Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE8589980
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiHDIuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiHDItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:49:55 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2092.outbound.protection.outlook.com [40.92.99.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669661087
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wesyi+QTus8GrkueMKMm6MQJdoh+DqXsEqnNTC0MTFoMb8Y2snIRj3fmuuaLkTrURKFbaU8ZhXNogg3iuGiGahPId49xXme60G/mxOSy6o36idhd6nq9KJYRRfYaZoAYDCmJKqATPgcG7oPovTNQ/HoCjtzYBq4t2eXk+SDrScgKB/oGAFXEeJwumuBq0bRA+OPpqbIzkwMMH6yKJT9ZF6XZcCZg+dXkfutgKgcuhy6YwlxImWy/EQEjLglVW1D38+Tg23IBty2WqQk80z5ey7tetiaAwuDOpsodPly/7xxzPib+BcIwfr+AHYLpWE6dM7n7UYG05axCO14EYPlUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMlMYzvU47yUThLwlB8+wrM/5jsubdNRgHjmNzMJDpk=;
 b=SHxhw3XtaaTzdtJIgEaaN2J7TLs/wpmy3oAu7FO8/dIJdcBmvlhUcBqV6xPZCSLcX+NLZI2gvo0b0KxrDdVCjZWEy5A/UvkLZ4qmPB5k4XkrweCyI901alyToFNBcYuo/Naa5W6l2CpqNGq1L4IHuWQsKeF3jkMoKwWjhu00f28T4sagOD2OlIbuvpquhEOMaLEAYmd2amDE7irWJdHzP+DGIW8BdlpOkXgH01kkKBWPRJBTWr0qnn17pjCPedI4trFV8h5cZMANnLtaPenG5ClXGzaMoRFhWm2bPmZILOx1rPktPxjzMhvBLpE/Hr6EkFUqz/RPzGV1h8vZ0iYJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMlMYzvU47yUThLwlB8+wrM/5jsubdNRgHjmNzMJDpk=;
 b=AP2iuA8OW3M01x/9AAzw+C4JyUYh996akL/zEef+Qc0QuCEHlLHpWoBRKEJTwwnlMByNBT5vHjqKkkRrq+FMHVY2LXwrTrJWJc6X5UgHXXZ1g0dcOTlbNSCYu87fZIi5VsF/noY3WGS5C9PcUIW5aI5VFRg/CA9UNQVCYHK+6ZqYxM5Ed5llfuJBFo3Yer4UZo3QWAHiejmhAOvDVE7Fsb3GuKbD0ZlP5zWGzYTgSWoZWGFlLt+7zutGPQZQDZaIHEq/r0cd3GzaVqsN85B+GYK9+FwICpjxzV6qK0CLPDKa6iQoZgw/kCRQSwsBxvtrb2KHC2dQFhQDYDemm1Qqcw==
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9) by
 OSZP286MB1080.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:112::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Thu, 4 Aug 2022 08:49:52 +0000
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d]) by TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d%4]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 08:49:52 +0000
Message-ID: <TYYP286MB17631A31235CF10F476FFC34C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 4 Aug 2022 16:49:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/3] scripts/gdb: fix lx-timerlist for struct
 timequeue_head change
Content-Language: en-US
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Liu <liupeng17@lenovo.com>
References: <TYYP286MB17634911E6C6951ACD128342C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <TYYP286MB17634911E6C6951ACD128342C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [CUoMVXRTIsPSY/lPyAm2QwpBGRzLOgru]
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ff::9)
X-Microsoft-Original-Message-ID: <f652971a-2336-5549-3e6e-16b3935fda6d@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b27d72d7-c4b8-458e-6a12-08da75f64bbd
X-MS-TrafficTypeDiagnostic: OSZP286MB1080:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/afoLlLqSxjqn/voQVuP/7dW0A+UaAMb2qywzwoFywO58KmuHGo4TY2USMkiscQMwTYTpaxG9smjXN8k3HxhfNAqfzarx0RbRWL5vLr5pQ2DW5U4Vpx+uT0ZYmYB1FEqTtj0OqFt6/HTgVkX/+mNxAfV+IP+xBzlJ7p3Ncmp9IftKEvKim8weOMAYeYIjXBJ2iR19ZnTfAhGM+EHjVevqans6Q2B9S7Mm6Efzu2WL3jwDVRqi24g9OVmpoeR3low6P6D9CF21LB9C39FL9O968q5YhOX/exMZZk9dVhijjJjGiXdjWEfQGLGbHjwbpBAXdRf8R4QWA3WeVK7HdIvReW89d7t8PirICIf7jD6rIrrv1qLoEEcIgfptEBNKTR6WuyNuERKxD6KWTNfHZ0rvLyQbREpQs3xJ8CrTJrJ8N24ePB1JArh1QgkEszZEGXuDtbcN0nhzde7+HQ8RUmQ/DYAwk1No2/mbAggpKXE8v9zTFHJXcvm9TERgG06sXaUH4RA00uIgoEjnuJCHqrXYtRnnjEIhAxLOHdL4AZUu4fF0ZveJzP2ikuLjCE/sxqQ6IRVliy8qksHt4pF/jbRo9uUEjKvmjiya3QjEETIdtVb1H1oWw96tllf4yiaqbX+75fZgJXW3P0yLGtCR5VWUBS6xZejZsrkw6mMiokWA1Lxnq+KZGMTGSLjnvBYeti
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NElPL01sOWpHT0VHYWlBczZmNHRHT0NpQWJ2aFlVV28yQWs2MWZXbXBzRFVo?=
 =?utf-8?B?a3FZL3kwWUl5MlVRUnpHNVZFclZHc2ZCbDRNWnBNMXRQSkk1ajlrc3ZQWVRn?=
 =?utf-8?B?elFRMjExekRxdXdTczd3V0ZHR2dSaFhjOUwvei9lbDhRcDdJam9YUzdvamZY?=
 =?utf-8?B?NW5ERzRpSld0MXA2U0poVEFPNTNqeWxRUC9WZllEVTBkOU5vWmZEbzNEZWhv?=
 =?utf-8?B?WkpabjcyTVFBYkk4b1Z4Q2pTVHVKZE9VVm9va0ovNjRpd1ZzbjVsbEFEVHAz?=
 =?utf-8?B?Y1BrR1RzRGJ5c25vQkw5dkJ1S2ZmZFJKMHlSemQwbGFpd3lBajY0VXpwSy9P?=
 =?utf-8?B?c1hDRFhmM0ZHWC9MTGl4VnRQVzJaUk1QSEd5ZDd1ajdxTDdVODBRY0MxTFN3?=
 =?utf-8?B?UGhIdFAweWtuMkRKQ0dERnc5WUI3RlRRRnVmZVViTnEwSHVQMzRxejFwbVBi?=
 =?utf-8?B?Uk9vSXZvTHJWdzM5VXZ0VDJmL0UzdTdrYUxtemkxd1hPNzlxekNOS0xPZzdM?=
 =?utf-8?B?RmRWMlVTMXNEYTRRc3Q3Tjc5T1JURGduWnZuY1YrVlVSSUtjeU5Ya0h5cHkz?=
 =?utf-8?B?VHpxVGZLY0ZjSmhBV04xcDY5aGJuZW1DTHB3QTh3aWJTWUQ4TWoycUJtaTZL?=
 =?utf-8?B?bkpzTE1DOWpTQVNLanNQUDUvU281cGM3SFpoUE5HMFBsd2h3bDhOSGw4WjNi?=
 =?utf-8?B?VVhOV1dHbE9RZ1NONFdEV3BkNkh6SWdyNlVNMVIxMnFaVWpzSGNGempxVG5X?=
 =?utf-8?B?a1hIV0FlUkloRnRoeTBUTmR5NlVVY01malJFZG9lQnAvV1dGRGpRUktSSmNq?=
 =?utf-8?B?dFY4Q254S3hVRG9PQ1orMUJUckJvc3A4QlRhWGRXMVczdDNKK2taUjBnQTVp?=
 =?utf-8?B?VGdLVUowdlllRXh0MDVuT0ZRTTVJczNKMzFIbjdIYXpaYXRaTTRwZE1ET3ha?=
 =?utf-8?B?U2Y0R1lHRzhsREV4czkxY3FOd2ZrdUQ3RGlPU3RSdHcvZllIR2g1YUdFN2tu?=
 =?utf-8?B?dXBMZk45TVJ0NGxFTFRYcFZnVndDOFZhL3NZbUVLNm9Sbys3cUlPcmZJcHVs?=
 =?utf-8?B?eTB3Y3dCc3NqSkVrMGsvNzE2NGFLUjdOVjREVDBMWEM4WEo3bEd6QnUrRXhQ?=
 =?utf-8?B?TFBydExmL1JBZnRUblNPOEh2dnZNUGhVS09NZlk2MkZRclEraXMrTHlrSGFV?=
 =?utf-8?B?dUhqMHJCdytEZWZLU01DbVIyUjVwc3NNaS8xbHkxVmpycnJwQzRpYWtBcWIv?=
 =?utf-8?B?NlI2cC9jUzhwZUw1OVEzL1pvQlE4M2NVOGVybTg0eDcwNHNTclRZczBqNm5r?=
 =?utf-8?B?enB4N0s0b1ZaQWR1ZzlwR3c1cGpYWkRES0tMOFVpcytIM1QwRDhObVllS2xt?=
 =?utf-8?B?QTRhTWpTaDlLY1ExUHVpcE9aY2pnRnFVRC9DQlVxRk1YV1hmTE1lbjBRSHNn?=
 =?utf-8?B?NEdRbFpHVUpHUnlHL3ZIUUVNeWV5VjN0STdCdThkVnozYmFZd1BXenlzTFZN?=
 =?utf-8?B?WDA4enlVMS94OHF6d0s5VFQvR3pheE45V3lsVU1wQi9mQmx5Mjk4VzIrNEhm?=
 =?utf-8?B?dFN0RzF4cVBwemZFYTFMaWRNSUgrdDU0VFl0amJyeEhIbGFYMjljak5xV1Rr?=
 =?utf-8?B?ZG1FcWFWNWE2ZFI1Qnp0Q29TeEdKMEZMOUVSUXBSdjVYeldVM1M1NVlQSUll?=
 =?utf-8?Q?8EWM3BQVWH03dR1nk7r1?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b27d72d7-c4b8-458e-6a12-08da75f64bbd
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 08:49:52.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1080
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 2022/7/20 20:27, pngliu@hotmail.com wrote:
> From: Peng Liu <liupeng17@lenovo.com>
>
> commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next
> timer") changed struct timerqueue_head, and so print_active_timers()
> should be changed accordingly with its way to interpret the structure.
>
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> ---
>   scripts/gdb/linux/timerlist.py | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
> index 071d0dd5a634..44e39dc3eb64 100644
> --- a/scripts/gdb/linux/timerlist.py
> +++ b/scripts/gdb/linux/timerlist.py
> @@ -43,8 +43,7 @@ def print_timer(rb_node, idx):
>   
>   
>   def print_active_timers(base):
> -    curr = base['active']['next']['node']
> -    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
> +    curr = base['active']['rb_root']['rb_leftmost']
>       idx = 0
>       while curr:
>           yield print_timer(curr, idx)
