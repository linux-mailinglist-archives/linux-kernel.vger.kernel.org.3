Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7762948BA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbiAKWMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345948AbiAKWMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:12:16 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF1C061748;
        Tue, 11 Jan 2022 14:12:16 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s30so1538889lfo.7;
        Tue, 11 Jan 2022 14:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tfx1WUFnevfKDPJ6flTJKUckxRcAPYOxlOVGm+YrEN4=;
        b=hbXTjjxuVzjhu9TnoPHQ+ZrJfABV3baYlKeZgdLZKyBQ9C5SBtCXvNsC4TSu7BPjdR
         MDRisfgd5AFaZDc2DSl+LbgQnWkpnTcYbpXoY+i/iX32BFcPwAZWUVCEB5AqsNAN6t38
         Z1EkeLt3sMQVtmdgYMGaiYRwWTKcyVxMdj/abGBqasnvS2qAfBz3Ur0qR7a8Ebu2EKQP
         27tYPA0O1kUZsYNSb56oK3pqrNmztUXBr+mLqh9EVL6mC/0yW9MBiwpr34rR2hkXd1SL
         2dWwRXn80RpxDLXdCjQV6DAUQZqmIDd2MvnZ7f1ozZ/yropwZQo0eMOXzWt5yoOmGbzR
         h7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tfx1WUFnevfKDPJ6flTJKUckxRcAPYOxlOVGm+YrEN4=;
        b=GHH2kGleiydjzchpl059KYlVGTlY77EfRPugKehL5YTtfFdYZsBa1rMnCmabGJMaWq
         /Na7p3HdLBmzC2f+D2ezC1qgGygpsKvJiFIvzX6aLQLWzGwCvol803vs9+9IOuBQwi+D
         uQLSxU4WGdOP2Rx3ZWW+V2fHw6Rd0FuIsr1s8VKywZcEzoOR9PzEID3z/NI/qZwzhjyK
         AjkVr5HGWFdpsgsMmxgCSZjjzLc0vn5tHX35KS/dSkaQIm+8B1rdQQiqUhxRSvStve1q
         UxhqDFNmvv0Lrg3KT4zgZRbkPDNeTigKfFa1TJOtx3qPKwaw9j83zjQTU0JrHOUV8czF
         ZSLw==
X-Gm-Message-State: AOAM532FlurOJMSUg5jZFFG6OpWD7Vlj97NWAqMmylUh6u2KkqU9bkrT
        5NVTk3R3zSG/z5uBkvuQo6e/+Jaqw4k=
X-Google-Smtp-Source: ABdhPJx9V1KKizTvicTEjlQbVuDAFGaVdJoi8XukjBhI4EvenZ/89vaEsnNLAfkOiRoH4jRZ+46E4g==
X-Received: by 2002:a2e:a30f:: with SMTP id l15mr4157157lje.493.1641939134557;
        Tue, 11 Jan 2022 14:12:14 -0800 (PST)
Received: from WBEC678.wbe.local (xt27d8.stansat.pl. [83.243.39.216])
        by smtp.gmail.com with ESMTPSA id c16sm1462125lfv.29.2022.01.11.14.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:12:14 -0800 (PST)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: option: add ZTE MF286D modem
Date:   Tue, 11 Jan 2022 23:12:05 +0100
Message-Id: <20220111221205.14662-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modem from ZTE MF286D is an Qualcomm MDM9250 based 3G/4G modem.

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
D:  Ver= 3.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=19d2 ProdID=1485 Rev=52.87
S:  Manufacturer=ZTE,Incorporated
S:  Product=ZTE Technologies MSM
S:  SerialNumber=MF286DZTED000000
C:* #Ifs= 7 Cfg#= 1 Atr=80 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=ff Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 42420bfc983c..962e9943fc20 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1649,6 +1649,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(ZTE_VENDOR_ID, 0x1476, 0xff) },	/* GosunCn ZTE WeLink ME3630 (ECM/NCM mode) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1481, 0xff, 0x00, 0x00) }, /* ZTE MF871A */
+	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1485, 0xff, 0xff, 0xff),  /* ZTE MF286D */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1533, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1534, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1535, 0xff, 0xff, 0xff) },
-- 
2.25.1

