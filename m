Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6A46F4F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhLIUfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:35:31 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:48156 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhLIUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:35:29 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 0A74D20AB94D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
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
 <YbJXjmsDJWlr3xpB@smile.fi.intel.com> <YbJYr7jg162RVP12@smile.fi.intel.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <fbc6f255-09e8-49be-8656-fac20968854c@omp.ru>
Date:   Thu, 9 Dec 2021 23:31:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YbJYr7jg162RVP12@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:27 PM, Andy Shevchenko wrote:

[...]
>>>> Does it fix platform_get_irq_optional()?
>>>
>>>    Of course! :-)
>>
>> Can you share link to lore.kernel.org, please?
>> It will make much easier to try and comment.
> 
> For the record it does not fix platform_get_irq_optional() AFAICS.

   Again, why? My only issue is stoppping to return IRQ0 --- which it does. :-)

> Have you read the discussion:
> https://lore.kernel.org/lkml/20210331144526.19439-1-andriy.shevchenko@linux.intel.com/T/#u
> ?

  Yes, I have. I just don't care about it much... :-)

MBR, Sergey
