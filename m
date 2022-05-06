Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E351DCB2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443284AbiEFQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348539AbiEFQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:03:35 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62A6D845
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:59:51 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwHp14YjzMq1Pq;
        Fri,  6 May 2022 17:59:50 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwHn67n9zlhRVR;
        Fri,  6 May 2022 17:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651852790;
        bh=ZKdObc4dUw8b1ppw9KF6MlLviIGEalnvEuIINAYEM+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eA96egW46rPu6iKJNmfwWCOXFRzp+ZVSbJ0AMdxdU5kSEzBL9zS+zxnjwu7B/RZcJ
         doSlHACIFWkWTM4fL5RGJMrpgw9mfE5aF2Z+QrJjDE5FYn7m1M7GJV9CbM+fuMyShE
         sBMgM4qWA+Obbr1ij98sMJMxnhvb4o6GpAHQJGmE=
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
Subject: [PATCH v2 3/5] clang-format: Fix goto labels indentation
Date:   Fri,  6 May 2022 18:01:04 +0200
Message-Id: <20220506160106.522341-4-mic@digikod.net>
In-Reply-To: <20220506160106.522341-1-mic@digikod.net>
References: <20220506160106.522341-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to IndentGotoLabels introduced with clang-format-10 [1], we can
avoid goto labels identation.  This follows the current coding style and
it is then in line with the checkpatch.pl rules [2].

Link: https://clang.llvm.org/docs/ClangFormatStyleOptions.html [1]
Link: https://lore.kernel.org/r/8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net [2]
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160106.522341-4-mic@digikod.net
---
 .clang-format | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.clang-format b/.clang-format
index 3bc1bdf0f3a1..30f68219c09e 100644
--- a/.clang-format
+++ b/.clang-format
@@ -633,6 +633,7 @@ IncludeCategories:
     Priority: 1
 IncludeIsMainRegex: '(Test)?$'
 IndentCaseLabels: false
+IndentGotoLabels: false
 IndentPPDirectives: None
 IndentWidth: 8
 IndentWrappedFunctionNames: false
-- 
2.35.1

