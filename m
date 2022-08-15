Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D096592770
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiHOB31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiHOB3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01F12AB0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:29:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 202so5409471pgc.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8+Ahz4a38eyA6zKB+vX/n3Ll4/c5qNBLImKNH5sxUnk=;
        b=nOX7+RXgDJikE6rbbxDpJ2ZZkhLD3THiAiiamFJ8nBrCdHI6SLi+7zHWy2HzsjiT5d
         +0Sd0SF4GpYwq5weQH5m6+tbHQoJC0avMDr3aY9I48HPQxOOM+yM1EIp8g0O6m5B6qQz
         NqWJX4yR4rsh9FUZwjS6pg3IRg8HWtdmtbxAmuN1qHsRMvMvZ4W4WcuBDA3kNqn96FWr
         8SNZCODYlNsNaKj1pAWhlQKC/ES0Rvk5e4FITnNszlGbsqQ2VVBjPXp+/pJ3QcOKmd9h
         Z88kKpgVyW5FT5zfFp+GeD0GaFN61sifoXNdQ6LKHey5BHQz+6e+bjecbIJDF1gPxN5B
         X9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8+Ahz4a38eyA6zKB+vX/n3Ll4/c5qNBLImKNH5sxUnk=;
        b=JKUwx9Dn8gVaoGlKYrJLPWeVrFyDVZsbfiHY3HNSfqSJW8zw442shORFpJxklO5m7W
         uLTs9RMGhQSZAnyY4pus+5a3zCwTNuBo6sAs2ZFThmYw0x0gmKNbflUcu9SqfhyvYtWr
         RAq52UdQ0ReadXajptenvQmKEprK0WNBOO/wbRgrM5i4cIQIGTBSQEBBqBVhdKmMr90x
         bexF39ShW3zrKFRzd4PZMb+2J8EbhS7/Ke/zLku/gtVqw9ygZxmhKHQ4lz4dQhe9I6au
         I8FIZ6U4QYhlAKgyEQQO2NRtynwENEUxZF+8CCN0O9Y3S+kPPnlSwRL4d4+kLnKqz304
         T0kw==
X-Gm-Message-State: ACgBeo2HcQTsOGwhBCRPqjfqqs68bTeaV5onyA5VqiSahfQ3K6JZrOuN
        d/rtfk5Ps2rfL2nvixIxZFJA3g==
X-Google-Smtp-Source: AA6agR6pvCdihGdBr6+HtpYskubsqSV8lC6FWJCAMZmcC3jhQnBiNFb7VGXMY8VZBDSwm8h1APrADQ==
X-Received: by 2002:a05:6a00:14c7:b0:52e:efb7:bd05 with SMTP id w7-20020a056a0014c700b0052eefb7bd05mr13953078pfu.24.1660526960364;
        Sun, 14 Aug 2022 18:29:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y22-20020a656c16000000b00427a59b78ecsm2144608pgu.23.2022.08.14.18.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 18:29:19 -0700 (PDT)
Message-ID: <c83dda59-b7aa-ac0f-cd32-d8c3c3940213@kernel.dk>
Date:   Sun, 14 Aug 2022 19:29:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: upstream kernel crashes
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andres Freund <andres@anarazel.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <20220815011718.GA3694888@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220815011718.GA3694888@roeck-us.net>
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

On 8/14/22 7:17 PM, Guenter Roeck wrote:
> On Sun, Aug 14, 2022 at 03:47:44PM -0700, Linus Torvalds wrote:
>> On Sun, Aug 14, 2022 at 3:37 PM Andres Freund <andres@anarazel.de> wrote:
>>>
>>> That range had different symptoms, I think (networking not working, but not
>>> oopsing). I hit similar issues when tried to reproduce the issue
>>> interactively, to produce more details, and unwisely did git pull instead of
>>> checking out the precise revision, ending up with aea23e7c464b. That's when
>>> symptoms look similar to the above.  So it'd be 69dac8e431af..aea23e7c464b
>>> that I'd be more suspicious off in the context of this thread.
>>
>> Ok.
>>
>>> Which would make me look at the following first:
>>> e140f731f980 Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
>>> abe7a481aac9 Merge tag 'block-6.0-2022-08-12' of git://git.kernel.dk/linux-block
>>> 1da8cf961bb1 Merge tag 'io_uring-6.0-2022-08-13' of git://git.kernel.dk/linux-block
>>
>> All right, that maks sense.The reported oopses seem to be about block
>> requests. Some of them were scsi in particular.
>>
>> Let's bring in Jens and the SCSI people. Maybe that host reference
>> counting? There's quite a lot of "move freeing around" in that late
>> scsi pull, even if it was touted as "mostly small bug fixes and
>> trivial updates".
>>
> 
> I may be wrong, but I don't think it is SCSI. The crashes are all over the
> place. Here is another one that just came in. I can dig up more tomorrow.

I guess it could be generic, I was mostly reacting to the three pull
requests listed. I haven't seen this on any of my test boxes, but I
guess it could depend on the configured kernel options.

-- 
Jens Axboe

