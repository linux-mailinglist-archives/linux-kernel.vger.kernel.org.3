Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B7E572C49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiGMEYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiGMEYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:24:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2094.outbound.protection.outlook.com [40.92.21.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5743134C;
        Tue, 12 Jul 2022 21:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+mqPzepGQ9Qi9qNrSH1yoIo2EWbWAcZJWdcLj2Kka3aMeiRsPKzhhmrq4ga2YP9NZvnZMQcZ9WcDPMKUHiDghYpXw7REHZzcwo3CKzbBY9qN/9JAXMUVRDXTakIYsMD7gCr0iEYBKhzKZvg/jGet6fjULAh45fNyxO1cA523dTc4DW77Z5XsI8QO/IevqDfLs/b+r25G4iR9l+tJBvIPV44jXzV3vB5tLgmZffOrTHn8MH2Pi6xQv6J9gqceB8ky52g0U94R/SyrP8o5c4PEKnBFr6nd1nGdv59W0yKpUbpsk2E/cKmgHysxafH6h0/EQ0GV3Fk/m09KpDaCxkpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADzwW0U05ebyTkNpofJdIS3oVCXmUceOW/nhbkNyjtc=;
 b=AZlildCiLRr9rfG2vCHBuSe8lDo34myozdqZtiFvVHr71AWG3PogApMCE6gNvNTihndjmUx97Wo8WrKfmK/pRN63fqdoYZYFP83jEuO7n6RMC8ME6bE74IE78n2h/sGUDM6LBUWn/TjWwvHD3Y0Uy2YMILhE/ObIQMvSRm0u0DCDuCinusYZ6xq+aYVc0hi/fShA8ov/309GyOKVq5uxNgt8B5gIGwQcCKIkZV93smbHlpWe6/Dqk0TMrpcq+PwvBcZAaq4AOm4qDc9x6lj8Te7AHwQvrVLohv9Z/DfNRWmBo9ZJu1+OKHiKvUN3xrStQg/Kt2Q2+r7P45StiPds+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by DM5PR02MB3895.namprd02.prod.outlook.com (2603:10b6:4:b9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 04:24:12 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:24:12 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 3/5 RESEND] arm64: dts: qcom: sdm845-xiaomi-beryllium: introduce tianma variant
Date:   Wed, 13 Jul 2022 09:52:47 +0530
Message-ID: <BY5PR02MB7009837DA8013CD87287B403D9899@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713042249.31421-1-jo@jsfamily.in>
References: <20220713042249.31421-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [wH/E0gDRnCmH9o0Rn9t3/a3RXoItcqN4+mNwA0y8n2bEM25Cw+Z2Dq7ad2P9rtOO]
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220713042249.31421-4-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 491a9190-dedb-453a-0112-08da64878991
X-MS-TrafficTypeDiagnostic: DM5PR02MB3895:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEfeo1Kx02qwCNYNdrE8sBGfVUGl8lR6gQhcpoKIg/Ycc8XtfmsHOe/oU9tg389Zl010JSvZYV5k8oQNXNYJjFShR7nnKlsSktl8e+y0yIWtztPybgQ0RtcMhkEjEAXawVVxUYYFVxwpSodzzqTYdcAcJ2QfTK2QDIV6EYFFZT8JGgtDzY5MRLT4ZcE3t3KNtRszbnNTA/HQLryTwPXolvELwGj3EVQvC1KavpUjsKs1z13OPIS+nSIALU0KwHB0aiGPfpvbBbcB/O/wCoHxaYt5wO0GExqDzv2gWLPhBjRaAgyxSN6RC8EzWwcxH0DmqlM1wz1My+yf7+og8animNzqxtdPOQhRe/m+sBPgkVSgMARQnVdV4KjupoZT4heN6j33j4Xn92R3FerpkoQ/ofxLbGAqCGTcEbYyS27L6jbwfTy9yDLn2xMqE/su2HBh140ruqpa2dNoR59whokSGCCnn9UC6Dfm8IyLTGsutaZwEzbHaJN/ZerjNaxwGy4tTAxaphvLdcmLqMI8oRBAjIojQzDEb+UOl6dqD0WTKeM7aJ1HMrDmDmFV7YOKZjUSq6nbWShyCKkcUBeHcJlyUxIAw/FuJulFyhv1Vrhxq3uxbHML80XkPcs7auYMHPE7IBxDhPs2wedz3qQzic818YwZsnQxDyyrPnszA/joxzfBd2w9/eyzYE8c8PrWXs+N
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJE5keDIR/s2s5h4BneOu1K1o8YNXvYvIVfu54biRKJBrVD5IpSNLu/ZuW9z?=
 =?us-ascii?Q?/Bmz7MRkY5htbxJKUznFjG8bU6v+7n+UVzuF+f2r6OmZNdO2TcgdT0VjrQ26?=
 =?us-ascii?Q?/kEEGZD0Vlih0QCtlOHVGXEG9W6fmg/mTA7VWdqzOm8We5jm4/fkqY4AqcFY?=
 =?us-ascii?Q?KTk446AlpZ5oTPuRNWz9U22KlQGiFRlFyso3o4dZFrpaLFEBfEfrPwxC9q8M?=
 =?us-ascii?Q?oUZQu4707FCuAqr2Uwq8ljGWLhuqhWvLqyR2zcBOz09/+jzEhDx8JnoROwTt?=
 =?us-ascii?Q?yy7+B54ebwQz5c47R6ba952M7i08b6D04nlsxAxnlt2UkwBd1OtdiX/8Uyzo?=
 =?us-ascii?Q?BPtxw5DJw0XO58wF6qQQKhjDr/F+5BKlbv+ruMFOVq6ojltTkmqayKLbQHB1?=
 =?us-ascii?Q?97rx9qEHO999jNT3U2ylTTw5KtI4vhDHzFQ4sI4l3tgqC55794SKw/xIBSAp?=
 =?us-ascii?Q?L8qZI3WD0FKylKegEnvGerGe67DNJ5k7P0BJd0K5pqAxO6FTNAF1oWTrvE+T?=
 =?us-ascii?Q?VQPQ3PrySbBDhsqTcMJEwvuq6pUInZ8E8NJ+EjSPKaYKfNNkHQkO81Obyn3N?=
 =?us-ascii?Q?tThr9LDxnqWanGPmqc49pVwyXP49gnORb3gux6CJ3OciqJkGkDkclFqM8m/D?=
 =?us-ascii?Q?b+NFpzraMmmI5ox86cR/842LTF3IySDXqlqxWr/l363w4rADA8zmqsL4cHbM?=
 =?us-ascii?Q?/TCfUpBsK1SQee66ZB6XZUbUoCT1p1lM9zV+yE6pKHuzH5QuBJHEr+qN/0Uk?=
 =?us-ascii?Q?7cE6uevzT/mNWkSd/Mos+gZxehNCZXOD03nbpXK/6RRvAaieZIeLSRHjz4bc?=
 =?us-ascii?Q?3dj3MhWy/ncChlNkR1jg5wkWYhOUH3T2+VuHr+fKUGj6v6tMiWSuqL6bA+4i?=
 =?us-ascii?Q?IYVBs2Ivgnwy704CQy3lLG1zOdmmegIo+Yzr/h8UUcqtMiB1rLWHM78OoFAN?=
 =?us-ascii?Q?WVyEfhNPuY5AimIexo1ei3Zea4I2qaDRVJcijcIX+AyJmqCM7HQmGSvTUeDZ?=
 =?us-ascii?Q?vmwshlbRfX+lFwMjmh7RgrpnRWK4MHDwn3H7OYyAZj0+Flw3A9V9vryJ8qYK?=
 =?us-ascii?Q?6EdZ51KMbanlqtvnbpstsFKevh+qWbUo/UTtbO+tqVX2A3QODfb5EHjAMWvM?=
 =?us-ascii?Q?x5YIldzn941PHXb8fPioiu+vI6DP4jGZoZscF1cQRRaxUFCcMF251ZNhG8ON?=
 =?us-ascii?Q?989dVFUcaIcby31c5ZB2f2KSuYfZl0XQFogbixZ+779a5XG5idEukIxu/NNi?=
 =?us-ascii?Q?BcaByDEoO2zZ4iWaAaySyYmV76tK6tvBxEt7OX37XYaLCv1HRYJLbiW06iSc?=
 =?us-ascii?Q?gzbbNJLsF5Shp2lW84k68I0L?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 491a9190-dedb-453a-0112-08da64878991
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 04:24:12.2221
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

The tianma variant uses the Novatek NT36672a panel manufactured by tianma.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
new file mode 100644
index 000000000000..97bfc1c67eaf
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-xiaomi-beryllium-common.dtsi"
+
+&display_panel {
+	status = "okay";
+	compatible = "tianma,fhd-video";
+};
-- 
2.36.1

