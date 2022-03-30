Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523274EBB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbiC3Gs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbiC3Grf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:47:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2089.outbound.protection.outlook.com [40.92.40.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC5189CD5;
        Tue, 29 Mar 2022 23:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD59DRN007MWQh9wkdFfMfPHXkMzk84b60GkgqXnaUH2cwdbI9JKYspU+s/jo7HRnwh85W1eBKc8gwmuowfZYhY6x6jV5PFBYXzfbtuNlyxPltFYdB/oQLIDwzCpSinuZ4cwhvyK1DdgsAF93TTkhZUxc7TWjnQTBlK7zBH3XZuPlV4d8n6QoOE8QNtcFe3CGekHsKCtaO0mz/CKW/YZudOOwJhS3WFdsVRUKkcSknFgdOgQn3+qZysqZKv0WUfWRWoemZ5RjXQspxeWRbev3jnC5aPlIZxhUilaC6cxdzDe+8jkJTGCIUtRianxRzUnYVVdyLwK8fk2idZrctzcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnqaHFspNzaDFXPCxywoCKrChn1FvnhBn5gXssIRgY8=;
 b=kX5GBH2Sh0axhsZQ8Pema7SLLIllutHgvpqQ5x7tbx2HTBX/ggqSJGIjvKaf0cLqUQCx+hc2MhKQbzJVwwvhALGtRqwB7RuJgozyCdYgdDOrESuK2+iZ7LbP5SnlscWCFuAFc/Gw84IlIKryC/vuyMFyaAl3wX+Em+GCf9OCpQ111liPBU1AryVICDw5Un84lUQjEiE+La50a20mPKeX0O1XRdRmil2Coy/A0tlhyh+NhQucVzMsEEm7Y8dNwtJxIoFXqzhkWnw5NxTf7cP1N155ff3hF4yvDMoR8PXQZxA3I4fbecAkm0bSRNVnFmHH4LAYbjj1hHGJUucPh2rTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by SJ0PR02MB8686.namprd02.prod.outlook.com (2603:10b6:a03:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 06:45:47 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6%6]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 06:45:47 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 4/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable second wifi channel
Date:   Wed, 30 Mar 2022 12:15:05 +0530
Message-ID: <BY5PR02MB7009E2566F9000F338432761D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330064505.243799-1-jo@jsfamily.in>
References: <20220330064505.243799-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [uWXReaxZUe5vhAMLYgC53dgU9yWicVp0iXkyKYhFIbOsUJmQLcOJ3OkwAiRAwiIl]
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220330064505.243799-5-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 561398b8-1f69-496e-8e30-08da1218ebf3
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8686:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JV9U4tEfrgL8wjoKqEBxjyqr9xNxpCMJp2igM8LORfwCRc52JdCRmPwtdXxCYPQIo1aEETkIPp3Fubs7CDcgPkaMI7GCXOPKoVgRC4Q9znihO+D8yIdGD1MgEhL7Vg34SIZ7obb5bqUxFqhXanj9sa9n+oI+NYA3F74QuJ6+VE6d7IJMwIu3sWxEanvu9SULZQBJ9z4AWTe2xniKKfj4UxTPD7qCSakYo/2tgseFXWIkyziHuEeK7dOk56NyJthy5RPGMN51BUoRB293iI7vDDvVSEPlBdNOX6z4Omb+CiH0dWTvkMBUAa58mVcp/5x38fFtOduWiJYPORf+cj3D+mCg0aBvF7Mk7UHcekIWWri4qIXM7iVgsqys4hEAU7wQnRNlAG6ay6ZQFEoThyQf1D9DqEz4mwKa3h6ayIG9MRYPPLBxh5Dajw9UUvHzdBpciFEb+lhfFIA7QkN+GhYf84luNL62z+rOgCLtQqLwjKcuV0HhEKIg3Dq042bO74ANqHSHt9+RYNP9QJkWuh5xaVKOsDqfW/hkovOoKb98V3UZJkJ257RAtzcp+VlcM/9swV01UGp+3cH03NGayEeq6g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tcut6qiLSgqcTarjsw1TP9C7iWoUPdQ5jQpVLl0WTlhNpVxN6zCUdLE5P6uC?=
 =?us-ascii?Q?zoOCeNEf7MXfMIBXp4gxENFFiWExhoraTnw2dLcu1SlfVuMjb1iPoBU7CSfA?=
 =?us-ascii?Q?hbhv4WIoRutrdKav5ICD477AFEPcWJA3EbNprnBeFYWW9lR4LvKzioE1YcUI?=
 =?us-ascii?Q?Mg2A40aCm8tA5GaDMLOvXyKXKP9ih5OmM/hK4DwQeGA7B8n10YvTIB3e2bpb?=
 =?us-ascii?Q?wc7kELMIiyU2X2P9UA06ILaDKCZi1Y6oTZm2rB64Z/zQl2uSKkOTU0P2pqmz?=
 =?us-ascii?Q?H50F5UBiZY+VdU/yCPHd3VvPAK/sSBZfsMO6obovw2B2bhZoFZ4V7LKUGVko?=
 =?us-ascii?Q?N5BZ2NxDfv6w0dbT9hlcwZX3aDJNJIqGhF8/X40PFZxg1T44DbIIQfCoFmId?=
 =?us-ascii?Q?FTB87BvXGGxotiL94KyRF4pN3tYrIAav42xHmcIashY7Hi54ezQepshs22e6?=
 =?us-ascii?Q?U4N4ly9v0ebXyx1Re8UBHLCq8ugW1B8bAzWlrCTd6pPC67OkctJ+jvdT1i1+?=
 =?us-ascii?Q?K6nmDB7Hd6r7brHGno5+7CFol3reeZyj2jLQ9HjhnTQnmWKMyLx/Ufhxedkt?=
 =?us-ascii?Q?Ev94UwfbenuVU/hV16++JXC5EtgHfMGSYAM9zbuerPlFZPMPAeKuj6SOxv98?=
 =?us-ascii?Q?2khYZdgF8umr9/vvnwLY26lH8q2dmo91jWPS+rdC2qc7mQv6ZpZ5EImo+dt8?=
 =?us-ascii?Q?i577zrBB1fY5cD80XPA7529nrv/Hip5CociMOs1Z+m48/bCRYQ55Vv3f1ook?=
 =?us-ascii?Q?GGoOy1bHQYx8uqICdi4onpQk9ZJ0we81ce7mqVehb4TN44lR0+823neGfnp6?=
 =?us-ascii?Q?9IdDb9LcvijlgifgqRUOX+hohfiWK5VM5iJ82PI9SbxsTm18IdyJmVRoW61Q?=
 =?us-ascii?Q?img/KSkEtuoJVllRgja04BFswMZhPuVXKyysAjn9dsFUSlzlAoFtxYAad21X?=
 =?us-ascii?Q?oGbDqHPLjQeRDOBQSyqKYw40HGmp76FDzEFtikMr4mNH6A+zlHxouEsh5M6k?=
 =?us-ascii?Q?CR/b2RZ8Mg53JKZIS8i4RObciY18CyCtZxh6AiFqln9wds2R7ZUT778oR6nQ?=
 =?us-ascii?Q?qKiN3ivedlsFVn4YSwn9FM/G3vU15j/+dFOav/qV3dUfzMe2e4MuA1eDhpYd?=
 =?us-ascii?Q?uQilXWUieUiL6yoWCHw937zHfCnF38WwzYGVY/0+8KWaLCOA6gn5CqG1ppR5?=
 =?us-ascii?Q?Dozm1gq0St2WdQdk/EzspK5f0MxWl5i9fyNVkKyLjEPe6JjOMEuumxxX+8qI?=
 =?us-ascii?Q?VivtkTkbQIDCyUBvikn0TD4K8kZqjwyRpzHD5rAkHWW8pupkqPXaasdGzQqL?=
 =?us-ascii?Q?nAIkMXVaO7ocB1TjyZqUky4SUtSDhlD/r/kQCCQddiQfrN0u4AYIzqadtbb5?=
 =?us-ascii?Q?ejoZ54neE30DX84NCTWUd70Se7nZPijQ4uQD1Ytg/MSM8iFy18dERAwbUVU1?=
 =?us-ascii?Q?RI7f55mnIxGO9+/obr+Cw6T8UwptO3XxoU6SBmR641ArXkeZrzTUZg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 561398b8-1f69-496e-8e30-08da1218ebf3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 06:45:47.7686
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

Like the c630, the Poco F1 is also capable of using both antenna
channels for 2.4 and 5ghz wifi, however unlike the c630 only the first
channel is used for bluetooth. Similar to Oneplus 6.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index f97900e7797b..798fc72578a7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -185,6 +185,12 @@ vreg_l21a_2p95: ldo21 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l23a_3p3: ldo23 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l24a_3p075: ldo24 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
@@ -547,6 +553,7 @@ &wifi {
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 };
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
-- 
2.35.1

