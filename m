Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCD05A675B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiH3P1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiH3P1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:27:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A938680F66
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:27:35 -0700 (PDT)
X-QQ-mid: bizesmtp67t1661873249trcnkl75
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 23:27:28 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: RFp2QSjOiS617OOkIrMC6/ouSX60WQmR4rEkq6fE1sbvxSlJ2Gh1Fu+wwRZYn
        QH7vjIwCW4G7ZKYDMLrNz2XrsUhJEO0lu3TNbunVuwR3bgIqh6pZb6BhxV57wCSKagwdtCJ
        uINDBs2WSOjk5SeCzAZSBSx9uPf/RfR/u+f9SVRxBz8ZgvkF7H1N63jZraorzbLuTJDI9N9
        O9PnQKBs5o5W2WEEzIs6JWw+ney5bVwGad3ts/iL8ggW3mHmiy3D+zsOHn6THXD07xrC885
        LuzordktPYAadOT/i0CCJ2XJ6Wx+4AV2ROCXvXomV3dR0LlMdadMpRX6mqlCGrOpa9YDPyW
        k8n/MksE2TYLxmmOD5AGFRL/04mclHj1AN03UNDQCs4ZTeE1hM=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] agp/via: fix repeated words in comments
Date:   Tue, 30 Aug 2022 23:27:22 +0800
Message-Id: <20220830152722.15298-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'as'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/char/agp/via-agp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index b2f484f527fb..2a4befd1c438 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -398,7 +398,7 @@ static struct agp_device_ids via_agp_device_ids[] =
 	 * by 3D driver which wasn't available for the VT3336 and VT3364
 	 * generation until now.  Unfortunately, by testing, VT3364 works
 	 * but VT3336 doesn't. - explanation from via, just leave this as
-	 * as a placeholder to avoid future patches adding it back in.
+	 * a placeholder to avoid future patches adding it back in.
 	 */
 #if 0
 	{
-- 
2.36.1

