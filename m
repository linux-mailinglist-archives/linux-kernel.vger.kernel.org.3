Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E5C4E54BD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244992AbiCWPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiCWPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:05:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2063.outbound.protection.outlook.com [40.92.23.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEEE5D1AD;
        Wed, 23 Mar 2022 08:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0P0hfADIuSOw5dzKNO750yybTXv5B1+rLpi6EDqpqtifHM4wK2BJ5vJ+nkiVeZyx1RdxMjOqQpaCHVTCwAWechpTfrIQNmQdGQrC2CuOQnL1Zd9UW7fE2bBFvd+Ia9TZ9fsI2Li1i+Z2vAMMh+3/nP986uVqxdz4tBhhv5JdYQyoraXTwNcYw4Wi8rEAAjPBmjY9BnfEDjOqeHzBPenYPw4l1ywfsQomiar2is9AOVIX6a7D8Tg/t3LFMdcy87GPlhpLBLM3zq+nTj+89luErapRwSxhVNRP8ely8snEvYqSqjXMvQ5wSkbxZ6nISKEYCqeBJU0dRyPLNB3aXrsKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf3/pK5DeARVgV+VOBVtbAGEk2HwUFjUbPT/Csnsik4=;
 b=LERWnxTgQTaTsfAdTujBSxPSrKR4b0eCXc8H02ylQ3F1yhC2RAXZyd01fhYM8cKC1KKIB9VtyFXXCTqjV6XVohc3rnh03lWv2cKq3xp3cRuKBimdTbp3RG8cz+Pryg9uo5fj4zvSVSu9u2D7pdKzCl4sWRZvK87yxaRxTDl8o6W8v2Jh2vKyPixAxiUf1PIISY3zBzUsKXKFCmRHQMSHxKNiLW2mq9GFxdxBArAf5U7QTwbO7cQMBtcRSTrUH/ILrJCznc1FaRo1qzV2hHXv+QLY5qxPqBwO20C4ZYIL61QsbB0k4yyH2SeYBhgas+G2zHAjTiGn8bVCxZ+p89mLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BYAPR04MB5638.namprd04.prod.outlook.com (2603:10b6:a03:101::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Wed, 23 Mar
 2022 15:03:26 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 15:03:26 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 2/7] ARM: dts: s5pv210: Adjust I2S entries to match spec
Date:   Wed, 23 Mar 2022 08:03:06 -0700
Message-ID: <CY4PR04MB056784D54ADDBB4F57F82D4ACB189@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [TQtYdL6bv1cgAY7In5drmxY/W/hEfVnWc0RS+CZRgoUyaMetHopieTgGjYt/CV06]
X-ClientProxiedBy: MWHPR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:301:2::16) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220323150311.26699-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff0dff2a-6998-4c05-98e6-08da0cde487d
X-MS-TrafficTypeDiagnostic: BYAPR04MB5638:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3ELMEtPI9zRSefAw7IqjJIaiB2iOEwfOUr4WjsZkSn9PlVv5OOuvQiq6TyV4/GKBLPOZ9yuXEhQY1PYHbYKNwJEDkyg8ma/0CbJsRAGN0VkOogKwc6zEw5D7RqXu2cJZE+mH1kB9c2wHHPWEh7MOhmHT+Fbs+rckbu9gpe62rsP/Mp0p5TtNRpHlpAsrU+K279ylCD5GKP1KQzuf9DUWPWHC4ZNU2bT7vdxnTrOaMiGS0aNHQ9lYiTO6jSMmYo5ZCd3zYj6M3VIWObbBrN1nQ+uWY53pgtI/PsizUA4gG9noutLHDnrifwSMJb3Jd1MZtpFE0eDHpQapeSjbm5ucN7i4+aQBGnqnfRDUk9QyuKiKPjGzq+tjAcQjO7rtb9zV/nVcqsJZICigsHf7zux+lELZeAK7pYjodeqmljPOhSs5fWfi8hbX5rx+Oj86yKlVZZ0wsDBsjM8ZkthVTHP+UPXYfViAH1GpnRYkbrT49FGXzqc6Qq8S1umUg/hYdDsSGubCEkR73S9PnsO03p2H/avI0WhLyV84HKWsagx2twoGxCdhE/Jtq2IhkU/LW1Yhn7Yh28Pt3j6aMq4YiPpeg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WKSxj5rpsVv3B0VQ/kfLkWRRPKhRFvZIZ1GYyM67Lat+8Qx4onMuWnresPjE?=
 =?us-ascii?Q?jSO77dPnsS2r9k0ZbX7GxSNTh3kAqbTfC4JgROL3qQpryNkzAdvrV7qOAkYJ?=
 =?us-ascii?Q?ri7+JVp70qbUvC7TXb1twmF/VUNlWzvovJfrMF1PRgsdokBxfpoqvbYQKptK?=
 =?us-ascii?Q?4OnutkATZjWMjm+Sql3G8cika7fnDL+H/XaudSs1hB86lXOO9HaS4715/1Dc?=
 =?us-ascii?Q?QVrj76CPtx1Qq2xLGWyoE0GG7CHfPAg4Q1Gz674FNkRxc+QwNouS0+H9RrX5?=
 =?us-ascii?Q?MEVxYSb1iY24TLWwC+P7TfQfDrQI4aZSoFIijtpyDG8vbtKh7wRwukHiLEOf?=
 =?us-ascii?Q?tlgf1eKt5kKPaz4JQpBU8roh0A0YdistQhA9osPgj5ip1SYzNTNrpbXBt3Qy?=
 =?us-ascii?Q?nqPwqOW+e0vPqfMQu7SgrW5ARvbUKmAJOFcXky9MFiiu1x9pl9FmtBAn6ULs?=
 =?us-ascii?Q?oLZ/nyjI3nFOurKf40CUSmYu1ylt4xug4Sdy7VPzO2wAW6XuoZ36bXh3HObk?=
 =?us-ascii?Q?dl2YToWd/AUkT1C+PlfKUqaK9dH/jO350OuJjo5sDe03fbSuYLlL7QmRHmmc?=
 =?us-ascii?Q?l8PPU3QEsbGIDnByrXflcPkGek1uVeRRcS/x9T6jmHWEHChJ1EzaqKo7uahm?=
 =?us-ascii?Q?bXCiDc2gz6SMSx+nlpvP+mzo1aXEX00h3M9EF8iZrVTlYn1y0MN2qc88ukYb?=
 =?us-ascii?Q?pY2oCtX/5Eo0WJUsXGG1ZWe+0vAnckem2C1hzB1xgYh6ab53cyuHpGzMEnYi?=
 =?us-ascii?Q?Cbu1GKPr/y97PasQtmuXGrrkvHHMmHvNpu7bgS6j3e2Iam6S3rblZzGvQSDm?=
 =?us-ascii?Q?3OERB8BVuiphgtBtCthuHZYxynWLX32pncSIEvOq4CLXfy0eUbXRR5bYnoS/?=
 =?us-ascii?Q?5NIJlRGEhXDpUQrzgxRIee+RQbF3+mNcrcvg7WY6R43p8ltd+62F8fj0UOUz?=
 =?us-ascii?Q?kWowzYb3Zn2/HZE/jaAWiAuqThrv1m5Rt4v6H21BLdQeCJtgTxfD3ACZof8h?=
 =?us-ascii?Q?V7NY/3bFVlU7AccuyOdvhHwhGJXGWRacoAC0hpTAHNMMDgpEiP3WvL7scdM1?=
 =?us-ascii?Q?VVlpv0uS7rUEtSuR4j2kru2nt6HWab1NgxgpRgw5q/68JG0iCKdZdQqsIiH4?=
 =?us-ascii?Q?bANwlp2zqEYVV+93deX8sesU7MEBYxp4HT9pUgH+5UbiyFG10wvly8okwuEg?=
 =?us-ascii?Q?tDB7YdFXA4YMRvqfkSgjud4MHZ8UL9NshyMMYg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0dff2a-6998-4c05-98e6-08da0cde487d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 15:03:26.8559
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

Based on the device tree spec, clocks should be ordered tx/rx.
Re-order from rx/tx to avoid warnings when running make dtbs_check

Additionally, the number of #sound-dai-cells should be 1, not 0

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi |  2 +-
 arch/arm/boot/dts/s5pv210.dtsi       | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 70ff56daf4cb..503b5a50ef1a 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -644,7 +644,7 @@
 };
 
 &i2s0 {
-	dmas = <&pdma0 9>, <&pdma0 10>, <&pdma0 11>;
+	dmas = <&pdma0 10>, <&pdma0 9>, <&pdma0 11>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 353ba7b09a0c..56c1d9a19570 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -239,8 +239,8 @@
 			reg = <0xeee30000 0x1000>;
 			interrupt-parent = <&vic2>;
 			interrupts = <16>;
-			dma-names = "rx", "tx", "tx-sec";
-			dmas = <&pdma1 9>, <&pdma1 10>, <&pdma1 11>;
+			dma-names = "tx", "rx", "tx-sec";
+			dmas = <&pdma1 10>, <&pdma1 9>, <&pdma1 11>;
 			clock-names = "iis",
 				      "i2s_opclk0",
 				      "i2s_opclk1";
@@ -250,7 +250,7 @@
 			samsung,idma-addr = <0xc0010000>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2s0_bus>;
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			status = "disabled";
 		};
 
@@ -259,13 +259,13 @@
 			reg = <0xe2100000 0x1000>;
 			interrupt-parent = <&vic2>;
 			interrupts = <17>;
-			dma-names = "rx", "tx";
-			dmas = <&pdma1 12>, <&pdma1 13>;
+			dma-names = "tx", "rx";
+			dmas = <&pdma1 13>, <&pdma1 12>;
 			clock-names = "iis", "i2s_opclk0";
 			clocks = <&clocks CLK_I2S1>, <&clocks SCLK_AUDIO1>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2s1_bus>;
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			status = "disabled";
 		};
 
@@ -274,13 +274,13 @@
 			reg = <0xe2a00000 0x1000>;
 			interrupt-parent = <&vic2>;
 			interrupts = <18>;
-			dma-names = "rx", "tx";
-			dmas = <&pdma1 14>, <&pdma1 15>;
+			dma-names = "tx", "rx";
+			dmas = <&pdma1 15>, <&pdma1 14>;
 			clock-names = "iis", "i2s_opclk0";
 			clocks = <&clocks CLK_I2S2>, <&clocks SCLK_AUDIO2>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2s2_bus>;
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			status = "disabled";
 		};
 
-- 
2.20.1

