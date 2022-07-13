Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5483572C44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiGMEYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiGMEYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:24:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2094.outbound.protection.outlook.com [40.92.21.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399107359C;
        Tue, 12 Jul 2022 21:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9jdSuBAuPqkZMOCKYSobG8t6RVmgMomsqu/7OyXkm6dZuJMBFeJJq5n4qTy9kG6fCz0iZnHcmXDeAYYKJ8T2YacnRNVUl5UlENpuMToFlX5ss5OMdJFCuDZbXE3xcGz/0035WZQXaWjtXgZXYTGbfzEssa40avQzcJiFvh7vNgjBFKpFfec/WwpQVCtjJf+Rz336WC1mObWCZu47wisSYUFsJbNu+PA97uXc1nWr34k32KBNMDKGEw3MixfydsNFgWf1w6s7/Oi+VVpIjHRwgf2A1jecCvvbvqXxVtm0B8GK+ERxXgDe+xDC59K0yqyPDiR4Y+OgHWbYpcuFOZfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx12e5Eho5JgOJICQjDkueNFPtE/+Uyedc/9+ZtY+cA=;
 b=mOrlp8TaOkycoVkS4yg9Yoc3D0mHwxWkWsaRcaxdoTkz8bllMg55Kv2/OE2lk/WpW6uhV0goS/uhD5/u8f8vag/fxc+RIhHElTxZdcA2a5mimjwAUm9fwr9JKj856wAxzS46pdRyA7Iz5H7gO6cqaOYcNGy9zqGj+WD+XEnj/L7xQJc7DZQtRhirAnxBt5x9lRqtFguV42QZZGxut03JFSOp50ZtVhutmk+SWdJgjfGkXNVah242xpBmXBCt4p30fTL9k4eJP/s8EBffWDjAC1G9Kgbt44T7/WBEZq4+g3GgjKamqg+x++HjFvjltRJBuONyR9FC8mPm3ZRI3fqbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by DM5PR02MB3895.namprd02.prod.outlook.com (2603:10b6:4:b9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 04:24:03 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:24:03 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 1/5 RESEND] arm64: dts: sdm845-xiaomi-beryllium: rename beryllium.dts into beryllium-common.dtsi
Date:   Wed, 13 Jul 2022 09:52:45 +0530
Message-ID: <BY5PR02MB7009A49AD394747ACB80F746D9899@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713042249.31421-1-jo@jsfamily.in>
References: <20220713042249.31421-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [fHfxKGShPe2F76tjCyiCMHyqA00b0OqeHU+/S29UfsZ5w/OUkvhNqbkusDZ/e6D4]
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220713042249.31421-2-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a789f7-7bd0-4d22-7b26-08da6487845b
X-MS-TrafficTypeDiagnostic: DM5PR02MB3895:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RUVjKIKqDhz+loIY+iYs8lT/HtNlMrMMhoVuW+5LsB3u3HFVcp6ysrdIdE3uJYCDp/u6wHq5dTbjSawsWPbo/7gMMrvbkEGw2OTVQq5+a8QjfVgaGFB2eyshnBaNUXJeOoaVEGlWvPL/5YjvaG/uU1zeXG0vvVgLbwJRLjF5qgBxVmac8ca/qy0fPdAYXC0tCQonI/q28g0IxpI3GYcDMt3IOMQ2+pvIjnMKnTwN27/j5hx6i9Sy4au9wewHKdkY/u5Km+NEKWbElydv93Y66GcL5vEI6PvunqMJaD9VEAmio75AER1L+hAHkDo3ae7a0hVTt1eQHBMZVet4t9Sh6JmSFckngOcXvBbd87QqOWia6lMmOMFDPTXdMulJa/abrQoJJsKOtyuKO01uqvA0c+yy2o2CVbEKg7g84jBPSJOT5clvGykO4bAesFAl+eJ90Zka7HoirYxx3Sd7L2rxEh0VUPBbPR2hZZEdye0kcgSTFGExmcj2G5DpFQNKtTMXK3B5HlWSOWWmtvxFKjFLSUKZ4eTpVIvXxY2ZbxuomXv/QM+PoGqCJM6aqF+XSTnPDOCtzPzYkmGgUVSxScxNUPwe45oZ7Z31QVcP9IaOxqRcMmnspvWVjlB902xSz18RShjoyGY7lxOv4cRXGvJpUo3oPaXyAn1nCYHqisOxrgRjaSJKug67jNpEpwY1TdqMR9i2WDM2rffbNzyxkvoqg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pmobX+XYVesmXf8WYld86Tpx+CejaFHhJQjsGYtjnnwvLfiHWFoZ/SswCY2t?=
 =?us-ascii?Q?Jw+qRjL5JIrBRmrHqALon9hCYQ2ukaDsV2UcTQnUcLYha4zfrqE9+76Hxv9Y?=
 =?us-ascii?Q?BCFoYXs2ORGK6iB+1kqCZ7an1ANcgZTE6RQuO9wFtVII/rWINauWieen5sBf?=
 =?us-ascii?Q?cKlyvB3EMAt5anQUm6E2p9q9Vok+bz8Y64ftN8/J8Xi3cekTfAK8ugBCIByD?=
 =?us-ascii?Q?7RFs9yDAlzB83IJfpdqmWb/Xzofy39IvV4tCrJVebH1ReAZ6CDpc/XJ3Jn9K?=
 =?us-ascii?Q?CB8OuL9pYlTKMl9EacoP1ThJ9eMoeFILzkE9zPyKzCTBtjkKL5bHl5jC26Fy?=
 =?us-ascii?Q?K2xRx16lyEYN7hvUY3q0caAKy6iLztr4ZXR/Gml+y20oDxcWO4FbEmdaT0Qp?=
 =?us-ascii?Q?Z65FuwM9pXCfE/1UO3YSSsfwz1oYMaLjCckuLppYGg6t2UphnXD7FdRTORut?=
 =?us-ascii?Q?OAAZIID7GlQc7oivsBf+DLKp8RDXYzgxBtDPJiVuEpepRTZsrNByeBuJGGM0?=
 =?us-ascii?Q?8aSGS3DehigTO697haLnxMd6zrw0dfoQzosb6/EGpz2eghffq9oXicAO2IuD?=
 =?us-ascii?Q?bOjMcZRfRyjsHChrOZGS+34vOiNbLMHTtGYVNMCeQK5byrAo5ul1SRnON862?=
 =?us-ascii?Q?Fe0jIzeL/w71Xrjd86D2Qzr2pKCtF/qyIiD4F3RsxVGxZCzDAiXPnUm/BYMz?=
 =?us-ascii?Q?WCDCDg7xjoPXcKtQLg1qUhFcZJ1EpNne2JQpmTblXXutudsvLcXtQGkM/AlA?=
 =?us-ascii?Q?VJyi8U1fgCzfwCdPHH98oZWfKFN+H1OWrvemj4QnkGDD3rBb7/TKPNQ1yT+N?=
 =?us-ascii?Q?1bgbyAzabfS1nUS3fmwMmJqoHUVjZwg5IicYiqqsunHjMum0kD27CG+rZ9hq?=
 =?us-ascii?Q?vzTX2izI0UAkF/0VI9l1Si1UJVPzPe6KsQuIS14F3HEBqQusrX4M7kRySSFd?=
 =?us-ascii?Q?rgVWmvBL45hsZlw389ZBfgxzfVSi+TTdLKp4wt0ks+tRvCdnwS3jnGZo4AO7?=
 =?us-ascii?Q?2MD/w5ZfJdTth3LFtduYaDSR5xiIU8QDI5P5MFD1hixLbFWUlpAdKGV3EaeV?=
 =?us-ascii?Q?HMXIppBP6nbqBRSnIGg8vS1O8n+CdbFYnVaRc4Q6KiYzMJ0NNG3BDT/0ayaX?=
 =?us-ascii?Q?hhwDVTJUKpgBY4iTRojh2UgwLTTZcAzGOca4H+IK1W1C5zjX/8pX3fKmhOE+?=
 =?us-ascii?Q?Lits3rcqRdAFIOAWWMiOWV462b1oYVCWW/0nSdQp//cKAtSNj62Xq1Zhn1s+?=
 =?us-ascii?Q?Ib0xvPShWMldeBxpIq0YprINnSQR8DmevrTT3KxCRke5xCfNHAUuDX1owOOj?=
 =?us-ascii?Q?6LJQt3x0zpRx6+OLG770SpgL?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a789f7-7bd0-4d22-7b26-08da6487845b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 04:24:03.4514
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

The existing beryllium dts file is converted into a common dtsi file
which the tianma and ebbg variant will inherit.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 ...5-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (100%)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
rename to arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
-- 
2.36.1

