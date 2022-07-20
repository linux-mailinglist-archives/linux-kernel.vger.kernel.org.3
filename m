Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD7057B4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbiGTKyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiGTKx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:53:56 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294D6EE8E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:53:49 -0700 (PDT)
X-QQ-mid: bizesmtp82t1658314418t29mchop
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 20 Jul 2022 18:53:11 +0800 (CST)
X-QQ-SSF: 0100000000600030C000D00A0000020
X-QQ-FEAT: G46xFj+wOV+plBYdJM0XyKJ+zUmgVa0RMlHFFCKUmShAIv06VYow9acLpSNba
        xfjiaDAOzPmOcrvB00DDxRRdzhWIjN46NkU49xk2k4Cu0ov1s3oURAEfZgrBLwzwwS21CbN
        jYsn5f3ov+zDKtMPSDik3wnM7RxNItM24B+B7I685Ccj4sIkUJuZAl6UBKgfs51urmeenHm
        N6vFRu8sRZYfAfLCyEcg+7xjgknDTlRJ454Ty32wjutny1LU9NyxLOPM1CZRAB5XPl51h5A
        NNUj0/VmtyerfUSh+kLWSxJmGeYtru+WtLIPilPatg3Z7HrvpDTXAhdNOOp+cY2jHCJUpPF
        lBZMChZSHcbHl7+Vb9Zgsm3bCcJBZ5TARRXC6Xi0sEGl1LNF5JLoNEdiggPtaAzm9VW8omF
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     funaho@jurai.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] m68k/mac: Fixed duplicate "in" in comments.
Date:   Wed, 20 Jul 2022 18:53:09 +0800
Message-Id: <20220720105309.3090-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed duplicate "in" in comments.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
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
2.30.2

