Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A864F6BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiDFUx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiDFUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:52:40 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DC93D1031
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:08:53 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 125so4104319iov.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=me+fcgRSm8+g0b6jcT9D2oZ2E2KRY2O76WiEXkXSbms=;
        b=o/FsVnDPL+0anaOigwidAaEH7TK8DP4aDi5UM6zbDbj6nwSVImMCDNcEqosv+5Lcao
         5XUBQjFBjZfdeChfMlaimrhGHm8KN9h9SreKhw/5JIgf54/0Hay3urZe3WAWVZtheSSK
         fSNu4pMXo05i6w/P33JQ63FTpS8k4xm5yMvY/+f8hFU8MufJ7Fr+u13qHCrBcnMiHxqu
         uKWOjOGgNWyQb606eQDCXz2Ekzk8MASU2THvn4pJYpzQ/JOzT+sYkeMDm8J5tiiwVPp2
         yduwXRyzIX1ddqPZEbe/QplDUaO4bfajnfDGBOw7FULQ56h5j/5cXQx3suuWKNYrN41p
         LRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=me+fcgRSm8+g0b6jcT9D2oZ2E2KRY2O76WiEXkXSbms=;
        b=XCWosLB2nc3Q97wBC6uZXhgYVEKTP3yAqrbnV1wIuJUUkAoSAhucRRVh0AODQVseB5
         PA7ONsRozs4+cTWzWguz5KDBZGXdv/jKUOK9Nv2Ju+0exSgFcGS2KFreM5IPRFxH2yrB
         dYiKdVe48FBS7JHwPcikRGSn9o67KD0pRyMeSA54KJn3gm0SpOrH/9uNG/Q1QpmzzTUq
         xk7CtTX1+otm8x+V15sTaMoHNE9dYYqmpr9tiPXOL47aO/B1h6P9J9NJb99XA9hPy3XN
         g8+oLNxix5utrQtXnAirRcdx8fIJanYdxvF9l3Cq6dNcrRDvuDx6esaYafoNLbnsWLpa
         avog==
X-Gm-Message-State: AOAM532OShnmHRwMNpFd+MzL0JntAZ3ULLW1jmikGwBpIYjnJFm4BFo7
        9yarXY65Kg8CwNo4vUTPd5cp2g==
X-Google-Smtp-Source: ABdhPJy534Xn0E7r2znTIqgGP9rj9pXvn5paA6sEmwZ7O+wcPbxsMfE4jUoQg48dt+07p0yfczbwqw==
X-Received: by 2002:a02:c9d0:0:b0:323:6e14:8da3 with SMTP id c16-20020a02c9d0000000b003236e148da3mr4977251jap.196.1649272132776;
        Wed, 06 Apr 2022 12:08:52 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o15-20020a6bcf0f000000b00649c4056879sm10908279ioa.50.2022.04.06.12.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 12:08:52 -0700 (PDT)
Message-ID: <9b6492fd-8367-a9f7-b2c4-1d8853cb7a77@kernel.dk>
Date:   Wed, 6 Apr 2022 13:08:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/3] DRBD fixes for Linux 5.18
Content-Language: en-US
To:     =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org
References: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 1:04 PM, Christoph Böhmwalder wrote:
> Assortment of more relevant fixes for DRBD to go into 5.18.
> 
> Christoph Böhmwalder (1):
>   drbd: set QUEUE_FLAG_STABLE_WRITES
> 
> Lv Yunlong (1):
>   drbd: Fix five use after free bugs in get_initial_state
> 
> Xiaomeng Tong (1):
>   drbd: fix an invalid memory access caused by incorrect use of list
>     iterator
> 
>  drivers/block/drbd/drbd_int.h          |  8 ++---
>  drivers/block/drbd/drbd_main.c         |  7 ++---
>  drivers/block/drbd/drbd_nl.c           | 41 ++++++++++++++++----------
>  drivers/block/drbd/drbd_state.c        | 18 +++++------
>  drivers/block/drbd/drbd_state_change.h |  8 ++---
>  5 files changed, 45 insertions(+), 37 deletions(-)

Applied, thanks.

-- 
Jens Axboe

