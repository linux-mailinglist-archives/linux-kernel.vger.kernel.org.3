Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CFD55A7F1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 10:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiFYIAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 04:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiFYIAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 04:00:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A54640A11;
        Sat, 25 Jun 2022 01:00:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w24so4720554pjg.5;
        Sat, 25 Jun 2022 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDWMJLL7b7hzJh8tds1bD8xBhXjv7hAzXFZafEyqTtY=;
        b=Ycp4G604pbCfOxrLUxAxT1vjBm3cpZnW0nl+pR1bzU0NHOscfe7tpVRhSsu5jjHThZ
         AIdE77P32o3JYo0ENsz9faJTT7DRXgn9mk+Tag+cqpcUWXVz0e/p4q6YdXee7J/pDrTd
         8XIATfWRHdbNqCFGplFk29hnymizhTE2M9yKLW0mK0ikoYe2/4OzL8sXyttvTAvmYfVb
         wWXoT0op0rl6zptNAOPhgznaPCUULsPj2v9os7hn34rAQZjELZ9WOY6+F2hRrKtQaToc
         bNRsgOQhyuJ5F30Egb583Ov8QC+47ZIA3VkVXoq2iDsIR+ndK2jLH4s2WOMq2J56vnKM
         CFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDWMJLL7b7hzJh8tds1bD8xBhXjv7hAzXFZafEyqTtY=;
        b=nLi74DXX8b6WtbKYNKixoqqQqRWpXh7x+X5JBoVBSWFOjCma/QZjWPCY+YDdnb1sip
         gOA2Rmm4iPc2S1KKoxZFWr7V3sblP0ulPy4u9d8ry9voXvmcz+u3zB2ale4nSGTGnQmg
         oxVm/oIeLBm9PidjfvT1UKQ86NYzNQbtzo9ewPX8eMD2nNRype7nHcfo9lY8JiuB8tRM
         DV9OBDvr8QukZbn6n0vXmUuiN8rsfose32mNRJW3I2+Vxkls1LJOgZdFNM/hu4QnhnBD
         EsYF7KoWGhtcx2D5GI619byFkO80nxf/nOcjRHMDuzfyjKbjjRaji8FExVSzjVi08kKD
         40Ww==
X-Gm-Message-State: AJIora8Z61vN8x2fBzV3lyt0KFz8WunA56SnSpqbXRX5HrU8R076KN9J
        IVtJrwuaCgmX91iLM5S1sWV+yvPprmlFhboC
X-Google-Smtp-Source: AGRyM1ussrHM2mCJLvFwHuyIiXYjXD9pt2aFNG01Hq845ui6eHFtrqYCgpGaoi/Qu6v06DBUe34gHw==
X-Received: by 2002:a17:90a:c981:b0:1e6:75f0:d4f1 with SMTP id w1-20020a17090ac98100b001e675f0d4f1mr3340993pjt.62.1656144012593;
        Sat, 25 Jun 2022 01:00:12 -0700 (PDT)
Received: from ZEN.. ([23.225.169.79])
        by smtp.googlemail.com with ESMTPSA id n8-20020a17090a394800b001e85f38bc79sm5223100pjf.41.2022.06.25.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 01:00:12 -0700 (PDT)
From:   xhe <xw897002528@gmail.com>
Cc:     xw897002528@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
Date:   Sat, 25 Jun 2022 16:00:03 +0800
Message-Id: <20220625080003.7104-1-xw897002528@gmail.com>
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

Signed-off-by: He Wang <xw897002528@gmail.com>
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

