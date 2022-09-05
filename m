Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DDF5AC87D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiIEBWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEBV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:21:58 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA76F28E02;
        Sun,  4 Sep 2022 18:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662340913;
        bh=p7tq8EFo2hJlkSavCDSglg7r5xGb0ADexWQox9zQCOw=;
        h=From:To:Cc:Subject:Date;
        b=uJrXjx63SiYFmPEfnsGcvZaTb6mJWEWCxy9js5kvhr5krTCoGs3HXQagP6XG1U6ZD
         vZdmxtu6Dy7Urzb8PGt7ca/aiMeIsX73nUdbcMwTqeRs8aFoCH+lsFx7eyVSSxnU2G
         L2wVrAqJ3eADGuDZMvZlEpnOGWXtfzHRh/yJ8esE=
Received: from localhost.localdomain ([112.31.70.25])
        by newxmesmtplogicsvrsza31.qq.com (NewEsmtp) with SMTP
        id 519A9474; Mon, 05 Sep 2022 09:20:25 +0800
X-QQ-mid: xmsmtpt1662340825t907jmgji
Message-ID: <tencent_3F0D3FA6C173619315358082BA45961FD008@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1j/a0KbPEA511fFlavcJNNlbfq0lc4rsXw6VSA5e4phzKnIX2SXm
         hGP1K4f162PBDeySpqKcoscrxT1UVoQdrfo8Uuh3ctOVdXZVZgcZw59PE2EBm5pODPScIc7RU6BZ
         uri6/h9Nc5YNSCC6PETPSWS6DKaVNR6iSfl1MFzZhEvzP1qGHNLB8AUApo2GUhdY0hTCbPvEyd/z
         0cKzLFL8mDdW83BBNd5eKVnBldukragscpnbu7jwKA3NMKZ/1QlwCOiNKwQpnhonLBWyM9KUC53p
         5GcppHGPD8KiQucr3LXxf3UrRbx5ZJYvdMO8kGRQUx2d4P9h6OORGFW2yWud4dkS+4Wy7Zh2v9IU
         CD73I9gG3zpxTiMq6mSroNRcP5bvdTcI5JjhZck9P7CnLwBq6s5HxF1Ifr42ndEeC1RK09D/lz8k
         7uI/9ornZFUJth6hKL0Rz0+pTa5NKNfKqc+lGOBhbAgYSOb9sVhms2N37mEPljUMvXP+PQY+8xhA
         RGA3V+zE6CkMIgcOVcPUZ9rFnqfZxPEdImVYNZ2pEk/hVmcoanW0/2I6Z9ifCn5zprQVrvkcz6ed
         1SH/oMtb+lXCVoCqhJRBwycBMtTQXcVhdigk300McPWFWzq4PU9zfoVtTf+xRIiCqY3jPty/4JQN
         ecm3PxU5DEsYdyiCaK5VvQ9HsOrS9qnU8qYW/QRbr7uvSR+X0hMtsLvAJFzxs8OAMrXYLydu1koP
         LHm4g7mQTkie2szMhISoIhgR6M1o9iu82P8MxJ9bTDEnEj8CZYMbePMNT8Bet9H3FcN4Phe14XYD
         kvBITf/T2lDdMJoP6aou3wVid8hO+plDQ5a+R/GE1YHks4ZILSzjI8R1CKCsIKzuo2cp7s/fsn9o
         p7VS/cuXpSXEUxQus+AtmVGz0vMM8JGCdW6/SvCTVV2c+SB29YxvPaqGWl936yTNf7RKD4Gn3pEJ
         Qyx2g60MwWUGGpbPVSCg==
From:   "jerry.meng" <jerry-meng@foxmail.com>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "jerry.meng" <jerry-meng@foxmail.com>
Subject: [PATCH] USB: serial: option: add Quectel RM520N
Date:   Mon,  5 Sep 2022 09:19:38 +0800
X-OQ-MSGID: <20220905011938.35620-1-jerry-meng@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add support for Quectel RM520N which is based on Qualcomm SDX62 chip.

0x0801: DIAG + NMEA + AT + MODEM + RMNET

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#= 10 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=0801 Rev= 5.04
S:  Manufacturer=Quectel
S:  Product=RM520N-GL
S:  SerialNumber=384af524
C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: jerry.meng <jerry-meng@foxmail.com>
---
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index a5e8374a8d71..e716395268fe 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -256,6 +256,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM060K			0x030b
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
+#define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
 #define QUECTEL_PRODUCT_EC200T			0x6026
 #define QUECTEL_PRODUCT_RM500K			0x7001
@@ -1159,6 +1160,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
 	  .driver_info = ZLP },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
-- 
2.25.1

