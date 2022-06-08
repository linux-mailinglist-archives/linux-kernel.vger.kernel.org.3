Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35E543109
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiFHNJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiFHNJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:09:11 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9C26E91F;
        Wed,  8 Jun 2022 06:09:00 -0700 (PDT)
X-QQ-mid: bizesmtp73t1654693736t7p6bnci
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 08 Jun 2022 21:08:50 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: +ZT4F8HYZJ6G9tB95OH1uDRs6oMrrb5LD4fLM++MBuWC9dntfg6GjlGt4yVdc
        OiXn4C9LmM67H6bkOZwO09EMSPUp/kccpVWrm7FsS0t1MrDyOQviSmYPgtnqkgBRJ8zTOLv
        5VECFjBr4GRCqTbyNBg/z34Qsg33NYic8C3/sdcURDGNqBxh+QyOupxHBGujie6Y+jde2Mi
        ySTgUwdqygr+0cH5T4ChTRZms6d7QS+WgE5GtIX+OIHUd7N1Qx9j4gDdU5Qs1pv9vZk+N0M
        pirab/pyoLghvrst6TyuxifpaiDvf5OjNFtBPVTVdJrPdhyZZ1peeFRfcjVPyl7JzRkycC+
        GaOzcrN1Rcm4FmMYEpweYsLLC3npw==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     ulf.hansson@linaro.org
Cc:     linux@armlinux.org.uk, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] mmc: mmci: Fix typo in comment
Date:   Wed,  8 Jun 2022 21:08:47 +0800
Message-Id: <20220608130847.46359-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'is'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 01159eaf8694..012aa85489d8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -762,7 +762,7 @@ int mmci_dmae_setup(struct mmci_host *host)
 
 	/*
 	 * If only an RX channel is specified, the driver will
-	 * attempt to use it bidirectionally, however if it is
+	 * attempt to use it bidirectionally, however if it
 	 * is specified but cannot be located, DMA will be disabled.
 	 */
 	if (dmae->rx_channel && !dmae->tx_channel)
-- 
2.36.1

