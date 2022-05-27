Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D395C53577A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiE0CVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiE0CVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:21:01 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05CAE2782;
        Thu, 26 May 2022 19:20:56 -0700 (PDT)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 24R2KP5F014480;
        Fri, 27 May 2022 11:20:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 24R2KP5F014480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653618025;
        bh=qaXGWm36XsMpK0YHSBcEjrBjV1N23G1+rvNZIJeUxz0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cVlG5rLeqP7ynBhNw8kq8O+Ix/y26Q/eFRFfYAyvjQ/BlMBEuZv3QNulfQOHoO2DY
         bMYkKWBs+NzbaE3LExgOq03BkGJgOxg/Cvv1QIWbRA15NUscIDA1bv3MuXxIT1rV7L
         bGz8k46bG83yD7P3bOtY21+1OMW82WZ4xvHQlonJdUyz3SD6NGeo1fA0eyzf9rxt+d
         z2UiYqKua1WATfcVQN05p5+VUzTc64mdw0PsStZJVmP08KCgm1r6W6wKp2xSKKpf7d
         i3tgrA74cOKaTwLXtRfbVSXu5yrmmShcoGlYmS/vK/9KgCRhfKtYF67+W16BWUfAU9
         /2hG5f7mt94FA==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so2009839pjb.1;
        Thu, 26 May 2022 19:20:25 -0700 (PDT)
X-Gm-Message-State: AOAM530R9/Wej8twHRZsQXFsVq+Xzgzzrk84LHspK4uDUsK32YZv9ELy
        GW9RASThjbZy9WbqLXgOKnllVtEJuls+22jtA/4=
X-Google-Smtp-Source: ABdhPJw18G/tZO61wmb0rN2KnjQCfnb44OFAHqqsrbPt3jMhR5jcSY59Xc0L4ljUHZTVF8bfNqgoMkYhe1v8eBMQU1s=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr40916303plh.99.1653618024744; Thu, 26
 May 2022 19:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220523142431.10ff2f77@canb.auug.org.au> <20220523154758.11668628@canb.auug.org.au>
 <20220523162307.45dycvqld7maaj7l@treble>
In-Reply-To: <20220523162307.45dycvqld7maaj7l@treble>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 27 May 2022 11:19:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5XWPhmTJV42sYiFCDan6DfB8gsOCJOWiqz4MV1cdE4Q@mail.gmail.com>
Message-ID: <CAK7LNAR5XWPhmTJV42sYiFCDan6DfB8gsOCJOWiqz4MV1cdE4Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the kbuild tree
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Josh,

On Tue, May 24, 2022 at 1:23 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Mon, May 23, 2022 at 03:47:58PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > On Mon, 23 May 2022 14:24:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Today's linux-next merge of the tip tree got a conflict in:
> > >
> > >   scripts/Makefile.build
> > >
> > > between commit:
> > >
> > >   0212301af7bb ("kbuild: do not create *.prelink.o for Clang LTO or IBT")
> > >
> > > from the kbuild tree and commit:
> > >
> > >   753da4179d08 ("objtool: Remove --lto and --vmlinux in favor of --link")
> > >
> > > from the tip tree.
> > >
> > > I am not sure if I fixed this up correctly, please check the final result
> > > when linux-next is released.
> > >
> > > I fixed it up (I used the former version) and can carry the fix as
> > > necessary. This is now fixed as far as linux-next is concerned, but any
> > > non trivial conflicts should be mentioned to your upstream maintainer
> > > when your tree is submitted for merging.  You may also want to consider
> > > cooperating with the maintainer of the conflicting tree to minimise any
> > > particularly complex conflicts.
> >
> > That produced may warnings :-(   so I tried the below resolution instead.
>
> Looks good to me.  I guess the confusing bit was that in most cases,
> CONFIG_STACK_VALIDATION has been replaced with CONFIG_OBJTOOL.
>
> --
> Josh


Is this really a correct fix up?

I checked the linux-next.

It added:

$(obj)/%.o: linked-object := y

so, --linked is always passed.


Apparently, it changed the behavior.



[1] original behavior in Josh's commit

$ git checkout 753da4179d08b625d8df72e97724e22749969fd3
$ make defconfig
$ make -j8 kernel/
$ head -n 1   kernel/.fork.o.cmd


I do not see the "--linked" parameter in the objtool command.




[2] behavior in linux-next


$ git checkout next-20220523
$ make defconfig
$ make -j8 kernel/
$ head -n 1   kernel/.fork.o.cmd

I see the "--linked" parameter in the objtool command.

kernel/fork.o  is a direct output from GCC,
not from linker.






Josh,
Could you tell me:
when should --linked be added?
(and when should --linked not be added?)








--
Best Regards
Masahiro Yamada
