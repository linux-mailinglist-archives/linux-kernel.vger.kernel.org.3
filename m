Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F02560BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiF2VVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiF2VVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:21:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7707F17E3B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:21:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u14so7182659ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PwKwpQLLF9Wx/gSr3MYc18IBLW4Vq6WXee7EmmVZzE=;
        b=Nh0GvePQZdPLDPpVm1bbOP/ozbuGK50Vpq/Z3OIgAaEmpGTDWuOpTEQOpkf4ZWq9fZ
         A8anC4CovA0hh5WmcF2Rv8wrCTwCILBRaUeUisxwQM3QHHdweL9Hm41cVmcv9uLXFQdR
         8tIqJ0HDOd2zAqv1I0ppEhdh71NS6SemVLKFIwZgNAzz/7rznuisse4czpv26p9qPPFB
         3ENRLlD1Ghtd4KYy8jF6ZC+X/CtEMZ4WW6hGggIwImkIvkCPnASfGJVMWsQyD7JITWSr
         WNzDb2cESbqvCW9S2mODKqs+XaLrLnj144LRFTgOKhhcEBT5ypNl827UtjtLMDcDvS15
         Jbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PwKwpQLLF9Wx/gSr3MYc18IBLW4Vq6WXee7EmmVZzE=;
        b=JGTOUUv8j607BjhRnrgTeqs0Dh3+Yd3ZWr1f8b3QPGNDr4SqpxaEjNSnryg6D7yqCS
         7J0Jx/kD41uZQQlFEgQ2emEBFjm8+kDyhmldhEwzC9CzxtDAm1YHxrlMCX9eUpkqWBCC
         n4QgTr05Yvj901EkaWpVxpUdq3gVJVi63YKwcShY2ER6hnLCYSXLThQs9QmBgAPKHl1N
         Q8I818tR3Cnng6VrgI9FCCnLZuANRd4BTFpJFXCZDJ2Ffpoqnu0IK2BaGnClciFuLQ5w
         Q+7wNeQUYxGRKb5Jhph4ZKxuX9wNB6XwcHKEXNyi94+n404z2xXJPP71Af9VsWmNpz9E
         4Zgw==
X-Gm-Message-State: AJIora/i4/F5AQ6j1l0FDpttzrWMOKaZ6VPhCbkNidBBHH1XRfNPFeV7
        /eanjzu+QoNAT7b6/rFb5l/6bkact46NM6FfO62MyQ==
X-Google-Smtp-Source: AGRyM1vg1ycQXO0cRaiqy3RblWUH6i/XJr7OcEGztOHZOU4+8d5DVDP4vt3bXSWJWiXbN5xo+oDq6Txx+gQQAubXPqI=
X-Received: by 2002:a05:651c:2104:b0:25b:f4ed:db93 with SMTP id
 a4-20020a05651c210400b0025bf4eddb93mr166254ljq.295.1656537696638; Wed, 29 Jun
 2022 14:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <YrLtpixBqWDmZT/V@debian> <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X> <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
 <YrNQrPNF/XfriP99@debian> <CAHk-=wjje8UdsQ_mjGVF4Bc_TcjAWRgOps7E_Cytg4xTbXfyig@mail.gmail.com>
 <CAKwvOdmQKo4tZRLWxK2tTvd+OEtUmKJM7XiijLAF8JWMeUzFMA@mail.gmail.com>
 <CAKwvOdnfRnqBF8exO-Y1ooX=67TrO_8fSzgZwvUtidN_P31hzw@mail.gmail.com>
 <20220628224255.w4lmzalkx3qejuyg@treble> <CAHk-=wivq+i2-xp3WagixzQMBXaD4etMDmiTp5f-mgsfwOjxtA@mail.gmail.com>
 <20220629163400.cgeqmuu45zsyxtwq@treble>
In-Reply-To: <20220629163400.cgeqmuu45zsyxtwq@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 29 Jun 2022 14:21:25 -0700
Message-ID: <CAKwvOdm7=6M3pdHnqLFYkV21ypYpN4rTaNCe48dN3hWOOd+T2A@mail.gmail.com>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang support")
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
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

On Wed, Jun 29, 2022 at 9:34 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Wed, Jun 29, 2022 at 09:08:20AM -0700, Linus Torvalds wrote:
> > On Tue, Jun 28, 2022 at 3:43 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > So, something like this:
> >
> > No, clang should just be fixed.
> >
> > These UBSAN reports should usually be WARN_ON_ONCE.
> >
> > It's all the same issues we've had before: causing a panic will just
> > kill the machine, and gets us fewer reports.
> >
> > Now, UBSAN is something that presumably normal people don't actually
> > run on real hardware, so it's probably less of a deal than some. But
> > hey, maybe somebody wants to actually run an UBSAN kernel on a real
> > load with a full accelerated graphical UI and real drivers: a panic
> > may end up killing the kernel, and there you sit, with a dead machine
> > and no idea what went wrong.
> >
> > So the whole "panic if UBSAN reports something" is COMPLETE GARBAGE.
> > It actually makes the whole point of running UBSAN go away. You *lose*
> > coverage.
> >
> > So please don't make the kernel worse because clang got something like
> > this wrong.
> >
> > Just fix clang.
> >
> > And fix your mindset.
>
> Yeah, good point.  All the other UBSAN handlers (other than builtin
> unreachable) try to recover.  There's nothing special about divrem
> overflow which requires it to be fatal.
>
> So clang needs to stop assuming the divrem overflow handler is noreturn.

I haven't been able to verify in the generated IR or in LLVM sources
that that is the case; it doesn't appear to be any assumption about
__ubsan_handle_divrem_overflow being noreturn.

Instead, it looks like this has more to do with undefined behavior,
IIUC.  It seems that for `-fsanitize=integer-divide-by-zero`
(CONFIG_UBSAN_DIV_ZERO), we introduce new control flow to warn on div
by zero, but the results of the division are undefined, so
unconditionally trying to consume the result is UB.

So:

int foo (int x, int y) {
  return x / y;
}

doesn't check for divide by zero, -fsanitize=integer-divide-by-zero
introduces control flow to check for divide by zero and call
__ubsan_handle_divrem_overflow in that exceptional case, but the
result of the division is still undefined for that case, so control
flow that tries to use that result is simplified into using the result
in the non-zero divisor case, and calls to
__ubsan_handle_divrem_overflow followed by (what is effectively)
__builtin_unreachable().

For hahas I tried:

```
diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index d7aa5511c361..cb2eab660fd2 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -907,8 +907,11 @@ static ssize_t ufx_ops_write(struct fb_info
*info, const char __user *buf,
        result = fb_sys_write(info, buf, count, ppos);

        if (result > 0) {
-               int start = max((int)(offset / info->fix.line_length), 0);
-               int lines = min((u32)((result / info->fix.line_length) + 1),
+               int start, lines;
+               if (!info->fix.line_length)
+                       return 0;
+               start = max((int)(offset / info->fix.line_length), 0);
+               lines = min((u32)((result / info->fix.line_length) + 1),
                                (u32)info->var.yres);

                ufx_handle_damage(dev, 0, start, info->var.xres, lines);
```
That way we don't unconditionally consume the results of a possible
divide by zero, and that fixes the warning from that TU.  Does
inserting guards against divide by zero on the kernel side seem like
reasonable fixes for these warnings?
-- 
Thanks,
~Nick Desaulniers
