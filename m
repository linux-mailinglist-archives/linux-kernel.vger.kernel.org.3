Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C049156B821
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbiGHLMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiGHLMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:12:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2065.outbound.protection.outlook.com [40.92.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2868737B;
        Fri,  8 Jul 2022 04:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwV4bGQc7TRVz2snK4iD+vF5xymO4b2UYROgYUlYxE8S0nnMIVxwH5BJItUlkcv0viFd3l7x3rZw/s2i298FR9T2bJWo+tJjzGcyEQH1GJpdqZ5Wv7m2sm6IX8PMaCtgSaYHEJoSiv+FqToZXlJqbftOQa3W/qGVerGysbEARCI3s6QcEjgw5tsjmQdBD1eVUjkSjqnLaxRiRbyuwskiz2vb+nLrvPO7QIfpCSy/LV66UJ0WScLmQwrLIkTEM4P7okVB0CcAseLY2e2kcKYMP1gGvb0mFqn8qAlBSEeM4x3P0cPp/k3f/6/5x2nz9+73boH6GSpd2eX5YijaavFlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx12e5Eho5JgOJICQjDkueNFPtE/+Uyedc/9+ZtY+cA=;
 b=KBjJtGEo2PEC3kKW1jShiRyVOAi/U/bJ9Bgd+Do5Ia1IDuqHHa1y6Eiqg9YNzbnxLhRBnodYF5EbOg3oDLaJUOY4xkad08XQTMFqWd/YODbj2Mu3pKoUK74o8ntV6Tvr+tjRTZeFUjW9oY/8UV5fkJQshoWs/sTArIzTVh0i9B5mrIcz/RDmW8lOhQcqOdj3UkE+IKeCw8Wpz1QEArUpWy/as4RSxLXti5g73SGNqhf4aoB3ksHoA7IuBNymQP8tjQh2Q/w2Nh3Q7EIMmttdDLjWQqrjxrfaaqCBhQloFkKr39KFIdG/m1nmmv1ZYOHiDIYY3OmhU/U/huJwZe2Mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR02MB7024.namprd02.prod.outlook.com (2603:10b6:208:205::23)
 by DM5PR02MB3879.namprd02.prod.outlook.com (2603:10b6:4:ba::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 11:12:31 +0000
Received: from MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63]) by MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 11:12:31 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 1/5] arm64: dts: sdm845-xiaomi-beryllium: rename beryllium.dts into beryllium-common.dtsi
Date:   Fri,  8 Jul 2022 16:42:03 +0530
Message-ID: <MN2PR02MB7024359650A02554EF6ABEA5D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708111207.85249-1-jo@jsfamily.in>
References: <20220708111207.85249-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [1aGZqkZqZ36YLLNRmCEfxn8cRGdfSzqE9Ug177xKl0s1cYZc7W6EvQeXaM6oYaKT]
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To MN2PR02MB7024.namprd02.prod.outlook.com
 (2603:10b6:208:205::23)
X-Microsoft-Original-Message-ID: <20220708111207.85249-2-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e596cb6f-051a-40c8-0cfd-08da60d2c051
X-MS-TrafficTypeDiagnostic: DM5PR02MB3879:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvEDTmFce4RoFnksR1Y4gbu/M3syqVe0QGPuZiOTu2x8W5uV9Ed7BGblqtonRQArnnL0z6tKGC18U7EO+0Axj7QSnTF3G8ha88V7eTz1f7I/+Z0y6aJETTzYwuW5/l2m6P9+vUhXrwWaCTJncyZf7uT+FqgWi1HgdAM8E+NepeWVAjunJj5EpO+UFKIVbv1OlrCW760mxaF6rBPMns/22+HYr9O0PgmgeWI1cmmDYzXDIx0PdZAWRWzNFEKRnEFU3JQp/wqzv53eWFtQimIRlOWVkZ9ApFBxSS4bUOGI3BRKin8kMGm1sDVaZGpxb321ZkQAWvEyONFIYTJqt/baA5GlEQpwaJs12GLu7PQfng18P+ZPQ7LCf/+7paiOkZ4CqWqwMCTg1rR6QQi/op+XkIF+7Z27ULN8bqdFHxpx3MkrchYqDmbNhNWp6FuR2vV8rO9MfAIFJSKI6exMv9TbtVOMjrHzSdklBUKRRSn9lY7m5QtMzmi5rVo3mvaV61/3tdGsxkGyGXWrRi6AIBRVDAcHN67+A6WXatocunN0tHlgE6k0NQTmFXWMncBOqvdMbSjUvXFqn+Qe7e/hQ8LG2+1DQwkPHKCWT7Jgl/5OVdWJmO/WNH5rmnelMYuC1n3fOv6RA1FRSRjItAW7SjkIjBXikiWQoHX/Y+HLmN6xDTjhEGTMR5ZMXqu9Lswqb/e7zCd7lfQ3ZV88ZhOXtUXOXQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/hT/UhOZVWYyjBr6ZcRDH7XBGH60C7ixRd5CONsmLS0zik4ouSl+W1hGpVwE?=
 =?us-ascii?Q?txFJcrBdBmCT0uS5lmPLiSqlPsZTTVwht49QrpmOFiQzS1VN3T8q/kXGsMWU?=
 =?us-ascii?Q?SFVRo5VDcsZ8Z79mVULzz3HGX3GThkr/mujvsazK4kQdqFbkTJUUr8KJZzS3?=
 =?us-ascii?Q?93pGT+srk5PCPkLdFlawRu6aDwj0EFPX8UC67ofrUxOEHr+HYNKpULSstEAv?=
 =?us-ascii?Q?8nqgSTZ4Tgb3Vmar/jPKFDXkstZhFimSjrAzzT3QFw5ozt4PNTPwG1ok/t+w?=
 =?us-ascii?Q?VY49qsP7rhniy4hFHBoo539Ge5kaODCVkhtmCZ3tlKwO/tHh113nxVi9vtXj?=
 =?us-ascii?Q?PE4z1ydyFWCyXTITVdV/xk+JLqPEg2rt97yV4KAwdGdvEEnI/ZJ+4LF1J8Pg?=
 =?us-ascii?Q?vuyJQnKDImC9xqG5oEE971lvuQtXHKO/4jN4di646v69Jipwk7PmsC2in3k1?=
 =?us-ascii?Q?+/T0es5U0Tgrf7TQkitM7v9wgEhddT+/1SoIWJVg43rDAydBnx5Cv3DZJJMG?=
 =?us-ascii?Q?I3aLLPyPNRwaShkjaoi00Rf9toCUH9og8K5njXihMvTu2FLNjotbfGOftBic?=
 =?us-ascii?Q?JNL8Rg/aLWz04CH9KOSstC/Uh38odpz7pLh607/6GvzmIEaGkfrvBpC8+g63?=
 =?us-ascii?Q?9b6uKRoJVtAmslS5SDYLyXiuZG3g2qigKF/5qp5QMinOTlnaGQoy6q3Xymm0?=
 =?us-ascii?Q?gi1WiEpZxiqFGnDFY6oTa+hKaG17B2Vi3dBmBhCDJ++pCsBVL5ZPImYC28I7?=
 =?us-ascii?Q?kbSQaqUb/F2COkEV2CGAfAE/2vSz+sVPFc5Z4uqFCvdcQ+sgVs/+ymw4Omd2?=
 =?us-ascii?Q?5Tp3T39LDO7eXSaykztYYXziSD9Jtqbww9ACM0uusCeTwd0nUCre7rdFf637?=
 =?us-ascii?Q?KqSsJHex7534RThv0ZRDMQDRTw6jLoxVsfW/Jw3RapY9tR4H0wpI/b/bOEKw?=
 =?us-ascii?Q?VACYIELz91d5ZMuWwVhZ0wdXHAGKpY+mtoKkl4W59YdUz9hR642cH/Bi+n8S?=
 =?us-ascii?Q?rJgCX4o6v48Ixzbl9xPGZaAwFDoMGpaCtPNPcawCOsFRZiudZLFOQJD+EBvG?=
 =?us-ascii?Q?+S12GtFHCIhuwl50YN0iS2nh1aEaBN4mRbja76VtYJdVzA5yYtnWhnNBUY6F?=
 =?us-ascii?Q?B+7jdgf04yL/TVNKHkWU+Y8aveEn5ED13H+YgtpEIVydXkh8ceBsnltnWPMO?=
 =?us-ascii?Q?AGHW+WCL3q3r+2JhAaxB8YEdS3eGXolEnlXvbwlutVfLHBX7NwxKlRWmXp5M?=
 =?us-ascii?Q?55H0gB7T+xNuAMm6Z3JFvRcCfL0hl48h8g8ra12X++11kSrJxLOAZWUMi68D?=
 =?us-ascii?Q?Dn0zWZ6pr1N4avOTeuGhbFQd?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e596cb6f-051a-40c8-0cfd-08da60d2c051
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB7024.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:12:31.6500
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

