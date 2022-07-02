Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8207F564297
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiGBTuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGBTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:50:04 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6492B86E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 12:50:03 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1o7j7y-0008Us-Dh
        for linux-kernel@vger.kernel.org; Sat, 02 Jul 2022 21:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/4] s390/cio: Rename bitmap_size() as idset_bitmap_size()
Date:   Sat, 2 Jul 2022 21:42:02 +0200
Message-ID: <62d3cfcd-a32e-59d1-c376-c95e8da1049f@wanadoo.fr>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <3f2ad7fb91948525f6c52e0d36ec223cd3049c88.1656785856.git.christophe.jaillet@wanadoo.fr>
 <YsCUW6vT7LlAv2UE@smile.fi.intel.com>
 <6063ee97-1bbe-2391-78cb-57572851a52c@wanadoo.fr>
 <YsCdSkzSbVz9gnci@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     kernel-janitors@vger.kernel.org, dm-devel@redhat.com
Content-Language: en-US
In-Reply-To: <YsCdSkzSbVz9gnci@smile.fi.intel.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/07/2022 à 21:32, Andy Shevchenko a écrit :
> On Sat, Jul 02, 2022 at 09:24:24PM +0200, Christophe JAILLET wrote:
>> Le 02/07/2022 à 20:54, Andy Shevchenko a écrit :
>>> On Sat, Jul 02, 2022 at 08:29:09PM +0200, Christophe JAILLET wrote:
> 
> ...
> 
>>>> -		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
>>>> +		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));
>>>
>>> Why not to use bitmap_zero()?
> 
> ...
> 
>>>> -	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
>>>> +	memset(set->bitmap, 0xff, idset_bitmap_size(set->num_ssid, set->num_id));
>>>
>>> Why not to use bitmap_fill() ?
> 
>> For this initial step, I wanted to keep changes as minimal as possible (i.e
>> just function renaming)
>>
>> In fact, I plan to send a follow-up patch on this file.
>> This would remove the newly renamed idset_bitmap_size() function, use the
>> bitmap API directly (as you pointed-out) with
>> "set->num_ssid * set->num_id" as size.
>>
>> It is already done this way in idset_is_empty(), so it would be more
>> consistent.
>>
>> If the serie needs a v2 (or if required), I can add an additional 5th patch
>> for it. Otherwise it will send separatly later.
> 
> If you use bitmap APIs as I suggested above as the first patch, the rest will
> have less unneeded churn, no?
> 
> 

Makes sense.

I'll wait for some other potential comments 1 day or 2 and send a v2 
with the simplification you propose as an initial step.

Thanks for your feed-back.

CJ

