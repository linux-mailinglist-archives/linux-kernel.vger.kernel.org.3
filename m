Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510A56B822
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbiGHLMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiGHLMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:12:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2065.outbound.protection.outlook.com [40.92.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4843C88F23;
        Fri,  8 Jul 2022 04:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1greFF1tdNNeLGhYTzIuKQGiIDVaJNhgX2xPWLaV8YafX9n6UNjQvu+cUujfFkgrzWqWh5TetzJ5ma9J6k324gPrpWpiyD666Nt2H63hIF2uPoRby7N+H/+frWbB1/yyRNJ9U84aiDU35y11bPrtbxpadWdokw7gF8OuVKt0W1EkcoAugsLlg5s1g50pwKOtelUvXTl5W0KVR06Z45gNuU2A2Mp5GQC+dNoOguRGPpmg/pPP814zirZL907uCTEw+tEcih2l5Yrfz7OoWeqyj6cQKP3TIRBZkcF34564QtJxK2Li1DPSCnmyjAnd9djfN9L3PQ3o5iMTrFacHwWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9txVPO2WljDZnFRw7slfEpHsO7jPhzdX9GJ8a6Rp714=;
 b=apbQPN28ATn7onV20qcLhA5o+q9is3l6QBWo5tkQdSVuB3xBpoNJxK5ip/4wZcqJyquxbEtE7Ieu8PRYUvrKkGVpeMAVEY052JaE8YaPvXdVKMTVH2WMt+Agzmt/row85HdC/WuKnV2NSS1us3WaGP/mZGw+zsXTWM5aYIZvTNS2HbipIiVM56Ffum3GpOP5RMKTuMiWc/Me455Nj4q4sfH+QqX51JxY0swfgPNDiLax38QIzm3hxZBWbDOEXUEcibgrPTjjJsBpQ3xzSyBfed/ddDxQ/gTYRl2xZJIelJMHr5R7aP8niY+1V//BzrWYB6GHzLxCgKdBg1cA+8RVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR02MB7024.namprd02.prod.outlook.com (2603:10b6:208:205::23)
 by DM5PR02MB3879.namprd02.prod.outlook.com (2603:10b6:4:ba::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 11:12:35 +0000
Received: from MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63]) by MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 11:12:35 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 2/5] arm64: dts: qcom: sdm845-xiaomi-beryllium-common: generalize the display panel node
Date:   Fri,  8 Jul 2022 16:42:04 +0530
Message-ID: <MN2PR02MB702479BBA7FE8757E577CA6DD9829@MN2PR02MB7024.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708111207.85249-1-jo@jsfamily.in>
References: <20220708111207.85249-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [MH7E1JzCm1qRXCFHM0syUaAZon+A4uiEstWFyyFCdw61EklUyAeLyWNaNLrCS9Z3]
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To MN2PR02MB7024.namprd02.prod.outlook.com
 (2603:10b6:208:205::23)
X-Microsoft-Original-Message-ID: <20220708111207.85249-3-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 109dc63a-e4d0-4405-f76b-08da60d2c26b
X-MS-TrafficTypeDiagnostic: DM5PR02MB3879:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXREJcOVO+PW2HmIWBhy5RMwQq81m9x4RNKN0oDFPmDidkS2dSLGaUWIxRF4kDnYf1nHO7Xaxa28n0EDjo/PdxGZrkg66w2jssLVGuRFA2va4vuqbLHLF7XStZOCzIu5kacAofyyFevA3JhIXjUCmmdV7WfHHintlLQ9ewfyOju4sXylxKhfRwJQKWp2kXs9nfsZRirwCSU7OrVWs/VSf5Pcilha7uV9sG/POk7+5VAU3XtnbF2BL6wsPx6p+eIgTxzUtgtqJSVkPTptLHIxqZ2xColtFvw/8qLlFB+LUaPowngacLT8V90PKvdHXFVNCdkgbNQRI596svCDLVCiXRUTl9NfW5VYIWiKHmECBN7AuQck9HKJ8tXYnUJl4xGEg03jFbT7wgb0fDzWqrF6qblqxrwM1ndm2vMH953XUJsvdWHjXKDR98taXsij49aLqYvBa7TrhJa8bOTHidw0ZH+sVwPkMuLgQNeVq7aR5Yzvl/WhABWuE4oJ32fc2auw+eOu6RqJXfaXr5JEASBoSwOIECZq8IRcqnyWIytIXQ4GxGGyLyKs/A3Dev5YvCfPcGHiAs7lbi2ujqjnhGwRealBwn457leC0qwp/bT34HYSgn4bxXC9aTXCoCEb2o+biBmt1sGo0b9/XM8gpRFc4Nt1nLS1CBGu+0EX+P5PoOOhKtICQMOSXKuxuWzreHY+OYkG6NraSM1A0L+4kkED6g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+kTH/X8psNMHwP9NP9C1bOYRl54BKNozfH8BsqTFYpZPqKNPkiVV47SjdCn?=
 =?us-ascii?Q?Ca23l3Ta8YFeQOr+PWsJqpyzlh1byzBHKrVllvrpxeH1HVTYZi7xLKD20nmr?=
 =?us-ascii?Q?UO9LsyuC50Dm9V7lcyUXAWo+X3ikBsq9EeBBlMbG4yB1zX9Y1Jw8rVYvuhsW?=
 =?us-ascii?Q?9AKpySZt99Vhkra3uNWSouEXgO7IOELuZMunC19MG/06qi23W+v1ymmJgbRe?=
 =?us-ascii?Q?dRfYijC05SxI+OiOPPjrFu5prfA01NP/qJ9SfDLIetiawWK/7bKYJGxi8JqY?=
 =?us-ascii?Q?i0BWSiqIw0tzTxgCr7APKwc18gT9CJrr3OvLmgHRQwqdhUN7jYNJpebgpRGI?=
 =?us-ascii?Q?CdhxAiq83abDvFbwnCU+8vlawvn51TSMHl8vBDypiTLJQakzuNm6kw6PUrpN?=
 =?us-ascii?Q?3avAZ8vZmLy9xUeQdLDZZGigO65mHPt3H4mCBQHlH3Ok57YYKvlyEDvU+LsO?=
 =?us-ascii?Q?YOYvlDho/tR3cmkTUMM6g5utgN19TCQgyWA9K1X4xzGwOY+I/PMggd6YjkNS?=
 =?us-ascii?Q?P8jzDffgjhqQrxOIWXQyG3jZ851WJ+YwYuvc0eujJ7Uikeee0vQOLX3f7AI3?=
 =?us-ascii?Q?Y/l7H0NzKRf0iXinSTpHgl5V+aJdIBWhviHz3iTYz6GNAj/M7G/9RyfgA6g8?=
 =?us-ascii?Q?H75wcmUT7hRP/sIY/pUcSy5B+J2p4yRiAFEcCpwQLPeVG9VMQ4lMB0Obzc2+?=
 =?us-ascii?Q?o1H2DRix0HDaz9233UESl3KKbC530ux1kCh8ohGFjybfaz10mQ7sBGE49rvV?=
 =?us-ascii?Q?5q7Kr4yJwNuXEzWLjAi2NkvbQGrUAHXr08earmcUcCFN4HvFWvT0596rhGFo?=
 =?us-ascii?Q?a/F0WQpAbZTUpgylOfoQ1PjEWJMwXbBK2iHpI/epBHnq+MYgev1F/Hpjnrbm?=
 =?us-ascii?Q?pqQaoxuISx80jFgtEzPIAnG91smdXee0UwRsj0FJci048/+T+yjPQi8WY0GX?=
 =?us-ascii?Q?ewTef95LeprOzjceSYUpLIpbvUqXducLVxUrZZyQV8macG5JmTXg1a5tI2X3?=
 =?us-ascii?Q?e8VTb7jdbc/hasNZidTKxQQi7p2zPwHBlJxscUNsOZc51/7ByeoPr5nh8RNI?=
 =?us-ascii?Q?eVZGbfB/62DFbZuevJJ4EjjjQvVg+La1/fw9hjilCGElPXMhxTTOOzwG5TqH?=
 =?us-ascii?Q?I8Knyj7+ojh2v0GTAMJ1Fo6XJehfQDIXOLAPTC0OP4gafKBrMIQ9A4/vJbGm?=
 =?us-ascii?Q?zKQ0Nx0p186Tn5ijCNlgmNSEUuTF3aHAJoP6kH8bmA5gId9b0D9Hu3wV6G7E?=
 =?us-ascii?Q?4M2Zeo1CuEysqHdFxmXrhMeLcVooo8txwT6m6FftW/m9aU9BBD11wZiEH7Xk?=
 =?us-ascii?Q?9ymie2BXDhknzN8dMAjgFFWo?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 109dc63a-e4d0-4405-f76b-08da60d2c26b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB7024.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:12:35.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3879
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the display panel nodes generic. The tianma and ebbg variant will
set the compatabile property as per the display model they use.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi     | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index d88dc07205f7..634999cf8987 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -221,8 +221,8 @@ &dsi0 {
 	status = "okay";
 	vdda-supply = <&vreg_l26a_1p2>;
 
-	panel@0 {
-		compatible = "tianma,fhd-video";
+	display_panel: panel@0 {
+		status = "disabled";
 		reg = <0>;
 		vddio-supply = <&vreg_l14a_1p8>;
 		vddpos-supply = <&lab>;
@@ -235,7 +235,7 @@ panel@0 {
 		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
 
 		port {
-			tianma_nt36672a_in_0: endpoint {
+			panel_in_0: endpoint {
 				remote-endpoint = <&dsi0_out>;
 			};
 		};
@@ -243,7 +243,7 @@ tianma_nt36672a_in_0: endpoint {
 };
 
 &dsi0_out {
-	remote-endpoint = <&tianma_nt36672a_in_0>;
+	remote-endpoint = <&panel_in_0>;
 	data-lanes = <0 1 2 3>;
 };
 
-- 
2.36.1

