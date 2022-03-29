Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922574EAD27
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiC2Mb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiC2MbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:31:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD638527CE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:29:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w21so14667398pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tEYwtozV5kisc/HAoJLg2e6AQnfx5UPKwLpWtsEvskI=;
        b=h6qN1hZ/Wy+W4nMvMo+YgmhULsEGKb9vKrt3zQTuX1qu/icKXYYLqymQaN0+Dd52S7
         mk1huIyhDWoZR+n5dGJ+hNuahS4f8R6rwhTZMpxRU3SbojZiXVnGg40V3T4R47SaYYdL
         YitKJDQxXwmD2ZgyXMq4CAFqmLACx27CJHD4Qt60L/2WO10HDzEYIQA27Mnvtu0mV5/p
         iRnclSv1S14Bo6TcZfJ+g1lMMFphPtmY2fkvVVoxLBf1GR7BG0MI14tA5CvGkJnKPHYh
         m4VbaDa5bB1s+1fFLUeZZzRB/h5a3FEw3U+FSaTRZNgSUxfMiGO3nN6tLmNnwaERbt1Q
         Dfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tEYwtozV5kisc/HAoJLg2e6AQnfx5UPKwLpWtsEvskI=;
        b=n0z2kwJek8SbldhE5OZKhYYdMZ2f9pOHmNlmp2OKDD9xVFjzT7qq1+8TVRTuUZCfUi
         //xr8soJUtyYtdmEBzZH+xiFav1NY2GmEj1Mjib+K2vylAesp6B5aqaRlWExs5ywMlMm
         +R99gRAvJ2bauBH63uSN8QSNh43UcjqRvPOpiREF+ts/gflfDg1otlHp5VLrqEVxRbdo
         9FuQjhquq3VCpifQwtHQtSUWg0xgC5zKCvqv7WrmVHhdPC0MB6MsVXPcgksv07+hGx1r
         YV3TxpfvJNyrxt7r4rP61MOzJp9JUkBe0v8Cyectf/mmji2gJHt2yGvbBLLm1ff0tbwj
         kDaA==
X-Gm-Message-State: AOAM531570z9F2kRLgbCRRFjo5VIZlgwWM9+BUjg1J+nIRarHMjJd4+u
        3T4zGH11+urW5JfHkr4afEZycg==
X-Google-Smtp-Source: ABdhPJzoQakIPG9Twcvrn4xf/24ThJCflQdfRtNpgJCGfbFPjnk+udG4I5buLv2jOnATPKAA3PnIPQ==
X-Received: by 2002:a05:6a00:3018:b0:4fa:d533:45e5 with SMTP id ay24-20020a056a00301800b004fad53345e5mr27557494pfb.13.1648556982245;
        Tue, 29 Mar 2022 05:29:42 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 135-20020a62198d000000b004fa9a8f73casm19843683pfz.99.2022.03.29.05.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 05:29:41 -0700 (PDT)
Message-ID: <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
Date:   Tue, 29 Mar 2022 06:29:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: state of drbd in mainline
Content-Language: en-US
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220329070618.GA20396@lst.de>
 <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de>
 <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
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

On 3/29/22 1:50 AM, Philipp Reisner wrote:
>> The complete lack of bug reports and maintainer interaction usually
>> suggests low to no use and heavy bitrot.  If that is not the case
>> here that's fine, just asking..
>>
> 
> FYI, feature-wise the in-tree DRBD is frozen. Maintenance only. Users,
> seeking advanced
> features switch to the out-of-tree DRBD and use other means of communication:
> Github issues, linbit's community slack channel, last not least
> linbit's ticketing system.
> 
> That is why you see virtually no activity.

I've been thinking the same thing. Even if most users are out-of-tree, you'd
still expect to see at least some reports on the list. A few followup
questions:

- Why aren't the drbd maintainers responding to posted patches? They seem
  to simply be ignored, and I'm left to pickup the trivial ones that look
  fine to me. In-kernel drbd appears largely unmaintained, and has been for
  years.

- Even if out-of-band communication is used for in-kernel users of drbd,
  that doesn't result in any patches or fixes that should go upstream?

- If there's zero activity for in-kernel drbd, all users are using the
  out-of-tree version?

As far as I can tell, drbd upstream is stone cold dead, and has been for
years. Why shouldn't it just get removed? Is it just bait to get people
to use an out-of-tree version?

-- 
Jens Axboe

