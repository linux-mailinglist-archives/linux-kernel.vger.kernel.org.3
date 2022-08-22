Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A2D59B9E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiHVHBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiHVHBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:01:17 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50081.outbound.protection.outlook.com [40.107.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1661D0D6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adNffGdR9T+t1s6hI7F4UUXSCpqK3ighns2PDMDUDRA9PKFdkjWXuTZTPBs0xp7NT4fJ3Sdb63uODCgMKOK18c1Q07N4T0IqpA2cRJ+xNHv+YKVWn1nvtoDyBzrYAZS3nw5S7z1AFGKgA8dlI1NzO3cA4NS3kZmTFwCF0ukZ6L8ro5kakhhZrG6LcvO+ZYrSRmffPXE10uxN5bT/KEDdRZbpTbve+C4ghMMdMfVxQDK+qd7Y2No+qAqgIyXsWJ+aLEareiguSuBB8buwHnb8T5asktBiuPNSV71HEHHo25Mx2XzVgkijqnawPNqehJPSTWqaQe2S3J2GDVdUPbzOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPeT8e98DfRTdIfBBNbnf4PaBOqDg225VQdoaXnMqfE=;
 b=LPKEaEZ5TNU0ADnC1/fc2t28U2e3PIfq6XxixpvClZrEDoO6grmeNc3hHcPh2uIPLCHnB3j+TUAhVs6KASWBX8ZdHlNT0gHxp7P15K0liT+53fybtSIaUaq6yja1Y70iYS4GrSr2dWwMpCaSLfA1rfYVfNFxwo8C6E1ANSBNx7JHhqv96a5Y5CYlTf/H29BzbE8tfiYwAFIXAleEauE1pKrkg6eLOkOP1c00hQj59Q35fhkod6QEAIgKTXJacLP63WozjErX1J8PbSsAUuaqfujIiT6hJtysJcneawdFefqqorPwy7I2Iay2p1A8O1+2Swd4m8dtPF4uHXPv3mTanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPeT8e98DfRTdIfBBNbnf4PaBOqDg225VQdoaXnMqfE=;
 b=LvH+aHTs0er6Ak3Oo3PLAAVwzaTdivjJlZoo7KW08M455l96neStWwnkIRrD8Su8gfPaR2JozYpUp50H/XyTaHogn/CV5DxfhZJqjGc1wgKj3+tVQTceT3QkDPVzNNawJSopnb+JU3LNKx+k/j+WdhROqleRYmllsHaNM0enneo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 07:01:11 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::2c84:f6b5:8727:b073]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::2c84:f6b5:8727:b073%11]) with mapi id 15.20.5546.022; Mon, 22 Aug
 2022 07:01:11 +0000
Message-ID: <16c7d279-9b31-f459-0472-8846cf45a653@wolfvision.net>
Date:   Mon, 22 Aug 2022 09:01:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG BISECT] phy: rockchip-inno-usb2: Sync initial otg state
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220622003140.30365-1-pgwipeout@gmail.com>
 <88f2de00-32e3-ed74-082f-c0972a81f0f8@fivetechno.de>
 <CAMdYzYoTLjRW1FgwfizUu-+k0R4tCO78qYa7MEpgfz99aj3SvQ@mail.gmail.com>
 <ec3d2515-b2a2-8441-2e9a-a7fe664e048a@wolfvision.net>
 <CAMdYzYo1nm76ti3PCYk4DYtEnjWD731bybHaQV3ODBZi4SMvRg@mail.gmail.com>
 <88e9c256-b930-d26d-63b4-9d0f132ae962@wolfvision.net>
 <3dd1a585-cf7e-033b-6c9b-f58dc43de6cb@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <3dd1a585-cf7e-033b-6c9b-f58dc43de6cb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0088.eurprd09.prod.outlook.com
 (2603:10a6:802:29::32) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb8db388-afc1-4ab3-c7b9-08da840c1856
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quaMWbekdyXAfiO+xBidn89Y6xvBf76Vc/b0ezqdbIm4rv4DbjpyPybtbiJxV9gvYCF3xCEFmxAEg9qV8mqVLFlsjXfkQ+JIX15e+bTK75klcEx8k3TRtG7pQQ5Xe7JpOHQ9Hc01RKt1Tuoe/n1xY3y8Y85FMWI6NeaIXCEe4DSFxKlKpa+hxixYE0/ztiK8nEjAqkFooEji3XELAS7uI8Smk0avLwea89DkPWIeS5JjIIf2ZlzHdyJo5zQo471KqDGoi3AjT6NKFzWW6UgjKUJrLcMXgBqEQuO0U0cSwbrXi8Q7ddRf7ws5WLP1U0g3xIql4R/U7XKvtW865yI/4V2jeGs8X+naBC1uN1x+M0jiM8AFT9rWSdFtjlUSkKJB8p5MSouBA+RY9lQk/w4FQMPaZIETLTatGxDrHA6xHHosD0vgVhtNfSWYalGDJA73jo6WNykV2Xa0XOpas0UItwjIG6s7CdCP262AM6F7x0osa7aC2xjYAUyXyndemtd5q9meN7WQLhELx85WdBe77aAZ/3B3zgMx8tHVqQ99tsRGTMlPHTpzojcvpw6n63ZRQtiww3zbcm7i07TvSpGhbgc6jvB9eDsbarxsVf04JR1iI2z48D+BInHcMMJ5T97ZRlg+nq2stNwGcoO96jL+w9vJZsOkKkqt511QLbp69WbNDe7/KHf/qBvLZcOmlU4wlNwIg2BkQHkOpdov26RJda6PIBnif4k85pbL0uMPF/piw73yheNzI0+lFRpQ5wmY77jkdSc0IlMTJT+KoIjpLcttCXPQVb/FsIQTM1twvvHoCDpzNP+Uwy8HZIcakFFCgPJGGgdxRnMJ4s4Agbl6RpQvCN/mQkXUiBKcZJ2ufBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39830400003)(396003)(366004)(376002)(136003)(66476007)(4326008)(66556008)(8676002)(66946007)(86362001)(45080400002)(6916009)(54906003)(36756003)(38100700002)(31686004)(31696002)(83380400001)(186003)(52116002)(6512007)(8936002)(6506007)(6666004)(41300700001)(478600001)(6486002)(966005)(7416002)(316002)(2906002)(53546011)(2616005)(44832011)(5660300002)(10126625003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNZRHZBZUNISXdhQ3lsWWpaWm1YLy80WERISmxjVGpUcy8zRFp5ZllnUzhj?=
 =?utf-8?B?dGE4SXFSYW1yZUZwazdibHR5VzduODZPU0JFZGNLQWJsazA2Q2NPVExpVE9x?=
 =?utf-8?B?bUNzeGF0Y0MwcGVNVnhTNTQyZXNXK0piNXdoQzBwR3ZBUFE1UXIvaE1LWGp3?=
 =?utf-8?B?RzUySlE3VG16RzJFNTd2anVUb1lHZHdjTW1BSlI0ZFRSSmwrRzVreTU3RCtO?=
 =?utf-8?B?YWtwUnR3MDVFYnBFdzcyK0FBUVg2SGp2Y0MybEFTdzRkMzRQRVQ4MENLWGZs?=
 =?utf-8?B?Z2dHVXJ4TDFyNEZSU3dRblYxamgwRVptelkxMWFLbWtDV2pKc1hvaFBXOTJO?=
 =?utf-8?B?d0dZeE4weFEydkNqS1N2RDNoSitMZW9odmJaY2VScTBnZFNtNHNFT3ZLcm43?=
 =?utf-8?B?VnRPYWxNOStqNTAxZHZiaFBMMjMwVE5sWUYwVFoxUUdoTm9oc3JsR0QwVkRa?=
 =?utf-8?B?ak9yam5KYi9ZMld4dDJwQmNOVm1SNzFrRFVpK3hxVGErMytIQllnSU9yT0Ri?=
 =?utf-8?B?Z2hlNXVGOHRrUUI0a1Bya0JoQ2FoTHM3eHNOdkJmbExES0tlU3U3ZkcwRi91?=
 =?utf-8?B?WGFHaGVCTnFaVDh6L3VIYTk4d3dpQjFqTkdzVlN4TGtDSHIwNG56V0E3T3pD?=
 =?utf-8?B?V2s0ZjhuemwraFB3c0lobENSWmRxbWltTkNaZUR5TmxVZ3kzVzMxdEdib0t0?=
 =?utf-8?B?M096STNhKzE3SFVNUFlHTVNuUEY2TTJNUHFhMDRlNTRYbjd4TTc5cFoyT2dJ?=
 =?utf-8?B?NmQzOXpzbnNHa28zeFZhajAxNXJFZFdnRGthb3NTYlovQnFqazNSenZka1FL?=
 =?utf-8?B?QkhJVktGNHlKenRNVStKTUI3RkhIbkkva29TdDIxNVNRT3paV3hsQ1VENkUy?=
 =?utf-8?B?enorMy81TlJRdjhuZ3E5NFBCNWJkd25oNGpadTJhSjgyUkpUTnNzRm9rbmxj?=
 =?utf-8?B?RUMxbk9RYTRFcllCa2RaZklkc2hyUTQ4elJ5cEE4Y1ZWTWw3NHZRRWIxM0wv?=
 =?utf-8?B?UDhBMmhNbVgwN3JoQzh3cDIzbUkyY3F3T1RmZnBYZ0twcTdTUlNIUkRvYXJL?=
 =?utf-8?B?dlN4QkgwaHZaZ1BMZUNaMzhyRHlnZWQ4ZWZXWnYyVmNiSCtENXhVWDB3Rzkv?=
 =?utf-8?B?TXNOVEYxcUo4MXpSUkNER2ZURWhDUzVqU2F0QzNIU29YTDFiRkIzbkh6dDYw?=
 =?utf-8?B?blo3SC9DUDcxa21aNnlzd0h0ZDhHZFdnanFPRGRuMEN1c21pUlhpL3ZUR3do?=
 =?utf-8?B?eHUrK2tzMUwwVkZZVmM3ejl3cDhtK3NpWUVkVWR5S1lPR2ZBWGtBNnFXaHNS?=
 =?utf-8?B?VTlvd1ZMbW4xWURQUFA3bS9YN285VVZEVFlUZXFIajJpZFJEQzZhZ0I5NmZG?=
 =?utf-8?B?aGlVU1Nha1hnaWFFbGw3cUMzVzBuY1AzcjY1Y2lhOFVub0xHdzB3YWpLai8v?=
 =?utf-8?B?a3JNNHJPdW53RkQ4SHk0c1BrWWdzN0pqeWdsVTdjelh1dTM2dXJLR3UyZmNz?=
 =?utf-8?B?ZzVrd2NGVG5mNHp1Q1YzRnVHZndpL2tWR0pYMW54MkpaNmMrdUxreFJ0YjRT?=
 =?utf-8?B?U3dWa0Rad0IzVTNEUEF4WHhYZFV0NEwxa2NtNDdRcWQ0VWJSK1ZNMUFVUE1l?=
 =?utf-8?B?Y1BmYWhVNUNiQVRzdTNzWkNFNThjbXJ0QTJIZHJydXpkOExUQmtHczYzNGR5?=
 =?utf-8?B?SzZwNmhBSFhEbFYyeEhmdkJWSTIrTWxCQWN5Vm4wYjdoNWZJc0pyM1BjRWdw?=
 =?utf-8?B?QUtORzFJU09McElpemZCMGRORXhETVYzSW5Gdm5mSlVlUjVudjZJSnYwTlor?=
 =?utf-8?B?L1JFVEdzQXZtSXoxSWdtdE9ESVZPaFp3UVBNT2RsRXNRa3lRb1gzRlpxVHM2?=
 =?utf-8?B?Vk1QSkMxaTlVV1JzUURsVUpPOEVyeUc1OFRpQVc4MnBWMU9mVFBXcXVRRStK?=
 =?utf-8?B?VzgxeWVkY1lDZFJ1VmgzRzZYelhZL0NQMVdPL1hLMUNmZDA3ZXFHeUFZMzJv?=
 =?utf-8?B?VHo2cElwTnhOR3FuRWxMUVhuQ0QwYXlRSm11WUIwTE1zSjA3ZDRNSkZYTVMx?=
 =?utf-8?B?RlZQQkFpY05QWk5tcUNtcUlESUZoQVZHQ0JrQXB4V2JsckVTMTdXSElFYWVk?=
 =?utf-8?B?SFNjR1lUbW54NWszUEg1U01mUFN3K1ZVREluQTExM1pXajZudStHazZ3SmlP?=
 =?utf-8?B?UDRRSUtnQjAvdUdPOWxHUXczcHhnMnFmMThQemEvbFZOWjREOXdiVW9rYWkz?=
 =?utf-8?B?V3l3c05Hc1ludjVUcG9pMGg1VmdRPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8db388-afc1-4ab3-c7b9-08da840c1856
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 07:01:11.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukeb0AoUj0Pwqdt2rYdK0Hs+/8ZR0Bb4R0SyPSWqFub/5SjH6XmyvbK1jsgEdvydPPcBcqAZP4AcrJSGJAJN0UR/4QO+hhzLU23U9YpPDV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/20/22 12:23, Peter Geis wrote:
> 
> 
> On 8/17/2022 4:25 AM, Michael Riesch wrote:
>> Hi Peter,
>>
>> On 8/16/22 17:27, Peter Geis wrote:
>>> On Tue, Aug 16, 2022 at 11:20 AM Michael Riesch
>>> <michael.riesch@wolfvision.net> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> On 8/4/22 11:49, Peter Geis wrote:
>>>>> On Tue, Aug 2, 2022 at 2:39 PM Markus Reichl
>>>>> <m.reichl@fivetechno.de> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> with linux-next-20220728 rk3399-roc-pc does not boot.
>>>>>> Bisecting pointed to this commit.
>>>>>> By reverting this commit the board boots again.
>>>>>
>>>>> Thank you for reporting this, someone was kind enough to reproduce the
>>>>> problem on the rockpro64 and confirmed this is an issue. As I won't
>>>>> have access to my hardware until next month, we should probably revert
>>>>> this until the root cause can be identified.
>>>>
>>>> Just experienced this issue on my ROCK3 Model A board (RK3568) and
>>>> reverting this commit solved it.
>>>>
>>>> Having the revert in v6.0-rc2 would be great -- if there is anything I
>>>> can help to accelerate this please let me know.
>>>
>>> If this is now happening on rk356x where I know it works, it now
>>> cements my theory that it's a symptom and not the actual problem.
>>> Possibly a race condition with the grf and regmap code where it isn't
>>> quite ready when called. This code path is called exactly the same way
>>> later on when the irq fires.
>>>
>>> What config are you based on? I'm running a stripped down version of
>>> the arm64_defconfig, but if you deviate from that it will be helpful
>>> in reproducing the issue.
>>
>> I posted my Kconfig here: https://pastebin.com/P1As0W4k
>>
>> FWIW the ROCK3 board has a switch to set the OTG port to device or host,
>> respectively. The NPE does not occur when the switch is set to host.
>>
>> Best regards,
>> Michael
> 
> Good Afternoon Michael,
> 
> Please try the following fix.
> 
> Very Respectfully,
> Peter Geis
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 0b1e9337ee8e..5fc7c374a6b4 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1169,6 +1169,7 @@ static int rockchip_usb2phy_otg_port_init(struct
> rockchip_usb2phy *rphy,
>              /* do initial sync of usb state */
>              ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
>              extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
> +            ret = 0;
>          }
>      }

Thanks, this patch indeed solves the issue in my setup. With both role
switch settings the NPE does not occur anymore, the correct role is
selected, and both roles work (tested with zerogadget (device) and a USB
drive (host)). Can you spin a patch?

NB: On the ROCK3 the device tree needs a fix to get the host role going,
I'll need to take a closer look on this one and spin a patch.

What I still find strange (but is unrelated to the commit "phy:
rockchip-inno-usb2: Sync initial otg state") is that two and four xhci
controllers pop up in the device role and the host role, respectively.
For example, in the device role there is a pair of controllers

# lsusb | grep xhci
Bus 006 Device 001: ID 1d6b:0003 Linux 6.0.0-rc1+ xhci-hcd xHCI Host
Controller
Bus 005 Device 001: ID 1d6b:0002 Linux 6.0.0-rc1+ xhci-hcd xHCI Host
Controller
# hexdump /sys/bus/usb/devices/usb5/of_node/reg
0000000 0000 0000 00fd 0000 0000 0000 4000 0000
0000010
# hexdump /sys/bus/usb/devices/usb6/of_node/reg
0000000 0000 0000 00fd 0000 0000 0000 4000 0000
0000010

that are related to the same device (in this case usb_host1_xhci). I
would have expected a single controller. Anyone care to enlighten me a
bit why there is a pair of them?

Thanks and best regards,
Michael

>>> We should revert it until it's isolated, as well as the patch setting
>>> the rk356x to otg since it will again be broken. If someone could
>>> weigh in here as well (I currently don't have access to my hardware)
>>> it would be helpful.
>>>
>>>>
>>>> Thanks and best regards,
>>>> Michael
>>>>
>>>>>
>>>>> Very Respectfully,
>>>>> Peter Geis
>>>>>
>>>>>>
>>>>>> [    2.398700] Unable to handle kernel NULL pointer dereference at
>>>>>> virtual address
>>>>>> 0000000000000008
>>>>>> [    2.399517] Mem abort info:
>>>>>> [    2.399772]   ESR = 0x0000000096000004
>>>>>> [    2.400114]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>>>> [    2.400594]   SET = 0, FnV = 0
>>>>>> [    2.400873]   EA = 0, S1PTW = 0
>>>>>> [    2.401161]   FSC = 0x04: level 0 translation fault
>>>>>> [    2.401602] Data abort info:
>>>>>> [    2.401864]   ISV = 0, ISS = 0x00000004
>>>>>> [    2.402212]   CM = 0, WnR = 0
>>>>>> [    2.402484] user pgtable: 4k pages, 48-bit VAs,
>>>>>> pgdp=0000000001376000
>>>>>> [    2.403071] [0000000000000008] pgd=0000000000000000,
>>>>>> p4d=0000000000000000
>>>>>> [    2.403687] Internal error: Oops: 96000004 [#1] SMP
>>>>>> [    2.404130] Modules linked in: ip_tables x_tables ipv6
>>>>>> xhci_plat_hcd xhci_hcd
>>>>>> dwc3 rockchipdrm drm_cma_helper analogix_dp dw_hdmi realtek
>>>>>> drm_display_helper
>>>>>> dwc3_of_simple dw_mipi_dsi ehci_platform ohci_platform ohci_hcd
>>>>>> ehci_hcd
>>>>>> drm_kms_helper dwmac_rk syscopyarea sysfillrect stmmac_platform
>>>>>> sysimgblt
>>>>>> fb_sys_fops usbcore stmmac pcs_xpcs drm phylink
>>>>>> drm_panel_orientation_quirks
>>>>>> [    2.407155] CPU: 4 PID: 71 Comm: kworker/4:6 Not tainted
>>>>>> 5.19.0-rc8-next-20220728 #437
>>>>>> [    2.407868] Hardware name: Firefly ROC-RK3399-PC Mezzanine
>>>>>> Board (DT)
>>>>>> [    2.408448] Workqueue: events rockchip_usb2phy_otg_sm_work
>>>>>> [    2.408958] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT
>>>>>> -SSBS BTYPE=--)
>>>>>> [    2.411634] pc : rockchip_usb2phy_otg_sm_work+0x50/0x330
>>>>>> [    2.414332] lr : process_one_work+0x1d8/0x380
>>>>>> [    2.416948] sp : ffff800009373d60
>>>>>> [    2.419406] x29: ffff800009373d60 x28: 0000000000000000 x27:
>>>>>> 0000000000000000
>>>>>> [    2.422199] x26: ffff0000f779fcb8 x25: ffff0000f77a3a05 x24:
>>>>>> 000000000000000c
>>>>>> [    2.424978] x23: 0000000000000000 x22: ffff0000010c8258 x21:
>>>>>> ffff80000888ec10
>>>>>> [    2.427768] x20: ffff0000010c82f0 x19: 000000000000000c x18:
>>>>>> 0000000000000001
>>>>>> [    2.430604] x17: 000000040044ffff x16: 00400034b5503510 x15:
>>>>>> 0000000000000000
>>>>>> [    2.433390] x14: ffff000000708000 x13: ffff8000eec96000 x12:
>>>>>> 0000000034d4d91d
>>>>>> [    2.436185] x11: 0000000000000000 x10: 0000000000000a10 x9 :
>>>>>> ffff000001aa7a74
>>>>>> [    2.438958] x8 : fefefefefefefeff x7 : 0000000000000018 x6 :
>>>>>> ffff000001aa7a74
>>>>>> [    2.441668] x5 : 000073746e657665 x4 : 000000000000002f x3 :
>>>>>> ffff00000356c808
>>>>>> [    2.444407] x2 : ffff800009373da4 x1 : 000000000000e2ac x0 :
>>>>>> ffff80000888eb34
>>>>>> [    2.447190] Call trace:
>>>>>> [    2.449557]  rockchip_usb2phy_otg_sm_work+0x50/0x330
>>>>>> [    2.452169]  process_one_work+0x1d8/0x380
>>>>>> [    2.454684]  worker_thread+0x170/0x4e0
>>>>>> [    2.457056]  kthread+0xd8/0xdc
>>>>>> [    2.459354]  ret_from_fork+0x10/0x20
>>>>>> [    2.461728] Code: 91037015 295be001 f9403c77 b940e413 (f94006e0)
>>>>>> [    2.464338] ---[ end trace 0000000000000000 ]---
>>>>>>
>>>>>> Am 22.06.22 um 02:31 schrieb Peter Geis:
>>>>>>> The initial otg state for the phy defaults to device mode. The
>>>>>>> actual
>>>>>>> state isn't detected until an ID IRQ fires. Fix this by syncing
>>>>>>> the ID
>>>>>>> state during initialization.
>>>>>>>
>>>>>>> Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
>>>>>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>>>>>> ---
>>>>>>>    drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
>>>>>>>    1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>>>> b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>>>> index 6711659f727c..6e44069617df 100644
>>>>>>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>>>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>>>> @@ -1162,6 +1162,12 @@ static int
>>>>>>> rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>>>>>>>                                        EXTCON_USB_HOST,
>>>>>>> &rport->event_nb);
>>>>>>>                if (ret)
>>>>>>>                        dev_err(rphy->dev, "register USB HOST
>>>>>>> notifier failed\n");
>>>>>>> +
>>>>>>> +             if (!of_property_read_bool(rphy->dev->of_node,
>>>>>>> "extcon")) {
>>>>>>> +                     /* do initial sync of usb state */
>>>>>>> +                     ret = property_enabled(rphy->grf,
>>>>>>> &rport->port_cfg->utmi_id);
>>>>>>> +                     extcon_set_state_sync(rphy->edev,
>>>>>>> EXTCON_USB_HOST, !ret);
>>>>>>> +             }
>>>>>>>        }
>>>>>>>
>>>>>>>    out:
>>>>>>
>>>>>> Gruß,
>>>>>> -- 
>>>>>> Markus Reichl
>>>>>
>>>>> _______________________________________________
>>>>> Linux-rockchip mailing list
>>>>> Linux-rockchip@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
