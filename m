Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6C650A189
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347974AbiDUOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386657AbiDUOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:06:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCEA39B84;
        Thu, 21 Apr 2022 07:03:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 1C3841F45A46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650549768;
        bh=upYW6msBu0zF2u6pnLcQsKjvZfwL5RHWhZEN1JHHeuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3aDphx00HgHRMM99XpuDiWKgYSZSBULwsvfNrQynW6MkOP/rZKIlqJ67XLHq4HJw
         IhKxU0oe7Cyq1Tu5EtGir9KxoR+h4OYuOYlW+bRs/WIzCJYa5is4vJLZAb53K5zXTD
         FgQAs5jZg+LJO+shZ+ehqiUWPZ4eo6vRO2pVPVKK/zbn3Ym0ckCoWnPLrGGsMyjwtd
         VPRM3L3br12T4PQBAGzN48YGX10S1ZRJxwn01IpoNIwVIy9kI8VIsG1suys65YJ6bD
         YmJc7ePpl4hFsCf+ZEurVJ2RpvgJVILVnNKp7rvMPMZbQbO4A+KXuPeASJfFK2JYx7
         j3viq0Zhrh3WQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krzk@kernel.org, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add 'ltr' as deprecated vendor prefix
Date:   Thu, 21 Apr 2022 19:31:31 +0530
Message-Id: <20220421140133.354498-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421140133.354498-1-shreeya.patel@collabora.com>
References: <20220421140133.354498-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'liteon' is the correct vendor prefix for devices released by
LITE-ON Technology Corp. But one of the released device which uses
ltr216a light sensor exposes the vendor prefix name as 'ltr' through
ACPI.

Hence, add 'ltr' as a deprecated vendor prefix which would suppress the
following warning in case the compatible string used in ltrf216a driver
is "ltr,ltrf216a"

WARNING: DT compatible string vendor "ltr" appears un-documented --
check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
364: FILE: drivers/iio/light/ltrf216a.c:313:
+    { .compatible = "ltr,ltrf216a" },


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v2
  - Add vendor prefix name as per the alphabetical order.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..02f94fba03b6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -716,6 +716,9 @@ patternProperties:
     description: Loongson Technology Corporation Limited
   "^lsi,.*":
     description: LSI Corp. (LSI Logic)
+  "^ltr,.*":
+    description: LITE-ON Technology Corp.
+    deprecated: true
   "^lwn,.*":
     description: Liebherr-Werk Nenzing GmbH
   "^lxa,.*":
-- 
2.30.2

