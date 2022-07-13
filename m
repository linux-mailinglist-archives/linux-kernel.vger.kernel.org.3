Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A94E572C48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiGMEYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiGMEYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:24:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2094.outbound.protection.outlook.com [40.92.21.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522D64F65F;
        Tue, 12 Jul 2022 21:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQTaUuni3vJae/RplKcNjYJGAV9AbA5ApD9/VSQoYbsvjDxaBZAf8m9t2ZQSLtymKGpVKFYvN4lMn7oSCcCggFpwzg4ooFCON9EoPbXipgeKmUkO4Hf3nbcyCbZJiFV1LiVhdOGKmxWQy7x4pfu4po9jPWWLW7MdTE2TisEaj85OStAYfEVJYcy971aR16U0jj4KWeo9lGPWZdEYgTGzgmfM8aF8831UEgKu/yxsO9LM+YTxhPiZ7ap/aV9vB49G7mhADqceot0VEVbYk0poQGB+3ph7UQJ0KpMQHvyuUTwmj81gvjgkoVd43RqNLAl361IFR1nCufILf8VCYPzkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9txVPO2WljDZnFRw7slfEpHsO7jPhzdX9GJ8a6Rp714=;
 b=V6hvRK5fRT1z0HXDHTp5WXTpzbNFIDN87Yeyxe41px0b9T65yyXspUy4MzMZrBLoBIYrqdWrZKWVWYYzmNBDdy/0j6zwULsHqYAAqcNDavNUILgqL8ON++A+XSlPXBIWgqTnPBJ/Upa+obbsJwYe502ROznTsOqIevuFoCTtwohr0KkV6OmMvOgZ7Tg8b+P3Qjq2gn1Xa8Z35/atBpGxHFdARHY+urkBV9Nahc0byIEc2zcsLeiVB+0mRzx6fqVofRw0JEwSuVRcgSDi2GQVh98eOxEc6umWQVv1ACzCLpyM5jvALw6SHQ4n9WddnQLiY8NvX1SfeJvKlVzB5PepJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by DM5PR02MB3895.namprd02.prod.outlook.com (2603:10b6:4:b9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 04:24:08 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:24:08 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 2/5 RESEND] arm64: dts: qcom: sdm845-xiaomi-beryllium-common: generalize the display panel node
Date:   Wed, 13 Jul 2022 09:52:46 +0530
Message-ID: <BY5PR02MB7009DE8412F42B479303CB1BD9899@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713042249.31421-1-jo@jsfamily.in>
References: <20220713042249.31421-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [KdzLKiB/GxOngtn/BBk+crPgXEZC+b9lARS4JXJrpu4sF++yO7QBku11ErJLLq7W]
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220713042249.31421-3-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 486d4aa9-c022-4815-7a84-08da64878754
X-MS-TrafficTypeDiagnostic: DM5PR02MB3895:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Zd/bQHDZ1WxphOVjsPpwq2hbOYWz4+Hf+QUfHKFHVOzC3f+EcM2/7AYHM6c1tu5pcCh/3KVATjcquajDxDV1HUSpcbVsy21QA2l4JAaOhMaxrImSWP7xpkZuFA8ng8+Uj9JDxNTmmDlTsHpfwUcXYKvjH6+tewfAj4HmtCxSvmvunBSmX5ZGl0XH2bFxMobQYSIwacaWcLZ1B3dfWVNu5KMj6Pz+R338pwL6X6RQkFsXg1h4lzKQS2TFzjWpDELCtRBcC1yCxogU6uvte1V7yodtBTJLLtYFMbV7yUQKphz/rLAODd9ITZ4IhXJ/Ln6X4DkW+4qfrWqvpr0V7hQL2lv0UfqX5iHgetDCXvdKV871NoQuI7yumuTQu3fsIDDgpMJxyT0+taFHboh1XByw1BYJpglj4s/1rzcVu9OiLV/Xl0y2Von5rP0SsrEx9Hu4BbhqqA2Kofa8PyOwK4oYU448OcOmZ791xH+JLChNrmmzT/vtKDESTeMI0Bu90hPYDRlEfYyYqtGk8WWnPyl3JyF3AmXRMsSnRZdxuXRI6NqM/nYa9+pl69w1CgllF6OUBbkr/bMn9BamxWVjMrtsaHOYb3rL8mm1OpxACvhhKITD23yy1lcpSkuGjI+0lnWsJ4V5HihNw0KAS1mjdCP6WDOutPHStXyi1Szf6h5giBKI7XEDBN4IaiEuvgbBVp+UAObQkQiDvvs0DTght581Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0l2h//dW8KD//W/z4JkfQ5sPwfl2l/4XlGn9jcxHwb1hf3jSza6Q8ik9VVF4?=
 =?us-ascii?Q?CR8zUhTdvI3jjNxjgT7Lkriotjrx6VNMHSTBahnVERkwTbzgVWhUaYwp+pxM?=
 =?us-ascii?Q?L0TbnchbZmnHvno0Oluwx4BLfR7UXwJ2nnpENC6RcKMwnZmmMmIHBDr2sCJO?=
 =?us-ascii?Q?AkgajqaK0gabfnRybu/0fxwYcs9TnDXxAfNoLbdIi/8osAorGju9dAo5YcSo?=
 =?us-ascii?Q?bnBpAZVnNqTe7EU1Ye9fIPiGmaz3shJg9njoKZO1M4RxAuPazpm6fn97tWhA?=
 =?us-ascii?Q?ULCZzCP/ZXEA2ut6ajaG4Nmz45bbI043yD6GSXSzoSTfzbv4isG/CKUpMnQs?=
 =?us-ascii?Q?E1sg9wfbQ8joBhnWVtJ1QFXggaLIjMOqZ5xwdwkdZ3DRuBa4/c1cQEt6aow9?=
 =?us-ascii?Q?R4FNwU35mjNuhMrIM6KBjIlAQOQ2FjnVE+jj3aailyXMM8p5rXrky/GeFG/3?=
 =?us-ascii?Q?If3TtLHmeN9zzwqpwJwLJbnAXPfWm0n/Eh6IVhzezbSBb+25D0yL1M+4jF/D?=
 =?us-ascii?Q?4KFGZWNaI0E4R+GmY3dJubnFgyw7fNEIHbiQJSW3FHiNP5+gALW2n2w9lKYP?=
 =?us-ascii?Q?/zALtuERUoZh8F+00ZHT5LUyMblXbFXkYwepgvMmrQHOzUl39bnPlXSU0nwV?=
 =?us-ascii?Q?yob/bXdpLG89dVYgUcswu6V35gpffkbUoIjh3OdscG+KsIxthnxLOm0vVDnc?=
 =?us-ascii?Q?QKBrt2HCigK7cB8DuyUcoqMjnnKuiZFlyOOSV3Omzi5I9GEM3gitLS48VTV8?=
 =?us-ascii?Q?W3Qow+GlcAhlb3EgIX6YV+3iGAbMpmJQakPBJ7AWPttR3NKo1rtqvVc5ndcg?=
 =?us-ascii?Q?l+dNWXe/nSJq6CmDpcTQnKBeH2TNrIeKVl3hgxYdmrRloA1+CkIQAJ7lJUB0?=
 =?us-ascii?Q?pGggeRgl0T1pYm/LFUYE/AB3vGoSumbZDlqplGrlgVYsmGP9nIa1GEgM+UdW?=
 =?us-ascii?Q?liWp+YW18RldCnFEkQeAtt4MYs9o7ziRmdniVcp5gEsEefg3LwRxPdZQV2hG?=
 =?us-ascii?Q?ZLqsMiOYtbSVQYgAJkUVi1NypuJkDYDiYIYg9/dlETGdersI+9ZxFf3qiW7x?=
 =?us-ascii?Q?betzRKOkD5qwbMCmpgVurZALv5D/wbOdpxTzxgcPjICnI5yaZQfBop/ruhvY?=
 =?us-ascii?Q?yOEiuMUauxiWFOFpGmmP6zRDMqdU7vXvCZvqiYvktnuuMR4bDFy00RUdW9gr?=
 =?us-ascii?Q?dIRsn+a8TnTAZzD3IGkYHwuzxdZ6xbafyVjGL5vRV6OUXT0FcXAr0rLvoZ3J?=
 =?us-ascii?Q?82IaT0DCY0+ntb3RSkLNGtksk/+H76Kw6D9MEzolSUgt3LEUqkocVn/Dw0Gg?=
 =?us-ascii?Q?AKzQWwuFR3dHP5jv+Av6wwNh?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 486d4aa9-c022-4815-7a84-08da64878754
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 04:24:08.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3895
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

