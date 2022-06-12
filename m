Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA78547B00
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiFLQNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 12:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiFLQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 12:13:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC94A3FE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:13:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u8so4371742wrm.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LL9w+d+H88J/0VBgbeKOwTbMY4B/jVYAAXA85+Hav4=;
        b=gl5639X+UtUz4/8ZKGB9pGoMNC/i69RQhkFXX4sV2KPNty/Uj+gZYC8+yAvfPMVjQ4
         flVMMv+wYJbeaU7Sucs4xH8SmGJRWX0lF6xMBjkdVbS5yqJn7s/sMYsbfglp/lMlsz8D
         iTSE1qWoCj8OwrfSvDiEIVikBaPyfgc1DrTe19Tsw01bK9szh4Y2w95yBh5FMQUUOMDS
         RgmFC8+X3mA1VuNAzM2LOyEU+r13r8GMEdzdexYcFcREk/5tjrVhzsznJqAVgQpbiuyA
         6P74+Xzhlx1dpmYB/9ewkmxFOu9uUepV6KNlfCgjqVLMpzYGgKZmteKKMT8HEQjDkI0A
         dTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LL9w+d+H88J/0VBgbeKOwTbMY4B/jVYAAXA85+Hav4=;
        b=64X3NY+2GZjAsV+AxRh35O0NUcl4BTkvH8RP6Hi7t0v1A3+2oVoDhWpCxSADLExg+C
         APONFkud+ajyUv1dJyt0quGqrVMAENlh6s9hd0zaNsPBmS5eWQXfBzdiawztS3r8Oh1f
         LHYCrukZB6VmkEKBhtHDTCs9WLxCOKIuDz2+1yurt6W34dYFHxrDDRwbHeDCHULUuKYL
         Ix+77NJFJnC7sKwLInpbOMlygvv+Lf38GPHbrc1rh1jox2mTPYXt205Dj/wBwf4I0w/R
         njbkezaAowjUeGd0ijcgglUQXqUc4tmORdSd/FvAmTe8v4yEwvqp8nUs5rnLFtj+pQ4w
         PXgw==
X-Gm-Message-State: AOAM533qjzW2NdPCbpNngkEn0VDz3vo+BNbKHoevWAKZPftXUdvkUQyS
        3IaIaxwcN6D5waRduecoZSo=
X-Google-Smtp-Source: ABdhPJz8VDALPE+dJoYWOkkCRUN5A2vLLKhXWgjuHeDFcnN/MUxG/0o2y8ajRYh1LNazs9hIj5r++Q==
X-Received: by 2002:a5d:5903:0:b0:210:316f:7f40 with SMTP id v3-20020a5d5903000000b00210316f7f40mr53339486wrd.624.1655050379282;
        Sun, 12 Jun 2022 09:12:59 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d6208000000b0020d0f111241sm6015925wru.24.2022.06.12.09.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 09:12:59 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/3] drm/rect: Add DRM_RECT_INIT() macro
Date:   Sun, 12 Jun 2022 18:12:46 +0200
Message-Id: <20220612161248.271590-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220612161248.271590-1-jose.exposito89@gmail.com>
References: <20220612161248.271590-1-jose.exposito89@gmail.com>
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

Add a helper macro to initialize a rectangle from x, y, width and
height information.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 include/drm/drm_rect.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
index 6f6e19bd4dac..945696323c69 100644
--- a/include/drm/drm_rect.h
+++ b/include/drm/drm_rect.h
@@ -47,6 +47,18 @@ struct drm_rect {
 	int x1, y1, x2, y2;
 };
 
+/**
+ * DRM_RECT_INIT - initialize a rectangle from x/y/w/h
+ * @x: x coordinate
+ * @y: y coordinate
+ * @w: width
+ * @h: height
+ *
+ * RETURNS:
+ * A new rectangle of the specified size.
+ */
+#define DRM_RECT_INIT(x, y, w, h) { (x), (y), (x) + (w), (y) + (h) }
+
 /**
  * DRM_RECT_FMT - printf string for &struct drm_rect
  */
-- 
2.25.1

