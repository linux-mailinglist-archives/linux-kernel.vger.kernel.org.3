Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD3524A82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352729AbiELKnh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 May 2022 06:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343571AbiELKng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:43:36 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 03:43:33 PDT
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.109.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 999AD65D26
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:43:31 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2109.outbound.protection.outlook.com [104.47.22.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-ON1_0Q35MvWzHiXY4HjlsA-2; Thu, 12 May 2022 12:42:24 +0200
X-MC-Unique: ON1_0Q35MvWzHiXY4HjlsA-2
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:57::6) by
 GVAP278MB0406.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:37::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 12 May 2022 10:42:22 +0000
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7b:8f0a:1d7:60f2]) by GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7b:8f0a:1d7:60f2%5]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 10:42:22 +0000
From:   Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
Date:   Thu, 12 May 2022 12:40:19 +0200
Message-ID: <20220512104019.19725-1-andrejs.cainikovs@toradex.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR0P278CA0154.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::9) To GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8da1c0a9-fe6d-45a2-08a8-08da340418d2
X-MS-TrafficTypeDiagnostic: GVAP278MB0406:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB040620CD49B9888821056133E2CB9@GVAP278MB0406.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: E0Tlj3cJSt1vfW1E7WJ0bcsHItqmqTAOiRgdFsZF6z7ExWINlWo8QlSdK4kt9pFT2YipDpEea5rWmmudOvEefJCLkYSp8XQpsVthfqopWhrYod45UqiRxZ//VB7hm159arocVYFTAb/Rxaj9vP/ggHDf14/HckvnSc9Wkz5FHBVfThpqDkr3MQX1iJsSQ+uu4chEJgMlC5SNReQSg0fdTRpBthp4XeEvt0n8qOh0nSVHn8JuNd+XccECceP4JfX4By9okcKwq7qganHJGoSXzv/ju8hgrjP2I33y2M9XRPO7Tqbe7tJYsnf0Z0wyYrAhn01r6aEbvg/UaPstjWUZAGvg9WV67nMCKqmfuKD5btWt9/8Unc/RbhH8OEpW2TaG28m+ufeJWH+m0uGqgMxUA6lvLQtpW04xAnkUPy9elrZ9aM0rUa+h8ZmloQx99kylNMyHjxzX9s39ENXJhm6GA2L69akzULj3ZXCCpjVbB0U6AQ1gDFpBIJFibj7WbbSy87DX3csaRcZHkoklIFgTeTTytvAwtFMsJGFqHdywJTDMgTyJYu/yQ4XJ88eie2viPUfX3PIkPqTGNy/hwh95eB8MIeAnSgnkmmI2sJezy2yaZ9uEjKE/y6kdDzzVamiEq91fAuUe+Ikj5Jj0my5XDglsCXJhl15/gDNK5A5+VSKxvWzwZ0WzR4p3hbKaqEJQ278kqvthEaR7v7GHHOOJOmCtJZnnOqrQebcfBTGURgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(346002)(39850400004)(136003)(376002)(366004)(6506007)(52116002)(6486002)(316002)(54906003)(7416002)(186003)(86362001)(36756003)(6512007)(26005)(44832011)(1076003)(38350700002)(38100700002)(83380400001)(5660300002)(508600001)(8676002)(66556008)(66476007)(6666004)(110136005)(2906002)(8936002)(66946007)(4326008)(2616005)(15650500001)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qaHjhBPzWD57zf70evWcK6zHURO0TSpW4t63uz54IGkLgOghKnmwfERKhxWD?=
 =?us-ascii?Q?+gh8OiyHFOihbuSpSJqBpyvlBXupQvAc17QYU8AuiWd9Lu3m5pYSx9v9no1f?=
 =?us-ascii?Q?YjWsVN3QBTPOYZuo4GvIAf+6P7HB4V0/RGtxAheVCOWNthxVZUjJ+/OwwFWs?=
 =?us-ascii?Q?r4mgi3jtiSckXzSkdB+H57u4zLBG0rfHoHCp2WpdqlytKuzlw3mc5868IHwX?=
 =?us-ascii?Q?K0aws7qvP5DXq0F4Eu+IsLIllT33O3lfoKH085WYaFHX5BExcJETkFrKAJrn?=
 =?us-ascii?Q?8C5QVeVq79icIchVvAlXk7L1dPd9+HK8RcDh0s6kvR/IKX3PQna2oqLryBeR?=
 =?us-ascii?Q?fyvynjq6tDLPVe6Tnn6KjnXif+1bImbaUuu/MKwW+xH+CP9BTFvgpsxEKiSf?=
 =?us-ascii?Q?zS9H1GbYGJG67o59ltP6ATqZTqdFG2uUqzilosXPtBYq2pH6gK/Q1U+n0vn7?=
 =?us-ascii?Q?7gn9cfbgG+JKrhKElR49cazOTxYCsUGHbEJ/LQ6IOlmynDaHu2BgomN++dym?=
 =?us-ascii?Q?GBRt967PX6vddX/fSYX/IFCH8aH8RBitz8NNGVZE173Axdr50yqlLCwAiWc1?=
 =?us-ascii?Q?L1g4mwdfvoUCaJ9NQ6iCCu93DvZMe+HkQzRxTE8zFpE+cvm+g+gEiJODBEnS?=
 =?us-ascii?Q?pl9smRgL+4Wb/A0w8tQOiJoI+sFaagcX7z9cQHw7DAJ9gkQ/JMC58pPPeGsw?=
 =?us-ascii?Q?mXbxcjFjC2/ziQ+oz+oPCla+qmQnBy3B83B2rwINsF0tn8k9NsV1dj/A4tfs?=
 =?us-ascii?Q?AcHdgZG4k61lFfLe5sAxMtQG4Bk+3GxYdjbysdbY1vqnsYkg2PNY6nrjANXF?=
 =?us-ascii?Q?WWNr8o04PmeNy9mMF1bP03rcpoPMHGZN3e0fqjA/Y5PdUkOye/wNkcGufczO?=
 =?us-ascii?Q?N5eU0XnbDICcdvtxmkFvWkbrzFUP9lFR49UeI0CCjclyZz6sNtV0/UT1ZUOh?=
 =?us-ascii?Q?h307lwHtt0pEsNmdSGQ3yBRxGvzM2eYOCBB4dyZGdJ/J28w7zSwgdogcsFTh?=
 =?us-ascii?Q?4Fso4fhkUzi9uP9PBJV9eau0QWaJrrJ/6szM/Nax6hvYIAUKYqzVXGiKQLng?=
 =?us-ascii?Q?HE14e36xEj53NOoLdB5FMqvsGQVGh9igHTPcXhE4ySizNDt9SoTiesBZPw6d?=
 =?us-ascii?Q?FyVFqUR6ABDKEwUS6lhJtxqbryJmpIokUrkSsq8XomvD/lxkvzZWefC/d3tn?=
 =?us-ascii?Q?Xjjll5noUIUbpaAcORU+hBXvycHzl9pMiPInR5yf/XFlkFf0PdO4TuJsq5ct?=
 =?us-ascii?Q?fo0sRP4KRdm3nTP1ibBU4FW/knrL8mlrPXMSJYb6zZC5jQBdjLIJNO/tisP/?=
 =?us-ascii?Q?XfagMenBdn4s5Gih/dDsJZnfBrnCHSgdxgVNR6vFC3E3/HA/cHEXjB2AMNYU?=
 =?us-ascii?Q?I1qtQthG5FOFJv+yNZpce+tyU0/BWiIiFmUs0IZoYTPa1ciZyJFbPrV9uyxU?=
 =?us-ascii?Q?vSqQxpP7sX2mteO4BoxW43g14L8VXK93wSNTEg3W44uxasstwQ4e4ShVReUI?=
 =?us-ascii?Q?POU4pv/Zsu1Kg4zcMpUI+lUdz/f4OVVwQCJNR8rDXeJTiwANhP9IRoYmmaqn?=
 =?us-ascii?Q?ReX2xC7eeTO6ANVD0t7AkU1931PceG3fXxcty2Do7NrZBUPdaWWiV3rd/KVT?=
 =?us-ascii?Q?oHEsbASEH+ZdyI19a6dPbRRZSX3yAiUbXeX7dhE/MQfFSoIyFmnl4mQtd+eK?=
 =?us-ascii?Q?ySDFR6/ZW7izP9J1ux85onu3GMXCjGYPsKANxJjfb28ynkRe+8rKNZrH/otK?=
 =?us-ascii?Q?3iWy4Z2G9/1iyUNW1pdYEM0XF80FHiz//y6FPf7trDVaJ/6SZUFE?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da1c0a9-fe6d-45a2-08a8-08da340418d2
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 10:42:22.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSVa6hcYhYzH/eg+XHjRtIQZ7Pru600D57pEDq+Io7be3XT3VJFWgc/p0TZCVvSE0sr+RXsKXX/ltNApLOr8ECCS/GOc8xP8SxUZW0x+7pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0406
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=andrejs.cainikovs@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update SPI CAN controller clock to match current hardware design.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 0d84d29e70f1..d309bc0ab8f6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -32,10 +32,10 @@ backlight: backlight {
 	};
 
 	/* Fixed clock dedicated to SPI CAN controller */
-	clk20m: oscillator {
+	clk40m: oscillator {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <20000000>;
+		clock-frequency = <40000000>;
 	};
 
 	gpio-keys {
@@ -194,7 +194,7 @@ &ecspi3 {
 
 	can1: can@0 {
 		compatible = "microchip,mcp251xfd";
-		clocks = <&clk20m>;
+		clocks = <&clk40m>;
 		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_FALLING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_can1_int>;
-- 
2.34.1

