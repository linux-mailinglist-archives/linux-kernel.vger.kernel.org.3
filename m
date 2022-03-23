Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7494E5720
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245666AbiCWRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiCWRGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:06:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2049.outbound.protection.outlook.com [40.92.23.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0BE5131D;
        Wed, 23 Mar 2022 10:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebSPD1JVii/YKMt062iQNXOdGsIxMevRYaY7PS66AWlYOALSrw225y35s+xh9XPoW+f73qyCl1pKnPAPJfAuG6X8sYzKehhpPdk/ZQHkjA1r2GMNEMte8WK2iJA1qccHwC3pu/w8OtcSy9iclTJjvWnZYo9XJVfWpB440c2mHRa16CysMUAUlNvIwZpZBbMWhoJgA5L1AnYv0sKQKsL939zAx345GTMcc3j6rxfphrBPJZeiopt0CKAf2pHWCXPnwfMVUawSMZEN20gnXprUvAJAawmFU7uwdTnmnJ32sFYMwvZKPNi6p8AjjtI9WyDlSHmxc112kH4Xsht2lMscjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9twsVmMcRqmtCp/yvgVVQiDvWE6gmHPy2ZRCT3H5Py4=;
 b=J84i+LsldBi7mGTv2Q+afSlRdgP+9Yk0OUgUwr5/nIBPNpD1HVgAd+D8eFdSY8FQGEtqgkLLNqKqi+UJRDvTovcY/MaSftorUcKwqMMtCBUKRT5UJOOAuIQ84d8YWCLoc8JCIWb/7eXX2GJC+rxINjKqA+2serSJlV/0P4zUb8MIo65DkVJD9kbCLHGWXku7IOTeov1Iqgd0Wl50Pec7Rm/ImzmEQEAXzfod4BVTRq3czb+3xzP8Ni4tFZRpQnpRUnuShjqsXVNIPy/RwJXRbdTEIlJWlvdM+fOtqhoxSf+eK+dgjEsn888KUWChiE9eiKHd2aeTKUymfmInWHRFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by SN6PR04MB4669.namprd04.prod.outlook.com (2603:10b6:805:aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 17:05:03 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 17:05:03 +0000
Subject: Re: [PATCH 1/7] ARM: dts: s5pv210: Split memory nodes to match spec
To:     Krzysztof Kozlowski <krzk@kernel.org>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322201144.20320-1-xc-racer2@live.ca>
 <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <51007577-52a2-60a5-0720-7b2c7f78ae3e@kernel.org>
 <CY4PR04MB0567A424CBEFF7F3338EF320CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <f716c6fd-66c6-4dd9-cedb-6024f415ddc7@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <CY4PR04MB05671F31023376B0B7050C68CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Date:   Wed, 23 Mar 2022 10:05:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <f716c6fd-66c6-4dd9-cedb-6024f415ddc7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [BKUENg7DK4p6X8xcWAvpaFyxUSAp2D/ZC+xt6MAYmmUXYCfE5gE5AzOQORT6qyR9]
X-ClientProxiedBy: MW2PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:302:1::32) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <61867a13-e216-709b-e3d5-0137756ac874@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10812755-a393-4131-f918-08da0cef45be
X-MS-TrafficTypeDiagnostic: SN6PR04MB4669:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QOVveUWYKOWdiEHe1LTpuWeAWqm5H27iRaQTlgaNVLQj3/3hp8dlhNTIM6A0VsSd9bs9ffiCiKXL14LKuouRt5ECQq+WRGCNTXESdLEXRqhZUtT8Aaa6bXYlqt713LYh29GJEoY/IcWwzbBm1xwgnwMMYyA07oMdXG1qHO63pFEln9qfzV8n1ywPlXxKhEwpzV1OWeM4B3lF/LYkIwxKhKG/997bqagEaEpFxzry3lbncQTcrSN7a2KJPPfgNA9d+k8TWeFKfediqYmd5IFfY6pFot9LLYIHOAQ5eW7csO/UqpxsdaPF195PHNF1r92GSWhTqrIlZH5TRwaNaogIjh5Y8388p/pQwyO+rNPrMP4vgU74OgbJrOwrh/xX0a7ktsWiKNNN2ApUtuYw5P76Kt6yBNGEIILyvkh8mxMg7nmCouvAlvTam0d+eae5oDK8PbsMdV40QqLPr1Bq3jFQF5B62vPHiJsUCm4lPyVJ7aiL0ympyNuYl1+J9qEkCVRT0Fl6/6NTb99izDlBu5aSKcXYqAcA7rdN4CvyUlyIq5RTMdBqVhruQe0XY6uDXOANQVUw6tLT+F4USnbTxJDbg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdsRFprMTU3YkhDQWM2R3M0eHEvTktxYnNRYS9UdkxQamlRSlAxQTJ2YUZR?=
 =?utf-8?B?bXNxM1o3STZ5eEdERHArK1UzeUNBTDJHek5iUWlNZ3M3OTZ2SmowZUs3MmVn?=
 =?utf-8?B?MDk4ZzVrcXZVaTJsTDkxNElwTEJnRTBSMlpoYTliWm1qMFlyY01RMGJLWjlU?=
 =?utf-8?B?MTJEWU5aWnpodE1iNldnNmovQXBiazk4UFlUSzRHbkw1UU5udzJLdGNWOEVR?=
 =?utf-8?B?WnQxSmQ2SEV4MkhzcW5wcDRma3UydmZQc0VIVWt4YUZodEZFR1pXQTBla1ZZ?=
 =?utf-8?B?QjBzc0tjcGxDMm9JT0FKUnY3MHpiZGxGajNIQkdDd1hSWWlxRXN4VGxoZlF2?=
 =?utf-8?B?MThyQ1kwbGZxeVY0NGRoS0RpQUN1T2FldkJlOVFvZy9WNzR2MWIrV3ZzemM4?=
 =?utf-8?B?NEx6ZWRmaFdLQzNKSXJOZ2hMdVJtanhkQjdRdG12WjRtSlZqdkpnbmJzWGs3?=
 =?utf-8?B?ZUc1TUJPdm1uUUhOa3FWZklDVEVYeGVtRDRNU1VCckMwbnNKY1VEMUsyeTNG?=
 =?utf-8?B?aEg4TXpuY2VZYlBFWVF1ZjdiRHdjWnV3U01hQ1FRTHBNWFlkUldURTBBTVdk?=
 =?utf-8?B?RzVMRC9lY2hULzlzQUphM2M4aHgzNkdhaHRhdHBEYjVqVkVncmxwZ21CRzh0?=
 =?utf-8?B?UXRpVmNKcDgyRHBvSFlUQlI5ZU1JMEMzSnNYWnk1ZW1ISjJNZ1FiME5lN3A0?=
 =?utf-8?B?bVNncTJkdEhhNHVKcmZvUmVLVTUwU1VQYU9BZER2NGRmUXJOUll3akovZDFW?=
 =?utf-8?B?V2R0cDhYNTdCdUxNQmhUNnF1ZS9RbithNXdVZGo3bUw5VUkxaXFScVNCd0ZL?=
 =?utf-8?B?ZzR2aVdQVktGZzJqS0JvaUFiQjhmS3lWN2IvK0pRcXZmRm13d0wyQ1c2bE5p?=
 =?utf-8?B?ZE1NRUc3dExHYlF0YnFTbWZxN1NNZHIwSEh2dnNHK0dPd0FZOFZsT3lLdCt1?=
 =?utf-8?B?OVJqMWpaeUh0NGFEYms1Wjg2TUtlUWtKbnVpQzJPTitmTzJMYStjamtzdkZl?=
 =?utf-8?B?V25FRTIwa3ZObU0rcEhlTk1YVzcyQlovUHlQQkhpMTkvUHhTL1poWjJwNGlG?=
 =?utf-8?B?Q2F0SlF5VGQrQy9ITTN1SE9rVEFGaFFkRjlIY05LOTZQekhlWlY2MkJvcVRC?=
 =?utf-8?B?eHRvaEVER1VTbENCUW5FQnZSaVNsMnEybTBWUFVBekhzTFBtMW9rSmFHQWdy?=
 =?utf-8?B?RlVpWFBUT2lzOXZRcHpFbjNtc2N5Y3dYSy94aFo3anJ5Z0lrSk8zWWhMRzlq?=
 =?utf-8?B?U2VOYmdiVENKVi9udEdNRytsb3NERncrUkJscnB4M2pBNDZrQzBYYUIxVXdm?=
 =?utf-8?B?eFNWMDZVaTloU2xDd3FyOFZneW1FT1Z3VExwWTRONnFzM25wUjBSRmg0azk3?=
 =?utf-8?B?b0J1WTA5WEdsOUM5dnBFN01CbVh4Njh1VkxCU3djZ00wZnJCRmxVN2xET3J6?=
 =?utf-8?B?citlYzI3NmwyTXNYOVVodElyakhDbVZPRXRBTDA5dkU0YmdqS0Z0UjFOeTZS?=
 =?utf-8?B?VzNpWGlXR2REYWoxWGlxcjNhYVF4QVE4aC93Y0pCQXhPSXFqK2h2SjlESWJz?=
 =?utf-8?B?bWVyeTkxdXAzNWtnMmVLd2Q0aFJ4ZEJnUGJCTDhsMnpveTl6ZWxuZ3dIRnhX?=
 =?utf-8?B?S0RLMXBqRTVZaE02cDNPdzdvWXBkdnc9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 10812755-a393-4131-f918-08da0cef45be
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 17:05:03.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4669
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-03-23 8:06 a.m., Krzysztof Kozlowski wrote:
> On 23/03/2022 15:59, Jonathan Bakker wrote:
>> Hi Krzysztof,
>>
>> On 2022-03-23 3:54 a.m., Krzysztof Kozlowski wrote:
>>> On 22/03/2022 21:11, Jonathan Bakker wrote:
>>>> Memory nodes should only have a singular reg property in them, so
>>>> split the memory nodes such that there is only per node.
>>>>
>>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>>> ---
>>>>  arch/arm/boot/dts/s5pv210-aquila.dts |  8 ++++++--
>>>>  arch/arm/boot/dts/s5pv210-aries.dtsi | 14 +++++++++++---
>>>>  arch/arm/boot/dts/s5pv210-goni.dts   | 14 +++++++++++---
>>>>  3 files changed, 28 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
>>>> index 6423348034b6..6984479ddba3 100644
>>>> --- a/arch/arm/boot/dts/s5pv210-aquila.dts
>>>> +++ b/arch/arm/boot/dts/s5pv210-aquila.dts
>>>> @@ -29,8 +29,12 @@
>>>>  
>>>>  	memory@30000000 {
>>>>  		device_type = "memory";
>>>> -		reg = <0x30000000 0x05000000
>>>> -			0x40000000 0x18000000>;
>>>> +		reg = <0x30000000 0x05000000>;
>>>> +	};
>>>> +
>>>> +	memory@40000000 {
>>>> +		device_type = "memory";
>>>> +		reg = <0x40000000 0x18000000>;
>>>>  	};
>>>>  
>>>>  	pmic_ap_clk: clock-0 {
>>>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>> index 160f8cd9a68d..70ff56daf4cb 100644
>>>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>> @@ -24,9 +24,17 @@
>>>>  
>>>>  	memory@30000000 {
>>>>  		device_type = "memory";
>>>> -		reg = <0x30000000 0x05000000
>>>> -			0x40000000 0x10000000
>>>> -			0x50000000 0x08000000>;
>>>
>>> 0x40000000 to 0x58000000 is continues, so I wonder why it is split? Look
>>> at Aquila DTS.
>>>
>>>
>>
>> Yes, it was split in the vendor kernel as well [1], and that's been continued along
>> here.  I personally don't see a reason to keep it split, but there might be something
>> I'm not aware of.
>>
> 
> I guess they wanted maybe to express the physical banks. Fine with me.
> Just your explanation is not entirely correct:
>> Memory nodes should only have a singular reg property in them,
> one reg but it can have multiple items. Why do think multiple reg items
> is not allowed?
> 

I was basing it off of this warning when running make dtbs_check

rch/arm/boot/dts/s5pv210-aquila.dt.yaml: /: memory@30000000:reg:0: [805306368, 83886080, 1073741824, 402653184] is too long
	From schema: /home/jon/.local/lib/python3.7/site-packages/dtschema/schemas/reg.yaml

and this solved the warning, booted, and I still had the correct
amount of memory.

Would

	memory@30000000 {
		device_type = "memory";
		reg = <0x30000000 0x05000000>,
			<0x40000000 0x18000000>;
	};

be equally correct?  (untested).

Thanks,
Jonathan

> 
> Best regards,
> Krzysztof
> 
