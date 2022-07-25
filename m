Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E575805C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiGYUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiGYUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:35:51 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2A9B75
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:35:50 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c3so9630546qko.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B24VEl56RSFIzcOUHAfYgMoNShNhXtFPv/q3LcmPwHM=;
        b=kE6o+XtXvihf90nAAx15AyOzv4YL/It1G3kBNDZYnbmaNctifmgFqkRO4gbDbmLIwD
         /BufJeti/EmEmylJh8uUMihpqI957A6DNDeWab+eCppXMqoFDqI2t7D9n0WSJCsTUzWp
         AWFox+BxwRC16e7MideOBbkzbVo09jcLuuDve05Cdv2AcyUUDiuVWZQ7/LxZ4vYgqeZV
         8Gn2yeoREF4bOiVKdBNBi8KIygSNu9PbFHCH2wQOpqW7PKwV9lWNjGkcefHGazSU161N
         Pnh6HGzVSPcFYZDalQ4FGVrGpNcUGdjNJnTIwjHxlCTtn2RcTtgAxKIX1QFkYiy02nH0
         M67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B24VEl56RSFIzcOUHAfYgMoNShNhXtFPv/q3LcmPwHM=;
        b=vovFKqIRJDQYlnCqFO/2ZC8PlhYhz25907uE5TuUHTU8yKxcaQNnBKbGcVfsDe0AvV
         tmXZPg6KdbwVIWEvEfBR8dFAYcDLSZJevdnJ6kJtuZ9fOXanTygsX5SKpsF5DeteqbAG
         JpsyBK10PTg62v6g0txoOfbJzMG2Hw1EC/3/JHmPik+trKeAqFWxPfwBCMdQ5X7YOpn+
         vlf9se3L/L3Gf6ksqvUiJYLls1zRORe3G2ypdk84sM/ibyrc5gSfucUZxNB4CRyplvil
         33KQ80Wz/Ioa/6uhuwyiC/k3WLIuKLEK2uHXbG3r+uNvHxSqnG8DxEljavoyLwBMk9OT
         a2UA==
X-Gm-Message-State: AJIora/EqPC1060eTpUnOcIe2HJkQITyXLdFgOtD3AhRLVT9ew0sEHnb
        s78+RFPRQ+kXmOurUNsCP9iHC9she+Q=
X-Google-Smtp-Source: AGRyM1s/YjsZq3gfxpirTWK/+1Ycmla4BiKcfBSQI2sYa7+v929I97Qvo9M+CWo0d/FqMjufDDnffQ==
X-Received: by 2002:a05:620a:2fb:b0:6b5:f6bd:dd9 with SMTP id a27-20020a05620a02fb00b006b5f6bd0dd9mr10465040qko.623.1658781349328;
        Mon, 25 Jul 2022 13:35:49 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:3948:b82b:8f44:3d84])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a415500b006b5ed1eccc5sm10357689qko.44.2022.07.25.13.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:35:48 -0700 (PDT)
Date:   Mon, 25 Jul 2022 13:35:48 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc8
Message-ID: <Yt7+pPyEmYYH8D1K@yury-laptop>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <CAHk-=wgGrewyOqT7Cm-eHKp5W+8rJ=aL8iNtsbhRfc0YD2gbeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgGrewyOqT7Cm-eHKp5W+8rJ=aL8iNtsbhRfc0YD2gbeA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:49:09AM -0700, Linus Torvalds wrote:
> On Mon, Jul 25, 2022 at 10:55 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think the fix might be something like this:
> 
> Hmm. Maybe the fix is to just not have the arm architecture-specific
> version at all.

I agree (see my other email in the thread). If no objections from ARM
people, I can drop it.

> The generic code handles the "small constant size bitmap that fits in
> a word" case better than the ARM special case code does.
> 
> And the generic code handles the "scan large bitmap" case better than
> the ARM code does too, in that it does things a word at a time, while
> the ARM special case code does things one byte at a time.
> 
> The ARM code does have a few things going for it:
> 
>  (a) it's simple
> 
>  (b) it has separate routines for the little-endian case
> 
> Now, (a) is probably not too strong an argument, because it's arguably
> *too* simple, and buggy as a result. And having looked a bit more,
> it's not just _find_next_bit_le() that has this bug, it's all the
> "next" versions (zero-bit and big-endian).
> 
> But (b) is actively better than what the generic "find bit" code has.
> The generic code is kind of disgusting in this area, with code like
> 
>         if (le)
>                 tmp = swab(tmp);

The patch that adds this is: b78c57135d470 ("lib/find_bit.c: join
_find_next_bit{_le}"), so I did that on purpose.

> in lib/find_bit.c and this is nasty for two reasons:
> 
>  (1) on little-endian, the "le" flag is mis-named: it's always zero,
> and it never should swab, but the code was taken from some big-endian
> generic case

Yes, the "le" is a bad name, and I think it should be changed. Are you OK
with "need_swab"?
 
>  (2) even on big-endian, that "le" flag is basically a compile-time
> constant, but the header file shenanigans have hidden that fact, so it
> ends up being a "pass a constant to a function that then has to test
> it dynamically" situation

I think it's not measurable, at least find_bit_benchmark didn't get worse.
Even if find_next_bit() is invoked many times in a loop, we can expect
that branch predictor would optimize the difference out.
 
> So the generic code is in many ways better than the ARM special case
> code, but it has a couple of unfortunate warts too. At least those
> unfortunate warts aren't outright *bugs*, they are just ugly.

Here we have 2 ugly options - having pairs of almost identical
functions, or passing dummy variables. I decided that copy-pasting is
worse than abusing branch predictor.

Thanks,
Yury
