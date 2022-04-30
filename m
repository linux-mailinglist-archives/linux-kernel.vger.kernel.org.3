Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA855159C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 04:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382071AbiD3CMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 22:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbiD3CMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 22:12:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9ECC1C8E;
        Fri, 29 Apr 2022 19:08:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m20so18411856ejj.10;
        Fri, 29 Apr 2022 19:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrNdHxLyFHKMsj56oskv/GALROKVMi7bvEfnrcUxu74=;
        b=Efjkl7x0Rk6iNHqkxMx3MZ0UTsKnUyuC0ZZ6GUEC5xNBE5wpBNYD2qO9Gfibb+FPVr
         XjjEG8UF6b8aXW1QKLtqeBVqis5rrL3Bods20YCaBC92t438tW89zi2Xr2/8vVCVYF9p
         HImjqQXsjE2k1akJs3pwxMlDFLGzmeR8Fe6+ENaA1L3Okpy6JQwskms/IInfsQpXH1T5
         4gW//ipAOfH/hKPtSagwYS+OpdIKbFbmjBBle30uEuXanyaQtIne7ZMpLG0QCua/Pcjp
         o6Kc2uZluk2HrWdCkZjhMX5iw++TcDLTg8yFvJiBAyFjneiupoY/twlgwlwj7GQgmo1B
         u6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrNdHxLyFHKMsj56oskv/GALROKVMi7bvEfnrcUxu74=;
        b=Y1LQyd5+Wlcg8G7zOxlRe/Y88wLkYA4tIpEkqy+9v6h+GBhigYWz8lgwIwuiJwpPTO
         hkL8NvmHYvniunKBkN4E8kBYrae+Cuo5UxvxlQHLAJJ8ONCaIPU7R77IJzLlowJCxFsP
         y4c0smUSmJFCAGRVxmqMfW79OUiE6crWdZ51zrLOzqDzcWvanRi9L1A1sQSlgQlzslwG
         xb7ppW3F6rVZLbW48Qjy2Hd/6FutKWA5onU1kaVt8avQNif+fZazW1oyxeqTYA5nBj+g
         Wa5qkOVqnq8Yxe5wBGfB3EBdVlgztQRpBhAOsAL/QetxdDz9HTUZpb1aIWqOuloVZ6FQ
         O59g==
X-Gm-Message-State: AOAM533vNp17NhG16fFQkf46ixtCxxzhL8aRGppKYs0XhyTTiiAfvQIs
        5b7yavykLRh3er2qZYwCxu5Cq8mCeT/eOBxjfYY=
X-Google-Smtp-Source: ABdhPJxMSTHQ8RRCUp4d1GLhpsO8MCmccnnzrS9qGM/JBjw+DKQNJFm2M4xTzuytRB7GpFuC+He0VLkeVUAXdJTcPPQ=
X-Received: by 2002:a17:906:301a:b0:6f3:fdd3:4d1c with SMTP id
 26-20020a170906301a00b006f3fdd34d1cmr1963318ejz.235.1651284524118; Fri, 29
 Apr 2022 19:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <YmlMGx6+uigkGiZ0@zx2c4.com>
In-Reply-To: <YmlMGx6+uigkGiZ0@zx2c4.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Sat, 30 Apr 2022 10:08:30 +0800
Message-ID: <CACXcFmnnS2HPoju3aTd29Nef0BLr9juS6SM4tGsTGe2eNsOyMA@mail.gmail.com>
Subject: Re: is "premature next" a real world rng concern, or just an academic exercise?
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     nadiah@cs.ucsd.edu, noahsd@gmail.com, dodis@cs.nyu.edu,
        tessaro@cs.washington.edu,
        Linus Torvalds <torvalds@linux-foundation.org>, djb@cr.yp.to,
        "Ted Ts'o" <tytso@mit.edu>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        peter@cryptojedi.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> The Linux kernel RNG currently pretends to care about the "premature
> next" RNG threat model. I'm wondering whether this is sensible and
> corresponds to anything real.
>
> "Premature next" is the scenario in which:
> - Attacker compromises the current state of a fully initialized RNG with
>   a wild 'n crazy kernel infoleak.
> - New bits of entropy are added directly to the key used to generate the
>   /dev/urandom stream, without any buffering or pooling.

So don't do that, then. Keep a separate input pool/buffer and put
only hashed outputs from ir into the output pool.

> - Attacker then, somehow having read access to /dev/urandom, samples RNG
>   output and brute forces the individual new bits that were added.
> - Result: the RNG never "recovers" from the initial compromise, a
>   so-called violation of what academics term "post-compromise security".

Use chunks big enough for "catastrophic reseeding", impractical to
brute force, at least 64 bits & preferably larger.

>  Fortuna requires non-zero code
> complexity; does the benefit outweigh the cost of such complexity?

I'd say certainly not.

> The questions are thus:
> ...
> 3) More broadly speaking, what kernel infoleak is actually acceptable to
>    the degree that anybody would feel okay in the first place about the
>    system continuing to run after it's been compromised?

If we have a good entropy source -- e.g. running on an Intel CPU
& consider their RNG instruction trustworthy, or in a VM & trust
the host -- then we should be able to guarantee recovery at the
next reseeding. Just dump at least 128 bits from that source
into the input pool before hashing.

The interesting question is whether & how soon we can guarantee
recovery if no such source is available, we rely only on entropy
gathering from interrupts, with or without the gcc latent entropy
plugin.

> Is "premature next" just an academic exercise, rather than a real world
> RNG concern?

No.
