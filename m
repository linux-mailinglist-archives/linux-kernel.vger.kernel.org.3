Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F819493CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355587AbiASPLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:11:51 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40632 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiASPLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:11:49 -0500
Received: by mail-oi1-f169.google.com with SMTP id bx18so4562098oib.7;
        Wed, 19 Jan 2022 07:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOMMgElRk3P4X8qjJo0jalSIZdngmcFEh5c82kBwE08=;
        b=2SoxMTgAZzEtGxYLjn33zYmv71iAb6mOYBhHIWoOeaLh6p9G9IgaSyas15dFHGVBJJ
         s8VX230RqorkThU0jhNEqHgvEL/qsb5oax+z0/+87ejw5eCc/WtXIleudcpKw7Tnmcff
         OoOgpABGclJ7BVQLlpaSZVm9vHUOeiH9gcJUIt7V1p/92Fvcyh1TEknzY5WHJ8NibCvS
         rhFOMB/rvq5bJqENZ8oM0RAD+c0cHg8eWEat8Osvc/ZiZZNWFGS7rx1BeywBFcmEJOZl
         XL23foio/MjDZNJowWOJHXWd34psHUkrRKqe4H0CHY0okqspwvOTKstjLWM4ZU0R12xc
         0tLg==
X-Gm-Message-State: AOAM5331KIwAGGxOwmOAlEXXxIjetz/7jl4kBGYwGq0rgFj6aivS2Yar
        8/ulPW7m3OKSOi4mijlYmbjV9JCvCg==
X-Google-Smtp-Source: ABdhPJw5SaSIbKk3zveHwugHJ+gal+j5YdgGsLkKXaFaapKpOy9L3SfD4UzR/3RnI8kVN7Ru2bTt8g==
X-Received: by 2002:a05:6808:1141:: with SMTP id u1mr3492177oiu.133.1642605109101;
        Wed, 19 Jan 2022 07:11:49 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id c26sm18267oov.22.2022.01.19.07.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:11:48 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kumar Thella <sthella@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: nvmem: qcom,spmi-sdam: Drop child node schema
Date:   Wed, 19 Jan 2022 09:11:35 -0600
Message-Id: <20220119151135.3598392-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the child node schema. The schema for child nodes is already
defined by nvmem.yaml and doesn't need to be duplicated in the
qcom,spmi-sdam schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/nvmem/qcom,spmi-sdam.yaml        | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index a835e64bc6f5..ee79e13b5fe0 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -38,34 +38,6 @@ required:
   - reg
   - ranges
 
-patternProperties:
-  "^.*@[0-9a-f]+$":
-    type: object
-
-    properties:
-      reg:
-        maxItems: 1
-        description:
-          Offset and size in bytes within the storage device.
-
-      bits:
-        $ref: /schemas/types.yaml#/definitions/uint32-array
-        maxItems: 1
-        items:
-          items:
-            - minimum: 0
-              maximum: 7
-              description:
-                Offset in bit within the address range specified by reg.
-            - minimum: 1
-              description:
-                Size in bit within the address range specified by reg.
-
-    required:
-      - reg
-
-    additionalProperties: false
-
 unevaluatedProperties: false
 
 examples:
-- 
2.32.0

