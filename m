Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53694A2D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbiA2J7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:59:38 -0500
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:29726
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236342AbiA2J7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:59:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqo/bW9r2O27e968jF3LgUJtqOV/MIEv4M6OUzlr9Nxh4rKTGJ2BcWjRewggxElKXHMKNeTvkG5rE2HXviUCL1AtOuolho63LQoAblfmCuhNCQWY5dGTvUa6Imp+D2S+OqmVwTAnMKCSrCX6JZaA1afVTGGtwaU1gIYXclY3650irHV9iDe8S9PCFvDJfh1LTKxhTUY3Djg6QF8lDM9CU5XTCruSNKzarK4i+lJcuflpvYjnt0gUvnFeF0E+fF/8iLbpKHyltCbMBSraW2A/21qQLgHfjRxKB9G5HqaXEAfuXAkF9cR/bttRcv2vXhOoHPS+PmI5FMk0y8wbe2lYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M63SzhjgMxT048F/GzzMY6n4QHW6r+FFy8c1USjeS+M=;
 b=GJn7fzPGIulHwqa9J+i3m1sj9alccNcX+pFyVAjyRKzxuyzOrIE3Y5jWcFQ7E/Ge4siko7QRQh4UC/nl+YKnZBVM+GFFT9csj5N+FVY5uNHFCq1Qf+eoqDca9Fj3fRFF0LJACeAMhB8CJNuSgrqacChYDggfgmqH//kbtPhWI3uvdD6Kg5Fct7LFS0s27ZAWgfjMsUKZZBpcWqh/tb17mvAe9F0GOiSgRRcNtTG5VUowd0uVYrEzYBkS4udNTSNZX4vmVfHpNmdY0Jc1uDUsm8uYp9Ho5Ef9Mt2zF0g7If/XEsyQprf7Rda6I+l3SLIOkYde0mEFgqcovXpd8MfN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M63SzhjgMxT048F/GzzMY6n4QHW6r+FFy8c1USjeS+M=;
 b=HU+BplunDi7h9xzuUABc6YQ0+/mL6azVzWchI47POWU4ZdbxgGWHOIcO/uSC+61f5a1ToBzRMhun2srG7L6STqVvkYAOO0XGJAbmZs0ZcLTyjXBP+INb9QasQzC2AM9OXhaER4jjFHMJCEapzDAZtdAt4e/znwNS49njthYgWE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by VI1PR08MB4175.eurprd08.prod.outlook.com (2603:10a6:803:ea::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 09:59:34 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56%3]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 09:59:34 +0000
Message-ID: <64f539b5-30b2-c0b7-17bf-c448b507713e@wolfvision.net>
Date:   Sat, 29 Jan 2022 10:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rename and sort the rk356x usb2
 phy handles
Content-Language: en-US
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
References: <20220127190456.2195527-1-michael.riesch@wolfvision.net>
 <CAMdYzYpkXdXDST+N8dEn7UvibXmytwNeJ+KZ9bn9Oq+RJuSaeQ@mail.gmail.com>
 <FBB7C392-C5E0-4E34-AC17-5323414623F5@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <FBB7C392-C5E0-4E34-AC17-5323414623F5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0171.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::9) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45352f23-f8fd-43db-c895-08d9e30e0d33
X-MS-TrafficTypeDiagnostic: VI1PR08MB4175:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB4175CD8E8115234B7044E978F2239@VI1PR08MB4175.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygu7DR9ePMzcFVfOVAmSNtb6YFWvavdaASTaGJi4qoiSnLdMFDYdddKiE78RgGEBu6Op5poU9xUxdNxUEEjIdstS3aYdIKKtfa/Wuk/+0yhqQhJA61N0z9SRkvzfF7BwAuLASLBoBJLI0wc4k56yQweVxA59Xd6BGBpmLKzaRGO1SnKOWKTHMAzRp/x32o7Er/g/sG6GX1AAbRL9jDmA9iosuKAtInIHiObKKPXYUKHkU4+qso0y7AFZNFsSaf/nD2KTkPGdTRlIkR/a1WZHgnvWK+zhokytzZ9JvPI+kN6fEjFmjkVrHP+DyJQQ182Keh2tJ9zbN9Lr1i2+OYpBGhyDK9hBye5p4vdw/TXLjlnQWlZhGpXC+EvuIyszG2mYWYHl79C+XKTRlL0GZt7eon0xFbdtL1K5NZlhREHnTTj6fJNImIbQOtbWzbBlluHJiFd39mJ+2wMAIrBbyTcmrF4kqGQy6MLCK9LJC8+SpKzl9EZEh2za1rLytAx+Wp0GNdBru2oeaGW5TTgy35Uk68uG/XtViHH14J1/GIWX6Q+PopH8A/4ugXNK81D9xHEyKHlCxJ2ExylmG2Bko5TkafoUjXCXU1uoZdJ+KJhU5YlDW5MDemfiURdeilh+tJcyxsgOt2B23KwfOO2w7bobV55OUszGP8TsyBiuNFladYbhg209GwaEesMaObaLYsmwEUBGYOgsKYYx1paGZ2NyzthDU50UYEz3S5iX1cnWtHzHZYxShQTxjuQU3GXK3YvX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(66476007)(6512007)(52116002)(66946007)(66556008)(31696002)(6506007)(8676002)(53546011)(31686004)(36756003)(4326008)(8936002)(7416002)(2906002)(44832011)(54906003)(508600001)(38100700002)(5660300002)(316002)(110136005)(86362001)(186003)(6486002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TThCc1BLeUdSS1dISlQzb0NaRG5MVUR4Y3ZaSDJqd0NwWGp6WG1ydzdxZW9U?=
 =?utf-8?B?OHFMMVJQYlNkQXIzK1BrRWxzY21RcnQ1WjQ4Y2JVL3lxYXRQQk9IeTlrOWRW?=
 =?utf-8?B?UUF3YlZxZVN5anNqSEY1b2haSFhyTUpWa0FxK2NwNXhIVGxvUUd0OExOeS9t?=
 =?utf-8?B?NjRqYzFSWUJQbGhwdlNpVXA2bUdyaFRTbWhYeWI0MEhsNGlBZDNzcEZWME1W?=
 =?utf-8?B?b1hrN0hyelZRSndmUlpsY1VVSkExUHNjbWcyd1RZUUlRc3RwcUViRGRzWFdG?=
 =?utf-8?B?RzdjYXd4SHJ6R1pXVG5KejZWM2pYcFk0QWdnTGNYblA5QmpZb0ppNmlwRVJI?=
 =?utf-8?B?MVU4aktIQ1d6VXdnMHFXaUM1LzRYUUxYK3hPSXVoWSs4enBnMlZaeitmU0tn?=
 =?utf-8?B?dWMxOWQrWXY5QmlhVjJzY3NuLzZnR1ZaUXVmLzZabDREalFNRlVNdTlwT1hu?=
 =?utf-8?B?VHlSaDZqVExDcU5uc0dUN0lEU2dlaWU5bGQzK0hOTlpuWG5NU3RnUGxOZTdW?=
 =?utf-8?B?U1cwcm1NZ3h0L2RoR1FrSnBWR3l1cEg3S25pOEdISGE5VDdGNURnTFZOck00?=
 =?utf-8?B?eW8rbjR3aGhjbjM1VjE3ejdwSW10YWxkQlRHazQ5ZitabzJqbFJPNXlFWUVu?=
 =?utf-8?B?QUpabE92cU9SSGRCaUt1RzJaS1FPRUNWN0JlaFJhOUlvNXM1amNBZ1lPUVVV?=
 =?utf-8?B?Wk9XOGhUK1JRRjUvbkt0UzlBOGZWUWFLb3FXaHBjWHdxak9makhXYlcxQmtk?=
 =?utf-8?B?NjdoZVo0SThhQmpVYkg4MWVMYXlWY2xuell3S1ZIRm9hWjIyQUxjYkJTREdh?=
 =?utf-8?B?Znp1LzJFdHF5ZG1KVGtjUlhJTDFRNi84cmZTRC80STJIM2RGOVBMMS9SOWlT?=
 =?utf-8?B?UHJ0aDlnZmtQeXZOU2xnd3MxSnlGcEE3eHlwOEF4MjJxRFFhZGhqUTB4aHJt?=
 =?utf-8?B?S2VIL2dkS3ZTNjEzelhrcFBWcnVEVUQxUS8yVUdFbHV0dGlpR2d1R1RHRXpx?=
 =?utf-8?B?RmxpZ2FpWXlsVmxTcFVOT2VKOEtuRlBUdXpidEFiaVhDdmhxUS9hR2p3a056?=
 =?utf-8?B?T05Pam1UMVRkMXFlVnJRRHVEb1UrRHpqVTRHa3NES0NNc0xzRnBnVU50V29u?=
 =?utf-8?B?Y21KbjJDUUdaOHE4VlBscHJnMDZzc2VaT2lnNGtzV0J2bTZEWmwrNzRUeGc2?=
 =?utf-8?B?NWxFM1gvWkdhWGtJNk45dGJ0WHN4cTdoSzZZcEE2eitWL01OdHkwNkJCVThS?=
 =?utf-8?B?NDlBVXNmdkFzbmJCblVLT0RzRDIzUmxlWjlCUnBtaFJMS0ZITWZTeFkrdE5a?=
 =?utf-8?B?bmJXYnNPSjNUUlZuWFZydjdXSFh4ekhHVitWSDFHdFpZQ3JwMmROR3g1T2hD?=
 =?utf-8?B?eU1oWUtmMVl3T0EyVHg5LzdzYVFmclNMZWc2R2xKZytucG5SYVBnOC9kUnRX?=
 =?utf-8?B?VzRnVzRJWVJLQyszNGluVUNHSnJLV0dVQ3FPMzljSVlFbGQ5OG94R3VMUzFB?=
 =?utf-8?B?a2dncTVYL2ppeWdTRnozOHZmWXZacWdQK2tUaG9wVHArT2VPUkVEVDM3T0Z3?=
 =?utf-8?B?eGUrdUVqOHpqNzlkTVIyQU0rVE9wdTFWNEwxaDhndmtXdkJUMmtUY2pqTVph?=
 =?utf-8?B?cllFVUNKYlBJUE1KeWdlZE9mUjNaWmo2QldybGtzMjhSNzEyZTcra2VJMVJV?=
 =?utf-8?B?dWZTakc4elgzVG9uZ2dtMVBUSjE5ekJKZmY2UVo1MExMSXhlTVgvOWhXTWxw?=
 =?utf-8?B?d1lTK0poUDVvYUkwNmIyRUVReFdEVTVpNkNJNzdPVlZHeVpwNGh2K0JUM25J?=
 =?utf-8?B?Q3lGVUJpV2ZRdSsvUnk0cVRJZGI1WG56SWJvYVQ5UVJERXhqVlE3UzBZZnE3?=
 =?utf-8?B?eDY3ejhaK2FjaUdZcmNOK2FXaWs5c01NMDU1a1JmclJhNVBQclFJK3VmVVQw?=
 =?utf-8?B?SXRSRXk1YW1zaHBEalZ1US91S01yOXdjWG5OYTUwRWNPTlZVZ3pBWUNDaHZG?=
 =?utf-8?B?a0RyTHdUQzVNbS8wY0pZOHJWdHBoc2J5aUJDZ2NTcFFwbndWeXdScnlUNHFU?=
 =?utf-8?B?RFIxZkp0TjFCSWVCdWI5OWFEcVhPei9FbVdJR3VlY2FaRFhPUTZVVEFMMCtL?=
 =?utf-8?B?dUc5SnF0NnlMaS9oUUZLd01PNlBvOFZBL0xKei9GV2g3TktoOTY1T2t6bERJ?=
 =?utf-8?B?Ykw0TmZSaXF2dGMyREFLcVlIWUdWMVd4QkRCd3ROZUNkYTJxTjhmalJ1a2pz?=
 =?utf-8?B?Y0VITXRVbWJmcUhlMUtNeWdHWE10aWxkTE5XSEIxWU9sV2ozbFJuOE45MFN3?=
 =?utf-8?B?N3l3NmNlSEFEcHVDcHVVYTFNMllnTlNCVnJNanhiUFlUNGNNVklKNTNEd3hK?=
 =?utf-8?Q?uVZQNUuxvCx2GC40=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 45352f23-f8fd-43db-c895-08d9e30e0d33
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 09:59:34.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw/Azt2plxafi29VYPATuq5N/ygz9wUjCQOj3M5g32I3DPW25NOZxUchGODp42rcWveYxuzjnCM72LSPEc4Zo0VzOMPfSfGLFcSyjUW7alo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4175
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter and Piotr,

On 1/29/22 10:23, Piotr Oniszczuk wrote:
> 
> 
>>
>> Good Evening,
>>
>> While I'm not against this idea, my main concern still stands.
>> I spent a great deal of thought on this, and decided to go the route I
>> did to maintain consistency with previous generations.
>> As such, I see one of three paths here:
>> - Pull this patch only and depart rk356x from previous SoCs.
>> - Do the same for previous SoCs to maintain consistency.
>> - Drop this patch to maintain consistency with previous SoCs.
>>
>> I ask that others weigh in here, as offline discussion has produced
>> mixed results already.
> 
> just pure user perspective
> 
> (who spent last weeks considerable time to develop DT for rk3566 tvbox. 99% of my work was by reading/learning from other boards existing DT's. Any inconsistencies in DTs makes work for such ppl like me much more harder):
> 
> For option 1 - i don't see value
> For option 2 - what is reward for extra work needs to be done on all other SoCs?
> 
> so option 3 seems to be natural choice...
> 
> in other words:
> 
> for me:
> option 1 brings practically zero value + increased inconsistency.
> option 2: extra work - but consistency is like in option 3 (so where is value?)
> 
> so option 3 offers the same consistency - but without extra work...
>  
> just my 0.02$

Of course this change is purely cosmetic and it is reasonable to ask for
the practical value. It is just that technically the quartz64 dts is not
sorted alphabetically at the moment. The u2phy* nodes should be but
before the uart* nodes to follow the convention. On the other hand, it
may be nice to have the usb2 phys and controllers grouped in the dts.
The proposed renaming would allow all the mentioned nodes sorted
alphabetically and grouped logically.

Therefore I had option 1 in mind. I don't see any dependencies between
the different SoCs and think we can make a fresh start here.

Option 2 is not really feasible, we would almost definitely break
something existent.

Option 3 is feasible, of course. However, I would sort the nodes
alphabetically (u2phy*, then uart*, then usb*). Works for me as well,
although it is not that nice IMHO.

Since many boards with the RK3566 and RK3568 will pop up in near future
we should do the change right now (if we want to do it), as of course
all the board files need to be changed. Therefore I wanted to bring this
matter up now. Let's agree on something and move on.

Best regards,
Michael
