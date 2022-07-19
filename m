Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA97579FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiGSNbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiGSNbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26198AEEB;
        Tue, 19 Jul 2022 05:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264DC61740;
        Tue, 19 Jul 2022 12:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10499C341CA;
        Tue, 19 Jul 2022 12:46:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="orkHbPvm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658234804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0M1RG9G8cO37nst2CD7DZ89TkqR9zkT7SUAp4B3bFOM=;
        b=orkHbPvmh6q5POuNqNQH1spr0aScRPGyZ7oXanlg68fil/7h/19PejEl4f1pwSHLoAmcIV
        V2f6KVxx+ALuprKlhga/EvwF53pj8Mk52asCsYsis1Jj1IVNESFZl34vlmgnxJyLUhHuep
        27JHgQYYlRkZPwkVGBqhthNjepG1c3o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4ee87988 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 19 Jul 2022 12:46:44 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id l3so8850612qkl.3;
        Tue, 19 Jul 2022 05:46:43 -0700 (PDT)
X-Gm-Message-State: AJIora855FplDa1R37UbKhwepcGLyLszeObJK2tMQx5P0fTW0pKqOikd
        +mZGnWRRsF8a9cDTvpS5r114tk4FfztMFFGYyhw=
X-Google-Smtp-Source: AGRyM1t2xq+LcMrIzmoeK42JgLdc9jD9mAg3j5fHR2WcBcobwuU+HIL3Q4G9gniTA5GYzRlJybQa0yDZOX953fr+g+E=
X-Received: by 2002:a05:620a:4552:b0:6b5:fc9f:e7a7 with SMTP id
 u18-20020a05620a455200b006b5fc9fe7a7mr2138601qkp.65.1658234802386; Tue, 19
 Jul 2022 05:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <YtP1+MJ1tNdJA60l@zx2c4.com> <20220717200356.75060-1-Jason@zx2c4.com>
 <YtamvPvl04ByTrVp@FVFF77S0Q05N>
In-Reply-To: <YtamvPvl04ByTrVp@FVFF77S0Q05N>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Jul 2022 14:46:31 +0200
X-Gmail-Original-Message-ID: <CAHmME9qTA90=GEr6h1GZh0CjS+6tpe5uuqkYoJVv79h0zd0w1w@mail.gmail.com>
Message-ID: <CAHmME9qTA90=GEr6h1GZh0CjS+6tpe5uuqkYoJVv79h0zd0w1w@mail.gmail.com>
Subject: Re: [PATCH v2] random: handle archrandom in plural words
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, X86 ML <x86@kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Harald Freudenberger <freude@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jul 19, 2022 at 2:42 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > -static inline bool __must_check arch_get_random_long(unsigned long *v)
> > +static inline size_t __must_check arch_get_random_words(unsigned long *v, size_t words)
>
> As others have suggested, could we please s/words/longs/? That's a smaller
> change from the existing name, and avoids amibugity were "word" has an
> architecture-specific meaning. e.g. the ARM ARM (ARM DDI 0487G.b) defines:

At first I had thought, "erm, I like 'words'" but decided to wait it
out, and now it's two people with the same probably good objection to
'words', so I'll send a v+1 with 'longs' instead. Thanks for your
feedback. Patch incoming.

> FWIW, other than the naming nits, the arm64 bits look fine to me.

Oh good. Can you send an Acked-by for v+1? Coming up shortly.

Jason
