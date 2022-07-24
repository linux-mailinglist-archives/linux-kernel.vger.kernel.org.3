Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6847357F665
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiGXS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiGXS01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:26:27 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38310557;
        Sun, 24 Jul 2022 11:26:26 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10d845dcf92so12180192fac.12;
        Sun, 24 Jul 2022 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DM/R9yX4is3BPPJw3zDaUfeCw8Cx4pI3OKbOnVDlwts=;
        b=BiBXPfXyKhzenr8F/qPCACHhjj/SZtE6dXYzI228H7pn/llrP8Z1JNeUYUq30Ljrs1
         ekjuprt2/aY8IYYil/a8jnHxSQuJmwUoj3SuLhOp8N81MyuDuw+hVMbWFUhZd9jOY7BQ
         8pYLLIQ1Re7PMBdIgAfZHbZa2A8NBsHGSPyl4NDM8stO6TrKKDyRT4bpdO6srDu1iLEs
         lJbB6/UctREGnhc8Cc69KhnRyflh0KfeSfNRwFogDwq3bb2KikalIbqnyinrmWxv9+Bw
         ht5ztXQ9vFd1Gxbaftk2HQx6L0bWUFSL3wjEtdzZxxBBYFC64rGszv4dG+M4IrCEknmv
         TOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DM/R9yX4is3BPPJw3zDaUfeCw8Cx4pI3OKbOnVDlwts=;
        b=6VQ7sqDBxhfCKGEzDqoevhH1cXf82zL+5330jdCRbDDEQfUjhIWmQl+atK19muLT/Y
         +KgKHwB3aoPmCHwnE73iC+NUl8kV9GznxsEHcDydOz7NEq/Cn4N+eLdfVSJZTza+lIiI
         UuCc26HXHktwrBFSJSwQPVGhgwYBruhXY9UxFlyu4m4yADh23cIcYp8as2vKQgMOkf15
         CGdFizn9bjphhzLCtqzw1N/ppcZjcqnusLQwAZe+qjy4qaVRwmhpT0N4ies5PviZ31er
         pp8pXPzhmcuASLlW9i2rVtg6Prclei/fgFEJDcxO2I54CAklC+EmZR8TOk5dzjP0GTfd
         JjJQ==
X-Gm-Message-State: AJIora8PrLbSV1QrkIubvvHvDUL1jExlt6F8qOrpBTSEIShCd77AMIHa
        wkoY9AAAJjZI8WHBKIhEZsvvyyLoO1i6dw==
X-Google-Smtp-Source: AGRyM1ugRYgGQDd1ACR7/1j8CIdHPh1IYyva+yyHCxOts+Hcn9RaVqqQ/lpSf194/C5xt5Orp8RsHg==
X-Received: by 2002:a05:6871:54b:b0:10d:80e6:eada with SMTP id t11-20020a056871054b00b0010d80e6eadamr4732911oal.102.1658687185443;
        Sun, 24 Jul 2022 11:26:25 -0700 (PDT)
Received: from localhost ([2600:1700:7130:4fa0::c])
        by smtp.gmail.com with ESMTPSA id y31-20020a056870b49f00b0010be134ac60sm4865492oap.19.2022.07.24.11.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 11:26:24 -0700 (PDT)
From:   Fae <faenkhauser@gmail.com>
To:     faenkhauser@gmail.com
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org
Subject: [PATCH] Bluetooth: Add VID/PID 0489/e0e0 for MediaTek MT7921
Date:   Sun, 24 Jul 2022 13:25:02 -0500
Message-Id: <20220724182501.5351-1-faenkhauser@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722020100.11221-1-faenkhauser@gmail.com>
References: <20220722020100.11221-1-faenkhauser@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on HP Envy ey0xxx

output from /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0e0 Rev= 1.00
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

Signed-off-by: Fae <faenkhauser@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e25fcd49db70..973d122c738f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -454,6 +454,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0c8), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0e0), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
-- 
2.37.1

