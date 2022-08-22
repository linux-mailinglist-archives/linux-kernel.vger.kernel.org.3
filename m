Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004F859C883
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbiHVTS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbiHVTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:18:33 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E00E52DD7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:17:32 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27MJGoj4021387
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:16:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27MJGoj4021387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661195810;
        bh=T4uH5LE9rwdE2mxLY8gFgbberK4lQnmO5E4/BP1T0DA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oOMkIlmfBMaDjJW4dvHHfRky0Hgs+xJ12QL9glru0xfZetX/NmPVnLyxJ9eee3raJ
         jWYxpgiDRn7zAflZrBAGzd2vIKv6i0tb1ZdnDGM9Czrdvk9iTSLyxEqMxN5lMEnRGc
         WIzxoR4fs955Z/4xo1qG+hqLoz2dflGX9+nIUHtj0ENaGxRiiWpAf7wboorDHlFj1s
         dUXEqaODyexu60xQ4cF1hiYis36SfHuuHFLEjlyHJQJvxFlaj9PlX57cu4EMStudjY
         0ZDK6X7Exlldc19ZSMLJIKqLKPP1ZNRwTTXBd+twesrNrUxOEvSRlY3AnGKGIouBiu
         kAiyr1Av8WkUw==
X-Nifty-SrcIP: [209.85.167.174]
Received: by mail-oi1-f174.google.com with SMTP id n124so2423918oih.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:16:50 -0700 (PDT)
X-Gm-Message-State: ACgBeo2kzVl6GCc5bSgenYunfeHzL8gLEh8FVA1CCXcpXm604wYBUSkN
        TEFvhZFMwuYktpqFickg8ar6C7J3uYUMSKdARjY=
X-Google-Smtp-Source: AA6agR717mpG90ugWMLiyVx+ynWHTylQ648Aa5m8evGr6iogFZUQOyFf7ESfDVv/rlQgqHWZEFafl+rzw0r/vsoWNjQ=
X-Received: by 2002:a05:6808:2099:b0:343:49f5:5300 with SMTP id
 s25-20020a056808209900b0034349f55300mr9252301oiw.287.1661195809494; Mon, 22
 Aug 2022 12:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <202208210645.72NkUj0g-lkp@intel.com> <CAKwvOd=VD-Oxtko-tq=GjcLZg5tNj_cMZwMhw7NqBbOYLxuidA@mail.gmail.com>
 <YwPPMK3ouRi0wJBT@dev-arch.thelio-3990X>
In-Reply-To: <YwPPMK3ouRi0wJBT@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 Aug 2022 04:16:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfDnUxuTEwiiN4FjGf3PdkDVJOidAON-CD4vyiatQx9g@mail.gmail.com>
Message-ID: <CAK7LNASfDnUxuTEwiiN4FjGf3PdkDVJOidAON-CD4vyiatQx9g@mail.gmail.com>
Subject: Re: [linux-stable-rc:queue/4.14 13/175] Makefile:877: *** Recursive
 variable 'LDFLAGS' references itself (eventually). Stop.
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 3:47 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Aug 22, 2022 at 10:05:50AM -0700, Nick Desaulniers wrote:
> > On Sat, Aug 20, 2022 at 3:51 PM kernel test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.14
> > > head:   ed8a2f4d20af62ebd64e4092d988d4ae6b54657c
> > > commit: 17c47886b521ae64a733f41364def799797e45ef [13/175] Makefile: link with -z noexecstack --no-warn-rwx-segments
> > > config: arc-randconfig-r043-20220821 (https://download.01.org/0day-ci/archive/20220821/202208210645.72NkUj0g-lkp@intel.com/config)
> > > compiler: arc-elf-gcc (GCC) 7.5.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=17c47886b521ae64a733f41364def799797e45ef
> > >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > >         git fetch --no-tags linux-stable-rc queue/4.14
> > >         git checkout 17c47886b521ae64a733f41364def799797e45ef
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> Makefile:877: *** Recursive variable 'LDFLAGS' references itself (eventually).  Stop.
> >
> > Thanks for the report!
> >
> > That's not something that I've seen before...
> >
> > Masahiro, does ARCH=arc do something special to LDFLAGS?
> >
> > This report is a randconfig against a branch of stable for arc, so
> > guessing this might be more obscure than usual.
>
> I suspect this would be fixed with commit ce99d0bf312d ("kbuild: clear
> LDFLAGS in the top Makefile"), which backports cleanly to 4.14.
>
> Cheers,
> Nathan

Ah, yes.
Please back-port that commit. Thanks!


-- 
Best Regards
Masahiro Yamada
