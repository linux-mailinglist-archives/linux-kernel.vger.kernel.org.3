Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3965552E0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbiESX5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiESX5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:57:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C597983A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:57:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id j21so6154398pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GEyJce2Ip6tDV4r1iYi7wVUAyIxnQ59RJ/nhlICsEeM=;
        b=KVzYt38jc/NGdkdZCETpP/3XXeJ8kUTHKVU7U65GDXCG2K5e2gUeNy5GfKBoWrT9ps
         txrcpbHWxjq50uz8qhzQRaSwDRzXUtZXExIljD0zVeBmvkZP1t3ssnpjp7lBgvok4Y+B
         MLu02w6TlXYFxtC8PlQCBu1FQTX+JyYl8uW8vdQ6S2IdEDknU62/JZdEAvmUbq0IhnS0
         4SHDz7ZdnufaQlAh3Y+ZGleBwCSNA931/pAxjsTogIsGp+soBv4z6G43aZ3ThpWqBzcq
         dQdqnGgVv6Ap5VCpaE4HV0jcR+afMllOUfxqMVHKx6f0sHRqqUJ026EaI10KS3ZbMO7P
         4sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GEyJce2Ip6tDV4r1iYi7wVUAyIxnQ59RJ/nhlICsEeM=;
        b=2rXpH8P/GZAvSDjF5oaxp6RE1Gy3etdTNgLmBtJxgzeVIFDLmh3RH/odPAlGiWHCrb
         uORxQsTXfKEG+qNe5DKtTeF3SOEFKLHssq1hjNrK0mmpyasyunlA9DWo5ro5d0lHhOzF
         1h+RCMCkRxmSfmSz9lsMiAGcsJitDZLZLidpZojzYWHk9Mcf19xWMTBKTHY/W30eggKK
         /F+3sc19VTrvZpF6V6Z3jq5fCENP1DED9ua5glgZ7vkAJ6PpGKyM+/sbtuTB2bMKlWHL
         8u0O+haI0LnM4Y+I4qBokYcYqSy67u1+DRn3rqoY2Xnao7Nmj3kq2HqoDz7mJQwNNMYP
         8/rQ==
X-Gm-Message-State: AOAM533tBskfbscuBEe5fD++S3W7AK2rGGUyQvCwGaYsbm96gC5EQ4xl
        68VzWy7ZtksG5y3fZNzJlGJ5Zg==
X-Google-Smtp-Source: ABdhPJw9eZnzyF13Q2UgBAbAW048ZmkJuMW0HKSskD6+DUxqhnFGavVw8vNCl8VkEIX7yGnaa7NpkQ==
X-Received: by 2002:a63:1645:0:b0:3c5:f0c2:b9c with SMTP id 5-20020a631645000000b003c5f0c20b9cmr5844062pgw.484.1653004625764;
        Thu, 19 May 2022 16:57:05 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db0600b0015e8d4eb292sm4337021plx.220.2022.05.19.16.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:57:05 -0700 (PDT)
Message-ID: <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
Date:   Thu, 19 May 2022 17:57:04 -0600
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
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

On 5/19/22 5:27 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 1:25 AM Jens Axboe <axboe@kernel.dk> wrote:
>> I'll leave that to you :-)
> 
> Alright, I'll have a look. Which one do I want here? This series adds
> splice_read/splice_write. The new thing would be sendpage? Or
> copy_file_range? Or something else?

For copying kernel memory? It's really the same thing, you just
initialize the iter as an ITER_KVEC instead. The nice thing about the
iov_iter iterator that it then hides that for you, call the same copy
in/out helpers for it.

-- 
Jens Axboe

