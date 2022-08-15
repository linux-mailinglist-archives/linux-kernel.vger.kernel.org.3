Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC9592758
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiHOBE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiHOBE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:04:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37546DFE1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:04:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a8so5725393pjg.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fG3uklqi9M+RAdE2cQmiR2AOv3P9kHtvMDCz33a0pts=;
        b=Hho2blZNzpafx4xGlukj5NhskZg5OjU0+/iS2MFX1IboO3/GCdQeTwkww6tYOu71GE
         6Ctmn9R5pcXym8826eOckhhum7ZopnaSWTF3IN6qqI5YO1v5UHkPU9VflvM99vKT5wzo
         YF7FxoFfARX03uD+vc7EkFR890u+BUl2Xf4HhftMkfdmlzPD11ENFtmMgZWPjNuCLXkz
         YIMDagzRJkGh5hFDN3GK7iy8q5AQGHXSSJOXB1yXwynSeyruk+bpg+KeG6VBF8DQ0oPD
         ir96qkFeKvpyU2aBGzeHZAMv0glwb4Gz29wuQCqR5k4N9bS6wDf0+mkGMdijVDoUFylz
         3skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fG3uklqi9M+RAdE2cQmiR2AOv3P9kHtvMDCz33a0pts=;
        b=ZsY5vRJ4AUo0rG21RFVjWt8CwXEfYZ6j+TVxsEPXllGLBjPfzA61ckUb8bVqH3afc7
         dq0p82o8zgXzbK46ULwAdBIh9OyUrIasCtuaWWVj6loTPQK3rlAD3f6zahVa/CDD6lF1
         Tz2NVaJxRVM4zPCWr/KXv4ur+VSMWA4sOA0b5u4b4nc+gTYdTolkDsA2Wbw4zQr6pGsa
         LfQGwMxvgJOerwGlKADEx/p8BVlLuRvPIxL+UyYaSPvujA5eulME2XE3Wa4V/6oGGzm7
         V9FYFJdEp1zTF7Udsf2ub7SBE2+i0TPnNx1RLrBBKK+ZR0F4lE50iTnUuU6AVP/phWI4
         lMaA==
X-Gm-Message-State: ACgBeo32iCFA9mv+QY77vHkNL7pe3KYzAsO2BwnMSq7K38oVDb0zUefd
        GGcA0myoDaZcbja/9saOKTh56Q==
X-Google-Smtp-Source: AA6agR4XYlmLCRV4gxutH/sEqV7bQ2otU/wmbVqa6PTkW3/LnYb460CqqHSfiyVx/mjJ6G58El/QMg==
X-Received: by 2002:a17:902:d4c4:b0:170:9fdb:4a2a with SMTP id o4-20020a170902d4c400b001709fdb4a2amr14047936plg.137.1660525464591;
        Sun, 14 Aug 2022 18:04:24 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902650600b0016397da033csm5933924plk.62.2022.08.14.18.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 18:04:23 -0700 (PDT)
Message-ID: <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
Date:   Sun, 14 Aug 2022 19:04:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: upstream kernel crashes
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andres Freund <andres@anarazel.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/22 4:47 PM, Linus Torvalds wrote:
> On Sun, Aug 14, 2022 at 3:37 PM Andres Freund <andres@anarazel.de> wrote:
>>
>> That range had different symptoms, I think (networking not working, but not
>> oopsing). I hit similar issues when tried to reproduce the issue
>> interactively, to produce more details, and unwisely did git pull instead of
>> checking out the precise revision, ending up with aea23e7c464b. That's when
>> symptoms look similar to the above.  So it'd be 69dac8e431af..aea23e7c464b
>> that I'd be more suspicious off in the context of this thread.
> 
> Ok.
> 
>> Which would make me look at the following first:
>> e140f731f980 Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
>> abe7a481aac9 Merge tag 'block-6.0-2022-08-12' of git://git.kernel.dk/linux-block
>> 1da8cf961bb1 Merge tag 'io_uring-6.0-2022-08-13' of git://git.kernel.dk/linux-block
> 
> All right, that maks sense.The reported oopses seem to be about block
> requests. Some of them were scsi in particular.
> 
> Let's bring in Jens and the SCSI people. Maybe that host reference
> counting? There's quite a lot of "move freeing around" in that late
> scsi pull, even if it was touted as "mostly small bug fixes and
> trivial updates".
> 
> Here's the two threads:
> 
>   https://lore.kernel.org/all/20220814212610.GA3690074@roeck-us.net/
>   https://lore.kernel.org/all/20220814043906.xkmhmnp23bqjzz4s@awork3.anarazel.de/
> 
> but I guess I'll do an -rc1 regardless of this, because I need to
> close the merge window.

I took a quick look and added more SCSI bits to my vm images, but
haven't been able to hit it. But if this is happening after the above
mentioned merges, does seem like it's more SCSI related. The block side
is only really an error handling fix on that front, the rest is just
nvme. Seems unlikely that'd be the culprit.

Sounds like Andres is already bisecting this, so I guess we'll be wiser
soon enough.

-- 
Jens Axboe

