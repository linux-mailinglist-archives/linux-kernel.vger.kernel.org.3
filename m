Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D0D4D3DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiCIXpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiCIXpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:45:05 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7EDF9F8E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:44:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so6685684pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 15:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xZ5pk/v6FvmYcF2QqtDQr6YQCEUmF5T9mslVfxhX4lw=;
        b=1WIbvfAR2a/++7W/4IMTjpVpx4LGXGDFNJUsWx/AtHefzuwYB7Ii+WwpGuhQMBboCJ
         EBhHmMctx6uCu8JLmONtixIVpWY2QicyiWWkOZrHN4HZwVLR9jox+7AGmkJ7bpRDpKgh
         JR0lFjc/cdsAShHmi86Ci3WzC1BGJk1B0pLDJpIbBKPRpJFqlEIBPTA/ooSsYOeaDaqu
         hYnUT+Z7BfiKRquUJ2eETcX3ohj3ZVj/C91brxaCgPkd3dUcw9KdGRN4Q2s8amsMbNsN
         dxugJoK64vYc8ORt3+Wu/HobFYWIVNp2f4syKjy9A8b9B9MscelgKPHi/z90MyGjrSgn
         5mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xZ5pk/v6FvmYcF2QqtDQr6YQCEUmF5T9mslVfxhX4lw=;
        b=sqLi10gKGKQWZuX8NNf+L1OTgSFf5Yx3CKNoISpJdArTrhbkYIQR49GAGjoYkPJwbs
         80LmWU/LW1Df0/EZnM6kPcX2aWYWr6lPqQBqEhZzxpP5Y2xHKDvPC9NJ/5QEPsNKX2cY
         Pqjz6naXFvtlgIWZi6FTvTFa+bV7V9Gprjidb5YPd6CozHm37/C2BMMIMsGPntFN2Rp9
         k/avNF4l1H//iCdos4uOxP2ylIq/rkcJdrYOQTHrjCEhpYdXafqjyV4aWVkJ3PSNujC3
         tla9kC42EB9HTJgKTVwTn8or9JdmNVOyKmusSWjGS0ptgd2AcflrJ6u1t22lxCjLXzRu
         orow==
X-Gm-Message-State: AOAM531FtzhQA7d4mUhm8XCbmZ7YtlQDzYxMwwMgfWftih6Y/bqDwR6q
        sslWsZnuUymYuk9Xfl2NrED7Hw==
X-Google-Smtp-Source: ABdhPJyNpn/jtIzIqkD+JWHBSxj97tNEmql3hwlNlKuZ1KJAAdvaWBVvrzNmqXb6CG5q7048gKxcTQ==
X-Received: by 2002:a17:90b:3910:b0:1bf:2972:ccea with SMTP id ob16-20020a17090b391000b001bf2972cceamr12778860pjb.221.1646869445175;
        Wed, 09 Mar 2022 15:44:05 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a133-20020a621a8b000000b004f6a79008ddsm4370365pfa.45.2022.03.09.15.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 15:44:04 -0800 (PST)
Message-ID: <cde6d338-880b-57c7-d9e5-86d117647e8d@kernel.dk>
Date:   Wed, 9 Mar 2022 16:44:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/2] io_uring: Add support for napi_busy_poll
Content-Language: en-US
To:     Olivier Langlois <olivier@trillion01.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Hao Xu <haoxu@linux.alibaba.com>,
        io-uring <io-uring@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <cover.1646777484.git.olivier@trillion01.com>
 <612546a3-5630-f1d4-f455-ef2bf564c83e@kernel.dk>
 <b0b2c07eb3b7acad02159e0db145a5b4e825b026.camel@trillion01.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b0b2c07eb3b7acad02159e0db145a5b4e825b026.camel@trillion01.com>
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

On 3/8/22 10:47 PM, Olivier Langlois wrote:
> On Tue, 2022-03-08 at 17:54 -0700, Jens Axboe wrote:
>> On 3/8/22 3:17 PM, Olivier Langlois wrote:
>>> The sqpoll thread can be used for performing the napi busy poll in
>>> a
>>> similar way that it does io polling for file systems supporting
>>> direct
>>> access bypassing the page cache.
>>>
>>> The other way that io_uring can be used for napi busy poll is by
>>> calling io_uring_enter() to get events.
>>>
>>> If the user specify a timeout value, it is distributed between
>>> polling
>>> and sleeping by using the systemwide setting
>>> /proc/sys/net/core/busy_poll.
>>
>> I think we should get this queued up, but it doesn't apply to
>> for-5.18/io_uring at all. I can fix it up, but just curious what you
>> tested against?
>>
> Hi Jens,
> 
> I did wrote the patch from
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> My testing systems are based on 5.16. I have backported the patch and
> compiled 5.16.12 with the patch for my testing.
> 
> sorry if I didn't use the right repo...

Generally, since the patch is for 5.18, you'd want to base it on my
for-5.18/io_uring branch as then it would apply on top of what is
already pending. But I'll see if I can shoe horn it, unfortunately we'll
hit a merge error but it'll be minor.

-- 
Jens Axboe

