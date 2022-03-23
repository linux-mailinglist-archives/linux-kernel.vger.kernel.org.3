Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77A4E5752
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbiCWRVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245751AbiCWRVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:21:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2058.outbound.protection.outlook.com [40.92.18.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3518957480;
        Wed, 23 Mar 2022 10:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfwN0B1ttD7fvMCD5pBt4oap3I08G9IPR6siQ7pS8hlUA3+a5s4t9HMm2BJimbOA8CziHyGAOIQmcXYXZxjLahfXMEMKfehfsA2SnlQr4HZAG9Ueq+ppqllgZ42RLY0YGi54M+3yzXgd6b35/kVypkWlsiI0wXvpKJ//WpiqN2MJdDUdMHhHGUq3wrrWFFu/gbfQUeEZiruxUyO7h0vczO6/xqAfoOYGZ6Fy9PgCYu+7jg2X0IpGCBKO7kfUnNv03S0TOq99k8MkuV0IVE2rHgvDb4aExEkdkX12ZBOzyA9oEXa2fcHypFJ6hCK7f0HK43Gko3VHjLFckClV/yICFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlOwU52bR1E3harLTsJqgJN5eSJuQRgLQsGkvDW3W9I=;
 b=GEbaQwxLmd86yLgBwco1fCzJxePl7q4t33PKSXKQ+QM9MHb5YUIjiAOhVnLuqI6JCUIIRqhcUKY34iBBpSIyHEIKP7wgpT2pYB8Xcuzif5wZq9sD55nva5l2+COIlLoZJFiA0Fo+6OCNXGwH1R/bBOJdKnwxx1+BmlUxM5GulpU1yySKB2ZqKbX7YYYOkwccIBVyBfxzy8GHi7QaZ9JNiRj+nnsRf8bqQDjqA59oIKLNwQk6kSYjLmMj8bUrRbkOGdlA/m1qKSwa0j66ycoUIAUFoyecA0cJdEr7p2WuZhZx45W86d1MzSGRmXk64u5+aku5fs/j5sciqpY28b1duw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by SN6PR04MB4093.namprd04.prod.outlook.com (2603:10b6:805:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Wed, 23 Mar
 2022 17:20:05 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 17:20:05 +0000
Subject: Re: [PATCH 7/7] ARM: dts: s5pv210: Add charger support in Aries
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
 <CY4PR04MB05671BD0A7FF349E8B04EE84CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <2eee2611-d618-3fe2-4315-c57a26de6b21@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <CY4PR04MB0567BD17C2EED0CAFA044020CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Date:   Wed, 23 Mar 2022 10:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <2eee2611-d618-3fe2-4315-c57a26de6b21@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [0EoKiigWJCbzhKDgkuY3m/Yw54RP+hvIX5QsWm7Syvn/FqhEWjtZbNSzvhk1qRRv]
X-ClientProxiedBy: MWHPR15CA0070.namprd15.prod.outlook.com
 (2603:10b6:301:4c::32) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <095bc640-a2ca-624f-5b99-fcbe5fba34b0@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4141611-a3d2-4c02-124d-08da0cf15f76
X-MS-TrafficTypeDiagnostic: SN6PR04MB4093:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b833GHcKzHhuhBal5OodDtlw9KIB+zyzfpOob8O6h9cOnq6gXVC1XWUH3hq2Ca6HRe+27S39F+CEDVhPcdca7tUCkzHyvmOWIxXRTPmmS79ShdbUjUmp11zl0HVC+YFd/ZIoZyrD4oJkDRe7ZQip+7aMxHKfttrSbYGngVijYIjwHFr9wj1jqeU6tegcHTxHe4hLiUGqI4pZClTQWfCTa/k/pGMSRet9Xu6j7nNKlzKddAKiw8msC+UfwnGIIELyyS2Ui1MD12LAtVliY0zTRnJYe2huH8WqFhtTl0oKYebqlgadyx/VHgo/6lb8irSfhYTL2q9BKvn/k0//6JK1OuiUTXv3f416BhyZtyluhPb2kZkw7u//+EHgF2LfJHW1CUpG+k/6kmFC7jrl5AWJGfX6PKGpjogRZairhMFi3s4sGGWsRzYOZ2gHKsFtAOM5sqrp91gmDzYVNLxqF8iHAi80SjFHYnPFKxc3AhlI6fKDTYyFBYHcZh/KcxGhV92gYLDnRyh1P5RxvR95fgQui42DV1A/GMDoj3WtKh9LI8JlaSA6twjzUFEBzTy5QqiFJDHQkqJK+KCa50ZBnWd/iw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTIyUVpPdzB5THZXL0hvdE5DKytEMDlqNllucDk4cWdSZW1ubmw1TTNtMGMx?=
 =?utf-8?B?WS9hMU1vdU0zZXJ3TlpIa2twWnNMUy9jN2VVZWF2SXpYOEQyR3NnOUNHN28w?=
 =?utf-8?B?RWRKRDdvQ1U5akpsUXFmVTF2MUZLMm9kMFZ1YVF1M3MwcEhZY1JTaHpHWXFr?=
 =?utf-8?B?UjVLK0tZS0xBWUxDV1ZNck1WQnQwcHF3WS9rUkNZSXlDYm5mek9TM0VETS80?=
 =?utf-8?B?U25hUjZLb0x6dUVPcTJucVlTWHhrSHFqV3hxTytmTlRuY25lNkdmZFViODNu?=
 =?utf-8?B?ZHNqSnQzSXp4a2gvNzJ0R2o3c1FET09SUmNaNjJOMUdYeThYcTlPdFFaL3NI?=
 =?utf-8?B?eTZXYVR5cnNHQVAxb29HVmd2UHRTSnphMGFsNnF2QU1pL0RVam81eHZLVkhQ?=
 =?utf-8?B?SU5Kb0o5SVJHTWV1cFVYd25UM2xRVzlDdlFvSENhbHhaRFd6Wnlta1VQbm1t?=
 =?utf-8?B?aWdKVk0vZUdWU2Fod2g5OEJ2bWE5RHFJS3BWQzdEWnY5K2N5SDhIQ1FnMHBx?=
 =?utf-8?B?UksxWEtlSzZabzZuSExVRkF5a3gzTE9VY3NxS29GQ1JidHArK1ZIa2pUYzB3?=
 =?utf-8?B?VG8vM083Z0tQLzFEYjJIdFArL01wd2crd1UzTGhjR3pIb0RHTG55czh4alF4?=
 =?utf-8?B?M2pKSG5lNko3cGp0ZEZyTDdSa3FBbzhPeTA5MlJCL2VlWXZTanVKMmZsQWM0?=
 =?utf-8?B?SElOSHEwS01JSVlYUWV2VjlnWS9jZ3JzWVA1T3d3Q0JZeUNFdk1hOFVOaGNX?=
 =?utf-8?B?TENrVkUzdloxd3ZZSEd2aGdPNzZUeGJJZmNXM2JieCtsbkYyb3ZnbS8rTWlQ?=
 =?utf-8?B?U1Y0cnlvcTVJaERCcURqU1BwalErNllBb0NhelBNNksrN2syVG1lQ0N4a2ps?=
 =?utf-8?B?VERmcUtxUTJQV2hLb0xHbXJ1TTE5dzJHNTVNd0M0bHh6U3ZObnJQRmRUbURT?=
 =?utf-8?B?OURwS2dVeWdTSEp5S1E0RVRYQnlZNmxNeXNYTkxmUk5aM2pUVDNYb0luYzBD?=
 =?utf-8?B?N3J0bXp5YmVZSjNFZ0IybDRhVE5hZUxLTlRBTkdYWGxhQ3dieVArSGNiRll4?=
 =?utf-8?B?MnZYSENvOVQ4bzZyT2dsMkZ2OENKYkk3R01VWjQxS25TZm0xeWtVTnNOaG5Y?=
 =?utf-8?B?RHhabTBHR1UrcWMzbTVsVUhucTJROXNEbzhLZXZsNndjaE9RdFpWTmFmOFNJ?=
 =?utf-8?B?WHRMdVg2M3laRTVpdEROVzZCUXU3dVZTTUlXVnJ1VUxFREUxTCtvRjJnd3hB?=
 =?utf-8?B?NG5EODllVVdOdzVqN3F2V2U0Mmp3bXlmZGRkbC9UUnVyTGxGanNrYzB5b2lt?=
 =?utf-8?B?blRwTnpOL3BPWGtxcXpEY3NxMENxREZ5Q1N5R040U21wT2xLRVMvSmE1UE9X?=
 =?utf-8?B?NVorb3pubVVoekJQQkQ1T2xsbHE5ZEtiYXh5RDY2ekE4YUhzU3VJSS94dEJN?=
 =?utf-8?B?dU5wUndnWVQ2dnFETlZ2Z1p6MlZlZGNGN3dBVUQrSS9RZTl2S0JIa1BPOVBN?=
 =?utf-8?B?VjN2amUzTkNzTXJYRHRwYmYxanBudkpRRTA3aTdaNlJ0aVZvU3RRaXNqeWJm?=
 =?utf-8?B?RTNOZkpINjNEd3ZFVjNGMDNIbEEwNFFuVEtGMHA3NVU2eDlwSVJhSFY2TjVK?=
 =?utf-8?B?V3lmaTZFRmNWcTc2M3hkK1pIbldZeHc9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b4141611-a3d2-4c02-124d-08da0cf15f76
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 17:20:05.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4093
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-03-23 8:31 a.m., krzk@kernel.org wrote:
> On 23/03/2022 16:03, Jonathan Bakker wrote:
>> Add charger-manager support to Aries boards to allow safe
>> charging of the battery without the need for userspace control.
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> ---
>>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 162 ++++++++++++++++++++++
>>  arch/arm/boot/dts/s5pv210-galaxys.dts     | 144 +++++++++++++++++++
>>  2 files changed, 306 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>> index 7427c84f1126..9530231b7a70 100644
>> --- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>> @@ -57,6 +57,168 @@
>>  		pinctrl-0 = <&main_micbias_ena>;
>>  	};
>>  
>> +	thermal-zones {
>> +		batt_thermal: batt-thermal {
>> +			polling-delay-passive = <60000>; /* 60 seconds */
> 
> There is no passive cooling device, so why do you need it?
> 

The charger manager code needs a passive cooling device, so that's
why this is present here.

>> +			polling-delay = <600000>; /* 600 seconds */
>> +
>> +			thermal-sensors = <&batt_thermistor>;
>> +		};
>> +	};
>> +
>> +	batt_thermistor: thermal-sensor-0 {
>> +		compatible = "generic-adc-thermal";
>> +		#thermal-sensor-cells = <0>;
>> +		io-channels = <&adc 6>;
>> +		io-channel-names = "sensor-channel";
>> +
>> +		temperature-lookup-table = <
>> +			(-20000) 1859
>> +			(-19000) 1846
>> +			(-18000) 1832
>> +			(-17000) 1818
>> +			(-16000) 1804
>> +			(-15000) 1790
>> +			(-14000) 1773
>> +			(-13000) 1756
>> +			(-12000) 1739
>> +			(-11000) 1722
>> +			(-10000) 1705
>> +			(-9000) 1691
>> +			(-8000) 1677
>> +			(-7000) 1663
>> +			(-6000) 1649
>> +			(-5000) 1635
>> +			(-4000) 1550
>> +			(-3000) 1510
>> +			(-2000) 1500
>> +			(-1000) 1490
>> +			0 1480
>> +			1000 1470
>> +			2000 1460
>> +			3000 1450
>> +			4000 1430
>> +			5000 1420
>> +			6000 1406
>> +			7000 1386
>> +			8000 1366
>> +			9000 1346
>> +			10000 1326
>> +			11000 1302
>> +			12000 1278
>> +			13000 1254
>> +			14000 1230
>> +			15000 1206
>> +			16000 1182
>> +			17000 1158
>> +			18000 1134
>> +			19000 1110
>> +			20000 1086
>> +			21000 1059
>> +			22000 1035
>> +			23000 1011
>> +			24000 987
>> +			25000 963
>> +			26000 937
>> +			27000 913
>> +			28000 889
>> +			29000 865
>> +			30000 841
>> +			31000 816
>> +			32000 794
>> +			33000 772
>> +			34000 750
>> +			35000 728
>> +			36000 708
>> +			37000 690
>> +			38000 672
>> +			39000 654
>> +			40000 636
>> +			41000 616
>> +			42000 599
>> +			43000 580
>> +			44000 565
>> +			45000 548
>> +			46000 529
>> +			47000 512
>> +			48000 495
>> +			49000 478
>> +			50000 461
>> +			51000 440
>> +			52000 431
>> +			53000 416
>> +			54000 405
>> +			55000 396
>> +			56000 375
>> +			57000 360
>> +			58000 347
>> +			59000 334
>> +			60000 325
>> +			61000 311
>> +			62000 303
>> +			63000 296
>> +			64000 290
>> +			65000 279
>> +			66000 265
>> +			67000 254
>> +			68000 240
>> +			69000 220
>> +			70000 206>;
>> +	};
>> +
>> +	charger_manager: charger-manager-0 {
>> +		compatible = "charger-manager";
> 
> Sorry, this is not a hardware. It's a hack to configure kernel charging
> driver via DT which was made deprecated.

Thanks, I missed the deprecation notice in the binding file.

What would be the better way of creating a functional charging system?
A new device-specific driver?  Userspace monitoring of temperature/connected
device and extensions to the max8998 driver for enabling/disabling/configuring
charging via the power supply subsystem instead of the regulator subsystem?
Something else?

The way I understand the charging system, there is

- The fuelgauge (max17042)
- The max8998 charger portion, including the ability to vary the current
- The thermistor for checking battery temperature
- The FSA9480 to determine what sort of cable is connected

Thanks,
Jonathan

> 
> Best regards,
> Krzysztof
> 
