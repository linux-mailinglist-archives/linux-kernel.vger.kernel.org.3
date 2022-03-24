Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D244E61B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349495AbiCXKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242686AbiCXKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:31:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAEA55219
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:29:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bt26so7259392lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhnV11ZIB9XQsFrR+7RyjEctj8mwdwZ8rAPFLvRFWjI=;
        b=UTkdRKxy/4KFYFJbrY18/+BI7r3nUnt/znELOVsFGL9K9mYyozmSoj7RiJT6at0E60
         P4GkOL4NqOo5n5zT908BnYQ49z5vlQqrKAU8G2gVOWYKhPbRJKjn07P5Y99A0kqxCtlE
         sTJsUJdf+WlJTPvZOcwUOG09FtDdGpcCzNtjjpY+7L+cE4UhfGTjORRkATSey2cfzCqY
         LqrvRVIuOMGON12SrhlMVmRd7jkDXxqAFLs8We1jOBNiHIqv2ttkXNQ3YVoxN75m3D3X
         Za0uArP8lrGptCh/KTpLeVI/DqQM9ph4YXWMtWUS8Vzi7QliWlUTpEzEydbZ824lGZIN
         Uo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhnV11ZIB9XQsFrR+7RyjEctj8mwdwZ8rAPFLvRFWjI=;
        b=bZJwgylP7I09nu6/oV6eZIlfaaJzQjcU6TYPw/zkPUZEORFJLUKRO3RrUEhYix26d7
         ft272lxvoH0Wzm9dbs+Vxnu98rndNKfAiheOvZtGqAovobxE6V//1YZmJVzUc3HLLFeW
         PolmkaeO0b4v8noVozdeF/J0zFULjWisd4H1IelXAdr5K3wiCcqGA9b19sIcbj/cpxK8
         xOzsmMo3z6nEIljcAn8y5nAYG6QPx1f9U8Ahzrwvwe5IRIKr2jMeeNvR+NP0FSEkfCSB
         xzl/Eq5xzQHyNnAhyxgVSl80RVSAZlS8BAXFDF6OjpvgREjc3Yu/+LGKYfCEgR8Dkx6L
         JtbA==
X-Gm-Message-State: AOAM531imblNkFfBUl0MK+jgEhgg8bEsfSPKjFqLSkTb3Mx0i6xUAFkE
        o/PAHbOM7vbLG8R7pwVbTUVMGEUhhTP+cAAcgG8=
X-Google-Smtp-Source: ABdhPJximP+pKDfVRtUrc7EWkUuUx+ODJxHOlUoYNyclqp8nzGphnUgTl6TKfn9FLnPjsX7V55sbW836zvFk7m0NEVQ=
X-Received: by 2002:a05:6512:1294:b0:44a:35a2:a282 with SMTP id
 u20-20020a056512129400b0044a35a2a282mr3174229lfs.269.1648117781114; Thu, 24
 Mar 2022 03:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9q55ifnzxE9zLuLT=Hgjv=qcvjU-O-c8G=_o_V_O+p44Q@mail.gmail.com>
 <CACXcFmnb87qqzVkw9GfojPNh5sDkYGsqq9TYxUXBvrC1R+Lr3w@mail.gmail.com>
In-Reply-To: <CACXcFmnb87qqzVkw9GfojPNh5sDkYGsqq9TYxUXBvrC1R+Lr3w@mail.gmail.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Thu, 24 Mar 2022 18:29:28 +0800
Message-ID: <CACXcFmnhHpGQdU7ZcYNqjSss8VHMOtTvmJRETn18p0AY3AsEuQ@mail.gmail.com>
Subject: Re: Large post detailing recent Linux RNG improvements
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy Harris <sandyinchina@gmail.com> wrote:

> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> > Thought I should mention here that I've written up the various RNG
> > things I've been working on for 5.17 & 5.18 here:
> > https://www.zx2c4.com/projects/linux-rng-5.17-5.18/ .
> >
> > Feel free to discuss on list here if you'd like, or if you see
> > something you don't like, I'll happily review patches!
>
> Your code includes:
>
> enum {
>     POOL_BITS = BLAKE2S_HASH_SIZE * 8,
>     POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
> };
>
> static struct {
>     struct blake2s_state hash;
>     spinlock_t lock;
>     unsigned int entropy_count;
> } input_pool = {
>     .hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
>             BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
>             BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
>     .hash.outlen = BLAKE2S_HASH_SIZE,
>     .lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
> };
>
> As far as I can tell, you have eliminated the 4K-bit input pool
> that this driver has always used & are just using the hash
> context as the input pool. To me, this looks like an error.
>
> A side effect of that is losing the latent-entropy attribute
> on input_pool[] so we no longer get initialisation from
> the plugin. Another error.

I could see reasonable arguments for reducing the size of
the input pool since that would save both kernel memory
and time used by the hash. Personally, though, I would
not consider anything < 2Kbits without seeing strong
arguments to justify it.

You seem to have gone to 512 bits without showing
any analysis to justify it. Have I just missed them?
