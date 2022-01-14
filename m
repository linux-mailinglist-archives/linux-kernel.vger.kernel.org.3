Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B816048E649
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiANIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:25:47 -0500
Received: from mail-psaapc01on2122.outbound.protection.outlook.com ([40.107.255.122]:12513
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239897AbiANIXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:23:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YswsgPJoZeY2ITFAJAwEJURay4Oxbnr0tOlohKVQHxt66k6MNkb7ZlwC/Yp98QVcgd5XCRSEH1zU7oB4Ma0bDh1ZrOu2Kzv4cYL2TGYH7Wpiw8069puae0aObwsJHBsJsAihDniHh2K3eX4KeW2nZCrQ8CUvTjlGxLeA9NOPVOku1PcOqOmroFsbNaXl/YUCbglEcAin3ODIOde9IDHD+qik9I/S9iHEJ1pDF1seY9+38Vp9Dwl7yR+ni/4bVbcTyQTsXoap0UvqLKRMwbKnWL6pCwY7eUobFayibBthijjGdFALhQ2hxIatFBoe7dn5OFXSfU3+cBYyFD+noAF50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvGmb/WbeC0KnBUEMPg2eb8+S+tCdAybhpU3TyLGBus=;
 b=FVacdpC+3MiqGP7Ts8VVBiXQh3wgJnZPacg0puMQtLhMc955RaIoZb7hZYde6cxIr0buelRvc5Aic55iRWdMuSqf+LrF+R8yZ53NJABlYWLBxy5wLBtMtJdn9z2x3Hpet3Xi+CNTFxBfXlzXdqpi7hKY7psp6ifYAAj7NSt4udLwEAu7gTYyU3ED7osYogexNoCarvm5XbHZJSmemJJXSsMAtJcpiZ25wE8QQiKYLDGR5eXvlAA9VnlcZuvxYvWW1gZl5QS0V6CJ8qyIyE64kvCaKdp89x5h103OelnOxqidDSAsR6NODkPWm0ygdnqWiJSqOYCwLxmKLG5wE47P7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvGmb/WbeC0KnBUEMPg2eb8+S+tCdAybhpU3TyLGBus=;
 b=V6y+6BLGSx1HX8nT5RWXnkTRI5akitF46x77AFzq9epE4wf/IwToJdB0Ovesrr5weR/ve0L71a9doT2ONlPJfHi43nNYeBKytoI4FfGD9Xd95/fni/CPY+F3nS7MQmUOEsL4bzwjKJtZS8PMMhDn8D4IvD22aQ1K1JZKhEii2CY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HKAPR04MB3922.apcprd04.prod.outlook.com (2603:1096:203:d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 08:23:16 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4867.011; Fri, 14 Jan 2022
 08:23:16 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] arch: arm: dts: update bletchley dts
Date:   Fri, 14 Jan 2022 16:22:59 +0800
Message-Id: <20220114082300.29224-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28b00885-7ab8-45ab-4f0d-08d9d7371d3e
X-MS-TrafficTypeDiagnostic: HKAPR04MB3922:EE_
X-Microsoft-Antispam-PRVS: <HKAPR04MB392295C5FEB91D2A93135EC88E549@HKAPR04MB3922.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++qqEQ84Rv4/2H9k8PdUa+hID/3X7AE1UsKcOn5fRQfHuZ3kUVK23Ede1OvlMO10hBOA/sP1zoACDROAGlp6OBUgg2bEAOBStLHLy0Db8Z9PiyyMb9Gl4Kf/wstlTi3yY6PqfqxaH8yKACOa5XxlwO7ENCjNWzmLv6vJkuNM41dA08TPCXWbyDYWDNyzXxkxVK7nfDhdmgyrLOA2/2BXa6FgRlS2qVikfqJcOUzBaA8YA8FHHVF4iS/w+8b/vxLImt8OCFgGty89US5XOefpGiF9qi4o1Zno7OB5DEXDVJA7fSCK3p4Sfo44MZ3XynKlkLW3OGgr90fdwTot6tccR9stYoqqzMu89+myJNduSdBiY8/xE1Y7+HHNBtYNPelV68ZXHslfIFrSnyQp4JjZQFU3tB993OhIDEu7MQEy/qBg42M2xigwPyws4WahnS8NePHXs4zp5VjMNnuwU/IeU46NlywJQK34mjBRLQDI3G1NUx+rT+MdqLj2G0U4jIexqJR4J1XYYJYLNPbTdWOnkzwdamSWUXOp6w5bAQFGycVolHFONbLzTveRda9Ls75AnTJfByXXgqNwiOAzG/9TTJurn11rLtid6+dLRpWwn2ki+5HzWtCBq50FGT1+ncx235CHsc3tpg/TV5YQ+JBIQDIChKFHXfxBNLACla1ti1Mm9Jd4OSSaLhbHGLc5lk/KtT6A5XpshyJBOMvhj6Ig8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(44832011)(5660300002)(6512007)(8936002)(4326008)(6666004)(110136005)(66946007)(86362001)(2616005)(66476007)(6506007)(54906003)(316002)(508600001)(66556008)(2906002)(52116002)(6486002)(36756003)(26005)(30864003)(1076003)(83380400001)(186003)(8676002)(15650500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQ5wPBhGdqLiD3rRVwDzevW0w4u1euPrTY6iouXBhWn7e8xLr5P/CM+Dc8fy?=
 =?us-ascii?Q?sZF4ZXNXmGNMhspUx1K9zeuAUdZPK32tBaEqvQzrptzXbGWcUYk/Ez+Jlkxu?=
 =?us-ascii?Q?glXvMpEeIjovkMsH5cyOufgi9PavQbZvNeq3xhjbatIIQSdpS5mJZ/PQ/JsU?=
 =?us-ascii?Q?VV0e7JdvEWrnyE2Et6PJbv4SiCw1/jUtQyYlifZkxAbzU4dvk7qbhcfqIxbX?=
 =?us-ascii?Q?jZsEQXmFTIu4QmfU0JR5lqM06eM6hZXze5ZE6HEEUW6ut+ljGXq4LFay/SsS?=
 =?us-ascii?Q?9tQ8TtoQeJ5oPbJELNOdON2JKHiwF2hqCFAenQB3xsIxBBySJ74JOSIOZB+Y?=
 =?us-ascii?Q?x0mtKEG3L1okytJ7DPZI4f2Gg/DXf2Cd1uo2gRzCeqUjJ7WIRz4IfyUyKmd0?=
 =?us-ascii?Q?Nvkn4ZDseteTLp/Bp8cufj1MH6afnsHYvKGN8VlmENheDwwE8BmS9CVNqc0B?=
 =?us-ascii?Q?/9WFMcAdjcx4rQsCauSCMte5lPsNOnLo3e4vCcRsXtI1b5VzxRRofQNSTsS6?=
 =?us-ascii?Q?4/pi4LreVmj6YQU6c5UcbIRyY29dKRgBbPgFyME7lRNt8lUkT9/PtNTb8Jb9?=
 =?us-ascii?Q?w29rVA07LPFM7qKJBu+r6NDESRyulesekTvMYMe9Rk/1Sx9FbAcEMMEtNjFy?=
 =?us-ascii?Q?e4JYFusrKxuPR5wA0p0Yrj1/DT9t03yIeVY+x2uhvcJ58zcj2wm0sWZ5QvLA?=
 =?us-ascii?Q?Gy3dH3XmCF+3+2MCDzjI2EOSuo0nVXJfqtFhIz9i3oZ6LOnaLUp/hne8hlaj?=
 =?us-ascii?Q?Pn/5QP50Ku6D1NZcyoCunjDFYekQHrq8gQtPnY+0qRaiDfzCAKWrkL6i0taX?=
 =?us-ascii?Q?6v7dCxJBBczBg9Zo0xm7qEiZROvl5WClMj60Oau87QY5O2SyncPUgW03sV3W?=
 =?us-ascii?Q?WOO+IOkXd3qqW2/cXMBdsyEfi1wC4k18fgt4GKrCrm538kLb5FwIVwgst4Pa?=
 =?us-ascii?Q?diV7eK05h38foojVB/oToVx4i/RwJz4lbSI/XxqXlUEuir2+BMC1QPTPhrnP?=
 =?us-ascii?Q?qjbdWwxAznaVukbWPW02dXhiMROiVJ/0iIi3EP5l8xSLrlVqDgYNbUS8rwrn?=
 =?us-ascii?Q?ZpNAs4PR4iKnZjVT+mSqYSyBJx9Ox4LEg4W9hw/7yd6zqNTW+ukqFPcZ1JXo?=
 =?us-ascii?Q?0e6fy6DH5dRZl4mJFOOy8uIlBNua/pz6piLH8nMm1cPLogzq5K5Y3xUdlCwL?=
 =?us-ascii?Q?6FMjH0xj+S3xCIuHc3V4QcSfbtTac2zHAWuu9zWlRgMrMJ44WYK04QJAeDMY?=
 =?us-ascii?Q?N6LkVv+zl7mq6Dj6eRxnqxOvQPaKgirwG93VotORdfubBzA62LQGPsZwhUVu?=
 =?us-ascii?Q?F47oGXJSMLhKPZ1o6cRyRnUQ1pPg+gWs16gR2M/CSmYqjgat/7VfiY69HGqL?=
 =?us-ascii?Q?DI3t7GYtPeBGOyGOZlvxIJnn0F2zHAovXDb+S7ioBP04x4fQ8lJ5maxVz34Q?=
 =?us-ascii?Q?iwS+x/HUKOGEDvo8MpFhA/oG7Jo2q+hjHZgIIDSW/AtPJrkFqrSYsdQF54nM?=
 =?us-ascii?Q?svIvbSA22sfujp0uIxSO2TQcSmgNcz+la+NQbQWhjGVDtRmfox1XBIQm2ooI?=
 =?us-ascii?Q?x59yPY+e8m18M/5JXqwv74M6xBCBK/3bzxqt0wTmi/e3fJ/AOUmqFkLYPmOa?=
 =?us-ascii?Q?1RJ05KCpDaS4Mj74VpEUQ7w=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b00885-7ab8-45ab-4f0d-08d9d7371d3e
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 08:23:16.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjjJW4DRQ1A7GesBitKCkf+oPYphVjNr7XfCm7KYGZVDll9RCdHRdR8wyKXEtoQsLOCNVQJ/dZu1ypyJXFqjQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR04MB3922
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

updates:
* separate leds into multiple groups
* switch sled numbering to 1-based
* disable inchip rtc
* add flash1 in fmc
* switch spi2 pnor using spi-gpio
* update gpio-line-names
* add interrupt pin for each sledx_ioexp

Signed-off-by: Potin Lai <potin.lai@quantatw.com>

---

Changes since v1:
- add interrupt pin for each sledx_ioexp
- remove duplicated i2c1 node
- remove all PCA955X_TYPE_GPIO (default is GPIO)
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 313 +++++++++++-------
 1 file changed, 194 insertions(+), 119 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index f973ea883b97..432c65bab0a6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -5,6 +5,8 @@
 #include "aspeed-g6.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/usb/pd.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Facebook Bletchley BMC";
@@ -53,113 +55,140 @@
 		// Fixed link
 	};
 
-	leds {
+	front_leds {
 		compatible = "gpio-leds";
-
 		sys_log_id {
 			retain-state-shutdown;
 			default-state = "keep";
-			gpios = <&front_leds 0 GPIO_ACTIVE_HIGH>;
+			gpios = <&pca_front 0 GPIO_ACTIVE_HIGH>;
 		};
+	};
+
+	fan_leds {
+		compatible = "gpio-leds";
 		fan0_blue {
 			retain-state-shutdown;
-			default-state = "on";
-			gpios = <&fan_ioexp 8 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 8 GPIO_ACTIVE_HIGH>;
 		};
 		fan1_blue {
 			retain-state-shutdown;
-			default-state = "on";
-			gpios = <&fan_ioexp 9 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 9 GPIO_ACTIVE_HIGH>;
 		};
 		fan2_blue {
 			retain-state-shutdown;
-			default-state = "on";
-			gpios = <&fan_ioexp 10 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 10 GPIO_ACTIVE_HIGH>;
 		};
 		fan3_blue {
 			retain-state-shutdown;
-			default-state = "on";
-			gpios = <&fan_ioexp 11 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 11 GPIO_ACTIVE_HIGH>;
 		};
 		fan0_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&fan_ioexp 12 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 12 GPIO_ACTIVE_HIGH>;
 		};
 		fan1_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&fan_ioexp 13 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 13 GPIO_ACTIVE_HIGH>;
 		};
 		fan2_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&fan_ioexp 14 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 14 GPIO_ACTIVE_HIGH>;
 		};
 		fan3_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&fan_ioexp 15 GPIO_ACTIVE_HIGH>;
-		};
-		sled0_amber {
-			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled0_leds 0 GPIO_ACTIVE_LOW>;
-		};
-		sled0_blue {
-			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled0_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_fan 15 GPIO_ACTIVE_HIGH>;
 		};
+	};
+
+	sled1_leds {
+		compatible = "gpio-leds";
 		sled1_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled1_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled1 0 GPIO_ACTIVE_LOW>;
 		};
 		sled1_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled1_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled1 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled2_leds {
+		compatible = "gpio-leds";
 		sled2_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled2_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled2 0 GPIO_ACTIVE_LOW>;
 		};
 		sled2_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled2_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled2 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled3_leds {
+		compatible = "gpio-leds";
 		sled3_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled3_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled3 0 GPIO_ACTIVE_LOW>;
 		};
 		sled3_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled3_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled3 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled4_leds {
+		compatible = "gpio-leds";
 		sled4_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled4_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled4 0 GPIO_ACTIVE_LOW>;
 		};
 		sled4_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled4_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled4 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled5_leds {
+		compatible = "gpio-leds";
 		sled5_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled5_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled5 0 GPIO_ACTIVE_LOW>;
 		};
 		sled5_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled5_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled5 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	sled6_leds {
+		compatible = "gpio-leds";
+		sled6_amber {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca_sled6 0 GPIO_ACTIVE_LOW>;
+		};
+		sled6_blue {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca_sled6 1 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
@@ -178,7 +207,7 @@
 };
 
 &rtc {
-	status = "okay";
+	status = "disabled";
 };
 
 &fmc {
@@ -188,20 +217,38 @@
 		m25p,fast-read;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-128.dtsi"
 	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "flash1";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
 };
 
 &spi2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	compatible = "spi-gpio";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+	gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+	gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+	num-chipselects = <1>;
+	cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
 
 	flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
-		spi-max-frequency = <100000000>;
+		spi-max-frequency = <12000000>;
 	};
 };
 
@@ -219,7 +266,7 @@
 		reg = <0x4f>;
 	};
 
-	sled0_ioexp: pca9539@76 {
+	sled1_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -227,14 +274,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 0) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED0_MS_DETECT1","SLED0_VBUS_BMC_EN","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
-		"SLED0_SSD_ALERT","SLED0_MS_DETECT0","SLED0_RST_CCG5","SLED0_FUSB302_INT",
-		"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
-		"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","power-host0";
+		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
+		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
+		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
+		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
 	};
 
-	sled0_leds: pca9552@67 {
+	pca_sled1: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -243,13 +295,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled0-amber","led-sled0-blue","SLED0_RST_IOEXP","",
+		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","SLED1_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled0_fusb302: typec-portc@22 {
+	sled1_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -282,7 +334,7 @@
 		reg = <0x4f>;
 	};
 
-	sled1_ioexp: pca9539@76 {
+	sled2_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -290,14 +342,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 1) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
-		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
-		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
-		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
+		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
+		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
+		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
+		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
 	};
 
-	sled1_leds: pca9552@67 {
+	pca_sled2: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -306,13 +363,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled1_fusb302: typec-portc@22 {
+	sled2_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -331,10 +388,6 @@
 	};
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &i2c2 {
 	status = "okay";
 	/* TODO: Add ADC INA230 */
@@ -349,7 +402,7 @@
 		reg = <0x4f>;
 	};
 
-	sled2_ioexp: pca9539@76 {
+	sled3_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -357,14 +410,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 2) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
-		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
-		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
-		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
+		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
+		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
+		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
+		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
 	};
 
-	sled2_leds: pca9552@67 {
+	pca_sled3: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -373,13 +431,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled2_fusb302: typec-portc@22 {
+	sled3_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -412,7 +470,7 @@
 		reg = <0x4f>;
 	};
 
-	sled3_ioexp: pca9539@76 {
+	sled4_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -420,14 +478,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 3) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
-		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
-		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
-		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
+		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
+		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
+		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
+		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
 	};
 
-	sled3_leds: pca9552@67 {
+	pca_sled4: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -436,13 +499,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled3_fusb302: typec-portc@22 {
+	sled4_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -475,7 +538,7 @@
 		reg = <0x4f>;
 	};
 
-	sled4_ioexp: pca9539@76 {
+	sled5_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -483,14 +546,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 4) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
-		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
-		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
-		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
+		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
+		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
+		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
+		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
 	};
 
-	sled4_leds: pca9552@67 {
+	pca_sled5: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -499,13 +567,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled4_fusb302: typec-portc@22 {
+	sled5_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -538,7 +606,7 @@
 		reg = <0x4f>;
 	};
 
-	sled5_ioexp: pca9539@76 {
+	sled6_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -546,14 +614,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 5) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
-		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
-		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
-		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
+		"SLED6_MS_DETECT1","SLED6_VBUS_BMC_EN","SLED6_INA230_ALERT","SLED6_P12V_STBY_ALERT",
+		"SLED6_SSD_ALERT","SLED6_MS_DETECT0","SLED6_RST_CCG5","SLED6_FUSB302_INT",
+		"SLED6_MD_STBY_RESET","SLED6_MD_IOEXP_EN_FAULT","SLED6_MD_DIR","SLED6_MD_DECAY",
+		"SLED6_MD_MODE1","SLED6_MD_MODE2","SLED6_MD_MODE3","power-host6";
 	};
 
-	sled5_leds: pca9552@67 {
+	pca_sled6: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -562,13 +635,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
+		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","SLED6_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled5_fusb302: typec-portc@22 {
+	sled6_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -632,7 +705,7 @@
 		reg = <0x40>;
 	};
 
-	front_leds: pca9552@67 {
+	pca_front: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -667,7 +740,7 @@
 		reg = <0x4d>;
 	};
 
-	fan_ioexp: pca9552@67 {
+	pca_fan: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -700,36 +773,38 @@
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
-	/*G0-G7*/	"","SWITCH_FRU_MUX","","","","","","",
+	/*G0-G7*/	"BSM_FRU_WP","SWITCH_FRU_MUX","","",
+			"PWRGD_P1V05_VDDCORE","PWRGD_P1V5_VDD","","",
 	/*H0-H7*/	"presence-riser1","presence-riser2",
-			"presence-sled0","presence-sled1",
-			"presence-sled2","presence-sled3",
-			"presence-sled4","presence-sled5",
+			"presence-sled1","presence-sled2",
+			"presence-sled3","presence-sled4",
+			"presence-sled5","presence-sled6",
 	/*I0-I7*/	"REV_ID0","","REV_ID1","REV_ID2",
-			"","","","",
+			"","BSM_FLASH_WP_STATUS","BMC_TPM_PRES","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
-	/*L0-L7*/	"","","","","","","","",
-	/*M0-M7*/	"ALERT_SLED0","ALERT_SLED1",
-			"ALERT_SLED2","ALERT_SLED3",
-			"ALERT_SLED4","ALERT_SLED5",
+	/*L0-L7*/	"","","","","","BMC_RTC_INT","","",
+	/*M0-M7*/	"ALERT_SLED1","ALERT_SLED2",
+			"ALERT_SLED3","ALERT_SLED4",
+			"ALERT_SLED5","ALERT_SLED6",
 			"P12V_AUX_ALERT1","",
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","",
 			"","BOARD_ID0","BOARD_ID1","BOARD_ID2",
-	/*P0-P7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","BMC_HEARTBEAT",
 	/*Q0-Q7*/	"","","","","","","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","BAT_DETECT",
 			"BMC_BT_WP0","BMC_BT_WP1","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
-	/*V0-V7*/	"","RST_BMC_MVL","","",
+	/*V0-V7*/	"PWRGD_CNS_PSU","RST_BMC_MVL","","PSU_PRSNT",
 			"USB2_SEL0_A","USB2_SEL1_A",
 			"USB2_SEL0_B","USB2_SEL1_B",
 	/*W0-W7*/	"RST_FRONT_IOEXP","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
-	/*Y0-Y7*/	"","","BSM_FLASH_LATCH","","","","","",
+	/*Y0-Y7*/	"BMC_SELF_HW_RST","BSM_PRSNT","BSM_FLASH_LATCH","",
+			"","","","",
 	/*Z0-Z7*/	"","","","","","","","";
 };
 
-- 
2.17.1

