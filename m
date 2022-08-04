Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CED589983
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiHDIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiHDIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:50:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2070.outbound.protection.outlook.com [40.92.99.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6F28D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBUadjffGCbejuUpq6i33pMXwakYWWY5zyc30qsRrvuO7Vw+otXY1e4ZKwcZwv+4DH1yuCYIOv2VrnIYnEYeCDYVRrfd7WBMZEdIMW+7wr6KWl/tKASYHK8eusxu5SbZ6JVJmkRklbG/klOxlhqa9kSf2Na15iJwTPvsjfoxvr81/bwPL7RtB3Zc5Z+gJ5yaarCSn78IsZb0pKgFVcCTysC5+KZXU4aekPUcxR1aNyd8KDFTx3CMVh0aeGey0HMRJxloC9WG7M7wpZcAW6AGpcmP2rlggiZPDl9CMVN7IBlfmdSzu6jyMYI66M6OWYR2DetYOOHqqq4+LiW7ySBHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btW7GZGUqXSnEvWFWgq0+uPXk0Simxjpu/Rd8PxXGvI=;
 b=BRbCtpUO4ycAFu7TBukvAhPUN5/hjbMqxZh3FI+T2T4EKn1hS8TtKmYjaH/XZ/4O1F2WrJrQLXdFOw80tyXKwQvwbMrK94po3i5F0tJN0+kH6Vj8jqnBbOZrzl206tnwt4h7kS9Jy3Ojyr2315zrkf49mcZzgqR+c0rEUrYzbGoY1DVaQuNb2hqcLStiut+8pxq1pZpZqXojXuFUgJLgnWZfJSuxzqlH/kRxkn4M+BOPbzVmeXPeGzx3eTlaNLPaiTVI3KNoAzZ7MRUoeI8k4CITnsvv2i6ORqgwz4HYQaagVYsFoTg8UY5W356dN0Xowb7R7wx++NvgeK7YX5G8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btW7GZGUqXSnEvWFWgq0+uPXk0Simxjpu/Rd8PxXGvI=;
 b=e84TDJ5Zhp4eFPzqTjukJxso6ri+m8Gui3ApkC47Ta45tlyZR6RxHQ8FksdKvmpikETqlatyOumrskZE8uD/Y1NYt+LhHYeKi2GI3f4I8AR4bdqsPZg1GOm5RJ51k5zHHCC6G7ofEEeIBpSRWs65AO+XjNmyOEDf6Yqf3VWZsQW2rnj2HTEHe4HtScpMMGxDWkLkThlU6TZ9nxBHN9/OApTZHRxj510pBQUvhsItalGRoWkkaub5Bicv6IRp9Ty/manHntltUgiY3+DziaV/sNgDFzaqwF3v8pd97VEc4aVqU5ZFctsIwxxvUODHevbKUndKFRpdKMhP2cTt9JB8/w==
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9) by
 OSZP286MB1080.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:112::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Thu, 4 Aug 2022 08:50:24 +0000
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d]) by TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d%4]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 08:50:24 +0000
Message-ID: <TYYP286MB1763C4319C6D5CC50E5ECCF2C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 4 Aug 2022 16:50:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 3/3] scripts/gdb: fix lx-timerlist for
 HRTIMER_MAX_CLOCK_BASES printing
Content-Language: en-US
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Liu <liupeng17@lenovo.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
 <TYYP286MB17639886A7064A1E610FB2E3C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <TYYP286MB17639886A7064A1E610FB2E3C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [1Khxw6qC2Lze+W9NH8irB9/ejNdux3M6]
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ff::9)
X-Microsoft-Original-Message-ID: <badc6eb8-15c7-09b5-af38-9ce3d8adf227@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a926483-784f-4563-0b16-08da75f65f0e
X-MS-TrafficTypeDiagnostic: OSZP286MB1080:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oxX3l1Dd4E3npuwENxi8+kkw2pCGxUtKLMHMJnxoLuyjTFeZ61CK9DCz6Zyrd5lYia+z5pdU4KTSs/E3SAFrXNya7Uk03RLz39J8m3SSixqLNewu1NlbtKUozurT6ysVuMHG3JDICtg0P+A07llL1W1Bwb84O8hgF+SDcLfkUGTU1R9f/9MKHQYst7+JWZDCI/fQtdWM+gd/HjhlKZj4DtdY96/r+atvI5PVyIZ+gUK3D2VPdHt8ETt+aeaAU8B5tEzUotj5Drg+cW74Hz68qfG+dC2HkgfqoB5vVlcdRZ70f52nUR36OJh7nYWvAGLrHd5/h4iqozDVtVS721eEZT13AD0Wr6RB76SyrysRtl1ntbQD0iXTYKL6k/WC1CnDSFe+hE324psfEPz9/DFT78M8v4Wk39WTFmDQx8qAEeE5OQpiCDI453yb41HkDkh3n6MWrE9G3MZAmAJhwh9og+2KOqsGvUZCRMMC/9HlDmPt+cKMVRh6vyDsCNgjI3hueVwOukuSiNxKRjsZWhJM1HZFa77Bmzeav+4wFGrNclVw6heEcX6tztEO7JTnwhiMKOHM8tZvb5LMfQZp/cfBso3iE+Zbst+Qs1NLyRK6QgHeASxfECY99m7JI2FnkwdOivUTd4YY6A5W6No+eIpHpzAj3bpd/m+RVIh5WpnFxm3C/hbh/ATyfU6foIfOt2r
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVNdWNpRGltd1BnSFhVOWJFWG5ZM2g0elVhdnduTWpiMGdVQ2FyTlBXY3BH?=
 =?utf-8?B?Y2ltKzg5MkRBVmNDMHBXSzZWMnZNRTZUNjZ1OHpQVTY0aVBWY2x0WEk3emJt?=
 =?utf-8?B?VmdwVjBqSzVHNXBvK29QVS9YbnpnZ3RGSDFWQ3NiZllHTmtrNkhHN1hHVWZ1?=
 =?utf-8?B?U2FPS1NoKzk1byt3c3UzcTk3STI4b3AwVXJEeDUyRlhNQllpK0dLVmtlaHFL?=
 =?utf-8?B?TjRZZjRONzFkS3M1ekI0cEhnMnFJTjR2VGU4TDVadVFGK3dWdXFFMjJwYTg1?=
 =?utf-8?B?cHovQkc3TCttME9Td1VLMExaUnRJdGpxSEJtdDh3blptZjlLRHhZTFVZKzI2?=
 =?utf-8?B?NkRXR3JvbFNCVHhmWE1LcTE4VFlYbmNMb29jV3p2dFBKZktFZ0l2SGc5RlFB?=
 =?utf-8?B?MUhocUp0NnlzS2NEaGhjaXltNi9KRWxIcXRhK3piY2RZWVc4VFFoWUZUQjVE?=
 =?utf-8?B?WHNPQm1oeitpRWQvWFdBSXEyWFhTYTc1U2NzWmhJeHY0NVZsNTQrc0d3a0I0?=
 =?utf-8?B?amdzWDlSUHJ1dkljL0xOTzlQK1JuS2pSVlV5Qjc3ZS9ER294N1Jwb1RrTTFr?=
 =?utf-8?B?VXkvanIzQ2ZrZGtvWVlETCtiNURyUEQvWm1aN0dqa0J2YWlCZmxqZldpNlBm?=
 =?utf-8?B?NUVpNGhydUhGdlVkVzRuZzRob2Y4TUdudXd2Zys1aDY5YWwwVnFhQkVYRnFv?=
 =?utf-8?B?TUtQV3VRRERDNVVFaXlNV1JwNS9HdXdSVmk2dGdURDdLME91c2p0OTFGcEZv?=
 =?utf-8?B?bnh0YTY2aGl2VVh2bXFEODJienNGaVdNS0RRTnRTblhtWFlsSEh4aENiRzM4?=
 =?utf-8?B?R3FqRFBIL0xmUFRNZWM5ZWpxTk00NEdwMVlyWTR0Q0Y5eWF6VXJlU29XQVlF?=
 =?utf-8?B?QXdEOU80dDdJMHFHYVJZQ2lLZFlFNlpiZnNQS1k4WE9OOFE2S1NtR0Q4SUJY?=
 =?utf-8?B?VWZGY2RDRVFRWUlYRHNKSTk0eGQyNldKNFQzUlA5TDVscmd1VEpJcjgxMkFY?=
 =?utf-8?B?cjlOWDRpdGJ5Z1dFb3YzSndpYXVuNlFCU09XU0hTTGVzQXBWaHByVmxEeHAw?=
 =?utf-8?B?Sk1JQWtFSm1VU0pBWnBoTk1aYnpIc2VFMVFnVm5ROXhkQmFLLzI5czQxMkVl?=
 =?utf-8?B?K1poK3dEaE4wVHNGNFlxbUxMeUhKN0dwNVhNdWh6cXM2NG5YYVl2elZmNk9W?=
 =?utf-8?B?bGQ2dE1OVk9UWGlaY2g5bk9tNXJseEl6MERtWXgyeDBzZ0pMRW1iN3l5eVBV?=
 =?utf-8?B?cW8rdEY1bC95bWtwL2VkNFBLWHR5aEVlODFFM2Exc0tuM0NpVGFSaVlvbWV2?=
 =?utf-8?B?RXB5dWZkWTFqVzZCYkpZQjc2Q2VBcGRPWEV2S0tsREMwdml6MUhaUUJCODUz?=
 =?utf-8?B?Kys4b1NQZURReXJLNFJZajlhVkpwaStoMlA1RlFnY2hkcjF1cXkya1ZNY0w5?=
 =?utf-8?B?bzBwOW04eVRPSEVyUUNnbm5scG50WWxyMXdnRGxGaEQvMStFMFBxeWozWHN2?=
 =?utf-8?B?UVYxUkQvcVRQU1hnSTI4VExPV3ZjSE9wbDFORWoxdFlXcGVaK2pzSVRTVWNa?=
 =?utf-8?B?NjQzYU9ZalpmSGdEMk5YK1piQklEY0g0QXFCN1h6Zk5nZ2xHWmhadGN6dVR4?=
 =?utf-8?B?NlR4ZlA0M1VjcTVZUWE0bVU1ck5PUFEzSndxaTdlWFZlQVZLT1FjajBKM2lr?=
 =?utf-8?Q?fCI2/CKifLwWk9yUQjNm?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a926483-784f-4563-0b16-08da75f65f0e
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 08:50:24.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1080
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/20 20:27, pngliu@hotmail.com wrote:
> From: Peng Liu <liupeng17@lenovo.com>
>
> HRTIMER_MAX_CLOCK_BASES is of enum type hrtimer_base_type. To print
> it as an integer, HRTIMER_MAX_CLOCK_BASES should be converted first.
>
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> ---
>   scripts/gdb/linux/timerlist.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
> index 8281da068c5b..249f0e804b24 100644
> --- a/scripts/gdb/linux/timerlist.py
> +++ b/scripts/gdb/linux/timerlist.py
> @@ -188,7 +188,8 @@ class LxTimerList(gdb.Command):
>           max_clock_bases = gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
>   
>           text = "Timer List Version: gdb scripts\n"
> -        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(max_clock_bases)
> +        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(
> +            max_clock_bases.type.fields()[max_clock_bases].enumval)
>           text += "now at {} nsecs\n".format(ktime_get())
>   
>           for cpu in cpus.each_online_cpu():
