Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93C547403A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhLNKRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:17:03 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:23768 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhLNKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639477016; x=1671013016;
  h=from:to:cc:subject:date:message-id;
  bh=okFUusOHzj8BtPwDsu4IVgGs5T42rJjBSOStK76pAaQ=;
  b=Pzj7gTd46VIfmdJFP7IaOPRjM/C/D1h7Xdz6CabpM1NIrt6qOBSOhhba
   NekK1+FsBzLMqYBfb2sMipn3vP1vVduy3hJjguLwv8CU1AZ02JXUzMN7B
   MdotLJ+qf4Hxkfb1VZGnHqRHBYm7GPHuMztdR2u0Wy/vB+s4JJOsXKNSz
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Dec 2021 02:16:56 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Dec 2021 02:16:54 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 14 Dec 2021 15:46:36 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id E5B3A52F4; Tue, 14 Dec 2021 15:46:34 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     dianders@chromium.org, tudor.ambarus@microchip.com,
        michael@walle.cc, p.yadav@ti.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V3] mtd: spi-nor: winbond: Add support for winbond chip
Date:   Tue, 14 Dec 2021 15:46:31 +0530
Message-Id: <1639476991-25676-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond W25Q512NW-IM chip.

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
Changes since V1:
	Added space before name of the flash part as suggested by Doug.

Changes since V2:
	Updated chip name as w25q512nwm as suggested by Doug.
---
 drivers/mtd/spi-nor/winbond.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 96573f6..42d5800 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -100,6 +100,9 @@ static const struct flash_info winbond_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
+	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024,
+			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

