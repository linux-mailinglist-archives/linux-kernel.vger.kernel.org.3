Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750E851DCB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443292AbiEFQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348385AbiEFQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:03:35 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B36D4D9
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:59:51 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwHn3VZxzMq1PY;
        Fri,  6 May 2022 17:59:49 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwHn1QqRzlhRVT;
        Fri,  6 May 2022 17:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651852789;
        bh=5yiUmrh6mlYQh3DCfa434DsRAxQHhOjF2SlkOyGu7nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlLGK/j5Q05j0Zba83UJpnk9EeC64v9Hcgx5VPTsXhDL8JgYqxcuFGQgy+Rn8u54O
         dX8jlQAZpYz5PlnejXbT+Tftdw0lkWcQ/Ljn8d/nYgOJKWKsi5nx4CjD8b+V//F6Js
         AjVIqlagBiopynuqfBu7rWFUPsxiT0J9otE2CAog=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 2/5] clang-format: Update to clang-format >= 6
Date:   Fri,  6 May 2022 18:01:03 +0200
Message-Id: <20220506160106.522341-3-mic@digikod.net>
In-Reply-To: <20220506160106.522341-1-mic@digikod.net>
References: <20220506160106.522341-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get new interesting formating with clang-format greater or equal to 6
as stated in the removed comments.  Miguel Ojeda suggested to even move
the minimal clang-format version to 11, which is the minimum LLVM
supported at the moment [1].

Automatically updated with:
sed -i 's/^\(\s*\)#\(\S*\s\+\S*\) # Unknown to clang-format.*/\1\2/' .clang-format

Link: https://lore.kernel.org/r/CANiq72nLOfmEt-CZBmm2ouEB_x6Jm9ggDVFCVJxYxKw7O0LTzQ@mail.gmail.com [1]
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160106.522341-3-mic@digikod.net
---

Changes since v1:
* Update documentation header with clang-format >= 6.
---
 .clang-format | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/.clang-format b/.clang-format
index 70d4e7ec4cf9..3bc1bdf0f3a1 100644
--- a/.clang-format
+++ b/.clang-format
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# clang-format configuration file. Intended for clang-format >= 4.
+# clang-format configuration file. Intended for clang-format >= 6.
 #
 # For more information, see:
 #
@@ -13,7 +13,7 @@ AccessModifierOffset: -4
 AlignAfterOpenBracket: Align
 AlignConsecutiveAssignments: false
 AlignConsecutiveDeclarations: false
-#AlignEscapedNewlines: Left # Unknown to clang-format-4.0
+AlignEscapedNewlines: Left
 AlignOperands: true
 AlignTrailingComments: false
 AllowAllParametersOfDeclarationOnNextLine: false
@@ -37,24 +37,24 @@ BraceWrapping:
   AfterObjCDeclaration: false
   AfterStruct: false
   AfterUnion: false
-  #AfterExternBlock: false # Unknown to clang-format-5.0
+  AfterExternBlock: false
   BeforeCatch: false
   BeforeElse: false
   IndentBraces: false
-  #SplitEmptyFunction: true # Unknown to clang-format-4.0
-  #SplitEmptyRecord: true # Unknown to clang-format-4.0
-  #SplitEmptyNamespace: true # Unknown to clang-format-4.0
+  SplitEmptyFunction: true
+  SplitEmptyRecord: true
+  SplitEmptyNamespace: true
 BreakBeforeBinaryOperators: None
 BreakBeforeBraces: Custom
-#BreakBeforeInheritanceComma: false # Unknown to clang-format-4.0
+BreakBeforeInheritanceComma: false
 BreakBeforeTernaryOperators: false
 BreakConstructorInitializersBeforeComma: false
-#BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
+BreakConstructorInitializers: BeforeComma
 BreakAfterJavaFieldAnnotations: false
 BreakStringLiterals: false
 ColumnLimit: 80
 CommentPragmas: '^ IWYU pragma:'
-#CompactNamespaces: false # Unknown to clang-format-4.0
+CompactNamespaces: false
 ConstructorInitializerAllOnOneLineOrOnePerLine: false
 ConstructorInitializerIndentWidth: 8
 ContinuationIndentWidth: 8
@@ -62,7 +62,7 @@ Cpp11BracedListStyle: false
 DerivePointerAlignment: false
 DisableFormat: false
 ExperimentalAutoDetectBinPacking: false
-#FixNamespaceComments: false # Unknown to clang-format-4.0
+FixNamespaceComments: false
 
 # Taken from:
 #   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ tools/ \
@@ -627,13 +627,13 @@ ForEachMacros:
   - 'xbc_node_for_each_subkey'
   - 'zorro_for_each_dev'
 
-#IncludeBlocks: Preserve # Unknown to clang-format-5.0
+IncludeBlocks: Preserve
 IncludeCategories:
   - Regex: '.*'
     Priority: 1
 IncludeIsMainRegex: '(Test)?$'
 IndentCaseLabels: false
-#IndentPPDirectives: None # Unknown to clang-format-5.0
+IndentPPDirectives: None
 IndentWidth: 8
 IndentWrappedFunctionNames: false
 JavaScriptQuotes: Leave
@@ -643,13 +643,13 @@ MacroBlockBegin: ''
 MacroBlockEnd: ''
 MaxEmptyLinesToKeep: 1
 NamespaceIndentation: None
-#ObjCBinPackProtocolList: Auto # Unknown to clang-format-5.0
+ObjCBinPackProtocolList: Auto
 ObjCBlockIndentWidth: 8
 ObjCSpaceAfterProperty: true
 ObjCSpaceBeforeProtocolList: true
 
 # Taken from git's rules
-#PenaltyBreakAssignment: 10 # Unknown to clang-format-4.0
+PenaltyBreakAssignment: 10
 PenaltyBreakBeforeFirstCallParameter: 30
 PenaltyBreakComment: 10
 PenaltyBreakFirstLessLess: 0
@@ -660,14 +660,14 @@ PenaltyReturnTypeOnItsOwnLine: 60
 PointerAlignment: Right
 ReflowComments: false
 SortIncludes: false
-#SortUsingDeclarations: false # Unknown to clang-format-4.0
+SortUsingDeclarations: false
 SpaceAfterCStyleCast: false
 SpaceAfterTemplateKeyword: true
 SpaceBeforeAssignmentOperators: true
-#SpaceBeforeCtorInitializerColon: true # Unknown to clang-format-5.0
-#SpaceBeforeInheritanceColon: true # Unknown to clang-format-5.0
+SpaceBeforeCtorInitializerColon: true
+SpaceBeforeInheritanceColon: true
 SpaceBeforeParens: ControlStatements
-#SpaceBeforeRangeBasedForLoopColon: true # Unknown to clang-format-5.0
+SpaceBeforeRangeBasedForLoopColon: true
 SpaceInEmptyParentheses: false
 SpacesBeforeTrailingComments: 1
 SpacesInAngles: false
-- 
2.35.1

