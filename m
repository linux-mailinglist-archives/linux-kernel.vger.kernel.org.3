Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3C0598C99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbiHRTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbiHRTcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:32:25 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF970CC314
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:32:23 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 27IJW6rw021713
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:32:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 27IJW6rw021713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660851127;
        bh=NcvUJaEQ6y315S3poHspeF5ySWLtVyWcy6yD+juzm2Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DM5yvujMwCDGQ2RMS+YN1Ig2malegXoHWowQQfCbOcctkiItYyi+SlR8M5IymD7dd
         eX7blbVXg6wex3vrDKvApBc9i+MGbckVUgCPf2ju4DlHSOS9lRIi291EkZe1v0/eC9
         LzZLBb8LgVdSLqAnj84xx9d75xwMAZAvxy3+NqZ85COoLl38RQmwlLC6QaJdQTIScP
         j8Yr81rPXNQyJwEVCSrS7H0wVr7WlZKHvhe4g5398HRXb1KgrAUfEs8ljsLnzRnwal
         5z6qwC36ErxYrbVkviMDor3C5c7GrIaFrSjpuhlQAOCnGJzJ0od2sE/vh/shWU3V9x
         BVNERv27CJ42w==
X-Nifty-SrcIP: [209.85.221.49]
Received: by mail-wr1-f49.google.com with SMTP id n7so2842953wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:32:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo1lpgvMpxe4VMNHGEsxc0QAdRx8pECwBS5y1ZB7ZsaX1xsp/Cut
        Du6yWzixlsMJ5Qf3iv1lz10bGL1LoZgSJh5SnXI=
X-Google-Smtp-Source: AA6agR6ftUsRsJrkQr0reVqKHXlXymwPfQaYkHisXC4DU3zbYS56buTiIYGOB4Et+wAwd214SsYH1CQM2LrzxIeaC90=
X-Received: by 2002:a05:6000:1acb:b0:223:5de3:f8bf with SMTP id
 i11-20020a0560001acb00b002235de3f8bfmr2356542wry.691.1660851125479; Thu, 18
 Aug 2022 12:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
 <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
 <7eacd1d9-42ba-fd61-7f37-0635cebcb33d@infradead.org> <e902a360e3759c7f87d98d71d79a0d5cbe935e3e.camel@linuxfoundation.org>
In-Reply-To: <e902a360e3759c7f87d98d71d79a0d5cbe935e3e.camel@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 19 Aug 2022 04:31:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNART2XQYy2hN1afODbuCMj+_VX9Ojh5nVCoY-hwXRAwSWA@mail.gmail.com>
Message-ID: <CAK7LNART2XQYy2hN1afODbuCMj+_VX9Ojh5nVCoY-hwXRAwSWA@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash
To:     Richard Purdie <richard.purdie@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 6:14 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2022-08-17 at 16:52 -0700, Randy Dunlap wrote:
> >
> > On 8/17/22 16:46, Nick Desaulniers wrote:
> > > On Thu, Aug 4, 2022 at 12:03 PM <alexandre.belloni@bootlin.com> wrote:
> > > >
> > > > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > >
> > > > When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
> > > > with a syntax error which is not the one we are looking for:
> > >
> > > Thanks for the patch, though I think I'd rather see `/bin/bash`
> > > hardcoded. Bash is a non-optional requirement as of
> > > commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for
> > > process substitution")
> > > scripts/ is kind of a mess...
> > >
> >
> > Well, once upon a time, we took patches to remove bash-isms (convert to
> > standard shell)...
> > No longer, AFAICT.
>
> This problem is a little more subtle.
>
> As far as I could work out, exec() is used on entries like this in
> kConfig. exec() falls back to /bin/sh so it is hard to see where this
> would be changed to be /bin/bash.



Kconfig uses popen() to execute a shell command.

See do_shell() in scripts/kconfig/preprocess.c



popen(3) says that
"the command is passed to /bin/sh using the -c flag.
interpretation, if any, is performed by the shell."



GNU Make is the same.
Make uses /bin/sh to execute commands in
recipe lines and $(shell ...) functions.
You can change the default shell via 'SHELL' variable.





>
> I have no issue with bash being required and used and if someone can
> work out how to make that happen for the exec() calls, I'm fine with
> that. It would probably require some parsing of the "code" being passed
> to kConfig to decide how to call exec().
>
> What worries me is seeing the kernel behaviour changing depending on
> whether /bin/sh is dash or bash and I think that should be fixed as a
> more urgent matter.
>
> I'd hope Alexandre's patch could be taken in the meantime as it doesn't
> really hurt anything and does fix a very unexpected behaviour change
> depending on the host system setup.



Agree.

We should apply a simple patch to fix this particular case
(I suggest to drop '\n' unless there is a reason to have it)
but discussion is needed to avoid portability issues like this.






One way is to encourage writing really portable code.
We used to strive for this (so we avoided bashism where possible)
because we believed sticking to POSIX was always good.

Some people make an effort in this direction [1], stating that
bash may not be installed, and bash is slower than dash.

In shell commands, we can use only commands/options defined in POSIX.
This is fragile because we do not have real /bin/sh,
and it is difficult to know what is POSIX-compliant.

People submit a script with #!/bin/sh but only tested on
environments where /bin/sh is a symlink to bash.








Another (and the opposite) way is to force users to use a particular
program like bash.

Actually, Googlers suggest this way.

Shell Style Guide [2] says:
"Bash is the only shell scripting language permitted for executables."


If we are forced to use bash, it should work in the same way for everyone.
We do not need to know what is POSIX-defined, and what is bashism.

I was thinking this way for a long time.
I wrote some patches to switch the default shell for Kbuild and Kconfig to bash
some time ago, but I did not submit them after some consideration.
I have patches in my local repository, I can share them.







BTW, Richard is here, so let me ask about BitBake.

The manual [3] clearly says:

"When you create these types of functions in your recipe or class files,
you need to follow the shell programming rules. The scripts are
executed by /bin/sh,
which may not be a bash shell but might be something such as dash.
You should not use Bash-specific script (bashisms)"

I just thought BitBake ran shell code in bash before,
but I might have misunderstood.
Do OE/Yocto allow only POSIX shell code?




[1]: https://lore.kernel.org/linux-kbuild/CAK7LNAT+4fOkJ5WDb9t5qXCqS+GhnbnG8wBffxNa1ZJ3=4Ps3Q@mail.gmail.com/T/#m74e382837a8a47a2278d892bc5d7f8bdbb86dba4
[2]: https://google.github.io/styleguide/shellguide.html
[3]: https://docs.yoctoproject.org/1.6/bitbake-user-manual/bitbake-user-manual.html




--
Best Regards
Masahiro Yamada
