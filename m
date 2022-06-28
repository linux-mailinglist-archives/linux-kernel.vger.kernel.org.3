Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9355DFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345509AbiF1L2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbiF1L2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:28:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3DAF4D;
        Tue, 28 Jun 2022 04:28:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o10so17138236edi.1;
        Tue, 28 Jun 2022 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+LlLZaDtYyevN2FUYLTzNmH0PwKbstBSDwmDMRaV6wQ=;
        b=n7pPSVPiiSJ1+gdboLLhYJ9f2hGhbzZRAJmZl5PEMUU87GpbDbIYORHNkubL6j125d
         U3G7vvwWc2C/l5ESEfNezHayvDrhVYJPeLDQPmHXW+nXcyqAGxVu4bEwZYSHgzynMaIg
         14hWsOCnf5YzkJE14RXt1lbyHOdu1yL0j4UtR90OXZj2wlpf8IIzBzcwVCXV0n2SqQJw
         ltnorUr4yOgaKyq1iTwP6B3n2r3Z285MWTN0W+q8iP46pBZnXLuKyRHqt88VjYRc2q1B
         5bE8LpsiIAXZAxIGYz+IVVuijgojfzTFg7gpPmURZO1JjWnKCsBbBlAFx6MuqC2eRuFm
         BCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LlLZaDtYyevN2FUYLTzNmH0PwKbstBSDwmDMRaV6wQ=;
        b=j7B8TLABJx5ApwRiKTmS2TU53MdTaScqFooxoOp9EMKiAG8tPqNGpzHFdOBz8syEiU
         QOX2/8hcGYGpyvcYC24p7PXUKsiHgGlCUzzOrUoI0Qs6MmkDp9AXQBkJ+cB3YNaOYilp
         pOdavDmFKgBI4XyyjhPNw2mCmqSG1sjBhVknXn0hAerJaxa+lLOas0k3C5MMR0Gixaxd
         d+iQ/PMap7G+NnerKV9B5feCayQGm1t3qRzeFSIWHN0GZ/Abt7lcviMVTQ5yU8AvO2/r
         HtXHHtx6e5yo7d65ztBxq7fGxy/5BfuQuq3bwenqdaaZRm3qY83teaaxgjSREJCtWQcn
         VARw==
X-Gm-Message-State: AJIora8Fb1puJZq8OYtjU+B/Rv+0r/0pcZ6jiQCsWnRz9TfMo4eux/Tl
        Jzicp6prL0SXiOcH//moIvg=
X-Google-Smtp-Source: AGRyM1uhgE91nhjR/KZn+mG1jgfNS2BuoAiTS53aWpUhL4EPUwgHNPi54ElTY6ldhaT1A4HEavdEdQ==
X-Received: by 2002:aa7:d709:0:b0:435:6ae6:5fb8 with SMTP id t9-20020aa7d709000000b004356ae65fb8mr21875688edq.161.1656415688197;
        Tue, 28 Jun 2022 04:28:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm9456318edw.20.2022.06.28.04.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:28:07 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 1/8] dt-bindings: mtd: intel: lgm-nand: Fix compatible string
Date:   Tue, 28 Jun 2022 13:27:24 +0200
Message-Id: <20220628112731.2041976-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
References: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
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

The driver which was added at the same time as the dt-bindings uses the
compatible string "intel,lgm-ebunand". Use the same compatible string
also in the dt-bindings.

Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
index 30e0c66ab0eb..763ee3e1faf3 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mtd/intel,lgm-nand.yaml#
+$id: http://devicetree.org/schemas/mtd/intel,lgm-ebunand.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel LGM SoC NAND Controller Device Tree Bindings
@@ -14,7 +14,7 @@ maintainers:
 
 properties:
   compatible:
-    const: intel,lgm-nand
+    const: intel,lgm-ebunand
 
   reg:
     maxItems: 6
@@ -75,7 +75,7 @@ additionalProperties: false
 examples:
   - |
     nand-controller@e0f00000 {
-      compatible = "intel,lgm-nand";
+      compatible = "intel,lgm-ebunand";
       reg = <0xe0f00000 0x100>,
             <0xe1000000 0x300>,
             <0xe1400000 0x8000>,
-- 
2.36.1

