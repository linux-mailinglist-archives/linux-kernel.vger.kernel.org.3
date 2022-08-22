Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC0059BCDD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiHVJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiHVJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:30:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2040.outbound.protection.outlook.com [40.92.99.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B148B2E691
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfJRUJARM0OkgSx7xdQ3RgmYQDvEWg86HZI6Cd9cdexQVvtG2l2eGYbciyz/T5X6zuxBL48zvfD+pDnHaZI0SM1RQm9sFNgLC8WFlkrF3fGNsWwP41el0lO5foH7RAe/6bAOqr1M5uCOyQSUyI1WIyLearTU8h+kMjzFlvdxGeGet02df+uxP0d3Rja8zZhC+bB+279gyZTQ7viKqdz6vOGv2LoMWq7YufLUm1hRWrgx8r3+DAxlC0qoMrMffS6gia02LFrheX2oc1gA2LAcf8DeQZp53U0aGB9cGCb1mF1gKcYbZcY/a9dS/WO4tdLyCXI5zJQhP7m08V4SvZBY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvP0e1GSnMyhyfWbhoOVTgnVwTkUNWgVDvddSz2phn4=;
 b=Yhd8HCGgNFCo/CplQyPHX9fpRqtK9rRIh0bcGEm1X6uKK08o2TJI3PNV59p6avyw3SjIagl5G2plbTqekPOqe8/UA2DRguUaE5QEHnf/1fFi+OZdrFvW7DZ0Z+8w+ECF9kDJ0mFR0zeHIX9pEaEE++ANhmIyjIaqhToplCuYcCAgkdgcb6amUYKq7SjLS54hEGr3NIn6lAAYG0BquFXbPlZdhcU3qTxUy1MquDzhqQsW1mgLjPPMx4grW1E2kVb/YzColr4FcGfH6vHW5xmvRsx8MwZ7LZVr70dCjChfj+PgKKAs3gxc4GKrHvnca90kb9mhO8ag5YoDRDM4jzJoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvP0e1GSnMyhyfWbhoOVTgnVwTkUNWgVDvddSz2phn4=;
 b=vHT3efwnuwvaHE1hsk9AXXVveQR4IgjDOsPS3gtQDRuoHpivpsGGJt0AskYlxlv9Cyxd33DgwsH6t/34DsvRHF7jsEZCkZ9n7ttmSblUUbz/Iu2jauE/nWAjAFH/7xGEBeHlSMCnsblZ5/q1PLz6XgFXNu7zBvxwwceoMK9JFQczYOChWP34+/HF7zeXmZIhYpC9vX+fO5lqTmrZHwNuwMEghIuWymSSPqQkJye01QkITrV5yyjn+1b+/qiCKRpLY4BTWQJ2yUtudAAIZZF0ifLI2OfgyMlNbu4WpY60CnK8Lz3VNj08ZYpH5vj8uQxEA+n3aaZhfYORlzCXBBdWOw==
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9) by
 TYCP286MB2590.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:241::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Mon, 22 Aug 2022 09:30:28 +0000
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d]) by TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 09:30:28 +0000
Message-ID: <TYYP286MB17634FC71CA47477B6C4031DC6719@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 22 Aug 2022 17:30:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/3] scripts/gdb: fix lx-timerlist for
 HRTIMER_MAX_CLOCK_BASES printing
Content-Language: en-US
To:     jan.kiszka@siemens.com
Cc:     kbingham@kernel.org, linux-kernel@vger.kernel.org,
        Peng Liu <liupeng17@lenovo.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
 <TYYP286MB17639886A7064A1E610FB2E3C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <TYYP286MB1763C4319C6D5CC50E5ECCF2C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <TYYP286MB1763C4319C6D5CC50E5ECCF2C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [rn35RbyBrt87Jcz/C/eR9LAKjObInp8a]
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ff::9)
X-Microsoft-Original-Message-ID: <e98babba-96c9-002f-b96f-ac03e2c94eec@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 665b9129-81ab-4759-f0c5-08da8420f36f
X-MS-TrafficTypeDiagnostic: TYCP286MB2590:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I312KjdiKNuDt5Au3D9cdHClWQ8AUiqvh63psOu8eqF2le7VFOY7q1G7tFED30dfEJtjPiwrU3MkGSKPK/kEFQnTkQSLWzz00BPuYOf+BkxqRkXyvDwMQsnPCFeR1bzkIwHmoBLn5hwOkE3N2BbgbMd/QmIhBqywIeidUVvqA62N5QoeYTczc1OxQujkgDu2vkZKvdqMqLI5BN2hb3eELl5L45RfgdSU4CJXAqWM60g2A4Cwhh1GaIswVh0jcEnru1vgwvXSZOW6C2eQ6fKJaQztDZyoD5imeC4acWdyOUyAYWMIcTv2G2vXNNlQ6dSzoWvahSt7Nn52m+y0p9nlIq5i/JGu2Bhprr0+S/0A9qqGsqbtuuVcjfhfk2L6MWc9ZmXgDj7O9zY9oMdqZ5RoujTfIfmT5bt0So2W5IGRA7XVPcSX1+s4N2ec6xjzDAR/hhVHvHJA5oTGsX66MSqdGolmv2ZQpDn/SL5P14N2N/lmei1Y41f+VVZ6cD1HmB8Vt+MC4ILMmnqvv8f1o+8Vq4Vul8z/MQIELjYwIn685ocJKefc0Ek/zT3ttkptkgXDdlG3XFJE78/a+xjtagCfLoZS4DVoL5cWoXhPOH9YTzY7wYrCCuNmaK743Fn3MThRGnl2L3q8BZxV1IEqCqs6kPIW9eLd8CL+t75LwncoFSjf8ztvhGNnI3FzRpxmZsrO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZOdGk1bWJrc1Q4amUzVS92OHZ4YXNycTQreDk0SDlFb01vYkRUa0dKM3Y1?=
 =?utf-8?B?RkR6dlZ1WTFCakpCVlpWOHlnZHlzdlRlQk5mbmZ6YzFNR2NNUThtN21RMHFs?=
 =?utf-8?B?bi92QkJidEUvWTc4UmE4eHp3Y2VnQUVkZGNMUi9qVUNYbWQrMU1vSmVBN09C?=
 =?utf-8?B?MTFCT1IrelMwMlE4M1pEOGgySWNRYktPYmEvU3I0aE4vZHJ3VlNHc0crL3l1?=
 =?utf-8?B?c3hBTXU5dnZxWW9kcG9zdnpFTG1nZHhPUk05VnlwOUdGazlydkh5dnFpYXZC?=
 =?utf-8?B?alhGSHRZb08yU0VodHJ4UXdCUmZhWnd0S2hqdGtvRXkzS3c3NXNKcFVndis3?=
 =?utf-8?B?SW5ZY3c0ZG1UdmxWV0thRk0yZ1BCNDVLN2dVd2RidGhZdTNzUG0wSzJoYjVV?=
 =?utf-8?B?RXVuYTNhRmlwVkh3MTFOTzF6OEtRRllRSDdSYS9wUTZhdDVRMEYrUFduSG4z?=
 =?utf-8?B?Q1U3RmNyb1JxVDdBSzkyam1sa1dkQTJqRmxESzUrV3VIL2JpQ2ZqR3NWNnUx?=
 =?utf-8?B?Y0dwUXIxVEIwUS8xNkR4WEZrUlJQSE5WRTk0OG05Rnl0NW92MldwM1J6eFZV?=
 =?utf-8?B?S1NNdElrSWJ0Vi9tZ2UxdG9Hem51bGd6K1VBZVQ5LzNXQmFja3JUMnVtYWd5?=
 =?utf-8?B?Q00vb1NOY1RzQ2hKV0sraDJyWTVLclBRZUZXSStESGtvc3VPRjl3dExuNmVC?=
 =?utf-8?B?YXVZWnlsRC9ieEh0dk55UWtQeDFndDdqSndNRW0rbW1ReGRDeDMyYjMyRC91?=
 =?utf-8?B?MzFyYkhXYzYzRjZCZU9pNXlFZzFMUW9tanBNRlVnRUQ1cUFVZDROU1FPWTAv?=
 =?utf-8?B?TElyOERCUldsT3JEcHRaSjFMb0s3VjhJUjJkZE1sZFIzc0xvMnBROVlJWDVH?=
 =?utf-8?B?ZGo4WDVMMUczL1c1emhEMmQ0QjJFb0F5dlpCaGRSNHZBOU0yYy9HdlpSQ0JB?=
 =?utf-8?B?SmJtajFTNVVsNTMycXliV3NIUmdkeG1rWkJ2Z2dIQVdFVjUrUCs3bjBzZ1M5?=
 =?utf-8?B?YWJheTZSNzZoUHZzRVpDbk0zTXI3NCtPTmMvdEhwTjF1SStSeVpnd0svRGpq?=
 =?utf-8?B?N3kzSDJWUmN5ei85b0srL3BQZTdva0Rsb3RmTHJ4cDRQNzV5STNJUkRsaGVx?=
 =?utf-8?B?aUZMaTF6cXJqTXBnUzJlNnVwdGtLeUc5b2g3SWxJQzZDMU5PTU1KYStnT0Iv?=
 =?utf-8?B?M09FT0NNdkp6RnhzV3dDN2IrS1o3aS9hMjhFVFI0YUdCaDUwUnJ1eGZQVmdm?=
 =?utf-8?B?RmlqV1h2Q1pFbitCSGlxK2toa1ptVWJyTVV3VkhGSnhJUTRYeUVjdytNNXFP?=
 =?utf-8?B?aG9zTXlPMlI2dDR5bkRMZ3oyL1VhY05PME9QeWt6ZmhER2licDBwQSs4M245?=
 =?utf-8?B?NndsZGJFbGlxRkEzNHQvS3h2eGJXSmpOQnc2MTJxOXhSclk2enpGMi9yQTcw?=
 =?utf-8?B?dGlrbGMzQlZQdk8vMzNIdWo1TWVXeFlLTzZvU3BrY1YxZDdka3ZiNmRSQnB0?=
 =?utf-8?B?Q1NCRWZQcENGeFlCT0hnbDJzT0R0VkxxSGNJc29nUlE5cGRIOVN5ZFFhcExX?=
 =?utf-8?B?dkZDRm9Ya2VlY2tDMXRNUHBlOWhpUndxRU5wVWUwb1p4SCs5cXlEMGp4VW9k?=
 =?utf-8?B?VTVWVEZBenhJb2RJMEVmQlRvTjFrZDI3SVpNdzVJUVhiV3E1My9wKzBjZk0v?=
 =?utf-8?B?ZWIrTC80MGpOcldtMVlCcnpod1hFREZIQWtwOEFUdnV1bEV5UzdUWFBBPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 665b9129-81ab-4759-f0c5-08da8420f36f
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 09:30:28.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2590
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 2022/8/4 16:50, Peng Liu wrote:
>
> On 2022/7/20 20:27, pngliu@hotmail.com wrote:
>> From: Peng Liu <liupeng17@lenovo.com>
>>
>> HRTIMER_MAX_CLOCK_BASES is of enum type hrtimer_base_type. To print
>> it as an integer, HRTIMER_MAX_CLOCK_BASES should be converted first.
>>
>> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
>> ---
>>   scripts/gdb/linux/timerlist.py | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/gdb/linux/timerlist.py 
>> b/scripts/gdb/linux/timerlist.py
>> index 8281da068c5b..249f0e804b24 100644
>> --- a/scripts/gdb/linux/timerlist.py
>> +++ b/scripts/gdb/linux/timerlist.py
>> @@ -188,7 +188,8 @@ class LxTimerList(gdb.Command):
>>           max_clock_bases = 
>> gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
>>             text = "Timer List Version: gdb scripts\n"
>> -        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(max_clock_bases)
>> +        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(
>> + max_clock_bases.type.fields()[max_clock_bases].enumval)
>>           text += "now at {} nsecs\n".format(ktime_get())
>>             for cpu in cpus.each_online_cpu():
