Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE6A47A4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 06:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhLTFhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 00:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbhLTFha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 00:37:30 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE600C061574;
        Sun, 19 Dec 2021 21:37:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f125so8432751pgc.0;
        Sun, 19 Dec 2021 21:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CyUHQURqnG0Cbk3YChc98g2xsw1FYRao5iS256syH0A=;
        b=WbFzvQ1hONQsyHiwqV6Zlrk3667b1DO8lhdslisAkvySv0fV3nJsOqK5v8BC72aAD6
         gspLlOgFtAExQQr5CbFO9nPhqNnPlQ9kxziBXoS3MgkaDyHAcRhikdDF+VnM8e8pdnJv
         uVUKG0N82E0DHiqrajuOzplKf6SB+e3t/fXUaS5/Ij88w3fgmUQO5HfFqRJRkTYq5N2M
         FER/NaF0KAAYAwchgeHfs0ZKpM8PFhw/LKcF8vLzSCwFKSz2GyIPBx+peFYXafHbNfdp
         RM1+cC58BeH6bImq4YjEgdJFUJmPw9+4yU+gSDKczwlPFkI/JHvq3Gl9uUKcJB6rS+vO
         aILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CyUHQURqnG0Cbk3YChc98g2xsw1FYRao5iS256syH0A=;
        b=E6ptvXJsWEnifgTPDGwf56CY6fGhfVPYFJI1NOGqiKM+9kDAhdZphPRsCGY2YNigjF
         XTjgAbsfu8w5jzFrUOrwcc2ZMbYK/i08nbpMirvvln34/DRknjXaGeux9uC/cYf88eAJ
         disYtfoGkHlF0gz2jFCk4aIVdvy2PO54UOW3N/PpFrch1dANZYl7Im0/lylrkLw7Z2nn
         9XDS3qIPOaQFE6kbkL6HnTg13nj2nnBOWfKBFef6gRKG4Z4LicXsIODHJzce01SOPPnT
         cPdnegXgfp3PvrBncwinldYivP49j7kDk5+C6cU1yCEQU21YR6lzriy5Tss96gZFwBiw
         d9Iw==
X-Gm-Message-State: AOAM530HO4/WivrZCux37g1ci5ZnJ5HIsagHPPRxyFyTMwOuvvM0tzct
        O4fbdLDRpMKTK/E44H7lkP0=
X-Google-Smtp-Source: ABdhPJwgxAQ8JB4bPDb/MN2P/h1QtS8uNuNzYfhrvM4GH13O0WyOCYTmksD0ZMTUZYD1CM7VWMh3Yw==
X-Received: by 2002:a63:2bc1:: with SMTP id r184mr13345119pgr.426.1639978649944;
        Sun, 19 Dec 2021 21:37:29 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d3sm7491501pfv.192.2021.12.19.21.37.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Dec 2021 21:37:29 -0800 (PST)
From:   Edwin Chiu <edwinchiu0505tw@gmail.com>
To:     robh+dt@kernel.org, edwin.chiu@sunplus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Subject: [PATCH v2 1/2] dt-bingings:arm:sunplus:add sp7021 compatible string to sunplus,idle-state.yaml
Date:   Mon, 20 Dec 2021 13:37:31 +0800
Message-Id: <bd7cf5810c0912e8fc43d166bd9c88d794c905f8.1639971376.git.edwinchiu0505tw@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
References: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
In-Reply-To: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
References: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for cpuidle state on sp7021

Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
---
Changes in v2
 - Align email address of sob and sender

 .../bindings/arm/sunplus/sunplus,idle-state.yaml   | 55 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml

diff --git a/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml b/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
new file mode 100644
index 0000000..649e953
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sunplus/sunplus,idle-state.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus cpuidle state
+
+maintainers:
+  - edwin.chiu <edwin.chiu@sunplus.com>
+
+description: |
+  Sunplus SOC cpuidle state
+
+properties:
+  compatible:
+    const: arm,idle-state
+
+  entry-latency-us:
+    description:
+      Worst case latency in microseconds required to enter the idle state.
+
+  exit-latency-us:
+    description:
+      Worst case latency in microseconds required to exit the idle state.
+      The exit-latency-us duration may be guaranteed only after
+      entry-latency-us has passed.
+
+  min-residency-us:
+    description:
+      Minimum residency duration in microseconds, inclusive of preparation
+      and entry, for this idle state to be considered worthwhile energy wise
+      (refer to section 2 of this document for a complete description).
+
+required:
+  - compatible
+  - entry-latency-us
+  - exit-latency-us
+  - min-residency-us
+
+additionalProperties: true
+
+examples:
+  - |
+    idle-states {
+      CLUSTER_SLEEP_BIG: cluster-sleep-big {
+        compatible = "arm,idle-state";
+        entry-latency-us = <8000>;
+        exit-latency-us = <700>;
+        min-residency-us = <9000>;
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..41957c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS CPUIDLE DRIVER
+M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

