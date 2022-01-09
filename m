Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C377B488B40
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiAIReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:34:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:57781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234494AbiAIReU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641749652;
        bh=MOFjIoYuYz3a6U9sFm3D7hME9fb4DnPcgdo1gj/6qb0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UgEsTqhvRH8KvmhcckXGkPp+rDYVJhD9QGrA+7g/pdq+9/RbWuvrfMudOHe7YoOuw
         Bb+4MDCqfPXX+XIBwpENi1GuQQKjRRYQPwTmiFAuxhFgEn+knXd/UGwo0LVZogXznr
         C0PpxxvOdSbvFwtTXRw6ht3UMv1vs3WYnJHSWG5Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.222.244]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5iZ-1mpuAz17LR-00J23M; Sun, 09
 Jan 2022 18:34:12 +0100
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
Subject: [PATCH v4 1/9] dt-bindings: arm/npcm: Add binding for global control registers (GCR)
Date:   Sun,  9 Jan 2022 18:29:52 +0100
Message-Id: <20220109173000.1242703-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
References: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ztSF5v5bx0P0Xz5y9nkAdqjiP/XUgvvz2+IaEIneM08rrCGzSmE
 qEHgmW7GXgERLlOWZgW4M1KUjg0li5txo9Sw2Uc3RmxTAa9WCyX7prTDY0FvPFBJgQHhz1G
 BgyXVoYP57YQGB3lvXtjL4Gjo8m5X6bf4NIJ2imK/J+glygqtYITW0ja+QqywukTdgFwk2+
 y/6FVv3p90ajkeG8dJCBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WJv/i/bnJqQ=:fOkmB1Ab5nLabHDOrcF4kM
 h4VIpJqxa0sA1HAcefZlM9AphF8ODY4SbmOINH4dOQFmjv0ikv52gbPllg8J7P+Vbr3hcGgqm
 QPe5xd/6pQlNPrRBGSEYMxGLvOHmUWIzadcmRM2TN/AIuDhe5Jm9+KLdjuOIKgjP5bz2jDSXu
 YtHZCay5R1lubfNJQZx6bpVdcFmZeV9N6/6Nx9+2cONYuniaTH2093bwA7ORSzGr2w1WjK+DY
 dOxciFRhkqMy2VyF6h0NgSlwY/bEGjBPZ3dGJJT0uQ3ZHmEC0Z7ik15NaGcp9MsERnMBwnrYk
 K+vddVEPz5/cNy3GrZFjqsbHRZ/XrBha7suD3XgDDyTthIljxJ9hm0+dQB0mSh0I5u/720ED1
 qCi5NMiImddW7tEMMwZHfOHizJ7QEFbuISF4z1q3PVaSGqc0NgAX7tqDqWI3doQiFX4Kbee8Y
 kqBO8jiLuUVX486F6Z8Z/uBmz5UNxs8kzC657aeblFuWVkKyuCAzH3nZ5PIEiQo9gFXgVKRQy
 DkowIzsVODrvLx+KzPPOWZqWIrpDMjnfwfN360HNXNFZPqN5GYK4nkDXoxcTMSV9FNSMZ9La0
 x/zTjPUkhg8vweYlqypMYS4QBInFMY7RTFR/HwZ3evZUublet8UDUM717Z66FyYIo3wHA8GmS
 hUbFu2O4rACk/GrNUFLps9XcVrkNsxJ5PS2ZBqGxBwfCh8fX6SqkwgZMwxRK8UUp3PuTAVMUb
 iLVGQmyA3IgNL0lDpa1HZADpXl8pkyqAmfCiTGEMvBO6Bjysa9h5j9Wj87U2PQaN1vzt1bi3Y
 iB+0ww4D/3DjvBVcy92PqgBo0SqYr5PRMR4dYRAw8X8+BD0c18uAZlt/3rC0v8NorvF8llokc
 Lj3wczI6UQGhbqcEQ53VWo/Kb145OZtD4jo/OiJDuP6RF2zfFHsrIQfZ/pl67oMC0IhOLTTGy
 ACiu+uEiWt2ZwtEUtwWfYgR4E9MGgv1zTqjJNp/7fHZx2p0JwjISzoHoBr0LC17syp3ZIOkpX
 May/4719MhIJ5tFjyLOWnMjDgOJCoQCz1cqgsmO2Bna5KPVKKGrLHBcSpSCAXTjEweywXsjyN
 9IYJug3vro0iYc=
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
2.30.2

