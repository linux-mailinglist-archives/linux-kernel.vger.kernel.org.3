Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE14539BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349471AbiFADsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiFADsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:48:15 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C946C37BE8;
        Tue, 31 May 2022 20:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WKkdQ
        S+1ZHVrtSv0zqhTsXDF05VKjrO1we7u5Uw2McE=; b=UgGHdajXcZD6iPTBJve6T
        MTQQw1enx5X1pLBL0fTMPKI58s5Q2eGnOlefaRiAujQNXIaaIuTfzja3/tj76X/1
        mhZYr9WbpkvJYxB9RAxSLlhp5gjgNiGIJhZxZLVFTzYtR0b0vkb6s6UlyXlYnyBC
        xmNUF2mt6bbEdMatglW/3U=
Received: from localhost.localdomain (unknown [112.97.51.18])
        by smtp3 (Coremail) with SMTP id G9xpCgDndIZm4ZZiMiLEFw--.3860S2;
        Wed, 01 Jun 2022 11:47:53 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] USB: serial: option: add support for Cinterion MV31 with new baseline
Date:   Wed,  1 Jun 2022 11:47:40 +0800
Message-Id: <20220601034740.5438-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDndIZm4ZZiMiLEFw--.3860S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWrurW8JF4DZFyDGr48WFg_yoW5CF4DpF
        W5CrW3ZFyUXw43XFnrJFn3ur95Zw4DKayIk3ZrCanIvFWxArsFg3yUtrWxAF12gr1SgrsF
        vr4DKw47Ga98J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKNthhUUUUU=
X-Originating-IP: [112.97.51.18]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAw8TZGB0KyX57gAAs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for Cinterion device MV31 with Qualcomm
new baseline. Use different PIDs to separate it from
previous base line products.
All interfaces settings keep same as previous.

Below is test evidence:
T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1e2d ProdID=00b8 Rev=04.14
S:  Manufacturer=Cinterion
S:  Product=Cinterion PID 0x00B8 USB Mobile Broadband
S:  SerialNumber=90418e79
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1e2d ProdID=00b9 Rev=04.14
S:  Manufacturer=Cinterion
S:  Product=Cinterion PID 0x00B9 USB Mobile Broadband
S:  SerialNumber=90418e79
C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
I:  If#=0x1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

For PID 00b8, interface 3 is GNSS port which don't use serial driver.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index e60425bbf537..5e26e90db7d6 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -432,6 +432,8 @@ static void option_instat_callback(struct urb *urb);
 #define CINTERION_PRODUCT_CLS8			0x00b0
 #define CINTERION_PRODUCT_MV31_MBIM		0x00b3
 #define CINTERION_PRODUCT_MV31_RMNET		0x00b7
+#define CINTERION_PRODUCT_MV31_MBIM2		0x00b8
+#define CINTERION_PRODUCT_MV31_RMNET2		0x00b9
 #define CINTERION_PRODUCT_MV32_WA		0x00f1
 #define CINTERION_PRODUCT_MV32_WB		0x00f2
 
@@ -1979,6 +1981,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3)},
 	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_RMNET, 0xff),
 	  .driver_info = RSVD(0)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_MBIM2, 0xff),
+	  .driver_info = RSVD(3)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_RMNET2, 0xff),
+	  .driver_info = RSVD(0)},
 	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WA, 0xff),
 	  .driver_info = RSVD(3)},
 	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WB, 0xff),
-- 
2.25.1

