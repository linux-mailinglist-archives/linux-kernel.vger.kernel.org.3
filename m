Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310CC497DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiAXLRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:17:10 -0500
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:45376
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237250AbiAXLRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:17:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LijJlEha4xNDX1HKPPQiI12BiniEXgF+kouhhZIKSgmjcfoFy/D3ahync9RuEE/C08FHzJompR41oYKQzF6q8I6K/+V2vB+cwizX0v3zZNsA10aIe5orCAVVFJgWXpup0QIEDVUKtfjphkvNaE7LzJn6bOousRS/5bYiPWM9cLFFVH/jY7y5R3MPxoSR8re7NeqRbdvEEhK9CN2eS4Nslu0dt4z/N7y0Rap+tfG1HbgM64RWT3oaLlWEfEG+klhEGe20bY+9CJgiWxkUJUOLSLdubturefyfoMNc3y6p8rmU9E7wOc/2RelhI44bWyljwCAInWPdkMH9+PKkTOwehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvWAJuXM7IpvxTLBTSANOqhWOHR50hxLyE5bJzHV6ek=;
 b=AVb+mMyD+Fwl1ZhS2nC4UA9slqeJYrQgWPWl7OgTAgHFWFq3EBcIENu5nUKIQAPbsn93QaA5U8aCIVVUS+2zxpjPeM2K5jfWG2Wi/C0d6NZ156LM2uSKkpacXLi++8ZS3Q5WAZOA2ghpWc+ONaV0blJzmGZ37hcVstlIFB05mBk/UeOL0TWs4RblDwsrXRU1kVmD+AadIItm+dpg64PYZowbY59/KB9lB3nUlYtpKuBSIv7VpnL9YM/hNpaO0vzo3+HPVokE4ucNRkkGQos5d+nszkQ3uGRfWQuhCm2leFW7vMyikmKz+vYSaqAL5aKfQFrzOCrDfSxNozN7KTE6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvWAJuXM7IpvxTLBTSANOqhWOHR50hxLyE5bJzHV6ek=;
 b=kALyV/M/pbLKBPPtxjQiCbsGmr8/3qPepE+u/50gpnEBXnQ2OUmKG1nINc8bAFIke64fkHIQQmVfWADdM1R/IQJ7VNvGJbZVdg74+IjI70w+QmFiugovV5CqesRqIc1CjZsv0GlUI/aC4FraD8I/FIDI+t/tYQV/66G6AdjSwCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM0PR04MB5697.eurprd04.prod.outlook.com (2603:10a6:208:128::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 11:17:02 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93%8]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 11:17:02 +0000
Message-ID: <fea9a91c-ccaa-15be-229e-60f78209cdce@theobroma-systems.com>
Date:   Mon, 24 Jan 2022 12:17:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: rockchip: fix rk3399-puma eMMC HS400 signal
 integrity
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
References: <20220119134948.1444965-1-quentin.schulz@theobroma-systems.com>
 <CAMdYzYr+UXU-x=OakdHnOzLe1e4Y0xdGR-rybsmpLCMGbsWwXg@mail.gmail.com>
 <3e87ed0a-8b79-006a-dce6-62becc9906ef@theobroma-systems.com>
 <CAMdYzYpT8BUrukUozRSQDHgiQHMPbS5GtV7huL4xFFRsdxw0qQ@mail.gmail.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <CAMdYzYpT8BUrukUozRSQDHgiQHMPbS5GtV7huL4xFFRsdxw0qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be117b03-f6b7-4e8c-e210-08d9df2b0bcc
X-MS-TrafficTypeDiagnostic: AM0PR04MB5697:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB569797C5AF142C43E5635511C25E9@AM0PR04MB5697.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lc0NOG2gOpu8kurtlH6hMkrkTsc/MKj9cEgeWFwNozePdefOMoZTzAkTNdzdg4t24ddHk9za0CvRk+sPSwzgjRJbDzmggewUIJptgLW4egz2h/FyPn73lUdJ5DLlvfRllkexdpGyypm+6DIEw6VSr5WJCKVNKWZQYThdlP050GMGHvn2SdoYvzdUQN4ly09K7yuahUGegJjdStajprSSGBwjsuwznuCd9wy94TbgFPTPMEGaRQSvXPtLYz0Iu4vQ3pxRaMwFWVTSGKjxHWNEbiYn88FLAEXBdYZ81o9916sk6lvczUvE/yXwsux2nbURbPew2H8LsVL3pg7V4WckdML2WHVHV+ALLe72FEM+MCvQhT0IJuFcJJ7LfUgVT3n3EpKvtieE/5h4a29IMcz5BfFmy8P8Vu4JpmMc2uEoHl9VO+Eo4BSXnOw+ysCa1iN8kI3DZDEJWIGavecKhiN+CiVux1hdFBJHqXbuLeVLV5X9bH/E6Zu3vo4dKBSoo21xGe2uuK0999nkU7Xwqdyu4J5I4BCrUPkyuEcKZ9jdW5PsJIp8vDIGRIlTb4wPsYFRVGZQvD3CdfbccrpEPxmRFvuldxHoaow1h4lG0ZSYrFwN2miqAYM6EYfVd4TS7DmOWbxoA4554rp/ivUEjPs9YwhGRvciFv3BCTL07yYcdb82LerGWh9W+ZT9aQWpo0thp1rWkstmZYIvrrE+3fVXZG8XM+vTRJPDRRpAFs6nPe6l0oXnOmh3jAWyThUfL7VW9xxyDUlBtTcKO+ugMGIpKMsQj3RkTD8F6JF+19uFbEaJFULjdkkVsIPu5JhaCMTu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(6916009)(2616005)(54906003)(8676002)(44832011)(66556008)(66946007)(5660300002)(4326008)(66476007)(6512007)(38100700002)(86362001)(316002)(6486002)(2906002)(508600001)(186003)(36756003)(966005)(31696002)(6506007)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlVMnhBMlRKMW5RWnJERGVDc2Z0RmN4NS9VNE9lUytKVlR2V2ZFdVBKZ25D?=
 =?utf-8?B?TCtkVUQ1aVpxUWkvSENrNS9zNml6UzE3RTVzcDdRNVVNbHlYcDViZ1gxeEZM?=
 =?utf-8?B?WkhJa3QzbytibEs2ZFAxSE5ZWGg1emFHZFpSNE9KNGRRYXVia2wySHdLWnVE?=
 =?utf-8?B?Z0x0V2g0S0JPRnhQL0pmeUtIeXZqQ0JEVGZuN0VZQTdqWUo3YkdxTVdqaFFD?=
 =?utf-8?B?T1daaWVsMWg2VU5ycU9IN3BvYXhqR1ZHbHFWWHpTN0Jobk1PNExMWVg1eGZt?=
 =?utf-8?B?ZDZVYUw3SHVNRmVqVW5Kd29Fb1k3ZDJYNXU4a2dyUXRrdnV6cm9tVThqR3FF?=
 =?utf-8?B?STh0bVBLcXpUZjZDZzl1aGVyaG1CM2QrZno4K1dKd2xTdXFGTlUySVZyMjhB?=
 =?utf-8?B?TXgzbHpDSWdDUXZmQlJMVXg3SmF2TGJkeEw1dTJ6S3puRHBwL0ptQlVUWnIw?=
 =?utf-8?B?Rm0vcmZKMkRzZXpPRmJyakRWZEthMDdXdTNqY3NFb2V6akZJZGE0V1M2QTkz?=
 =?utf-8?B?Z09SSTdaRG9WVTVDVVFrSlBkdnBSSWh3bmVJYjhEZVQ4UDNLaWd4WWxJYU9N?=
 =?utf-8?B?cmpiNFFCSDJwa3BuZStzcEk3L3Q4RE0wQXRzSDJvNXN4OENESm1BWVl3VE9a?=
 =?utf-8?B?NDdwNkxSWmlIeXBaemhlM2RGMzdLYXU4S2dYMmFKTzVpQTJ1QlVIZ0ZheUEv?=
 =?utf-8?B?S2VVV3JzbHlRdjhteDBvdURaMDdMSjdpRkdySXZ5Vm9WbFFjMTdtdElMUnM3?=
 =?utf-8?B?U2c0eUwzTTBOUzEyTC9SMWt2NE5Yb0dybW1SYS9JL2VBeWhBQWtvR3cvMzQz?=
 =?utf-8?B?Z1lreGNldkFySWZiL0tQUk1VenYrZkdnbGhxRndyUWtubWw1ZENDWmZzaUdT?=
 =?utf-8?B?TGErRXY4LzlHUHZwRWVUN1FReTRieTIyZ1hsbW42T0xqVTBoZktxUWhvY0ZF?=
 =?utf-8?B?NCsvTUhJam5ReEpHTXR4d3dpU3FoNmZoMlFhRnQ4bi84Zko3SzBoRjlGaEIy?=
 =?utf-8?B?aForWTRFS2pqaFY4ZllwVjhlejQvYXRaZ1VzL0NkNTNtbzF3anVaU0s5Sngv?=
 =?utf-8?B?ampKSzlCQi9qbkt1aGNSUFo4cXQrRUhiK25TNTl6SFpSajVXTUlMVy95eWJj?=
 =?utf-8?B?ZWtlZXFydDdWUHVjajJTbjhsN1FTRFhHeTRHKzBCUVB2MnVUanFqek85WEVV?=
 =?utf-8?B?bmtKTHJURlBTQThHYXFZeVdPSk5TQkV3cWxKU1lGYk8vQXlvRE0yOVJkVnVP?=
 =?utf-8?B?c1BrZjZzdWpRaVBiQjk5YnN3WEVaWE1ZaENjOTR1Q01JUlc4Y3B0N2RqbllL?=
 =?utf-8?B?QkJFTVhiVU9QUitMczJueWpHa1hWNjJZRWJVV05nNFhVSVZweE1IemxKZU42?=
 =?utf-8?B?aGxrMUtZMkpJOXlvYnRmdnlWMnhZNzJJYlhzZ1R1R29nTEs3NWd1MjdJdEZ5?=
 =?utf-8?B?WXZkTXZjN0ZlUU9RblhsZ1A1ZVp1dGh4dnNBM1hJNWdNNkpzVjZuSUxSZmdL?=
 =?utf-8?B?VU5UL3NIdFcrcDFCRFpYWjl0SytwZW40NTVSTEZtNXRhU2hJajRZS1RhQ3gr?=
 =?utf-8?B?WDBhSDRTUU9jMDR3S0EzbmtzSDUxZld2L05Id3RSMVgzYUt0eitrbFhqMUxS?=
 =?utf-8?B?OVdDYnpzTFo2Z1F5dS9KTmJOM1ZJdmlKNEd2cXg1ckpKZ1VjY0o5NC84R3hP?=
 =?utf-8?B?NHBPSjVKeEh5T1ZVdFRkL3dPMmw4cEw3Rktpbm5qQStHWHpad0FJNUUwdkU5?=
 =?utf-8?B?alRsdEtWeU42OVFjNEpySzZSZjFHQ2ZoWE1rQ0dNd1dJNkk4SnNIRlkzNXFj?=
 =?utf-8?B?aFFwdTI3dG9KVko3UUxHUVNpVjRoR05VcnMyM0Zmcmp4cVlqUUpHUWpXc2Ez?=
 =?utf-8?B?U2pjcktCTWFweVZwSUJBOU1VVm9SY0tsSVN4WlhFV1k3c3dBMzRzaFdiOEV2?=
 =?utf-8?B?eDVyOStDcjR4SjQzUkh5T2hXZ2ZZbDZDMXRyNnl4R0NjN0xZOE4xS0ZxdCtm?=
 =?utf-8?B?SmdtUmxqSGpMUW0zT09TWWV5dC9WeXJmTWQvMExXMFp0cjltaWVrZVZvMjYx?=
 =?utf-8?B?TUlRWlFIUHRuVnNRaUVMVk82TTdHa01kaWtCWTFGSlFkV3MzTWFwb3NXdURR?=
 =?utf-8?B?QXV5cFpiZUtUdnRjWlYzZWkyK1VuOTJtUmxFQkRJQmZrcjUrd2tTL0owTFFm?=
 =?utf-8?B?WCs3UWJWanN3VFBXL2RhMTdpdnFBRncvc09JNTR4Wk0yTW44cVJzU1BEcjl3?=
 =?utf-8?B?SVBiYjB6SjNHRlhRM1dKdVZoNzZ5OGtJSERqR0Nyd1VlN0hCb1RZV0VmaUJk?=
 =?utf-8?B?TW1IVFBzYXRSaTVHQlNtRXNJZSs5MENPV09FTjNsUU5HTWpZUGhzUjVvaVUw?=
 =?utf-8?Q?vpDR0E6nzk2Sh960=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be117b03-f6b7-4e8c-e210-08d9df2b0bcc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 11:17:02.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfMUFYL3upzuv15QFHZyrfim9R9GBtKppplq3eTv2qsqJwXl22T2+6brb8qu5NRZnGChbtH4gMQl87qYG80nfpHEi5s90ApZAIO+h2uC/NvUZYt1axqJIhy0Vk3ry6yW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5697
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 1/20/22 18:14, Peter Geis wrote:
> On Thu, Jan 20, 2022 at 11:03 AM Quentin Schulz
> <quentin.schulz@theobroma-systems.com> wrote:
>>
>> Hi Peter,
>>
>> On 1/20/22 16:06, Peter Geis wrote:
>>> On Wed, Jan 19, 2022 at 8:52 AM <quentin.schulz@theobroma-systems.com> wrote:
>>>>
>>>> From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
>>>>
>>>> There are signal integrity issues running the eMMC at 200MHz on Puma
>>>> RK3399-Q7.
>>>>
>>>> Similar to the work-around found for RK3399 Gru boards, lowering the
>>>> frequency to 100MHz made the eMMC much more stable, so let's lower the
>>>> frequency to 100MHz.
>>>>
>>>> It might be possible to run at 150MHz as on RK3399 Gru boards but only
>>>> 100MHz was extensively tested.
>>>>
>>>> Cc: Quentin Schulz <foss+kernel@0leil.net>
>>>> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>> ---
>>>>
>>>> Note/RFC: as opposed to gru DTSI, max-frequency is used here instead of
>>>> assigned-clock-rates.
>>>>
>>>> AFAIU, max-frequency applies to the SD bus rate, while
>>>> assigned-clock-rates applies to the clock fed to the SD host controller
>>>> inside the SoC. max-frequency does not interact with the clock subsystem
>>>> AFAICT. assigned-clock-rates sets the clock rate at probe, regardless of
>>>> eMMC tuning.
>>>> Technically, the Arasan SDHC IP supports silicon-hardcoded clock
>>>> multiplier so I think setting assigned-clock-rates as a way of rate
>>>> limiting the eMMC block is incorrect and max-frequency should be used
>>>> instead (as done in this patch). Otherwise the SDHC could still potentially
>>>> derive a 200MHz clock from a lower rate clock thanks to its multiplier.
>>>>
>>>>    arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
>>>> index fb67db4619ea..a6108578aae0 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
>>>> @@ -425,6 +425,12 @@ vcc5v0_host_en: vcc5v0-host-en {
>>>>    };
>>>>
>>>>    &sdhci {
>>>> +       /*
>>>> +        * Signal integrity isn't great at 200MHz but 100MHz has proven stable
>>>> +        * enough.
>>>> +        */
>>>> +       max-frequency = <100000000>;
>>>> +
>>>>           bus-width = <8>;
>>>>           mmc-hs400-1_8v;
>>>>           mmc-hs400-enhanced-strobe;
>>>
>>> I don't have these boards nor the schematics handy for them, but
>>> wouldn't it be better to simply switch to mmc-hs200-1_8v?
>>
>> Thanks for the suggestion, I just tested, by removing mmc-hs400-1_8v;
>> and mmc-hs400-enhanced-strobe; but keeping the clock rate at 200MHz and
>> adding mmc-hs200-1_8v; failed a basic dd test.
> 
> Quite understandable.
> I more meant it may permit you to reach a higher clock rate than
> 100mhz and thus possibly a higher data rate, for example perhaps
> 150mhz would be reachable.
> For example I would do a bandwidth test for hs400-es at 100mhz, then
> test at hs200 and find the maximum stable clock rate.
> If 200mhz is stable enough to probe and /sys/kernel/debug/mmc<x>/ios
> shows you are in 8bit hs200, you can adjust the clock rate through
> /sys/kernel/debug/mmc<x>/clock without needing to reboot.
> It will speed up testing.
> 
> If hs200 permits a higher overall data rate than hs400-es, it would be
> worth making that switch.
> 

Got the HW dept to look into this and they said that since the main 
difference between HS200 and HS400-ES is that for the same clock rate, 
twice the data rate is possible and that the signal integrity issue we 
have is on the clock line, anything that impacts HS400-ES wrt clock rate 
will impact HS200 too. Therefore HS200 should practically be half data 
rate on our board and no improvement should be observed.

Lemme know if there's something we misunderstood or check more thoroughly.

Thanks!
Quentin

> Always,
> Peter
> 
>>
>> Cheers,
>> Quentin
>>
>>> Other rk3399 boards don't have issues with hs200 at full 200mhz, and
>>> as I understand it hs400-es exhibits stability issues on most rk3399
>>> boards.
>>>
>>> Feel free to disregard my comments if you've already tested this.
>>>
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-rockchip mailing list
>>>> Linux-rockchip@lists.infradead.org
>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Drockchip&d=DwIBaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=OTusi9XARCbef1Ba5t1gv4_LqRkOaxFY3UtvYky6NVLpeiziqqmdOJ8-R5WXWFNr&s=xBnqhBu20rxvu_V-5EhXyA_yNxcJpa4Dq6HO2Ow3Gk8&e=
