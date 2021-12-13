Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C84472C81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhLMMmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:42:31 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:64516 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbhLMMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1639399340; x=1641991340;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NGlq9XGhNk/6Qyl8diek/rJVEG81o+VT/IU9qxD7V/k=;
        b=GR6YuyOU4dhZlhjeJPpiKVANXmMYetZyHSyBLDLV7TW1pNIQNA6LUcw3yOutMH3y
        QaflWZuJ+H/yDMob7N5LDOr2SJuekEKlRuot1KwK+KacZC7VQEK/IaIXdOoQaqhu
        nfZht+abM3aF/CAqrJAszCkpTbZ/9Xk4+ftJJMHcbrU=;
X-AuditID: c39127d2-4f7337000000426a-43-61b73fab2ca6
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A9.E3.17002.BAF37B16; Mon, 13 Dec 2021 13:42:19 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021121313421971-2360043 ;
          Mon, 13 Dec 2021 13:42:19 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx6qdl: phycore-som: Add custom volt/freq table
Date:   Mon, 13 Dec 2021 13:42:19 +0100
Message-Id: <20211213124219.3065974-2-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213124219.3065974-1-y.bas@phytec.de>
References: <20211213124219.3065974-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.12.2021 13:42:19,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.12.2021 13:42:19
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWyRoCBS3eN/fZEgztCFvOPnGO1eHjV32LT
        42usFpd3zWGzaN17hN3i7/ZNLBYvtog7sHvsnHWX3WPTqk42j81L6j36/xp4fN4kF8AaxWWT
        kpqTWZZapG+XwJXR8uMre8Fh9YpZx+azNDA+U+hi5OSQEDCRmLttN2MXIxeHkMBWRonVL9ez
        QjgXGCUe3eplBKliE1CUOH/7LVCCg0NEIF7ixRt3kDCzQJTEh1+r2EDCwgL+Eu3fTUDCLAKq
        Ejffr2AFsXkFzCS2HbjFDLFLXmLmpe/sIDangLnEjqY3YNOFgGp+d3xnhKgXlDg58wkLyAkS
        AlcYJQ5MfA3VLCRxevFZZoi92hLLFr5mnsAoMAtJzywkqQWMTKsYhXIzk7NTizKz9QoyKktS
        k/VSUjcxAoP38ET1SzsY++Z4HGJk4mA8xCjBwawkwvvSemuiEG9KYmVValF+fFFpTmrxIUZp
        DhYlcd77PUyJQgLpiSWp2ampBalFMFkmDk6pBsbIud8/HdToVtJ+kKQza8JT3terrdpsHz67
        0i8pMjXkvZrtQaui1r1W20NcLneGvgh0if275MeKiJV1Z4+eW+rXNj+ncN6WhtJJnHmO75ql
        pFbv3RaTIRWtca3188fuVo/+1aE7UqoWMPexzeyT+y/YEWW7PMzo7s/f859K3XjSt27N2dPn
        dMqVWIozEg21mIuKEwF3dMEPTAIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHYTEC phyCORE-i.MX6QDL SOM-modules are operating with a slightly
different voltage and frequency values in contrast to the generic
i.MX6Q/DL tables. The values have been adjusted to achieve the most
stable condition for the PHYTEC-modules. Introduce imx6q- and
imx6dl-phycore dtsi files with the modified power tables.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 .../boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |  2 +-
 .../boot/dts/imx6dl-phytec-phycore-som.dtsi   | 25 ++++++
 .../boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |  2 +-
 .../boot/dts/imx6q-phytec-mira-rdk-nand.dts   |  2 +-
 .../boot/dts/imx6q-phytec-phycore-som.dtsi    | 83 +++++++++++++++++++
 5 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-phytec-phycore-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-phycore-som.dtsi

diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/b=
oot/dts/imx6dl-phytec-mira-rdk-nand.dts
index d906a7f05aaa..8ec27080ca1e 100644
--- a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
@@ -6,7 +6,7 @@
=20
 /dts-v1/;
 #include "imx6dl.dtsi"
-#include "imx6qdl-phytec-phycore-som.dtsi"
+#include "imx6dl-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
 #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
diff --git a/arch/arm/boot/dts/imx6dl-phytec-phycore-som.dtsi b/arch/arm/bo=
ot/dts/imx6dl-phytec-phycore-som.dtsi
new file mode 100644
index 000000000000..0985453b5ad6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-phytec-phycore-som.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2021 PHYTEC Messtechnik GmbH
+ * Author: Yunus Bas <y.bas@phytec.de>
+ */
+
+#include "imx6qdl-phytec-phycore-som.dtsi"
+
+&cpu0 {
+	operating-points =3D <
+		/* kHz    uV */
+		996000  1275000
+		792000  1175000
+		396000  1150000
+	>;
+};
+
+&cpu1 {
+	operating-points =3D <
+		/* kHz    uV */
+		996000  1275000
+		792000  1175000
+		396000  1150000
+	>;
+};
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/bo=
ot/dts/imx6q-phytec-mira-rdk-emmc.dts
index 322f071d972f..7d947762f3b9 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
@@ -6,7 +6,7 @@
=20
 /dts-v1/;
 #include "imx6q.dtsi"
-#include "imx6qdl-phytec-phycore-som.dtsi"
+#include "imx6q-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
 #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/bo=
ot/dts/imx6q-phytec-mira-rdk-nand.dts
index 3f13726c8058..afbb6681a6b5 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
@@ -6,7 +6,7 @@
=20
 /dts-v1/;
 #include "imx6q.dtsi"
-#include "imx6qdl-phytec-phycore-som.dtsi"
+#include "imx6q-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
 #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
diff --git a/arch/arm/boot/dts/imx6q-phytec-phycore-som.dtsi b/arch/arm/boo=
t/dts/imx6q-phytec-phycore-som.dtsi
new file mode 100644
index 000000000000..3ecb94379c8b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-phytec-phycore-som.dtsi
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2021 PHYTEC Messtechnik GmbH
+ * Author: Yunus Bas <y.bas@phytec.de>
+ */
+
+#include "imx6qdl-phytec-phycore-som.dtsi"
+
+&cpu0 {
+	operating-points =3D <
+		/* KHz  uV */
+		1200000 1300000
+		996000  1250000
+		852000  1250000
+		792000  1175000
+		396000  1075000
+	>;
+	fsl,soc-operating-points =3D <
+		/* ARM kHz  SOC-PU uV */
+		1200000 1275000
+		996000	1250000
+		852000	1250000
+		792000	1250000
+		396000	1250000
+	>;
+};
+
+&cpu1 {
+	operating-points =3D <
+		/* KHz  uV */
+		1200000 1300000
+		996000  1250000
+		852000  1250000
+		792000  1175000
+		396000  1075000
+	>;
+	fsl,soc-operating-points =3D <
+		/* ARM kHz  SOC-PU uV */
+		1200000 1275000
+		996000	1250000
+		852000	1250000
+		792000	1250000
+		396000	1250000
+	>;
+};
+
+&cpu2 {
+	operating-points =3D <
+		/* KHz  uV */
+		1200000 1300000
+		996000  1250000
+		852000  1250000
+		792000  1175000
+		396000  1075000
+	>;
+	fsl,soc-operating-points =3D <
+		/* ARM kHz  SOC-PU uV */
+		1200000 1275000
+		996000	1250000
+		852000	1250000
+		792000	1250000
+		396000	1250000
+	>;
+};
+
+&cpu3 {
+	operating-points =3D <
+		/* KHz  uV */
+		1200000 1300000
+		996000  1250000
+		852000  1250000
+		792000  1175000
+		396000  1075000
+	>;
+	fsl,soc-operating-points =3D <
+		/* ARM kHz  SOC-PU uV */
+		1200000 1275000
+		996000	1250000
+		852000	1250000
+		792000	1250000
+		396000	1250000
+	>;
+};
--=20
2.25.1

