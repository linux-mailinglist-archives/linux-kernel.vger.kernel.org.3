Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8653451C9A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383807AbiEETyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385550AbiEETyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:54:03 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA25BF68
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:50:16 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nmhUL-00D2Yj-VY; Thu, 05 May 2022 19:50:14 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] Bluetooth: btbcm: Add entry for BCM4373A0 UART Bluetooth
Date:   Thu,  5 May 2022 12:50:10 -0700
Message-Id: <20220505195010.31329-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device ID for the BCM4373A0 module, found e.g. in
the Infineon (Cypress) CYW4373E chip. The required firmware file is
named 'BCM4373A0.hcd'.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d9ceca7a7935..ced0ad25ffc4 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -457,6 +457,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
+	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
 	{ }
 };
 
-- 
2.17.1

