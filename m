Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3B4EB10F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiC2Px5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiC2Px4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:53:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A51164D25
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:52:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b16so21512267ioz.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9NtXRZP0DYrWCoTLKXqVYrEtOzP8J+6Ei1YBGnCYRsE=;
        b=wCSJ2RWIKFAo7QsFAVi6ZWOvSkSRf5ZKLSOUpBb9nQkzdcrMK8gOq9wpt8YxhDqXDF
         DDkkq+RCP19Sm1wge4VwYyJ7Jx60NeJpfsMHoxpjUDTTQLqiUGD/KxjennUi2i92fiS6
         Fxtgzrj661RrvkbhfG7k6NuaE7l7LICC21hZKUaSLD+Za7l9WUvZpaOXAwtkF18HOlKQ
         GDmv32qyNMzsOc9yYAh8sqaPyx5XWJio+BcVuJat4MR0UeIoolyK0ELfaTv/54ffE29u
         8HPpSs6egTIFH+cEqdBNZPR6X5Z2k5dO4D/1R6sLdG3bhFDGWuIlffI7WrBPGb1x1KlV
         /uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9NtXRZP0DYrWCoTLKXqVYrEtOzP8J+6Ei1YBGnCYRsE=;
        b=XR8sGbogW3TUXqXo6fgNyPwnyTZTINZekz0SVq2o9p7wRJMJcLN4GjO/FVRt5VnS4T
         Qjqn/eHkk5mL4llPynPMCD1lxveE3i/IsslOyS6purXX4QUs5oUSoW398inyHWbjTi5p
         3f35PrWtfCIFCI19t/srtQaQsQ5IT7bC0YDti1L3wqKtkCRUFW9jhrndmvt2a1e6ItZB
         mitAo9px2J0yYtm/mh/TSmWWbv31R+LqhDLDc9MbW/9G8ZAfCySgj4bPc8wmbdqaZZyt
         bNTH7MRDZ2+KQM4mTeaC/Z0pTMSH4IEptKvIn2h0c3TfRvL7cDjudldH2Ehb/FgN4AJ5
         oWhA==
X-Gm-Message-State: AOAM5326atvlIZRhbgA7kbhMAeFiXpWkmeoS6wkGoqSg9Nytwn8NeuSg
        ixTIJcf/BdgrgfrhufZFaW8udg==
X-Google-Smtp-Source: ABdhPJxK5IS/HuiP8JcWwj9DK/HbLT5Wlcg0zY7+VPt8mzJDCkPMc9snfKatO2/yJkfl0axTG6Pdmw==
X-Received: by 2002:a05:6638:13c4:b0:31a:886a:625d with SMTP id i4-20020a05663813c400b0031a886a625dmr15382057jaj.211.1648569131699;
        Tue, 29 Mar 2022 08:52:11 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c2-20020a92cf02000000b002c9ae102048sm4267972ilo.77.2022.03.29.08.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:52:11 -0700 (PDT)
Message-ID: <3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
Date:   Tue, 29 Mar 2022 09:52:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: state of drbd in mainline
Content-Language: en-US
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220329070618.GA20396@lst.de>
 <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de>
 <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
 <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
 <CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
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

On 3/29/22 9:44 AM, Philipp Reisner wrote:
> Jens, my intention is to keep it in-tree, and at some point update it.
> Regarding your questions:

That'd be great, but it's been years since there was any significant
updates to the in-kernel drbd... I would strongly suggest that the
in-kernel be brought closer to what people are mostly running, as it
stands it's basically unmaintained.

>> - Why aren't the drbd maintainers responding to posted patches? They seem
>>   to simply be ignored, and I'm left to pickup the trivial ones that look
>>   fine to me. In-kernel drbd appears largely unmaintained, and has been for
>>   years.
> 
> The team here has grown, we are busy. Since you started to pick up the
> trivial patches yourself, I thought it is not necessary that I collect
> them and send a pull request in merge-window time.

That's just one part of it, the fact that the out-of-tree drbd has been
drifting further and further away from the in-kernel one is a big
problem. For trivial patches, I have no issue picking them up. But
silence on your side is not very helpful. Please review and ack patches.
If I see it acked, then I can easily pick it up.

>> - Even if out-of-band communication is used for in-kernel users of drbd,
>>   that doesn't result in any patches or fixes that should go upstream?
> 
> This one:
> https://patchwork.kernel.org/project/linux-block/patch/20210426163032.3454129-1-christoph.boehmwalder@linbit.com/
> (relevant to users that have DRBD on top of md raid)

That's a single patch, from a year ago. Not a strong counter point,
looks more like it's proving my case...

>> - If there's zero activity for in-kernel drbd, all users are using the
>>   out-of-tree version?
> 
> There are users of the in-tree version, some with huge fleets.
> Some do not need the newer out-of-tree DRBD, and the in-tree version is a
> lot easier to compile. You need coccinelle for the out-of-tree version,
> and that can already be a hindering barrier for some.

The main discrepancy here is that there are apparently huge numbers of
in-tree users, yet no fixes or patches at all making it to mainline.
Either drbd is bug free and doesn't require any fixes at all, which I
very much would doubt, or fixes aren't being sent upstream.

-- 
Jens Axboe

