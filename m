Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6335A6CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiH3TKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiH3TKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:10:32 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2CE255BD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:10:30 -0700 (PDT)
Received: from grover.sesame (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27UJ8ZDL014149;
        Wed, 31 Aug 2022 04:08:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27UJ8ZDL014149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661886515;
        bh=ExOgCI7V96Z6R/+llvRQlPICGHveN6sllg9dVu+33hs=;
        h=From:To:Cc:Subject:Date:From;
        b=gNytFIHmggiLo7UX9tYTYrdZQfCWlmO4rbJcLJNMoNMBqNB7rVBhTVi/u5v/L7sGc
         fY/492KvOKhW4ymFQOdjLHHxVkhnqFF25y5509bbfwfQ2YqrEfOIFyYXbVquKMQu87
         2fsFQcuWRWLc05nlEvlYSDRaqBayshOigmT+KrmQiFZ+sl4NemwiSFv4Cb7SCLUv7f
         QPEiK9ZFaIrvQWz4ndP4ONfS7Ij2skGHE4tV8NnniFdPwvwzVOFoAkgfjfC4Ne9ToW
         t6/19X89y9BgcyIts30ekgHNbq4DiQdPiXMxW21sfFRNx4DEAscMTNQHW5NoibSJET
         z3GIv9kuDs9wA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] Documentation: raise minimum supported version of binutils to 2.25.1
Date:   Wed, 31 Aug 2022 04:08:10 +0900
Message-Id: <20220830190811.323760-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binutils 2.23 was released in 2012. Almost 10 years old.

We already require GCC 5.1, which was released in 2015.

Bump the binutils version to 2.25.1, which was also released in 2015.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/process/changes.rst | 4 ++--
 scripts/min-tool-version.sh       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 19c286c23786..5fb6a60677ef 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -33,7 +33,7 @@ GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
 GNU make               3.81             make --version
 bash                   4.2              bash --version
-binutils               2.23             ld -v
+binutils               2.25.1           ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
 pahole                 1.16             pahole --version
@@ -94,7 +94,7 @@ Bash 4.2 or newer is needed.
 Binutils
 --------
 
-Binutils 2.23 or newer is needed to build the kernel.
+Binutils 2.25.1 or newer is needed to build the kernel.
 
 pkg-config
 ----------
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 250925aab101..8b1edd1f7281 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -14,7 +14,7 @@ fi
 
 case "$1" in
 binutils)
-	echo 2.23.0
+	echo 2.25.1
 	;;
 gcc)
 	echo 5.1.0
-- 
2.34.1

