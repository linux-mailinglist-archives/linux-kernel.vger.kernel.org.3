Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33CD5542C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357110AbiFVGLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356662AbiFVGLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:11:03 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B411F2E5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:10:58 -0700 (PDT)
X-QQ-mid: bizesmtp71t1655878245tfybuqf9
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 14:10:27 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: mIVznwO+07KFdQ97HnLJOfaqt0yS2IkN2hCITnfNJWjamiN5FTFRx87sZ5VNl
        mgyWbNsn9WoEBqGJV4S3wWglXmrJ8mEjfS0BCHw6Qdvwz1u3T8JYONLo8C/GXIyDMyvRx9v
        hgMvAVYL9fFeFXdMQpXRJeDsMgUazQqjxNimLGUqk3YDHdR8LQk2M4hB+XBoBVUU7eX3whz
        cBhhAl5bqqEpZlnpwoJYOB1nGPbtqoUppuwfeusBg2pb0F5vKEIQsRrL32v3HGlv5Flh5sJ
        rl9ivSegb7P0fEiVwAWkz0vHwMKdUYQxLzbsrg22AvN7TNy+Ydrdu09cc=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     funaho@jurai.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] m68k:mac:Fix syntax errors in comments
Date:   Wed, 22 Jun 2022 14:10:18 +0800
Message-Id: <20220622061018.37575-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/m68k/mac/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 4fab34791758..29a4cb46af01 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -126,7 +126,7 @@ static void via_rtc_send(__u8 data)
 
 	reg = via1[vBufB] & ~(VIA1B_vRTCClk | VIA1B_vRTCData);
 
-	/* The bits of the byte go in in MSB order */
+	/* The bits of the byte go in MSB order */
 
 	for (i = 0 ; i < 8 ; i++) {
 		bit = data & 0x80? 1 : 0;
-- 
2.36.1

