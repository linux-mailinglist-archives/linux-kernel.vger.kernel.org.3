Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15157D83A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiGVCBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVCBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:01:09 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD613C165;
        Thu, 21 Jul 2022 19:01:06 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id i126so4316191oih.4;
        Thu, 21 Jul 2022 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dL9ncBfc4HB03ByKwbOAy+t26qBqrPAYGisg0HDIwBE=;
        b=cqhPpBRtcM1eiNCUd89Pl1MDa54ELyiqv+PDX7SM1JcnXMnYMpKAuhs+vGHV9lqu+S
         oeFiP8HzbEk9wiJaBYDLawf9ps2gVwjx57HARwHQXD3VHVJn9vpKAB9MbrGKSxJezv8g
         JXhkjibYvX6+x/RnDGYRE4YSGrbEzhwtwnzBLGD3KgAT9DFBBvTpv3flol3aeSuq/nPV
         3qJM4R2kWDJlUIX+BtlST2xUVR5gODaeJSg91UeKu+KldPaHZqhJd5LKkI8tZeGKwBe/
         Oo4pbCm8fBEwj1oBPkDer1njzs44W7ZCRlC/6GzTNU3jFVkQB00V+r0IrZEwrmeZuGCm
         4Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dL9ncBfc4HB03ByKwbOAy+t26qBqrPAYGisg0HDIwBE=;
        b=oRoNj8GeUhdwSRnTINxhjkXxjCkqXD9da6lombuYf4aNYCAialUeF1ZhAY/9E3VIaM
         tL8/ZijIqzpY5UYwFsPjxy+wQoZCyz8kWJaKkFktg8aeKQkyd89KwH5AfNe3WiR5U3hu
         Vg0lD2Wg/fS+WwkYzO8rS5qAO9yPs88nup3FuRHAbbo/U9SsNjY5lHyDDoBIyDq/zKqu
         oWS9NWnVqbFHf3YR/bf80fOqreqjkvCdkQ2BYybNMSl3jOOvurBfFvGwckckMYrPrVAI
         L38KtDRfjS90zLSVbDBB4jZ/tg6Bj6JsiTQxek4DdX7SFiXkyC5EKLmHr41ScH8R91wb
         cC/w==
X-Gm-Message-State: AJIora9paF/9FIpUFxPWiyBDcxkzRGRRmZ/FRroxcWm33+Ye+i9mfyED
        xucys4pfW5FVoUtiL4wfKr8=
X-Google-Smtp-Source: AGRyM1vmY7ZsLOK5nv+PDjh12V4j6kiiY+2tRMZ7WmNfNIbpMFc3aG98acF3J6VFNsyNlKdALKWSMQ==
X-Received: by 2002:a05:6808:198b:b0:33a:636f:76d5 with SMTP id bj11-20020a056808198b00b0033a636f76d5mr487336oib.14.1658455265887;
        Thu, 21 Jul 2022 19:01:05 -0700 (PDT)
Received: from localhost ([2600:1700:7130:4fa0::e])
        by smtp.gmail.com with ESMTPSA id p23-20020a9d76d7000000b0061c71f2a6b9sm1455199otl.36.2022.07.21.19.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:01:05 -0700 (PDT)
From:   Fae <faenkhauser@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fae <faenkhauser@gmail.com>
Subject: [PATCH] Bluetooth: Add VID/PID 0489/e0e0 for MediaTek MT7921
Date:   Thu, 21 Jul 2022 21:01:00 -0500
Message-Id: <20220722020100.11221-1-faenkhauser@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720011002.5221-1-faenkhauser@gmail.com>
References: <20220720011002.5221-1-faenkhauser@gmail.com>
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

Found on HP's website ( https://support.hp.com/us-en/drivers/selfservice/swdetails/hp-envy-x360-15.6-inch-2-in-1-laptop-pc-15-ey0000/2101086013/swItemId/ob-288116-1 )
Tested on my laptop (an ey0xxx)

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
2.36.1

