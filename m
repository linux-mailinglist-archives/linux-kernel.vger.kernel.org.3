Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E3258EEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbiHJOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiHJOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:42:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505DB4F6A3;
        Wed, 10 Aug 2022 07:41:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so28064606ejc.10;
        Wed, 10 Aug 2022 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+K2qsWwalWN+gCRC+SKCkMGbVGT3u4gZZQj37rAvARQ=;
        b=ASKJnbWFRYJikUvAhqgTeTq6xayqgxBfyoSbQsPkUaZb1Kpz+9/aJE87c/9RKXWSI8
         r2J6uP1WwFjpC+wnEV83Do5DGCa/+gpn4oPR3iw/U1zITYHBFoYthitzpW8vkZw+WBc4
         gDQufUZdhjw4YkuoNulnIeMpRtnhoLff+5jAom9aKrbmO30pv7IOqfjsC1wigQ/NOONu
         2QKTeHD3zLc4s8/TAjlGgHPj+bfi2POufkH3V1yJeIGvC53ECjUC0vsOdvnp2xO6qkbP
         J2SSuBWfSRXqfurF1JEDkM5g5Fs9NifQncK4nDEOHdaJS4cKnPm9I+rrER5EWy7SApOF
         6Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+K2qsWwalWN+gCRC+SKCkMGbVGT3u4gZZQj37rAvARQ=;
        b=RwbtgIiXRmvS4pKdSFULd2CKnynuYD6EojRSHzMFq4BRKmqDvl1ugFxiS3OpAROsF3
         qTnEtmExfh85TVVzAJJfjy8RqrFBAmQj5YYSfEMQlEbGrrcgb2P4OP0maC+Ey+3gLZLt
         2Anlo34+jlSeyjScCTl3sX8wqxoad62z+WOCYmWZtnDWQdCjqL7RWU6rJz2VhLOVeCEm
         SmFan0u7bmh0W1NWk6yBjfnIgYRJmkSqPUtbqLQBoCfDhPEpp20UJGLJFaOBsSrnjW+r
         /3+1WDoa70mNpQybK5aSjpiXE4xwBScuk7UMZ2E+cGokrN6jvzNBtRlfEbvwqU/lYAlR
         QQrQ==
X-Gm-Message-State: ACgBeo3+FXR2BoGpNfPSUk7VzI1KZYpX6fv0LA8XuFCYy0BZ7muuyMru
        jCVoGHa9CoYnru/AL/PbxKmw03wmrGI=
X-Google-Smtp-Source: AA6agR7+OZZMo9j26lkZt/EprWK2SrP/+2kywFgh/UYliLghkSYMnYwwAccYL4FJFi6p+OBvKiVggA==
X-Received: by 2002:a17:906:ef8b:b0:730:d348:61b9 with SMTP id ze11-20020a170906ef8b00b00730d34861b9mr20547784ejb.350.1660142501743;
        Wed, 10 Aug 2022 07:41:41 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7d699000000b0043cedad30a5sm7778049edr.21.2022.08.10.07.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:41:41 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/3] platform/surface: aggregator_registry: Rename HID device nodes based on new findings
Date:   Wed, 10 Aug 2022 16:41:16 +0200
Message-Id: <20220810144117.493710-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810144117.493710-1-luzmaximilian@gmail.com>
References: <20220810144117.493710-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Windows, the HID devices with target ID 1 are grouped as "Surface Hot
Plug - SAM". Rename their device nodes in the registry to reflect that
and update the comments accordingly.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index c1ee8af7996d..805c7bd4b15e 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -86,38 +86,38 @@ static const struct software_node ssam_node_bas_dtx = {
 	.parent = &ssam_node_root,
 };
 
-/* HID keyboard (TID1). */
-static const struct software_node ssam_node_hid_tid1_keyboard = {
+/* HID keyboard (SAM, TID=1). */
+static const struct software_node ssam_node_hid_sam_keyboard = {
 	.name = "ssam:01:15:01:01:00",
 	.parent = &ssam_node_root,
 };
 
-/* HID pen stash (TID1; pen taken / stashed away evens). */
-static const struct software_node ssam_node_hid_tid1_penstash = {
+/* HID pen stash (SAM, TID=1; pen taken / stashed away evens). */
+static const struct software_node ssam_node_hid_sam_penstash = {
 	.name = "ssam:01:15:01:02:00",
 	.parent = &ssam_node_root,
 };
 
-/* HID touchpad (TID1). */
-static const struct software_node ssam_node_hid_tid1_touchpad = {
+/* HID touchpad (SAM, TID=1). */
+static const struct software_node ssam_node_hid_sam_touchpad = {
 	.name = "ssam:01:15:01:03:00",
 	.parent = &ssam_node_root,
 };
 
-/* HID device instance 6 (TID1, HID sensor collection). */
-static const struct software_node ssam_node_hid_tid1_sensors = {
+/* HID device instance 6 (SAM, TID=1, HID sensor collection). */
+static const struct software_node ssam_node_hid_sam_sensors = {
 	.name = "ssam:01:15:01:06:00",
 	.parent = &ssam_node_root,
 };
 
-/* HID device instance 7 (TID1, UCM UCSI HID client). */
-static const struct software_node ssam_node_hid_tid1_ucm_ucsi = {
+/* HID device instance 7 (SAM, TID=1, UCM UCSI HID client). */
+static const struct software_node ssam_node_hid_sam_ucm_ucsi = {
 	.name = "ssam:01:15:01:07:00",
 	.parent = &ssam_node_root,
 };
 
-/* HID system controls (TID1). */
-static const struct software_node ssam_node_hid_tid1_sysctrl = {
+/* HID system controls (SAM, TID=1). */
+static const struct software_node ssam_node_hid_sam_sysctrl = {
 	.name = "ssam:01:15:01:08:00",
 	.parent = &ssam_node_root,
 };
@@ -241,12 +241,12 @@ static const struct software_node *ssam_node_group_sls[] = {
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
 	&ssam_node_pos_tablet_switch,
-	&ssam_node_hid_tid1_keyboard,
-	&ssam_node_hid_tid1_penstash,
-	&ssam_node_hid_tid1_touchpad,
-	&ssam_node_hid_tid1_sensors,
-	&ssam_node_hid_tid1_ucm_ucsi,
-	&ssam_node_hid_tid1_sysctrl,
+	&ssam_node_hid_sam_keyboard,
+	&ssam_node_hid_sam_penstash,
+	&ssam_node_hid_sam_touchpad,
+	&ssam_node_hid_sam_sensors,
+	&ssam_node_hid_sam_ucm_ucsi,
+	&ssam_node_hid_sam_sysctrl,
 	NULL,
 };
 
-- 
2.37.1

