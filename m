Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9A518D68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbiECTtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbiECTte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:49:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975942229E;
        Tue,  3 May 2022 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651607161; x=1683143161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CP0I8+L3LjHbkmf03eJINEHNiUWKyiWgZVLpi7cVFIs=;
  b=mUvJ6UGE0BDV8588hjtqeZ1saHiQxXBk81ou+sXGRzoK7OTAnKOz8Jao
   iTCR+rgBL2/BqM3jcSl5FRZS5nzaE0g/LIElmRXvAoOTZMkgaJabIWoYV
   aMU8GQtNxFTWxEyyl5L2XBQLzu7+7KXhQPFYCbUmOZ4+MWety3PgOENf6
   0s/CATbprz6ywz9sPgd5MrUUeohU70cD1HfWgxXfMkmvL8670it5yIV06
   0AT7AhavlQKLBIc2JkmKyqARemz+ZbRZt2x+PZ+fqDlIvUbINAJX/O/Ir
   XriGj2JIcjFN942m4EY2OX6PRrmtes/KaQlFh2TVF4LZHTwVA+DcEEh9Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248114159"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248114159"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:46:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="584345938"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:45:59 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 1/3] dt-bindings: misc: add bindings for Intel HPS Copy Engine
Date:   Tue,  3 May 2022 12:45:44 -0700
Message-Id: <20220503194546.1287679-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add device tree bindings documentation for the Intel Hard
Processor System (HPS) Copy Engine.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 .../bindings/misc/intel,hps-copy-engine.yaml  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml b/Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml
new file mode 100644
index 000000000000..74e7da9002f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022, Intel Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/intel,hps-copy-engine.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel HPS Copy Engine
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
+
+description: |
+  The Intel Hard Processor System (HPS) Copy Engine is an IP block used to copy
+  a bootable image from host memory to HPS DDR.  Additionally, there is a
+  register the HPS can use to indicate the state of booting the copied image as
+  well as a keep-a-live indication to the host.
+
+properties:
+  compatible:
+    items:
+      - const: intel,hps-copy-engine
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    agilex_hps_bridges: bus@80000000 {
+        compatible = "simple-bus";
+        reg = <0x80000000 0x60000000>,
+              <0xf9000000 0x00100000>;
+        reg-names = "axi_h2f", "axi_h2f_lw";
+        #address-cells = <0x2>;
+        #size-cells = <0x1>;
+        ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
+
+        hps_cp_eng@0 {
+            compatible = "intel,hps-copy-engine";
+            reg = <0x00000000 0x00000000 0x00001000>;
+        };
+    };
-- 
2.25.1

