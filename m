Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F058C4CFD01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiCGLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbiCGLd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:33:59 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70118.outbound.protection.outlook.com [40.107.7.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FDA6244
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km7yuA27dgd06aVHMXLFZvQIyVjzZw6uIaN83f/kNY1kcjl7GFYXf5gmgcS9QaDUBmG9n/pBhZQy3iqLGO0GvvAoX/XDi8FRMvi7IXC6ozfxjGrXMQEZGfR8kh/33zSmp9QxxFb949tsObL3zH1SjCQgWZ8wd9kw6InYKC5cgepvOckFdL5/vhbLLiXyOSso2gsO2wH84b1Gh7ySD2wW0GmCVtNpAAme7x5ZaHPwyCuL5Fbp5MecYYQ13V3bKEHgafF7koq3S0RrsYISuA0fg0lVl8K4Y/QxBYVafiZdJyHtm9kZ4/aZUQchmD5RIREXFtQTCSpjr84w/vll+/ejrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8Rehcahr8c79qXkX9InDyLFdnTeNi387e24qTLtLlU=;
 b=MScPC228vTYpB4VxdWpj0MvAMk9DXwqYpA9JTRVbVHqJgegHFeq7HTUNKRde3CqWcatntFDtcGSmn0jSo5/0MhOnq8ZaWnMYbTPNyKjwYzngzz9GrcPqqCJiiNS8600u8WUB53PnhKY8qjh4e+R0ilehQyXHsP79lAUmbttCDXrzoFFILBpvHy+e05OUnUMz2vFtWLzUWYq4yuSAMwap5g8mA6Av0dCtmF8M2dU4PgaUoZ1axRr77IdXODx7DD6awZ6UIRBiSyb7U4JihtfNPZzx4dIgiYcQE9vxaatkUleL4+jmb4d9pAwapOtrdzLGyg86dCgrogqNi3gYlUglMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8Rehcahr8c79qXkX9InDyLFdnTeNi387e24qTLtLlU=;
 b=EYpd7xqVM0uvogZnS+Exm6TY/oYgi+9znHlfZdJL9yXy5/X+qL757QqLGBXkuStIYAEeNrNtFzQldeovtaQPDi1gMgpH9+rpk/tIdkrGNqlCTtURsKNQjzlgp5LsTKm8iLIvpEKn+8VWw4DHJcDRyzTCI25ucDRhA2r6KZTiA7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM4PR02MB2994.eurprd02.prod.outlook.com (2603:10a6:205:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 11:32:26 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 11:32:26 +0000
Message-ID: <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
Date:   Mon, 7 Mar 2022 12:32:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: sv-SE
To:     Tudor.Ambarus@microchip.com, saravanak@google.com
Cc:     alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, du@axentia.se,
        Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
 <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
 <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
 <8484ce66-639c-03f5-c5db-3574ea26690c@microchip.com>
 <075a196f-79c2-0d58-15f9-ad5e33e2306b@axentia.se>
 <3beb80ad-d6f8-8c6a-e17d-e40a644bba07@microchip.com>
 <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0902CA0044.eurprd09.prod.outlook.com
 (2603:10a6:7:15::33) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aca23ea0-6bb4-4dd8-356c-08da002e27e4
X-MS-TrafficTypeDiagnostic: AM4PR02MB2994:EE_
X-Microsoft-Antispam-PRVS: <AM4PR02MB299442D46A93D2BEB1EB8827BC089@AM4PR02MB2994.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6ql/WNGxW0sriXrHtkGTV+Jw52s3CFvUboIDtU/Wny5D98KnthqlCGH5CzO72FLoQuYQm7VcMnMOu2i19iY8So8IQwBLhdzXHsVgrAlSh6bEq6AlF57EuBVrcyjOIlOh9DJvT8sSUNMh0GOINNb8hcG4PsEZErhjNiUWu1tdYURIEL1RsW2nEMrTT5q6NKdMnie713/8aHhn7gJfE0xfJ0vfJUAoJDCno6VJpafQNill1wMHn4WNIb/UtZJCPA9aEXYXwe5meeo+ssfV4LMtNUQf2bZHP9Er759ZOphmLfSjLIlsH6Ng18O5R5wfHz/bMDuVqX70Nz0mb5+VYtMXeNjNJ0tpmRNSWGwWxnl98Gg8c6fPKqfJ9zkXHwnjD7ym7gogeix1XNseX9b112ifDzPyDYo9V1UwAckGiVwg5lrnXp3mJKmA8Z7Hzc9+xT8TciC6iT0/92owLGZ/TUiuhtK4z185/UwwZpE+jaR++aK6yu3B3BjVWC1B5AtxORY/0/MMIaYJdbnh9ldHB1+pUMLqQeLcqvW7qkpfrVF6xj+pmPGgTaesXsZVvLrmPwk5GYUqWdg6yX4iCkz8W5qnjXOsg32ThCSFKsDPCKNDqFHaFTpHuB5NiqpmUEZq+BmRY4wf4T72AxvscHNnpDtQ7TUZEOVGEqdFt5zOu5EMOxdPf48YiV2IsprS65VSEiYhiQBXLEpVavFzo+FSzzJ9+TLI/AF5KS9B75DxS+5D/adBbeXa3sC6qQdMM4EZZFG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(396003)(366004)(39830400003)(376002)(346002)(6666004)(316002)(26005)(6506007)(36916002)(53546011)(6512007)(186003)(36756003)(66476007)(66946007)(83380400001)(31686004)(6486002)(66556008)(8676002)(4326008)(2906002)(2616005)(38100700002)(86362001)(31696002)(30864003)(508600001)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0txUTVwNEVoa0dYdld1eTZLMlZpRzV4RmxKYmUwY09KUUY5YVh1WGxJZno5?=
 =?utf-8?B?ZUwybmt6OWU1R05tc2x1Qm5sR3FMWnJvU25Kc3owMVJuZ3JhT2w2ODg1V2Vn?=
 =?utf-8?B?RE5tZjM4VldYRjJXdmVmZ1dLTml5aVYrc2MrWmVXWlJyeTN2Z3V3eG84c0Jx?=
 =?utf-8?B?SW5TQ0I1dFBEN1hwNUtUVy9JQlEwZGZrTUVkMHdnV0hpS1lORk5CcEF2UEs1?=
 =?utf-8?B?dmJ5RS8rM2NrejJBcCtoRWtSKzVmSyttV2FQL0I4b2lOL2ZNcWlQYktBWktu?=
 =?utf-8?B?WkdXR1JLdkkydWhtNm5BNE55M0kxdUZ3QSthVWNQdE9KY3lrVGxtQUVwMWRQ?=
 =?utf-8?B?TjRRdSt3RStIM3pnUm1LUHVLUWxsRTBsVXpVc3JIZjUyc1M0emo0L0JiSTI0?=
 =?utf-8?B?MVlLbkVwMGpIMytEVk5KVlZ5MmNrR1ZSRHhTK3JScXYwOENNRTJyYS9rZ29k?=
 =?utf-8?B?UVRwallDVUZ4K21mY1JVK0hYSzVNbllzajY2VzdFcldQdjBjenl3bHNvQWIr?=
 =?utf-8?B?ait6cG8rMjlVaEs2WFh5bFJlVzJpYU9BOWV3ZWY3MG0yUis2Mk5GUnNFc3dX?=
 =?utf-8?B?K2hkUmY1TnU5ZVRJSEFGZm92RlBCdFltVkxEamdkbXhDQzNCUVF0cHA1TUtz?=
 =?utf-8?B?RXRBMlFNMkJVRHdFRHlEdnBDaHJrZENJYVNITlNSMFhISW5RbkpXMC8rYll2?=
 =?utf-8?B?VVc1SC9LemcxNDlHd3l6OXozdW16WFZZUzBvNXZjMHBKdWVlbk9MOG9zbm5h?=
 =?utf-8?B?MnFSYVVTdGRyOUNtU0FucU11SllwTFRqb0hLeVdrYnpxb09qb0k0ck1qaFpU?=
 =?utf-8?B?RzBHYnhRZmZ1UGFBU1RqUTlLeWVGYXRZR3NsTm15ZDYzM0RWQmxVQWY4L05j?=
 =?utf-8?B?cDQ0ZFhwL2YxaFFGVFUxM2xCcXBmS3h6bUdpckloZDMwT25DSms1RTZpSjNy?=
 =?utf-8?B?bjgwY2lZaDdDdUhiNE9IaXN6UWJoaVA3RlZRNjMzMjVqY250d1JzcVlqME4v?=
 =?utf-8?B?N1JNQXFLUFNZK3hONTcxVWo3eUFsWlhxdXBDTUhoSVUvRnZ6OWFEWE5FYzJh?=
 =?utf-8?B?aDNyQkZZYXo5WFcyUkxPc1FXM1EwbmkxcjNQOXMxd1NSaDduVkJtZlYrMksr?=
 =?utf-8?B?Uk1nNG04NExUOUNRZDFtb1VTU0dVcTJUNlFsYmVFaXJUVitwcUtpZmFweUdE?=
 =?utf-8?B?NTlNd1VvQlU1ZzVqY1ZsUzJCZ0pyRW9qeVQ4SWhiVTRIUDRSN3FxcnRGenFB?=
 =?utf-8?B?UFduaEEzSlNZV29yMDkvalRzcjIwcGhoV0Q3OXJSb1BNOU5QdUNzSmhQcmQ2?=
 =?utf-8?B?ZCsvVzRpZEJUbUUycVJNbnluaUNLQmwyQVN3TDMyck9LY29lTGFyVUwrZjF5?=
 =?utf-8?B?d3loTkVHdlFkUVpMQitsMG9tcGdjckpVREdpWVdEUFJlcEJqYWJQMVZCdmJm?=
 =?utf-8?B?RXZQclcvQXVUN3g5NjJtZE5DdHY5TjFJUEd4eWxkMFBsSGkwOVN6SWNLenRL?=
 =?utf-8?B?UEFlaXRmS1FQRFNFczlxOUZ3dGtsa0YxNU1UbnZpcUZRSmNoZWR0ajRjc2ll?=
 =?utf-8?B?bkhFNXpzdld2c1A2aVNjWlYrc0o5VmxERlJOYVg2SHp1TlUySVFUcFlRblhh?=
 =?utf-8?B?dFd6Y3Zta0R2YnlraUd6c2dhZStMR2R5V3hyL2FNUkVwY2pOaXNVdkZQSnha?=
 =?utf-8?B?VVhtU2x5ak5mS2lweDRIQmlBakVVTEtBUTkzd01vRk0xT1NkaUhESytqZlEx?=
 =?utf-8?B?M25QanlvY0FYc002b0tMOEtFMDkyWkVteWZnVlA5MytKRFNGbTBzb3hRc0Jh?=
 =?utf-8?B?Y2VTbzB4aHRNRWNEOEdoc29hVnhnbWRLWTY3N1ZOV0VEUE5hcEFIWXgrT01z?=
 =?utf-8?B?NkpEWWhYb3luR1dPWVZxK09mdXpiTEE2WDdZN2FBT1F2ZzV1Y2NpNFJnQ2xz?=
 =?utf-8?B?OGw2eWtwb1pJR1loM3NDNTdiWTI0eG45dzRZd3FIN2l5NEJzTUwwaW9sZ2RD?=
 =?utf-8?B?cWVsZTZ2VjZoUlNiaTRSZGJoRzkvUmRKOHgrZzJxOXBhbGF2S08vZ21PUStr?=
 =?utf-8?B?eWdHZ0VHdjgzTExwTjhFQW1VbjZvVGlTMm5ocXNMWmY2UlVjdXBpdHFEVUJx?=
 =?utf-8?Q?l8Q4=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: aca23ea0-6bb4-4dd8-356c-08da002e27e4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 11:32:26.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmFR6AdRS9pU5lIAu1LBm9QeqwCccBYkBszGY3PV5sJugOqvVSSzo2UJvMJhSMK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB2994
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-07 10:45, Tudor.Ambarus@microchip.com wrote:
> Peter, would it worth to do on your board a similar test to what I did?
> I'm thinking whether the source of interrupts matters or not. So can you
> disable your USB and use a mtd NAND stress test as a source of interrupts?
> mtd_stresstest together with scp or hexdump.

That's not a quick test for me, since I don't have modules enabled.
I have located my SAMA5D31 evaluation kit, and I think I will try
to get that running instead.


Meanwhile, during the weekend I made tests with a slightly permuted
"old style" struct dev_links_info, i.e. swapping place for the with
defer_sync and needs_suppliers list heads for this layout:

struct dev_links_info {
	struct list_head suppliers;
	struct list_head consumers;
	struct list_head defer_sync;
	struct list_head needs_suppliers;
	bool need_for_probe;
	enum dl_dev_state status;
};

This produces a new failure mode and hits a BUG. Maybe that's a hint
for someone? I have several more of these reports if someone is
interested, but they all look very similar to me.

$ while :; do cat testfile | sha256sum; done
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
[  690.196564] ------------[ cut here ]------------
[  690.201193] kernel BUG at drivers/dma/dmaengine.h:54!
[  690.206249] Internal error: Oops - BUG: 0 [#1] ARM
[  690.211057] CPU: 0 PID: 1753 Comm: cat Not tainted 5.17.0-rc6+ #72
[  690.217245] Hardware name: Atmel SAMA5
[  690.220998] PC is at atc_chain_complete+0x114/0x174
[  690.225885] LR is at atc_advance_work+0x7c/0x190
[  690.230510] pc : [<c03de48c>]    lr : [<c03de6d4>]    psr: 600f0193
[  690.236793] sp : c0a718e8  ip : 00000000  fp : c0a71a74
[  690.242030] r10: c0f28000  r9 : c03dd624  r8 : 00000002
[  690.247267] r7 : 600f0113  r6 : c0d5bae8  r5 : c0d5ba78  r4 : c0d5bacc
[  690.253811] r3 : 00000000  r2 : c0d5b800  r1 : 00000000  r0 : c0d5ba78
[  690.260358] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  690.267605] Control: 10c53c7d  Table: 20b6c059  DAC: 00000051
[  690.273361] Register r0 information: slab kmalloc-2k start c0d5b800 pointer offset 632 size 2048
[  690.282193] Register r1 information: NULL pointer
[  690.286906] Register r2 information: slab kmalloc-2k start c0d5b800 pointer offset 0 size 2048
[  690.295545] Register r3 information: NULL pointer
[  690.300258] Register r4 information: slab kmalloc-2k start c0d5b800 pointer offset 716 size 2048
[  690.309073] Register r5 information: slab kmalloc-2k start c0d5b800 pointer offset 632 size 2048
[  690.317887] Register r6 information: slab kmalloc-2k start c0d5b800 pointer offset 744 size 2048
[  690.326702] Register r7 information: non-paged memory
[  690.331764] Register r8 information: non-paged memory
[  690.336825] Register r9 information: non-slab/vmalloc memory
[  690.342498] Register r10 information: slab kmalloc-4k start c0f28000 pointer offset 0 size 4096
[  690.351225] Register r11 information: non-slab/vmalloc memory
[  690.356985] Register r12 information: NULL pointer
[  690.361786] Process cat (pid: 1753, stack limit = 0x2b6a6c18)
[  690.367547] Stack: (0xc0a718e8 to 0xc0a72000)
[  690.371921] 18e0:                   c0f28000 c0a71a74 00000000 47a25045 c0478b9c c0d5ba78
[  690.380128] 1900: c0d5bb18 20f28000 00000800 c03de6d4 c0f28000 c0a71a74 00000000 47a25045
[  690.388330] 1920: c0f15a00 c0a71940 20f28000 00000800 00000002 c0478b9c 00000003 00000000
[  690.396534] 1940: 00000001 c0a71944 c0a71944 47a25045 0002eb42 c0f1d050 c0f15a00 00000000
[  690.404737] 1960: 00000000 c0f28000 c0f15a00 c047a23c 00000002 00000000 00000000 c0f1d050
[  690.412942] 1980: 000005f0 00000000 00000000 00000000 c047a350 c047a36c 00000000 00000000
[  690.421145] 19a0: 00000000 c0468570 00001030 00000000 00000004 c0f94000 00000000 00000800
[  690.429348] 19c0: 0002dd98 00000001 c0f1d12c 00000000 c1dec000 c0f28210 00000210 00001030
[  690.437552] 19e0: 0002dd98 00000000 00000000 c0f1d50c 00000000 00000040 00000000 c0b438e0
[  690.445757] 1a00: 00000000 00000000 00000000 00000000 00001540 c0f1d050 c0f94000 00000000
[  690.453959] 1a20: 00000000 00000000 c0a71a74 00000000 06ecc210 c045b078 c0a71a74 c01bc8b8
[  690.462164] 1a40: 000000bc c0f94000 00000000 06ecc210 c0a71ad0 c1dec000 00000000 c091b928
[  690.470367] 1a60: 06ecc210 c045b19c c0a71a74 c0484388 000000bc 00000000 00001030 00000000
[  690.478570] 1a80: 00000000 00000000 00000000 c1dec000 00000000 47a25045 00000004 c16a6000
[  690.486773] 1aa0: 0000c210 00000376 00001030 c04865e4 00001030 c0a71ad0 c1dec000 0000000a
[  690.494977] 1ac0: c1dec000 c08e52c4 c091b8c0 c0b44228 00000000 47a25045 c16a6000 00000000
[  690.503182] 1ae0: c16a6000 c16b9000 00000018 c1dec000 c16a6000 00000000 00000376 c0484250
[  690.511385] 1b00: 00001030 47a25045 00000540 c1d33480 a0000013 c02f1604 c0c00100 00000000
[  690.519589] 1b20: 00000018 0000b210 c16b9000 c1dec000 c16a6000 00000000 00001030 c0483144
[  690.527792] 1b40: 0000b210 00001030 00000000 00000540 c0b62734 c16b7000 c16b7000 0000b210
[  690.535995] 1b60: 00000018 00001030 c0a71c98 00000018 0000b210 c02cfd38 00001030 00000000
[  690.544199] 1b80: c16b7000 c0a71c28 c1dec000 c0b40028 c16b7000 c02d2e6c 00001030 00000001
[  690.552403] 1ba0: 00000000 c02d53a4 60000013 00001030 00000001 c0a71c24 c0a17d00 00000018
[  690.560607] 1bc0: c16b7000 c0100b14 c16b70e4 c0a71c98 c1dec000 c0a70000 c16b7000 c0a71c98
[  690.568810] 1be0: 00000000 00000000 c1dec000 47a25045 00000018 c16b7000 c0a71c98 00000000
[  690.577014] 1c00: 00000000 c1dec000 c16b70e4 00000018 00000000 c02d57ec c0b52718 00000000
[  690.585218] 1c20: 00000000 c0a17d00 0000007d 20001082 00000000 00000018 0000b210 00001030
[  690.593423] 1c40: 01140cca 47a25045 70586723 c3fd4ee0 c2cf7000 c12b4b30 c1dec000 0000007d
[  690.601625] 1c60: 00001082 c0b3f800 c16b7000 c02c5870 00000000 c0182df8 c12b4c20 c0803744
[  690.609830] 1c80: c0a71cd4 c12b4c18 02710000 00002710 c16c6180 00000000 0000007d 20001082
[  690.618033] 1ca0: c0a71c9c 47a25045 c3fd4ee0 c3fd4ee0 c16b7000 00001082 00001082 c12b4b30
[  690.626236] 1cc0: 00001081 00000000 c12b4c24 c02c5f80 00000000 c0b3dd0c 60000013 c0b5b900
[  690.634440] 1ce0: c0b5b8d8 c0b1d6f4 c01995ac c3fd4ee0 00000000 00000cc0 00001082 47a25045
[  690.642644] 1d00: c3fd4ee0 c3fd4ee0 c16c6180 c0a71dc4 00001082 c12b4c18 c3fd4ee0 00000000
[  690.650847] 1d20: c12b4c24 c0176090 000010a0 c0a71e30 c0a71dc4 c0177d40 00000002 c0a70000
[  690.659050] 1d40: c16c6180 c16c61d8 c0a71f18 61c88647 c0a71d84 c16c6180 c12b4c18 c16c61d8
[  690.667254] 1d60: 00001082 00000000 00000000 47a25045 00001000 c12b4b30 c0a71dc8 00000000
[  690.675457] 1d80: 00001000 c0a71f18 c0a71e30 00002000 c16c6180 c017a064 c0b52718 c0a71dc8
[  690.683660] 1da0: 00000000 c0d8b268 c0b0eb40 00000000 02710000 00000000 c12b4b30 c12b4c18
[  690.691864] 1dc0: 200f0193 00000000 c3fd4ec0 00000006 c0a71de4 c01381cc 00000001 c0c24040
[  690.700069] 1de0: c0a71e04 c01382ac 00000040 c0b52730 40000006 c0a70000 00000100 c0b52718
[  690.708272] 1e00: c0b52734 47a25045 00000000 c16c6180 00000000 c0a71f38 00000000 c0a71f18
[  690.716475] 1e20: 00000000 00000000 00004004 c01c1f3c c16c6180 00000000 01082000 00000000
[  690.724680] 1e40: 00000000 00000000 00000000 40040000 00000000 00000000 c12b4b30 47a25045
[  690.732883] 1e60: 00008000 c0a71f18 c0a71f18 c1dd8600 c16c6180 c0a71f38 00000000 00000001
[  690.741089] 1e80: c0a71f30 c01c205c 00000000 c0a71ea8 c02fee04 c02fbe10 c0a71f18 c0a71f80
[  690.749290] 1ea0: c1dd8600 c1c54e80 00000000 00000000 c0a71ecc c02ff91c c07aa990 c0136e98
[  690.757494] 1ec0: 60000013 ffffffff 00000051 c16c6180 00000000 47a25045 00000002 c1dd8600
[  690.765697] 1ee0: c0a71f80 00000001 00020000 00000000 00000000 00004004 00020000 c01c37f0
[  690.773903] 1f00: 00020000 c0d8b240 c0a70000 c0100264 b6c7c000 00020000 00000000 00002000
[  690.782105] 1f20: 0001e000 c0a71f10 00000001 00000000 c1dd8600 00000000 01080000 00000000
[  690.790308] 1f40: 00000000 00000000 00000000 40040000 00000000 00000000 b6c7c000 47a25045
[  690.798512] 1f60: c1dd8600 c1dd8600 01080000 00000000 c0100264 c0a70000 00000003 c01c419c
[  690.806716] 1f80: 01080000 00000000 00000000 47a25045 00020000 b6c7c000 00020000 b6fdc550
[  690.814920] 1fa0: 00000003 c0100060 b6c7c000 00020000 00000003 b6c7c000 00020000 00000000
[  690.823122] 1fc0: b6c7c000 00020000 b6fdc550 00000003 00000003 00000000 0000005e 00020000
[  690.831327] 1fe0: 00000003 bed35b58 b6dce1db b6dcffc6 600f0030 00000003 00000000 00000000
[  690.839537]  atc_chain_complete from atc_advance_work+0x7c/0x190
[  690.845562]  atc_advance_work from atmel_nand_dma_transfer+0x118/0x234
[  690.852109]  atmel_nand_dma_transfer from atmel_hsmc_nand_pmecc_read_pg+0xd8/0x1c8
[  690.859698]  atmel_hsmc_nand_pmecc_read_pg from atmel_hsmc_nand_pmecc_read_page+0x1c/0x24
[  690.867901]  atmel_hsmc_nand_pmecc_read_page from nand_read_oob+0x268/0x7f8
[  690.874883]  nand_read_oob from mtd_read_oob+0x84/0x148
[  690.880121]  mtd_read_oob from mtd_read+0x60/0x90
[  690.884832]  mtd_read from ubi_io_read+0xf0/0x3fc
[  690.889545]  ubi_io_read from ubi_eba_read_leb+0xb0/0x468
[  690.894956]  ubi_eba_read_leb from ubi_leb_read+0x90/0x104
[  690.900454]  ubi_leb_read from ubifs_leb_read+0x2c/0x78
[  690.905693]  ubifs_leb_read from fallible_read_node+0x84/0x2b0
[  690.911537]  fallible_read_node from ubifs_tnc_locate+0x140/0x1dc
[  690.917647]  ubifs_tnc_locate from do_readpage+0x10c/0x4c4
[  690.923146]  do_readpage from ubifs_readpage+0x4c/0x4e0
[  690.928381]  ubifs_readpage from filemap_read_folio+0x34/0xac
[  690.934144]  filemap_read_folio from filemap_get_pages+0x4c0/0x670
[  690.940337]  filemap_get_pages from filemap_read+0xc4/0x390
[  690.945922]  filemap_read from do_iter_readv_writev+0x128/0x1c0
[  690.951859]  do_iter_readv_writev from do_iter_read+0x88/0x1f0
[  690.957704]  do_iter_read from ovl_read_iter+0x1f4/0x248
[  690.963030]  ovl_read_iter from vfs_read+0x204/0x314
[  690.968003]  vfs_read from ksys_read+0x60/0xe4
[  690.972454]  ksys_read from ret_fast_syscall+0x0/0x58
[  690.977513] Exception stack(0xc0a71fa8 to 0xc0a71ff0)
[  690.982586] 1fa0:                   b6c7c000 00020000 00000003 b6c7c000 00020000 00000000
[  690.990791] 1fc0: b6c7c000 00020000 b6fdc550 00000003 00000003 00000000 0000005e 00020000
[  690.998989] 1fe0: 00000003 bed35b58 b6dce1db b6dcffc6
[  691.004061] Code: c5940028 c580100c c584301c caffffca (e7f001f2)
[  691.010166] ---[ end trace 0000000000000000 ]---






$ while :; do cat testfile | sha256sum; done
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
[ 1928.214666] ------------[ cut here ]------------
[ 1928.219293] kernel BUG at drivers/dma/dmaengine.h:54!
[ 1928.224350] Internal error: Oops - BUG: 0 [#1] ARM
[ 1928.229157] CPU: 0 PID: 4427 Comm: cat Not tainted 5.17.0-rc6+ #72
[ 1928.235346] Hardware name: Atmel SAMA5
[ 1928.239100] PC is at atc_chain_complete+0x114/0x174
[ 1928.243988] LR is at atc_advance_work+0x7c/0x190
[ 1928.248612] pc : [<c03de48c>]    lr : [<c03de6d4>]    psr: 600f0193
[ 1928.254895] sp : c17358e8  ip : 00000000  fp : c1735a74
[ 1928.260131] r10: c0f28000  r9 : c03dd624  r8 : 00000002
[ 1928.265367] r7 : 600f0113  r6 : c0d5bae8  r5 : c0d5ba78  r4 : c0d5bacc
[ 1928.271913] r3 : 00000000  r2 : c0d5b800  r1 : 00000000  r0 : c0d5ba78
[ 1928.278460] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 1928.285707] Control: 10c53c7d  Table: 20044059  DAC: 00000051
[ 1928.291463] Register r0 information: slab kmalloc-2k start c0d5b800 pointer offset 632 size 2048
[ 1928.300295] Register r1 information: NULL pointer
[ 1928.305007] Register r2 information: slab kmalloc-2k start c0d5b800 pointer offset 0 size 2048
[ 1928.313647] Register r3 information: NULL pointer
[ 1928.318360] Register r4 information: slab kmalloc-2k start c0d5b800 pointer offset 716 size 2048
[ 1928.327174] Register r5 information: slab kmalloc-2k start c0d5b800 pointer offset 632 size 2048
[ 1928.335989] Register r6 information: slab kmalloc-2k start c0d5b800 pointer offset 744 size 2048
[ 1928.344803] Register r7 information: non-paged memory
[ 1928.349865] Register r8 information: non-paged memory
[ 1928.354927] Register r9 information: non-slab/vmalloc memory
[ 1928.360600] Register r10 information: slab kmalloc-4k start c0f28000 pointer offset 0 size 4096
[ 1928.369327] Register r11 information: non-slab/vmalloc memory
[ 1928.375087] Register r12 information: NULL pointer
[ 1928.379887] Process cat (pid: 4427, stack limit = 0x41e59390)
[ 1928.385648] Stack: (0xc17358e8 to 0xc1736000)
[ 1928.390027] 58e0:                   c0f28000 c1735a74 00000000 f09b5186 c0478b9c c0d5ba78
[ 1928.398228] 5900: c0d5bb18 20f28000 00000800 c03de6d4 00000051 c03dcdc8 c0f15a00 f09b5186
[ 1928.406433] 5920: c0f15a00 c1735940 20f28000 00000800 00000002 c0478b9c 00000003 00000000
[ 1928.414636] 5940: 00000001 c1735944 c1735944 f09b5186 00028218 c0f1d050 c0f15a00 00000000
[ 1928.422839] 5960: 00000000 c0f28000 c0f15a00 c047a23c 00000002 00000000 00000000 c0f1d050
[ 1928.431042] 5980: 000007d0 00000000 00000000 00000000 c047a350 c047a36c 00000000 00000000
[ 1928.439247] 59a0: 00000000 c0468570 00001030 00000000 c159d300 c0f94000 00000000 00000800
[ 1928.447449] 59c0: 0002c404 00000001 c0f1d12c 00000000 c1c78000 c0f28030 00000030 00001030
[ 1928.455654] 59e0: 0002c404 00000000 00000000 c0f1d50c 00000000 00000040 00000000 c0b438e0
[ 1928.463858] 5a00: 00000000 00000000 00000000 00000000 0000c1c0 c0f1d050 c0f94000 00000000
[ 1928.472061] 5a20: 00000000 00000000 c1735a74 00000000 06202030 c045b078 c1735a74 c01bc8b8
[ 1928.480264] 5a40: 000000bc c0f94000 00000000 06202030 c1735ad0 c1c78000 00000000 c091b928
[ 1928.488468] 5a60: 06202030 c045b19c c1735a74 c0484388 000000bc 00000000 00001030 00000000
[ 1928.496671] 5a80: 00000000 00000000 00000000 c1c78000 00000000 f09b5186 00000004 c16b7000
[ 1928.504876] 5aa0: 00002030 00000310 00001030 c04865e4 00001030 c1735ad0 c1c78000 a0000113
[ 1928.513080] 5ac0: c1c78000 c08e52c4 c091b8c0 c0b44228 00000000 f09b5186 c16b7000 00000000
[ 1928.521283] 5ae0: c16b7000 c16be000 0000005a c1c78000 c16b7000 00000000 00000310 c0484250
[ 1928.529487] 5b00: 00001030 f09b5186 0000b1c0 c1d37300 a0000013 c02f1604 c0c00100 00000000
[ 1928.537690] 5b20: 0000005a 00001030 c16be000 c1c78000 c16b7000 00000000 00001030 c0483144
[ 1928.545894] 5b40: 00001030 00001030 00000000 0000b1c0 c0c06018 c16b8000 c16b8000 00001030
[ 1928.554098] 5b60: 0000005a 00001030 c1735c98 0000005a 00001030 c02cfd38 00001030 00000000
[ 1928.562302] 5b80: c16b8000 c1735c28 c1c78000 c0b40028 c16b8000 c02d2e6c 00001030 00000001
[ 1928.570505] 5ba0: 00000000 c02d53a4 00000041 00001030 00000001 c1735c24 c17b5400 f09b5186
[ 1928.578709] 5bc0: c0b52718 00000a20 00000000 c159f400 c159f4f8 00000040 00000000 00000006
[ 1928.586912] 5be0: c0b52718 c04eb804 c159d300 f09b5186 00000000 c16b8000 c1735c98 00000000
[ 1928.595116] 5c00: 00000000 c1c78000 c16b80e4 00000018 00000000 c02d57ec 20000193 00000000
[ 1928.603319] 5c20: 00000002 c17b5400 0000007d 200004fc 00000000 0000005a 00001030 00001030
[ 1928.611523] 5c40: 01140cca f09b5186 70586723 c3fee7c0 c39be000 c12b4b30 c1c78000 0000007d
[ 1928.619727] 5c60: 000004fc c0b3f800 c16b8000 c02c5870 00000000 c0b5b94c c12b4c20 c0b3dd0c
[ 1928.627931] 5c80: c1735cd4 c12b4c18 02710000 00002710 c16e3000 00000000 0000007d 200004fc
[ 1928.636134] 5ca0: c1734000 f09b5186 c3fee7c0 c3fee7c0 c16b8000 000004fc 000004fc c12b4b30
[ 1928.644338] 5cc0: 000004f1 00000000 c12b4c24 c02c5f80 c0b3e164 c12b4c1c 000004fc 003c0000
[ 1928.652542] 5ce0: c12b6e40 00000000 c01995ac f09b5186 00000013 c3fee7c0 c1735e30 f09b5186
[ 1928.660746] 5d00: c3fee7c0 c3fee7c0 c16e3000 c1735dc4 000004fc c12b4c18 c3fee7c0 00000000
[ 1928.668948] 5d20: c12b4c24 c0176090 00000500 c1735e30 c1735dc4 c0177d40 00000002 c1734000
[ 1928.677153] 5d40: c16e3000 c16e3058 c1735f18 61c88647 c1735d84 c16e3000 c12b4c18 c16e3058
[ 1928.685356] 5d60: 000004fc 00000000 00000000 f09b5186 00001000 c12b4b30 c1735dec 00000000
[ 1928.693560] 5d80: 00001000 c1735f18 c1735e30 0001c000 c16e3000 c017a064 c014965c c1735dec
[ 1928.701762] 5da0: 00000000 c3fb0120 00000000 00000000 02710000 00000000 c12b4b30 c12b4c18
[ 1928.709968] 5dc0: 70586723 c1730000 c3fc38e0 c3fae3c0 c3fae140 c3fae2a0 c3fae300 c3fae360
[ 1928.718170] 5de0: c3fadfa0 c3faee60 c3faf480 c3fb0120 00000010 00000000 00000000 c0b032f4
[ 1928.726375] 5e00: c1c00000 f09b5186 c1735e20 c16e3000 00000000 c1735f38 00000000 c1735f18
[ 1928.734578] 5e20: 00000000 00000000 00004004 c01c1f3c c16e3000 00000000 004fc000 00000000
[ 1928.742779] 5e40: 00000000 00000000 00000000 40040000 00000000 00000000 00000006 f09b5186
[ 1928.750985] 5e60: c1735f18 c1735f18 c1735f18 c16e3840 c16e3000 c1735f38 00000000 00000001
[ 1928.759191] 5e80: c1735f30 c01c205c 00000000 70729076 c159d000 f09b5186 c1735f18 c1735f80
[ 1928.767391] 5ea0: c16e3840 c0c22f80 00000000 00000000 c1735ecc c02ff91c c0803c00 00500cc2
[ 1928.775595] 5ec0: 00000001 c0c25240 c013f468 c16e3000 00000000 f09b5186 00000002 c16e3840
[ 1928.783799] 5ee0: c1735f80 00000001 00020000 00000000 00000000 00004004 00020000 c01c37f0
[ 1928.792003] 5f00: 00020000 c0c25240 c1734000 c0100264 b6c2a000 00020000 00000000 0001c000
[ 1928.800206] 5f20: 00004000 c1735f10 00000001 00000000 c16e3840 00000000 004e0000 00000000
[ 1928.808409] 5f40: 00000000 00000000 00000000 40040000 00000000 00000000 b6c2a000 f09b5186
[ 1928.816614] 5f60: c16e3840 c16e3840 004e0000 00000000 c0100264 c1734000 00000003 c01c419c
[ 1928.824817] 5f80: 004e0000 00000000 10c53c7d f09b5186 00020000 b6c2a000 00020000 b6f8a550
[ 1928.833022] 5fa0: 00000003 c0100060 b6c2a000 00020000 00000003 b6c2a000 00020000 00000000
[ 1928.841224] 5fc0: b6c2a000 00020000 b6f8a550 00000003 00000003 00000000 0000005e 00020000
[ 1928.849428] 5fe0: 00000003 bebf4b58 b6d7c1db b6d7dfc6 600f0030 00000003 00000000 00000000
[ 1928.857638]  atc_chain_complete from atc_advance_work+0x7c/0x190
[ 1928.863664]  atc_advance_work from atmel_nand_dma_transfer+0x118/0x234
[ 1928.870209]  atmel_nand_dma_transfer from atmel_hsmc_nand_pmecc_read_pg+0xd8/0x1c8
[ 1928.877799]  atmel_hsmc_nand_pmecc_read_pg from atmel_hsmc_nand_pmecc_read_page+0x1c/0x24
[ 1928.886003]  atmel_hsmc_nand_pmecc_read_page from nand_read_oob+0x268/0x7f8
[ 1928.892985]  nand_read_oob from mtd_read_oob+0x84/0x148
[ 1928.898222]  mtd_read_oob from mtd_read+0x60/0x90
[ 1928.902933]  mtd_read from ubi_io_read+0xf0/0x3fc
[ 1928.907647]  ubi_io_read from ubi_eba_read_leb+0xb0/0x468
[ 1928.913057]  ubi_eba_read_leb from ubi_leb_read+0x90/0x104
[ 1928.918555]  ubi_leb_read from ubifs_leb_read+0x2c/0x78
[ 1928.923792]  ubifs_leb_read from fallible_read_node+0x84/0x2b0
[ 1928.929639]  fallible_read_node from ubifs_tnc_locate+0x140/0x1dc
[ 1928.935748]  ubifs_tnc_locate from do_readpage+0x10c/0x4c4
[ 1928.941246]  do_readpage from ubifs_readpage+0x4c/0x4e0
[ 1928.946482]  ubifs_readpage from filemap_read_folio+0x34/0xac
[ 1928.952244]  filemap_read_folio from filemap_get_pages+0x4c0/0x670
[ 1928.958439]  filemap_get_pages from filemap_read+0xc4/0x390
[ 1928.964023]  filemap_read from do_iter_readv_writev+0x128/0x1c0
[ 1928.969961]  do_iter_readv_writev from do_iter_read+0x88/0x1f0
[ 1928.975805]  do_iter_read from ovl_read_iter+0x1f4/0x248
[ 1928.981131]  ovl_read_iter from vfs_read+0x204/0x314
[ 1928.986104]  vfs_read from ksys_read+0x60/0xe4
[ 1928.990555]  ksys_read from ret_fast_syscall+0x0/0x58
[ 1928.995614] Exception stack(0xc1735fa8 to 0xc1735ff0)
[ 1929.000687] 5fa0:                   b6c2a000 00020000 00000003 b6c2a000 00020000 00000000
[ 1929.008892] 5fc0: b6c2a000 00020000 b6f8a550 00000003 00000003 00000000 0000005e 00020000
[ 1929.017091] 5fe0: 00000003 bebf4b58 b6d7c1db b6d7dfc6
[ 1929.022161] Code: c5940028 c580100c c584301c caffffca (e7f001f2)
[ 1929.028267] ---[ end trace 0000000000000000 ]---
