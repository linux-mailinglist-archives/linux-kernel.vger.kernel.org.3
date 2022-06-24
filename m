Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D07559212
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiFXF1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 01:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiFXF1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 01:27:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8769253;
        Thu, 23 Jun 2022 22:27:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a15so1578167pfv.13;
        Thu, 23 Jun 2022 22:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3TwuMMQSBkayMQhluJ+QW7nWYifyPvIiKPEtPbPsRI=;
        b=YH8vKhqizQKX6BboGPvvkO1DW1jNxCnNm4y8Q7Z5KwlxsjsY4StaROJiTqtL0X7UZx
         sgPJDTeU0qH0qjX8TFuRzDXJSa5vCnptx/c5iCFy7rkOnCSHdQZZ5pjTkIUgjbk+8+Ag
         7DeF2RQFyf5hGCHQ0j47mpfqP7rV0X5Pq9pMcme1Igj1q26MWsZMgJrKhkoUAQjMLNdH
         LlPWB2KJv3+RKLQMrr3dS9SJ+phjTpP3XPD3i/VX4A6CSLi+nymN2VMLYGMDCO6960wu
         lSfcVrGm5ItX296+KqfC5KcyOWnjTX82IZj4AcJdu5c3DmA5xLNs8588SesmhVLUoaDn
         bGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3TwuMMQSBkayMQhluJ+QW7nWYifyPvIiKPEtPbPsRI=;
        b=43jm6RezXh+peHZ7xi/fHIyjxoQxDR8z084b/AqTXYYXvJbAD1h6tzlAgHr1mSCwBO
         9SA/DI1nJaprZPv7agVK3fuvfI8jaWjgk8b86oO3NOVrRSPw5SDr4GZhsEDqZEzl0jVB
         2pFMfshBkZf50QHnUDOWjdIB6bozpXnElUAPOLf4XgDGpryAUzbr9FA1XVh22xh3eO0P
         FdfFhEGe7BOt5s8/dKKOUbLNLQ0s+h1P2gu4v/UpFl057dMBqjDlN6E2JElAVyD2IgB5
         lvgltjJ1ibIj6qUpfjUsaqZj0rNxhcZUOj78ACgBCGy3KCw5PuaVNuOusJBsqIPPFfwP
         SiGA==
X-Gm-Message-State: AJIora9xXGBQN8B6jFdKm5GkowO6onOC5h6lSxaTjilqiD5AeezwaQWM
        476CqHIHjURVPsuS2iqyInCWCwJQuKIQHMHe
X-Google-Smtp-Source: AGRyM1scpl9H1K7ZjmMhr4UyDg3vdF8/oNa4/g9/JWPe7LYmQLggxcHN7KvcLEYtlXR+m/82YOEgDA==
X-Received: by 2002:a63:4081:0:b0:405:4f9:e802 with SMTP id n123-20020a634081000000b0040504f9e802mr10469693pga.211.1656048467922;
        Thu, 23 Jun 2022 22:27:47 -0700 (PDT)
Received: from ZEN.. ([128.1.48.244])
        by smtp.googlemail.com with ESMTPSA id b5-20020a170902d40500b0016a13bd845csm762639ple.165.2022.06.23.22.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 22:27:47 -0700 (PDT)
From:   xhe <xw897002528@gmail.com>
Cc:     xw897002528@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
Date:   Fri, 24 Jun 2022 13:27:03 +0800
Message-Id: <20220624052703.32067-1-xw897002528@gmail.com>
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

Add VID/PID 0489:e0e2for MediaTek MT7922 Bluetooth chip. Found and
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
index e25fcd49db70..534a396b50ec 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -477,6 +477,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d9), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0e2), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.33.0

