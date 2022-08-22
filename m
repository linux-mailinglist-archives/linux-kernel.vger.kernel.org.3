Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7619E59BCDA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiHVJ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiHVJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:29:44 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2052.outbound.protection.outlook.com [40.92.99.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048C91D30D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5MFgMZE3igu9pLIltVLdGLW++wQsdhkmboVwCD0IjU78F3Fd3NFLxwxzQgJWnmN578x38oKuRHzNcOCP0sV8Z4MzK6E3PZ18SexXJf1t8k8TqrPaI0HFOpb4+nCkJ4DmA0Fo6rO2UoBXVxJlk7BVGdIlngf43ns0O4mLW5hSTpJ3Vgx5yQtovxa2SxtUIhtS1PgSZfUWc/rEpCH4DTcYA2O6D05ZZMVad30LtYxgxGmiG4OKtfPKWUA0xF+VOI+L7V84rubI+80CAZ5fioOUs3LE5LZH4bUjtj/EZo/fVftjNdy0D++TSiMQ9nOkvFCAONW0+G47XsbdcOP/1hlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ejTeLBj2MS2aCNBejeJ19JpDfqU0woNcnS7nmZzaQg=;
 b=i/pCm66ueTl08HQSYV0xr88X9TxO/PSGc62VTzFXBVCe6sSzJb4/+5b6mcxBeLFw2wVuV2Y7qulpg+7dxTr4K2POyu85aa2GqAdkp+1sMzO1vr5kZauZ8h00JSoWYj/U8Mv6Oy3durCL1lzmCcx26qos145lQalrbx/J6nJkDAQCxdmVwS4H3OVnAIcOijASwAEp/7uKp0N79vJv3y8boEJxFQpdAcm52Oj2immUDI2/hSotlFskB7onCAZ07uim9c0K7t2B+jtf1dKCcFnOUd39zcTkdOYRtGBvseLVp/RgyCIKR+CEk2+tnvyPgjZaR+5DLJ3OQN6yJKbiio8VSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ejTeLBj2MS2aCNBejeJ19JpDfqU0woNcnS7nmZzaQg=;
 b=n4rlsrcytB9Sx3DnwM9qAL7HLu/kdsR36+l/X5y6zawa0sgKxYvRnshJBmrzUEGgvtdtuVNt79udBfJJ2iJg0uXt/eNwn9L7IQ+NwzgHuITSsRc95SkFhRUJWWc/vcSaUym9VKwGWHwL0coTm9NNyHlzBHBAFQ9tRlyn223JQ/SHguzkUv/Qwmm5+6a5Hv1mICzjf9INX1cgIOPOG0+iICG9/+GbyYiZT/gZx6AntXnXnGsvUGh2uwR50Wq0j+3XLVkhmVnPmScBHixf0XU2qI34QQbEpCoPZU+ry/Zhl0XfBmAuzbKNYMaJtlEqUHO8ohm544Y7AQFIazPd9Z8lDQ==
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9) by
 TYCP286MB2590.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:241::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Mon, 22 Aug 2022 09:29:39 +0000
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d]) by TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 09:29:39 +0000
Message-ID: <TYYP286MB176395568EC0A0C49C63C658C6719@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 22 Aug 2022 17:29:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/3] scripts/gdb: fix lx-timerlist for struct
 timequeue_head change
Content-Language: en-US
To:     jan.kiszka@siemens.com
Cc:     kbingham@kernel.org, linux-kernel@vger.kernel.org,
        Peng Liu <liupeng17@lenovo.com>
References: <TYYP286MB17634911E6C6951ACD128342C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <TYYP286MB17631A31235CF10F476FFC34C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <TYYP286MB17631A31235CF10F476FFC34C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [1VcBy84+eQP2NVCUTrghd7Aw/vD5aWKj]
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ff::9)
X-Microsoft-Original-Message-ID: <8adb150a-41d7-e1d5-5e3d-856ec7701456@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a95f5411-d8dd-4a7a-fda4-08da8420d627
X-MS-TrafficTypeDiagnostic: TYCP286MB2590:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMgQC9wfnmAeyoy/FbkDa7KnJiiK8hJ5byq1FMgngiP/yqb9ngqHapIVif6AwZ5POXfTBP8P6Yn+yzLxtgLt0BSOI52fw1Jrz2SkqJoVpvtouZc2dI5pe55iyaiaiADh/xz8LVcp7GjQTI50ZLAnBUakNmdsJfnDB81YzM4xmmfwcbRHaHYJuT6hb/NvRHFQcXrRod45rVvvSHte1mTkOnAnwSjmGICDHAj+zJgRAmvgs7EoNWU+g9YE57l6f04svVjpNrMifPuw36SFAxSGR1bFu5fcRB2aPTMM7zn5bohyTinmm70GxjUfEmJMOECcZznFBi/L95o+ywRvBbrEe54ICLoDjDp5paZ3e3DVWx7pHF7KK3J7Lfz5QUKLOPjW6rrMlj/4u/QDNVCOVXZMfI/qNlFTYsyMEyaRyTknETCUoCX+4pWb1exVxMJpQj6VQ4/iRMW2PaK7qGb7V7gx97oZQnSov2lOOOaPo+uYqe52pEy2KozLBiISRQxsmjVjzfK2Bqzkgf+YQX83o0bosfEJ79I9TFu88oRa26cJEs3bkjn1BZoUp788tAtS4uggTq3Y8RFpj4gWPMHsu/IkD/cmxFdUGnO9+axwxtKA6m6JQUg3fcUT5sp3Twyv46EJkJ9nKjOZ7C+WWUmwSWk2CzLF1x9c/eRH/j8uDcIskZGH7h9VgLqu4gfh46S/uVW+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REUrNDVzYWV6emkwd0RVa1ZFWEpDT09BMVltYTFDVFZYenJnN0tobFRxZlNF?=
 =?utf-8?B?b2JJa2I1MDA2eWJKYnd5U2dpRVBkbElobXp3UGZvYXhhWmMrYnd5Nk55WkVN?=
 =?utf-8?B?RVFIdmplTndWdTY0L0RtajU2dkMxL0FlVlcyZi9lQmR4K3NhR1JKSFhnV0tq?=
 =?utf-8?B?U1RKaDVJdldwclRZNXNZNWYxRDdjdW16Szg3TlBCcUlCM0VzaTFHQmNNQ2ph?=
 =?utf-8?B?cXdsOGcyQXFwK0NXQnBHQ0lBeXBuOWl4bld6elVKNDcvOWNkeitEQTRIM3kx?=
 =?utf-8?B?ZThpZUkyNk5EN2NCQnN1SDVVT3FsMDErVEI0N2ZQZzZDd2VHdFVNc3RUNUZi?=
 =?utf-8?B?cHFvT3NjYUhRZFdhcktwd1hFTnRhMWNWbFRqcnhSWTY1ck9GbEVtQjQySEp4?=
 =?utf-8?B?bEdQc1pNMjdFOGVFTThkMWxWNnV4Y0FwUXgrelNZMkxuRmpjTjd6SGYvU2I0?=
 =?utf-8?B?SlhxUHB0dS8ybWg2eGJhYTh6SzFFRlcxL1pMM0ZkaklnS0diZi9VSFJjL1J1?=
 =?utf-8?B?eGpsRVQxWHVsRGFOWmxxSFdocis2V3NaUXJGbTk0L3pHQlh5Z290VXIxUGVz?=
 =?utf-8?B?KzkrQXlPUUhVOGxZMTY0T1B2aUNPN1BhQ0Y0bjl3cUVSQWdMV2dLbTVoVk1C?=
 =?utf-8?B?bTVUOW5IbzFWZHAvYnN4d1ZMUnNUblFNR2U3YXBveERkQmxFdlhmRDcxT2Mv?=
 =?utf-8?B?WXhRVTJyb29OYk1Dd1owYTJpN1ZwMjBzQWJ6aExkWkpaT0NlYXUrbFdxV21W?=
 =?utf-8?B?QjNrM3EraGY4TGtwSXluWTk3OFlzS3dUQWdOeEVTT1p5ekFicnUvS3oxd003?=
 =?utf-8?B?VkZFV3FaN29lRTRJeDZFUDRZaEFVUlVyMkFWVGV5RGlHNGNRd1l4WEVRcTh0?=
 =?utf-8?B?U0Urb0dERGdHTVJMb3FycTM4L1puMHdGbE4wNFlPZFdzZ3dWeHc0SmhoUFRV?=
 =?utf-8?B?NGNsMkFOcDQrZEVpWG94ZWRqQVJHbWdaT3ZYTlk4cXAwU0pySC9PNW9oTy85?=
 =?utf-8?B?MmdWbW5nVUV0ZVY0NkhNelZaN01iUGhTL1NzQUgwdHVMRDB4akJUOUZUcFBU?=
 =?utf-8?B?RzZRWkJ4NFBqaENHM3liTXVmRUtta2FrY3ZFakdwdktCZkt0L2E1Nkd6Y05H?=
 =?utf-8?B?bGtwamswNnZwM01TZlJmaVlKbmUyRFMzS1JmNitvbXB5Nm44eHl4YjNYVnZU?=
 =?utf-8?B?VC9UUjhELzd5YWllNVhNMUNLNWErN3I1dEpuOG56TWdFczBzQ0J1MnFZakJD?=
 =?utf-8?B?aHQ2ZnVUSHNqYkFtQjNVNXdJYzhIQkFBR0hQcU82UmVXZjZ1QS9NeVRrVnpC?=
 =?utf-8?B?TjlXZlFhdGh6QnRqVFU1b2h4RHpLdkIwMjVYdkpqUE9jL3BEbUMrYmgyRHR5?=
 =?utf-8?B?NXNXU2w2WDVkTU9raStMcnVjVmc3eXNWbTBEN3I5MGcwdnZ5aVVqeUV6MWxO?=
 =?utf-8?B?M3FkcmJ4d0RuOUY2SCtzUGIzL3FNZ0RwNzdiYnJxZU85UXFrVXpieEptL2Jn?=
 =?utf-8?B?SHpPVEZpN28vcUxvYmY3S1lQRnc1bkt1YkVHOUd4YzM3d2txUUNhRHE4endt?=
 =?utf-8?B?dElPYkQ1RVVuWk8zWVhwSlJsT3B6eUNpUVdpVkgrWDFNWlhNUjhlbGVOWURw?=
 =?utf-8?B?OFVHSk1SV3B6RWd5dWQ1UmlERjlYdHNhUFFNSE4rSDZ4S0Iwc09CSWNFKzVF?=
 =?utf-8?Q?YLZfv892Ilf/vEQMf3R/?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a95f5411-d8dd-4a7a-fda4-08da8420d627
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 09:29:39.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2590
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 2022/8/4 16:49, Peng Liu wrote:
> ping
>
> On 2022/7/20 20:27, pngliu@hotmail.com wrote:
>> From: Peng Liu <liupeng17@lenovo.com>
>>
>> commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next
>> timer") changed struct timerqueue_head, and so print_active_timers()
>> should be changed accordingly with its way to interpret the structure.
>>
>> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
>> ---
>>   scripts/gdb/linux/timerlist.py | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/scripts/gdb/linux/timerlist.py 
>> b/scripts/gdb/linux/timerlist.py
>> index 071d0dd5a634..44e39dc3eb64 100644
>> --- a/scripts/gdb/linux/timerlist.py
>> +++ b/scripts/gdb/linux/timerlist.py
>> @@ -43,8 +43,7 @@ def print_timer(rb_node, idx):
>>       def print_active_timers(base):
>> -    curr = base['active']['next']['node']
>> -    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
>> +    curr = base['active']['rb_root']['rb_leftmost']
>>       idx = 0
>>       while curr:
>>           yield print_timer(curr, idx)
