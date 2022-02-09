Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD64B009A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiBIWsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:48:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiBIWsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:48:19 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [195.145.39.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3F4E01644C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1644445979; x=1647037979;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NGlq9XGhNk/6Qyl8diek/rJVEG81o+VT/IU9qxD7V/k=;
        b=U61P0Ybe1H8KdEw1WJxjbua61eJkQiIH28qxi68VfMZxCCJV8LJ2LxW9cqXECX6G
        aD7hZHFQRk61FQyLfHVwEBLTn+c0WWxvgieLiWbCEE0xnxq92yEN0XNoq+Ww7nL2
        gi2HtjXKmJAkfXIwln3nVBt7hMNvDsHXcp+UngvMDlE=;
X-AuditID: c39127d2-9112070000002a63-ba-6204411bbed3
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A2.82.10851.B1144026; Wed,  9 Feb 2022 23:32:59 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2022020923325880-256539 ;
          Wed, 9 Feb 2022 23:32:58 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, devicetree@vger.kernel.org
Cc:     festevam@gmail.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] ARM: dts: imx6qdl: phycore-som: Add custom volt/freq table
Date:   Wed, 9 Feb 2022 23:32:58 +0100
Message-Id: <20220209223258.1672425-2-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209223258.1672425-1-y.bas@phytec.de>
References: <20220209223258.1672425-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.02.2022 23:32:59,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.02.2022 23:32:59
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWyRoCBS1fakSXJoHcOm8X8I+dYLR5e9bfY
        +PYHk8XlXUCh1r1H2C3+bt/EYvFii7gDu8eshl42j52z7rJ7bFrVyebR/9fA4/MmuQDWKC6b
        lNSczLLUIn27BK6Mlh9f2QsOq1fMOjafpYHxmUIXIweHhICJRP+2pC5GLg4hga2MEk3bb7JC
        OOcYJba/WsTexcjJwSagKHH+9ltWEFtEIEviyc8HTCA2s4CPxK99V8BsYYEwiRW3ZrKB2CwC
        KhLP969lBLF5Bcwk9p/ZD2ZLCMhLzLz0HWwmp4C5xOLm+WBxIaCaWbf3sULUC0qcnPmEBaL+
        CqPE7LkcELaQxOnFZ5kh9mpLLFv4mnkCo8AsJC2zkKQWMDKtYhTKzUzOTi3KzNYryKgsSU3W
        S0ndxAgM4MMT1S/tYOyb43GIkYmD8RCjBAezkgjvqXrmJCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK893uYEoUE0hNLUrNTUwtSi2CyTBycUg2MAevuOL/ZyFv3ye3TdvUqm23ipT3bf+zTS7K+
        1fQtrsiQvzOy9auF2Xc9p7Rn33a/Soty25HGPjH5geperjC5DrP4pU+tL0d4pptlvc0WnXX7
        090cR9Hf8gmnWl3Fq2L0pL0mn7NLqRHW3utzT/GuLWP8Zv6983K6DZc+SdN7pij10OENa5oS
        S3FGoqEWc1FxIgBuOjCGTgIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

