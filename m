Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FBA51DCB3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355739AbiEFQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443267AbiEFQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:03:39 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAD96D3AF
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:59:56 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwHr6bv2zMqSHG;
        Fri,  6 May 2022 17:59:52 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwHq1CRGzljsTN;
        Fri,  6 May 2022 17:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651852792;
        bh=wXt5V32MOkd3JJdPG9GwDCkPTH/BF8OWATmyHyUQ6Gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRc3SrWTV3AmR/r28718FJBdJMqWCLH3epIPUkeDPP5Fvsxo0yTfsoSPEIx8a41Y3
         eD6qhRb2ozK76zekD+h18j4KhJ0cqak1Vg21qn/w3LrH6g6XnjHr5Ez123dytbMtSe
         g6zCe59CnX4hyrlxED8pwmtjPGgn6C06qu7PKqFk=
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
Subject: [PATCH v2 5/5] clang-format: Fix space after for_each macros
Date:   Fri,  6 May 2022 18:01:06 +0200
Message-Id: <20220506160106.522341-6-mic@digikod.net>
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

Set SpaceBeforeParens to ControlStatementsExceptForEachMacros to not add
space between a for_each macro and the following parenthesis.  This
option is available since clang-format-11 [1] and is in line with the
checkpatch.pl rules [2].

I found that this patch has also been sent by Brian Norris some weeks
ago [3].

Link: https://clang.llvm.org/docs/ClangFormatStyleOptions.html [1]
Link: https://lore.kernel.org/r/8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net [2]
Link: https://lore.kernel.org/lkml/YmHuZjmP9MxkgJ0R@google.com/ [3]
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Co-developed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160106.522341-6-mic@digikod.net
---
 .clang-format | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.clang-format b/.clang-format
index 235f7bb8f84a..1e083df1a689 100644
--- a/.clang-format
+++ b/.clang-format
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# clang-format configuration file. Intended for clang-format >= 6.
+# clang-format configuration file. Intended for clang-format >= 11.
 #
 # For more information, see:
 #
@@ -667,7 +667,7 @@ SpaceAfterTemplateKeyword: true
 SpaceBeforeAssignmentOperators: true
 SpaceBeforeCtorInitializerColon: true
 SpaceBeforeInheritanceColon: true
-SpaceBeforeParens: ControlStatements
+SpaceBeforeParens: ControlStatementsExceptForEachMacros
 SpaceBeforeRangeBasedForLoopColon: true
 SpaceInEmptyParentheses: false
 SpacesBeforeTrailingComments: 1
-- 
2.35.1

