Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32A462AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhK3C6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhK3C6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:58:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674FDC061574;
        Mon, 29 Nov 2021 18:55:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o29so16202122wms.2;
        Mon, 29 Nov 2021 18:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJ076OIqjgPenNCZ4jeRYQlwYOXUIXZ8CFtTTusFwys=;
        b=ApkCABF3+SMmNqkepoyou9vrhQQPJbhuUmyPifOiCt9M61bwpFxkRendDsuu6J/1BN
         n48JnDY6+aPYYODIZ39tGNP5XsSBs5A2MUlFTkaCit06Oe9z6UIuxZNYFliv1RwSRCcE
         1M7ac9yl5PLiCqduoEFM0ud0kgldrAPSqyT3PbmIm8Mjq5j1xDsRNXVuzHGHRTVlooxh
         R/B9U7EEq0HJqD2Asan5MFnX7U9BXSXB2iN/n1Ziuc9UCOsgnPQ4BMGRXs9Yi1LPwbbW
         /87UklTQO35R/nVhAw74bjcVuna7MeS5KcFaZeNOrxxUdLXgdjYGfl1G1NkFavbh0Uwh
         DU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJ076OIqjgPenNCZ4jeRYQlwYOXUIXZ8CFtTTusFwys=;
        b=msJ0xYbJXgP0kCLwM3AWi4Av3F9ssc7wQ00YCxLk5h2/2GTu5G+72uleRvvoMehYiw
         wQ8jBWH94QKaSoG0ZBHYLDraLwYwkOpWV52iwE9hmoyhaIM34QvFsdbDOjXzjI9n9Jhs
         RPrspR7JN5VAkOVwbTwlPp0O1DboXfqMQA+5VvDwUvJqmZNts7zHMGL0Kp4EbBlu2vwX
         FIbwVix9miMwZxQ3cYR5M5rUt8GpFPTe2p0/4knGSNqIxE6n4eu4F6GVuReEvxBfRkCn
         InDql2w9axuqmq6wA5MJeKzMROrR7wpPPUIhKuaw/3sW/inCdMd/SyZvGbAJBDoP/sIT
         eMng==
X-Gm-Message-State: AOAM530ZbW1YWoypT93f1OZnMTpUsJnRsOQWdeYjswxLiGrg7SmBKGSa
        g0PNymjR3vVhqKsyeoqR/gEc7PoNXngrBkLnkH4=
X-Google-Smtp-Source: ABdhPJwdFvld2vbGf5PnJgcyA4Z6UvYHga3hAbO9Z3wbMSFiG4jXWo/nsOKswiPZSzLLzWgq12bD/+wyDrh/MvdgKso=
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr2009715wmg.17.1638240925988;
 Mon, 29 Nov 2021 18:55:25 -0800 (PST)
MIME-Version: 1.0
References: <4641592.OV4Wx5bFTl@positron.chronox.de> <202111221831.lPHo6KJJ-lkp@intel.com>
 <5540546.7F5nsSknLy@tauon.chronox.de> <7ee4a94e-496e-67a0-897a-0dd84bbce72f@intel.com>
In-Reply-To: <7ee4a94e-496e-67a0-897a-0dd84bbce72f@intel.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Tue, 30 Nov 2021 10:55:12 +0800
Message-ID: <CACXcFmmtdQLCusKu1NHq4JjiKAjCpCPj0aYBR-wxO3tEz_-nQA@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH v43 01/15] Linux Random Number Generator
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Rong A <rong.a.chen@intel.com> wrote:

> On 11/22/2021 7:47 PM, Stephan Mueller wrote:

> > Thanks for the notification.
> >
> > I think this is a false-positive discussed before. __latent_entropy is
> > seemingly allowed for an entire linear buffer as seen in the declaration of
> > the variable input_pool_data in driver/char/random.c which is an array of u32.
> >
> > The struct chacha20_state is a linear buffer of u32 words.
> >
> > struct chacha20_block {
> >          u32 constants[4];
> >          union {
> >                  u32 u[CHACHA_KEY_SIZE_WORDS];
> >                  u8  b[CHACHA_KEY_SIZE];
> >          } key;
> >          u32 counter;
> >          u32 nonce[3];
> > };
> >
> > Therefore it should be identical to the aforementioned example.

No. It is a struct & there's no guarantee all compilers will lay
it out as you  expect. There might even be a gap in the layout
since nonce[] has an odd number of elements.

>> The __latent_entropy marker therefore seems to be appropriate for this structure.

First, this is completely unnecessary since the input pool is marked for
latent entropy & changes there will affect the chacha context.

Also, if I'm reading the docs right, the __latent_entropy attribute
on a data structure only gets it initialised somewhat randomly.
If you want a continuous effect at runtime, then you need to
make the code mix the latent_entropy global variable into the
data structure.
