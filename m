Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37847536D99
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbiE1PtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbiE1PtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:49:12 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7398AAD;
        Sat, 28 May 2022 08:49:10 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 24SFlthK010610;
        Sun, 29 May 2022 00:47:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 24SFlthK010610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653752876;
        bh=XlGpy9qwy3ZeFc0Ita9T6lAssxHHl1pbiPE9/3ec6+g=;
        h=From:To:Cc:Subject:Date:From;
        b=lSjByJBi6/u3JC+VVgofg4v99QmdwcIgasIOIeTxlHdJfCPwcvzeC3bSiMndo1rhn
         vCQWM9dhWGOP2QqMVmfDBeYHUJjtIOAHAGUwIzXm/NnBaxughYkrHTWLeoOVQT2Mu7
         DV63LZFFl9SsjCq9uYSz4UPsR9cUUfDY7MpJPsbBkstz7y6OYOGuO6oC66+k8iVje9
         a/wgjDs0zadzYVmEjMVA2/i0QjT8Kml3fovQLbsaPRss3sugbFJJshEfLTKjT89IuZ
         ZF7w12huhulX1zzZ116PpzeATYnQOdUxOWergGT9hI6r45swxobW31gneFwJU+pj9t
         RXuSLXMBLs7UA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 1/4] kbuild: remove redundant cleanups in scripts/link-vmlinux.sh
Date:   Sun, 29 May 2022 00:47:01 +0900
Message-Id: <20220528154704.2576290-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

These are cleaned by the top Makefile.

vmlinux.o and .vmlinux.d matches the '*.[aios]' and '.*.d' patterns
respectively.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/link-vmlinux.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a7f6196c7e41..844fc0125d72 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -309,8 +309,6 @@ cleanup()
 	rm -f System.map
 	rm -f vmlinux
 	rm -f vmlinux.map
-	rm -f vmlinux.o
-	rm -f .vmlinux.d
 	rm -f .vmlinux.objs
 	rm -f .vmlinux.export.c
 }
-- 
2.32.0

