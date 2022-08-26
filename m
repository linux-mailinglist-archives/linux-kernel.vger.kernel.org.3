Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9AC5A26CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbiHZLYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiHZLX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:23:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B32DAEE5;
        Fri, 26 Aug 2022 04:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99EAB61ABC;
        Fri, 26 Aug 2022 11:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4517CC433D6;
        Fri, 26 Aug 2022 11:23:56 +0000 (UTC)
Message-ID: <a4fbbf75-7fad-3124-6d42-21749b507115@xs4all.nl>
Date:   Fri, 26 Aug 2022 13:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] media: i2c: Fix repeated word in comments
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Jules Maselbas <jmaselbas@kalray.eu>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20220826100052.22945-22-jmaselbas@kalray.eu>
 <20220826102447.kpwpj2n5mta4k3xi@uno.localdomain>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220826102447.kpwpj2n5mta4k3xi@uno.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm rejecting these patches in patchwork. All (or almost all) are duplicates.

Regards,

	Hans

On 8/26/22 12:24, Jacopo Mondi wrote:
> Hi Jules
> 
>   thanks, but as reported in patchwork and lore
> https://patchwork.linuxtv.org/project/linux-media/list/?series=&submitter=&state=*&q=mt9v111&archive=both&delegate=
> https://lore.kernel.org/all/20220824135433.h2udwtnub7mlmtam@uno.localdomain/
> 
> This is the 4th patch to fix the same repeated word in a comment.
> 
> As I asked to Jilin, are you submitting this as part of a new
> contributor program ?
> 
> Thanks
>    j
> 
> On Fri, Aug 26, 2022 at 12:00:50PM +0200, Jules Maselbas wrote:
>> Remove redundant word `the`.
>>
>> CC: Jacopo Mondi <jacopo@jmondi.org>
>> CC: linux-media@vger.kernel.org
>> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
>> ---
>>  drivers/media/i2c/mt9v111.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
>> index 2dc4a0f24ce8..7beca0b70b72 100644
>> --- a/drivers/media/i2c/mt9v111.c
>> +++ b/drivers/media/i2c/mt9v111.c
>> @@ -633,7 +633,7 @@ static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
>>
>>  	/*
>>  	 * Set pixel integration time to the whole frame time.
>> -	 * This value controls the the shutter delay when running with AE
>> +	 * This value controls the shutter delay when running with AE
>>  	 * disabled. If longer than frame time, it affects the output
>>  	 * frame rate.
>>  	 */
>> --
>> 2.17.1
>>
