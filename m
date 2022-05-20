Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9039652E0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbiETADB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiETAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:02:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B00D12AB34
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:02:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id bh5so6071346plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JRJGmCqk5tjloCFIjqv0r+VHMtvyHIc44tkIRahAkNw=;
        b=Utq4ThbmRd6RQqkA5cmIwmwu6VlAnDFD6J0xe8Af4MFqXAsjgH1XG51pA9oG7egUjF
         bTM9KAU1Sq+dbLAcL9gYqR/4KxIAqER1nXm69Fm7iugPuBRc5Ials37rYct2RHDs8Ld0
         suSFQE1xDBakouVfkI+sBjnwdMH/3ptTGHe0LxiHqG1cLcnx5NtLnmcUTauTTX0Od5LT
         oGqZbfACFos1SEbXDK4cxjE1utzK4Pc+1hQmpyty4rFIsXSmWu4G2Qru7bkGzjJv/aTH
         Wc3Jpdcc9dlx0pU+XFQ9rNiABHvMKRPHohUQk2RHMgwzBYDr/5sDv8iQwiEsYrtb2QyN
         lwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JRJGmCqk5tjloCFIjqv0r+VHMtvyHIc44tkIRahAkNw=;
        b=ROP1EAQ0K6XGMP0I6TdJ8YlqrWDtq1xxqmvSa4rR+5/Cq4kzhbCRPi23DPMy8opJhG
         z3R3VrpplAXWrvyxYv5vd/7Zc2rfUiqWkVdzRHbh0gwCZhOM42VhPUGdtPwV0Xffs/F8
         0yyQDyqvNT3LYXlqOjvIme6z7k1la7MixPCnvoLddVPcsg2JfYyjwiEdAilYylUxw/N0
         6zhW+JB18hye90gB/zgVHMnJ2Kf3Pdpcj6BhdhaSR712ItgIB4RkPN4H/BYg3kyg++lk
         LAUkKt6TMKJi+jQ7pCvOWrTgGkQmROON/prgNp8ZAtwRHVJWKSEAUSwgPZkcRHcZTB0h
         e5VQ==
X-Gm-Message-State: AOAM5329JfcXmTCaDLzJ3BoZge3jLB3PAlV+bh1+Yo69AfXd+1FojDz9
        15iHcUweCixs2vyxNi74vti0jQ==
X-Google-Smtp-Source: ABdhPJx9H3IVdAZZk26IPh4h1xYBABIV5nw2uiEKo/9tmw4Q+oCYeUoHRIWG+IzLjN7fViFaF6bo8A==
X-Received: by 2002:a17:90a:2e83:b0:1da:3273:53ab with SMTP id r3-20020a17090a2e8300b001da327353abmr8411071pjd.14.1653004976932;
        Thu, 19 May 2022 17:02:56 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b0015e8d4eb21dsm4459347plf.103.2022.05.19.17.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 17:02:56 -0700 (PDT)
Message-ID: <13899409-e81b-8689-3380-249de46c0b6f@kernel.dk>
Date:   Thu, 19 May 2022 18:02:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com> <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
 <YobPB27Ozl7uqUEu@zx2c4.com> <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
 <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
 <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
 <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
 <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
 <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
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

On 5/19/22 6:00 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 1:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 5/19/22 5:27 PM, Jason A. Donenfeld wrote:
>>> Hi Jens,
>>>
>>> On Fri, May 20, 2022 at 1:25 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>> I'll leave that to you :-)
>>>
>>> Alright, I'll have a look. Which one do I want here? This series adds
>>> splice_read/splice_write. The new thing would be sendpage? Or
>>> copy_file_range? Or something else?
>>
>> For copying kernel memory? It's really the same thing, you just
>> initialize the iter as an ITER_KVEC instead. The nice thing about the
>> iov_iter iterator that it then hides that for you, call the same copy
>> in/out helpers for it.
> 
> Err, maybe we're talking about different things? I was thinking about
> the plumbing to make splice/sendfile work on non-pipes.

Ah I see. sendfile() just uses splice() internally, so that'll work
(again) with my changes. splice(), by definition, either moves to and
from a pipe. Hence one of the fds must be a pipe. Does that answer the
question?

> get_random_bytes() itself doesn't need to become iovec'd, as that has
> no IO callers.

I was a little puzzled, but didn't look deeper and see if it would make
sense to do so.

-- 
Jens Axboe

