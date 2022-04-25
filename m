Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEE850EAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245590AbiDYUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiDYUjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:39:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60126.outbound.protection.outlook.com [40.107.6.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4544D33E2C;
        Mon, 25 Apr 2022 13:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy29onZymYDDB6JV9/o+v8LkfjHyBSsnUKF7Fykeosy2Nd5YGCDtTb4Bw24jsc23sjzjT+OuVr2xGl1JmFQ+2F0TSaoM4TSw/LEJupk6+FlgOPANGPVFZhZ6scUO38VFr+aw99RQ1pMwCvmzNKz7sDSva1zrQkmC55HDqXGA7qHRcXaNRzNaIg/tm5ktziBWsD44+MMQbD9gt8TQ2iW0UlP4XzzUBQTC08vsylkSkR/mn324qsKO6t0e/gAB4d3KXP/snAcC0MEL0UmnVzk0Ncs96b7SRzvSla61KhhN6MplRyBsYWdnH7203sxO2BpLlN+poWD4EUZut3lVb+NZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yItIVB2LjgAgrsdgjwkeY+n4Y7Yuh6A6wEQyQUjd/y8=;
 b=Cy8GhRW18it/aWtp+qMtyrLsRDor2inhUUYrkjZWmHXyzP7oELRBHQ3tEU9zgtiPvz9ocVn8RwJHbNFWUUqbVrAUL5OigbXUjADzv5/zy5JOLtSjdRXGO4bUz+AVtigdt+aHZEZHjEE3y+haS5904LcETkmA1YJfuGsvq8ifBEgLkwd2/mGmhyV1xRTC/uWz/ADN4PXoz10BorWNFnhGGxS7VD8jJ0NapNv+y1aRJBuCLCc7gt/PuBHoT0jWusPO6xGg0cEFgQGt/hzpcY5m2JBt8+sL+zNwkWlQPAeTN/rexSPvZIw78GhQLyyPhjCd2rEBBSDXhvb2E7hNEXuhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yItIVB2LjgAgrsdgjwkeY+n4Y7Yuh6A6wEQyQUjd/y8=;
 b=YacltOKlvnbU9Us3A9AmYVfZB/yVqWcdjJ8htfBUTVi2oxCZBnJZl/SZw0aDqTsnjSLKBJluTtcJEN4LjCse74s5Eco+C+W13AtaDlVEAHWJ6DrRvMAPOao10UXMOEPj2AhbrQjPv9BvUZjkQnqNdsaIthTdfWt8npza9MX0GME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM9PR02MB6929.eurprd02.prod.outlook.com (2603:10a6:20b:263::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 20:35:52 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 20:35:52 +0000
Message-ID: <9494dfbc-f506-3e94-501d-6760c487c93d@axentia.se>
Date:   Mon, 25 Apr 2022 22:35:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 2/2] hwmon: (lm75) Add Atmel AT30TS74 support
In-Reply-To: <ea4cd16b-4a04-8857-d08a-53be58b00d28@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::32) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce9369cb-b39e-4f4d-0019-08da26fb30c6
X-MS-TrafficTypeDiagnostic: AM9PR02MB6929:EE_
X-Microsoft-Antispam-PRVS: <AM9PR02MB6929E0FAB6EAA38C2FFFB51BBCF89@AM9PR02MB6929.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t68XYQGgRFj9LRfT4kx5uj1ham6YLLQYsTdQiXyZivuJVD9t/giEaZWv8jiqT9zC0tADNAQdEGAr5lVlAFVa90D4x3EPLRiIcZuhQpZopMo+EOGLPEhI6Kl1k5fJoecJEHOFcSpaY77tleikox7a1oW9r79hHhzpjdPUrU0PhXqghbiTXdUKY8k6T0lr9rGM4XRZOT4vrHJarvHjgDS3892CCQivbWIMX1D5Xppgnw9xeFImZmQVm5SuX+f0lOVo3WGgOK6h0PV/FnK/lZeQhbcfc0ljYEAf5j+2L9zDsVlol3iKNKyulLfWEWRe/g25CYkwbJ5C7SfpPEpePDtk88+4ogRfDcK6LwmzIeX8bbda/oCg2GAI4wd4q/xp6jYvcZOgD1sfldTl5ksOd1ejCN7EDiMFc1dbJ8sCAEM4L6rLq09+zKLn/+dQX0iMs+Gc//1wh6xwxyrMVfgCR0GsmJ1Qvq1fjH5J1tVkawoJGGtOQNLoedosWyyJ8l7ha8p3SYm2hwC1Ht6+QznVXVVpjKl1Hzg2jczRxqeZ1QcP301afGFNOxwYEfM1eyOSQlOEvARzJrDtqJjNHIxhqvYuV6h65mcw0TgThg+B1K9KqqbeM6vidwyKNOHKjuZGPVlLcUORf4NF6lKxZc2CyH4ujtkEr0Xm1Sgzf1uUkM+sOI0S2hlcsLnnWN2jmtCGAayRp5fSlKQoSlBvdkFW1k29fR5QuDCSMjXfF14UDBV5BcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(376002)(136003)(346002)(39840400004)(26005)(6512007)(6486002)(66556008)(508600001)(6506007)(2906002)(5660300002)(36756003)(8936002)(31686004)(38100700002)(2616005)(8676002)(4326008)(66946007)(83380400001)(66476007)(186003)(54906003)(6916009)(86362001)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTc3SFN6QkdmWHpWdnduOFlRTjFyTEp1OHNPVTJsTkJyQVVYQkFFeVhVQUhX?=
 =?utf-8?B?VGptK09TTW8xNy9JdnRsWGdwVEpzOCszMkhOYU05S1FpTDlNMFBzYkphU0xO?=
 =?utf-8?B?ZnZzRVBRWnBHdENxSTFBSlZKczNSTVlGb0thNUJPaStHcWxPQnplZEQ1cTh2?=
 =?utf-8?B?TlMvSWxxc083ZHFyeWh4OXVRN3JYWjZwQ2M4Q1UxR1kvNDZ5Nmh3YkNGOUxZ?=
 =?utf-8?B?YnMzVG1sMVV1TmUwRGI1bnh2Y0Vkd015ZUhENE1hZFMxQ2ZocXBKaGpVcHVH?=
 =?utf-8?B?LzFPR3VnMEVZWWxtZUk0Y0ZQVmcxbW1kbEJYalJGTDBpaEhVbDVFTDB4TlI3?=
 =?utf-8?B?SXhBSkcrb0gvZTFVQnR3Q0oxQkI2alBjS084V1lTQWdJUVhjV3RMdFlUM3N2?=
 =?utf-8?B?VnRwSzh1ZkYwakVFaThEM1FUait0cEEzWlNpY29PdEdVUFFuYjRmWFNhR2tn?=
 =?utf-8?B?WHhESDFEOFNZdXFST1dWQ3RGMFpaMFYrSWVwQzVId2Z1bEM2MFdsR0FTSlk0?=
 =?utf-8?B?Q3pWZFkrZXRNWnJTb08vaEdUTHBlbWt4TEQ4SFcyZUhBb05rM0hZUjFxRE9M?=
 =?utf-8?B?dk5qVFZPTzJwK1BYUUlyQTNsMlFyc0s4cWlOZWYyUzNseXM4OXFaeCtLQjY4?=
 =?utf-8?B?dUhieFlIdWFhcEtlSHpPWmt6cWpyOVBIWGxYLytZQm9mWVJxZUhxTUhhSTFR?=
 =?utf-8?B?OGx2a0U3Z09pbVlUK2Z1VGE0SHY5aTh3bVllMU9QdW9ONWViOFVhL0sxU3dr?=
 =?utf-8?B?WUFaRk5pRHRJdUxjTGc2Z2hXOUJTSVMyZ3RUZkNEWFdmNWJnNGNPS0VOam9a?=
 =?utf-8?B?QU1rdlpYK3NZTVNWNysxOU9pRGo1SC90U1o0WHFNUDlKeVdrRDM4SzRORCtu?=
 =?utf-8?B?dHRyTXIvSmxlMkRMWWJjOHlwZEVOVHY3cHBnbDZhRkJOUlJlcWZQeTdYYlda?=
 =?utf-8?B?WjFCMU1OR3BPNTBOM0NYcjQ2ZUhBUVVhb3RuTEJzNzBXUTkyeUtUQi8ybkky?=
 =?utf-8?B?UGFER3NhYlNTSXFQajlrb0pPUGJodGgwaDBneGxpWmNQQkI5ZC9QZXZkNE5I?=
 =?utf-8?B?RVlCdFlFb1g0V3U2Y01RWEZBQUJtQ3VJb3B3NU9VdnFWb3p5WkpsR1lpbThL?=
 =?utf-8?B?VlZ6dmtkZklKZHBSWUZFN2xRanB6ZkVmQUEvMG1SUEs3UmVrK2Y2cnZIVm5t?=
 =?utf-8?B?U0lMMmExK0tXdFZiVmNaU01SQ1FTK1J4U0pBSlMwMHhCRy9wUWNXMDBKV2dH?=
 =?utf-8?B?Ly9WcStndDZlZ1BlYVhLWVl5RHIyYStVOHpwSWJoWlc4N09WOEYxeUxHQzBy?=
 =?utf-8?B?QmI4MmNocmdVMHpQWDR5VG1PcnR5QkVWdEphVWZ4Kzd3eGNybkdZUlBnbTRr?=
 =?utf-8?B?QTc0aThqOGJIR21ZVDZvTSt6WW5zVkdHcUptTE1qUmxrYWFpUEU2NzNRaVk2?=
 =?utf-8?B?L1ZpMUN4RkZ2QWRLK2ZCU21hU3dSd2RMYXRtRnBHVDd6SUprWWpCbSt4SHNF?=
 =?utf-8?B?YVRzSEpEaHRnc0RtcEpDSWo5RndZbFhVU1NHUzVHOXdCRllqSG5qSnNGOWNl?=
 =?utf-8?B?WVkxOXMyTjRsenRvWWZZeWE2ZTVIRlNmSExaNXREZWhNd1ZESk42WU9VMlZz?=
 =?utf-8?B?RVZTWE52WkVCU3pnWkdDdDE3YmwrWlpMOXlvM0I1ZGJvdWNYa1RhY3VQOFNT?=
 =?utf-8?B?TndaM0pGbWJhVkx1VUpzaUZNcTBIa2hIWTBORHlKMHhTRkFGd1FBMUtWcWNU?=
 =?utf-8?B?Umt4QWJrcEtaWGwvajJ6VDlXMnJCdWVaOHYzeDFGV3ZTN0RwNmg4VmEvMURm?=
 =?utf-8?B?MjU2LzR4UDhoeEpnY1hSWXRibTVncmdMOTFNd2UxMWt5OUNta2hOdW9rR1Nh?=
 =?utf-8?B?b0l0ZEhER3R1Vk1oNERNTk5VSW5aOTMzSFZPNnRMdFo0eHY3THlJVTk4ckNV?=
 =?utf-8?B?TUpLbEpsanRrV2ZoR040a1VyQ0ZxQ0E5b04vWExaYmU1NkpHM1U4UVg0azBv?=
 =?utf-8?B?TndaL0E5Q0xic3IrRyt3amw0a0VSR2puNDd1Ujg2LzdlZmlpeFZ3SDZBbStV?=
 =?utf-8?B?czBCeWZGN0hjT0hwWk5jbXo3ZXYwaC9sUWttRW5TTi8wTGR5RWZHVVozUDMz?=
 =?utf-8?B?Sm9kdTFOeng1a1VLQkxaa0RrTXZRR1FuemdES0xPdVFzNW5NL29hbjZZb0V1?=
 =?utf-8?B?dFAzNUdUc2lvZzJTYnY4M1R3QkpXNVpGNGVKUGIwQmVEbWlWT2E3b0s1bGZp?=
 =?utf-8?B?dEhTcFllSEhucUdrYzJ1bVhqdXZucmtHa2hyRW1kRHp4Y29vNW1pTmFYMlBU?=
 =?utf-8?B?TTR6YjFPNG9hYnNpU29rdmNkbzZXbVdnZGNPVDVxcmtobXZPRmZsZz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9369cb-b39e-4f4d-0019-08da26fb30c6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 20:35:52.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGqWyzdXWb07KGRigW4E2oe5E/1ULspryJPi3lBXZhAkuvQ2ePq8uyD8OwY6RS+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atmel (now Microchip) AT30TS74 is an LM75 compatible sensor. Add it.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/hwmon/Kconfig |  1 +
 drivers/hwmon/lm75.c  | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 68a8a27ab3b7..d8dc58b2c55a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1248,6 +1248,7 @@ config SENSORS_LM75
 	  temperature sensor chip, with models including:
 
 		- Analog Devices ADT75
+		- Atmel (now Microchip) AT30TS74
 		- Dallas Semiconductor DS75, DS1775 and DS7505
 		- Global Mixed-mode Technology (GMT) G751
 		- Maxim MAX6625 and MAX6626
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index afdbb63237b9..66dc826f7962 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -26,6 +26,7 @@
 
 enum lm75_type {		/* keep sorted in alphabetical order */
 	adt75,
+	at30ts74,
 	ds1775,
 	ds75,
 	ds7505,
@@ -128,6 +129,14 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = MSEC_PER_SEC / 10,
 	},
+	[at30ts74] = {
+		.set_mask = 3 << 5,	/* 12-bit mode*/
+		.default_resolution = 12,
+		.default_sample_time = 200,
+		.num_sample_times = 4,
+		.sample_times = (unsigned int []){ 25, 50, 100, 200 },
+		.resolutions = (u8 []) {9, 10, 11, 12 },
+	},
 	[ds1775] = {
 		.clr_mask = 3 << 5,
 		.set_mask = 2 << 5,	/* 11-bit mode */
@@ -645,6 +654,7 @@ static int lm75_probe(struct i2c_client *client)
 
 static const struct i2c_device_id lm75_ids[] = {
 	{ "adt75", adt75, },
+	{ "at30ts74", at30ts74, },
 	{ "ds1775", ds1775, },
 	{ "ds75", ds75, },
 	{ "ds7505", ds7505, },
@@ -680,6 +690,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "adi,adt75",
 		.data = (void *)adt75
 	},
+	{
+		.compatible = "atmel,at30ts74",
+		.data = (void *)at30ts74
+	},
 	{
 		.compatible = "dallas,ds1775",
 		.data = (void *)ds1775
-- 
2.20.1

