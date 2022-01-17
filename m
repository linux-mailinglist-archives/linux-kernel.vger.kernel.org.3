Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC62C490C48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiAQQNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiAQQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:13:31 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54559C06173F;
        Mon, 17 Jan 2022 08:13:31 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4Jcxls3bzRzQkh2;
        Mon, 17 Jan 2022 17:13:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642436007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLpQq05ojJBubdnMnqxCtN2iVnQY5tMp3JI97HMSq1o=;
        b=ElkNY3tDtG5g/CDiNellX8CP8G14hnTB/UCfUbe2O8AHe+QFbRI70ZKZfiMFTMx49TDimM
        dLJNBQR7GDeg0N05kj2XIScFqADb2n5PItC/0bJKmkmhdfd33L+hTIS48tn5M4XKdcersM
        1MHsGrLfTNhbL4kGxCpeoj+NfMxG57fnXjUYxkUhXWxirH1CO80Y5oK9S/ZTOR49yQJiGu
        jVpyMBVCreKm3/WLVsqpAf5naUQRXd0YZadpdpVVNsWRRjzrdMq0ygIYczZHgxAik2aifS
        HEdXidxp6YIWW97cFNMJBrL9S2zEVdswR+k5+Sar51WVQUM7ouCe9s5R8RbecA==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] dt-bindings: hwmon/pmbus: Add vicor,bcm6123 Bus Converter
Date:   Mon, 17 Jan 2022 17:12:48 +0100
Message-Id: <ba6346942dfed14440e0243a6da510581389fbdd.1642434222.git.sylv@sylv.io>
In-Reply-To: <cover.1642434222.git.sylv@sylv.io>
References: <cover.1642434222.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for BCM6123 Bus Converter from Vicor Corporation.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 .../bindings/hwmon/pmbus/vicor,bcm6123.yaml   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
new file mode 100644
index 000000000000..5559d22e00f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/pmbus/vicor,bcm6123.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Vicor Corporation BCM6123 Bus Converter
+
+description: |
+  The BCM6123 is an isolated Fixed-Ratio DC-DC Converter,
+  operating from a 260V to 410V primary bus to deliver an unregulated
+  ratiometric secondary voltage.
+
+  Datasheet: https://www.vicorpower.com/documents/datasheets/ds_BCM6123xD1E5135yzz.pdf
+
+properties:
+  compatible:
+    enum:
+      - vicor,bcm6123
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bcm6123@5f {
+            compatible = "vicor,bcm6123";
+            reg = <0x5f>;
+        };
+    };
-- 
2.33.1

