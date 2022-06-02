Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAAF53B8F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiFBMY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiFBMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:24:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE795C35F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654172663; x=1685708663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RPaYs2e4VEQbh64WV+PrgBDqdrljlSQLbrEW9Z5ialk=;
  b=jWtafRd6PXKwMgMxj2HuC4Ypin3Oy0ZuKLniecakGK84oTD/9YV7h3ND
   tpsIWDUrtVIxo3WIu9mcB0ZmZxWY29mdXipNK6kLNNOFi1jETnAA7FSn7
   bJlp+EOpC0CBKzQOefkVBuvKYB8bHc/mPhjN0PiSap8jf9yAUrtssqCa2
   MXkQAs/f8s+Ikae3ij7/gNIlJZSmT+WB2TyfO04H3JZwIb48otkMPjxuv
   EAYliLkfNdx1vYrII8tIQhLmJU5sU01ppMh2Skq12x2IKTohpZfE9/5Cf
   qaYrS+M36mFYsj/BFXWahjTPgMKPC6b7eQBBMUoX1YGV54LFbwxyCf7qN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="301296203"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="301296203"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="530554494"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2022 05:24:01 -0700
From:   kah.jing.lee@intel.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 2/2] dt-bindings: misc: Add the system id binding for Altera(Intel) FPGA platform
Date:   Thu,  2 Jun 2022 20:22:47 +0800
Message-Id: <20220602122246.3021328-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

This binding is created for Altera(Intel) FPGA platform System ID soft IP.
The Altera(Intel) Sysid component is generally part of an FPGA design.
The component can be hotplugged when the FPGA is reconfigured.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 .../bindings/misc/intel,socfpga-sysid.yaml    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml b/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml
new file mode 100644
index 000000000000..470444248365
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/intel,socfpga-sysid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Sysid IP core driver
+
+maintainers:
+  - Arnd Bergmann <arnd@arndb.de>
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+description: |
+  The Altera Sysid component is generally part of an FPGA design. The
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

