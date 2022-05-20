Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8152EFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351228AbiETP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351234AbiETP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:58:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC7179C27
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:58:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so6669501pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MysCUo8PigBFNybv8qU5iNiuSIpAumArXKSI8owJTuU=;
        b=4ZESbKhavaZ10eCwk9P7h9qCgI+c7CV9U2d6hMtshpiAtKk0PCu7uLknriso6xzrMp
         PI7x+X3ZOm2hNOM6iaHXx31XPivRgnMUP4Z8BmfCHPqYrjvHM1Onfkbdc/rUkC5RldoR
         8+yOtwMVkNRWaHxrLSEL+Yma5NQfvsRRjjneZVHRLmiAv0Ag7u9S8gySCJNXrwQ65Ocx
         nkf82wPdaqpangbhnYgnR36xvd4bShoQVIgjfTA7837A5jY+yCI51JVtFSCxREO3dl3I
         HV4IpKBnLcIYybsKnDI+sbyx0y2n0qEwcVUPWvmPdpJc9UCyipnKt2MH/zVelzjuCLKf
         pUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MysCUo8PigBFNybv8qU5iNiuSIpAumArXKSI8owJTuU=;
        b=Wl48No0FqGeIOAtY1rhS3XjaR8jbg6rEXN04wGHfcRb6VRlsRgZL3kEmy5h+bqfa4u
         O5vI5H5cMd/OL2qnMRIm3oDCohSS+i4i3CLgnpSoJn7tECzQ1gBbX7AOu0+8Lfe2SnCh
         us+PFiRJiQIiVngXQadvzBfu2H2CrrIFUKyDz+7+Kaa75k9iwA6oKOGU76PdmIvBHMfd
         F0dSkbw+6koFXf+ABuwJybBI+LTTFnfYC28kKqRy/GPgbY2Cb1GbH/vEoiVyWqP7qRlI
         P1ZM0Rl9dUrUJ2RFaCE5vRKB6QBTVKBMOoX9Toer71GPO9oZMCZPIGDCvdZ687n6KLeB
         31jA==
X-Gm-Message-State: AOAM533XN/fEHP9HKjRR75p0KVlyY3tci/er+jzCES5SvSXbl4wCy8ub
        vzLiJu6RMG55zkNAUMs50TnTs1ee/7AQAA==
X-Google-Smtp-Source: ABdhPJxp+pZYZG8MueKuo5GNhm/avo2fwEqChY0eIPMDGUesocEa3foAr7GXTFa5Pcga1H0XBQLtkA==
X-Received: by 2002:a17:90b:3b4a:b0:1df:f68b:f6a5 with SMTP id ot10-20020a17090b3b4a00b001dff68bf6a5mr4609263pjb.166.1653062310787;
        Fri, 20 May 2022 08:58:30 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902e3ca00b00161929fb1adsm5752360ple.54.2022.05.20.08.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:58:30 -0700 (PDT)
Message-ID: <79024675-9a4a-cb2b-a0ed-91067ef05783@kernel.dk>
Date:   Fri, 20 May 2022 09:58:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com> <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe2PPA/pzqhf+GZ@zx2c4.com> <0a6ed6b9-0917-0d83-5c45-70ff58fad429@kernel.dk>
 <Yoe52RaMayvgodVW@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoe52RaMayvgodVW@zx2c4.com>
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

On 5/20/22 9:55 AM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 09:44:25AM -0600, Jens Axboe wrote:
>> Ran 32, 1k, 4k here and it does seem to be down aboout 3%. Which is
>> definitely bigger than I expected, particularly for larger reads. If
>> anything, the 32b read seems comparably better than eg 1k or 4k, which
>> is also unexpected. Let me do a bit of profiling to see what is up.
> 
> Something to keep in mind wrt 32b is that for complicated crypto
> reasons, the function has this logic:
> 
> - If len <= 32, generate one 64 byte block and give <= 32 bytes of it to
>   the caller.
> 
> - If len > 32, generate one 64 byte block, but give 0 of it to the
>   caller. Then generate ?len/64? blocks for the caller.
> 
> Put together, this means:
> 
> - 1..32, 1 block
> - 33..64, 2 blocks
> - 65..128, 3 blocks
> - 129..196, 4 blocks
> 
> So you get this sort of shelf where the amortization benefits don't
> really kick in until after 3 blocks.

Ah I see, I can see if 64b is closer to the change for eg 1k.

>> If you're worried about it, I'd just keep the read/write and add the
>> iter variants on the side.
>  
> Not a chance of that. These functions are already finicky as-is; I would
> really hate to have to duplicate all of these paths.

Then I'd say there are only two options:

- Add a helper that provides splice for something that only has
  read/write set.

- Just accept that we're 3% slower reading from /dev/urandom for now,
  and maybe 1-2% for small reads. Can't really imagine this being a huge
  issue, how many high throughput /dev/urandom read situations exist in
  the real world?

-- 
Jens Axboe

