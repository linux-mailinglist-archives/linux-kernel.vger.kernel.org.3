Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FFA589982
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiHDIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiHDIuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:50:15 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2084.outbound.protection.outlook.com [40.92.99.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D08CF03
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3p4XlANsdOhQmUyDXyQIcwZqwqlPFwXarg/HPIknNxvbXziu811iecNlpJWRDNLlc6MJmb6QwgXr7M7bPdhxg0YyY8P6qeL/pUnRX5Ef7nbiSMecS20Hh5t7PZmnIQA9Bp69D3BDd6Bv1m25ZfzQScGtW0Shr/9hzBXs+BMEu79jfOxR4dva/Cds97HEi5w2PgitevutfprHJfLVpWJrR5l4v6o5u5RdofXT+n1VDT19Vguxsub0aA/BkGRoPkf1CSYqAUrOT4d+VGb33t7WXFsWrYYPzuvR90o+KCyJAV8h8CCrXi2AbFOS8/KtLY6veeUQo3xfS0glMG0yHCdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkdg9Uw2DDJenvwQxzMJOUa0GhqE3iCTHQdpDYO2SFw=;
 b=lr9oa8jNjZgwKU2b9tAt+FYR6rEFfvV+qPkxh0IRxst4O3nKVWdMXTC1kmYzDIbq+ALj3UFe5/ItII/G8CoVIjbhikHu3sEZkY/hHHm5Dud2j5YM70Av06RssADW7WMd06Ye0010PQEpkCrytJJTAA8baNoaOuOS3MogI02qLN7OLncQzB0Qgo6YBmWZBHvWc7y59OOW3N1TFBz7WCR2EMDChO5v0Qop1nrkNJy6qn+0QeaYxhJL8jftwd605U4Kwn9rmENJxJaBuZcD0KC9vfP1U9Qq+Q/98jYr2VeQwGZZM0qzCQL91eecnSbDe+MjG6TGKXW/g0X98ETtx17E0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkdg9Uw2DDJenvwQxzMJOUa0GhqE3iCTHQdpDYO2SFw=;
 b=NRKWLwrRFB1EhTNk+TyFbT5mg0i9imn9xGBdFk7ElNcLKYf/S0vvV7kW5Gdu8u861A/U4gmXvLcUQz3bkV4gmCHhC3ZtCmrmRhFQE5DZrg801xE+SaYOx0N8X6SPig6u7oORcu7R/Oux3EH+NLMH00XJCatNOR7sY2FOw96rnFVB/vxW+XYPAaN+TharWL3W3tCMpT2dKWgAdsxGtTOuVuGdnaejAXOA06WsziSJGParnt5EkhOHWePPxTff8+dJ8xivbZcpa8ipwGaSuxjEgrruHPbFyUdErgYVQ6+HF5zlwc+MHvbimwBvPM7EvP72+Nj9R0C1PbZphKvxYoZA+A==
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9) by
 OSZP286MB1080.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:112::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Thu, 4 Aug 2022 08:50:10 +0000
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d]) by TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d%4]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 08:50:10 +0000
Message-ID: <TYYP286MB17633E7DDA7739F53B1C4CF2C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 4 Aug 2022 16:50:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 2/3] scripts/gdb: fix lx-timerlist for Python3
Content-Language: en-US
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Liu <liupeng17@lenovo.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
 <TYYP286MB17630AE047E8AD679B37C77AC68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <TYYP286MB17630AE047E8AD679B37C77AC68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [v1FLxUARc1KixvwaoZQW3iiw57/OcUfO]
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ff::9)
X-Microsoft-Original-Message-ID: <17aaa946-6b2f-248b-c885-b1595c406d7e@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbafcede-ceb3-42cd-61dd-08da75f65685
X-MS-TrafficTypeDiagnostic: OSZP286MB1080:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qa8iWaQhT7bL6J0L2YdusJoATiNbHRUgpyXilocItMJQ9ivCLUII8kw3T9cjrzk7QBqYAbba5GP+A1TOHUmt1YsHWDI1YfWSLVewS74DseAUayeezsVBL1FqDkCY/4JshDZmnPkD4V29TRhk9GGFh21KeT67xaBfA7WRbXofSylOlPVy0/EEhz56w+4z+sWd2MCjYm1tl3TO0AgjOanBf9pMD587fi4m78JtZUXzorGDhua60bz7/n9hsxqK+bklLqUI8onlzZU5BJtlA3FP8Vewd12CjFP1+YEWCE9ecvCQK4moojVpY4q5YFUgZ3KXEM0KiGt0jokCT4rzd4qcQnKEQ70y55AmuW7RfQrwUccils4tEPRP5oPh3duiS665QwoCQ37gHgZlqWsBQ0qtplKhTmMMOsdo0rtLzHRftCA0GhfmNtIaFjHMzs6aRYxj2iYvIHx9bo+zWDIhnslncCJUskZu1oEse5foMk/pmhF/rd3uMqrFDuURg8NtGg2YYpvg15QoRT0nrKXJXHYyZObozSk5n99Tu6PFIFJagy3tr+MG4KcxQJPnE1Dqbih1vI6yjLxs5I7hze1zmniqHjOUHlvx0JrVoo2z3TzsZuFOJHQ2FpqpUvTiUdkCw4N4DtvHkQU3viz7zb2fbZGekqDKDpNmiYrkyuUBzJcKtrB8/2sZ2/iWRUtymHs8XYyG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9BREhLU2FTRlVrU1JnVTY3bFZVcUtnQ3gvdGlvNUh4azd2bVhrVjhaQnZE?=
 =?utf-8?B?VjZOK0EvOFlFRkFXZjFWMUhvRW1BcHBOQ016Vmt5Y1U0UHM5alBJWEZZTGdZ?=
 =?utf-8?B?UHpxek9udUlDRk1pMVc1aXYxbC96ZXZLdGVEUDE3N1dHYUZENG84Qy9SWEw5?=
 =?utf-8?B?TFNwT2dETy94RzFVaVNEYTV6S1h4ZFZUTnFLK2xYS0lDODRIK0xldUQyLzlt?=
 =?utf-8?B?elNzZHlqV3NCMExGM2krbFhHeVBWaGw4MzV5OVdqSzYrcVRKM3lOT3poS28x?=
 =?utf-8?B?MVlyL1F2T1hxd3BWcnhBV2RsRk5vV3hmNjNJd2dsU2cwU0h1Z21SUEw2YkNI?=
 =?utf-8?B?VUJYT1IxUXhLZCtjc29NZ3RuS0hBZ1c3NmhxYXZoNngrVXNyRXNUOStkbU5W?=
 =?utf-8?B?Yko1dXlVejl5WnJZa1RGeUtqY0ZOLzhYOWI1TmREUWxoY3hVYmcrOEQwVXpM?=
 =?utf-8?B?N0tDckVDejU2MmpwMlNYVEtsUWJGQk9kdkRsbXhqb0JaWEpENFNTT2FCMFA0?=
 =?utf-8?B?SmFCM1UvOWRaNHJCQmI0YURKUUJsWkozTnRtMFI0d3hPbkM2SEdYNnpBKzhw?=
 =?utf-8?B?TWZrNlAwM3BLc0pCYWFjNW5tMUlIcnVmZ09vcG5zSDFzaWhuSE5BYXVDa1Ur?=
 =?utf-8?B?eU5iZC9OSGtNZ1VGMWwzOTl6TVdQWjhXUTlRY2dpTE04Y1htSUthMGt5NnhO?=
 =?utf-8?B?NXovQzJ2ajZFRWdEbmo3dGpHNUFmRDlqeSs1ZXhNd1pRSHpDeFllMEFCK1pT?=
 =?utf-8?B?a2N6cXdrR1p0MnFTbnQ4Tm1HTHY1QWFYY0pualZqMWtXZnJWdHd0SmxWV1FJ?=
 =?utf-8?B?NEVGaHdkejF5R05JOUxJSVhmcElpcXliMFBKamMwRjhxMzNpSnRxRHd6ZlQ3?=
 =?utf-8?B?Ykk4OU5EZmZvdW1zcHRMWGZyWldMSGFsVWRCeXFQaTQzdTY2NVVINXM5Nk5j?=
 =?utf-8?B?aCs0SERVbXY0dFdzZTZDNThLeXFMckFDQmhzY29Uai83WFlpUUk2akxBZGpx?=
 =?utf-8?B?b0gyWCtRZmZrSkgwN0xYUyt5K1dnZ2JHMmdZR0dEUnpDbWdRdmVZN0czNk8w?=
 =?utf-8?B?Sm9YUlFZLzJZT3o3czVVVkRUNWtNQXFaTVBaVzRHSzIxT3A3eStLM053enp6?=
 =?utf-8?B?NXllT3Q2b0UraStWNFROaUFPam1sVzNyR0ZGTFplaXF1WUY1emIwS2wrMnZy?=
 =?utf-8?B?aFo2TWNQdEpzY1BUWlNLNm5lcTBtSkxXRmxKZDBNRm8rN055TEtlaEV6Nklm?=
 =?utf-8?B?TW5JVmoyWFQ5RkFkdEZ3cENMMGdMTlJCTW4wWktRblowRi9PNlkvREh2L3Qz?=
 =?utf-8?B?RGdVZ1lPaHZHSU84QTBhNnFkb2h5MDhiTktzSUx3NUhIL0hzOVFFM3V5cGdI?=
 =?utf-8?B?OG1RVUFEeXFuR3RveExGVXhUQXJBcGx4Uk1HeTBUZFB2cm16UlgwQUxoa2dW?=
 =?utf-8?B?U3FYZnpmRk5HcmJmcGx5NExuaHIrVDVNWlF1eURSdExnWGUweW5LclpOTDNy?=
 =?utf-8?B?SS9ZU0IxRXBMZU1LY1hHMEl1Tm9RcEkwd1ByUWpBVlVPNGtrWWowUFNIbDBh?=
 =?utf-8?B?cEhTbjBBWjJVSTROeVpQMFN1eWszcG9ZMG5wbmI0azdxcDdEVENoN3orLzlP?=
 =?utf-8?B?WG44MEZHemlpb2VDZXZDQ2Vvbk1zMG9tWHcvaTJrWXNyZXJXUjd1T21kbmdQ?=
 =?utf-8?Q?4IATiGGEyZ5nF3/u3yYA?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cbafcede-ceb3-42cd-61dd-08da75f65685
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 08:50:10.2831
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
> Below incompatibilities between Python2 and Python3 made lx-timerlist
> fail to run under Python3.
>
> o xrange() is replaced by range() in Python3
> o bytes and str are different types in Python3
> o the return value of Inferior.read_memory() is memoryview object in
>    Python3
>
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> ---
>   scripts/gdb/linux/timerlist.py | 4 +++-
>   scripts/gdb/linux/utils.py     | 5 ++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
> index 44e39dc3eb64..8281da068c5b 100644
> --- a/scripts/gdb/linux/timerlist.py
> +++ b/scripts/gdb/linux/timerlist.py
> @@ -72,7 +72,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
>       ts = cpus.per_cpu(tick_sched_ptr, cpu)
>   
>       text = "cpu: {}\n".format(cpu)
> -    for i in xrange(max_clock_bases):
> +    for i in range(max_clock_bases):
>           text += " clock {}:\n".format(i)
>           text += print_base(cpu_base['clock_base'][i])
>   
> @@ -157,6 +157,8 @@ def pr_cpumask(mask):
>       num_bytes = (nr_cpu_ids + 7) / 8
>       buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
>       buf = binascii.b2a_hex(buf)
> +    if type(buf) is not str:
> +        buf=buf.decode()
>   
>       chunks = []
>       i = num_bytes
> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> index ff7c1799d588..db59f986c7fd 100644
> --- a/scripts/gdb/linux/utils.py
> +++ b/scripts/gdb/linux/utils.py
> @@ -89,7 +89,10 @@ def get_target_endianness():
>   
>   
>   def read_memoryview(inf, start, length):
> -    return memoryview(inf.read_memory(start, length))
> +    m = inf.read_memory(start, length)
> +    if type(m) is memoryview:
> +        return m
> +    return memoryview(m)
>   
>   
>   def read_u16(buffer, offset):
