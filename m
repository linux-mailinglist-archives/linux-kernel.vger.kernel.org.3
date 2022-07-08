Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB756B823
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiGHLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbiGHLMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:12:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2061.outbound.protection.outlook.com [40.92.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277BA88F24;
        Fri,  8 Jul 2022 04:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfo0+uR7DkCxSQI5tZ7gKAS+X9uohM+Zq9EUg3zqk/NfnWfkIEYF9XtJpW7ffHIJyYVInnfRB2TfyKFFQyROIDzMaC3iT5iurjOGwzHYzouLi/OItuBLiRBCJpthXuRwJViM8JybLkWyffgWJjq8MZhvxHvaO2bcJJzDPEw0MOxxIOvm0N2Np31JRnibxqdt4l5xNWAUHXtUE7eIhvTbI+rlouEt83CkL3/GKT+eQoDNqdpwqBkDEFiOcaIwKC/xYblqBMbFbmINNNotl477nrJbrShcvpLPcpkZkMOWy3SUlN90H3haysa70Urouya2AssADCBJ/cKPc6rKeyvG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1IXg/zNiqmj4k6zzOycq3rG76MvSt1UXRXBkHBhFlA=;
 b=isj3SoeNZgS1F1ZtfWQhwwJk9NbgVt4zpG7AgeTQjcrIGLmR+gEqM+nroZRAL8rSECJin5QsRoT8yg6FvBdkwzmzmxHgvqMccRWzXmoMXG8XH1DS9Iug/2qGXTEdlqZI7uTMQDsOLnZXL9h4UJFNsOi2xof8aRP2dr33sM13eVO/uD2tWFA5+pIvanD5+4MfeTf3rdGhDFbzXPUPwYLaOhbLt5+3SWsMoO/t8eD+z5HfwabhtKAF/2Vuiy7zTJI40lgl0JNxJfPj55/wvwVqb9SQ/R6VWa6SJpvlBoU2fzUQzRnhuR+innTyHoXDeqWMjkcKFrjC7kv2jssuSGY4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR02MB7024.namprd02.prod.outlook.com (2603:10b6:208:205::23)
 by DM5PR02MB3879.namprd02.prod.outlook.com (2603:10b6:4:ba::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 11:12:45 +0000
Received: from MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63]) by MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 11:12:45 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 5/5] arm64: dts: qcom: Makefile: split beryllium into tianma and ebbg variant
Date:   Fri,  8 Jul 2022 16:42:07 +0530
Message-ID: <MN2PR02MB7024E3528EB03CD7B352E2EFD9829@MN2PR02MB7024.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708111207.85249-1-jo@jsfamily.in>
References: <20220708111207.85249-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [eFyrMenTr9118FxKImUR3UwcwchUX9lsw/e5csr4nKphtW5hlbEvKp5IaH8PTHYg]
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To MN2PR02MB7024.namprd02.prod.outlook.com
 (2603:10b6:208:205::23)
X-Microsoft-Original-Message-ID: <20220708111207.85249-6-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe437198-ea46-4334-f4d4-08da60d2c8ba
X-MS-TrafficTypeDiagnostic: DM5PR02MB3879:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNSuh6CVq2BFQpC7J56xFqeku4oEIR4PurWvuvu3ib5obnThXodyx7Hgg358sAhU8tF19WMEMcSGFVgaOm3ZMDOoEAdgM7SwDcVHdy6oPcEFd2KW5THhxxGGW48s4zBlTnTl56P6Zju+Vn0w0dd94c3keiTH7v1pCvIZ0OqX+4PtFwr/uzZtZ9/BLwHMNokpXle9jjgxUQcXImN/7pFBb3Z2TqM80p3E8ly2qRcT/NfFsqoXf3A7adw1Iuab0AwqW3mUpk2G7d47NXZ2ZOdaeaT6ZdMd7Xn898gZYjTZCyFLcvCjBEnZMEdqAlgNo6kngCJ9zAEd7k9YBZuI9Y4wJIRt1pKYFkOhQjrxm5aqTRrvAQeAzooqAP83TG8nWcYgEexx8eCD28K9UrefPzUWJWbgPGZaQNJ1t8BuOxW0KO1kK/SNqz67qFtO9YrKg0MHgN7YcFbvWuFGosVaMBNvwkf3oZRTB75vvjmjHKCuYHmLNW+scFX1CftmDmJ6SWsD4AhGFOz9gUKeY9+6e1Z0FP6OMhiXl7OFbHA958i3VRRfQlbInnjJxdODyA+I1OOLzcHavHbKyQFXKCGytBRZIXnlOCEzkzi+KOwpu9TAjpTnFzGZrDbHe2Re6Ol+hjXd1+v8XmSN67s5o0oEWUZ5whqNPqpniOq3WzVSdvJh0sp+rO0JYqpGM02OkiGpAn+CVp6/kEt1enkIAkFABJHrrw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UjsqHfJdzK86i6kM2TbhD1oXHH1RQU2pZYXFpysZ4wMguUldsrI3GyN4/ljp?=
 =?us-ascii?Q?FQbv+JPluSbAH+EJr1QLt/+CBM+0ogAGpZFJGA+58G9AQQB0Kzu4ub9cTSvU?=
 =?us-ascii?Q?1DBeJyf2xYcxQqdjpRYXGRcbCmFOtgITEp3fgwq39pPxsaCUnPNw7oE26fhJ?=
 =?us-ascii?Q?01v61y8DFXfW4cnMEfu3ABi5at7fwqFTyg/4kkDwbMgPocKbQVxo0R4SDYJn?=
 =?us-ascii?Q?REVotTtRuwWqSNU5ea5zhha5Te4TnCq974VrQlKiUBwegnma0wx0WA50zEa0?=
 =?us-ascii?Q?0IULTI3jUYJuq3cN/AzpznxtaVlcWYnUM1SmMLmOHrk3SIdDSHN67orFf6a4?=
 =?us-ascii?Q?qJo0cP0U1av6ChT/jcuVgvsECB0kwxKp0hR66YzTjQ7WzVs9OksO62b0bgMn?=
 =?us-ascii?Q?DAhdpJI9i2qZ6doF9b6mo5nufhHgmhIY5wiZx25egki++C5zq1AV52LiEfDr?=
 =?us-ascii?Q?fzUxrHzpfO0bzX32KjEm2EqNVTFSXm2TJDdLvNAKN2hVtG1EYMGZ0jmFsjG3?=
 =?us-ascii?Q?XPh1kN/um0FXi6d+YsuYG2N9OejYAn909Jpv/lPy9xE+ng9DN3JSaWKB/Tme?=
 =?us-ascii?Q?gc2w/KrbxYbCi/yHieA1MdvdwpmmrYGwjsA47I/hen/Hks1fh6FUinfDwn9D?=
 =?us-ascii?Q?ldanZV4W2dCMH4OBk2gRzFztfcZyX1hKNWpVsSiqrT6csBiN6UJh/kDEibDT?=
 =?us-ascii?Q?7685neftBJ6ENG4LPEVuwtC1tHomVOzI6Xlfip5JJA/5tSTx8j0G7mdpi1gg?=
 =?us-ascii?Q?Fl8hACKHyTVm1RUteqnNPQKGbHMenYixNS4hNnO9uulE9BPTHhEcbZzixkQB?=
 =?us-ascii?Q?XlsfxeTRDRUwsJVgYcCmu6ky3ebTdfD3RhUhDe8gsqWtZdktc7OSNzu20OVs?=
 =?us-ascii?Q?paoNJM7BAdyf0RRbtPrMyhsav8oliARYPqEujHH+A2VBS83o7wFHzOhdf9sB?=
 =?us-ascii?Q?3lg7oz2m23nuSxtZUZxjvYTj7LSI4MMpBGDBv7eidWpVKvoCD+Wfjd9jmLaZ?=
 =?us-ascii?Q?Xdx6Ov1EH+qFbc2/cC32XufdI9XmP2MKI4GqXXYSO0x47aM7/75dAScEuqbj?=
 =?us-ascii?Q?TSNe8u8mf6oVPTmbC3zAvXg+SJdf8Q5/5HYKIxI5coGOREovrXZ/hT853vPv?=
 =?us-ascii?Q?CCYfVykd2rTBA+VtMa+jwAKkiORtmjdq5+EYbis5mpX6Z6dVLqnOCBQtDY+u?=
 =?us-ascii?Q?NhJICmTTeAGEGX48NsddT7Ur5bSB2jQIdm9gyfzxJroBBm16mnefUNR2xvY9?=
 =?us-ascii?Q?D9Ap2XdWnPnuR7mo1+5xxUfEzic2uzC/CV6mCvMOcxfoGu+5XLUSoFT1A51D?=
 =?us-ascii?Q?+G8Q4gkRt0UwlKFoWTGM3+a1?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fe437198-ea46-4334-f4d4-08da60d2c8ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB7024.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:12:45.7345
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

Remove old beryllium dtb and compile the new tianma and ebbg variant dts.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 arch/arm64/boot/dts/qcom/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f8aec2cc6db..5cc165dfbc94 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -106,7 +106,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
-- 
2.36.1

