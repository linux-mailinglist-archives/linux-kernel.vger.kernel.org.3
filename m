Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFAC55A85E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiFYJEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiFYJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:04:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791B231374;
        Sat, 25 Jun 2022 02:04:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 184so4490306pga.12;
        Sat, 25 Jun 2022 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxyMneeFLZ1Him14wA/vaqAtLh6smrx5mXTdl7jbmeM=;
        b=eRu2Ta4mZyZ7borRVGbN1C1efQXR+klT/iliBLQtfzujyuP5iIl8xotq8DV1BMZq0Q
         B38m7L/JutSdFDHhM0DKpFiBoYebjt13Ikcwl2aWjOeau/wTXVrjjDGe3exTJxqwwesY
         WLyh9MDasoEDd+jm6MOFsYNoz/vYArosduWEVW7KjtLliagDRoVMRRII3Pen5ZpnolPk
         pdsW4ACN9f8PrVK5nJU6GR5pM165kVo5KOZgrS8RTQohmVCpPq6KX59bHcWo4352BNtJ
         HmpRL9TdC3sVXS20e977a9dDwh0EEO+5RLgGwsq5px3wPN80XOJ5JAU8NhDkRoP0NU3b
         YLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxyMneeFLZ1Him14wA/vaqAtLh6smrx5mXTdl7jbmeM=;
        b=UNNw/pKhKVoRs3Ieuq+d7ceOxuNNHbeCoBFK7xx9H8BBP+ByFeNS4bNw/az9caAsi6
         rKbZg55nG+qUMlPntrspGmNL2ceW7BfL2k0D1u6KRneM8CDMiFWGby8VzWbDmjs2epoI
         lUt7y9Ea9C10THP5BSdxXYEI8jpOrzt8gBWb8NvqCk1V3/V/dDQB/89a92lYipGk4m1J
         yO6f1CgdLpFRihLoINQPIE6IQQU2hn8Y9TzJBZfEFeKQ73myfMgpD5eTpKh03ABZKira
         n9kckFFbR4jJ1LjJeBvFr96nPrN2EyatDJoNdCVQyLnbLf2PnD3BgM90Ung4XkVxPB2W
         ibdw==
X-Gm-Message-State: AJIora8Nn4hhgh/LVrkFCdK+GiV0CDRFw9m9TXDzb8CUpOflRs6w3joh
        QBiqmZ0NJxBTptp23wr2PC5QzJCCSd47bw==
X-Google-Smtp-Source: AGRyM1uAw3KjZ1St9BZsASG20Q7hiSOWE/GnoUyPQgT5ZJyzutxL4AHeYm+O2bpMjAxP50ac2mNNnQ==
X-Received: by 2002:a63:ff0c:0:b0:3fd:29dd:c478 with SMTP id k12-20020a63ff0c000000b003fd29ddc478mr2849728pgi.291.1656147844935;
        Sat, 25 Jun 2022 02:04:04 -0700 (PDT)
Received: from ZEN.. ([23.225.169.79])
        by smtp.googlemail.com with ESMTPSA id t13-20020a17090340cd00b00166496ba268sm3130433pld.285.2022.06.25.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 02:04:04 -0700 (PDT)
From:   xhe <xw897002528@gmail.com>
Cc:     xw897002528@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
Date:   Sat, 25 Jun 2022 17:03:57 +0800
Message-Id: <20220625090358.9373-1-xw897002528@gmail.com>
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

From: He Wang <xw897002528@gmail.com>

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

