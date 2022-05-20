Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA53552EC96
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349533AbiETMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347387AbiETMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:49:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29B1668B0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:49:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso1528416pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L5PMblmmvoFAeFdsYsUFWHO7SIHwulVtXRKpa8zsMb4=;
        b=28tz65xXLtKpfh4aJ2vYSm3Ig9VveaDYnjyOkMc28CTA0q6pR5fjJK3ZQ5Umul/Sxr
         K2GrMhwmgXQEAFhhGRTqdbRyhUhC54ozVB9zM9Gb/xk1QtpT5PtxSepRDXre6UO/2cbb
         DWVYuyM2mDqeRlbxLHEFhgbLeL4yNxuJRCjoBbE/Eoqs04AlSqBTP/m9Z+U7KMf4wGXt
         fHQOr3tGUjin6oDbJzUlPtHdB7e+mI0decQedxHq9+OKcI4jwTy+zJf9odwt2FuFxFjd
         vk4w4/4mf3jOLlvF9qsZNSRhUkTnQn07nItty4zX4/8B/X5r4wVwibciDl+i7Posjlsj
         Awow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L5PMblmmvoFAeFdsYsUFWHO7SIHwulVtXRKpa8zsMb4=;
        b=6UUh6o9pdD1J+4K0ei2FI7b1q79snoj/Fxw+WRSVb9D8sOlfWNs5dL6TjdhuTmB6oj
         ilpyjrvXCdpZuwaIMWuRaitGxmkDSJjzSupptlsXjQUYeETLew/aIoTeYMJ+3OrTpK3x
         I2iLOtxcKuxjl6zphjYSKGVRhCIkijqNzEN5UcYP4g2ziLcoT53cIaesZsHAaOCmJJh9
         zH+OJhyDbqiUI/MXnhBtsMoND6vh/ETCnD5gLA+iuVqcKV+GADzB7RZLa14ARH7WNqOU
         JyrRK9yAi5EFk39MQ+q9s+CozKwRsQ4MX95RJxkk0Emry2z96u67u5yt+JVWvzDPplUp
         MNQA==
X-Gm-Message-State: AOAM532xdH4r9XisLlijiDAl6NRw9hIGsx6lKJUYbnMgAUQbg0NyPnWP
        qbyg5WyYO2kkHREuPPYn/A7WWBh1UsJipw==
X-Google-Smtp-Source: ABdhPJyQykJwg3rfKF87IWw+moG2G6VP1tO5mjGoc2XXzdpA5vDIApiSwil4Q+D5P6+gP/ie5hotjQ==
X-Received: by 2002:a17:903:186:b0:161:f394:3e75 with SMTP id z6-20020a170903018600b00161f3943e75mr2974469plg.113.1653050989176;
        Fri, 20 May 2022 05:49:49 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z7-20020a655a47000000b003c67e472338sm5437060pgs.42.2022.05.20.05.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:49:47 -0700 (PDT)
Message-ID: <110504dc-4720-1430-2e18-a7b6e3a12015@kernel.dk>
Date:   Fri, 20 May 2022 06:49:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
 <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
 <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
 <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
 <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
 <13899409-e81b-8689-3380-249de46c0b6f@kernel.dk> <YobldmDn6pU9mr4f@zx2c4.com>
 <84d073aa-9937-1a58-dd7a-b1828874c21a@kernel.dk> <YoboEokc00YACuha@zx2c4.com>
 <435cc499-7564-13e2-c4ef-a71119379cf0@kernel.dk> <YoeM6hP0JVqL9edj@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoeM6hP0JVqL9edj@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 6:43 AM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 07:10:56PM -0600, Jens Axboe wrote:
>> On 5/19/22 7:00 PM, Jason A. Donenfeld wrote:
>>> Hi Jens,
>>>
>>> On Thu, May 19, 2022 at 06:56:12PM -0600, Jens Axboe wrote:
>>>> On 5/19/22 6:48 PM, Jason A. Donenfeld wrote:
>>>>> sendfile() returns -EINVAL even with your patches. Only splicing to pipes
>>>>> seems to work.
>>>>
>>>> Huh, that really should work. Are you trying to sendfile() to random? If
>>>> so, you need that last write_iter patch too, and add the splice_write as
>>>> I mentioned.
>>>  
>>> No, I've only tried the read side so far. I made a little program:
>>>
>>> #include <sys/sendfile.h>
>>> #include <stdio.h>
>>>
>>> int main(int argc, char *argv[])
>>> {
>>>         ssize_t s = sendfile(1, 0, NULL, 0xffff);
>>>         fprintf(stderr, "ret: %zd\n", s);
>>>         return 0;
>>> }
>>>
>>> Then I ran `./a.out < /dev/urandom > /dev/null`. Fails. OTOH, if I
>>> replace /dev/urandom with an ordinary file, it succeeds.
>>
>> Here's why, it's limited to regular files or block devices:
>>
>> if (unlikely(!S_ISREG(i_mode) && !S_ISBLK(i_mode)))
>> 	return -EINVAL;
>>
>> in splice_direct_to_actor().
> 
> Indeed. Looks like that was your code from long long ago!

Yep I would not be surprised if that is the case!

> I posted
> https://lore.kernel.org/lkml/20220520095747.123748-1-Jason@zx2c4.com/ to
> fix it if you'd like to review.

Not in my inbox, but you also used an email that hasn't been valid in 16
years :-)

But looks fine to me, we can open this up to character devices, don't
see an issue with that.

-- 
Jens Axboe

