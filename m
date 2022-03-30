Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4564EBB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbiC3Grr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242896AbiC3GrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:47:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2089.outbound.protection.outlook.com [40.92.40.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CC686E3C;
        Tue, 29 Mar 2022 23:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5TV545g3gfuqKQI/nqi9uaQFOkJ8TjrF5RqRZdDOetJTSzSmFqm1atcHiewGPNUdFJqpjb4fLf+Smq0/+1GXrJTj9lQu/413tw68q8O72h354DR6aQuw13wPe3rJC7Zl4PuCqvOM+Rb/76V8wZuzooLZhKp8vf9JlWz3fpyoVSYuDG7pXiT5PdRMKuCkrijkrq2uCraGXbI7isM5l80fNX0kZaG7wnnzog5PlTmr67z8OI4fXwAP6/nsCCw3as3uDkLRyEYfq0sPwTEOLLElywMCkiy1FIYPUxH4bjGjl+v64ZVl55lc9oWQDhMbaLyxVdTEaW6jNTyn2buqygTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBzEdsjhP+UXeIaca5oMxtkcaPJCoarWBReYT+jq7GY=;
 b=czZn5c6qSQiHn/HtTX2QODkcTiSocT8BDQWUdntiAuWd6WABJqGYJ+Wc7WsTKG6I3muS/gnRDfx0SFmaeCneP2Z0aF4Fphko1+BxFF7dNiMwjBPccXyFi3ced+KLO2Tt/DpHsI0IpahUUusfc9cITJJzwVXFbXDpbtcJ5DpMNRHLKF/rliQ7ASkY1mwpW6VLLHfTb6BDwOUmpP1hq93CM4fgnWyA7F0KIEqq34xHm3SDg6vFTj4/Kcsc3fo37ScOmnkUXESg/f4WWW6I/gC/cAONZgO7E72DyCxQzobIEhd6SPjW3YXH5y1tFzUad5AqGCtwgvsbKusgpkt28Rwb6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by SJ0PR02MB8686.namprd02.prod.outlook.com (2603:10b6:a03:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 06:45:36 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6%6]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 06:45:36 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 1/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: change firmware path and use mbn format
Date:   Wed, 30 Mar 2022 12:15:02 +0530
Message-ID: <BY5PR02MB700966DEE6F6044EBEB5B892D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330064505.243799-1-jo@jsfamily.in>
References: <20220330064505.243799-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [uhNilr12gTt9vg/zfk5VG5syvWZtYhkRo3vYPzFphtiTe2jP59O06S3HJ9qC4StM]
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220330064505.243799-2-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 807aa148-3e60-4278-ce6c-08da1218e51f
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8686:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByNVlIiElGb8ZBoozDtVRPsERxeXssz2Nn+mtcYiAVgQ0BlCYAFbIdUYGy9nTcj5/W5L0GOrL3cyc7ks9Kd/Yy277hp21PYwK+zMOIxnZA5EItpKRM/1rFRnn1p3id3fxj1vGuOeRzP270c/CDttmYoIlLelPwVNtxBdFm9qDpX2ldAywkYgxFkUQk5A+O4L+D/fvdauCpciN/Z4QZ1uNMyx8ByRQkMmz0/8SQC3f4GoTG77QW+i9CHiIHixqXuUwdji5p0ue8FEZRB7VHtAdGgDtml0tPkGhxFLpxF3261hL3pBadR4/eK5/jkYHy8QfF/I4jWJtGW/hLcZ4RbFuSzFPYorv+HkyjcfrsHKXlN4LdimkS86T8PLifoVIhQ5Ux0UzODmnnsG2QCvFPrHLaJ98POmcG/K6C0nCzT+F3BBnKWBduPgU7Ghi7F20VcTdWIKnLwj/UJb51w88mneM1PHfGAvi8KOTbNnO8EQSStdjgkMtvrHHjMTzzuPQORCd9qNNm0cLIXgUdJwxhOgwFc71MLRuSXyzIJxz4w5WGAy9cp18grkZDoqP4ONlMFlbn5syuUouo5BiY1eE9Ue/jeGaKKWHoadb7lCzrssSc5m7JxXpeRr34ONaSHJvS0T
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6qbaSUM+peL+GJvPlNxOW6A2TFB+/kw0tInw1DRNuGO9ON+FTcT8f3m4pORm?=
 =?us-ascii?Q?62cVjbtVpFk/CQWDZXiJ9Fkl+9NAq60LqEU7xRtJiVyYntOV3Nhct1wYO5Fw?=
 =?us-ascii?Q?ez1y9LlT+OvemjUZQZdLtP8jhS0e9nh0A46434CeLznS/H8KSBE7KzpKLesg?=
 =?us-ascii?Q?mz8R1G9ZDvyR2rTQqpAlqo347qNWT6jzo/Q8yXuheDO5SO6NRDWAceC1Vr3T?=
 =?us-ascii?Q?lgkVF5toPoWbUhUf38JcyX/jlG2TtzcxvrcADJl6QKQDWS46KTfA0nk0Mn1u?=
 =?us-ascii?Q?VwrjyVE32KegcjEjOVkYzOvA02cetXZSq/oOXeOS4ZzeabPAck49SGKgEC0l?=
 =?us-ascii?Q?t8HXsL95daqt2NYtX7az7ZzjGhsyKMRALDeuBrkBllt3Rt9t1BGuLl3uZHew?=
 =?us-ascii?Q?MrXyrxqKJoDB4gXaxT7PahcjbtHo98Kt9wdrlSN/SWwI65UJCRANJkETbX3h?=
 =?us-ascii?Q?I2uJ8bowUzaesTK/jKQ6fGqDLSflfJwKF7/XuItHMl+RjYnVo0GnOxJ8PQOF?=
 =?us-ascii?Q?avccrLDH32sasWPFe87QKf4aEiFd8UWngnxcnpWwummEnrVhxTWjvrJqAdvA?=
 =?us-ascii?Q?ntflPkGDPQQuCKHU0q0pFVak15/MW+othN/30r7pFsWtYwSpU7b3ja25/L79?=
 =?us-ascii?Q?Egnw7S1o6ChQT+werdoQBlcWyjNyCh6P5/k+jvhnb/2IUvIWwggTxUFtcUPe?=
 =?us-ascii?Q?ZWYn8dSE5En3rb1xdZUcsaboLotVtU1m/63pjK2qTTmQHwBOSp+PhifZKTN0?=
 =?us-ascii?Q?PvJ9+TBVAW/Gh9Xz9cGM5EckIMOvsj1Y3Wmss2EZext9iPLgExAhUB55Y93D?=
 =?us-ascii?Q?+bD2qaxAioR579QHwHOzAmZTibFJi3DD3/sEEv3cok7NMKTs02Q3N+cZGMk6?=
 =?us-ascii?Q?DzEMJ66T56bAVu4AJZ0TsyFdKTvVnsZY8IJ/x/lCaWvEwoUbPjAiRmF948JM?=
 =?us-ascii?Q?JL0QA0gzZrPPIByER+fGeDJge17qtx8yrsRmVM9p+Gjehna/EHjNCN4q6B1I?=
 =?us-ascii?Q?sk7fe2FRv7rA5m96hb+opMWr+5ZgJ8U9ZUVdHIpFNPfMhHJsENK6LRitMJb6?=
 =?us-ascii?Q?vNdVIGqxxMXPkIOXp3hSMGHspzInBgldoFoypy/c3bcrK3Uhg1/qXTfj1FIR?=
 =?us-ascii?Q?d7GAkU5vN9/jXsAcLK+dh0IsFgIouNSTqV8QWZnbOL+QHMqqmLcA/QZolqvO?=
 =?us-ascii?Q?8XA+OUOXIDpm6O/3HkWfuIRlPdovbc0Ar324fn7s6S2hEi3zAMzifS1E0rtS?=
 =?us-ascii?Q?QlFcMFcqgtvPlA7kGBpe6R+/rQXfJneBMy6ePmCtsBMnAt5m6dWX7zaX9k5/?=
 =?us-ascii?Q?AV8Wp8A4g3K/puZRYmpNvLL5+Z4PUoeX3BM2luig/n32WsTiLmXUtf7rL3Jl?=
 =?us-ascii?Q?38nkzo9Z0By5UqghXg+UtocNbc+ggbcO0pQ3ddB9urPKaO0jNMcTKnYEhLTT?=
 =?us-ascii?Q?o4CGXXQBf3wpbsA2580lqcTxq7XdWEWBzvQWOL0qv78kHRSQ47Yn/g=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 807aa148-3e60-4278-ce6c-08da1218e51f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 06:45:36.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8686
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "qcom/sdm845/" path conflicts with db845c's firmware that are
present in the linux-firmware package. Xiaomi uses their own signed
firmware for Poco F1 and can't use the db845c's firmware. So let's
use "qcom/sdm845/beryllium/" to distinguish Poco F1's firmware files.

For easier handling and packaging, the mdt+bXX files are squashed
using Bjorn Andersson's pil-squasher tool from this link:
https://github.com/andersson/pil-squasher

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 367389526b41..27ba9ad1ad02 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -121,7 +121,7 @@ vreg_s4a_1p8: vreg-s4a-1p8 {
 
 &adsp_pas {
 	status = "okay";
-	firmware-name = "qcom/sdm845/adsp.mdt";
+	firmware-name = "qcom/sdm845/beryllium/adsp.mbn";
 };
 
 &apps_rsc {
@@ -208,7 +208,7 @@ vreg_l26a_1p2: ldo26 {
 
 &cdsp_pas {
 	status = "okay";
-	firmware-name = "qcom/sdm845/cdsp.mdt";
+	firmware-name = "qcom/sdm845/beryllium/cdsp.mbn";
 };
 
 &dsi0 {
@@ -262,7 +262,7 @@ &gpu {
 
 	zap-shader {
 		memory-region = <&gpu_mem>;
-		firmware-name = "qcom/sdm845/a630_zap.mbn";
+		firmware-name = "qcom/sdm845/beryllium/a630_zap.mbn";
 	};
 };
 
@@ -289,7 +289,7 @@ &mdss {
 
 &mss_pil {
 	status = "okay";
-	firmware-name = "qcom/sdm845/mba.mbn", "qcom/sdm845/modem.mdt";
+	firmware-name = "qcom/sdm845/beryllium/mba.mbn", "qcom/sdm845/beryllium/modem.mbn";
 };
 
 &pm8998_gpio {
-- 
2.35.1

