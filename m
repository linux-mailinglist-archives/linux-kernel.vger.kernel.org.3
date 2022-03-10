Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814F4D3F31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiCJCNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiCJCNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:13:33 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B6311147;
        Wed,  9 Mar 2022 18:12:33 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id s207so4556472oie.11;
        Wed, 09 Mar 2022 18:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tS3l5dyv6iEtlmALFxQ3ouIPA92mybhqp9cn+Az+v3o=;
        b=bzx3iqq3WWr62snyOqU0fk70emKCt+7ePouDpuqRFw3e0rbUxJocSWgJ0WgTBbX09Z
         l+QwDq+xN49a4xajT0nMZaTnmDvr6S7Qn1yYldxVx7QJB9Lm8/1d/HwQVsoIz1ncgUxM
         w45UEFFc5cj28bkpbi2OG3EsqR3xn58DUz45jjQbskVApux5uTAGQuyE42ubHoGP5rFZ
         Q7njke7miQOrCA0XeH8sQ+GyNSUt6GjMx8vYkl6RVvTcNNqu6ziuIWu1S7cf8sYjrcvc
         yM+g1FEVoL0weBS78ivsqYWeJpTYiQmJD0YwK5dGP64gm/7mo+XJxIvSEzc/pJQCkn0T
         l8uA==
X-Gm-Message-State: AOAM530bGZSbSZ39Yu3EU13W1lTQ4kPSnE21jhrHufH2YOEmgS2Cd330
        B6ox3UMaJ4nkJ0VctFfICw==
X-Google-Smtp-Source: ABdhPJxG8Srsb9UPYkF3u10xlvHRZWXyFAvFkGI+jXbie6TLmXp59NVffaMP9vQHjhKA35jSSIiicA==
X-Received: by 2002:a05:6808:15a9:b0:2da:5978:4a43 with SMTP id t41-20020a05680815a900b002da59784a43mr1135977oiw.30.1646878352942;
        Wed, 09 Mar 2022 18:12:32 -0800 (PST)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id l15-20020a4ab0cf000000b0031c0494981csm1872051oon.9.2022.03.09.18.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 18:12:32 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Add QEMU virt machine compatible
Date:   Wed,  9 Mar 2022 20:12:24 -0600
Message-Id: <20220310021224.599398-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top level QEMU virt machine compatible, linux,dummy-virt, has been
in use for a long time, but never documented. Add a schema for it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/linux,dummy-virt.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/linux,dummy-virt.yaml

diff --git a/Documentation/devicetree/bindings/arm/linux,dummy-virt.yaml b/Documentation/devicetree/bindings/arm/linux,dummy-virt.yaml
new file mode 100644
index 000000000000..c7c5eb48fc7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/linux,dummy-virt.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/linux,dummy-virt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QEMU virt machine
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    const: linux,dummy-virt
+
+additionalProperties: true
+
+...
-- 
2.32.0

