Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD14E5EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348217AbiCXGxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCXGxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:53:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C1C95494
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:51:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e16so6390221lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uv9WDFuf73d36aG534OWTYxmQv2bNKKIk/9hpshgIJU=;
        b=Kq8gbI9QPeSROVHNU9dFJEHcWJnqsbuUDwE9QvWau9w5fMGGztvKfyqamgfePWtIP2
         8oUQbzmwhvMTZ9u2HVCqwgMle+PWtNdwGH7Fj7oMF0pqAH35MsL+Or1vbBulcyAt+rvM
         vc9HCHhIocij9414WGtRFt198fp6E08L02GUCFPiP52kJY/HW+9eFT1mltFFZ3BaG3ln
         5kqV/NJgdHc6SXLp+Fymz2qAtXl+EUFnP0gtnTg1Wa85RvSt0irE57CUq1s3FJWKFWfW
         888oKuWc2fQxTuWhxjVsD8mbp8sfCJgRvICccKylPmR/N2tK9/37tW4otVE4laU5vFFv
         MhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uv9WDFuf73d36aG534OWTYxmQv2bNKKIk/9hpshgIJU=;
        b=kqCHiCSLGOg8EVjdR2j1cu+LD19nrYnCmzff9bFsO6EwOZROvhzxLJgo/STCasYBh9
         bNwCz0aazx83XFDc8MdMn6eGksQiT2FdklLUXWjUOHOA8biJSI7EY0c1nSYNGaSvXppS
         HLh/pF4u9H0qqyOskpZ8JQYnbb4/j3yjIKdBdgu6jhmMAdzr80cDhl5zBqyb8wYZcjJq
         jBlUyV4PB70rlLoF8KpihM7RQJ4OBbD+rnbLB8rZMThAv68GSva1z2mcmAZ+ow9eho6y
         U4S6ngMAXrvZskrAbcucVPCppiWP1UgbyKg9XUpjxgJFx36ec/OFGq/RGxtx+ldtUY1t
         8vsQ==
X-Gm-Message-State: AOAM531fhLgt4udy5yAGkrxUfl7tr2PBUeqSqcEyP/3agKwo0p+mMzAp
        7HQgBShjnoe13PdlyZZ4xxMtGUqZw2ChzF9jSdtodfubU4E=
X-Google-Smtp-Source: ABdhPJwDfXqglQAx4xkKcgV5qn+FFERkaesBPRjOEZL/Efm6/Fu/ASIYOR/QcdIpx4wkzANYfvK5RODptL0UVCnEAwQ=
X-Received: by 2002:a05:6512:308e:b0:448:5d75:9729 with SMTP id
 z14-20020a056512308e00b004485d759729mr2598646lfd.663.1648104717736; Wed, 23
 Mar 2022 23:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9q55ifnzxE9zLuLT=Hgjv=qcvjU-O-c8G=_o_V_O+p44Q@mail.gmail.com>
In-Reply-To: <CAHmME9q55ifnzxE9zLuLT=Hgjv=qcvjU-O-c8G=_o_V_O+p44Q@mail.gmail.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Thu, 24 Mar 2022 14:51:45 +0800
Message-ID: <CACXcFmnb87qqzVkw9GfojPNh5sDkYGsqq9TYxUXBvrC1R+Lr3w@mail.gmail.com>
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

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> Thought I should mention here that I've written up the various RNG
> things I've been working on for 5.17 & 5.18 here:
> https://www.zx2c4.com/projects/linux-rng-5.17-5.18/ .
>
> Feel free to discuss on list here if you'd like, or if you see
> something you don't like, I'll happily review patches!

Your code includes:

enum {
    POOL_BITS = BLAKE2S_HASH_SIZE * 8,
    POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
};

static struct {
    struct blake2s_state hash;
    spinlock_t lock;
    unsigned int entropy_count;
} input_pool = {
    .hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
            BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
            BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
    .hash.outlen = BLAKE2S_HASH_SIZE,
    .lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
};

As far as I can tell, you have eliminated the 4K-bit input pool
that this driver has always used & are just using the hash
context as the input pool. To me, this looks like an error.

A side effect of that is losing the latent-entropy attribute
on input_pool[] so we no longer get initialisation from
the plugin. Another error.
