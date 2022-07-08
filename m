Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4470D56B82C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbiGHLMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiGHLMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:12:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E347A81490;
        Fri,  8 Jul 2022 04:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4sx+AKml8XuvlIAnhPO//+Ra/Cn5jb87snrutr0u6FnOZlAX1ACSdFzCiAw/6OvlLxfM4qE1NSyseQpKcE7SmCy1HppG3WGoWIXr9X22eXUGcYgafw8MhfalRvky/BX9onsmIYqdkJes2A8Cu/Kps5r79u6d/59h4PZe+NgZfQLGHonTQzzpL5KETpLkk+fLruLczjQDh/RIbRJjCDhh/L6I2AKHa4xIK2NNmcWlZxNzdpzJtCphb+WmGbNwjyex23WxgXH9f/ayFj0GSXMobrkoINCEEjqx4F1E+HOW+WVDE9pUy08TFaH/rT5yvXoWDFk/TAM18e2wHd74fJEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26v5y3Qipq5N1HBy2yjP0zBQQBTEIIrvKisDK1XzNgQ=;
 b=lKfMN9lm8HeWHUp0GGKC7uwgpJLL0q50p29c1NrT6otuq0zxjESGcv/54BblCDunygzjkP8dmj+VuTGjD8jbFI1VWM0Z6vIXaQE1/L4dnOsHX1SYe8fENY2QUkiE6IXYRNXukRkzarw+3TejNiNj9Yjcn5lMoTih6FO5Y4ItqXTCVIWkzlgYWu1iftsoNWtuT0I3tldHa8bpyhWzPIfoffgSUHnzLK2rwIGw5XXwWivj+zZvnksKop5SGF+C748c7gKQ2QKGZMun+43NALCqiIH5xZNQQkg7PJQRVMlSUJ3MWOgJ3nlvHU7L6k0CrHiZljgACL+ogZ8g5/DtUtaNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR02MB7024.namprd02.prod.outlook.com (2603:10b6:208:205::23)
 by DM5PR02MB3879.namprd02.prod.outlook.com (2603:10b6:4:ba::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 11:12:28 +0000
Received: from MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63]) by MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 11:12:28 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 0/5] Add support for Xiaomi Poco F1 EBBG variant
Date:   Fri,  8 Jul 2022 16:42:02 +0530
Message-ID: <MN2PR02MB702415D7BF12B7B7A41B2D38D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [f5ZlqpMiNBqLf4yC7ptIf04HUKvUWTcjeFbOy+1owsIT0nz9kkVrTHQ7Lg8RGSwG]
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To MN2PR02MB7024.namprd02.prod.outlook.com
 (2603:10b6:208:205::23)
X-Microsoft-Original-Message-ID: <20220708111207.85249-1-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a3e509a-ee20-4ce0-a520-08da60d2bdd9
X-MS-TrafficTypeDiagnostic: DM5PR02MB3879:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rZYYPfS7BoQ5WDlfsYv1IlLaTd92ryuOUFvunmJodmu60/ZuuGAET7deWDypZ/at47HLqGmFoAiR0cGQWWAMEP9SSgI7Irei9X6clNaUgigfULNkKz/VtKhyxmHPq/BNnweEUbYlhwVly/K0h8KCpDn8tQbAXggsmXuwPQnlSi8ys6sCXS9/MQT48dJROacVA1HiAOvDJisZDjddMbg9rV0mrCGRdDYTxFqKhCzq56hL6dplijWi3sqalo91NGQtxB1hzhL1WVm0iObGtVqWyqZHP0L7tPdSQmW8gk0/jeYQZ0443Dcsb2Ao4r8/P57rY46DWK1Wt8jXSIP33duklYWQYGOhBgndw7omNqw5hecaoXFOEjbo9fbhVynTaMD6NeEVWAt6Y/fpMwRTMnvEs5pIs9eSmKac4KkYspfpio8czuComqM6T8Zxna38R6WuVVgKHMXi+SSkdAhtFBrN0p6+Ude/bXaWCtGgSCRDnyYLg+5uoT7NSFXsgNLaZKJW8bxVPJC5loOj+Spq6R7ssRwWAdGD1UM1lqAhca6iBnR/3UVZCwFiLDyFFyRqitUx843iESCTwSi2pIMUiT3Y6nvaZS24vMa1RPvbNdQNIqMpjItk1LDQcFu26paR8LBhmGAYTI12VxurYzsqJHGeBVgARPqteL9Sl/sZTO0tqgu3hyHFOQYWCLvGWJNyr8m5R0WskfeYCl4obHxX5roMA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOWQbASxt8JRCSDbWEvXwtwpNLqgNDfJIivpG/RB8LbgxHteB4NpREadf65Z?=
 =?us-ascii?Q?FMuXjSsEk3U4wHXETFKyM/KSbMxNK0G9iCjOVMpqKzObb8n2C4WzcxEzE3VG?=
 =?us-ascii?Q?C/h4xYo4ev0koKlY2aaXTTpbZx4b917Q2UJHEJ+qD2GLEcIETtkcTBB05vSK?=
 =?us-ascii?Q?nZk9k7KtoXjvgonildacnhh+7Omo3azOnxQ83fZ17Lw6kad/MhBsHa54OG6+?=
 =?us-ascii?Q?ld46ABl7eUxaAArte5aUAD3sz7z4OjCpnJ2cgr8zNRA7o6mRsioZIyw9voAg?=
 =?us-ascii?Q?sXffJianEwxiPGwb/V2LB5BjwBRSdHcm8hd+RC62Hr7AZbGKq06qDbBJlGcY?=
 =?us-ascii?Q?zZr54cdlrBgBl9OlAznXnh4FnrKs1U2HxWmpTERhUYWHEyQv0FTF3oxfP8gg?=
 =?us-ascii?Q?+poddFYUR4hjfpca82qAl71S5oUwDONPWTWW1QyY/FG10BDfV+CiJAecvoTU?=
 =?us-ascii?Q?/jYFgOEgTPo2hHRS//a3lfNPLgtTDqsGYyd0swRQ58cQaiJLwsFN0i1FWgZD?=
 =?us-ascii?Q?W22oLJ02bzr09WXQeBssSumn8MatX6cTuBDzcg7TmpP6VSNjqFzyJeUxMjqh?=
 =?us-ascii?Q?+xvIF7HQ1983OwLcwYnYTIVr2UUa113qwACDxmxRIaaGCBACOMNyAjbj1z8S?=
 =?us-ascii?Q?qEZiGPKS+TMcMXVKcA5kzyhmNL0p2XVMG4CX81d7xml5Fr22qUaK4WH4Qop1?=
 =?us-ascii?Q?WEb4jnIrI+UfCBuI27uefIqfYoccqOV7n8RseYJ4ksa001+1GspSWR+BkIDb?=
 =?us-ascii?Q?PtjCS0HotZlJTKG6LVBiYCaGoRiFyW/p5ZLDcqHaPUZacslBrZuuHXLcbOrS?=
 =?us-ascii?Q?TKhgv/iBc59Kbu1bcNVwQTW1HFjWYt8QlMtjonQxoxXSs+c7KGlHDDbX/tzz?=
 =?us-ascii?Q?G4s1Txr0Qu88oEFqIpg9pEb+Z82Acrq1mnfifjnm0liUOXa6FbuAKmGC/zl2?=
 =?us-ascii?Q?SOH4E5mSjciCT6yVkvT4/hM8mlbMkdl4JVcAVD+FI+3UXfJ/Os49P4dtfysB?=
 =?us-ascii?Q?rLtS4h2TxDgmWyMHxKS0XfYru52bJjvLMhD3kM1C+Ibx5ia2I/hjOr0dCqHV?=
 =?us-ascii?Q?SY+mK3vffs5VrbX5Y2qiScZIwnAXpVFFek51a3IX5VoQJgYR4N7Sb1uygPpm?=
 =?us-ascii?Q?63cdauKTJF32ZIJpQZmyjUbxHCiw/QlqOQUY/j5wUs74ngH91so9ofzxNvL7?=
 =?us-ascii?Q?qGizcMtjx/lXJjdrRvGMsryFM0AuXiJ3w/d6B4ocqxU0HjfFWgrMa7LkU1w0?=
 =?us-ascii?Q?a5zkBOz2jdLnZ1V7MjOntkV71aRDHyHT6dBIdGXPFBvYDm1k3CfRYG8GXZkF?=
 =?us-ascii?Q?0BPeP1d7VlGKpHtDdKVfGwLK?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3e509a-ee20-4ce0-a520-08da60d2bdd9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB7024.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:12:27.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3879
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

