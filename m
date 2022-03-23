Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2AA4E54B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244970AbiCWPAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiCWPAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:00:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2045.outbound.protection.outlook.com [40.92.40.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9932F43394;
        Wed, 23 Mar 2022 07:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYpTgrEfmcT+6pm00iebGZBsG2f5E5+OSe2ycy7qtr7ralvS7YAHp2EI77Lx1eSDbh6tq8xkggu7GCuhSiB0rz3GqgqLgB164ngzmle5xXYpGPV1rDg2EaeApS+vcshbBogveAaSRwbE3Ocy2kEyU4j3lejLuc1eLWY7D8LvQzEkyaCXOC1RMvmZjEqE7hX2S7YrxEly+GI5RlTh4DQb7+a8Q/Clk84xEzyPmHCIX2dc+buRgQbPZYMps4KF95Nv08n9TwAzQllW7l4ip8kJYtWhFBmjVkkSTVyU5fSP/nxDYAIOIrkv1W8afC1q/fTlJEIEg84Js+0sKSSTiuHa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hG8LYIuSkyNV1pCAn4DMPVmR7yJ80Xw4TvCXGXyNOo=;
 b=FujR7CJosYQaXHL3HIjZ9fCfU3Y62V1K6jPgfZ4tYEsbR7FTDQkR5hGvS8R4iG7708w3r2dSjf3RG+zWK/N9W0qGzVzzD3nD2XW/veqO3+cmlKNwlSrpJ8MvYLXnxisu9tuCC4lrUnlkBO4OQAF/9FJnQWwfLW20qsJGtkWdVcnRxtNGMIZI0c41auopP60v3XKj4IIx6elALr4KRCE86M1DQC0XGsFOfxcM5d+iIfsC088PDh/w6Iy8RpDl+TM4t4ZGonvapP1YTlWXS3cj8Tfmjlvy5dSjTRpolWppH9PpHTOW1AWuKCei05+6NUvZ90XgUe7b9zat+8qfKmGSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by MWHPR04MB1024.namprd04.prod.outlook.com (2603:10b6:301:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Wed, 23 Mar
 2022 14:59:14 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 14:59:14 +0000
Subject: Re: [PATCH 1/7] ARM: dts: s5pv210: Split memory nodes to match spec
To:     Krzysztof Kozlowski <krzk@kernel.org>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322201144.20320-1-xc-racer2@live.ca>
 <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <51007577-52a2-60a5-0720-7b2c7f78ae3e@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <CY4PR04MB0567A424CBEFF7F3338EF320CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Date:   Wed, 23 Mar 2022 07:59:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <51007577-52a2-60a5-0720-7b2c7f78ae3e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [2zr9he/MfPFCxkOYBxoOQPNdvyajNXH+C3uCCi1OTaUovCd7BBPVY5Sl3luwtuum]
X-ClientProxiedBy: MWHPR2201CA0056.namprd22.prod.outlook.com
 (2603:10b6:301:16::30) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <84ef4c7c-da66-8238-e1c8-bfc416bfdc5d@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d01a3398-e1d9-4bd2-7eab-08da0cddb228
X-MS-TrafficTypeDiagnostic: MWHPR04MB1024:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +InE+5bRpwFBIWr+upIaSXaWYOA5xcKP6yZKf14zVPOUdCZlplX7DGQXQtAEOG0YI+FaljlE3cEqXCZ1BRT5k7fEjXvpiXyQQtdO/WpG4Aa6+zvx/pKgcPSrAJwtX/K5VhpVNsb1Y9ewtXbYzjU7XpbalyBMgEEjf3TKReVFIG/G8HFBfTa11CQBGsCqe5PhEL2PrcFLGOnbnzSoMDutipIcGNxznHZunApN1AQA0B9v2Ltyve6A9zxmbXUaE6YCqKYKvYD+RWAmB4o4+xgjRUENjUECCvwk+gEtaJ0UM5JMcGwdsIfmOlGrxMxkDtUjG1KyDTsVJ9Xq/4uEC6Up+UqtQ54dEMZknfmc9oTNL7IwyVKFcWeu5pb15cZ6I7WTRT+Oueo0aParFqfvoAjahTvz6+emsJAMgY+xpvg2/Oy55lUK6B6X1S+3AGxMmxbayEtMEqp1TkzN4t0XMKbMwu+XzeYhpqms/E/tCqwHbQMSeqZ9pQRr0Mt8l2w369yH1y2nDkAuBuo1i1A6zJLd/B1V7EcSiclXqyxc5lcmVxlz/7sVyKiB/nKWpFp0t6Yfa3nkEskfE83QXGvBzzxBQUM9fW8JIPjaSE2vEu8CwHE0g105wH2bIym+3df0f2Gq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRMbVFtOExlTHlPV3NJcUlBVjBVeUE1UVhXQWVxeVJuUElLZElZbjlFV0pN?=
 =?utf-8?B?Z2x4eXlqbmdlMVBOQUViL2J6cS90UkpGa2ZnWkF5TzY5YlY3NW1xN3pVcHdF?=
 =?utf-8?B?cDRvVDU4aDNGYjdyKzBocmxMaGxPMXRuVzcrOGxUY25VaDdJb2tvUTNnajlQ?=
 =?utf-8?B?S2xBWHA1QUpBMVdtMjBiOTZkVUIrRXh4MU5VQTB3TGZ3b1psaE9sdzAxc09a?=
 =?utf-8?B?M1JWdVNXZU1Ua3pTK1g0WXJBNEtnWm1sa2JQcmxyYnJld1NTMmVxdWU3MW9H?=
 =?utf-8?B?TVA4U1lRZHNJNzBEZlA0V0lFNWFQbm0xa3hhS2hWbm05Szk5Z0UrbHpGajMv?=
 =?utf-8?B?U05MbzE1SzhZby83SzBENzVDZjNaMC9wTTAvbFhBR05yWmNtZldkb3k2WXZN?=
 =?utf-8?B?L083SnQ3bkt2QURzMVorWmR5WGt5NThWQXZTeXdtUGo3a2ZaL0NUeld1T2Z2?=
 =?utf-8?B?S1B3Vi9Mbm1uTmlpbVJuQ0VISWMrOWx3bXBLd1hMSC83WGl0aGg4enlPR0tP?=
 =?utf-8?B?VXJVNXNEaWFHVGxlb05OcWlWcDRWWVRsNTFpdHRJZFdwLzJMZmgvRE1vbG5V?=
 =?utf-8?B?N1E4MXgyc1ErM1V1SkNqUWxlRExNMDkrTjM2V2FGbnY3ZUlQajVRZ2d6M21z?=
 =?utf-8?B?elhSbXRPbkxhWDlrcTY0NFAwOFhFNkJuRURaZ04ySERWSGRReHZJNGpod0Jh?=
 =?utf-8?B?WlRhanBDZEVFM3FWVjBOTDFLZWtSRTQwdVlUYU9rZ3ovVWdsRE12V3ZNNmhz?=
 =?utf-8?B?dmYzMEFUdjVqcFBERnlVblkzeDdUdm9qSzllR2tON0pab0l3UVlJVitNdmhX?=
 =?utf-8?B?TFVMWjVTQjZadzc0WDR1S3QwL3BLRXZYbXZkaE44Q2Q5U2dMMkZhcTlOby9w?=
 =?utf-8?B?Wks4WU5QUm1wNUgvVlIzVksxdEluVk5QNjkwWWRuS3VTVklvMHFqTVNQSklU?=
 =?utf-8?B?bGlMSUdNSklwRllLbFdWUFJpenkvTWMyamRVTURNLy9BdUJ1T3AwQnNKMDBB?=
 =?utf-8?B?UUlibFJqUWxUUDRhZ1B3MEdTejBINHBqbDY3M3NvSjk0amNRSmJZOEg2d0xy?=
 =?utf-8?B?YXgrb0MyWmhLdGo3MlY1aTloeE0wZkZ0ZHRzRjZ4MGlhNUFFcmZSMUpwakZj?=
 =?utf-8?B?KzVrWTgvKzhjaUpwTk55Y0VwdjdlOW9NMXFwSDZNQ2RvYlFVZk5OMDRHS2hX?=
 =?utf-8?B?dUxXRWlNS0l3amgrKzBjdEZYRDY2ZkJxZ0xaZ2JJdEFnUDdtR1Myc0ZmSER3?=
 =?utf-8?B?MUFlTUlYRkpDMnJRR3FObTBXZFcvNmRnUHA4S2taR1N5ZGNUdUpSZEdudzQw?=
 =?utf-8?B?d1QvOStGYnRlS3JqZFV2ZGhGZkdzWmJNeW0wOGluNnRWRDlSNWtIWUIrY1Ey?=
 =?utf-8?B?bkl6dGE2bFFKS1BvUHBLNFJDaXRMTGFoc2dwbTl2cDFUdTNyTUJXM1JkNHM5?=
 =?utf-8?B?allaZWt4cFlNSzBObFFUZklxYnltQjJEczNWSjJLSHVJMmpjTmp0N01vUUh1?=
 =?utf-8?B?bUhWU1QxSndpRkVLcXpFZEVBOU96dlk5YnNock5kM3RlWTNsMmwySGxEVGZu?=
 =?utf-8?B?KzcyNWpaT0J0VGxZM09BaUxKcXdRbzh1em80MHlwdGhad3pXNGZTUGVTYXhz?=
 =?utf-8?B?d0Z3ZEMzOFd1UUVYZ0taditBazlMd1E9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d01a3398-e1d9-4bd2-7eab-08da0cddb228
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 14:59:14.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1024
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022-03-23 3:54 a.m., Krzysztof Kozlowski wrote:
> On 22/03/2022 21:11, Jonathan Bakker wrote:
>> Memory nodes should only have a singular reg property in them, so
>> split the memory nodes such that there is only per node.
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> ---
>>  arch/arm/boot/dts/s5pv210-aquila.dts |  8 ++++++--
>>  arch/arm/boot/dts/s5pv210-aries.dtsi | 14 +++++++++++---
>>  arch/arm/boot/dts/s5pv210-goni.dts   | 14 +++++++++++---
>>  3 files changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
>> index 6423348034b6..6984479ddba3 100644
>> --- a/arch/arm/boot/dts/s5pv210-aquila.dts
>> +++ b/arch/arm/boot/dts/s5pv210-aquila.dts
>> @@ -29,8 +29,12 @@
>>  
>>  	memory@30000000 {
>>  		device_type = "memory";
>> -		reg = <0x30000000 0x05000000
>> -			0x40000000 0x18000000>;
>> +		reg = <0x30000000 0x05000000>;
>> +	};
>> +
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +		reg = <0x40000000 0x18000000>;
>>  	};
>>  
>>  	pmic_ap_clk: clock-0 {
>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> index 160f8cd9a68d..70ff56daf4cb 100644
>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> @@ -24,9 +24,17 @@
>>  
>>  	memory@30000000 {
>>  		device_type = "memory";
>> -		reg = <0x30000000 0x05000000
>> -			0x40000000 0x10000000
>> -			0x50000000 0x08000000>;
> 
> 0x40000000 to 0x58000000 is continues, so I wonder why it is split? Look
> at Aquila DTS.
> 
> 

Yes, it was split in the vendor kernel as well [1], and that's been continued along
here.  I personally don't see a reason to keep it split, but there might be something
I'm not aware of.

Thanks,
Jonathan

[1] https://github.com/xc-racer99/blastoff_kernel_samsung_galaxys4g/blob/gingerbread/arch/arm/mach-s5pv210/mach-herring.c#L4116

> 
> Best regards,
> Krzysztof
> 
