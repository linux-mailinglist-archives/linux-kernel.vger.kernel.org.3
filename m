Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1FB56D09E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiGJRv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:51:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E06510572;
        Sun, 10 Jul 2022 10:51:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so1540661wmj.0;
        Sun, 10 Jul 2022 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMwhz1M1zPryVflcNS8Rn/GSnUJtV+dvUFo/LQneMlo=;
        b=VCW7LMXjn25fPbiF/cktMPqfNx5/pc5qk6icjJjUBDXteuPJFhTFdIQG7uVwe0LDKM
         ohse6jjeRhxVZOYdySZowtdJn3UUSvtBCMa/u0T3LwsMGlb5IXtXcx0TNv9X1o3FMA/g
         IeiXoYeGQC2LOO8RiVYJSy/zs1Yzm46gsJIEwBwrsoWTK7pbpR+OwoIAtK37RQ3mI8Cs
         IUzYRWf3kGVKH4x84R7fBPPQneVMCq4ltyBk8HxieNZcrRkfoSsN2FBQsCjrnqhqFWpu
         WSMMJ+Ge9hSu+GLEeg446NGu1bxzkKQ79Hl34gc0MnMk4lX4iEoDmZVz3plxhYOw9iLx
         xUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMwhz1M1zPryVflcNS8Rn/GSnUJtV+dvUFo/LQneMlo=;
        b=m8z8hZZUKJFKITeNC89WMaQMFQlMNxpCGTiP5dZPUHvxMuQC5U4z1jNrDVL3jnK7nX
         i1S5V5kchM2RradWl9nbjdlUI++lC1vK64h//wrj/BOx6+lmXHISYVTsC3ZI9UEpLwWi
         s+4cgjuEihw/YUfa72jgg1gzCg4d91YhSg2uVnuw0MZvbJwDyDQHV/1CkyzLj5udGc+U
         WBd7GanoirVrCq7kgWIeSh/HEgG0AAS+3kbLJGji7N1QQ1UXqbUVNaB/Kq8UVf6aUVE1
         5S3nC30NL7j0R/P+axTOPH8csMJrtLvssVPm2Fv+dhPZ22r849pxB/bGDfgRi/1LT3y5
         4NpA==
X-Gm-Message-State: AJIora8s2xuloNwoHN9wGnvg/wJm+ekGNyKy5LEs9OD+/IEP8wdAVnDe
        g3+Hk4uFVoPPTD+RuTS1NcWsFBmF4R/gHw==
X-Google-Smtp-Source: AGRyM1vJc18tLHf7+UHfPbyx5zktq8jWUkNHBQ6g+cPNSKECPogHDZKsi9lCyidZcOLHBE0dbJP2ww==
X-Received: by 2002:a05:600c:460a:b0:3a2:e09e:cc5f with SMTP id m10-20020a05600c460a00b003a2e09ecc5fmr9873836wmo.186.1657475471854;
        Sun, 10 Jul 2022 10:51:11 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id l23-20020a1ced17000000b003a03ae64f57sm4523495wmh.8.2022.07.10.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 10:51:11 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 5/7] HID: uclogic: Add support for UGEE v2 dial frames
Date:   Sun, 10 Jul 2022 19:50:41 +0200
Message-Id: <20220710175043.192901-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710175043.192901-1-jose.exposito89@gmail.com>
References: <20220710175043.192901-1-jose.exposito89@gmail.com>
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

Add the required HID descriptors and the initialization function for
UGEE v2 frames with a bitmap dial.

Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 44 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 40 +++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |  4 +++
 3 files changed, 88 insertions(+)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index b232125f6972..8ac7caeda535 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1149,6 +1149,45 @@ static int uclogic_params_ugee_v2_init_frame_buttons(struct uclogic_params *p,
 	return 0;
 }
 
+/**
+ * uclogic_params_ugee_v2_init_frame_dial() - initialize a UGEE v2 frame with a
+ * bitmap dial.
+ * @p:			Parameters to fill in, cannot be NULL.
+ * @desc_params:	Device description params list.
+ * @desc_params_size:	Size of the description params list.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_ugee_v2_init_frame_dial(struct uclogic_params *p,
+						  const s32 *desc_params,
+						  size_t desc_params_size)
+{
+	__u8 *rdesc_frame = NULL;
+	int rc = 0;
+
+	if (!p || desc_params_size != UCLOGIC_RDESC_PH_ID_NUM)
+		return -EINVAL;
+
+	rdesc_frame = uclogic_rdesc_template_apply(
+				uclogic_rdesc_ugee_v2_frame_dial_template_arr,
+				uclogic_rdesc_ugee_v2_frame_dial_template_size,
+				desc_params, UCLOGIC_RDESC_PH_ID_NUM);
+	if (!rdesc_frame)
+		return -ENOMEM;
+
+	rc = uclogic_params_frame_init_with_desc(&p->frame_list[0],
+						 rdesc_frame,
+						 uclogic_rdesc_ugee_v2_frame_dial_template_size,
+						 UCLOGIC_RDESC_V1_FRAME_ID);
+	kfree(rdesc_frame);
+	if (rc)
+		return rc;
+
+	p->frame_list[0].bitmap_dial_byte = 7;
+	return 0;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1248,6 +1287,11 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 
 	/* Initialize the frame interface */
 	switch (frame_type) {
+	case UCLOGIC_PARAMS_FRAME_DIAL:
+	case UCLOGIC_PARAMS_FRAME_MOUSE:
+		rc = uclogic_params_ugee_v2_init_frame_dial(&p, desc_params,
+							    ARRAY_SIZE(desc_params));
+		break;
 	case UCLOGIC_PARAMS_FRAME_BUTTONS:
 	default:
 		rc = uclogic_params_ugee_v2_init_frame_buttons(&p, desc_params,
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 3d68e8b0784d..22429df693fc 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -961,6 +961,46 @@ const __u8 uclogic_rdesc_ugee_v2_frame_btn_template_arr[] = {
 const size_t uclogic_rdesc_ugee_v2_frame_btn_template_size =
 			sizeof(uclogic_rdesc_ugee_v2_frame_btn_template_arr);
 
+/* Fixed report descriptor template for UGEE v2 frame reports (dial) */
+const __u8 uclogic_rdesc_ugee_v2_frame_dial_template_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),                   */
+	0x09, 0x07,         /*  Usage (Keypad),                         */
+	0xA1, 0x01,         /*  Collection (Application),               */
+	0x85, UCLOGIC_RDESC_V1_FRAME_ID,
+			    /*      Report ID,                          */
+	0x05, 0x0D,         /*      Usage Page (Digitizer),             */
+	0x09, 0x39,         /*      Usage (Tablet Function Keys),       */
+	0xA0,               /*      Collection (Physical),              */
+	0x75, 0x01,         /*          Report Size (1),                */
+	0x95, 0x08,         /*          Report Count (8),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x05, 0x09,         /*          Usage Page (Button),            */
+	0x19, 0x01,         /*          Usage Minimum (01h),            */
+	UCLOGIC_RDESC_FRAME_PH_BTN,
+			    /*          Usage Maximum (PLACEHOLDER),    */
+	0x95, 0x0A,         /*          Report Count (10),              */
+	0x14,               /*          Logical Minimum (0),            */
+	0x25, 0x01,         /*          Logical Maximum (1),            */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x95, 0x06,         /*          Report Count (6),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x75, 0x08,         /*          Report Size (8),                */
+	0x95, 0x03,         /*          Report Count (3),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x05, 0x01,         /*          Usage Page (Desktop),           */
+	0x09, 0x38,         /*          Usage (Wheel),                  */
+	0x95, 0x01,         /*          Report Count (1),               */
+	0x15, 0xFF,         /*          Logical Minimum (-1),           */
+	0x25, 0x01,         /*          Logical Maximum (1),            */
+	0x81, 0x06,         /*          Input (Variable, Relative),     */
+	0x95, 0x02,         /*          Report Count (2),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0xC0,               /*      End Collection,                     */
+	0xC0                /*  End Collection                          */
+};
+const size_t uclogic_rdesc_ugee_v2_frame_dial_template_size =
+			sizeof(uclogic_rdesc_ugee_v2_frame_dial_template_arr);
+
 /* Fixed report descriptor for Ugee EX07 frame */
 const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
 	0x05, 0x01,             /*  Usage Page (Desktop),                   */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 86e64a9ee6bd..1a2d658bad3a 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -169,6 +169,10 @@ extern const size_t uclogic_rdesc_ugee_v2_pen_template_size;
 extern const __u8 uclogic_rdesc_ugee_v2_frame_btn_template_arr[];
 extern const size_t uclogic_rdesc_ugee_v2_frame_btn_template_size;
 
+/* Fixed report descriptor template for UGEE v2 frame reports (dial) */
+extern const __u8 uclogic_rdesc_ugee_v2_frame_dial_template_arr[];
+extern const size_t uclogic_rdesc_ugee_v2_frame_dial_template_size;
+
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
 extern const size_t uclogic_rdesc_ugee_ex07_frame_size;
-- 
2.25.1

