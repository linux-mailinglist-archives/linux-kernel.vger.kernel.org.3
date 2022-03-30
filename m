Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E866A4EBB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbiC3Gr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242981AbiC3Gr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:47:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2082.outbound.protection.outlook.com [40.92.40.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8197888C8;
        Tue, 29 Mar 2022 23:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGl/XwV+aBIKUESMDbWq35y+Qm0RvcOjiXxbPabQ675EVHRg4Tg6v1aUdEm7PCUkGmZtk1ZFbLH0Msz+HiZEvN+rlwDpgKgWCypF6/KO1rF7h6Qv0jdmD4YeK4v4mgm5u/CO6PBi4ZXxT1lWdmI66IPHjqlnkPROFmXlT8oxhFNdUuuZ+0URsRAz+EDXdocvGIgsog1I2Ycn6i51QQ2Q57R2RCIJ9eNOScHbFmRhN7tHA459gYjSRxo6P1BWFZkccZBLvkoGUH4dIVD4hU2axv3zr5CkRz0G1Fgr0aeq4D2N/3FoZBWcSMbQasxhtoJknQjBJBUgj4Xp9g5GaEfnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNk22jNVyKcgAQ4EpyUuRw+nQ0NDRD4MM2skhGTQO6c=;
 b=cLuXZiOtldibrowviaiwm9A7Tgy1ytRujzend/BBjpCAtXjwqTWTiIIdIiDWAKa+OM+xax6xqoqtLt+01Q9qLHHMES095FrHHwQnRaIuyyua1Mmkvbge/s1C7ORrjeGfMgsZTu+/BtdQObRNrbWNxHcg3EdI8jb2MwRZDoBntxDebu+Oqd2zlp9abuItJxqrs+ZKvK7b09RZpSAcs0SKF0FgnuZ18RTSR6UVWpfDTjIghsdjjztntTRh+61Dhi9TxIC5wLC0loDYF8KqB1C0hdio1DMG9d7Pbh/C5zfeH4zotPynbIIHzbPVBMwPQbIE5LWmWzIrNyoewBuMjNDPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by SJ0PR02MB8686.namprd02.prod.outlook.com (2603:10b6:a03:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 06:45:44 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6%6]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 06:45:44 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 3/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: fix typo in panel's vddio-supply property
Date:   Wed, 30 Mar 2022 12:15:04 +0530
Message-ID: <BY5PR02MB7009901651E6A8D5ACB0425ED91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330064505.243799-1-jo@jsfamily.in>
References: <20220330064505.243799-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [Zp6Zv2o66Gb9D4cEYRiAAxbvySSBNzvFT1VJ+7xlu5qA7ab+Tkwvze9Lb83LNe9h]
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220330064505.243799-4-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bfae8b1-db0d-447c-7a48-08da1218e9a9
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8686:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2nGXHW8sAtb62filimvUEgavONWU1jeJZ58LDRx83/8YbWbBfua+SbKJykfpg4YsjkZh6E8vqrWz9sL1+NWysRgYpI02EojJXIJTc/u/nuKydUUjHoGBj0qJD932d8JVCVbeSGxzHYs0xuewinPa0EiOMUoxUlN34Yj+FUWf80gkKgKX+oNnC9ERnr3S9+SqrmZKILLzbJ8HV2uL8eE/8gGu9KQglixbjJwW1KpKC3Drl2NLBlHBqXHWWRIbogCBokWvU0JO7sLC1mSGYz0mRmH//5vLMkc9Y2a5ZE7J7+B5aUYzM0ug1pCLBnzIMzvEay8UwGnB4dXFXF2hh6VjNpy68TYj6+C7nnOFyTusL0xqX0Mp4WYYf5Toio/s8AG9keB/3ewkcEmfnaRqtzJ8098Dn7UKhTG6kN7d7jayJZBdtLCunnQ9y5r3kxBQr9D8UY9Kepo1vlg9oOfPbXp4ygSO75mi7fjpWxdOhQjw8bwNQuYM5+159jcuk2FlUP5KXC9t8geSuz99EgIbzIk5AGux+XajKlKRLZ/0fSRbQ/WwcnBtFpnt0qJyLqg+oYVRJE9eUbaF//zcjvLcyb25g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9tyaoHqhP4FY5xIpbCrwfNCUsuWGqfGBwIslmQaOrQJdq1G5YJNDqje105oZ?=
 =?us-ascii?Q?fevCpHa5yoE/UAXusZLoY35JG10rohs/f1+c9AHvM4hn2YhPqVmh6UXos2lC?=
 =?us-ascii?Q?FETBYEHlbl48lgWv9Q7QxYpfqzsW86awmVe4hIbkFuk5LYSC3bZdu+ER/meK?=
 =?us-ascii?Q?EJV79lFUIbkMggA1yxOZZj4ZY3afacLH7UzilTEhX7zSwrL+7dsKHQD8bGJa?=
 =?us-ascii?Q?PMC6p4aJACpIEq6ezc//ecyGtnFL1Oh/uO3D+IIwFP5EaR7WITr63iPFss+S?=
 =?us-ascii?Q?UGmscBH2jPHYdxwVF554yoKXOXpnwNkWB3qnrmKpWYQTaslScBMT7+RhSVUm?=
 =?us-ascii?Q?j5VUh2X1UgSHhY0TdmLEqVlzz0wGGj+fJ9HimZXJJPLYVA3A+0HTkH54zSJb?=
 =?us-ascii?Q?/R9XFVyovR1bWIFOxDPSNx72IoWQeoqimBlAYN+r+G0zIvaxtxqEzuvAJyM4?=
 =?us-ascii?Q?izt4QSR06MaTH6DXiYmeHNXWqosV+nYLDiGiiuaIYz6Fk3P+TKSZzPZmpiyz?=
 =?us-ascii?Q?t2s2lyFg23JoDl0GILdV5N1+JC/ElBXF8szZrB87ESRswFV6h5ecQBx8rjWR?=
 =?us-ascii?Q?fQvyYqXVdg2n89TBc1Cu1P9C9C6LsmkAj1WL0E/Etqjkx4qtnmfv/AyYoOxg?=
 =?us-ascii?Q?SKsTsFqU4sAtc8gRJRqWJy+6s3hcRfztwukCzQymAA6+CZk5LfFtj+9xLIEk?=
 =?us-ascii?Q?XLODy7jGMHHkX+EjPieXmwplTMLno0fMyfTzaoyNuf9nxjVcEHc3xiYwROfp?=
 =?us-ascii?Q?v1zNO/Vbag4C0VsPhNV7YN6AflJzrp6ErgxXJwKTGRLXfouay4UTqX9nww54?=
 =?us-ascii?Q?NGfSTffqNu+6EEEeY1ChpJobBYqPLmYGBuAAqHzY4MFSBSCf+anOyhB+THrd?=
 =?us-ascii?Q?A/K+bZsiQSp3izhpRJIQi6tu/10YGTjsAR/AN2AgF1enxt1mihCjKbZIN8RC?=
 =?us-ascii?Q?WE+wGB2covp98qsah/QV4HvfqINqb9pX1BTCqE0YUAItC/FsmKG4b9c3/2T2?=
 =?us-ascii?Q?GsOW7LDBZgUa8iSo7tVL5XfPDqWDHXO3Rb1qeL6HWDZAPOqoNS7VIf9xdmkJ?=
 =?us-ascii?Q?v4NNt9+QX5kOK3tY0nNPUOlz4qIgVRNZkVLfQXtgid7tj7TXqSJZl7xOT4Hc?=
 =?us-ascii?Q?LJgk3T7XBt+aJFhQ+sZkihdz0bCXkoVp4dKygslkFwO9EO2NsuYa3AL9yrs4?=
 =?us-ascii?Q?UNAp3TPJYqHA5D3CCReI4KHsCaV0s4uZPm3pLtIKwiJ2YfeFREseeiTJVapF?=
 =?us-ascii?Q?qZKRyBrDgy//0GF49YvuMHFBCcnNs91KwS5coy6OQBqXj9JIjTV4Z6yzShsK?=
 =?us-ascii?Q?4KRehFbAziTcx+ZE63HxAipzvJ2gIZdScPszhI/O/GVi0RuXVhDjQUjSwDvS?=
 =?us-ascii?Q?VmWMuBhwaUnzE3rNMDGCZHEq1RoAyqMzyCq2RGBy3bxgHi35PH3LbHy6eu1F?=
 =?us-ascii?Q?W5VWG9mGw86P8Zpb9eN8R4h41nDydsMbNqsyHl+UwPUtHjCdIgs8LQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfae8b1-db0d-447c-7a48-08da1218e9a9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 06:45:43.9398
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

vddio is misspelled with a "0" instead of "o". Fix it.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 801b8c5984a3..f97900e7797b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -218,7 +218,7 @@ &dsi0 {
 	panel@0 {
 		compatible = "tianma,fhd-video";
 		reg = <0>;
-		vddi0-supply = <&vreg_l14a_1p8>;
+		vddio-supply = <&vreg_l14a_1p8>;
 		vddpos-supply = <&lab>;
 		vddneg-supply = <&ibb>;
 
-- 
2.35.1

