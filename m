Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756D6572CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiGMEyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiGMEyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:54:05 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29FF11A27
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:54:03 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220713045359epoutp0439b5365ef09f709dea9b3265922c93ad~BSn0_y3mT0411104111epoutp04Q
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:53:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220713045359epoutp0439b5365ef09f709dea9b3265922c93ad~BSn0_y3mT0411104111epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657688039;
        bh=tPsEacl3T9QwI1DRgqlseU8fnaZER9fU2P3/wRUgcVA=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=OzPBoxM7Hw5Td72jLCBmfZoiAC46YcePrvtDJ71EJezsfOoolrojeBIFDUafnScSc
         qfrztmVk8dlUPRFxp+FwyK36BDt9dcSqMFQf94YRFWqHQFqsyq+97XO17fyUmzTeO6
         sIphvHuIhYMtZBVr/gEMx5JsDYyjK+EkogKde5SE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220713045359epcas1p4ae1158164221a0fbac6db4c990fa947e~BSn0f3-N73062830628epcas1p4p;
        Wed, 13 Jul 2022 04:53:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LjQJ63t6Gz4x9Q5; Wed, 13 Jul
        2022 04:53:58 +0000 (GMT)
X-AuditID: b6c32a38-5adff700000027db-d4-62ce4fe67129
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.05.10203.6EF4EC26; Wed, 13 Jul 2022 13:53:58 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 1/4] dt-bindings: firmware: Add bindings for Samsung smc
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
Message-ID: <20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71@epcms1p8>
Date:   Wed, 13 Jul 2022 13:53:57 +0900
X-CMS-MailID: 20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmge4z/3NJBls7ZC1O73/HYvHykKbF
        /CPnWC12z1jOZDFz6hlmi4XTljNaPD80i9ni5ax7bBZH3nxktrj/9Sijxf7jK5ksLu+aw2Zx
        bnGmReveI+wWdw6fZXHg97i+LsBj06pONo871/awebzfd5XNo2/LKkaPz5vkAtiism0yUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5WUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnTH9bW7BD
        oGLl/SeMDYz3eLsYOTkkBEwk1k1pZuxi5OIQEtjBKLF9wlWmLkYODl4BQYm/O4RBaoQFPCT6
        V/exgISFBOQlPk+shAjrSHS8fQoWZhPQkpjdnwgyRUTgM6PE422P2UEcZoEjzBINR+ayQezi
        lZjRDtIAYktLbF++lRHC1pD4sayXGcIWlbi5+i07jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5J4
        1HwAyq6WONfeC7ZYQqCBUeLg541sINdJCOhL7LhuDFLDK+ArMf3yerA5LAKqEvM/nYC6x0Vi
        z9v5YHcyA/24/e0cZpBWZgFNifW79CGmKEscucUC80nDxt/s6GxmAT6Jd197WGHiO+Y9YYKw
        lSU+N7+G6pWUWDx5JvMERqVZiHCehWTvLIS9CxiZVzGKpRYU56anFhsWmMBjNjk/dxMjOOFq
        WexgnPv2g94hRiYOxkOMEhzMSiK8f86eShLiTUmsrEotyo8vKs1JLT7EaAr08URmKdHkfGDK
        zyuJNzSxNDAxMzI1NTSwMFES5+2dejpRSCA9sSQ1OzW1ILUIpo+Jg1OqgamdP9vZ/LmLeNjF
        oCXfAl+nOn9wFzA7EVFeVXXXN+z/UfmYXWu5zsxXUVW+UWw9aaXAs3fb3eYFTf0RtnPuU/PN
        91WUkp4vfR7idSpGX/mR7wLvKQeF3/i3xNyXKj+/q7vxnpZO3vc1r19t8OG7O7v5U9f5y7fS
        U5cyrVsdWHf+5HH99/f2qEVdjLsx9XvDj/Pmv+p/yFlJZMqtvfxyXcY+o/WOn65Ofsl+Ian/
        +ZTVtys3pf84dOqrcfXGYjWtgCffteT27OVk9o1Tdt3vd/m7zDv+E3JZbJH3hY+e7UgVS394
        5/SENf1/Ys5x3lV6XPO4aAm7av8j8dDqiMQ1kpkq9jcl02IUtLa1/wiqmWClxFKckWioxVxU
        nAgA/1Bu1UEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71
References: <CGME20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71@epcms1p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an devicetree bindings for Samsung secure monitor call service.
This driver is used for SoCs produced by Samsung Foundry to provide
SMC call. This patch supports register read/write request to secure
monitor. Also, SMC call request which uses shared memory to exchange
the data between kernel and secure monitor.

Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
---
 .../bindings/firmware/samsung,smccc-svc.yaml       | 31 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml

diff --git a/Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml b/Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml
new file mode 100644
index 000000000000..427c42a6cd75
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/samsung,smccc-svc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Secure Monitor call service
+
+maintainers:
+  - Jesper Nilsson <jesper.nilsson@axis.com>
+
+description: |
+  The file documents device tree bindings of Samsung secure monitor
+  call service.
+
+properties:
+  compatible:
+    const: samsung,smccc-svc
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+
+    samsung-svc {
+        compatible = "samsung,smccc-svc";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 20133dcd8ce9..6763746c349f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1862,6 +1862,7 @@ M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>
 L:	linux-arm-kernel@axis.com
 S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 F:	arch/arm/boot/dts/artpec6*
 F:	arch/arm/mach-artpec
-- 
2.9.5
