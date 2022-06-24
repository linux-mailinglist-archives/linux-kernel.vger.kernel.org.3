Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA36F55933C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiFXGRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiFXGRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:17:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697BD4DF73;
        Thu, 23 Jun 2022 23:17:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 68so1489103pgb.10;
        Thu, 23 Jun 2022 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAEP2sHrXbKxadsvb5WCiqvBUjLw5ULpC36iLZbKyWs=;
        b=iaJaknUM0hJCXpPJYvH3NG5Ui5wciJRJ0GDlvnHmqVV0zFVWFSYK+nTCwsxp/x3/a/
         xbRO0BuEOb6DxmVLuF+zzeRQaZ4+fAitrM5h28BGodVNQcYQ7HXYkG4VFtHbUAVVLcmx
         cM85hw6e5Zz1Tz5nwLddv6dpXy7eFhnEAB9ni4foYguA7fXYCf0crI4JSpH5pDD3wlxa
         0tuWstIoAiAQGvItaaj1EGlx+bZUPWU7BoQoydJWEGCj+kQMvGyKICrm4sv3Pn8Qtv8f
         4cA4/rUR0DBxwo573gMl7Xj9xcWDRCOrPM0d+6f6h++I00dT2ST6MKm+ZGZx65l+rES7
         jULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAEP2sHrXbKxadsvb5WCiqvBUjLw5ULpC36iLZbKyWs=;
        b=y2hK4ERB32UvwbF1fSHz5jV7C0m0/Hg5wwviblxfvjdTapEMQktljFmORbQRvAVhu/
         PqfHgFm+TScld/8ZUI5rfYQlif5VzflkmtpI/hNHNB4xDdpbMVNH8qwJ4fsIpBn8+LYR
         +aiwIUQY54GP66HKKzIXtNZhorUh+OjuS79BFq4OOXoXRTr8hHVsTuIXg9Us8ARL5DQj
         FxKVp/zCwo5FtG2fgoApYvu24eKgrT0BTe7fwEItNTr2ImefIInhPW8jvF1V0XzFi4+u
         gggxe+9lIuuGl/sdfoofUPrE8hm3RkqRNOuhh/r5uEbs9Vr8gqe5tkdEttVnICCQpEwX
         PAfg==
X-Gm-Message-State: AJIora/HyKUsO7eBkPlRHRm/R218E9ZWbYErGlSDnAdRK7wj71WxTKfH
        yMXgC8om8szSUYAaSwaFrcnzX8YDw2ExnT8C
X-Google-Smtp-Source: AGRyM1uWyPzm4IDTHTkoUxdeELC1ZIeujDPdaDM8o84JwXA3Kg6cJFxIIx8lJQWAtSDEgF8yXq3/0Q==
X-Received: by 2002:a63:ea09:0:b0:3fd:3c6a:47c2 with SMTP id c9-20020a63ea09000000b003fd3c6a47c2mr10439756pgi.242.1656051431887;
        Thu, 23 Jun 2022 23:17:11 -0700 (PDT)
Received: from ZEN.. ([128.1.48.244])
        by smtp.googlemail.com with ESMTPSA id n11-20020a170903404b00b0016a12571537sm850241pla.299.2022.06.23.23.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:17:11 -0700 (PDT)
From:   xhe <xw897002528@gmail.com>
Cc:     xw897002528@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
Date:   Fri, 24 Jun 2022 14:16:38 +0800
Message-Id: <20220624061639.36230-1-xw897002528@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VID/PID 0489:e0e2 for MediaTek MT7922 Bluetooth chip. Found and
tested with Asus UM5302TA.

From /sys/kernel/debug/usb/devices:

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0e2 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: xhe <xw897002528@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fb1a67189412..23ff919d7768 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -480,6 +480,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0e2), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.33.0

