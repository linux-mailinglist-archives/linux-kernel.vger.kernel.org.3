Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B82451E6DC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446348AbiEGMXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiEGMXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:23:01 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF11A05F
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:19:13 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x9so7858447qts.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+oiGSCZb6NX25tsDNXkBW7Afl7nrsXXqru9rnhpvLU=;
        b=EVjVfXPYIT2pl1sW+WbBkp92OXUctBj433s+LBnmcW97uRKsPbxvx8bTWykOj7zQsr
         TNnujS8Pb49zFu16u0ddLu3VKMjDcbfC6fXazegN8+f0mE3WAL1eV2SWMZWF3SeBguYU
         Nhe8OO+Me6dzKehUPX5jOjwosHi9CRmaDd1nwtIKaocOYuFIg+qtpDXGXO+KGeVArJGD
         4S9wUxxLXlhiG0VGwFrTLINb08hqJfEyko4cUJi22tnorrbQit3Zk+2z2vPue2U0/7TU
         w47mD/gDrZ0ugqCxN1epRr3FceAe/MsC6iTsw1NwA52fOki95Q7IIaG1yt4pZR4SesjS
         Cieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+oiGSCZb6NX25tsDNXkBW7Afl7nrsXXqru9rnhpvLU=;
        b=TSjGa/cGm3pjse+Ih6UEXtDdp++zA3njiG0OwLws07IX6WH4oEvADybN73+lFV9yx9
         V5u1oWWpunUZoe36WT7B339wGM3QLZCLrIBS6E8AcnT4Jtx4+GYG8ENOCfndD9TouBPA
         g8peAf1IEx9hpp7uzjb7rIbSasc2fHEq4nyVPHHcJHP2Ni0Za6EXJpQSGP2ADya1Q41E
         S+AmPLgGZD5lLOTz1zq9D4a9R1liBcA+rXlVkgdUY0xm0gBOxLwIIzbEJsQDnD+Lu8GZ
         Rj+u1B3vc7HvMd7q4WLWkKGeogL6UHjfXr9bRPwzrYLBgTm8/XWuUwNGmxV8pA4R6RLX
         8Z8w==
X-Gm-Message-State: AOAM532vTuou9cpA27gDrACwpN1yUDkFu2m0Og3E54S9V1NNTE+/dres
        KKkw+/VagEze7Y3FhhOIajLGfOJUF+oHYnh04iw=
X-Google-Smtp-Source: ABdhPJx7wlfjWdeqEwgKDAGwo8OCpkZMyW9++BoZIi/ZIEDmLSzP4QUQMRq/5r+8+GSG4TnCXGtyUkhmypL2Xin0baM=
X-Received: by 2002:a05:622a:134b:b0:2f3:d11e:3865 with SMTP id
 w11-20020a05622a134b00b002f3d11e3865mr1552279qtk.329.1651925951403; Sat, 07
 May 2022 05:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
 <Ym2qdHAB6BMMlegB@thelio-3990X> <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
In-Reply-To: <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
From:   Mauro Rossi <issor.oruam@gmail.com>
Date:   Sat, 7 May 2022 14:19:00 +0200
Message-ID: <CAEQFVGby3Q1mf1GGJwkFyAgaq38NvVAMx6tQM+9LO+HE8Z8Z8A@mail.gmail.com>
Subject: Re: arch/x86/entry/entry: RFC on recent kernels building error with
 llvm 11.0.2 internal assembler
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     luto@kernel.org, Chih-Wei Huang <cwhuang@android-x86.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>
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

> > Alternatively, you could apply the hack that Nick inserted into Android
> > for this issue if upgrading your toolchain or turning off the integrated
> > assembler is not possible:
> >
> > https://android.googlesource.com/kernel/common/+/e58f084735b8abf744d61083b92172ee23d45aae
> >
> > I really do not mean to sound dismissive or rude, I apologize if it
> > comes off that way, but we have worked quite hard to avoid inserting
> > unnecessary workarounds, as they are ultimately technical debt that can
> > be hard to manage over the long term.
> >
> > Cheers,
> > Nathan
>
> Thanks a lot Nathan
>
> It is definitely the clang version 11.0.x which is not updated in aosp
> Android 11 production tags
>
> I will use Nick's workaround which works since only lsl %rax, %rax is
> currently happening
>
> Many thanks, problem solved

Hello,
I'm back again because I was assuming that Nick's workaround was working ok,
but I have found that ARCH=x86_64 i.e. 64bit built kernel is causing
an immediate hard reboot at initrd execution,
just after hitting [ENTER] at grub/efi menu.

ARCh=x86 i.e. 32bit kernel binary is not affected, but is Nick's
workaround targeting 32 bit kernel builds?
Should it be modified to work for 64bit kernel binary?

How do aosp android-mailine kernels avoid this instantaneous hard reboot issue?
Mauro
