Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A822572C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiGMEX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGMEXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:23:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2103.outbound.protection.outlook.com [40.92.21.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CC2FFEF;
        Tue, 12 Jul 2022 21:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5SBSSg0Cv9LBvsleY6dHLz2HLKZs7B1R1OLDvl8eGztv/9LYTw8u63w4ku6G2SislpeOFybFVEShc8K10R6+vIT2CmUk/8kQt8on3eOa+YVcB7ii9xbiwi+Oxy0rZd2pbvIK85Up3yLeFXZL4hcGJFzGlgKUkpRLFU5pvVcV4wOuLWvBQMTirsPu9gmJJHJogO7TBy7aKqDH7bkmRIZH8gbpxhIZpoAMtnRDv2Y3HB8kKx6PYiJ4MKGFEpAiilTmkbczO+IXrqFs3oheh39kOyHC0e86ssJWgKVywnieOBcoJqo4Vdb+tsKqX25lMfdCF5ycUV68qrXp2fXLEswog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26v5y3Qipq5N1HBy2yjP0zBQQBTEIIrvKisDK1XzNgQ=;
 b=N33yp4o33LcnIVkHafKOMpNegPrWeqvT3BPyR9jn5wwSgIw5lQMAfFwLeRY1XJNugtkWvdzhSb2tzTvKfXRUdOaoTXYarRsyTmBAV/1tpJ0w5IOKMuIFkmSp32pofA3HMdAeqr8PbAX8LQSmdT+lEs1euT/Hut68KPgqHjxRGZoTZB/l1XIbGubMA6UcYm7Es27jiCvMMeT+HLi606aZ/9ow6QaeQK84OlbJGAa2IyLNyCn1VVcjTlNW/05gDLnRduMMx8Ot5kIqH5BFf2dlqyzdqGV9DdJVeCzopqjEyN/kvQp/iU92/vyuYAKlwn6S0UMxauMlTlm67D9R5PRfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by DM5PR02MB3895.namprd02.prod.outlook.com (2603:10b6:4:b9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 04:23:52 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:23:52 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 0/5 RESEND] Add support for Xiaomi Poco F1 EBBG variant
Date:   Wed, 13 Jul 2022 09:52:44 +0530
Message-ID: <BY5PR02MB700954C6003BC5D5B6AAB1B7D9899@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [JLWrWJacZHO3MtgHKWQ6bweeyGOVDZ8x7yes6hnJhEsT6vsStF/t8LURtroULGT5]
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220713042249.31421-1-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07dabff8-bcfa-423a-e5c7-08da64877d8d
X-MS-TrafficTypeDiagnostic: DM5PR02MB3895:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqJ8S4tKNUJ6WQ46+9PmMDMknzXJ9DpSme2DmRYgltPSs8qp5Ewc8j7xOjLVqV4Qol8ms9lJL3apzyjOQOIEsE7FAZdsOgVmg2dBJS3VSnM87yWPjkNkSeLLTt3RoOXw4wojIQhfTE9nII3iAlletFcHpVKOrmuOE+capjt3aHPxVrpDFT/eXKawYeoP8eyM5/F4fhXJtXB/9zJ/v+UtZu58pvcUlnwCp6rj/RpU/m/7T0utaaYBftW2MwQmlnk3uPyBQpKtor1j0DdnRzoQglPrY5ZGChFaBTTTn09cda1gSwCZkD7s8SVe5rvnshMdxewIeuHJtNhWO4F7XJGLZV1TJT9hWPxmFW/0oyY4Uil7D/kz4qqbi7WX7BrsyIYxdfZfzRe1QXnkn5XsYWSeJNs2FXR25xgumocDjInPXzOsjFt2u1jlarScrX8EHIVI4I4nNI/rRqjQj3RfitiULWhvhfii+RV5AWl4W2MtKWBNF8Q2ST5pgSDYgqlKteV6nOWjWSHpK9bwMJQ8GX/p5XzaarYN1UcAVeXjR19Nlsd24BaEyZeEftKfInsA7ZC180HRFG+GdwSM8OEDquCjMuK2TjMnCSgkntzJhNLspTCEnXRAXDC17QNH2CNZQrf1sXKWBAylva0563fUX9NypnW+tyttQ7gJEiDIMKf6rkVdPCE22OvxVgaRTqGLy6kxeErnWRBzmx/oqDT3eGQwOQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8vgqnp4a2EXFfn91BhZNPjTNgUJLeTH8iNeXu4PYJZTxhgbXEfOYl0cGKpbE?=
 =?us-ascii?Q?i9lM95StRRN6z2EHWkd+AWMMkvHJVOrKtIpVvZOCTpFxe1fXF93ZMUC+ZTue?=
 =?us-ascii?Q?uM57X/kkdn56IzwBMRa3ZgR4cBOb9uPlw0x/jYW5qgOgQX2Zmjph7Rs8/l0H?=
 =?us-ascii?Q?j3m/PVeNXt3sKG8mzPd+2d/c0x6vnI8rGHsiJFYvyof1PhZucDUr9qTO5cvl?=
 =?us-ascii?Q?1nVXFz2lXc5HzJUJibPqWWHPRrK3h9WsmdHgWaXdHaoszv/jUZEgk7OngMqk?=
 =?us-ascii?Q?fTQUk3ORnrid8dBtcNkgmvrxtVOulNH3zb+aK9KiSR+esxLolSMu60WVrWmF?=
 =?us-ascii?Q?4H0xjNIHkkaJI7oV02+ntrYyg+sljl5CZy7xlDC2XnmohbDAfIrU1f1VcV33?=
 =?us-ascii?Q?36tiHIXnxMu9Hie1bgDqHcwsNvmQuvND68UATJtTXqToVRWkSYa5b+tgoSri?=
 =?us-ascii?Q?I/7UtLEnOHChBITA0IjZIj/Ai4tnPAguI/XE1KH8IWcdaQ87wgPDz4fF1Yva?=
 =?us-ascii?Q?O/aM7jAT9j1OTx2+lL2DeZUMSIM+sC86rnjWZK7B5RaaGz1ONYqrH7B4qlgO?=
 =?us-ascii?Q?esQHie3Z4uIeETpMEvl1O3q2ofvEOkHVQ0vEBzc+lSVHMJY4bfyEkQ6nEuJM?=
 =?us-ascii?Q?ufAuwGMxQSu/Qiir049o9g3aHOZRPspssRjy9QsadKLvNvEGd2LIYiCFyIzQ?=
 =?us-ascii?Q?b1vKLRDx+mdqTZhSzlD/Iu5INxZhydFpc8Vhhgt9+MygZ7r0eNT12JqikcSN?=
 =?us-ascii?Q?M3Bjull/5s82Eof+Rj0Pntti5PpgFqrkO2k3JNac9+NwciRmR4WxJvP2sBZK?=
 =?us-ascii?Q?18l4nS7uCCMATZOWznpGm1SPEqd8tM901pBQ1xqQt+WivRRCT1XGcM9G9cAr?=
 =?us-ascii?Q?iuVS/ESE0zwv0P2lQAYrr/gBWxY5alFhdvHD129vio3RA7UYpW9pnSy9A1vg?=
 =?us-ascii?Q?ysWSXfnDlo7EONyNFY3GULZzCt/8ClSy2fFkRa6YWVMttqMHAwdDq3dc83Qc?=
 =?us-ascii?Q?4qX8hMUnPCqXJ92nnLkNTR4sn7+pq1N5GaOUa6jD/siSINackQEvMMTiyUef?=
 =?us-ascii?Q?CJWW2KU28IePpUaj0/AhwyWUuOFSkeNbOc5nJ307j1mngOdtD8xvpNt3IIZx?=
 =?us-ascii?Q?zdzCVQI3i74ASYkA5oBgYSipaYuap53p6em0mq1t+D6qDcPDjjYFyx3XSjkA?=
 =?us-ascii?Q?79+kMLSDhQlzXLYeew46EUrDiiey+0LgjeB5Ea2PJMGfSaP/7d8CSQr6bG81?=
 =?us-ascii?Q?rUoDdumJp32fLEfDFrHGvtKu8l/jLB2nAOF19b0UXc1zbFHBW+dEksIJOfgV?=
 =?us-ascii?Q?rCJ+Q7BjyuEJ2CqQDzftxYg+?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dabff8-bcfa-423a-e5c7-08da64877d8d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 04:23:52.0066
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

There are two variants of Xiaomi Poco F1.
- Tianma variant with NOVATEK NT36672A panel + touchscreen manufactured
  by Tianma
- EBBG variant with Focaltech FT8719 panel + touchscreen manufactured
  by EBBG

The current sdm845-xiaomi-beryllium.dts represents tianma panel variant.

To add support for the EBBG variant, let's split this into 3 files,
- sdm845-xiaomi-beryllium-common.dtsi which contains all the common nodes
- sdm845-xiaomi-beryllium-tianma.dts for the tianma variant
- sdm845-xiaomi-beryllium-ebbg.dts for the ebbg variant

Note:
-----
Both the panels are already upstreamed and the split is based on them.
There were patches earlier for both the touchscreens, but they are not
accepted upstream yet. Once they are accepted, we will add them to
respective variants.

Joel Selvaraj (5):
  arm64: dts: sdm845-xiaomi-beryllium: rename beryllium.dts into
    beryllium-common.dtsi
  arm64: dts: qcom: sdm845-xiaomi-beryllium-common: generalize the
    display panel node
  arm64: dts: qcom: sdm845-xiaomi-beryllium: introduce tianma variant
  arm64: dts: qcom: sdm845-xiaomi-beryllium: introduce ebbg variant
  arm64: dts: qcom: Makefile: split beryllium into tianma and ebbg
    variant

 arch/arm64/boot/dts/qcom/Makefile                      |  3 ++-
 ...ryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} |  8 ++++----
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 10 ++++++++++
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 10 ++++++++++
 4 files changed, 26 insertions(+), 5 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (98%)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts

-- 
2.36.1

