Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1464E6C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356019AbiCYCZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiCYCZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:25:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2098.outbound.protection.outlook.com [40.92.21.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23706C1FF;
        Thu, 24 Mar 2022 19:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOZRTbIDRhoXCt+XwmNDE/8lVDGW+CIdbEwe0Hm7lOtyxaItA9N7RDXV6AQ+AhKygGd5LY/pze2UPZsfYbiSb7V/Jp4kQOsQc4nI3QjmE6Qcw+QQbbh0fJdpC15d9jLhn439zObIFJF98QX/QbR0jKLn949AjnPeyV3d96DS8XNh+ioSJKmzJG7kUOFfCsOrWSwlKbP9iBxHzTGqUdnc9TvqbjOmEhKAbbHEKUt9j3kiUGNGsDMPEIOf479GL+01MrcYvRn5ZguGzI0/+r7l+b6dq/soyjTQzScyTz9n/NhDTm5mxy6YMn18yI+1FVS44wKlhFl54zg3VYdHBFZDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM2BA1KNZ284jm826Q36hrgubyHLIzmQMZClZBZcyR8=;
 b=bvjrJXQeTUiUtnvEVz1pLvZH4rJ8gNfH7VP1v1xVE8y1PRAlc/y26Wvly/dXHLrlSwpTVJYPWEEx6BPDiyRRLTfsrtYOrF+aiOlGExpf9vahAUEj1VjW4rZbNT3Z0GiQVZvZ17TPkj2i27oBxvQsYnatyuxblawZa9IZxzGXLl2OUi+2YOBEyL0dzusoO4OtPyhw/HlOxwOLKkiRhsJU2ljsaMl70C+Qia1tCf8YX6uy123Kc/69H22JkOAAFd9ruyTUi85i7hbbsqGU61huqr1sVCe745zDh+2QkKEegV9aJaZuIhKTLBeRxKQavh2Gle18j3aizyAI4mkpIFawPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by CH0PR04MB8002.namprd04.prod.outlook.com (2603:10b6:610:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 02:23:37 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 02:23:37 +0000
Subject: Re: [PATCH 7/7] ARM: dts: s5pv210: Add charger support in Aries
To:     Krzysztof Kozlowski <krzk@kernel.org>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
 <CY4PR04MB05671BD0A7FF349E8B04EE84CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <2eee2611-d618-3fe2-4315-c57a26de6b21@kernel.org>
 <CY4PR04MB0567BD17C2EED0CAFA044020CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <c96f889e-cbd0-4221-fcff-ef0cf93236d2@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <CY4PR04MB0567DDA596E9E124C80DBF0DCB1A9@CY4PR04MB0567.namprd04.prod.outlook.com>
Date:   Thu, 24 Mar 2022 19:23:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <c96f889e-cbd0-4221-fcff-ef0cf93236d2@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [sFvN5UMRvW/s8VlRi56DERPc/rSPFt6tuMzKdLx/ARNTxpI+koQIz5CyWYC2UhkA]
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <c4095185-7861-479c-6041-b81d63e58aef@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 926553a0-9239-41e6-16fb-08da0e0677f8
X-MS-TrafficTypeDiagnostic: CH0PR04MB8002:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwS1E8T/lA2yzojDeDl1U2P01hxHLVMiD8fn4LtkyG3hwpu+aMqC8G4ljk7E4T0Nq+8FZnclWd0ha448uoyQ/GN34bKPeTCOqCQBzJqCD5Q7jzKbcgaCdulioK9Q0BeBSlOttIo/lOamsGPkYxR5XCVtqYiqsDIdIbhGQu4pT8lAIUKbL+50ooKVf9W3yLcK7ksGJjQ6sgwAJB8GMY25dhnycVMmEwTzxu3TXLZB+vJc6znwZi8jIFFCVtDtBuySQo2dOeWWEXVZAQMzVcMHX8EhmVTEAsBJY0IqQQAcTagb8Tz1PL45qO4OXFV4yugRjWLDOtDVgM/5Z0nxVHoLaldEuSzWGX73ngUB4gC0hCjaNQ0l3YnipJiwGrfBjZhyKsgeWZBXFj4w9FLPbKmmXdE8bJhezUWBEWEls69KHJ83kkMUqE/BdRyYlUHPEJVLJfqeec9P5FQHBZZC+Tr9GSJTthf02BLPA9Egxl6EXVKgdtuVWoZkgNmd39NbmAzwp5ayI5fSdCq7DeWZFajg3U4944MDzDAe7V0B9+5ytghHVeLT0uXWYp0SbBYwp5Z2FzyOEfM9HnDMwKkMZFs/Ag==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUtWakd4Z0R2NDdybkZPNDU5R3hiMjBTdHV3bDdLNUUvSkdmclRXdTB1WGFI?=
 =?utf-8?B?MzY0bHl5N2NYRjBSejFqS0hLbk5qZDNITEliK0s5N1U0ZHNOVEtGOG9QSDRq?=
 =?utf-8?B?TjIzN0YwR2RmR0h1TVBNemhXN1c5eWEzamhSWTFjR0JURGZSQWhLR25neFVT?=
 =?utf-8?B?RmIwa1IrNS8zWmpKZmtNSDFOQUcrbFVLUjRpTy9OdXFIeEJzK3dKVU0vTnZh?=
 =?utf-8?B?L1lDczh0RzJodHpmTjVJK1VVNFF4cWFjVmdXSXVCU0ZzUitjYk5NV244YzRL?=
 =?utf-8?B?ZEVYeldWcU9McjNBT1B2T09PQlI3OTlNMzhWdkFsRkxBZElXY2w0SUhOVjF6?=
 =?utf-8?B?L3N0V1hWYXpPNlJsd3NpazJCcmJUK2pnSWxVYitGc1FHc0FqZktpY09HQVM0?=
 =?utf-8?B?RXpNQm1wbWNpWHcrTnNKLzU2cFJTSlVlMUdicnJ5aXkzL3BuaHFxL3VvNUFE?=
 =?utf-8?B?SDRXbm55VmZNSGJjbFdFWTc2dll1ZHFXRlFCSGx0QklLdmdJYWpnSkN3UktT?=
 =?utf-8?B?K0NJdUlSekZWU2IwenIwcGttZDBnUisxR3VaMEt3cm8zUWtleCtSVVNCYjd4?=
 =?utf-8?B?cFFFOEN3YndibGJHNXNHYStYZ0NIa2pCZ0VmV0RKMTRGa3cyWWpROU9TUkRC?=
 =?utf-8?B?TEdIM2tyZS93OGdTTWIvbHBRT3l1dm1Vb0toS1Noa0d4ZElrYkM4K01zM0Nq?=
 =?utf-8?B?cncwSk4wNFZ6SHVGTTg3cFdpY1VJWmtDMjBvMkdMMkt4RTVwOTZ2Q1dNRk05?=
 =?utf-8?B?dlRUcjdGSG52ayt4MTJwUkpZeGk0blQzSFZ6VXJ2bnIwM1ZQQ3VkWWc4cEM3?=
 =?utf-8?B?d1FRUWtTS1RYR3MrZVhhSmV4SlkwNE9QbXZSYk5NRS9XaWF4eEtXNlhSdldY?=
 =?utf-8?B?Y1JoRndrWm9udk5rZWNHZis1Q1dlOHk5K1Z0R3cwaUtHZ29nWm0rYlVqVG85?=
 =?utf-8?B?dkp6cmNxcHdqM0cxWWlqRnFPeXZBN1U2UlVmYWZHWWV4Q0tCWHVYdDFaazhR?=
 =?utf-8?B?Ymo5VFdHbTdJUjk5TXJRem5Ua05jOCt0UGRSM1cyRVpkdWpZOXE4WXpHMWlC?=
 =?utf-8?B?SkxLUndid1VPVmR6N1hUcGFpckp6Mi9NNmk5aHFmNFdXMkNyNEhWZ0lDMGlP?=
 =?utf-8?B?WnB5WmwyTktDRG9BWGQxM0d1cCtqVGVlQk5ldWIwOGk4aVc4K0k1V1JMa2R1?=
 =?utf-8?B?Y0xSdDdZUUpTSVJsazdvVFA1NUpMeVdmemgwdC94d1ZUZmoyWGxoZTM0Q2x3?=
 =?utf-8?B?ZVh6VXNYWkl5UEdIdDBIOFdoWlc1Tk1EeGFDZkx2dXNvT0NaQWloMFFPbEtO?=
 =?utf-8?B?b0JQZUhDaURqb1hSSmphOVdxakExQkRZM1h6RVZkVC8wVG54b3FnNjhvMlNQ?=
 =?utf-8?B?azlQU1NzREd5QzgyS210WXo3WDdNNnIzaDFORzg1a0xwR215UHMvOGRWYjZQ?=
 =?utf-8?B?ZG5rYUczdElCZkZ2RWVsK3dKR3lQTXFOWWVtbXZERXoyMHpNN0lHTjNERTds?=
 =?utf-8?B?YS9WNklWN1VwZW9ZZUZTTTEwN0RuMHZjTVZ6NXpzbXE0c0Nmd1RvMmt4aWNk?=
 =?utf-8?B?c2NSK3VsWHg0anE1NmpsdjZpMEYxVVZpWDdOUkRzbkFnTGFncFlDYnlvZVBF?=
 =?utf-8?B?WDRENlZrUU10cE5TWGFybXdnMWg2cVZnK1h3Y0pUNVdEK3hWZldmaUFTSXhS?=
 =?utf-8?B?NkJia0NOMHRjVHdWZUlvbFZnZG1rSGk2bGcyV2NucW9RbFBCdXdmWkNWNndH?=
 =?utf-8?B?UXdmM0ZkNk1FR0tYVHFxMFhsWjNrTElRR3ROTWZSaG5MM0Q0V2YvbFB1YVlo?=
 =?utf-8?B?NDQ3bFkxWXg2N3RKclc1eXRKRlIwRjBNcmpUaW82cVdTRW5QQXRRVTBlZ0Vt?=
 =?utf-8?B?d3VDb1ZxaEg3UDNHZmFOS2pUYTJOZ0dwdGNXcHR4cnNITDZXdFhla1cwSVNY?=
 =?utf-8?B?RmZrZnF1ejNwT2ZBOUlYbDNXM0JRd0lUNHRmazZ4RjdheUdiOTIzV3QweHpw?=
 =?utf-8?Q?LzFYgjUhpcuCbbf+kqMSYq51ycJA2o=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 926553a0-9239-41e6-16fb-08da0e0677f8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 02:23:37.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8002
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

On 2022-03-24 4:47 a.m., Krzysztof Kozlowski wrote:
> On 23/03/2022 18:20, Jonathan Bakker wrote:
>>
>>
>> On 2022-03-23 8:31 a.m., krzk@kernel.org wrote:
>>> On 23/03/2022 16:03, Jonathan Bakker wrote:
>>>> Add charger-manager support to Aries boards to allow safe
>>>> charging of the battery without the need for userspace control.
>>>>
>>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>>> ---
>>>>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 162 ++++++++++++++++++++++
>>>>  arch/arm/boot/dts/s5pv210-galaxys.dts     | 144 +++++++++++++++++++
>>>>  2 files changed, 306 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>>>> index 7427c84f1126..9530231b7a70 100644
>>>> --- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>>>> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>>>> @@ -57,6 +57,168 @@
>>>>  		pinctrl-0 = <&main_micbias_ena>;
>>>>  	};
>>>>  
>>>> +	thermal-zones {
>>>> +		batt_thermal: batt-thermal {
>>>> +			polling-delay-passive = <60000>; /* 60 seconds */
>>>
>>> There is no passive cooling device, so why do you need it?
>>>
>>
>> The charger manager code needs a passive cooling device, so that's
>> why this is present here.
>>
>>>> +			polling-delay = <600000>; /* 600 seconds */
>>>> +
>>>> +			thermal-sensors = <&batt_thermistor>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	batt_thermistor: thermal-sensor-0 {
>>>> +		compatible = "generic-adc-thermal";
>>>> +		#thermal-sensor-cells = <0>;
>>>> +		io-channels = <&adc 6>;
>>>> +		io-channel-names = "sensor-channel";
>>>> +
>>>> +		temperature-lookup-table = <
>>>> +			(-20000) 1859
>>>> +			(-19000) 1846
>>>> +			(-18000) 1832
>>>> +			(-17000) 1818
>>>> +			(-16000) 1804
>>>> +			(-15000) 1790
>>>> +			(-14000) 1773
>>>> +			(-13000) 1756
>>>> +			(-12000) 1739
>>>> +			(-11000) 1722
>>>> +			(-10000) 1705
>>>> +			(-9000) 1691
>>>> +			(-8000) 1677
>>>> +			(-7000) 1663
>>>> +			(-6000) 1649
>>>> +			(-5000) 1635
>>>> +			(-4000) 1550
>>>> +			(-3000) 1510
>>>> +			(-2000) 1500
>>>> +			(-1000) 1490
>>>> +			0 1480
>>>> +			1000 1470
>>>> +			2000 1460
>>>> +			3000 1450
>>>> +			4000 1430
>>>> +			5000 1420
>>>> +			6000 1406
>>>> +			7000 1386
>>>> +			8000 1366
>>>> +			9000 1346
>>>> +			10000 1326
>>>> +			11000 1302
>>>> +			12000 1278
>>>> +			13000 1254
>>>> +			14000 1230
>>>> +			15000 1206
>>>> +			16000 1182
>>>> +			17000 1158
>>>> +			18000 1134
>>>> +			19000 1110
>>>> +			20000 1086
>>>> +			21000 1059
>>>> +			22000 1035
>>>> +			23000 1011
>>>> +			24000 987
>>>> +			25000 963
>>>> +			26000 937
>>>> +			27000 913
>>>> +			28000 889
>>>> +			29000 865
>>>> +			30000 841
>>>> +			31000 816
>>>> +			32000 794
>>>> +			33000 772
>>>> +			34000 750
>>>> +			35000 728
>>>> +			36000 708
>>>> +			37000 690
>>>> +			38000 672
>>>> +			39000 654
>>>> +			40000 636
>>>> +			41000 616
>>>> +			42000 599
>>>> +			43000 580
>>>> +			44000 565
>>>> +			45000 548
>>>> +			46000 529
>>>> +			47000 512
>>>> +			48000 495
>>>> +			49000 478
>>>> +			50000 461
>>>> +			51000 440
>>>> +			52000 431
>>>> +			53000 416
>>>> +			54000 405
>>>> +			55000 396
>>>> +			56000 375
>>>> +			57000 360
>>>> +			58000 347
>>>> +			59000 334
>>>> +			60000 325
>>>> +			61000 311
>>>> +			62000 303
>>>> +			63000 296
>>>> +			64000 290
>>>> +			65000 279
>>>> +			66000 265
>>>> +			67000 254
>>>> +			68000 240
>>>> +			69000 220
>>>> +			70000 206>;
>>>> +	};
>>>> +
>>>> +	charger_manager: charger-manager-0 {
>>>> +		compatible = "charger-manager";
>>>
>>> Sorry, this is not a hardware. It's a hack to configure kernel charging
>>> driver via DT which was made deprecated.
>>
>> Thanks, I missed the deprecation notice in the binding file.
>>
>> What would be the better way of creating a functional charging system?
>> A new device-specific driver?
> 
> I am not sure, but maybe you could use charger-manager, just configure
> it from user-space (or add such features). Better ask power supply
> maintainer. But anyway charger-manager is mostly abandoned. I don't
> think anyone develops it.
> 

Yeah, I made it so that it could be probed a year and a half ago, but
there's been very little use of it - there's no in-tree users of it that
I can tell.

>>  Userspace monitoring of temperature/connected
>> device and extensions to the max8998 driver for enabling/disabling/configuring
>> charging via the power supply subsystem instead of the regulator subsystem?
>> Something else?
> 
> Enabling charging via regulators was done only for some drivers, I think
> for charger-manager. I don't think it is the recommended way now.
> 
> Everything should be controlled rather via power supply from user-space.
> 
> How postmarketos or lineageos are doing it?
> 

It's quite varied, but I can't find any examples of a userspace
daemon watching temperature/connection type, although it should be
fairly simple to implement.  A few examples:

- Maemo Leste uses a plugin to their MCE daemon to shutdown on low battery
- postmarketOS uses whatever is in kernel and whatever the DE provides to shutdown
on low battery
 - It also has a power stats collecting software, IIRC, although this might be DE
specific
- LineageOS/Android has healthd, but this appears to be more for gathering stats

In terms of in-tree examples, there's quite the variety:

- The AB8500 driver (used in some STE phones) is fairly similar situation,
with separate fuelgauge, charger and temperature drivers bound together by
an "algorithm" driver that checks temperatures and what is connected (very
similar to charger-manager, but specific to that HW).
- Nokia N900 has temperature reading integrated, but no shutoff
- Pinephone/Pinetab appears to have separate USB/AC charger drivers and
a battery driver, but no temperature monitoring.

So it rather looks like there's no consensus.  I guess I'll do some more research
and drop this patch for now.

Thanks,
Jonathan

>>
>> The way I understand the charging system, there is
>>
>> - The fuelgauge (max17042)
>> - The max8998 charger portion, including the ability to vary the current
>> - The thermistor for checking battery temperature
>> - The FSA9480 to determine what sort of cable is connected
>>
> 
> Best regards,
> Krzysztof
> 
