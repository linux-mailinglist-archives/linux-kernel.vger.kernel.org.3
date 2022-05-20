Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3180F52F0E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiETQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351792AbiETQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:41:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222E3879C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:41:14 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h9so982pgl.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BuCtCZCdrJS/y+CQKpD70xnFhNxF3fjbwJKHoZ95Fdc=;
        b=tDxbB5ru3oVKGVtQsTDutHZHvxcRTacKjSv99gXw9CPhvIBlSTOeJiqcuLe1OhZAzm
         O5WcGIY1H8CCdUVPzwA8JVMpEkPKYAZKY2cyNlqH+WunBb/v1hgrCxDnuBC7VujAVVG2
         AiO0tdxIQ5yN9uc3jas4CBnj86ucfWD1uYYsvfbTic203nmEpKMtaSendz/7lPUdBuvg
         YcpxTfZMGB4aj6wUn7+qzJ97F7LJYIIBZOHoqNI0n/KqAsRFki0ezfLFLqTf55Td/YO7
         r+02TBv5nkt6yAUmDrYv9JBLrx5VFvb90yjOayTVZmwEbM2MmJ/06KHFYPm+MaGHbEBH
         021A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BuCtCZCdrJS/y+CQKpD70xnFhNxF3fjbwJKHoZ95Fdc=;
        b=yzmU9K91SySF5Eu5RP9mlViV6V/rKYNYpN7EMqO46QsPkVd0ML+cWWfcRtNOXvUzZd
         97agVgHWEfDJGdhdTtG876RIYi5DEjlRyvrk4KD3zWFi7E27AWXBsftdHpnBGjYDCOd/
         bUvRTmXWMkBR14gawWt9j8x2F0WlGO6j2qhDG8SiWnmfEbxM3uGy4J9854t2oQMBVBz/
         +svwM7+0+z9IpckhyKsmP+f6VQNWGB7yQ9GYzkdt7BZyELFqjAl0pmWz3Fox7a11Vz4C
         s4L+7/+hV6uYkFOlSatwL1h+yHSicek6yYEDDrqwwndjYvAQPWrCi2NQu0yV5VtAdcbL
         BmUA==
X-Gm-Message-State: AOAM531khbJgE8GvMhlcghd7jbfYJ8rvSEg9zDzUpXN8Uc3VXCvOrHvR
        KRRIZdJAmpZqsX0mXAHH1SXO9A==
X-Google-Smtp-Source: ABdhPJw0C/H1C2WUV3tvYr7ejA7I4W2/gCWNlTEOKvPsFSIbOJ3TGOMiwgH1F+Fd7avcEYC31IN5vA==
X-Received: by 2002:a63:115c:0:b0:3c6:cce3:8c12 with SMTP id 28-20020a63115c000000b003c6cce38c12mr9127106pgr.131.1653064874067;
        Fri, 20 May 2022 09:41:14 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u13-20020a63790d000000b003f6ba49bc57sm1725959pgc.71.2022.05.20.09.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 09:41:13 -0700 (PDT)
Message-ID: <247ac77e-15e0-8612-2507-7bbac80af824@kernel.dk>
Date:   Fri, 20 May 2022 10:41:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com> <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe4HP9iTA6l/For@zeniv-ca.linux.org.uk>
 <7e78d6a7-1cc3-2408-fe91-0329f5020e77@kernel.dk>
 <Yoe+lK8RIRbK6lDZ@zeniv-ca.linux.org.uk>
 <69bd18e6-d216-dfb3-201b-f6a285deb0e7@kernel.dk> <YofEU1ticqujwJdj@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YofEU1ticqujwJdj@zx2c4.com>
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

On 5/20/22 10:39 AM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 10:24:36AM -0600, Jens Axboe wrote:
>> On 5/20/22 10:15 AM, Al Viro wrote:
>>> IIRC, Linus' position at the time had been along the lines of
>>> "splice is not so good ABI anyway, so let's do it and fix up
>>> the places that do get real-world complaints once such appear".
>>> So /dev/urandom is one such place...
>>
>> That's what Christoph said too. Honestly that's a very odd way to
>> attempt to justify breakage like this, even if it is tempting to
>> facilitate the set_fs() removal. But then be honest about it and say
>> it like it is, rather than some hand wavy explanation that frankly
>> doesn't make any sense.
>>
>> The referenced change doesn't change the splice ABI at all, hence the
>> justification seems very random to me. It kept what we already have,
>> except we randomly break some use cases.
>  
> It looks like Al is right in the sense that Linus must certainly be
> aware of the breakage. He fixed tty in 9bb48c82aced ("tty: implement
> write_iter").

I don't think anyone is disputing that, but I also know that Linus wants
these fixed up as they are discovered. And I agree with him on that,
even if I disagree on the process to get there as it introduced
frivolous breakage...

> Anyway, it seems like the iter functions are the way forward, so this v4
> is queued up now (with a few minor cosmetic changes) and pushed to:
> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/
> I'll send an early 5.19 pull for everything either tonight or Sunday.
> And then next week I'll start on backports. (Though, 5.12 is a weird
> kernel version; I assume this is some Meta kernel that has its own
> backport team?)

Thanks!

> Meanwhile, hopefully Al can pick up the splice.c sendfile(2) chardev
> patch for 5.19, so at least there'll be some silver lining to the
> performance hit.

Let's hope so.

-- 
Jens Axboe

