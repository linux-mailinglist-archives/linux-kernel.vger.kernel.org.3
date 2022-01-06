Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897E84864BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbiAFNAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiAFNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:00:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE77C061245;
        Thu,  6 Jan 2022 05:00:14 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so8393750pjf.3;
        Thu, 06 Jan 2022 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BkiIzAKsOgVknYHXwUT1TwPOBF6Sao9OIvKgj69GMxI=;
        b=SEeiBBVK94BYnNwH+3/XImWwWfpk9eJ7VK9zDjeSdrmJC9BlBQhJtismKPvLlnTeoI
         jJIEG9I2Y4h/F7lgLK3pS7TuKw0ymmcyqm5o/Y+0rQR6aqNI9e5ej307ECNynZ0Zfq25
         bFpR5qz9kkjiJ9CuQl+DS4fzKRuUZR5DmFwvjX8qFINP0V0G8ahDH0cRAakEWaEl4GFB
         e+kiYaU9DxryYx6GQZBt5lW90egaYZ9W/MKQP57aLRwxZI851ZLnHZnHVdLDzfRtFlV5
         aJ2g2wWUgTJUBjDaIkTn2ZwWZfrVE84gsVmtx35RZQwV2WaWSamwlb2cajXTKGZk08Px
         0KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkiIzAKsOgVknYHXwUT1TwPOBF6Sao9OIvKgj69GMxI=;
        b=1TV2byQJSr2nFx0o89MdYczfbmYgVL6OPfGMQUPWgZUA4cie0YtNb6tuAkn1uEO4S6
         h6k15pJoVMFkxwbNTQAa7Q1ed653S/n8puBI1yF4ydTS/lu0Kr1o00ExdzW0sKyQGWvv
         HqTkvopr5b/k01gqS3Or4u7ttgeGQkQZ0HBaK3XGTBb2I3e1mDTwOsYKNvXpyqfJ77Wj
         4juqdxKPkINBYMYgciEDOA7ikv5AjTKRqML12eEhowjpdDzr80jYGw3TTq/OP3HjWjdK
         X7EzpCwxkJ0cvn0QuKzcjhuOqGBHAWZoPn23PHVjF835WYhi/rRugwCmOHbNCTQNkdRg
         xihQ==
X-Gm-Message-State: AOAM530R5e3w69mygpnu0jeahpQSn7wpUCS3aDXguII6HuzjZD30l+n+
        bime1xuzEoEZxc2bVvqGTDooJwDKBEl1CA==
X-Google-Smtp-Source: ABdhPJxXOmFqRCpe5E6OxqxN9E6z6xz/IyM616DKi1mfA9kkGHzDUYQJiHeBkGgmDXTISZNF7M+uqA==
X-Received: by 2002:a17:902:70c3:b0:149:a78f:54ea with SMTP id l3-20020a17090270c300b00149a78f54eamr28587826plt.114.1641474013654;
        Thu, 06 Jan 2022 05:00:13 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g14sm2052583pgp.76.2022.01.06.05.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 05:00:13 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc dtbindings
Date:   Thu,  6 Jan 2022 20:59:41 +0800
Message-Id: <20220106125947.139523-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106125947.139523-1-gengcixi@gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

sprd,ump9620-adc is one variant of sc27xx series, add ump9620 in
dtbindings.

Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
index caa3ee0b4b8c..cd20ff17e58c 100644
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
@@ -20,6 +20,7 @@ properties:
       - sprd,sc2723-adc
       - sprd,sc2730-adc
       - sprd,sc2731-adc
+      - sprd,ump9620-adc
 
   reg:
     maxItems: 1
@@ -36,11 +37,29 @@ properties:
   nvmem-cells:
     maxItems: 2
 
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - sprd,ump9620-adc
+then:
   nvmem-cell-names:
     items:
       - const: big_scale_calib
       - const: small_scale_calib
 
+else:
+  nvmem-cell-names:
+    items:
+      - const: big_scale_calib1
+      - const: big_scale_calib2
+      - const: small_scale_calib1
+      - const: small_scale_calib2
+      - const: vbat_det_cal1
+      - const: vbat_det_cal2
+
 required:
   - compatible
   - reg
-- 
2.25.1

