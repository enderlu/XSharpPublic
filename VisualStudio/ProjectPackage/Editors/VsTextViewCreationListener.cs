﻿//
// Copyright (c) XSharp B.V.  All Rights Reserved.
// Licensed under the Apache License, Version 2.0.
// See License.txt in the project root for license information.
//
using System;
using System.ComponentModel.Composition;
using System.Diagnostics;
using Microsoft.VisualStudio.OLE.Interop;
using Microsoft.VisualStudio.Text;
using Microsoft.VisualStudio.Text.Editor;
using Microsoft.VisualStudio.TextManager.Interop;
using Microsoft.VisualStudio.Utilities;
using Microsoft.VisualStudio;
using Microsoft.VisualStudio.Package;
using System.Runtime.InteropServices;
using Microsoft.VisualStudio.Editor;
using Microsoft.VisualStudio.Language.Intellisense;

namespace XSharp.Project
{
    // This code is used to determine if a file is opened inside a Vulcan project
    // or another project.
    // When the language service is set to our language service then we get the ProjectItem through DTE.
    // When the project item type is defined inside an assembly that has 'vulcan' in its
    // name then we assume it is a vulcan filenode, and then we will set the language service
    // to that from vulcan.
    // You must make sure that the projectpackage is also added as a MEF component to the vsixmanifest
    // otherwise the Export will not work.

    [Export(typeof(IVsTextViewCreationListener))]
    [ContentType("code")]
    [TextViewRole(PredefinedTextViewRoles.Editable)]

    internal class VsTextViewCreationListener : IVsTextViewCreationListener
    {
        [Import]
        IVsEditorAdaptersFactoryService AdaptersFactory = null;

        [Import]
        ICompletionBroker CompletionBroker = null;

        public void VsTextViewCreated(IVsTextView textViewAdapter)
        {
            IVsTextLines textlines;
            textViewAdapter.GetBuffer(out textlines);
            if (textlines != null)
            {
                Guid langId ;
                textlines.GetLanguageServiceID(out langId);
                if (langId == GuidStrings.guidLanguageService)          // is our language service active ?
                {
                    string fileName = FilePathUtilities.GetFilePath(textlines);
                    if (EditorHelpers.IsVulcanFileNode(fileName))       // is this a file node from Vulcan ?
                    {
                        Guid guidVulcanLanguageService = GuidStrings.guidVulcanLanguageService;
                        textlines.SetLanguageServiceID(guidVulcanLanguageService);
                    }
                }
            }
            //
            IWpfTextView view = AdaptersFactory.GetWpfTextView(textViewAdapter);
            Debug.Assert(view != null);

            CommandFilter filter = new CommandFilter(view, CompletionBroker);

            IOleCommandTarget next;
            textViewAdapter.AddCommandFilter(filter, out next);
            filter.Next = next;
        }
    }
    internal static class EditorHelpers
    {
        internal static bool IsVulcanFileNode(string fileName)
        {
            object itemNode = GetItemNode(fileName);
            if (itemNode != null)
            {
                Type type = itemNode.GetType();
                var asm = type.Assembly.GetName().Name;
                return asm.IndexOf("vulcan", StringComparison.OrdinalIgnoreCase) == 0;
            }
            return false;
        }
        private static object GetItemNode(string filename)
        {
            EnvDTE80.DTE2 dte = Microsoft.VisualStudio.Shell.Package.GetGlobalService(typeof(EnvDTE.DTE)) as EnvDTE80.DTE2;
            var projectitem = dte.Solution.FindProjectItem(filename);
            return projectitem;
        }
    }


}
