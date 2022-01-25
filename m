Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A749449A87C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319032AbiAYDHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:07:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:21854 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3419781AbiAYCUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643077234; x=1674613234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ZXypthltIN0M4U9ONm8JDamYC9OeGyQdWqMLAif9aQ=;
  b=n+2RRYZ0NByJPR0eHLM7U3q52oIJ23cJpYC+aHuJnaJyvwW4+57K6vfH
   9hcq99ywW2uQbbZOMAk9X7FIAJcDmzOYtym1KYcLZN2++/L9jdo95W4wB
   /DuTtUN5Xv2VFdyOabjFLrCL4T72fe2JRSDDzC2D6jMLtKybn7/4+uDc9
   d8z5uXI4CAJrYcWS5ZAjoP2q7QnfkuzEUp4hdmpn5iUtMSGq5b9G8UPvk
   72xgG45F4NcwCe83j/tV8/G5BMwIGhY19vBf/F7Fxfc9MkL4ZX1MZzWxZ
   dMvxYKotN2H3FCNsZith9bPqz9lmpeXX1qf7PU5twruOdlQDnnRSpHekk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226168064"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="226168064"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:12:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="695633494"
Received: from kerguder-mobl.ger.corp.intel.com (HELO localhost) ([10.249.158.133])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:12:22 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v6 02/13] dt-bindings: Add bindings for peci-aspeed
Date:   Tue, 25 Jan 2022 02:10:53 +0100
Message-Id: <20220125011104.2480133-3-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125011104.2480133-1-iwona.winiarska@intel.com>
References: <20220125011104.2480133-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the peci-aspeed controller driver.

Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/peci/peci-aspeed.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.yaml

diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.yaml b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
new file mode 100644
index 000000000000..1e68a801a92a
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/peci/peci-aspeed.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed PECI Bus Device Tree Bindings
+
+maintainers:
+  - Iwona Winiarska <iwona.winiarska@intel.com>
+  - Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+
+allOf:
+  - $ref: peci-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-peci
+      - aspeed,ast2500-peci
+      - aspeed,ast2600-peci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Clock source for PECI controller. Should reference the external
+      oscillator clock.
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  cmd-timeout-ms:
+    minimum: 1
+    maximum: 1000
+    default: 1000
+
+  clock-frequency:
+    description:
+      The desired operation frequency of PECI controller in Hz.
+    minimum: 2000
+    maximum: 2000000
+    default: 1000000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+    peci-controller@1e78b000 {
+      compatible = "aspeed,ast2600-peci";
+      reg = <0x1e78b000 0x100>;
+      interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
+      resets = <&syscon ASPEED_RESET_PECI>;
+      cmd-timeout-ms = <1000>;
+      clock-frequency = <1000000>;
+    };
+...
-- 
2.31.1

