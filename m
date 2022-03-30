Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E264ECDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350951AbiC3UX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiC3UXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:23:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CBE3BBD9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:21:38 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k25so26153017iok.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4qH3sjnyZ0sZu4IU936XgcnySyKMmLOeeiMCINTicno=;
        b=ZJ+jUXzm23avbF4K9SMxVMSicBNjPYuCYIOA/vgGY7WcSGsJmLUM1ErMcEtaeIqcv2
         5PmOQQlBL8qzz8DbV5/asR0cLg/3usp6ksXP577st28dW3h7SBsNIq+vGM4/nYGH8it0
         zL1k7aFl+eIzbY3dTkkPFhg5YzRjNGvcKUoI5M7oMzowN22RQU+WhikR92H9JGIEn70t
         B7w4iP61DZeYtxEg1oHF3lT6Iir4HpuolHxffRhYmYEbDRG1kl6fI2ONcslYOiXS451N
         YRiIVOjligELpykhgcE05vEvBVNbwEM6j4d50Kx9I2z9kYSlVqU7b0pOma+LAgGVvEqf
         o7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4qH3sjnyZ0sZu4IU936XgcnySyKMmLOeeiMCINTicno=;
        b=40A1GDEZu3mlScH2GQNWSJjpMj4KwbB/gAJFfMwudehRo7Mw/Z+aMQC+BvBCkrn9Ye
         6nAuM0Eo5N7bEF5DAzKJA6rjEr9YvCp9IihDMp49KccJcNWHBfqjAAUY7uhg/ql4kNOj
         hY2QkbvTGJ83Uxb4nm0GxPTj8fq0hDCqMOF4gklePE2vCNeXhMN5ncRmxa+3OPS24bYm
         tY9P9APszCztsDAVdd8WSk2CsvENqQdxT3d5lb8jQRQh83BqbkFRZnsNS2+UsK1bBbcr
         E3UXyiOejpqumscvw89a7BbbcdXY8a0Z0yXjjyD3sALMu8HOBi90Vz7WR+sPGpW4mVwG
         TvFA==
X-Gm-Message-State: AOAM530TBcwm+dixSwKkKaPs1qSAkDzBLBl8l3h75CIrgBleOyfOcd/m
        xKwLsXcQ4nHuhMkphw2W9GY9gQ==
X-Google-Smtp-Source: ABdhPJxiHd4wWA49qUn6yTSxex2CITvWAs8MaDikj6dKgx6kY3gZ6gIFiWxA3BuSpcV+jcVERuHs8w==
X-Received: by 2002:a05:6638:25c4:b0:323:a5ba:e1a2 with SMTP id u4-20020a05663825c400b00323a5bae1a2mr324273jat.135.1648671697776;
        Wed, 30 Mar 2022 13:21:37 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b12-20020a6be70c000000b00648f61d9652sm11510617ioh.52.2022.03.30.13.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 13:21:37 -0700 (PDT)
Message-ID: <a5fbb7f3-8b0a-eef9-6479-dedc9fc6a425@kernel.dk>
Date:   Wed, 30 Mar 2022 14:21:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Drbd-dev] state of drbd in mainline
Content-Language: en-US
To:     "Kiselev, Oleg" <okiselev@amazon.com>,
        Philipp Reisner <philipp.reisner@linbit.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "Smith, Stewart" <trawets@amazon.com>
References: <20220329070618.GA20396@lst.de>
 <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de>
 <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
 <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
 <CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
 <3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
 <CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
 <7AD2D6DC-0609-42F9-A481-B6E5C0F58180@amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7AD2D6DC-0609-42F9-A481-B6E5C0F58180@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 1:31 PM, Kiselev, Oleg wrote:
> AWS RDS is a major user of drbd.  We are probably responsible for the
> substantial percentage of drbd users in the world.  We are currently
> on drbd-8.4.  We will eventually migrate to drbd-9, but at our scale
> this isn't going to happen very soon.  
> 
> The last time we needed to patch drbd was back in 2018.  We've not
> diagnosed any reportable issues with drbd-8.4 in the past ~4 years.
> It's a stable, mature driver.   We would prefer for drbd-8 to continue
> being available in the upstream tree.  We'd also welcome drbd-9 being
> available in-tree as soon as possible: it will make life much easier
> for other AWS teams that are currently working on DRBD deployment.

Thanks for the info, that's useful and good to know. My objection was as
much about ignoring patches that are sent for drbd, I don't recall
seeing any replies to those kinds of emails in the last 3-4 years. Part
of maintaining an in-tree driver is also dealing with those in a
reasonable amount of time, and ensuring that they make it upstream. And
the one bug fix that does look important was just sent upstream only
because of this discussion, and that's been lingering for a year it
seems.

Roughly ordered by date:

https://lore.kernel.org/all/20220327070918.8465-1-xiam0nd.tong@gmail.com/
https://lore.kernel.org/all/1648436049-4335-1-git-send-email-baihaowen@meizu.com/
https://lore.kernel.org/all/YbpERiPKO4ufe1hf@pc638.lan/
https://lore.kernel.org/all/20211213223331.135412-11-keescook@chromium.org/
[PATCH 0/2] drbd: Make use of PFN_UP helper macro (only on drbd list)
https://lore.kernel.org/all/20210525065925.3978-1-lyl2019@mail.ustc.edu.cn/
https://lore.kernel.org/all/1619774456-116567-1-git-send-email-jiapeng.chong@linux.alibaba.com/
https://lore.kernel.org/all/20210426163032.3454129-1-christoph.boehmwalder@linbit.com/ (the referenced patch)
https://lore.kernel.org/all/20210402070713.4069-1-lyl2019@mail.ustc.edu.cn/ (use after free, security issue?)
https://lore.kernel.org/all/20201026215043.3893318-1-arnd@kernel.org/

This is just going back a bit, by no means an exhaustive list. Looking back
to 2016-2017 and I see zero replies in emails like the above, not one.
Everybody misses patches here and there, that's common. What isn't common
is blatantly ignoring everything for, what, 5 years?

I'm not here to babysit unmaintained drivers. linbit need to get their
act together and maintain the driver, or it will get removed.

-- 
Jens Axboe

