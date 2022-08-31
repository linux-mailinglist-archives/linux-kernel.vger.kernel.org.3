Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2355A7312
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiHaA6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaA6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:58:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A44A9C0E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:57:59 -0700 (PDT)
X-QQ-mid: bizesmtp86t1661907467t62nxb90
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 08:57:46 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: 83ShfzFP0oDIRreUK6adz5wTVdQyShTxZeHC2bUg8eBmCdTH4bjfHfU4c2RKf
        +pEy1ajNp1slJSLECzdbqH7duG6VnAR5XwjKwGNCTEl1qPo3/919OIiO1ONRDgKfghwpFTg
        j6yvumPy9phSjo4D8FBrUqauSdZt6PIjmggQ/8V8kjaaU9Tlg6oHu7HoXVDjQQcihyxP9J3
        b4IBbubYws+q38CwLpAaiuIjvcMtQbT3HPwfDJ2eLl7cVtohXm7JNCJ5QDUNXR4901o3c6R
        uGd0WXqvLESFdtvo+xteTJmnkSPD8lYEOrr4U3SaDDL7pOOvEpcd7GowwGQ6hSctzY/Gw41
        ezJDagp//oX2wgIrN1l8TmyFXxHblaEuN/7UzSvuKojtKAWpok=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     nsekhar@ti.com, brgl@bgdev.pl, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ARM: davinci: fix repeated words in comments
Date:   Wed, 31 Aug 2022 08:57:39 +0800
Message-Id: <20220831005739.42648-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index d8c6c360818b..cca709236ade 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -528,7 +528,7 @@ static struct vpbe_enc_mode_info dm365evm_enc_preset_timing[] = {
 
 /*
  * The outputs available from VPBE + ecnoders. Keep the
- * the order same as that of encoders. First those from venc followed by that
+ * order same as that of encoders. First those from venc followed by that
  * from encoders. Index in the output refers to index on a particular
  * encoder.Driver uses this index to pass it to encoder when it supports more
  * than one output. Application uses index of the array to set an output.
-- 
2.36.1

