Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E5465E51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbhLBGmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:42:14 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:55571 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345329AbhLBGl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638427117; x=1669963117;
  h=from:to:cc:subject:date:message-id;
  bh=3g+eUVzpsgrN7jH+hXE6d4OUhX4I1HGrua57aZsyv40=;
  b=AiinRTEwOGXL4q3gWfmI+K3LdpojXP1YjijcEI7WlsmgRnzSLWdsvO8u
   HwfrB/N8KF9bbqeZK9p5JH6BP5WVPZ+rJtBLJR6tMHHmcVrqO4+xNWwhk
   zChEpoMzQpQrU2fdhIqx4Vj1owi31nNNBvjG0gFm1BmHGtUgDpwaOZYK6
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Dec 2021 22:38:35 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Dec 2021 22:38:34 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 02 Dec 2021 12:08:16 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 8FBEF48F7; Thu,  2 Dec 2021 12:08:15 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V2] mtd: spi-nor: winbond: Add support for winbond chip
Date:   Thu,  2 Dec 2021 12:08:12 +0530
Message-Id: <1638427092-9139-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond W25Q512NW-IM chip.

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
Changes since V1:
	Added space before name of the flash part as suggested by Doug.
---
 drivers/mtd/spi-nor/winbond.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 96573f6..44f19f2 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -100,6 +100,9 @@ static const struct flash_info winbond_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
+	{ "w25q512nw", INFO(0xef8020, 0, 64 * 1024, 1024,
+			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

