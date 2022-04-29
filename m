Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0085149EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359575AbiD2Mya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359545AbiD2MyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:54:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9F0CA0E2;
        Fri, 29 Apr 2022 05:51:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bv19so15259738ejb.6;
        Fri, 29 Apr 2022 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BenUmI5YlFoZ8y7dkLtbgkF8fzK7mypO7kCBy+ysHLY=;
        b=QjJcXyX0Tbqo6ltLEBb8JucwUuWznyJeaKAtemFVTehtLAi+LCsimByCxeERypXBfc
         xv0+sK6gEkwAQz4VsL9BPu9WjHA7/xOLiv8X2ZRF/eX2fhyducz2VqnypCgsnvKCRNK+
         nQO9sPGNiRgd82coerrG+ouWBQRabe8cgm4NweLVAtOq/oDiSC4LA1M/hNu8qvL1gl1X
         ldnroNIK8Z/obfyHrp0UAIIj9F4Kn5z+MyDZV+dchNPtfgJZU5O8dCKa48Qi8PQLBU4A
         mBuIUWc46CG+9GqzcEmahIk9gVnAz3P8Xz9xbRmC4l5CuGtv81jtrIJJ4Md4De6b2Tov
         iK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BenUmI5YlFoZ8y7dkLtbgkF8fzK7mypO7kCBy+ysHLY=;
        b=mEkHLUXQEYNWqPXdaKbf5yJQJ7EJnN08Bu9bhbW25/QU4ruxOc5mWcXzd+6Im9uDvJ
         +ilnNl6sw+9YH8DtqhCu75F7GRI7htdFyzDY7YWlildfvYQQnZvx32x65nbTqKqbRbiD
         T4DPJlsnp/zYP3bCo3mnvLey6LO3W/kG+iDMS6IiHk5jJwlLdLe8+SEeWc1r4aZIN1PC
         hHH83iHbHGOlKXvwCVStNOtH9OcIAiyIST3GVt0gSBgNgtJVepd4MoE9EnMwOd5EWfcm
         3VBSJ4gFFVJYMckhq/shQfe8fObrl/b0nAObUyLUHBzkHDPW0pEy3clXZz48K+cDdUsj
         +a1w==
X-Gm-Message-State: AOAM532Z+VHd+wkyAzpQPrZVsFeguQACbl5cr3J3RpNKcy06XHwrvCVi
        QnhRP71ej1AUsVSdt9R112c=
X-Google-Smtp-Source: ABdhPJzcaPjPiMJaEJBt+TyXfl1pat5tjEZR0q5MJYJbj2FbHBU0jDI98msQGayKRO4VWcieXH3C/w==
X-Received: by 2002:a17:907:33c2:b0:6f3:9aff:d532 with SMTP id zk2-20020a17090733c200b006f39affd532mr23226425ejb.394.1651236664201;
        Fri, 29 Apr 2022 05:51:04 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e33sm615347ejc.153.2022.04.29.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:51:03 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 1/2] dt-bindings: mtd: partitions: Document new partition-dynamic nodes
Date:   Fri, 29 Apr 2022 14:48:24 +0200
Message-Id: <20220429124825.21477-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429124825.21477-1-ansuelsmth@gmail.com>
References: <20220429124825.21477-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new partition-dynamic nodes used to provide an OF node for
partition registred at runtime by parsers. This is required for nvmem
system to declare and detect nvmem-cells.

With these special partitions, the reg / offset is not required.
The node name must be in the form of "partition name"-dynamic.
If the partition can't be displayed using the node name, it's possible
to use the label binding that will be used instead of the node name.
The node name or the label binding is used to match the partition
allocated by the parser at runtime and the parser will provide reg
and offset of the mtd.

NVMEM will use the data from the parser and provide the NVMEM cells
declared in the DTS, "connecting" the dynamic partition with a
static declaration of cells in them.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../mtd/partitions/partition-dynamic.yaml     | 56 +++++++++++++++++++
 .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
new file mode 100644
index 000000000000..e0efa58e4fac
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/partition-dynamic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dynamic Partition
+
+description: |
+  This binding describes a single flash partition that is dynamically allocated
+  by a dedicated parser that is not a fixed-partition parser.
+
+  A dynamic partition require the node ending with the "-dynamic" tag and if the
+  dynamic partition name can't be displayed using the node name, the label
+  properties can be used. The node name or the label have to match the dynamic
+  partition allocated by the parser.
+
+  These special partition definition can be used to give a dynamic partition
+  an OF node to declare NVMEM cells. An example is declaring the partition
+  label and all the NVMEM cells in it. The parser will detect the correct reg
+  and offset and the NVMEM will register the cells in it based on the data
+  extracted by the parser.
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+properties:
+  label:
+    description: The label / name for the partition assigned by the parser at
+      runtime. This is needed for sybsystem like NVMEM to define cells and
+      register with this OF node.
+
+additionalProperties: true
+
+examples:
+  - |
+    flash {
+      partitions {
+        compatible = "qcom,smem-part";
+
+        art-dynamic {
+          compatible = "nvmem-cells";
+          #address-cells = <1>;
+          #size-cells = <1>;
+          label = "0:art";
+
+          macaddr_art_0: macaddr@0 {
+            reg = <0x0 0x6>;
+          };
+
+          macaddr_art_6: macaddr@6 {
+            reg = <0x6 0x6>;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
index cf3f8c1e035d..1d7d9b3378c3 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
@@ -19,6 +19,10 @@ properties:
   compatible:
     const: qcom,smem-part
 
+patternProperties:
+  "-dynamic$":
+    $ref: "partition-dynamic.yaml#"
+
 required:
   - compatible
 
-- 
2.34.1

