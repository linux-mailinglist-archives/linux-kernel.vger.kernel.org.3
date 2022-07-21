Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C857CAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiGUMc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUMcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:32:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3AA6173C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658406774; x=1689942774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8sKkrl0mKQraN12jKx8DZsTPCIjkH/bm4bE5zt6c6OA=;
  b=Oc/E2RmYxMbIVomUVKpfqFykSfQTTsAAWsqOOSp8+Kd1dy5l+fbiEWZt
   UJQZK9nlMBHGc7aO+gZOCJK38ggqUrFgHhF7EODxvzBqAe4flKnVMCeLH
   0MTRlBpw8aWH4jRx8nvWzmKzaFGyDJuLAWidnbbFBAdkajXVEHQ+6MFUg
   dX3Zj/IuU7VUoJLwoCOUBVMpr/0705JMcL7vsFTsvEIrp+EqTPhEMC881
   Ag5B/2dzcTmaTzAi/TIJSbrjNaxaoJ/znzzRgYGHFA725GNRaMfCQM8T2
   CqWKWcy4PHt5wNfwohqI1hD0Led/UlZd1JBWefhUS5i5cmgrgFyMeBNaA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="312743591"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="312743591"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 05:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="573720719"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2022 05:32:51 -0700
From:   kah.jing.lee@intel.com
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>,
        Zhou Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 2/3] dt-bindings: misc: intel_sysid: Add the system id binding for Altera(Intel) FPGA platform
Date:   Thu, 21 Jul 2022 20:32:17 +0800
Message-Id: <20220721123216.416696-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721123017.416438-1-kah.jing.lee@intel.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 .../bindings/misc/intel,socfpga-sysid.yaml    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml b/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml
new file mode 100644
index 000000000000..055f4cb305ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml
@@ -0,0 +1,41 @@
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
+  - Arnd Bergmann <arnd@arndb.de>
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

