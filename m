Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E94E54D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbiCWPFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245018AbiCWPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:05:19 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2081.outbound.protection.outlook.com [40.92.47.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF06C7DE22;
        Wed, 23 Mar 2022 08:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIUtevFkfgMPRFP80I2M3PLmcol8pplBNrKx2QaKhIgCFvfDt6iSpa3gUP1pDjAxWIOKzZzE/e32scsU43Rbx5Jpb6GjYhLi+2Ekk2HIAoe3A/NAMeVQKVSN+hknGXRrUbDNpMF7BBKS8P+Rbp9dVxD/bQLtS8hoyvf9yW9ae482Gws7DbuEDSzO0VVZtPjZ5Q77+ukcBPsftwUX5JNe0h6sdlxfC5Pe80koj+jsqGxbpACuOtlhhUBcoUWTlPKjfT5WJh5L10qp45Xt4n+3GmhGtIsBGhbTFIpTe/oMLKPQXSvIa366JzLb+muVMj99hAHOzuKzVzK0YM5z1/RVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+azOx6dCVyJXZqdk+EI5cyv4DgSWjqQmIIAKE0ukoE=;
 b=YMZIH8AKCBxrnn8qtqJHlxKDa9cWx0UHyqiDx5Huq35EOzM5fXQUmKmpUpdRSLKjKUie5d1+TR/2oChzHuvotDsZHVxRYfojJ4rKvlPbDxDeZn9gdjGPzAV/i38x0MRsNV6QjNxofFudJqNwAE4XPGsFmp5RpZh233GZOC7eTGdPgVkKLEKkBHj3JuAh6MjcaxxMaTR/YT6MW6G4of23YcDHECudoUzN29z6/NhS+NxX0Ug4Yxz84g3JaQQ6iaQYrAetCDKhWDQ2RAYRCsFAXWgwfd489bj6Umd9vWoJq38X6hnfDcFEPZNRrK3pHPXOEnk0lZhYx5fVknVZMwGcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BYAPR04MB5638.namprd04.prod.outlook.com (2603:10b6:a03:101::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Wed, 23 Mar
 2022 15:03:45 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 15:03:45 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 7/7] ARM: dts: s5pv210: Add charger support in Aries
Date:   Wed, 23 Mar 2022 08:03:11 -0700
Message-ID: <CY4PR04MB05671BD0A7FF349E8B04EE84CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220323150311.26699-1-xc-racer2@live.ca>
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [ycEHKKWNAKfC7i2fTWd9r4f4xEfz1KvLVXX/nrHZMxJVQyo+nsxQ21FNh+XZfHU4]
X-ClientProxiedBy: MWHPR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:301:2::16) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220323150311.26699-6-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94bb0a0f-9369-4fa9-818c-08da0cde5360
X-MS-TrafficTypeDiagnostic: BYAPR04MB5638:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRv+sWrmAA2qx7YFyfqk7PbqxfoQtNUQAarMrOG4MB53xBog418BX/oHX68x7KOSXdNuLWY2zCr2nGxgbZLlQBmICRfL/iu353g6zOFOnXjvqWXBJ+GHoBaTMWboCZX8fJ1hmH7jMlUkx3uG9Wkjv/tGNH7ily1lu/BW9u3UKz6WV0J1V2Gy+cjWxwhRtXee9YN3wceRp7u7+XDBSNxdG33FAPtDflHw++/ohPN3lKQ3Vx3GLeSfOkI5FDzLDbi+ccP1M6NtTH5g4SHECaS9nS46QpScRHIkw98Rv2GQSzDlkKaKL3xcGMfRVyN3ISwvEOO1WzA/z3pcHmhsXxHwk/N8ZtQDX/Qxbbf9m5YS9O6upsXM+DbtVdJ7sRsCp8DmecWUoazL0tI69qvJA9MgfItfgx2QXfZ5x3vyvXxkxneIUkfUA3UY1h7Np74IZeX3v2WMmLoZyCSW9K24B8PzDXr1vZIPKzZqeSi507VqF9oJHyzYIrZqF6XKoDzA+mtq8TTJ1hVD3cHKAPzAwxdcNLwKtbVz2q8EUDxFqAbSnrvK8KYFeB4kpe+tyJcZFLRQ0ut3AYHiO5c6ayO66OH68g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E8BK8eDdhQhIeWRPc1SQ318JHEmPDlaDjj1UdVbt6xe8qDWQT08eL+q/DqmL?=
 =?us-ascii?Q?4uf37Xv53TnKteQu4xhfYvqzT0faaMx67JAS8KhKnzfPUHtvff+p5opJ+F/b?=
 =?us-ascii?Q?Et4hI06Ns3aZ1zIIKTWu/uyTrT/08BYOJ6qHo8tZGey/ECLO2LVnhWhaZCnk?=
 =?us-ascii?Q?H1n+I3UBdq+HTdpDY4PeW7jK+NuG4Iv5VErmiv76L6Ce1opc4WEeX1h5+S1j?=
 =?us-ascii?Q?d3zaMC7ENPIlPE/5RTx0u7GclQ07szR5sHO3u7rkr/eksZ+MDHF+OcLjey5/?=
 =?us-ascii?Q?qkpX6lpb4XE4ipASWVlWyYJBYNRSLR9sfQoyoMFQ+jsFq+ngTVrfutfpCwAV?=
 =?us-ascii?Q?5qtocNpBYfS6xF9bv/c2TpcP9qfGojTHXGQSMi6IXCsoeOPuvpX3oA6qHT1Y?=
 =?us-ascii?Q?ZIN/Ba64Wzv/o5Qdx+RsjoNe/KtM0iz2xK7/Z9LKrtQ8ai1wyrX9k+FcpUiu?=
 =?us-ascii?Q?5U4bmAE/+lwiDGcQk99GcjY9uP3NuuO5uSXfyex90/NXSx6nYxWeFFnpyJd9?=
 =?us-ascii?Q?hwM+vqA0w8e0+GznBsjRCcwoJbG593wMayfTsUJeClv9uYyHTMO+VA9bMwYE?=
 =?us-ascii?Q?Dvc67kNtL5hHM0y3hhAxx//URK9o0D5lCZLZDENI39mvMM9gAf5PsaJ0U2vu?=
 =?us-ascii?Q?P+afLeyOxcU+rSy0rayTfQQniU7tXo8ImH3hbRdIT7hUaXUXicqjN2GTxMhq?=
 =?us-ascii?Q?0/MSPKr1p8zriP7rmMpb80q/33EUEzHC6bkjxyMpCCTcvTbjd4COeuJTyC4j?=
 =?us-ascii?Q?YmGBWBrSnFyQG3vfV+hxHvC4yB1eyAYO2SFa29Kxv9VNtS5GLpJ7wJnkW7kb?=
 =?us-ascii?Q?5dxm9JJ3I7PIfw/pK6Lq9l8UZoZEJ8GnMvIc/f2n70B+BjM6aNnBWPqrtCfA?=
 =?us-ascii?Q?mPgc2M/IF+SF9usrda7ex+iZf5StAZ+nUyfZ1zASnK2SNkRD/rBlCk08veJF?=
 =?us-ascii?Q?5Vv08lDdtPpyeQ3wZ5GZ6YOKKpNwupvH4CBngqHb4u2go1fCNeiXIVkh1fAa?=
 =?us-ascii?Q?vN3/OwMRS/5XFngh+TR7dxypvN8CoCzdpPILuhzJheR3NX4Hej/w7QmCF6Da?=
 =?us-ascii?Q?mLyJ/+kJlpUOhxdqJ/5IDElbu+wpxqhcfB4kaIMRPPdBdbKqcNFG0nu88EJq?=
 =?us-ascii?Q?jBvlVbEWJ5DGxG5PPQADv/GmyvOY1wLtHa9DmDjZd/g6sTuyDC946DYsRSb3?=
 =?us-ascii?Q?5EiljQeaefiH2rhRHpyDzonKCQCEqYVxm0UoUg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bb0a0f-9369-4fa9-818c-08da0cde5360
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 15:03:45.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5638
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add charger-manager support to Aries boards to allow safe
charging of the battery without the need for userspace control.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 162 ++++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-galaxys.dts     | 144 +++++++++++++++++++
 2 files changed, 306 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
index 7427c84f1126..9530231b7a70 100644
--- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -57,6 +57,168 @@
 		pinctrl-0 = <&main_micbias_ena>;
 	};
 
+	thermal-zones {
+		batt_thermal: batt-thermal {
+			polling-delay-passive = <60000>; /* 60 seconds */
+			polling-delay = <600000>; /* 600 seconds */
+
+			thermal-sensors = <&batt_thermistor>;
+		};
+	};
+
+	batt_thermistor: thermal-sensor-0 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&adc 6>;
+		io-channel-names = "sensor-channel";
+
+		temperature-lookup-table = <
+			(-20000) 1859
+			(-19000) 1846
+			(-18000) 1832
+			(-17000) 1818
+			(-16000) 1804
+			(-15000) 1790
+			(-14000) 1773
+			(-13000) 1756
+			(-12000) 1739
+			(-11000) 1722
+			(-10000) 1705
+			(-9000) 1691
+			(-8000) 1677
+			(-7000) 1663
+			(-6000) 1649
+			(-5000) 1635
+			(-4000) 1550
+			(-3000) 1510
+			(-2000) 1500
+			(-1000) 1490
+			0 1480
+			1000 1470
+			2000 1460
+			3000 1450
+			4000 1430
+			5000 1420
+			6000 1406
+			7000 1386
+			8000 1366
+			9000 1346
+			10000 1326
+			11000 1302
+			12000 1278
+			13000 1254
+			14000 1230
+			15000 1206
+			16000 1182
+			17000 1158
+			18000 1134
+			19000 1110
+			20000 1086
+			21000 1059
+			22000 1035
+			23000 1011
+			24000 987
+			25000 963
+			26000 937
+			27000 913
+			28000 889
+			29000 865
+			30000 841
+			31000 816
+			32000 794
+			33000 772
+			34000 750
+			35000 728
+			36000 708
+			37000 690
+			38000 672
+			39000 654
+			40000 636
+			41000 616
+			42000 599
+			43000 580
+			44000 565
+			45000 548
+			46000 529
+			47000 512
+			48000 495
+			49000 478
+			50000 461
+			51000 440
+			52000 431
+			53000 416
+			54000 405
+			55000 396
+			56000 375
+			57000 360
+			58000 347
+			59000 334
+			60000 325
+			61000 311
+			62000 303
+			63000 296
+			64000 290
+			65000 279
+			66000 265
+			67000 254
+			68000 240
+			69000 220
+			70000 206>;
+	};
+
+	charger_manager: charger-manager-0 {
+		compatible = "charger-manager";
+
+		cm-name = "cm-battery";
+
+		chg-reg-supply = <&charger_reg>;
+
+		/* poll when externally connected */
+		cm-poll-mode = <2>;
+		cm-poll-interval = <30>;
+
+		/* read supply status for status */
+		cm-battery-stat = <0>;
+
+		cm-battery-temp-diff = <5>;
+		cm-battery-hot = <5000>;
+		cm-battery-cold = <400>;
+		cm-battery-cold-in-minus;
+
+		/* 6hr max charging time */
+		cm-charging-max = <21600000>;
+		/* 1.5hr max discharging time */
+		cm-discharging-max = <5400000>;
+
+		cm-fuel-gauge = "battery";
+
+		cm-fullbatt-voltage = <4176000>;
+		cm-fullbatt-vchkdrop-ms = <30000>;
+		cm-fullbatt-vchkdrop-volt = <176000>;
+		cm-fullbatt-soc = <92>;
+
+		cm-num-chargers = <1>;
+		cm-chargers = "max8998_pmic";
+
+		cm-thermal-zone = "batt-thermal";
+
+		regulator-0 {
+			cm-regulator-name = "chg-reg";
+			cable-0 {
+				cm-cable-name = "USB";
+				cm-cable-extcon = "7-0025";
+				cm-cable-min = <475000>;
+				cm-cable-max = <500000>;
+			};
+			cable-1 {
+				cm-cable-name = "SDP";
+				cm-cable-extcon = "7-0025";
+				cm-cable-min = <380000>;
+				cm-cable-max = <600000>;
+			};
+		};
+	};
+
 	sound {
 		compatible = "samsung,fascinate4g-wm8994";
 
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index eeec2bdece11..240cd0a5c9cb 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -74,6 +74,150 @@
 		};
 	};
 
+	thermal-zones {
+		batt_thermal: batt-thermal {
+			polling-delay-passive = <60000>; /* 60 seconds */
+			polling-delay = <600000>; /* 600 seconds */
+
+			thermal-sensors = <&batt_thermistor>;
+		};
+	};
+
+	batt_thermistor: thermal-sensor-0 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&adc 6>;
+		io-channel-names = "sensor-channel";
+
+		temperature-lookup-table = <
+			(-7000) 1667
+			(-6000) 1658
+			(-5000) 1632
+			(-4000) 1619
+			(-3000) 1614
+			(-2000) 1596
+			(-1000) 1577
+			0 1559
+			1000 1536
+			2000 1513
+			3000 1491
+			4000 1468
+			5000 1445
+			6000 1421
+			7000 1396
+			8000 1372
+			9000 1348
+			10000 1324
+			11000 1299
+			12000 1275
+			13000 1251
+			14000 1226
+			15000 1202
+			16000 1178
+			17000 1155
+			18000 1131
+			19000 1108
+			20000 1084
+			21000 1060
+			22000 1037
+			23000 1013
+			24000 990
+			25000 966
+			26000 943
+			27000 920
+			28000 898
+			29000 875
+			30000 852
+			31000 829
+			32000 806
+			33000 784
+			34000 761
+			35000 738
+			36000 718
+			37000 697
+			38000 677
+			39000 656
+			40000 636
+			41000 615
+			42000 595
+			43000 574
+			44000 554
+			45000 533
+			46000 518
+			47000 503
+			48000 487
+			49000 472
+			50000 457
+			51000 442
+			52000 427
+			53000 411
+			54000 396
+			55000 381
+			56000 368
+			57000 354
+			58000 341
+			59000 324
+			60000 306
+			61000 299
+			62000 293
+			63000 286
+			64000 275
+			65000 264>;
+	};
+
+	charger_manager: charger-manager-0 {
+		compatible = "charger-manager";
+
+		cm-name = "cm-battery";
+
+		chg-reg-supply = <&charger_reg>;
+
+		/* poll when externally connected */
+		cm-poll-mode = <2>;
+		cm-poll-interval = <30>;
+
+		/* read supply status for status */
+		cm-battery-stat = <0>;
+
+		cm-battery-temp-diff = <5>;
+		cm-battery-hot = <6300>;
+		cm-battery-cold = <400>;
+		cm-battery-cold-in-minus;
+
+		/* 6hr max charging time */
+		cm-charging-max = <21600000>;
+		/* 1.5hr max discharging time */
+		cm-discharging-max = <5400000>;
+
+		cm-fuel-gauge = "battery";
+
+		cm-fullbatt-voltage = <4176000>;
+		cm-fullbatt-vchkdrop-ms = <30000>;
+		cm-fullbatt-vchkdrop-volt = <176000>;
+		cm-fullbatt-soc = <92>;
+
+		cm-num-chargers = <1>;
+		cm-chargers = "max8998_pmic";
+
+		cm-thermal-zone = "batt-thermal";
+
+		regulator-0 {
+			cm-regulator-name = "chg-reg";
+			cable-0 {
+				cm-cable-name = "USB";
+				cm-cable-extcon = "7-0025";
+				cm-cable-min = <475000>;
+				cm-cable-max = <500000>;
+			};
+			cable-1 {
+				cm-cable-name = "SDP";
+				cm-cable-extcon = "7-0025";
+				cm-cable-min = <380000>;
+				cm-cable-max = <600000>;
+			};
+		};
+	};
+
 	micbias_reg: regulator-fixed-3 {
 		compatible = "regulator-fixed";
 		regulator-name = "MICBIAS";
-- 
2.20.1

