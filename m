Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5247D79E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbhLVTXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345143AbhLVTXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:23:31 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA1BC061574;
        Wed, 22 Dec 2021 11:23:30 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b22so7508479lfb.9;
        Wed, 22 Dec 2021 11:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnMHNj6u7HaHgpLVLKeM6nSGjSJw2q61Bxw5Xl/ukmM=;
        b=Xiyb+qLClCl7Pu3HgsGA1CRIe4oxKjaxidZtnc2DhR71a0wt6QbvrsXQ+GkeN3mNQi
         5fjoJyR5RfCHD6wZ8pJlJ2eeVcitm2Rk7YZ/JoFYRcZB715QIj75Mcd1VcneXf/MlA1O
         fuOFY2opBTvmP1vj3T7kn0m+/elI9kwvTx7h1JeV1/Uwxmi7u9UEGBOsv2GfKHV5WsU+
         ckTpY6CigzGd2F9k4GkiZO/Mjex/gL4sJZHj27ygx+brHfevAwIKi7+XgSNAqk71vVmZ
         3uyHorjbfpoCRvzJ20xG90RuyoReVd8URTQn/8UCg5aDQBqwvDq9qa7o3wFMDRNNVBJJ
         yV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnMHNj6u7HaHgpLVLKeM6nSGjSJw2q61Bxw5Xl/ukmM=;
        b=Y3gVA+tzbYQnUYtnS0Mah5aVjWHz0qgSKVE+GWk7dUOBILKgAItAAcBjIV2MBtSDbv
         tA2qV0ZZAYJ8hOALzHYxbexHX304iIEORrdlRG7w3SYGQ/BiC6WQwUudMY+ScfqP45Kl
         CSJQUkHJe4jrbPCIdbNjV3I5q0gb7jOQIKbg1F7EzPGTY3D7kipARTB3zMEG3sxJI5/q
         S4jDIJ7ciC/AP7Pj7kLPN7X2Dv6c247FQbK2cGDzuxlUk4KUBb29wWYHp6TIgyyWWE+6
         tQKrBNk3tAfHpTa8iqKYLP6KP2yn2B9v4m+79DVAUKSEcwSln9hJ4vfkNMFqcJN7JL8K
         kA+Q==
X-Gm-Message-State: AOAM533Tgf7/qnV6+N9pA7II6v1i2GHAQk71zaQhAyoWakCMVCUiBzD0
        RkhPx34VYS0lUsIWw9m89R+diPmGEUE=
X-Google-Smtp-Source: ABdhPJxrlcBFE05Qdt3pla4vKu9cuel8MOEK+s8D2N0uphrADifmn9B4e9V0aEdS4UAho1nrT/S2Jw==
X-Received: by 2002:a05:6512:40d:: with SMTP id u13mr3236080lfk.327.1640201009043;
        Wed, 22 Dec 2021 11:23:29 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id q10sm242070lfm.163.2021.12.22.11.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:23:28 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/3] dt-bindings: nvmem: add U-Boot environment variables binding
Date:   Wed, 22 Dec 2021 20:23:19 +0100
Message-Id: <20211222192320.21974-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211222192320.21974-1-zajec5@gmail.com>
References: <20211222192320.21974-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This binding allows describing a (part of) MTD device (partition) that
contains a block with environment variables. Operating system usually
needs to parse that block to read variables values that may affect
booting process & device configuration.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/nvmem/u-boot,env.yaml | 56 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
new file mode 100644
index 000000000000..0f808868fff3
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot environment variables
+
+description: |
+  U-Boot uses environment variables to store device parameters and
+  configuration. They may be used for booting process, setup or keeping end user
+  interesting info.
+
+  Data is stored on flash partition in a U-Boot specific format (CRC32 and NUL
+  separated key-value pairs).
+
+  This binding allows specifying data location and format (default one or vendor
+  specific).
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - u,boot,env
+      - brcm,env
+
+  reg:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "uboot";
+            reg = <0x0 0x100000>;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            nvmem@10000 {
+                compatible = "u,boot,env";
+                reg = <0x10000 0x10000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 67558097bb66..271c29c84c7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19624,6 +19624,11 @@ W:	http://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/pci/tw686x/
 
+U-BOOT ENVIRONMENT VARIABLES
+M:	Rafał Miłecki <rafal@milecki.pl>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+
 UACCE ACCELERATOR FRAMEWORK
 M:	Zhangfei Gao <zhangfei.gao@linaro.org>
 M:	Zhou Wang <wangzhou1@hisilicon.com>
-- 
2.31.1

