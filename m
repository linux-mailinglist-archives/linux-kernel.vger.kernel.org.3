Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4001857F88B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 05:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiGYD6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 23:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGYD6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 23:58:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88095E011
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658721527; x=1690257527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+EnxZIrQhRnh7vJ9vI6LHqK+QN4zze69LzQQrEUVBI=;
  b=cNwvGR9AazG+Q6L5HdeQJuMR5jssV9sxXLtIr+Hiy0KgPbgtiHH5ysOv
   8dflYpnka8ZDGa0y7b06Uxd3p/xdNLZ31s7emdKtOLRgdkNPngs46VyuE
   4MOFWzs0wmYzEYBrc6Nfir/ESTc0vfrfFLMN4bo3rfnc3jMozJ0hJbuzN
   68AfD10kWEFMTsPWa5rPGvr3U+Op4ZHg16DDL5NFXxhyy/mfYBvpUofbI
   YmVNqeZEM5pBt3Uzvvzb7d8BRqwSyPOIsLJLxqXAT6lQ3iIPkAnL86mQN
   jS9nI+8VxJ6+STGXDF8jcGDlTlRyLm+4YWxl69KdomSxdV6VmT3ogLXCp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="274466632"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="274466632"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 20:58:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="574882677"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2022 20:58:44 -0700
From:   kah.jing.lee@intel.com
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>,
        Zhou Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 2/3] dt-bindings: misc: intel_sysid: Add the system id binding for Altera(Intel) FPGA platform
Date:   Mon, 25 Jul 2022 11:56:52 +0800
Message-Id: <20220725035650.648838-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721123216.416696-1-kah.jing.lee@intel.com>
References: <20220721123216.416696-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

This binding is created for Altera(Intel) FPGA platform System ID soft IP.
The Altera(Intel) Sysid component is generally part of an FPGA design.
The component can be hotplugged when the FPGA is reconfigured.

Based on an initial contribution from Ley Foon Tan at Altera
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
Reviewed-by: Zhou Furong <furong.zhou@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
v2->v3:
- Updated maintainer
---
---
 .../bindings/misc/intel,socfpga-sysid.yaml    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml b/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml
new file mode 100644
index 000000000000..7426cbe4462b
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022, Intel Corporation.
+# Copyright (C) 2013-2015, Altera Corporation.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/intel,socfpga-sysid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera(Intel) Sysid IP core driver
+
+maintainers:
+  - Kah Jing Lee <kah.jing.lee@intel.com>
+
+description: |
+  The Altera(Intel) Sysid component is generally part of an FPGA design. The
+  component can be hotplugged when the FPGA is reconfigured.  This patch
+  fixes the driver to support the component being hotplugged.
+
+properties:
+  compatible:
+    items:
+      - const: intel,socfpga-sysid-1.0
+
+  reg:
+    items:
+      - description: physical address and length of the registers which
+          contain revision and debug features
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    sysid_qsys: sysid@10000 {
+        compatible = "intel,socfpga-sysid-1.0";
+        reg = < 0x10000 0x00000008 >;
+    };
-- 
2.25.1

