Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60579517F1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiECHq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:46:57 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8441B37BF6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:43:26 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f7bb893309so170949897b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4F9J/vN8tSN8jrLP9zOvBCiC+XRvEv+dkdWW7NWJIE=;
        b=jemBUzyTNt8gqs21UYjZoNdxfU+cp9TWiW1q0iax3DlGEAbY7xlCAfY4bUC7P3X6pK
         04nmfrLNlv6zJLfpgo3edRkTCJfWsQYRi6SndpX/kyin2q3GGvDjOhAtgRofIS4LZ/Mg
         9QxCb7OLGJPqy2Pokkm2lvA2Trf0j8FDBuhr1TguD8w8Pvsz8Fu63w+IQXsl7reHLEaP
         /c2remfX9g/x5khU2m2HrwZUbwxOljrybrm6aghnggp80OUBit+1wAdx6yiw8A8/HpLO
         De0oOx6sP9xD9UYU3YHtYbsv+4D9+KwLLwjxUojZ5ivoIJ4X7vygdoB5MpV7FAmvnqib
         MJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4F9J/vN8tSN8jrLP9zOvBCiC+XRvEv+dkdWW7NWJIE=;
        b=wXB0YCzVO8xgzCYZQdD8DTe9AceZCJ2FSFqtbLZLbhRaN3K39FxJJrTVKXuWFT0XHP
         Z2u2bEAos0j3Fv+0Xz8ZcHw9D06lUZn0frJVK7I8th2lNsvrFsVGtnxNFINN2PikkcRv
         4JYi2Yaksxu+4ZDeL0ESvJACrUA4u5UucVyZtMAh1nmQoXH5Kjjvhl80ZuSf7AX5hpz9
         y3U9RilP6rtvS77TfDhZ30iBsNNL4jHxuGmms33hoFYGSnKg+TWTumo6eekkBNzmadMG
         MHSTd/TVdKaEqbsGlymCYql0YwkWBxkIYFJJjHspFOuGxuWl4GtGkJU9W+S9qt6cH+PQ
         IOhw==
X-Gm-Message-State: AOAM532PQiVb1zPnu5CB0RZaAJlviSP5/7mCQ5fPvMwXm5FaGSkimaQv
        Av1LfyjOphlJHYCjmJNvMBJD8fQuIqgen5QGn6YsmQ==
X-Google-Smtp-Source: ABdhPJwRj8WrBGxMnhniDzry34cZen2tqr3v8q9LbIHdeHN3Oe0gtfYxAWk0kgpG1EsHA0p3OQWLFgC5/6173OGoVKA=
X-Received: by 2002:a81:1495:0:b0:2f7:1ce7:f482 with SMTP id
 143-20020a811495000000b002f71ce7f482mr14373555ywu.333.1651563805516; Tue, 03
 May 2022 00:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com>
 <YmwPocGA9vRSvAEN@elver.google.com> <87fslup9dx.fsf@jogness.linutronix.de>
 <Ym+NkkglHI5D89Dx@elver.google.com> <Ym+WqKStCg/EHfh3@alley> <87czgwmgtc.fsf@jogness.linutronix.de>
In-Reply-To: <87czgwmgtc.fsf@jogness.linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Tue, 3 May 2022 09:42:49 +0200
Message-ID: <CANpmjNOgT_vvCtEOT8idcZdXgLcZrEwFvsj0GFctpCnNmq4eKA@mail.gmail.com>
Subject: Re: [next] i386: kunit: ASSERTION FAILED at mm/kfence/kfence_test.c:547
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 at 11:20, John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2022-05-02, Petr Mladek <pmladek@suse.com> wrote:
> >> My proposal would be to fix the tracepoint like so:
[...]
> >> This fixes the KFENCE and KCSAN tests.
> >>
> >> Unless I hear objections, I'll prepare a patch explaining why we need to
> >> fix the tracepoint.
> >
> > It makes perfect sense to me.
>
> This is the easiest place for it. However, it should be clear that in
> the context of trace_console_rcuidle(), the message is not yet visible
> to any readers. The message _will_ get committed and definitely _will_
> become visible at some point. But it is not (yet) visible at _this_
> point. Maybe that is OK for what it is being used for.
>
> If trace_console_rcuidle() must be called at the point of visibility for
> readers, it becomes more complicated.

I think that wasn't the original intent, so fixing it up to actually
happen on printk() is probably the sanest thing. I sent the patch
trying to explain:
https://lore.kernel.org/all/20220503073844.4148944-1-elver@google.com/

Thank you both for the valuable pointers!

-- Marco

> John
