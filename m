Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2301453CA69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244512AbiFCNHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244507AbiFCNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:07:27 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862A1261A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:07:16 -0700 (PDT)
X-QQ-mid: bizesmtp81t1654261628tqoqx0j2
Received: from localhost.localdomain ( [117.176.187.31])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Jun 2022 21:07:03 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: +2TysDGdvCxihwzKCOZuvGidjv24sITKq1mlDIYROOkH2qCkkw8JkgiHqlY32
        ItQimqRUCIXdbCX+h47GmuvRmsi86Cuc3uE9dwII63L6SbEr+NLDyIgHJxZXWvIWaxPZkkQ
        fHQ3vlRciGC90Ot6Tq8ycABJAkizsQH6BqyzYOpu4lOEuDmjvGxISZLMEOwC8j5x+doGwm/
        hxHJjeR3gsSHf4uOXKyxFofNQPV502AYtEiTF/xOHfgQK2q5w+ZhKL3qFopjA1Q1eSXW3Wf
        2OTVbNnY0hx1iuoXWV3eTCmPu8jkg7jHCtfJja6YQtE+yE8e068+tvs6LSU0rOv8JwZiQBa
        agz3DZqpupgOzod4PsMVcpqZkGR2w==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] staging: rtl8192u: Fix syntax errors in comments
Date:   Fri,  3 Jun 2022 21:07:02 +0800
Message-Id: <20220603130702.6926-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'tx'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 725bf5ca9e34..916618ddc4b7 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -3002,7 +3002,7 @@ static void dm_check_txrateandretrycount(struct net_device *dev)
 	/* for initial tx rate */
 	/*priv->stats.last_packet_rate = read_nic_byte(dev, INITIAL_TX_RATE_REG);*/
 	read_nic_byte(dev, INITIAL_TX_RATE_REG, &ieee->softmac_stats.last_packet_rate);
-	/* for tx tx retry count */
+	/* for tx retry count */
 	/*priv->stats.txretrycount = read_nic_dword(dev, TX_RETRY_COUNT_REG);*/
 	read_nic_dword(dev, TX_RETRY_COUNT_REG, &ieee->softmac_stats.txretrycount);
 }
-- 
2.36.1


