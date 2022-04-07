Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D29F4F7844
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbiDGH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiDGH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:56:16 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F04D1E7458;
        Thu,  7 Apr 2022 00:54:16 -0700 (PDT)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1649317671;
        bh=Ut064C6RS4PDAbd5Ahi4RtYZYMmrVcZFHFSa7j3qPUA=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=KGnKHsfSaZlfeD0clS0a23EfpLOWbGj93tVYofXOWJh6M4J6TqOakCuFw/NElrEm5
         cRqMmku6SeuJR2WwiMLNfbTkGYkDbXTwt0yPmKDMdo+hX1ZlMRGNciz8TwYk9hMNEf
         wAoRHmyd0YUcw3IUuU4dGPmEFpgUesZtsREdNXVrTMqMwNKR34mi6fl9jLafpXaLGm
         KZTyA/Ri85S9KaKLTC6Ed66LlS0J9kQDxMw0dxnaYFSdrp34ETMnfgLw5uxqNCkuvW
         59vBE73e/DvQDSH+TROARFumDdssUNglY92eE/rIKA+M6cG+OYx1g4B1BEhQ4rJoRs
         wWhWUG7V0s4SQ==
To:     linux-usb@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org, oliver@neukum.org
Subject: [PATCH v1 2/2] net: usb: cdc_ether: Add Fibocom MA510 modem
Date:   Thu,  7 Apr 2022 09:47:45 +0200
Message-Id: <20220407074745.74195-2-sven@svenschwermer.de>
In-Reply-To: <20220407074745.74195-1-sven@svenschwermer.de>
References: <20220407074745.74195-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

+GTUSBMODE: 31
--------------
T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#= 99 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2cb7 ProdID=0106 Rev= 0.00
S:  Manufacturer=Fibocom MA510 Modem
S:  Product=Fibocom MA510 Modem
S:  SerialNumber=55e2695b
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 3 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
I:  If#= 4 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

+GTUSBMODE: 32
--------------
T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#=100 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2cb7 ProdID=010a Rev= 0.00
S:  Manufacturer=Fibocom MA510 Modem
S:  Product=Fibocom MA510 Modem
S:  SerialNumber=55e2695b
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 2 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 3 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---
 drivers/net/usb/cdc_ether.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index b09b5567aea2..c9367587698e 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -1005,6 +1005,18 @@ static const struct usb_device_id	products[] = {
 				      USB_CDC_SUBCLASS_ETHERNET,
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
+}, {
+	/* Fibocom MA510 (+GTUSBMODE=31) */
+	USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0106, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
+}, {
+	/* Fibocom MA510 (+GTUSBMODE=32) */
+	USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010a, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
 }, {
 	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			USB_CDC_PROTO_NONE),
-- 
2.35.1

