Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7557057556C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbiGNSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbiGNSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:52:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F346BC18
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:52:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x10so2746725ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49yEzsvmawtcLnUgC2yQBZE5eXJRfHTmZ4ZvW7x4v9c=;
        b=hrGmrdgdTvFHno5/QTxcHC3PCTGFb4gMP0U3KyLiK9V2rGqR/D85NhUJ3AZjXLs1px
         rhLgTtPhGrvFuxgJ/VgsBqaKSFfGKYm86IOtWYefA+6glY1VXTK/qhDap+UY22HHfkNJ
         vZ8IsiZVaNaPX6Bbq5+Onmw3sjeRLKhphF2ZSOZHpBFaOUOVbz/xHQumxKLL7L6/aIUF
         tuzj3oGVfUiAqbuY3tRsL/pn23F+Noxex/K0jaFxhwYCEKn+7ZWIqaUaJ3hbigFN3a/J
         rBaYTIDRpFkX4InPJ1RYICmFjai5MTVDl99l64L3k3G0E/nLBcbEzOH6EDOQ+IEVixmq
         E6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49yEzsvmawtcLnUgC2yQBZE5eXJRfHTmZ4ZvW7x4v9c=;
        b=rh5WOlDJ1rr2cqQogjiMSilBlofDCgsAWzpNHLMUZhpx/jKHfUmOaTD0U19Sq8ZAzu
         329Qmi/vtaovIFW1KS16aWPyJQ5BBWmPXxc40fGmxFeuKxJNEEY34bav3u/SHMrFLTFA
         +s+GmNOPi461PIQYZAeME7K0Xa1PP2gKDPvG3BmBa0gSJ8puOGr6NeTPJDu+AzXlhXCm
         4BVybWaQR8WWwu92t6Ltp7r1AAmoyi4Y7fLW5u7XuaHiFP5JXUYgCvu5r2npRok6PpaS
         ZD0K3ygnpsxzMUUNGa6kIAhwIa1GGXiR19Tn+MIH7V7Vp+70uwRRJak0PjG1Zwr3JeGe
         yfJw==
X-Gm-Message-State: AJIora89sogsC+wRdc8XBCvIgjOp46NBDce6sefUU0yt00Lkp1VoYp76
        lIUrhuOPRnKe7KtpLjgUgMpxXKMOCOS1c4ppyl9aNA==
X-Google-Smtp-Source: AGRyM1v5WFvUhT4uy7cRgZ3s0XpRydE/lwxo9oq/CznFK8qS3NKe4Z/vQPPAvwjdNxDpqCwbMDMfWzcGpf04XwFb+u0=
X-Received: by 2002:a2e:a5cb:0:b0:25d:7a70:2891 with SMTP id
 n11-20020a2ea5cb000000b0025d7a702891mr5388267ljp.295.1657824723053; Thu, 14
 Jul 2022 11:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220714185514.7d1a2ac9@canb.auug.org.au> <Ys/42uMzQy+CFTGI@debian>
 <YtA+127QgRifnRBZ@dev-arch.thelio-3990X> <CADVatmOTNA8uVqDEx6kp=+_O=wEhV2jbS9-frct-c4ZqBxcspg@mail.gmail.com>
In-Reply-To: <CADVatmOTNA8uVqDEx6kp=+_O=wEhV2jbS9-frct-c4ZqBxcspg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jul 2022 11:51:51 -0700
Message-ID: <CAKwvOdmS2SugAzRSmQzWAmRgz642KEgTtOw5O3TvZwFSHU-fPQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 14
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Moving Stephen, linux-next, and lkml to bcc)

On Thu, Jul 14, 2022 at 9:22 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Nathan,
>
> On Thu, Jul 14, 2022 at 5:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Sudip,
> >
> >
> > In the future, consider CC'ing our mailing list (llvm@lists.linux.dev)
> > for any clang related issues so that we can get them taken care of ASAP,
> > we have a MAINTAINERS entry for a reason :) thank you for testing with
> > clang; the more people that use it, hopefully the easier it will be to
> > get things unbroken.
>
> Sure. I run arm, arm64, powerpc and x86_64 allmodconfigs with clang
> (along with gcc) every night for mainline, started with linux-next
> from today. Trying to setup the mips build also, I will mail llvm list
> asking for help with the mips build.
> Currently I only monitor the clang output from x86_64 as thats the one
> which builds. If you want I can send the other reports also.

Hi Sudip!
Right on, nice to hear from you.  Consider filing bugs in our issue tracker
https://github.com/ClangBuiltLinux/linux/issues (consider taking a
peak to see which are already known issues and commenting on those
rather than filing new ones, time permitting), and joining our meeting
(next one in two weeks) see https://clangbuiltlinux.github.io/ for
calendar invite and meeting link.

> I have added Lukas if you both think
> it will be good to collaborate.

Ah, yeah, Lukas is an old friend. Hi Lukas!
-- 
Thanks,
~Nick Desaulniers
