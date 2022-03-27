Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB84E893E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiC0SLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiC0SLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:11:02 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07olkn2089.outbound.protection.outlook.com [40.92.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB243467A;
        Sun, 27 Mar 2022 11:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWr5SfyPpvFlmZOqavkIbhDdw8ydA9tNXXMsLH6YmyawI9NK5TfHTKznBD4j0/EDJvL+pIFj2lLgjecngRAGMvaT2B1nldTeaMzjIrkvUyjLsZpEzkCK0pAXKV+kzNsRtHGvNWoHMhUoXJ7G/5J9ALswbcICr5O5Ye4IkmVyox/WWLVxALM66e9qXUFA09WZiMaAiEZJt8lfNajaIgoFmqYiaoocQce/4cOM4xJ0Pp8BY90P+ekgP8xK02qacj1LZOJgitGbyftEJ4IPH2hBxjZnLy6acp/T1W79KmXKrKywckuhQP3ruL3HzDoYueToT/KSx/dGsAvYEj7UQ4UmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0eqBNZdW2QwZRlBfTX4mH3GI3a6AWc7lIT/oA6JgRM=;
 b=Iqxr4ZAfYFFdWhncGMk3aWy2K0NEZuJxqpu2HocgYS7F+X0o7nJM4bCPTFHH0tnm9KL/Lw3WSVSKFifHHMI+sXWtcmUuInDwJwGsMzOEDuuP8nQGK6yM4cB3yUfu9q8Ovi7/seHQy28FNwvF7jrhQRDmz2ug+o/CCNsgciZ1KxoZztZxWLwaGQ81WicgENV1nOtUzYz2UAs9VoZJC9qzUHLWFKGs7KGmaW1adw7yzVVrQd75v7RbPcWcx7ZFBXzY04jQc+n70mJkeO114QuOtnm2vx4LQDAQXmTr17+ztz2iwIB9akajXZdAUq93vOfeMtLy6EK9JXCzdxqayZfzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BN8PR04MB5778.namprd04.prod.outlook.com (2603:10b6:408:a3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Sun, 27 Mar
 2022 18:09:22 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 18:09:22 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 5/5] ARM: dts: s5pv210: align DMA channels with dtschema
Date:   Sun, 27 Mar 2022 11:08:54 -0700
Message-ID: <CY4PR04MB056779A9C50DC95987C5272ACB1C9@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
References: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [QS70HMVKJ4/wXVSwn4WNcVUvied2AEaiOPeaV+ScTomIR+qa7Dtkv7Vgs3tXsu70]
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220327180854.4857-6-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a568fe9-923e-4dd5-ddf5-08da101ceb26
X-MS-TrafficTypeDiagnostic: BN8PR04MB5778:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Od960jT5uYPrlay4+oTU42dy3+s4y13140/3WJhRlZGN3Zs/Ub19cpwJoVSBXQmZ8D4afWg9Ym0k0i+sh2jsVJNQyGDGV4x3pM/W9txyQBcWy3IR4buIiQ46dLhxAz5q+513HT3Q2aYjBpNRTdTV9m4oyQ0kuwuiYybinRXSB9KKuMW4CH9kaxlWVvZmf7iC+sdwOQHUhJC+t7CRs5zy8X5CJibE6yDonhuuhWtl73LSJ5QAudwGknrlYTrAZ/SUv5gHIOIljyl/lNdDzuPI8QALpG8JuAVxYwtgpOM+2gN2+Q2bUlBw7dr9kZ40TVUrcga8z35PeLTp0KOjg1WCaief4Cxa5Wu/8bbeYWApWNuYwfKMhyNIdTUqh3qA/fegM6Rt6HJx8BQnH9RLfQOetFRy113sQBz6QfrpF6ykwx2m29YB6I324qasdMdcsg9L/gQ1CRsHgVAh8eMxBYF5XpGdAouks0C7bDA0ZauPuenvT273d6uXe/qyajkS1ariDrDKqMINL9s7hnNz2rESo0OS8haCp5OwF1+CH41Wbwqqpzu6AZxSGkPW416RZtVLdThET5oMz75vMmOk/ow+g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vfcuSdkTyZEWahGv15OAxxFsGMpS6EOwpbwm3sDIpikezNnQvoiwUTxUugxt?=
 =?us-ascii?Q?IufkP5l4JVTZOEZOr5b31IyUc83pcN/5GNTnSFpTxllMC7tasJ9KQTOQVsQO?=
 =?us-ascii?Q?MjQs4ZqU1HQXblPQr8fZX+Xs0E3vtGS+oJKE6mpqPXMCqKhHucN8cDkCdU8+?=
 =?us-ascii?Q?21d1P7po3duC0HKBPLd1ApaeGqsVzLPTEmPW6Xgncfxw2/WS0MYmKzStQehk?=
 =?us-ascii?Q?hD/vOH/1Hsh6JPkI1E2PPbQ5EyYk/kCm7r7ASHs+ilOM0iwjne7wV9547gIo?=
 =?us-ascii?Q?sDNuRw8F+UTSn+RQoKdjDJ/MvEMXoVcGuQJal/s1B+aT26+Kms+7qx9VhM1S?=
 =?us-ascii?Q?2Ao6uMZP4vOLrGfCDnm3qlnqeUdoTImg+NEozu/HagRNwcrAS66s/Fs8NHoo?=
 =?us-ascii?Q?0nfvHxvb2QMhekQxFwa7yKBdosfAT73k6YUF+3ts9COv1GKJq/kHAm01l83k?=
 =?us-ascii?Q?duzvM9xZ4ZOItzRrtjh1CsYyNkp5fKvpRAN5IDkfAaP2nRF+N+Zc05YQUzBN?=
 =?us-ascii?Q?ouywuDbITIWCWw4+PZZXuCMqUc27t4fFLfS9omlb34Doe3cvia0OyTlU8m2j?=
 =?us-ascii?Q?yJ/AgpCqN/b1JEJill1xQSAVqbtaZCVkJkefGLBJ13jXP0BJyB8v7FWn1iNz?=
 =?us-ascii?Q?fOGhQaer0kUbuO39p0ImSF1vVkGm+vYxx30DrpqJ0u0aWQ4dzLTt8b/Lejxp?=
 =?us-ascii?Q?QUR8iJEtvroNxOfD6GzTjAookDHalbBvl9t7MwNJt+RhRBZFTv9HthLIBvCc?=
 =?us-ascii?Q?tgz9AtV4WbhxFmNflGgv42oV++mn5XMi86dIsxPk/6yDNjJQqkyoXkFXf78O?=
 =?us-ascii?Q?Kg59ub1OVd15k+rY6927Ocp9P3ftUsa+sRS/Dmk8J1799WYR7eGkkAKZXoRZ?=
 =?us-ascii?Q?t2x9jqv97nayQ3fbwSmdYXtglwOvsvM6jMLHb5nts78EdcA851MMixt3fpur?=
 =?us-ascii?Q?ClIPBncAq8Kk95dTpRwsOElrUsnJqSXTWu61ATyqZ7IDLW2vFhSty7A67PIH?=
 =?us-ascii?Q?Cyy0dH2f7L5+xmyeQllk/gC4fMSJHHLXoZajW+j2afDAHs0VPIK9aSl3Xk6o?=
 =?us-ascii?Q?OoEzVFNFeRIW8byHTMlt0zj+vm8uTf7gR6NX5Y8R2x8qE5tvwlW+0UvAkDkL?=
 =?us-ascii?Q?u12+tkzi3//8PSsLHWO+28m/2PSZ+mPRdBvv+WLFJSipi7rLRO02c2ENvhTo?=
 =?us-ascii?Q?EDiMbCnEX/K+Ga087mE4xY62S8/bZOv0cDSjomSNWWD3JiXJe424KjHWrYvB?=
 =?us-ascii?Q?DVrIgKYYBc2MEfr2eMEocORpJiIMfTx4srZ9L3AWfGYBufeERJajwou5DHbP?=
 =?us-ascii?Q?7Y6y+e8f/Xmb1hkuvMDaoSkyH4pDR/pkzEZ7lHYk562Ogpt8ZBmtk/cm5yE3?=
 =?us-ascii?Q?/y77wQ8KDmTnG+PZJVqQQ5Os25aYMzvNMYd4OgllcZj1+2+yrKgqqSdjFeuy?=
 =?us-ascii?Q?tzccps6tnErPhpLHMq1i65xeT5iBQanweOcwATaBcR77q0NdXGtFKGbObsqe?=
 =?us-ascii?Q?uXjrSLQ/Dvp7ays=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a568fe9-923e-4dd5-ddf5-08da101ceb26
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 18:09:22.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5778
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

dtschema expects DMA channels in specific order (tx, rx and tx-sec).
The order actually should not matter because dma-names is used however
let's make it aligned with dtschema to suppress warnings like:

  i2s@eee30000: dma-names: ['rx', 'tx', 'tx-sec'] is not valid under any of the given schemas

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Co-developed-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
Changes in v2:
- Use pre-existing patch from Krzysztof, adding change to s5pv210-aries.dtsi
  which makes it continue to work
- Drop changes to the sound-dai-cells
---
 arch/arm/boot/dts/s5pv210-aries.dtsi |  2 +-
 arch/arm/boot/dts/s5pv210.dtsi       | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 116c507da028..8f37e34d08a4 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -635,7 +635,7 @@
 };
 
 &i2s0 {
-	dmas = <&pdma0 9>, <&pdma0 10>, <&pdma0 11>;
+	dmas = <&pdma0 10>, <&pdma0 9>, <&pdma0 11>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 0bccfb9d0c0e..6a22b899e21d 100644
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
@@ -259,8 +259,8 @@
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
@@ -274,8 +274,8 @@
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
-- 
2.20.1

