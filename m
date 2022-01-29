Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172214A2E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbiA2L5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:57:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:60127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240332AbiA2L5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643457446;
        bh=jI07oj6ZQKZI4SXgpi5iludWDQoXodJQyaeDRlTbCts=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gJ4oIxK9rVzKDBcpkf+20Gj+/iYCpB/Atx1VVrPPCh0zNg8+2PWj3sJm0GWsDfC0F
         KnV4sUE5BSoY56q3M+Mv4OI5BuciU1dK7tA9mG6fBRhxEcpJxFALsWf+667GcXWQPb
         HbUA/HwuIonalH/7VlhxghqZZv3N7PWcHPO1LZGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1mKilj2IyP-00xwKK; Sat, 29
 Jan 2022 12:57:26 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/9] dt-bindings: arm/npcm: Add binding for global control registers (GCR)
Date:   Sat, 29 Jan 2022 12:52:20 +0100
Message-Id: <20220129115228.2257310-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:02EDbgw1aWo9wwZ2hCE2GRIiaSUQ04z/cHtTktAVudX4/RIbZry
 8loU3I8s1IpTPaA9Bdi/N54iuGnis79b6JO1dQnH72ZoUzjfR5si+pRrzmLMhBUtsY+OYiz
 fE+/yXtezAgzBT+X/TyFeB1m4BszI1ZySOZwX5p8iG70geceiobxhDsOTbze9uyJE5NZ/ca
 ZRI6toxGGQzhcBTM6Rs7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jPAjAyxpmtE=:eOzq2mUyQpGbvQ6lsLzcMV
 Qaa4Bna/j9J78/ULZoZTWi5CrIkp2i9V3O3JH2M6irxclEQImaFTYmrG68xSfJ35n5qCCyf0K
 zFhlsMTj3Jm0g2eGMcOLDZjWlTjDcqqQTKdvcxRn+fXfVJDWg1t8DHt1eU8RdDoLdqAflPcvS
 RSjlHyguKQrgqx20iicgt7UYScyToCsJozDXN38mwAvzR73e7Tc5cxbqQL60aK3TmEEmxLVHQ
 PNYHYUuBdT1AbBznXVBy2bUljS7M0l+i23huysvcLGE9RACiC6McclQVd7Jfb6BFC08lMUhU1
 mfSW/6bg6oyOr5MvbFCP8nauTEj+nhISe3BedaiwMDbse16zKdZen1JHPYZYq3BfLqMIjculO
 8jIcwER5gVr36xgJkDw1CjUfZfWiZL0TijtHilxK3tkJ2rjre1QrUa34V8Hk1+WE465OoNYQG
 UVEiH3BiWqX2e01AQWTLnzTJAGgdPiZFyJZinnFztwR7Uk/iYb5hAytY5mmu6okSavEufTx2W
 D3r7fmXL1amkYndQFeNQwCw8/92NeT/rZihpLZteCnbEbD0Onb5HNnuscT/OU7meVbrQC7Z41
 vg/6iM+aq9SpVo5ItL34RkosFyTeaaKsEZLyq6jnLuxUcRYExbRZzsaCsc3dccxP0XEeE4nvq
 9elrmI/kyOdfDBj1urT3rVVe9L57pA7c0OD4qW9vXZRkKY0n6ot0kxCF5guZIaIMDmNoffNFt
 U9ZPPYnx1kquCzjLz4yzQ9deXkkF0nOvzybumJ3Df5I8gl3+YbSUuYLEIvci7UCmECvQLaXMR
 RH9gFC1QrHygDi2dH33bxoZjITRV+4uUnvmpNzm3/Cq0xB2JxHt0g/b/1KFFEhnkwgn72/3e0
 +CSknAqVrqvP9QK5K+3glj/s/rC98EM9xSXsU2hu8jNFSotVY0bxK/oz0CS7BV9AGe4LsjQHa
 RdQs5rJemIIG1C0Hd7ErsGSKwNlJs6jYiw7TF1yabOaboEND/CJu06xVgkdxLvp5sbv1PGxQ4
 4VSWon1mnW0yHeSdoWnjHoMdoHsXb0LqdCvRfgjRmFWejQsbWBufK3FhyVNU1yzFKDhHNHPnJ
 uh/V+v0ids5Qw4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A nuvoton,*-gcr node is present in nuvoton-common-npcm7xx.dtsi and will
be added to nuvoton-wpcm450.dtsi. It is necessary for the NPCM7xx and
WPCM450 pinctrl drivers, and may later be used to retrieve SoC model and
version information.

This patch adds a binding to describe this node.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Rob Herring <robh@kernel.org>

=2D--
v5:
- no changes

v4:
- Add Rob's R-b

v3:
- Make a few changes suggested by Rob Herring
- Change name of mux-controller node to appease the linter

v2:
- https://lore.kernel.org/lkml/20211207210823.1975632-2-j.neuschaefer@gmx.=
net/
- Rename node in example to syscon@800000
- Add subnode to example

v1:
- https://lore.kernel.org/lkml/20210602120329.2444672-2-j.neuschaefer@gmx.=
net/
=2D--
 .../bindings/arm/npcm/nuvoton,gcr.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr=
.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml b=
/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
new file mode 100644
index 0000000000000..fcb211add7d37
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gcr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Global Control Registers block in Nuvoton SoCs
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+description:
+  The Global Control Registers (GCR) are a block of registers in Nuvoton =
SoCs
+  that expose misc functionality such as chip model and version informati=
on or
+  pinmux settings.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,wpcm450-gcr
+          - nuvoton,npcm750-gcr
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    gcr: syscon@800000 {
+      compatible =3D "nuvoton,npcm750-gcr", "syscon", "simple-mfd";
+      reg =3D <0x800000 0x1000>;
+
+      mux-controller {
+        compatible =3D "mmio-mux";
+        #mux-control-cells =3D <1>;
+        mux-reg-masks =3D <0x38 0x07>;
+        idle-states =3D <2>;
+      };
+    };
=2D-
2.34.1

