Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0045F563B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGAVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGAVEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:04:50 -0400
Received: from sonic315-55.consmr.mail.gq1.yahoo.com (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F55A465
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1656709488; bh=9Ab6xgNj5PtuiyxXfeQMXpkH7HijIo0PSP2H54i4vy8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=D1iQUQS38g4BOfgnfBme8TyDU2Zj+FumGOlqnnGZ12YK4ts2pUNwa3t3x8JfBKC/8jZFCqCLytNBCAqw3ARvjqp827WYacf96sPciiyPcqY4IkTmq3GZYMS61kv3WRH9eehUIJFTsil598u5kWhs7c1ddZm5Oj5IAohjxb5QSP/XRB9JIoJVKj3OuYZgIG5CkVvgHlPp9ZZBxrtcFczVFiD3w/pRLFJGw3TGhigOprX10/qVVRQP8NzqwbulMVcByq9OjWMZe48QgI52XBROE9uZ7xPAa4eCSNREYhqVMV9mt6VsAhFV+1k18BDQUQzQymcd8jHqhajwaZ1bNz5FvQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656709488; bh=EOi6gM3terRj944+hkG3raif54ag1ZICwMZFSQy2joB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MYUfNqjwxzARrZDH3z1tgOwK+XtXMQ2/tLEcKuNjh3tv8/LIqL1rYZm8P5X/B0RpVy9U/HWPzEp2vLbbzrRB8rrPV8RGU+JbrK7uCV99dNFH3/+l2vteooO2Ezra2Owh2o5yNNVo+cfkypk3C+wEjMksWVTTpq74VWK3chqkDmLwFZepieMoUZh8AKjtY0NVl/WhYsSe7f2KFHodGJBKJDAHrXUyoTn/XoJHcavsX2J7WL9tjzrQ91HcN7spvxDWyUCa7lZv4/5GVfsQ0lC3QAdg3/4DX+nyNwEqcQ9L/oMy87E04/euzvzTGnrUAEFmgYMCXnpGMjrWafIGMfAGNw==
X-YMail-OSG: W2EEy_wVM1nOr1HLCtu51Bey116UsM9pMw2Ap35HBst3DlnMiHPJ7pvtM41k71o
 .i9VO3p6V0crEjD5QxkXn7ku_l9J4rKAYZ400J0b72HN0E6rwhoXa4K8pjiK6nidm8s44b5Xar4w
 mHmZSMD4wSFLpOotBhpg6HrkQmZ6_WojsuBadUYqe5f22cVuzD5nk19OM4EAmvtLJoo3xhUDLFXS
 t77VIxDdzuL3RzhU.6bch6fYfOKn5Q9VKDp7oBKbnwFbQXGnlGTUhdQJVLihcCfsKyZ_l2jL84S3
 bj1cALVz0M2T04L3oc1Jefj2bemMCgFzQSqRSjH2kuyAwKWLs2s9UQ6cLanG.FKuNi.KHevPkb4P
 3aA98_Nzfbh_fgyOb6KTIQlwxsKlnqdG5QVKeobUXOCo4A3X.eIDMZmATwTlDYb4Iv.vqRpK.d32
 5QrijHwVtPmQ1KPMSdWrm5_XlpbrfMH_aZqebuhKrkZt6WWKlhNAtjgIElWR1oJoMTwSm86pzuY7
 mt0UUZM6pL5odcQ3eH1MAy_FZ1h7uV5yZ7HThvEm0ABWAVaYvqiwO4nfTcWHIPzbClPEM1WHfUUd
 pe3iY86eprM3ec2muG1UGau0.t.vW9cd06t0KDzu9PO7_dLOd9kJhDMU9gXkZqGq5t9kBN_pyQOA
 74tb2_9.yQMRnXbP.NSzZxAzQugeJV1V_Ae1rkpx5xX3rOODWnjrpSbsx.Cp3nvAe8Wzg9l3XLxj
 GuW2wlM2KcUBTBCH8h2.5KtwoWR1BZJHvpX1rPct9Fl4TOneJhA9U1XhAa4QQnZxjBxhWFUrOK7r
 LVv9laRTIcbItlF9rN17weuHLB06cQl_BRaw2bxlUtiDcqUPoZy0J2iq5lXt4c8BXC1f_o.ndbkt
 .z2h9DhuZNyDe3fEEZMUMZsPF62nJJXo2YgBanuG5mHrr8mX7pKYr4IiVNYlvs0LjaS1r7SCH.WT
 upY4xRwCFfxJkUr275kxdWImhDw3QHi7URHhQE7Dkdsas2mbfqStApGT0VTush2BHQAysTPBxKgV
 70gorGerHfb.jfomGF7angN4.mskFCzANfNI5KwAtMtxiYxB28m0SreCzLXATMHOgKhK934oynuW
 jn355VM8tXOmO4INeePrwPsQAEkBOJ_TmPbchz9u0M3nNnIRWUBW6.zUHMnERT0ujKOog0MXjEYg
 m4IT5WYLUZCthNawSUzQk__jOPmtQxgFbv1zJp8lmhHAXHcZzniBTf.jzouJWd1LFXR7ttKRWYSt
 l5_dqB0mr3qRWO37aRad3CvA0ccMJaXKziDH3WdDqZFjC070HjUx4AbxZBjZSBK3s9TZ7_GlUFhm
 XpyEyWKGdtEOL.yMxRPwEMEjA2Se6dJAcZDebrsec2WPcbePGZUX67RtIDNWlSo4HvZe6YglieXC
 KuMnGSjsXnQBOzXQ0OogtsS5Hwe087qa_9DBpLZJ.pC_iAnT3WatA7D6KIdBRxuhJZyRrfuSAbxF
 WiAg8ujlTwkTpSMIzwHjvjRj2C8Wb3eE8JQmGn3sGfOFxHLnRurgTQxUFQVKB9Qf5_VBBHAhTYeo
 Cjd.j4b0.aaBm7hKs7Fj8hcFLm5INA46Agz0RblM2u7JbLRuG.i.Khzp928EpALa8WPJ1tW0KosC
 YUZItR85x1ZnCGCsc6OqJNetzs5lEnEkf7cJ18ktanijLplFBu2ZuRVibKgLcr88Nb1zRMGo5cit
 tG6mYTMzDLX9n3WbLtYmOlDFUvqPSIL9R0hN9Qavbx15_1YSOlk7QWR7nLNbahGP41uPAvbXWYwn
 nKf1WXy8tnHNFq2sS5vUkqSpiC7jFg3Py6q281t5jME3h5xoZAzE1xsw5etboi2X841SLkkac2MU
 JobHYvjab28WUy8lOrfN_WKSTt7a.kb2Kkij2aGB7M376hq5n1Q4XTq1sWIQWhj.urhvW528VawJ
 ExIgF3hW.JgF58kzfaTzLldQvqKI8_FdQ5tnfZvgsSWisIXdQMy4w7UVBVat6GiMfNEe6DCIz1c3
 TC3WNziJO0Oxrgr4jarizxVxZv4JJN4aIciemMFSjm4f1PgKOhzgn2hxgYRG.pyIwgR2IuUlaPUQ
 1ul3wGO4yOLo54H9dVlcd7f2rxe1wb8UhxK18W.BqSskKDfDlfz7NfEjc2zwjX5xqRaOQcz9_Hzj
 ByNt23IfvolXS2QRWg.wsQxn_is4PcGC6fx2HKR.kvClAIOCpFCoPPYSi6ZjH3eHA8UfK_gyhbrX
 MLNjiiLavgTo5cYy00aNgTojuKIeZEqhinq4CtXk1VJJJy3bZRHWKb_ReYJEoOZc-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Fri, 1 Jul 2022 21:04:48 +0000
Received: by hermes--production-bf1-58957fb66f-dd4hs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa1946aa1fae24efe50afcfc6dcc1acb;
          Fri, 01 Jul 2022 21:04:42 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        llvm@lists.linux.dev
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] x86/Kconfig: Allow X86_X32_ABI with llvm-objcopy in some cases
Date:   Fri,  1 Jul 2022 17:04:37 -0400
Message-Id: <20220701210437.579322-1-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20220701210437.579322-1-alex_y_xu.ref@yahoo.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comment and commit message, there are issues compiling
with IBT and/or compressed debug sections. Therefore, the condition
should be restricted to when those are enabled.

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df6..e5af1088420e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2847,7 +2847,7 @@ config X86_X32_ABI
 	# compressed debug sections to x86_x32 properly:
 	# https://github.com/ClangBuiltLinux/linux/issues/514
 	# https://github.com/ClangBuiltLinux/linux/issues/1141
-	depends on $(success,$(OBJCOPY) --version | head -n1 | grep -qv llvm)
+	depends on !X86_KERNEL_IBT || !DEBUG_INFO_COMPRESSED || $(success,$(OBJCOPY) --version | head -n1 | grep -qv llvm)
 	help
 	  Include code to run binaries for the x32 native 32-bit ABI
 	  for 64-bit processors.  An x32 process gets access to the
-- 
2.36.1

