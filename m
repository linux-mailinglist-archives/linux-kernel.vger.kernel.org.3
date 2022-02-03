Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B3B4A8BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352977AbiBCSeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:34:44 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:36676 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiBCSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:34:43 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 1C617205CF13
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] MAINTAINERS: add myself as Renesas R-Car SATA driver
 reviewer
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-ide@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <6c1f0131-fb02-f30a-86ed-63ce3788901b@omp.ru>
 <CAMuHMdVjCzEpDLnW-jy_kpHoV8DEa=KCAjp=QeXnr8auh3B5Pg@mail.gmail.com>
 <ad4930d0-7d4a-6a81-5830-3a62a44572f5@omp.ru>
 <CAMuHMdXcj8tDdGLZ=K29YDUqb_=_kM42ZOE6F2kCJhf-uPSzzw@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <4d7532fa-a814-6856-3af6-f0ee89581ee8@omp.ru>
Date:   Thu, 3 Feb 2022 21:34:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXcj8tDdGLZ=K29YDUqb_=_kM42ZOE6F2kCJhf-uPSzzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 9:27 PM, Geert Uytterhoeven wrote:

[...]
>>>> Add myself as a reviewer for the Renesas R-Car SATA driver -- I don't have
>>>> the hardware anymore (Geert Uytterhoeven does have a lot of hardware!) but
>>>> I do have the manuals still! :-)
>>>
>>> I guess some of the manuals are publicly available on the Renesas
>>> website?
>>
>>    Have they finally published the R-Car manuals? 8-)
> 
> The same SATA block is also used in other SoC families. See e.g.
> "RZ/G Series User's Manual: Hardware" on
> https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz-arm-based-high-end-32-64-bit-mpus/rzg1h-ultra-high-performance-microprocessors-quad-core-arm-cortex-a15-and-quad-core-arm-cortex-a7-cpus-3d

   Oh, I that know, and have redirected the people in search of the R-Car manuals couple times. ;-)

> Gr{oetje,eeting}s,
> 
>                         Geert

MBR, Sergey
