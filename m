Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D365471C33
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhLLSVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhLLSVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:21:09 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9285C061751;
        Sun, 12 Dec 2021 10:21:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d24so23681806wra.0;
        Sun, 12 Dec 2021 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NX6glLrIhrFAeV+2sLrwAejToH2nkjjgEtF8KiG6Dgc=;
        b=DW2/UiVaUlSbuzR+l2ag6jTSbeJaDVqab+lSd/dJev63JJM/UwY1cF8OXw/0QS/Mmo
         Hj82YYUE4HEhH6agr8gJmpSVyjs2fuXsjpBKGtvkigPZ4/PINUu276UKPMqdEClldUnu
         zmwbXtoRMnmFiYKjtp7hAUw2IbzGjPpI5e7S4XsdOEq7PSFf9jgnTvU0nETOXhlw6anW
         xzYdnk5OfL3c9ewkVmDAgon3dLRSP6dDX0F+l6E7vsSFBMuLLDrbuV7OqladmVs2vB1c
         yBVDibJ28I1r7xk3/kYTywrVwkdLmcCl2i3hA1fhvJDXzO/Qm9SMWJ99G68FuBl4bLfK
         Zxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NX6glLrIhrFAeV+2sLrwAejToH2nkjjgEtF8KiG6Dgc=;
        b=jCjXxyv8St065SUoFQ5JhpxGXiJlndyksImq3Ggq7cKgfSM8yJ/vRcqwp44HChkrV2
         LLalf1fArE7DqWvLBJzWg1X6LUSq/HoXBuqOKllpIcJg8gvGAiRS/xVtlsiDDb+7C7uI
         DfucwACiOjtanYGUXCSJt0SyprQBEu6iH+RpOuS+QOB4CjVVpqxw4XOSsiEZdLkAjabh
         VZ7Ax2ERQMhvkRi5Lrqnm0a46hHqwSbjo1BHt28MY9fS9vZEG3hz/QnVPSMVuOdp1G2a
         /KK2akZJRNv/DRijt8NLPPXRDCyELPGMiXHNG14RlD+tbRt+4oOevxpHZ4LDfRVP/oR+
         4Lfw==
X-Gm-Message-State: AOAM532FDUDllhucumcm2w9DT20isa441C1INshbzFNW8wqaYVElvUI4
        LcpDJri75ItziYzCWPSnHU0=
X-Google-Smtp-Source: ABdhPJzFn2ywU0qLuijjPAVSuNhbOAN7Z7ClbfVlW0+gIRMqB2Xv0GSNx1A5QDfhLyqgXs2iHVo/jg==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr26559316wrt.233.1639333267341;
        Sun, 12 Dec 2021 10:21:07 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id r62sm4667421wmr.35.2021.12.12.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:21:06 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 2/2] HID: magicmouse: set Magic Trackpad 2021 name
Date:   Sun, 12 Dec 2021 19:21:00 +0100
Message-Id: <20211212182100.40968-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212182100.40968-1-jose.exposito89@gmail.com>
References: <20211212182100.40968-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apple Magic Trackpad 2021 (3rd generation) has the same product ID
as the 2nd generation. However, when connected through Bluetooth, the
version has changed from 0x107 to 0x110.

The other meaningful change is that the name has dropped the generation
number and now it is just "Apple Inc. Magic Trackpad", like the first
generation model.

Set the device name correctly to ensure the same driver settings are
loaded, whether connected via Bluetooth or USB.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-magicmouse.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index e650ade15a7f..2ccded36dafd 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -51,6 +51,8 @@ static bool report_undeciphered;
 module_param(report_undeciphered, bool, 0644);
 MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state field using a MSC_RAW event");
 
+#define TRACKPAD2_2021_BT_VERSION 0x110
+
 #define TRACKPAD_REPORT_ID 0x28
 #define TRACKPAD2_USB_REPORT_ID 0x02
 #define TRACKPAD2_BT_REPORT_ID 0x31
@@ -546,10 +548,14 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		 * Set the device name to ensure the same driver settings get
 		 * loaded, whether connected through bluetooth or USB.
 		 */
-		if (hdev->vendor == BT_VENDOR_ID_APPLE)
-			input->name = "Apple Inc. Magic Trackpad 2";
-		else /* USB_VENDOR_ID_APPLE */
+		if (hdev->vendor == BT_VENDOR_ID_APPLE) {
+			if (input->id.version == TRACKPAD2_2021_BT_VERSION)
+				input->name = "Apple Inc. Magic Trackpad";
+			else
+				input->name = "Apple Inc. Magic Trackpad 2";
+		} else { /* USB_VENDOR_ID_APPLE */
 			input->name = hdev->name;
+		}
 
 		__clear_bit(EV_MSC, input->evbit);
 		__clear_bit(BTN_0, input->keybit);
-- 
2.25.1

