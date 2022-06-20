Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57AF551515
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiFTKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiFTKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:02:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E161212AEC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:02:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so8682352pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsi5qTupo0kCuDpyUp9YDxiUEMfoJpT1b7YUEL135SA=;
        b=oo7k9+JPQLMEKY3tOyf6KAUgNfkZrLlYSmVWITF7Fr2t4tvkQXfngyks/qngStBwXO
         2KuDwQZZEJQWpZDVOEjycAu2bxEWq8N2PnxoUaIm+gAycjUQ8qK446V23KAeFOx9pk1N
         MGwXnL/k6JiwNXoCJTBuob1cdVpgTd1cPM4NmxboqdVzyy+YMCT0WRGKbaw3xAFi8ROi
         pTDl7Vb7DIyknDT7WfQDEyH4rhuXYzj7lO2+pCicymiMMyUqMqqTlYXJZEhEFc/uhT8z
         1PtDeeEovLFDCrYqnJq4g+N6tLBcn4cJAO3krkPR3D3vYbXA1wbOklEsvBkWnhr+bVL4
         AIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsi5qTupo0kCuDpyUp9YDxiUEMfoJpT1b7YUEL135SA=;
        b=Tyj5lNvQoKwYqTK2BFE9zk/27BJoKcZXmce0tlkRvvwU/JE3ZmhX0oZNy5RAXY00AN
         nktdWVAtDtn1AoIAj70bZEe/Xm2NUSfEgUWf4sv8C0XgkLldKXOF6FsalpNqtr9BSUVY
         Su+HdTzVyLOl2LLeoDwMnd416L0B5q5Dxn8flJa6wqdlo0OewfSsf/Silyp/ZMkkSeIH
         wzgjYP6Z6D7nSGb/vpd+xNcmzw259m3+/87pW+SxCyhhdIgsT//BIQL+s8TDvjlTTGDn
         ROzLowCqEFFPTGgLUvhXsiOHYDPGR/EZMP90wH6XNIGnqmDWKdRF6qeCZckTq13M2q0Y
         AxHA==
X-Gm-Message-State: AJIora+hPDyNeQCDoPbha5o70Og43NzNl0ROHK7m1yIx3t9wTc87tVLK
        AGZXgv+33e/7lsGwFHsGLmk=
X-Google-Smtp-Source: AGRyM1u3K6M5PpPDTvfSLZ5whwluHfiPWJvWBgeCw28Fdp0FAEibLDJdV8iLozIYLO5sCfWNAOKn1A==
X-Received: by 2002:a17:902:e8c6:b0:169:10c4:5231 with SMTP id v6-20020a170902e8c600b0016910c45231mr19307693plg.173.1655719342478;
        Mon, 20 Jun 2022 03:02:22 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id p2-20020a63b802000000b003fcf1279c84sm8826654pge.33.2022.06.20.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 03:02:22 -0700 (PDT)
From:   zys.zljxml@gmail.com
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     bob.beckett@collabora.com, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, katrinzhou <katrinzhou@tencent.com>
Subject: [PATCH] drm/i915/gem: remove unused assignments
Date:   Mon, 20 Jun 2022 18:02:16 +0800
Message-Id: <20220620100216.1791284-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: katrinzhou <katrinzhou@tencent.com>

The variable ret is reassigned and the value EINVAL is never used.
Thus, remove the unused assignments.

Addresses-Coverity: ("Unused value")
Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
Signed-off-by: katrinzhou <katrinzhou@tencent.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index ab4c5ab28e4d..d5ef5243673a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -931,8 +931,6 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
 		break;
 
 	case I915_CONTEXT_PARAM_PERSISTENCE:
-		if (args->size)
-			ret = -EINVAL;
 		ret = proto_context_set_persistence(fpriv->dev_priv, pc,
 						    args->value);
 		break;
-- 
2.27.0

