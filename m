Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DA94E8941
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbiC0SLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiC0SK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:10:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07olkn2053.outbound.protection.outlook.com [40.92.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4114E34656;
        Sun, 27 Mar 2022 11:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5fT/8CxbQTGc+j6fiW+O5nwRwU12IqWZ01xOXpm/LJYhv4GhRgz9dZzKpLTbVBEBFieLxheOd1r8Znr1mUj8Cb/pg5ewW7FbNhzx/xh7sdqGcuWgkOOMHhpQS+kinOTmLSOA03czXunWs+hdJhJDyZ9h1/9LWJz3/c+LnESaO3Q1zrfB3tI7SulZl26I8GJ/rqEVrjmSL1aU539xATD7cVO7lecPaURFTW1+VEZzQkyzIc2vqD/VlT9+nexC07wcbiq9LpzyCmIaUAynutR1S/nlsfxb5op8IB/OyKRCCCbdcGN/TckafrBp/Zsh44o462Gu61b4CMfpE5FucmPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv+7ooUARPAzKlw4ps3s4rr4U5e6oufJifd70YDYepc=;
 b=ga9cPIbs2IixhGb+FABK5vHeS8uAd7PNWsR8j1zmb66jZiCwJXyZgwPh5gmRXWS1DhCVQG0Qs2ouAem/Tazk9YfcWkojiRlw+Wsd1MLisG05ycq5y8N6IKl1279FNtb5ZxWs+fkC2I2Qp83+Lx1LpvFqyCEwIVKGQS/FuM0tybtUyzPb2efGY1buXVKcXNaqoM7zg5oVjghaH9zOw9Gbkr1ozSyMaMRVT2zyF3h0gkkaJxcetIZWbVPlL7nqQZ5a5w776IJAtUVk+alIyxVj3EE8k7B7uGqdiThodoYoUviKpBOV5TNc5ZDtxAI6UnoJi2uEhwTEynTWvyaY21fvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BN8PR04MB5778.namprd04.prod.outlook.com (2603:10b6:408:a3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Sun, 27 Mar
 2022 18:09:19 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 18:09:19 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 3/5] ARM: dts: s5pv210: Adjust memory reg entries to match spec
Date:   Sun, 27 Mar 2022 11:08:52 -0700
Message-ID: <CY4PR04MB05677849A13F41BF603906DFCB1C9@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
References: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [yl+6Tu3fgPOJfUjUIe6Azwd5ekzE23BD9s0vYJLyMC1B2BmnDLuZpDsIwvWsvTrS]
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220327180854.4857-4-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3033aeb1-db7b-4cbd-babb-08da101ce9b7
X-MS-TrafficTypeDiagnostic: BN8PR04MB5778:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INmCne61l+YUuktzZvlyFUY88HveecOkJa6Vdvn87j+ml5KCvf+vQadn/SKem+FkgGnUdOAodkh00Qz0uw+FVsFwRJE6nDWOwh6JrTQHiENVvecvCpNaQqIhSED0BrGV9X+VrW7IXwoyYWdiFjj8HsBu9mWSbSGQk1TWqtTm5WX8wkqQfwrublycf9zGzKw9Jp27sgW6MlihZHOigxuqhMNBKV5hu/DnJvaIdetseL7UhfjTlNkZC3ApXZvhFOenQic3DitvDq3ETYSHbCEbaEXAhOOQJ6qXEBMi+Z3iemaEGn1zdlGIjnORucp4+qpdCwdcrESqWNGTjTCyBBS1onn0nogwGSYz5Z4GQHjsiHXHqombALaxWZazwr17+OiPIn9WHIGgsvc4a468xAmV6F9Z83S3Czlc+0pWe2MR6Qz+4i99bzSouI9lYjwDJY9Z2cqYiPtvgmcrtwuT8Xn5gUynfFoJamBlbJ1ccBpHBiyyClU0QjmApB80W0LjhKBVq6MFq4jaKoCOdVZvNp1mfvK/m75lblasxGU9zjyEYfpZ7ohINSk7iEH8T39F9UwgViE/Q7A6nhGJ4ICS7QROLA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HTqW9zXvKWGJYo60r7tV8r+VlkLAGdQqBS8Mma7215vMpRutjeBNOAbVqNhR?=
 =?us-ascii?Q?KpBQFn3REM1DNjis/rSHZwIoxFhPuMCZc7dUA5LWBnhD5oUNRhGVa9iaAovs?=
 =?us-ascii?Q?knKhvis2u3EMXOutLl+5qTPZJjX1DZhFdzj9JS0bDWTmnacfoak7thI4/q0P?=
 =?us-ascii?Q?EutJFPtVWGQ/tIV3AIadL3EElGBl/hj487km860Ft/liD7KVfCwXAPOM5/KC?=
 =?us-ascii?Q?IamyfwPU9FhcJzzHK1MLyDWxPPkteI0IbvuJWhBx0MXlzza/EU2dDC0dNDcw?=
 =?us-ascii?Q?V5iZfhtfcPR0VL7gKMOa4eU8Na4hZaMKfSb4y3pfutGq7PYfGqGtYvqxsrc2?=
 =?us-ascii?Q?dlCQLiXBhYRH3qy+LOtsdRc/4aH71wr7RZMX7uoHKjGZ7SFlFbc9UVKuQ1gK?=
 =?us-ascii?Q?ydG3zjLhkPOGBkrFik8tbWCYlI+0sVlViKOB85CfRTF0OFNuuvgnvYPf9A3H?=
 =?us-ascii?Q?TchPLNtMu9wMFiPct8a5mbz7M5b9ovLYZ0OlbBXEbCMJ5TXEoFIvV9bFgDKt?=
 =?us-ascii?Q?NdIAd/i1AGIo2UVIN5FbqzxHZObY1ehSBAg66DtAykOsKbEQPLsIXsvS8eGx?=
 =?us-ascii?Q?hcbIHvWLjTMTI4Nrmozr/7JAppYPYdClug2/ftSMjMVCGNByj5KPLAR4PwHe?=
 =?us-ascii?Q?AvrM1iiXo+2J1d0HUy1ITIycKN4ehJJTB9x8OkTarQS8vlnxiEPYq7VwrOiA?=
 =?us-ascii?Q?7iWakYlFIzUfKESlSjDpa8/Gk3e225rBYp/dlK/BdORU2zBZC4GljQj0GkU9?=
 =?us-ascii?Q?4asIA7EMqtFQbz1b060jTmvtOxQtOunGqRJSAQAymGpaikaSpo51JZJcLCkD?=
 =?us-ascii?Q?8D0d7hfXThGPZRl7ELdPSSQ9/KP2ytIhvFaf/9YjwWmzSSNV3E3cS+xbx5k1?=
 =?us-ascii?Q?6+5QBSucY8J5spxfY7iEokZEMQrNWz54GAsgI9cCg3oIKjHPY3lU56HjIH+F?=
 =?us-ascii?Q?xfxHnebCptZ5S+y8Z6YDE+SUO4xJ9OECcfngNZYgl4V2JVGkbcXpj1hROxC7?=
 =?us-ascii?Q?EGSKD3uJyV0nKHrCJKlyv3t8mD87zcYPvH+POdmb0kxkN7hTM62awh4lTacI?=
 =?us-ascii?Q?ddqFNm+jE2OGUfpHnUkPsRhu1qdVJ681W4Nvmf0pPb8O6NquZl0VkMYR6eiy?=
 =?us-ascii?Q?UDFbsrFfc+c6/aQ9pRuOSnmbiL2sFB8sP+6JoihkRXBrizqsmTZYdfEGeUv+?=
 =?us-ascii?Q?EHLiDDVti3ghDAiXYZile0FlHezHGjxC2ePFvbHEAsbBYNeMTqAQrly/ZgP+?=
 =?us-ascii?Q?2SJ85dOL5vcjbUoqb006fvZQF6z/ZTqnMvZUGJKkcR2X1HvlnrUR9nWH8hD5?=
 =?us-ascii?Q?jfJ5cROf9NkWsb0TUyMpDbiGPirW0pCnTFnT6jXb5bfebyIPHZo5ZdrQ58wS?=
 =?us-ascii?Q?DrHDQWvOKMHShcv3syU+1ykSQbmFbjAQiD4M0CQn+XY4hHxstvPJkNqT4opm?=
 =?us-ascii?Q?GEZZzehgylzH3wTKv3o26NjitPkR2djlHNgXzGTz5d4rvo1XbmzVqIJFsaXa?=
 =?us-ascii?Q?KqsCE9nssXLaWqs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3033aeb1-db7b-4cbd-babb-08da101ce9b7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 18:09:19.6200
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

The reg property of memory nodes should have pairs of offset, size;
not all memory banks lumped in as one.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
Changes in v2
- Adjusted so that there is still one memory node, but the reg
  entries are split into multiple pairs rather than having multiple
  memory nodes
---
 arch/arm/boot/dts/s5pv210-aquila.dts | 3 +--
 arch/arm/boot/dts/s5pv210-aries.dtsi | 6 +++---
 arch/arm/boot/dts/s5pv210-goni.dts   | 6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index 6423348034b6..79014a624e4a 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -29,8 +29,7 @@
 
 	memory@30000000 {
 		device_type = "memory";
-		reg = <0x30000000 0x05000000
-			0x40000000 0x18000000>;
+		reg = <0x30000000 0x05000000>, <0x40000000 0x18000000>;
 	};
 
 	pmic_ap_clk: clock-0 {
diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index cbd378ac4e18..116c507da028 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -24,9 +24,9 @@
 
 	memory@30000000 {
 		device_type = "memory";
-		reg = <0x30000000 0x05000000
-			0x40000000 0x10000000
-			0x50000000 0x08000000>;
+		reg = <0x30000000 0x05000000>,
+			<0x40000000 0x10000000>,
+			<0x50000000 0x08000000>;
 	};
 
 	reserved-memory {
diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index c6f39147cb96..d32f42dd1bf5 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -30,9 +30,9 @@
 
 	memory@30000000 {
 		device_type = "memory";
-		reg = <0x30000000 0x05000000
-			0x40000000 0x10000000
-			0x50000000 0x08000000>;
+		reg = <0x30000000 0x05000000>,
+			<0x40000000 0x10000000>,
+			<0x50000000 0x08000000>;
 	};
 
 	pmic_ap_clk: clock-0 {
-- 
2.20.1

