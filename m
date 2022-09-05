Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A795ACB28
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiIEGgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiIEGgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:36:19 -0400
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065D23B;
        Sun,  4 Sep 2022 23:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662359759;
        bh=V8ZDTeX4onpSjv5CcGuGKq/H8OzsvnzZfzF+5C+J3c4=;
        h=From:To:Cc:Subject:Date;
        b=Uj+VmQSY+twYXPmb1laM50lwYrrzvkp8KbQgn+k/NtjQBcrGWBnXAWDrh7ETuxOBq
         +cz8OSApY+QorVMK2Bo4sDRZ4xjDcqJxUg9TokjOpFyMqJFDp+jPnAv8eDzejd+Efl
         hOrXk4dN4zGifcRsSUt+B4r15oQBRp5WYU3Nd6EU=
Received: from quectel.localdomain ([220.180.239.55])
        by newxmesmtplogicsvrszc14.qq.com (NewEsmtp) with SMTP
        id 8E3B9AFC; Mon, 05 Sep 2022 14:35:35 +0800
X-QQ-mid: xmsmtpt1662359735tam44x0hn
Message-ID: <tencent_23054B863154DC02C6E98E5942416BFC200A@qq.com>
X-QQ-XMAILINFO: M/oQ2p0eBD4uHP2+x9T9Hfu7FWrsPUFjS4xTkhnQcxCrP4eh8GTKo6sE37tDEc
         UXvfv1V3cX8A5SSthQpfZwvwqvd4Fgqs6GNO3TCpeAOFtcmwauWua4PXEV/IdgvyUQpSOwGUnp7I
         T+26ohr7fZlU7ZCvekvrJGHU5zC+gvBaN5JMRKT1t/J8YOKecD7FW5yGi5MMwpLZ896k+y4uWXO9
         kal2fep485clIZ31lEXohRITr1S4igxdDAs6ddr8JISMh5IziOIrJH0IwXJ89VN+3GUTcSnTIDxC
         4O98zQIho/daStwbCU+w/AJGcajGcnkFjcCc72YflIoUkXC5YIDzV+leQyZIpYLcuIO9msBRNZnB
         vrjW55pxC3Q0NbSoBZKkP7kPUQHLGld3Rkhf/LVcX2snOMC/GbJJuZSYE6eXv9r5TYkIKqCbLp2t
         yS2hH6NLXnV86NC9tv1XknPjUhJgF6LTvFRdK/ZfpfQTLnGeqCcq8wPzAUu6tLkHN/Op9ff7HHty
         Y56zQXurDU3m4ZOWq8+LOCqeSK683VLwFLdW/f5JTYDXq05WqXXNm4/FOBKKXK4cNpJ7bKNh0fac
         jpcQTEGba8WSAYa+h8WzdohfAC3cYdmRewKxJxcYyvUHbTozI015mkpb4dlwTOy/q9ia4dXOvLly
         wwjKq9FZWf+E+K8cHrOTH98eVzjR3tSO6CpfWccDHNBiCzvS0S80w7Sq2hhrjMRQxrw/kloFD18X
         HX8Tw3eD2TjrLct84mREX/OzH8v1mS5yqvJ26ucbyqSSujQ9L4dhsjIYnUNQUE0qumUQ+kzF4YQ+
         rj1O+YB0pxLLY4I1zXSKxNgIVnB6XpyOzwRfgdwS8K2YGDQA2NU7PCSnjQztiftjm7d3RAhrYTtE
         kJ4+PHu2Qn1Vl2FC0+WFMeIQqDzq3a4C1lhkhJkY8bxDTK8JLgtETQCLDXXZPETlMpVXMM1an3Ti
         SHSmRu1yagfUwlwq0K31OtuF3opQjKahVC7LjMih3ATDV2zQfCZA==
From:   jerry meng <jerry-meng@foxmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jerry meng <jerry-meng@foxmail.com>
Subject: [PATCH] USB: serial: option: add Quectel RM520N
Date:   Mon,  5 Sep 2022 14:35:33 +0800
X-OQ-MSGID: <20220905063533.53616-1-jerry-meng@foxmail.com>
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

Signed-off-by: jerry meng <jerry-meng@foxmail.com>
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

