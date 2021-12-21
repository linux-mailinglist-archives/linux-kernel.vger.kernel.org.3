Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D447C56D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhLURus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:50:48 -0500
Received: from aposti.net ([89.234.176.197]:39338 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240647AbhLURuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:50:46 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce common properties
Date:   Tue, 21 Dec 2021 17:50:28 +0000
Message-Id: <20211221175029.144906-2-paul@crapouillou.net>
In-Reply-To: <20211221175029.144906-1-paul@crapouillou.net>
References: <20211221175029.144906-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a file for common properties of hwmon sensors.

As of now it contains only the "label" property, which can contain a
descriptive label that allows to uniquely identify a device within the
system.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/hwmon/common.yaml     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/common.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/common.yaml b/Documentation/devicetree/bindings/hwmon/common.yaml
new file mode 100644
index 000000000000..997f74127d8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/common.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for hwmon sensors
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+  - Guenter Roeck <linux@roeck-us.net>
+
+description: |
+  This document defines device tree properties common to several hwmon
+  sensors. It doesn't constitue a device tree binding specification by itself but
+  is meant to be referenced by device tree bindings.
+
+  When referenced from sensor tree bindings the properties defined in this
+  document are defined as follows. The sensor tree bindings are responsible for
+  defining whether each property is required or optional.
+
+properties:
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: >
+      Descriptive label that allows to uniquely identify a device within
+      the system.
+
+additionalProperties: true
+
+...
-- 
2.34.1

