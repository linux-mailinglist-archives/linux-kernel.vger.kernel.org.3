Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC346C64C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhLGVM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:12:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:41853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241620AbhLGVM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638911326;
        bh=ucTTqYfqrAIEEQUOAqIQuTU4lLZGs0Rtoae2Ggs56Lk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JMxB8wxG8C8TyjLgWq12CJQRzhzbOn2CbRMLngVQ5T8LFHWpTO+dYH6M30ZHNejGj
         mXmUQTZLQd12/0pIJEiQtAk94jqUVZAdmUadPmMp7sM0ZQlXyswZVDmdI4baHwuvsP
         KFMe/32VdpZ4b7JrIT7xDQr/J9Db3OmzT9dQYrsY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1nGNHb1yxV-00MIU3; Tue, 07
 Dec 2021 22:08:46 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: [PATCH v2 1/8] dt-bindings: arm/npcm: Add binding for global control registers (GCR)
Date:   Tue,  7 Dec 2021 22:08:16 +0100
Message-Id: <20211207210823.1975632-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5z6fEwkITtvUUGanwwbUAU9wniS3Wxx/3lxzUrIulEn2I63yJtD
 2ZJaoUkFgy/5lelXXUnnsIeIHi4tAIEojSrz6nzdNhILkTKHXJu6zGm31w/lk2gfZfIlHhj
 e2brlbpU+yQqnd6seeDz8jx/m5Lz8NcDzo5HEayRqFXGGof3x+eAq1CdqtzNKsdBetFbDRN
 87M0qpknnQsCbuVPCN2mA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BdxySlRDLD8=:YMshSa6kD+dYBdTNnTBAsk
 UeMhi1NiJHp6Yf88bupwAc+LxGKIiR8SoJeN2oFWYnisPRBrOyUzb+GpnZaJWsmhMZc4rSrdw
 nPkL1FL7e7Bn+1AAOtFlHkH6cFq5W1ZXPbiI3sSSBkuiBlGteJOR1QcU7AJb19XgPyRakjaS1
 z+K0Uovf7uoH2iH2VBkg2BAGx4q1l1U+uw6/HhpzYJhxIRhtdbnKWhMaW85yR14ZHMwRKpHlI
 WFriqjcrbVoECGnCyNko/A2eeNczLraAEq8WMIJc0uF13Bl+/H5TKMnJHvlSsxXzwLj6tpDZP
 sXcf9OfOV+0uutcyyPkp4lGGys7AJtlevK+UtXESDebc2tXH0LQ73DkaUb3nnP9juzBPzC1DV
 bn2KUyFdrSFPTptnZg/o72xUlmlCymSt+6XJYTKXvhDlj+sVpOrubweaToQRYC1fcY0Yld2Xu
 qj2wm/E1gGo7Qo07UimbL4tc7DFwLk7oRYQjugdLzRoj+DY6a4QXwGxK8J/TlfmuXlc53kDFW
 ltOpJez/x12B/0/nuU1qwEA5innGtu9XS/TyweFA1lCpiEIJdetkm7O5GDN00QXQDIrEXE3IZ
 CLPzrYArvaKTLt2TVU+eVQm5Fd/1HyoTF2WMtlMvThxn70ur1+BapfrDgWCF0KPrs/Dl7HMu4
 8gcZcyuVvoRR9W6W1Wgx+HiLus/S3y1OyHrbBalrosvchez6fq4Kjk2YhrgUs0nVpNbK2RxxY
 ZBT6W7yzQc37NFVkTM9M56GNqMn6c4O2DcmcX/WxtlntLUkAQHuAD0Wg4rJSOGR3n/DjefVEY
 j65Wp6/sA81mRBsuUzBzIQpGcH4izDHl4paY3NzzDHaUYug/cXEKyrwqoVlGpTTEXeE7ySHyd
 UvFHhoojM3QODJHL8XwAXnRcTPk4/Z7wgbJHy0mV6Y6+5U6MSjt96i5fMJMyNvF768/5ZEplc
 47Tsu8OoYr8/w+FE2FMStNOJvbgm3LMTzc1wdOUVsVAG2QgrsbJFNMHSlVFW1sz7QhATlPurb
 6O/9FPAAS7RKtR49U1oPeFq3FAt7k+qWaGbqRkCHcHJqwojWlXJZKaNgO+1P4SknsmqcJn1TJ
 h96n/2qkTawnWI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A nuvoton,*-gcr node is present in nuvoton-common-npcm7xx.dtsi and will
be added to nuvoton-wpcm450.dtsi. It is necessary for the NPCM7xx and
WPCM450 pinctrl drivers, and may later be used to retrieve SoC model and
version information.

This patch adds a binding to describe this node.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

=2D--
v2:
- Rename node in example to syscon@800000
- Add subnode to example

v1:
- https://lore.kernel.org/lkml/20210602120329.2444672-2-j.neuschaefer@gmx.=
net/
=2D--
 .../bindings/arm/npcm/nuvoton,gcr.yaml        | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr=
.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml b=
/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
new file mode 100644
index 0000000000000..62020d7ac305b
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
@@ -0,0 +1,45 @@
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
+description: |
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
+  reg: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    gcr: syscon@800000 {
+      compatible =3D "nuvoton,npcm750-gcr", "syscon", "simple-mfd";
+      reg =3D <0x800000 0x1000>;
+
+      uart-mux-controller {
+        compatible =3D "mmio-mux";
+        #mux-control-cells =3D <1>;
+        mux-reg-masks =3D <0x38 0x07>;
+        idle-states =3D <2>;
+      };
+    };
=2D-
2.30.2

