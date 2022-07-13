Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E11572CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiGME4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiGME4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:56:34 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A43599C4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:56:32 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220713045631epoutp02c8231827f4b7b7d67c9fc1049d3803c6~BSqCO7_Bp2646326463epoutp02y
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:56:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220713045631epoutp02c8231827f4b7b7d67c9fc1049d3803c6~BSqCO7_Bp2646326463epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657688191;
        bh=8MPvtsaxAy1ZW6zM9O+1nQEXthz2xlrMFwuuHLkLc1s=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=K5DphKDWdVelsvlAGMVSPbEW6ZnrX0XMTJRcdd4G0fkslxGDwMbsQnwBL4LNRHESV
         329vN/fSS7rHrH0/vjXGqq/PDh8KY7qTsKbA/ackreUMltQLzM+D/y9q9RrkTgiwoH
         dxH8uXl4RTpA+Fj5y208a1IaIIYlPkh03cCjayLg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220713045630epcas1p15bba55adf5846dbde29f337c08e7d385~BSqBQ5-4h0875508755epcas1p1D;
        Wed, 13 Jul 2022 04:56:30 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LjQM15ZbPz4x9Pv; Wed, 13 Jul
        2022 04:56:29 +0000 (GMT)
X-AuditID: b6c32a35-71dff700000025b9-81-62ce507d2ace
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.FF.09657.D705EC26; Wed, 13 Jul 2022 13:56:29 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 3/4] dt-bindings: mfd: Add bindings for Samsung SysMgr
Reply-To: dj76.yang@samsung.com
Sender: Dongjin Yang <dj76.yang@samsung.com>
From:   Dongjin Yang <dj76.yang@samsung.com>
To:     "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p3>
Date:   Wed, 13 Jul 2022 13:56:28 +0900
X-CMS-MailID: 20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmrm5twLkkgxOPtSxO73/HYvHykKbF
        /CPnWC12z1jOZDFz6hlmi4XTljNaPD80i9ni5ax7bBZH3nxktrj/9Sijxf7jK5ksLu+aw2Zx
        bnGmReveI+wWdw6fZXHg97i+LsBj06pONo871/awebzfd5XNo2/LKkaPz5vkAtiism0yUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5WUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnvP7sU7BX
        sKL/7k32BsbFfF2MnBwSAiYSH76uYO9i5OIQEtjBKHH2YR9bFyMHB6+AoMTfHcIgprCAm8Tq
        8/YgppCAvMTniZUgncICOhIdb5+ygITZBLQkZvcnggwREfjMKPF422OwicwCR5glGo7MZYNY
        xSsxox2kAcSWlti+fCsjhK0h8WNZLzOELSpxc/Vbdhj7/bH5UDUiEq33zkLVCEo8+LkbKi4l
        8aj5AJRdLXGuvRdssYRAA6PEwc8bwV6RENCX2HHdGKSGV8BXYuOWL2D1LAKqEqffnmeF6HWR
        eDS5B8xmBvpx+9s5zCCtzAKaEut36UNMUZY4cosF5pOGjb/Z0dnMAnwS7772sMLEd8x7wgRh
        K0t8bn4N1SspsXjyTOYJjEqzEME8C8neWQh7FzAyr2IUSy0ozk1PLTYsMIRHbHJ+7iZGcLrV
        Mt3BOPHtB71DjEwcjIcYJTiYlUR4/5w9lSTEm5JYWZValB9fVJqTWnyI0RTo44nMUqLJ+cCE
        n1cSb2hiaWBiZmRqamhgYaIkzrtq2ulEIYH0xJLU7NTUgtQimD4mDk6pBqZSOf5J/E9O7Nku
        92TOq56Lk7Wf1JXPXKtdeVQ6VE5O5sehyXJa/gn1dhMduRNrzxZcVMow5mWu3Pcpdm5NyNsX
        R3SmL9i31GPXjO5iuxeha77NzX08KT1E5wCf9uUqyaiXFqIrFJQmX/KSk8yT1NQuCBOwTJ5+
        WvW08/+bH9fvSvV2XL18QefaqCkTrrSu2vvD4sqnfzYWr2MFesT01n+/LzW73NRps1nO3Bw9
        jbjVssluhr7WEzPvMPI4fA9dz1+w+W60/Yw/75oW8XlvTe0+sH5J3o5rV56kd1X/WJs4+9md
        vz03tycGBJ/conboRk7l03mLJgXMn8V+kHUL/9/g/jinjKw/XN9qlX9sY4pXYinOSDTUYi4q
        TgQATfB4GEAEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef
References: <CGME20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p3>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an devicetree binding for Samsung system manager.
This driver is used for SoCs produced by Samsung Foundry to provide
Samsung sysmgr API. The read/write request of sysmgr is delivered to
Samsung secure monitor call.

Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
---
 .../devicetree/bindings/mfd/samsung,sys-mgr.yaml   | 42 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml

diff --git a/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml b/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml
new file mode 100644
index 000000000000..83b9d73a5420
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/samsung,sys-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung System Manager
+
+maintainers:
+  - Jesper Nilsson <jesper.nilsson@axis.com>
+
+description: |
+  The file documents device tree bindings of Samsung system manager.
+
+properties:
+  compatible:
+    enum:
+      - samsung,sys-mgr
+      - samsung,sys-mgr-smccc
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
+
+    syscon_imem@10020000 {
+        compatible = "samsung,sys-mgr";
+        reg = <0x0 0x10020000 0x0 0x1000>;
+    };
+
+    syscon_fsys: syscon@16c20000 {
+        compatible = "samsung,sys-mgr-smccc";
+        reg = <0x0 0x16c20000 0x0 0x1000>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d173043ffb46..55cb8901ccdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1863,6 +1863,7 @@ M:	Lars Persson <lars.persson@axis.com>
 L:	linux-arm-kernel@axis.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml
+F:	Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 F:	arch/arm/boot/dts/artpec6*
 F:	arch/arm/mach-artpec
-- 
2.9.5
