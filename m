Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A65246F4EB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhLIUcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:32:45 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:35392 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhLIUco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:32:44 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru AE51A20AAC93
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d841bc59-a2a6-27f5-10af-05fe2e24067a@omp.ru>
 <YbI/6OIKM7qvLQcp@smile.fi.intel.com>
 <bfd96f5a-94c7-cee6-9546-14dc59cb8542@omp.ru>
 <YbJXjmsDJWlr3xpB@smile.fi.intel.com>
Organization: Open Mobile Platform
Message-ID: <15cf03b2-8d45-93b1-f0a0-d79c93cee0da@omp.ru>
Date:   Thu, 9 Dec 2021 23:29:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YbJXjmsDJWlr3xpB@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:22 PM, Andy Shevchenko wrote:

[...]
>>>>> No need to repeat this.
>>>>>
>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>>>> out a big WARN() in such case.
>>>>
>>>>    And? IRQ0 is still returned! :-(
>>>
>>> It should not be returned in the first place.
>>
>>    But it still is, despite the WARN(), right?
> 
> So, you admit that there is a code which does that?

   I admit *what*?! That platfrom_get_irq() and its ilk return IRQ0 while they
shouldn't? =)

> That code should be fixed first. Have you sent a patch?

   Which code?! You got me totally muddled. =)

> ...
> 
>>>>> -	if (!irq)
>>>>> -		return -EINVAL;
>>>>
>>>>    This is prermature -- let's wait till my patch that stops returning IRQ0 from
>>>> platform_get_irq() and friends gets merged....
>>>
>>> What patch?
>>
>>    https://marc.info/?l=linux-kernel&m=163623041902285
>>
>>> Does it fix platform_get_irq_optional()?
>>
>>    Of course! :-)
> 
> Can you share link to lore.kernel.org, please?
> It will make much easier to try and comment.

   I don't know how to uise it yet, and I'm a little busy with other IRQ0 issues ATM,
so I'm afraid you're on your own here...

MBR, Sergey
