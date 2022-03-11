Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB07F4D686C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbiCKS3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242495AbiCKS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:29:15 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0FAD1083
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:28:11 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id j29so6563175ila.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3h6kRnzC7goLGEPmVBWo4cUiV7yAsagl+8hP4OJRt60=;
        b=Yysm327o5/GzYIVke4LAYz/7eSWLDIM7SQoR1fxon9K3967gGvGTsPyBKOdl6WsoUs
         lxMBbrpmgjl2+fdxYqM30DKensGi/owlaCLMJtL3ldflz8+HF9HcsODaxgYYL0J79FEj
         0ZJqXnBsDrNyosZT8oIqcVD8Q+UJUxpjOZP7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3h6kRnzC7goLGEPmVBWo4cUiV7yAsagl+8hP4OJRt60=;
        b=Q2fzcHkt4xWS44oswTKrLuo9Tu2262CnAaTIPHw+nTyNt9gBivN18OfFNBYHRCm4IN
         FRgomMf0L2kmglh2QA99wZx4zApSh3WcZXdexESuxthMCvfvIeZRhJD7+o3gtOLje7En
         7AXVYt3KYn+PdFFI4anQRqleEIAxaGRwODBk8RPn/quPv+BOMxuB1GHyEiqVnUUumFcB
         swFQnINe+lumk1Fyk2u58sfH+FH8jIKnJEh4WOcjZlg+JP+y2Ezly5O78nUtgKVVtXnx
         lw5p+TzxorYj2hUIIa/4uFPrUEULhQcw1/ULLRc3LsRNttie92nF6Ob5CB0SRgJLJTK1
         puwA==
X-Gm-Message-State: AOAM533mQDx7PgcrihV6K8siCjURweOK9Yz5izfBLAJPJ08ew1tKGvio
        LNnnx1v8iUqod2OYm0Fjh26urJOn41DtZQ==
X-Google-Smtp-Source: ABdhPJyXBcq64bTK5sj2ZWDtA1swRGQqBBlqtFMBcZKFPte5wO3bMxTNbICLQeV75OSaWmb1MkEzMA==
X-Received: by 2002:a05:6e02:1285:b0:2c6:123f:48b8 with SMTP id y5-20020a056e02128500b002c6123f48b8mr8342898ilq.250.1647023291166;
        Fri, 11 Mar 2022 10:28:11 -0800 (PST)
Received: from ddavenport4.bld.corp.google.com ([2620:15c:183:200:5a3:e166:1d11:e36c])
        by smtp.gmail.com with ESMTPSA id u15-20020a056e021a4f00b002c665afb993sm5031715ilv.11.2022.03.11.10.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 10:28:10 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Drew Davenport <ddavenport@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: Update comments for drm_find_edid_extension
Date:   Fri, 11 Mar 2022 11:28:07 -0700
Message-Id: <20220311112801.1.I8dff39863e3d7a30f13512d9ff50b38ce6743373@changeid>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In (40d9b043a89e drm/connector: store tile information from displayid (v3))
this function was changed to find EDID extensions by id, but the comments
still are specific to the CEA extension.

Signed-off-by: Drew Davenport <ddavenport@chromium.org>

---

 drivers/gpu/drm/drm_edid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 561f53831e29..1afe73fbf3e0 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3326,7 +3326,7 @@ add_detailed_modes(struct drm_connector *connector, struct edid *edid,
 #define EDID_CEA_VCDB_QS	(1 << 6)
 
 /*
- * Search EDID for CEA extension block.
+ * Search EDID for the extension block with id @ext_id.
  */
 const u8 *drm_find_edid_extension(const struct edid *edid,
 				  int ext_id, int *ext_index)
@@ -3338,7 +3338,7 @@ const u8 *drm_find_edid_extension(const struct edid *edid,
 	if (edid == NULL || edid->extensions == 0)
 		return NULL;
 
-	/* Find CEA extension */
+	/* Find extension that matches @ext_id */
 	for (i = *ext_index; i < edid->extensions; i++) {
 		edid_ext = (const u8 *)edid + EDID_LENGTH * (i + 1);
 		if (edid_ext[0] == ext_id)
-- 
2.35.1.723.g4982287a31-goog

