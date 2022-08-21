Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3D59B5EB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiHUSSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiHUSSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:18:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B1B15FF5;
        Sun, 21 Aug 2022 11:18:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y15so4438886pfr.9;
        Sun, 21 Aug 2022 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oSgkN+dTN7nRZb20JasKAqJ/0pKCu6M2zNDhcnKlGu0=;
        b=MkZHKAGKHan5H72D8tPjvl3t5B0A1ynHIQaPnJRJ5crpXL2QupZxn+K5xNrx16Jowe
         T8gGwT9SKtRepT3P1aZFte+0Fu4PCMbqwqf/I2pL5Oj7WdW2FWmJ1dafGEsMI46JAZed
         CjLfcNP1U+8SAIAe2NdElNpU/XaECGX77/aNshLSGmH3yo5QZUBVsbG55lCQkxSfBEmo
         ktbahVOVyTLG5IStMa+S3UEG0T3v6983R4ptNSKz1WlJkOIV4ieio6MMTZ9S6ZSvNLkx
         re5Sz1ZHevGLSNH80ua19vTRoQIC4NYZSAK4LPtqwOXPH02oMly8hfL8F0f225yicMtY
         CYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oSgkN+dTN7nRZb20JasKAqJ/0pKCu6M2zNDhcnKlGu0=;
        b=xLz70WE9aM++Ajp++4KNCTjNbilSA44yfkTSl7sb3qa6gh6mWp/aWHz3SHIXjZKgKM
         gOzfSjCLjmiNlrXxkoGrKoKxCMRyS7f1kQo/EKHH1+PfdebJa8kN2sB6Z+G96Fpzx33K
         0eclWJUsdQ/c6KA/hF+LIv5zaBLaDALWIZBGv4nlf8XpHILXDIPieundZUbdb9Np5Y2W
         lGBhAMUSwHrUveKz9D3dc8xfVUqZOrH1rbSw6FJsbhArlH4VjkQgzsTKTrcm1RQKT+2Z
         7u03Pn5OKNmnkVYeRCtc8AUJsmXSSYmcD4a+ECW8wNCAybTdvOUsNMY39YcTIYnWSd3f
         YeFw==
X-Gm-Message-State: ACgBeo1cAx/emiBQoFPEY78qx+ZqSXDeZz0ZpYC+1yaMSeeJw6FTBY6h
        nnatZPxVWN8BNkj4oP0SvZyZse5f/0g=
X-Google-Smtp-Source: AA6agR6WWMc3ZkdxZ/qB/4q1PzNtoY5Nih3Ar2rTZXIOvK3bglEb6Kp9bCIcl/7BDvowbchcx6VF7Q==
X-Received: by 2002:a63:5b4f:0:b0:426:9c52:a1f with SMTP id l15-20020a635b4f000000b004269c520a1fmr14188278pgm.511.1661105928539;
        Sun, 21 Aug 2022 11:18:48 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id p27-20020aa79e9b000000b00535bed953e8sm7147739pfq.94.2022.08.21.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:18:47 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] iommu/arm-smmu-qcom: Fix indentation
Date:   Sun, 21 Aug 2022 11:19:02 -0700
Message-Id: <20220821181917.1188021-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821181917.1188021-1-robdclark@gmail.com>
References: <20220821181917.1188021-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Plus typo.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 include/linux/adreno-smmu-priv.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index c637e0997f6d..ac4c2c0ab724 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -37,7 +37,7 @@ struct adreno_smmu_fault_info {
 /**
  * struct adreno_smmu_priv - private interface between adreno-smmu and GPU
  *
- * @cookie:        An opque token provided by adreno-smmu and passed
+ * @cookie:        An opaque token provided by adreno-smmu and passed
  *                 back into the callbacks
  * @get_ttbr1_cfg: Get the TTBR1 config for the GPUs context-bank
  * @set_ttbr0_cfg: Set the TTBR0 config for the GPUs context bank.  A
@@ -61,12 +61,12 @@ struct adreno_smmu_fault_info {
  * it's domain.
  */
 struct adreno_smmu_priv {
-    const void *cookie;
-    const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
-    int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
-    void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
-    void (*set_stall)(const void *cookie, bool enabled);
-    void (*resume_translation)(const void *cookie, bool terminate);
+	const void *cookie;
+	const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
+	int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
+	void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
+	void (*set_stall)(const void *cookie, bool enabled);
+	void (*resume_translation)(const void *cookie, bool terminate);
 };
 
 #endif /* __ADRENO_SMMU_PRIV_H */
-- 
2.37.2

