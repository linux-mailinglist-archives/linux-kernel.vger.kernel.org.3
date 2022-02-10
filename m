Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919B74B15CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbiBJTEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:04:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbiBJTEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A5100C;
        Thu, 10 Feb 2022 11:04:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w11so11301834wra.4;
        Thu, 10 Feb 2022 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nAA6pdXjhS4D3IAaxQTjb/m0O26X1sZm/YouSY/spQ4=;
        b=k4Ntv0iA4bcSn3GKu4B5DCKss5zKxFD9bXP0NXImDtZXvuHLj20oT09ZHOPNHRMdA2
         cSa3ByaYh4oL6PPus9JCLqCJAH+LJ3g8o4LzY7ktZsiVOBvgFcQIllvA3/bm/uR0KOTM
         9ZRiIygS8OhYuEeA9uLNhzHrMvVSR0nYdFz1TK5zpdaGyiEvnTZIb1ljCBuGzCUksmYt
         lmrzCF8s4+4VQbDDZEfJeCqG765alaTYqU8xIPF2Ps40G7Mv72M9R8bgMoRDd3SXvS0l
         p/Zqih51TrB2iY15bbf3iZygA+U6zJqin30OjhoqD1/NqDL0zV8Ppjkphc7gcX8AgpRa
         QfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nAA6pdXjhS4D3IAaxQTjb/m0O26X1sZm/YouSY/spQ4=;
        b=Zt0BLfLQaSSZ/bSVFNgl1MEsBR5LOY9sm+rJm+ei4pb+Qnfz1W3BVZZhxuDTbReaUV
         vHE6WiQd9e2LIlArMYsbBxRAVHvYaETEHpc7GiPIj+5oKyCWUyh92BR+vBDy5CHD4Gms
         FHkIniSdfVjl2VefpiQeOL4aafNXI13XW4obizf1D/imGGk5/i5BbQyUFFspTnJAYZGc
         bVLQlmnP2I0NDzgfOr2Z7i6bjn0UY//goA+v0U/VoHxRa+E6X3Ciyvz3wNtpydKM3BrT
         xX0U5yMW8OQfI+oYMgfHAL+uZbUiGen/mAmInBKwGqP6WzROsDrytATznc+hjQsHa97j
         fibg==
X-Gm-Message-State: AOAM530GKAMsHlDN+k4X5DRdP1ohgDtEcN18TD4k9bBUSg27pJ0RKM9V
        U3LeQK7st3frhGkjGtnQg3w=
X-Google-Smtp-Source: ABdhPJyNtQjpApuEhj3jDG1SUuj2eAEid6s6WwsVI73LthRdOf83jyNUs0TPALyr31cuO+1JlffOmw==
X-Received: by 2002:a5d:6143:: with SMTP id y3mr7567484wrt.556.1644519891963;
        Thu, 10 Feb 2022 11:04:51 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o10sm21794816wri.19.2022.02.10.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:04:51 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 2/7] HID: uclogic: Rename Huion HS64 PID to Huion Tablet 2
Date:   Thu, 10 Feb 2022 20:04:32 +0100
Message-Id: <20220210190437.50152-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210190437.50152-1-jose.exposito89@gmail.com>
References: <20220210190437.50152-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kondrashov <spbnick@gmail.com>

Since the 006d Huion PID is used by multiple tablets (at least HS64 and
HS610), rename its constant to a more general
"USB_DEVICE_ID_HUION_TABLET2".

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h            | 2 +-
 drivers/hid/hid-uclogic-core.c   | 2 +-
 drivers/hid/hid-uclogic-params.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 85975031389b..10780a076693 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -606,7 +606,7 @@
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
-#define USB_DEVICE_ID_HUION_HS64	0x006d
+#define USB_DEVICE_ID_HUION_TABLET2	0x006d
 
 #define USB_VENDOR_ID_IBM					0x04b3
 #define USB_DEVICE_ID_IBM_SCROLLPOINT_III			0x3100
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 823704bc02ef..850c660ec2ab 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -376,7 +376,7 @@ static const struct hid_device_id uclogic_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION,
 				USB_DEVICE_ID_HUION_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION,
-				USB_DEVICE_ID_HUION_HS64) },
+				USB_DEVICE_ID_HUION_TABLET2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TRUST,
 				USB_DEVICE_ID_TRUST_PANORA_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 30e0f69ed5af..98910d8dae92 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -993,7 +993,7 @@ int uclogic_params_init(struct uclogic_params *params,
 	case VID_PID(USB_VENDOR_ID_HUION,
 		     USB_DEVICE_ID_HUION_TABLET):
 	case VID_PID(USB_VENDOR_ID_HUION,
-		     USB_DEVICE_ID_HUION_HS64):
+		     USB_DEVICE_ID_HUION_TABLET2):
 	case VID_PID(USB_VENDOR_ID_UCLOGIC,
 		     USB_DEVICE_ID_HUION_TABLET):
 	case VID_PID(USB_VENDOR_ID_UCLOGIC,
-- 
2.25.1

