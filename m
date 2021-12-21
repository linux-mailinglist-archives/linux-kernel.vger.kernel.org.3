Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83AF47C93C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbhLUWc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:32:59 -0500
Received: from mail-vi1eur05on2133.outbound.protection.outlook.com ([40.107.21.133]:17120
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234058AbhLUWc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:32:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQAkuBQnImK59wmD/scgc/b+2I6ukAaQRqDEI3h07J81Xs5OyKukPGdMXoOcX34Dk3G0U5dHOSyTs8eo/4+Wrk5y/r5qD1J3ACMW5MwF20HasEgz7sVrN1UfAVBMoKb2VYA1HMc8X5itz7Y1KpRQ6JCyuo3MT9lo7vLRtp5Pa9ArXoF7Hdg7zyLxSibEBTMuy4buga5dKfd3Ku08cJ0KpFAE2HrmF66wexQ66D/BNQJGsYfbhKLVHTB9iZfttWmYj5qpSD70xH4XEOWyA61LsiZAOSQwW61u+nX3ebRWblhmMUJgnZHq39hZf6iZmGpRYP3nSx9t7nLX/Vo+rxFU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xYv6C2/54Ig5RePaoeNUgTOCRA+nx1IhSkJuq3xD84=;
 b=SabiJXZJk4XhAY4Kbn21IPZOdAU7GxhMUQ5dRC1Raj5zY3+l4Lkn8Zxw5+Y3PfGPThvIBYEyEYk0UV/mkwQxueBFBFYfaFBQ/+1JV2OqD/UnkOobGQbRFONkoJ+6geEU4MeEy52cngiSwclPpAtTcgMFSu32Xfmr5bX8j1HQ13z+tsjWXcTFypW1NServRSV9RoDFIySJEr2lC8Iv8cToAkdByCrI7PwTbsF/olfALzC6QDWzN8O8Nc9242+Lt15buiz1gragRiAvVQ3kjgirKqHUka3M0preKcACL9WaW1FfAVttYz1k9qycvBCL5sQIVqKeUB/NHl97+03dn3Vag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xYv6C2/54Ig5RePaoeNUgTOCRA+nx1IhSkJuq3xD84=;
 b=Im3tMF5Ku+fRKZsU9kU2Mypjwf74yYFPBJ/GnWbjLtbU5Ftm8QLoS7pNRwuoD/yXY8ZKg5UDFYaef7M1h9/hZ3yIcKuixoQof+lkdXZ5Rdajq1afvoZbP9Awrgm/vkZqw/XL+YvxM/KWdXlectyw1XHfppe16tcWuwSOmzsxwCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB3673.eurprd02.prod.outlook.com (2603:10a6:5:8::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Tue, 21 Dec 2021 22:32:54 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 22:32:53 +0000
Message-ID: <10d9d6ff-6d32-6fac-46e0-11262184729f@axentia.se>
Date:   Tue, 21 Dec 2021 23:32:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next] mux: Fix struct mux_state kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     a-govindraju@ti.com, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20211221025649.119456-1-yang.lee@linux.alibaba.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211221025649.119456-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0071.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::6)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 199ff3c6-e3b4-49f3-90ea-08d9c4d1d43c
X-MS-TrafficTypeDiagnostic: DB7PR02MB3673:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB367300C90C8C113D9960E923BC7C9@DB7PR02MB3673.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgAfzXtFqTlEzIOWucOFAFJL39FvGc4EzuuaaRTbNcOlVa2tdrO39Ji2Ew8DhvTKxVUNpnltFu2tz6RuBc1UZ5F8oSoaW0Ixp450CZexvBeTAcHBtn3o0fVvpYNMWj92srXKRaG9S7qdAPn0N6XzDq8XRO6rpPBND+RsFVgSu1/eP3kv4ycO7asv2BsH6TcFilrEX+Mz5vwtl3xasotHOp8zgojHsnt6H3IwEo5l3Gp8FJ2zllEdyN62iOJy+USS6TSZaRqDYI5hy44kw++XxMSSg9Sak9Xfyic9IMzfk3uVnlNER5879zfYCD6puiNmg/ASDhqkLjGnK/g/OBegEMNCyK70KgznMqz5qVXVmNvSxESnHpN2nt9vjYCws5d4SYba6kxun2j+TAqhwnE28weXSjjUubxsTNzb8oEppfwddy9qMYqyv7b2Cdow4lQAFUkBlTKnYkRTOSv11FRzFLneyEcJgJHbKGhj+ZVH4rs/gzHoUEcgx1s1ZQZuJsQlXwSc+ZXYeTusjMO18PLohRHc4JlXw0ML30Xv6dffOQd8eucSFqF1OHK61MaipgAmlnyubhr68qcRf5skOkvQjQt9RstD0kboPVSr6JOUjQszZ8QRTlsw59rV7bdcHjNV/ILkGDlXGJGS6jpp/yNGaMfuJN0FnLlSyBEcCRcUmD4F87z2BlKPDRRZE/PWHj1/cKB1i82mamDGxTy/u8kvn8cZH7BUh8hyCPH/fNYUaZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(396003)(366004)(376002)(26005)(83380400001)(6486002)(2906002)(4744005)(8936002)(186003)(66476007)(316002)(8676002)(66946007)(6512007)(4001150100001)(31696002)(5660300002)(31686004)(36916002)(86362001)(36756003)(2616005)(38100700002)(4326008)(6916009)(508600001)(66556008)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTFsZU9KaUFscnF2Skl1UXU5TTd4M2hHTmt3QTJMeVhzL1E2WC9rK0hhM0lo?=
 =?utf-8?B?QjVMQmFURjAxQkc5YWlPV1U2V1lDYTdCRGtYVTZ0clRXSmpSMm5FNGFYWFlw?=
 =?utf-8?B?eXluV2tEQzI3djJXMVlvcnRvV2g0cVhxVktJaE0xK2t1QjlIWFhSdkI2dk5x?=
 =?utf-8?B?L1BtcUcrY3NibVFaRkkyMS9GRWtQNDVOOVpiUW9DUmd1RXBFSkZDN3ZtcnFH?=
 =?utf-8?B?SW1Kcjloa0F5YUtSN0Nic0oxLzVOUkZLZk9Pd1RlUitzUlJpS2JBYVp6b0cx?=
 =?utf-8?B?cWZyZ2NqK2hUcWR0MWx2NTUzZUViaGpYT256MjJiVkZ4TWc0cThscGZHMVBM?=
 =?utf-8?B?RHpHTFAzQ2czVEg1YWVIeUJaNzVXTEpJZDdzRVpGZWFGTllmdzdSakpRd24w?=
 =?utf-8?B?VEZtZ3VqRlB1SVFIM3E2ZlU1MWQvNENMcW1BMXZwN01nSlROczZwNm9qY1oy?=
 =?utf-8?B?bDgwNHp2bHpMaWQ0YnJVUXlyQzR0L2JoV2F6OHo1eHQzUFpYQkdpQXFYbHRp?=
 =?utf-8?B?QnJaSkVjQTkyL3BxeWRzcWhEdEtISFNTS04wNHYwTGlpL09QRktkYld5eVl6?=
 =?utf-8?B?SWdIdVFCT3lObzhoZnU0aWxsZTBlVW1DNTVnckZHRmVzMUxLcE1FTFA3eGNN?=
 =?utf-8?B?R3Zld09tN0J5OW9TVjI5c1FpaE41Q1U0ekN6WHRiRVAzS2xDN1dsV3NnS2to?=
 =?utf-8?B?Umc0T3lEZU8rTTJKakVYNWFEYm1KUlVCR2IvUDU4bWJVaEhZYlZ2SUdkTnJ1?=
 =?utf-8?B?b1lid2RVaytBbzJQZno4STBJRTc2VkVqdEE4SFpwdDdvOWc0TDlHc2FrZDJY?=
 =?utf-8?B?NXRFM25iY1RqdVYyWk15QTJBT1R5ZGMyZHNUUmxlTmdMc0cybzU0a0E0Tzlv?=
 =?utf-8?B?aUZEYjB2QzQ3SDI2M2dBSE9HQlM4bnMwM3c5dzBlaFg3SjVpWGdLK2lzWFF6?=
 =?utf-8?B?d1MwV2JhTTRmMVV1VWJUeHFpeXkwOHRtZjdwallLVUY5VW1MdlpLdUM2bXg3?=
 =?utf-8?B?UnJwTXB1Qm5LOVdzanpZNVh0bXRreDh6WElBUy9XcWJUaERrRlN6ZSsxdFgv?=
 =?utf-8?B?dEwxNGhTdEUrWkVxR01FMUt2aEd5NDlHU1J5VEdrSjM0am1kZWpkNmc5b3g1?=
 =?utf-8?B?K2tCL09JeG93a1hOTlVhNWNYY1QwUlh6emdUZGRhTDd3aWcwRjB4OE1tTjRS?=
 =?utf-8?B?cVFUZzBKQkhaVmprUlFHekJmZWlIOG14UFBPaFJHci9abGVJZlRsNFNYTTBN?=
 =?utf-8?B?VkozQ2F0Rm1NMkd2TWZqNCtTV3UyZUdFQ1ErVk9ib3I5d2NWM0lXaUJqRUFD?=
 =?utf-8?B?QlVUblVNM0hpK3pxTjJYWGNsbUptNWZrUkdoUGc0UzVJR0pNTStKWWVCQ3RN?=
 =?utf-8?B?UHdJNlp6VlhzdlcxdXpqMjBBNy9ucTVqRTVFUWtXdkZvYzluYWd2dWxhY1Zm?=
 =?utf-8?B?aXlwUFZ3d3pmaDMrMjd2UHl1MllkUEFLUFJSYktwQ2RwV05ycmc2bGd0Z1Z5?=
 =?utf-8?B?elVhYWNPMURNUTNlRHlMaVBDRlh5cUpiOHpjcDVId1F5b1IwUTBuS0diLzNQ?=
 =?utf-8?B?eE55dVYvN2ZGcmVpZmM1WW9BTGV0UG5XYmw4SEN3OWpmZWxxM3oyREVxemtm?=
 =?utf-8?B?WjluNDBONXVlVDBjV0NQdDdMWHhOZVp6bjhIQnNkSFF3eTVHcDZhT0hIdXFL?=
 =?utf-8?B?Z2V0enVqOXBwVE1IeHMxdnhCd1Q0cDI3UUxMd29hR1RzNlp2RTlPYTdxUExH?=
 =?utf-8?B?dWlPWGNoREZZTnozYWIvcHoyK3BuSUI5VDdEbURrK0RZaXVhTWt5TlVsY1hr?=
 =?utf-8?B?NW5HeG81NnFqTUpZVG15d3A5M1ltTjZ3NzJ0ZzdhOTJtNmZ4VVZSZ2hWM0Rw?=
 =?utf-8?B?UmwyR2lWRUhKWVBJVFoyZnl1cDVZZ3VQTHJ5NnBGaW4wT1ZHZEVjaXdMTnp2?=
 =?utf-8?B?aFBWOU4xaTQvQm4rOHlvRTNRMEpRLzRENDJpUkY4ZTIzbmFuRW94VXczYkNF?=
 =?utf-8?B?QlVWY0FaMXdkTWdncmdLZWMxVG43a09hZDdyOG9CTlpMODZUUG00QjdzOEV3?=
 =?utf-8?B?aXd0L1V2K1NEc3R6dSsxdHRFTTF6QWFxdm1uWmI3QTRNK0txRGJXSVZhcGJq?=
 =?utf-8?Q?TERA=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 199ff3c6-e3b4-49f3-90ea-08d9c4d1d43c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 22:32:53.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zmfX8JSz0E1iaOO2JmviS+pKQlm0zFzv98/GPRFs2Q9eZJ/nlZfpKZJA+xCWUDy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3673
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2021-12-21 03:56, Yang Li wrote:
> A warning is reported because a colon was dropped, it is found by running
> scripts/kernel-doc, which is caused by using 'make W=1'.
> drivers/mux/core.c:44: warning: Function parameter or member 'state' not
> described in 'mux_state'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: f20e55504ef4 ("mux: Add support for reading mux state from consumer DT node")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied, but I dropped the Fixes tag. Greg will probably not do a raw
pull and instead add his sign-off on the individual patches, so everything
will get new hashes anyway.

Cheers,
Peter
