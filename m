Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3150BCBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379718AbiDVQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378994AbiDVQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:20:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1F5C861;
        Fri, 22 Apr 2022 09:17:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k22so11784838wrd.2;
        Fri, 22 Apr 2022 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqaDmVSTH8kRIVx2Jc7UCmC/D+1NcV2YaY4UF+KoQrE=;
        b=LBRrPEsh5v4Ua+CSf7zr4C62y//TkfzRqpV3PBZJRBv4CRQdOGCoTEQaKNDTp+sLlk
         lKwrtnBRF8oP6xhAtavb18l0DVnUYCPeACgbWDZx7ivGRtLyfMq63htBTs8V6XJX9zo7
         AUwTPdl5h8ZwGIys2HQAsC4um9xLK67DhwofOQGd6/G5h9srgZZ9vF+iSSU0fRt058wc
         uI9jgBIs8BGFZbWPFwO+C8b/ibDYwKOa4px0WctiWv4BaDqzrhLP1fi8c/FPArFrGC2N
         PO5BlTdOTweSO33q/9Ajn3Uubn8oS3UaG4Ob1fTdtOp+s9lw6TySzSzis7YMqnpt/YIb
         PRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqaDmVSTH8kRIVx2Jc7UCmC/D+1NcV2YaY4UF+KoQrE=;
        b=3XJX8DdtSsshOqyqjf5Y0C0Zyj/AzUtjDYY2Bew0d8iCn7FEBvICEDxKvDFPxwgbf6
         UaysJ0E6ltDCKfxkvpXZMOtcAkkKmIlG+xkc8iWHDp+wkj8Jb/x4xdYKF3J+ZIg7KhKD
         X2nVv/fdP/jKV2lAg0sCJ7u1ksCWbnVmKXFG0hWiow265UfpGHKnrvhLSd7KVzwBunZy
         mFBtE2EHNw50dMG/tqiKBQBbj581rRd6j8V++ySbIN/rnNnfzcrTdaO0/ps7uMDZg4TE
         pkbM8L3vUgJkOuu7YrZrNIVf4DjO8A0NG6x72hlJptN5HGmShR/bKTdyYnEdaTFfdg3w
         zhTQ==
X-Gm-Message-State: AOAM532F8ACcty0bemC1atgMP3gZiTs9m5moyPYfgyI+o9cFwDxCfDAr
        Z2PtFOF110FbnuD/gd8cTQE=
X-Google-Smtp-Source: ABdhPJy8A+5MLmvgrVf6CaFzLQbY516nLLbku9rWWNatXqiOrdjiHJhHtgZ0ZGYa/KZ/OmNHmanEBg==
X-Received: by 2002:adf:da49:0:b0:204:1548:2a58 with SMTP id r9-20020adfda49000000b0020415482a58mr4400090wrl.664.1650644257315;
        Fri, 22 Apr 2022 09:17:37 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b0038c8dbdc1a3sm1927029wmg.38.2022.04.22.09.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:17:37 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     hadess@hadess.net
Cc:     hdegoede@redhat.com, dmitry.torokhov@gmail.com,
        rydberg@bitmath.org, lains@riseup.net, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 3/3] HID: wacom: Fix double free on managed resource
Date:   Fri, 22 Apr 2022 18:17:09 +0200
Message-Id: <20220422161709.30198-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422161709.30198-1-jose.exposito89@gmail.com>
References: <20220422161709.30198-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the documentation for devm_input_allocate_device():

  Managed input devices do not need to be explicitly unregistered or
  freed as it will be done automatically when owner device unbinds from
  its driver (or binding fails).

However this driver was explicitly freeing the input device, allocated
using devm_input_allocate_device() through wacom_allocate_input().

Remove the calls to input_free_device() to avoid a possible double free
error.

Fixes: d2d13f18aaa51 ("Input: wacom - create a separate input device for pads")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/wacom_sys.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 066c567dbaa2..164c0f7cb796 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2098,7 +2098,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 	error = wacom_setup_pen_input_capabilities(pen_input_dev, wacom_wac);
 	if (error) {
 		/* no pen in use on this interface */
-		input_free_device(pen_input_dev);
 		wacom_wac->pen_input = NULL;
 		pen_input_dev = NULL;
 	} else {
@@ -2110,7 +2109,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 	error = wacom_setup_touch_input_capabilities(touch_input_dev, wacom_wac);
 	if (error) {
 		/* no touch in use on this interface */
-		input_free_device(touch_input_dev);
 		wacom_wac->touch_input = NULL;
 		touch_input_dev = NULL;
 	} else {
@@ -2122,7 +2120,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 	error = wacom_setup_pad_input_capabilities(pad_input_dev, wacom_wac);
 	if (error) {
 		/* no pad in use on this interface */
-		input_free_device(pad_input_dev);
 		wacom_wac->pad_input = NULL;
 		pad_input_dev = NULL;
 	} else {
-- 
2.25.1

