Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4052EE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350347AbiETOcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350313AbiETOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:32:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564B15AA54;
        Fri, 20 May 2022 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653057134; x=1684593134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0U51dIDeKS9iJa8qsaG7KUn90eS3J81yP2z2SUNTgg=;
  b=IRh8RbE3rJIvSAKHkuuiR78CduiTvScKV2rZpQ7ELnY+DNu5QHxDJKC7
   LGeqRvwWaZfBfRaiFS1lQLnSwRGTv+hIQ00dfXug8SbIujwfU9hHE5Zcx
   yeMTh6R8vo3YhxFMAFASdlhAjngTeJ/VcVWK2s2pnG7sZs7ehye7Kmuh9
   slC+H6EhZjdShIWTKicO+97iTEwykhF8TxfvfEIAB6kbJUpL94ePzF/f4
   dF0ISlJZISd2fcJq1/BpOIydn5BzGN7cOB0eRrySChz3Aq4vvf82cozYA
   VuxiIuA0XWcwzsfmEopD2MgP/BbIny6YeZ2Gpvim5henBv41PE1dYb02T
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="271439339"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="271439339"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:32:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="662286644"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:32:10 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/3] dt-bindings: soc: add bindings for Intel HPS Copy Engine
Date:   Fri, 20 May 2022 07:32:06 -0700
Message-Id: <20220520143208.1160506-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520143208.1160506-1-matthew.gerlach@linux.intel.com>
References: <20220520143208.1160506-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v6:
  - move from soc/intel to the dma directory
  - remove unnecessary parent device tree node from example

v5:
  - add Reviewed-by: Krzysztof Kozlowski

v4:
  - move from soc to soc/intel/

v3:
  - remove unused label
  - move from misc to soc
  - remove 0x from #address-cells/#size-cells values
  - change hps_cp_eng@0 to dma-controller@0
  - remote inaccurate 'items:' tag
---
 .../bindings/dma/intel,hps-copy-engine.yaml   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,hps-copy-engine.yaml

diff --git a/Documentation/devicetree/bindings/dma/intel,hps-copy-engine.yaml b/Documentation/devicetree/bindings/dma/intel,hps-copy-engine.yaml
new file mode 100644
index 000000000000..6332305db1de
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/intel,hps-copy-engine.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022, Intel Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/dma/intel,hps-copy-engine.yaml#"
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
+    const: intel,hps-copy-engine
+
+  '#dma-cells':
+    const: 1
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
+    dma-controller@0 {
+        compatible = "intel,hps-copy-engine";
+        reg = <0x00000000 0x00001000>;
+        #dma-cells = <1>;
+    };
-- 
2.25.1

