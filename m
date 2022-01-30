Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBF4A358D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 10:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354553AbiA3J4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 04:56:19 -0500
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:64542
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239760AbiA3J4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 04:56:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkELyuP4/wcKJyj2eDJG6Qtx1X71Zz2h70AGRGooo1OEK3yKPxSSixooof4/gI6Ugu53nR3LeUd/DmzRK8LFjZVXQ4emjGG1z5jybStvsTeziyVOBAE7OZdV5Q7A4BvC6+BekHPvTi61PbGV5tFtluCSf86FSY4Dq0cVlCMLhTTRzc0h5wIQBEopj8i3eDH64ebIxSesDFPHCi/oypHs8gMkkNLfAMfo0fedUKarxbTrZgfikfuX08FodAk3h9WOoWAkaRdx1HUBSz55A6MsehzlyA1/xgwoDKrdI6MmCGliehZ5PsI0Z3taTILln0Eni4i9rntNV0O5uCnTbIbsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCcGRgG5pkGYsUfYK8GU1z+mM7ORwIOl/GAzMXRAsdY=;
 b=Xeh8Wu9Awiu7Y+mYujDGFeGj6zcRbFgqXe5q0Z2ViPRsJobiJixJwKo/DjG8TTuHcJF1K8fDjP5plOX6IraO7CvEplVK8Qs1dtlGEEch4wIGrop/j2PaeAzkMYj5U/u0qSM7MXC3QpLlj3SZD+VJC9a8oCHrw38NOfowDdw2wZygxMT9XGXKovs+UlpkFHQyW7uTiDAqE9VG8hiJBzWLcaHykC2eNtotNf8t2moqP+wh2/DfGOlwGHSRPc6+SmvEmQTNSeJH36FoJxYp6U9mz1KUKHpT0+GX9KLlFhfNyq6vpyY44b24pbBmj5oKQFoL3JgehBEXdxUrDebsIwbkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCcGRgG5pkGYsUfYK8GU1z+mM7ORwIOl/GAzMXRAsdY=;
 b=X+g2WeXp0k+ocKUI853u4B7VU82EyyC/BiKp9gF4Gyv4mEafBanMp4vxz+fTrQSQBXH9epSH6tnyrMJN03La4ITjPHifnvwAYond5WHQk11Vzkz4+Z5jIFTdUwRlyrPE9Hk/0vQL+/ubj9XhcdvTAsZQzabZ+4I3ffaIi/mQuko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by VE1PR08MB5661.eurprd08.prod.outlook.com (2603:10a6:800:1b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sun, 30 Jan
 2022 09:56:12 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56%3]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 09:56:11 +0000
Message-ID: <d203569c-bae1-c35a-204a-53617170d3b3@wolfvision.net>
Date:   Sun, 30 Jan 2022 10:56:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rename and sort the rk356x usb2
 phy handles
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
References: <20220127190456.2195527-1-michael.riesch@wolfvision.net>
 <FBB7C392-C5E0-4E34-AC17-5323414623F5@gmail.com>
 <64f539b5-30b2-c0b7-17bf-c448b507713e@wolfvision.net>
 <3736463.EBuT6JFcjP@diego>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <3736463.EBuT6JFcjP@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0136.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::15) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c46e7fe6-52ad-48d1-73c5-08d9e3d6bef3
X-MS-TrafficTypeDiagnostic: VE1PR08MB5661:EE_
X-Microsoft-Antispam-PRVS: <VE1PR08MB566185489174AE1892A33AC8F2249@VE1PR08MB5661.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqFRGz56Q12qDLXzNSnOYGbsWd9n9HS5vRXNJfQu4pQNHwHurU7yOaWgT6RPhpbpceSSPN5x+gm6C6VbAYDhNa4W2Xk/WiUMQcIT1rlnIYONhuy4Il1piJ6q/lYt9B//Z7hS8qn+6RdF8FH1aiJYmbyb+l/IOKRfrJETAZRSHe5NZkZr4pQfCJC2J2K2Z/oC2ebiSDdD7Y43On3qpWfAfJCTuPPVz8WwTjipSR4cuSqRWUdUOG4k8GhXKFMCsVc0XgbL/271i+80l/O18MjpGwcrYnKR73O5LPK0htK91k8kVRgegiBqeeMwX7yMJ4xeR5n/h4P37SnuJbzc2Vpf4kEscxwVPDktAyHncRBIfw0OUkm/vIP9ST/K41Axn5qZBOxjSTx4w6lyTenPCxkPHN8ybHRUSs9rtAmDxL9RKS/nKh9NnGJGxJecJGNsz77ZSPWHSMalek4YizGmydQuphn+GqvQ1imakMwCrJR2RY+CvtRdsmdLzBBST6ZTumeigI2c8B+ZLMv2ZUk07cmzhJ9z5VDkkE3dVMtJ7QhtsDWhWsNQ1J5AHPNyJZMe0lxHvE+m3+qUViZCvULFenIP+MgEAH0UDWG1OEbl9bd5Op+M8AvKQxT6U++8H/gyNodeP4VINi2goTzm5xEPSSihXh1ULTD9X2alb1Z2gGzdo7mnK+oFMIwKAcUN7JZFBdKL8U/eokY1w6XHPaqhFtHQkjKQSrak1AQuWaYUv0eulqzV8FypWwyeYwle+yXuxGVx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(8936002)(66556008)(66476007)(86362001)(4326008)(8676002)(66946007)(38100700002)(53546011)(52116002)(7416002)(6512007)(5660300002)(6506007)(508600001)(6666004)(6486002)(54906003)(316002)(83380400001)(2616005)(2906002)(44832011)(186003)(110136005)(36756003)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpIWmFUeXhwTnQ5TWVreDJwTUUyV3E5K3dveTNqR0gwQXlsUU5KSXpNbXZG?=
 =?utf-8?B?b2JEeE9uWWp3YUc4WTM3eVdIbDVhak5LQ0QxcGFzbXVteTJZUnBkNjM4QTlW?=
 =?utf-8?B?cnZudUJJblJMS0crcE8zY000eld5aU9KVWlNY0ZySlNoTmhZSzdIbThTQUp2?=
 =?utf-8?B?enVEeTJlUFlkOWZzRGZMeGUraUpJTG5BQll2S1preUkwdzZJNUlMUXZDbTZD?=
 =?utf-8?B?SE1sU0FpbnJSUjNOZG5pb2NiSmxjQzlJN1FTN3F3dXlKNTFZVjdFWmlNWVFx?=
 =?utf-8?B?Ykl4N2E2TVhyYk1Hd3lwU3l2elZOVzNxZ2JGeUlmYmFyd3RkZUNjeUVVT3JB?=
 =?utf-8?B?T00yS0NTd3VNS2ZjYXBrbC9YRHpDcjY3Q09PbXkxYS9yNElzYzRSNXhndThs?=
 =?utf-8?B?WmlBTGw5Nitwb1ZraVBOTGNtL3hmTDE1QmZqZDFBa0tydTIwbGVWbFMxSzNM?=
 =?utf-8?B?aGtGYVl1bFUySkVQbGxpQW9MSHNXeU5UZmpId3RwQm9IRTdFV2pQU2RJWmF0?=
 =?utf-8?B?UGY0QVh1dE52eTJTOHBOZDNHSWd1SWQ0SkJ1Vjg1QTRJM3kzN3d3UEs4MWRr?=
 =?utf-8?B?WGlVN3lTYm9KclNRcUZ3ajIvMHBHUnc4RVg0bHZaMmhtZ01rai9aWlR3d0RO?=
 =?utf-8?B?NXNvWkwwVkd1VVVhTk1hY25senh1czFZVHBGMWFlUFo0Y0RZWjJhRTBZRWtO?=
 =?utf-8?B?QlRKR3ZYTHhDVlJJekpoV2UvVTBMTDFLbmhHUXB4Lzc0UWxLVGNkTUliTnZh?=
 =?utf-8?B?Q1NvOVJmMjBuTjNwTzRPcmV1MEx6cERzOURDRzF4elB6NkhtM0M4cjFnU0E0?=
 =?utf-8?B?YTgrY0NPVmd0NHVObzdhbmVtQjNMbUlMSmFwWTRNSjB2SFBlWStGZGhkZzFt?=
 =?utf-8?B?Qk0rU2c4Y1B2bnhwVWlQalJkNWRQSmNlakp3YzRob0JoNTVPMEI0d2s0QTY3?=
 =?utf-8?B?T09CbDBvUzlQcEpIaWJmWis0NW1SbzVuUW1Mbk5ZbnVtZ21kSytKOVJ1WDJO?=
 =?utf-8?B?WXF2OCtlYjNCMnpnNktmeGdOVzNuRFFNSmV0RU84ZlZHMmEvbG5hSlBtalQ0?=
 =?utf-8?B?ZkgvcFRYbnBxZVRGV3pEQTVsRHhxdG5kcHR4QmROYlRFRkUxTitpaUxVYmxS?=
 =?utf-8?B?eS93OFJYTUdJVjA4WEs0NVZyb092dE9TNE4xRTRKNGJNeDVoek8yMmI4MFE2?=
 =?utf-8?B?bXo4N3htSjAyV20xaTMrbzdrTGRCK0ErODcvQThkVE0xY1kvd2V5R2cyUTFo?=
 =?utf-8?B?TzhDMHcvbUJMMkQ3SS8wOTB1eGUraEZlWXNHWUZUSThBdmNVbjcvQnNLQThL?=
 =?utf-8?B?c0JsRHZQbXJJSEJaZjQrYUxac3BENVhFdTVzK3ZjU3Y2b1g5RCs3eWtkNjN0?=
 =?utf-8?B?N3V1NXp5VWVzSWhTTjFta0ZaRjdZUVl3dnpDSHpVKzFBSWpqR1NqWHFhVnRq?=
 =?utf-8?B?aHBtK2k1aHFFRjRGM0dGMlZEVUxEd3FhdXFaY3JjNndwRHhWdmtzYUUzZzZ5?=
 =?utf-8?B?RG9lMyszQk52SGZ5Y3Q3eEMxZ2NjZU8wWlZ0a3p2SHo4RUdINXlIOHVGTFpq?=
 =?utf-8?B?N1BoMmRkVm1uRmErTEt5enNHUzg0YUYwZm4yK3V1RStSWFpUR2hBcm56QWZv?=
 =?utf-8?B?M2ZSdWxSaFlBKzBPcUVBRVJiWVgrbi8xYWJhNkJPeEYvdzRDM1JSY05zYzZi?=
 =?utf-8?B?VUV6d1c3anBTZ3VGWEhlR2VYL0FvRW83OU56SXhsZXRpa3dOaXM1Tyt5ZzV1?=
 =?utf-8?B?Y2IyeGs4WFBDWm84WWc4Ui9ON212VktZbmZYOTZyOW9IcmpvVDRBWFFMbFVm?=
 =?utf-8?B?WUFaVzBodlJsOXYrRGJqeUluOEo3L3pIMG02TnV2QVNrT2JWNSt1OFhKT1Vu?=
 =?utf-8?B?cW5JdDRxVTNvU2V5dUVySWdKWEQ0TFJwb1VxMmxXK2I2RlZrZ2tUYU5QTUhW?=
 =?utf-8?B?a3JtaWhRYnRZYVhKZ2Mwa2VYYndCZnFlT095dXRxanM5SmJybTg0YVRuODky?=
 =?utf-8?B?K3REMDdnUFpzckhsS2hObDl3UzBhSldGRk4vS2w1VitJU3BPNWpuRjFvalF4?=
 =?utf-8?B?Ky91TUt3OVNMaW1sQVlEdHVaaXRNUTlCY1dVdGh1OHk5bTBXc3dEcit6dWpX?=
 =?utf-8?B?UDVZb2FVWTJobFYrT3BjWmMvcW95U2RqQnR4M3h2WVJnVjBKckg4dWxCRk84?=
 =?utf-8?B?cVFERTZFMUhzQjh5cE5jbjZtNUlQVTRjUlV6RWxLZVAwWVVHWXhteXZwWkpG?=
 =?utf-8?B?WnRMeXZUd0RtSjhKcXdFamt6aFByWG4rVlh4RW50WTFpWVkrcTFMdUYyV3M3?=
 =?utf-8?B?SXZiS0Q2OW1sRFZaV1UvQXpLMjFjR1BKazNyWE1BV3E0RnpKcW0rdWtsRzVG?=
 =?utf-8?Q?6VSzo/H3zpcbKn7s=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c46e7fe6-52ad-48d1-73c5-08d9e3d6bef3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 09:56:11.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFFbtriAQeaAS4NGEhZj3oemPkb/mFaEIIa9CvOXtsdt1P7qwhDqKTlfS4gfzz2KL61OyJkiTf2QUqU8sw+Q1OAcBex8TSYBKBVwEYvhbG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5661
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 1/29/22 16:28, Heiko Stübner wrote:
> Am Samstag, 29. Januar 2022, 10:59:32 CET schrieb Michael Riesch:
>> Hello Peter and Piotr,
>>
>> On 1/29/22 10:23, Piotr Oniszczuk wrote:
>>>
>>>
>>>>
>>>> Good Evening,
>>>>
>>>> While I'm not against this idea, my main concern still stands.
>>>> I spent a great deal of thought on this, and decided to go the route I
>>>> did to maintain consistency with previous generations.
>>>> As such, I see one of three paths here:
>>>> - Pull this patch only and depart rk356x from previous SoCs.
>>>> - Do the same for previous SoCs to maintain consistency.
>>>> - Drop this patch to maintain consistency with previous SoCs.
>>>>
>>>> I ask that others weigh in here, as offline discussion has produced
>>>> mixed results already.
>>>
>>> just pure user perspective
>>>
>>> (who spent last weeks considerable time to develop DT for rk3566 tvbox. 99% of my work was by reading/learning from other boards existing DT's. Any inconsistencies in DTs makes work for such ppl like me much more harder):
>>>
>>> For option 1 - i don't see value
>>> For option 2 - what is reward for extra work needs to be done on all other SoCs?
>>>
>>> so option 3 seems to be natural choice...
>>>
>>> in other words:
>>>
>>> for me:
>>> option 1 brings practically zero value + increased inconsistency.
>>> option 2: extra work - but consistency is like in option 3 (so where is value?)
>>>
>>> so option 3 offers the same consistency - but without extra work...
>>>  
>>> just my 0.02$
>>
>> Of course this change is purely cosmetic and it is reasonable to ask for
>> the practical value. It is just that technically the quartz64 dts is not
>> sorted alphabetically at the moment. The u2phy* nodes should be but
>> before the uart* nodes to follow the convention. On the other hand, it
>> may be nice to have the usb2 phys and controllers grouped in the dts.
>> The proposed renaming would allow all the mentioned nodes sorted
>> alphabetically and grouped logically.
>>
>> Therefore I had option 1 in mind. I don't see any dependencies between
>> the different SoCs and think we can make a fresh start here.
> 
> correct :-) .
> 
> I do see each SoC individually and while I try to have people follow some
> styling guidelines everywhere (ordering of properties, ordering of nodes)
> I don't really want people to fear what some other SoC has done before.
> 
> But even these rules evolve sometimes, when something seems to work
> better than before.
> 
> We have nowadays 9 years of Rockchip SoC history in the kernel.
> Thanks to general dt-binding conventions most nodes have specific
> names anyway (mmc@... etc), but for example trying to rename stuff
> in older SoCs that has worked for years now is for one error-prone
> as Michael pointed out, but also introduces unnecessary churn,
> when these old SoCs (thinking of rk3188, rk3288 and friends but also things
> like the rk3368) are essentially "finished" and most likely won't see that
> much additional support for stuff added.

So... may I take it that you are going to apply the patches in this series?

Or should I switch to option 3 and re-submit?

Thanks and best regards,
Michael

> 
> 
> Heiko
> 
> 
>> Option 2 is not really feasible, we would almost definitely break
>> something existent.
>>
>> Option 3 is feasible, of course. However, I would sort the nodes
>> alphabetically (u2phy*, then uart*, then usb*). Works for me as well,
>> although it is not that nice IMHO.
>>
>> Since many boards with the RK3566 and RK3568 will pop up in near future
>> we should do the change right now (if we want to do it), as of course
>> all the board files need to be changed. Therefore I wanted to bring this
>> matter up now. Let's agree on something and move on.
>>
>> Best regards,
>> Michael
>>
> 
> 
> 
> 
