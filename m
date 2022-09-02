Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAD5AADE0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiIBLtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIBLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:49:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22EB02B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:49:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j5so1626692plj.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NlpVgVfz2RRSAymMEXdJiA8fExyAOwW23DsSaRbFVaU=;
        b=VvDrt6aY+ohqukXqy3IvxuNh9f/PPX0M6hcBJsHOnw4mXHpmKj3CxvtvJPfbVB6xQ9
         zwrnfizVkODRbBPMGlgekA2CAVufS6C29zPlOtBu66RXHpFrUPMKH8XQvq0pNROTifMF
         8lVs0PKsbATWJa8fS5OZO8ux3Ss4i7WKlxZHUyBoWMfyOu/dRilhq6OZKOSD3T4rJy+L
         +dCjDyAzoEm1OdwFcDhltj/7GrmSi409vfKtFWWS8lYwReEV5kU3jrO/Lik1onrDWYTM
         MzBQyfPxaj6+n0BE+UxJtNET3AQr9O4ei1Se+RCYwRHiEJlekFv2JwmG5ZjHqqQ7TWYh
         0KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NlpVgVfz2RRSAymMEXdJiA8fExyAOwW23DsSaRbFVaU=;
        b=rNVqwm7rHZ2EePDxnsKIyibjGktB/jPBEDGdQR/DA1/dpFj8JqWLJlzpBAu0e+nf9j
         neDI37U+wtNyO6vLw8HJqEw4v9O9zTeuLINgpe/iIlUS5GC6XcoRtFg0KMK3Hj7IYcnO
         GPcN19gLNVGXMzGjbjOzHLBTVmr2gkS2RncNdwrMvcy8W3Z0XJXu6yMXzhC+9aF6eAQD
         Pxrs4WkXoUQvZWulCyGAwfikcD7+oYQTIJpKqoDqAUh8bbebGlXPAGnhSs62aeU3Y/Ny
         XX8yTKXAHY8Y3G7u6f4U9t4Wzi6N+WORmakcSTrbX88GwzAmjYrcaXNpo0tEp7tK6YX6
         Dqlw==
X-Gm-Message-State: ACgBeo3MpwwgbtKQEf7DNN3QtapBiACLZC/sxrVloGzMok3ScGafyh9o
        uYqZJAG1IlEBEOLAtBwfioIKE9sLGYTDbA==
X-Google-Smtp-Source: AA6agR714K7qNz523bKI8efTp1dD3S0Mp2JLN56ADUf/Be+iEfcIrUoU7kcxsNt+r7VCxoIzyl1GEw==
X-Received: by 2002:a17:902:d58b:b0:174:b336:bf0c with SMTP id k11-20020a170902d58b00b00174b336bf0cmr24431229plh.29.1662119345723;
        Fri, 02 Sep 2022 04:49:05 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v123-20020a622f81000000b0052d4afc4302sm1594767pfv.175.2022.09.02.04.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 04:49:05 -0700 (PDT)
Message-ID: <ae675a01-90e6-4af1-6c43-660b3a6c7b72@kernel.dk>
Date:   Fri, 2 Sep 2022 05:49:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: linux-next: manual merge of the mm tree with the block tree
To:     John Hubbard <jhubbard@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220901161722.739d2013@canb.auug.org.au>
 <1a6632f1-5e23-5fb3-1af2-6d653e4338d4@nvidia.com>
 <f80623f2-7c19-c121-6eff-f5bb4f1cfc48@kernel.dk>
 <87d96d36-fd13-2268-122b-fea806090942@nvidia.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87d96d36-fd13-2268-122b-fea806090942@nvidia.com>
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

On 9/2/22 1:02 AM, John Hubbard wrote:
> On 9/1/22 07:10, Jens Axboe wrote:
>>> So I see two obvious solutions. Either:
>>>
>>> a) Only do the first two patches for now, and leave them in Andrew's
>>> tree. After the next release, do the remaining 5 patches via the block
>>> tree, or
>>>
>>> b) Move the whole series to the block tree now, or
>>>
>>> c) something else?
>>>
>>> Andrew, Jens, any preference here? 
>>
>> Would've been cleaner to take through the block tree given what
>> it touches, imho. Or at least base on that, so we'd avoid frivolous
>> conflicts like this.
>>
> 
> OK, so I'm new to block, and my first guess at the right git tree
> and branch:
> 
>     git://git.kernel.dk/linux-block block-6.0
> 
>  doesn't seem to contain this one:
> 
>     e88811bc43b9 ("block: use on-stack page vec for <= UIO_FASTIOV")
> 
> Can you point me to the right tree please?

That's because block-6.0 contains fixes for 6.0, it's not a 6.1 tree.
for-6.1/block is the pending 6.1 items, and for-next contains all my
branches merged for linux-next consumption.

> Once I know the right block tree to use, I could post the next version
> rebased on top of that. And plan to send it up through Jens' block tree,
> assuming that it continues to survive the reviews, that is.
> 
> Andrew, is that OK with you? The first two patches will still get
> reviewed by mm, and they shouldn't conflict with mm, even if they
> go up through the block tree.

We can just make it a separate topic branch too, I often do that for
various items that are separate in nature and has overlap.

-- 
Jens Axboe
