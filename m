Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09750483F2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiADJae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:30:34 -0500
Received: from mail-sgaapc01on2121.outbound.protection.outlook.com ([40.107.215.121]:58049
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229693AbiADJac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:30:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=job6AL2DNorBldl7UO1+2mmxqWtEthaSMOBug+Rol3COmjy3UMNOI1qpLl3Fhz6rsEADzn2XSWhvhHfpBJS36DbWLiZpSpW2dmYJhc4NvbJCkJtmWuU1j7sEvNkhwPv0JWRPDQCUmMs3glUB9gYT1cwculH/5eTG+iVEaYNfLLhXxBnko3sbhl1xzsZ/37Ni+YhSfpWYbLeOUpqDp2zEmVZreX84+c9qHGg+UHGjW7qaoPYOK1AZg3tps9xOHZKMDz4+wrtJKMy8AjKSn43l4hzbctDkrQYTNGJ1lh7WI+BtFnR40lUKQ/bjeGFPbKUDP5u69CbzJ5DhKiUt/ptmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z9vMC/HMrgS64IsDGs9EpAs3T0/JLBsArPYNvRWcv8=;
 b=iTX4jYnKeV9HGl3Fk94kQoDYGF68oQ1JZlPH1XrxgxdLccrqR0Qz9wA7vNW96ea0KSW5z/D9K3ECus/bBBLS+hCaKQ4i05kxU9ZmtYi32UrJjS+HLzXm9bWT3pL86ccjzK8nsHp/6b/ElLufNAPA842mLi6HVLFdUZbQTu/D4bR682LC8xUbAswQgKYKfmWrB0vVyPzws5IrUhai1aOl6nRy/n0mxscuFSXHropbWPQbjyYvdU8T69KobTwySxy+bQCA3fxSInnkmjzIDR5GspPLiWHysAgFuuOASOxQ3rGnVDoOTYDPCxDIu4fiouVibaYedmtNfa7GJcy7kwg5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z9vMC/HMrgS64IsDGs9EpAs3T0/JLBsArPYNvRWcv8=;
 b=IExAcNJgstraXd6MdItP7eMRDVQXWPMVvSa8AWNDYUrPpY9PUJUR6/lxBRS3Od4LKSBilcjImb+K5m7fTllfPDSI7ynyTfeBH/UXZGUQT6BxXuKlpeYcLNEDK5QcTWz9dup4BZlJc0ebm7VZ2WH+0s9pzoHKzihiyks37YYrPb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2691.apcprd04.prod.outlook.com (2603:1096:203:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 09:30:29 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 09:30:29 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: update dts of Bletchley platform
Date:   Tue,  4 Jan 2022 17:30:08 +0800
Message-Id: <20220104093008.624-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aac52d2-b804-4664-54be-08d9cf64d899
X-MS-TrafficTypeDiagnostic: HK0PR04MB2691:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB269148E74EF0808864C4E4888E4A9@HK0PR04MB2691.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpaZ0vUzhnhFc2KsBJgAqqEsBDR0429Xhv4aHSCQaCsNKwzPRPIomEJzOUgrr8a/CtCqSyNnP2lSLwOqK8YlvgcZmSVUAs7lnY/F877UFHJ37D5Uu2G7dnrAVe0u27NwN3yXyf6z+DwYX0DslAtnw9xUjqiRGVeg9HkC2shxQQoz1LNGVRYHvl4Wz3AJD3+7t97P8yyu4LCP8yd1Z9elgIcV72Qum6YGhroRZkT7NQg78djBd5HhwHruGUleBMGpmem3z9/0Y6Bh1Sqq7LQreo7UV6QWgFx4ff4lDKO8a3t77Ya5roWZbjVs311Svt21fCUq+y9Mjk/9Bjl/SQYK1VGWzEeih486yy9SHeYU/a6LBVLBZ5mUJytlgw2jwzElJzw9QnpznJYjkL+8/Bfx+gA10e2PhcVq8HonxEKw+oyxJwwvn5CRNu3obhUKXJ6qS19XN2ClCUUHGMGLICfYJ926VvRkBRhfFUhjdU1Gvu0PrnsQ8Ngmt4UEKT7opnUTBLk/sHsJ+F6HU8TOTT3kE9DZyd4OXyYK8G0//8RT8zOa3CyBuOynRuMwzsZoKRD0SDAfEjkpff01vFooSabMQscer7Iz8Q9NhwQEq7u63CuRGX5rrlnhFeLs+CMuV3+yMYUS1Na0JwBXCuadV/1rRD42Ai1ONjip7yv/ri6L9z9a1YFSP74xWZBKVLTgTKLKm/emArTY+gfopTZ4yjEEUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(44832011)(66556008)(316002)(8936002)(38350700002)(6666004)(186003)(83380400001)(36756003)(6506007)(8676002)(15650500001)(26005)(30864003)(66476007)(54906003)(4326008)(5660300002)(508600001)(38100700002)(86362001)(2616005)(6486002)(66946007)(1076003)(110136005)(52116002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ceVjWB0+1VpIzueqf1Ie758Bnoy9fNnCb0W6x9mI3pf4KfSR7q4DHlCuScvU?=
 =?us-ascii?Q?ew67QBSfVrVeGn0bfyMPPhWAeD8mFKJErrhKc7KyITHhwrnBZ6w84f65spR0?=
 =?us-ascii?Q?K5hSTU48+B9++/g2dTb9QnOYZQmq8FNNjlTnpb5kMvruObAmXKfA/ckixAhB?=
 =?us-ascii?Q?NN2Jttl5e4Z0IssIGjTS7Fp7qFbeWz5myd5gZ3u9UEGUt1Xu3mdzTz8d4aJg?=
 =?us-ascii?Q?xzxEcb5Et72hRd/j56H18N9NPzRxU9Uu/o8mtswF9DwunRkFPBBw3dXClW9B?=
 =?us-ascii?Q?77PbfHVM/oplVd9NyGtIVC/tgunV41ZJi4p0ot/loYaSE63IYtQhUYWnIz6X?=
 =?us-ascii?Q?nKnNVGxPDaHski9X9fYMxHw6uBy62miuBZS0eANNrsojK9TaenjfzCqYwVP+?=
 =?us-ascii?Q?WJgYCDddH6SmA1HvFbhuF35988qY3jZXP4FvPJMDmUhUcqqqXhmNLW6OfqP2?=
 =?us-ascii?Q?RmpoDcH0WQ/tOb7GoopyXnreYAzKElOuij/lQbYgFEi++BF4pJCQBSRdcNur?=
 =?us-ascii?Q?+q74zOghrEHs/wIV8UIyuvgwZsfM4I2kFw93Fbgh7EJLpqlIh6Tb3zWFhOaJ?=
 =?us-ascii?Q?VdCdZGi5JVtGm+kUs/Aa5fwnutz+2GucDgvthORgAGBCdcEnlvHyrphWli+t?=
 =?us-ascii?Q?U4LWNd4BH9JPiLrOAnwowFcW4TY1UwyPV8WchBAXWTunFr0G6b3LwKCiwCfD?=
 =?us-ascii?Q?HlLnG4OjTd+53YicKbo2JWi7TLfAY6qtOAO8AUzQChRtSV6GniW98lbJ0Rcn?=
 =?us-ascii?Q?TIQVqJAygnQt1iiDIwyd1GTXrpnSJkEB3cZNao1giIWMaqkgkD30A5tG9Pgs?=
 =?us-ascii?Q?Yma9fRu4SZGCO2k8lgC0zdvpe9bly2njiOgg/v8jmk8WHLHKo//z5jSTrhPv?=
 =?us-ascii?Q?DL4+ey/4pJ+qq1cYfOAQug48IXNO4mvC3a78gAWfZYDa3IaclpGolWwl2je/?=
 =?us-ascii?Q?oI8hpLUUyMpoFm/mh5nsOBnAfYARJxIjTBZ32ijBLNebBJhBpHyoDLKzQRNt?=
 =?us-ascii?Q?B09yuwoxKV+6dluFv7N9kHx4iqPgpSuacMivtrX0Dgx6rM2XQmTHpcRNkiAt?=
 =?us-ascii?Q?DYJVPAKdNvFD1uH+uWe6VJc7esbDRbiBv4nN9JbbjaMwUmpNBgdy6n9Op0p1?=
 =?us-ascii?Q?lWNCAIe/zyjELRqxjuosHQieSW9ddaYfLHNRSquiblME1DeGrihxHOh8I2xe?=
 =?us-ascii?Q?nF+vXyV2nfpfmRl2HAl9uHEV2kHvp70/mKVPTdG+kqNtQUgdZJh8n4uEV9P5?=
 =?us-ascii?Q?Cs7gNehzSqPNOzIzDQpoU3vsNXRStwkfPXydDK+6u40/CGk49daHU5G6zGLY?=
 =?us-ascii?Q?WXuni/QFH/5K8JxXtg+I9x+u+agaTA1JHuJxHM1O/78DRx8YgoDXu0jb+sMv?=
 =?us-ascii?Q?aTzblHqqRnEIgR2ph2bRn0H0Q74Dmpto6/SddQQxw68P7TLiniHEQ5/k9pCq?=
 =?us-ascii?Q?bCyAlaeY63mxXL2Yf2JsZjy17059Pdx4x9TKhJa1mmUoIPy1Ivz33ulYYo3g?=
 =?us-ascii?Q?/yN/KcfwGqOKpFDzpuu1PshkJbID2IMJnG1ul3AGMBoyI/zxgrwIFEW0pcRi?=
 =?us-ascii?Q?kyT6kEv/IVjPy/jle9Se+NL3Frp10ycPvA1n2f2yIkllmW8R7xM3ZVzATbAV?=
 =?us-ascii?Q?ty6ciMlYgdYPDiqV0g8TQMU=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aac52d2-b804-4664-54be-08d9cf64d899
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 09:30:28.9429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+G8EuP37BhMQbZHamQ5QtGF8WtVeRwwkV2rzAkHzZlhWgd/vro7K0fWilCTIH7QRV9q/pcSyTYjeMbbCJV/6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

updates:
* seperate leds into multiple groups
* switch sled numbering to 1-based
* disable inchip rtc
* add flash1 in fmc
* switch spi2 pnor using spi-gpio
* update gpio-line-names

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 277 +++++++++++-------
 1 file changed, 163 insertions(+), 114 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index f973ea883b97..d617cfebcb18 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -5,6 +5,7 @@
 #include "aspeed-g6.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/usb/pd.h>
+#include <dt-bindings/leds/leds-pca955x.h>
 
 / {
 	model = "Facebook Bletchley BMC";
@@ -53,113 +54,141 @@
 		// Fixed link
 	};
 
-	leds {
+	front_leds {
 		compatible = "gpio-leds";
 
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
@@ -228,13 +275,13 @@
 		#gpio-cells = <2>;
 
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
@@ -243,13 +290,13 @@
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
 
@@ -282,7 +329,7 @@
 		reg = <0x4f>;
 	};
 
-	sled1_ioexp: pca9539@76 {
+	sled2_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -291,13 +338,13 @@
 		#gpio-cells = <2>;
 
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
@@ -306,13 +353,13 @@
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
 
@@ -349,7 +396,7 @@
 		reg = <0x4f>;
 	};
 
-	sled2_ioexp: pca9539@76 {
+	sled3_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -358,13 +405,13 @@
 		#gpio-cells = <2>;
 
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
@@ -373,13 +420,13 @@
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
 
@@ -412,7 +459,7 @@
 		reg = <0x4f>;
 	};
 
-	sled3_ioexp: pca9539@76 {
+	sled4_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -421,13 +468,13 @@
 		#gpio-cells = <2>;
 
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
@@ -436,13 +483,13 @@
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
 
@@ -475,7 +522,7 @@
 		reg = <0x4f>;
 	};
 
-	sled4_ioexp: pca9539@76 {
+	sled5_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -484,13 +531,13 @@
 		#gpio-cells = <2>;
 
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
@@ -499,13 +546,13 @@
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
 
@@ -538,7 +585,7 @@
 		reg = <0x4f>;
 	};
 
-	sled5_ioexp: pca9539@76 {
+	sled6_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -547,13 +594,13 @@
 		#gpio-cells = <2>;
 
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
@@ -562,13 +609,13 @@
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
 
@@ -632,7 +679,7 @@
 		reg = <0x40>;
 	};
 
-	front_leds: pca9552@67 {
+	pca_front: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -667,7 +714,7 @@
 		reg = <0x4d>;
 	};
 
-	fan_ioexp: pca9552@67 {
+	pca_fan: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -700,36 +747,38 @@
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

