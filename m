Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9024F4B253A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349801AbiBKMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:08:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348790AbiBKMIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:08:51 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3DD5A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:08:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i14so14830664wrc.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAuohS2r9a+rHBFH3yY/vSyvPnTGhT8Dt1KFd/tOWeI=;
        b=P45HGFmHAEfQUBc17dQA6o/s45i6unuZR5s340ifEwoZCHFXTa9wDuR69ZBx52vIiN
         EYl7Bt5ZOKRfiKArVUV26ZLXh5KCFYHcH0xA2ynxrxSTdCemcMgNTtMgmMLboFnPuViZ
         N7i3uIYj6QV9YHo1GDsV/eJ53JGEfGmNQ15y28AirhIdb5dljS8FcVap/P6GTYEGT0GN
         HjVT6Jucs4aZlJ2t8GnjqQKM1f8uJ/UFxEtbM2VW4LbBcJnsRXV+qwcUAospcWAmgqUW
         j9jwUjX8mjB1PdQ3xCDbXZVwGrye5JM/pPp6ovxrzHVcCweU6pliKVrtajTecIJL4W81
         t55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAuohS2r9a+rHBFH3yY/vSyvPnTGhT8Dt1KFd/tOWeI=;
        b=Ctu7EGmAaMhFYM103RDdyabQ4KolkPnoXRWqu1RABFOTeqZfYYhtdU4DcYC7RV0hxQ
         pVrHUGW8zgeHVmUfdc82Qif6HpXfnAbCw8SQa06XN1TSgFmcB9Hy07ASlR3qvVKnVYG9
         ZUzIPgcVCB+GTP5GTlEjcF1YBA3IROIxc373jpzkLBOxY/iMF2dVkz4w194ODFEMvoFR
         dp92BGk6ibRtYTc0NBL07l/lu0NP7wAvV1dLXr0JWr3OcZRrEZPL4mrLMhAtkp6IK5dP
         wI8zdRMvDl3zi+4nkuhbVW+90A5kR/7upv4ReCroFIEjqA5OpGWRTvv20qNW5UZGN6mz
         mBVQ==
X-Gm-Message-State: AOAM531fQA48DjIbo+EUSJoDKC33uhQwLcTNLlbgmr9ZpnHcwZ4RAHV0
        khewNXd4VA8auuCyi8ljKhXLcA==
X-Google-Smtp-Source: ABdhPJwVw5S0X2Qt2hPLp4zMzju9cunlPHkSEzWmDwKelbhqMeD+1GpmGTr6gaKuSABzKVvhEa1xxw==
X-Received: by 2002:a5d:6d4b:: with SMTP id k11mr1102228wri.623.1644581328100;
        Fri, 11 Feb 2022 04:08:48 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h6sm4095412wmq.26.2022.02.11.04.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 04:08:47 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     krzysztof.kozlowski@canonical.com, linus.walleij@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3] dt-bindings: mtd: drop mtd/cortina,gemini-flash.txt
Date:   Fri, 11 Feb 2022 12:08:42 +0000
Message-Id: <20220211120842.3388592-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop mtd/cortina,gemini-flash.txt since it is nearly already handled by
Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.

We add jedec-flash to list of compatible because one board (gemini-dlink-dns-313.dts) needs it.
See commit a10d862e585e ("ARM: dts: Fix the DNS-313 flash compatible")
The flash on the DNS-313 needs to be probed as JEDEC, it does not conform to the common CFI standard.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Change since v1
- fixed typo in syscon

Change since v2
- Added reason of adding jedec-flash

 .../bindings/mtd/cortina,gemini-flash.txt     | 24 -------------------
 .../devicetree/bindings/mtd/mtd-physmap.yaml  | 18 +++++++++++++-
 2 files changed, 17 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt

diff --git a/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt b/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
deleted file mode 100644
index efa5b2aba829..000000000000
--- a/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Flash device on Cortina Systems Gemini SoC
-
-This flash is regular CFI compatible (Intel or AMD extended) flash chips with
-some special bits that can be controlled by the machine's system controller.
-
-Required properties:
-- compatible : must be "cortina,gemini-flash", "cfi-flash";
-- reg : memory address for the flash chip
-- syscon : must be a phandle to the system controller
-- bank-width : width in bytes of flash interface, should be <2>
-
-For the rest of the properties, see mtd-physmap.yaml.
-
-The device tree may optionally contain sub-nodes describing partitions of the
-address space. See partition.txt for more detail.
-
-Example:
-
-flash@30000000 {
-	compatible = "cortina,gemini-flash", "cfi-flash";
-	reg = <0x30000000 0x01000000>;
-	syscon = <&syscon>;
-	bank-width = <2>;
-};
diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
index f827984936f6..82eb4e0f453b 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
@@ -44,7 +44,9 @@ properties:
               - numonyx,js28f128
               - sst,sst39vf320
               - xlnx,xps-mch-emc-2.00.a
-          - const: cfi-flash
+          - enum:
+              - cfi-flash
+              - jedec-flash
       - items:
           - enum:
               - cypress,cy7c1019dv33-10zsxi
@@ -127,6 +129,20 @@ required:
   - compatible
   - reg
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: cortina,gemini-flash
+then:
+  properties:
+    syscon:
+      $ref: /schemas/types.yaml#/definitions/phandle
+      description:
+        Phandle to the syscon controller
+  required:
+    - syscon
+
 # FIXME: A parent bus may define timing properties
 additionalProperties: true
 
-- 
2.34.1

