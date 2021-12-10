Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2D46F7DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhLJAK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhLJAKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:10:55 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66754C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 16:07:21 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id k4so6553723pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 16:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SqdngTwe2XgwyKo/Pb6E5PIDgu+YHowlqzredlDWUUo=;
        b=Jd8l4nJsc2zSy3FoSQRS8trukHPke0O1MMbpoDI0jJYlcyOpGieuJm0F9QluiYgAuh
         npM5r6/eGJs9MbC0HoAyWf8Xkg+P3DPPDePuXwFzMHR684pAXpCthxyBxOz0e414asVP
         n6SyJOmqJrty7bI94umXwBoCgnyUhvIy9vJoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SqdngTwe2XgwyKo/Pb6E5PIDgu+YHowlqzredlDWUUo=;
        b=qPFvwQEJY3qE8ipz/BiflDxCQrLBtCAp9jGTBbgdQkR0sOWHj5vF37vmOlLYsYHGvN
         134HKEpx/OSRDrcaw4Sg0W/evkZ2XJacVgaPiA1zDufodZRPBqgN9LszUDknUDv3OjVD
         Fd9fZlVf2JvCA/tb6JR96rzss2Z+pGJP98Js6rfexJh4mR+tGp6okdbpsI3gk+29t4db
         Y8RUztHg38gB/iH+t0Fbcjz8od65uNWWgQnqk/SZhpunle4nT8xOkkG2fnr1ctaSDOEj
         ekhxPnrexDfbvDkKVGcFyLRVWty3z2IrCquR7nFHSElMQQNxc3q7EGr34r/l36DiMyTe
         HyRg==
X-Gm-Message-State: AOAM530hIIoqQZfZQecyH3+bsSPuIAexNUVy1py9yyJxF9fubpRpiT8X
        wE1matxvwaY7+0uZDCbpvtWfVw==
X-Google-Smtp-Source: ABdhPJz35EhY8oQxfMnxhQU7gBZE3+hleuuy0wl+wkQUU0bxgF4SlRqsRr4ih1aduyWxCIzuHSJQkw==
X-Received: by 2002:a65:654f:: with SMTP id a15mr37161846pgw.195.1639094840689;
        Thu, 09 Dec 2021 16:07:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pi17sm11051645pjb.34.2021.12.09.16.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 16:07:20 -0800 (PST)
Date:   Thu, 9 Dec 2021 16:07:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question about all*config and COMPILE_TEST
Message-ID: <202112091542.BDA98658F@keescook>
References: <202112082057.C993DC6881@keescook>
 <CAK8P3a1wsa1makDonP8xdbMt5Tc4rU2a_4LDfXLpSp9+uFd73w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1wsa1makDonP8xdbMt5Tc4rU2a_4LDfXLpSp9+uFd73w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 08:45:30AM +0100, Arnd Bergmann wrote:
> On Thu, Dec 9, 2021 at 6:07 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > tl;dr: is there a way to force a config default to "off" under
> > all*config builds, but still leave it configurable? (i.e. not "depends
> > on !COMPILE_TEST")
> >
> > I'm trying to understand a Kconfig behavior with regard to
> > COMPILE_TEST. I'm able to use an "all*config" target, followed by specific
> > additional config changes (e.g. turning off KCOV), but I can't enable
> > things like DEBUG_INFO because of their "depends on !COMPILE_TEST".
> > Whenever I want to examine debug info from all*config build I need to
> > patch lib/Kconfig.debug to remove the depends. I was hoping I could,
> > instead do:
> 
> This would be a minor hassle for my randconfig testing because I really
> want to have DEBUG_INFO disabled when building randconfigs in order
> to keep down compile times. I could however just force DEBUG_INFO=n
> the same way as forcing COMPILE_TEST=y at the moment.

Right, yes, I want the default for DEBUG_INFO to be off for the
COMPILE_TEST=y case (for savings on speed, storage, etc), but I want to
be _able_ to turn it on when I'm doing whole-build binary comparisons or
pahole archaeology. :)

> 
> > I then thought I could use:
> >
> >         default !COMPILE_TEST
> >
> > since this works:
> >
> > config WERROR
> >         bool "Compile the kernel with warnings as errors"
> >         default COMPILE_TEST
> >
> > but I think the above is a no-op: it's the same as not having
> > "default COMPILE_TEST" when doing an all*config build: it'll be enabled
> > not because of COMPILE_TEST but because of the all*config pass.
> 
> Correct. One trick that works here is to use a 'choice' statement, as those
> still honor the 'default' value even for allmodconfig -- Kconfig has no
> idea which one of them is the 'all' version.
> 
> > How can I make DEBUG_INFO configurable, but default off under
> > all*config?
> 
> I'd try generalizing the "DWARF version" choice to offer 'none' as a
> default, like
> 
> choice
>        prompt "Debug information"
>        default DEBUG_INFO_NONE  if COMPILE_TEST
>        default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT if DEBUG_KERNEL
> 
> config DEBUG_INFO_NONE
>        bool "Turn off all debug information"
> 
> config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>        bool "Rely on the toolchain's implicit default DWARF version"
> 
> config DEBUG_INFO_DWARF4
>        bool "Generate DWARF Version 4 debuginfo"
> 
> config DEBUG_INFO_DWARF5
>         bool "Generate DWARF Version 5 debuginfo"
>         depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM ||
> (AS_IS_GNU && AS_VERSION >= 23502)))
>         depends on !DEBUG_INFO_BTF
> 
> endchoice

Ooooh! Yes, that's excellent. I will give that a try. Thanks!

-Kees

-- 
Kees Cook
