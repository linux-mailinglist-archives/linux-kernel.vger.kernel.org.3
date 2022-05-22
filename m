Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54438530368
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346178AbiEVNuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244754AbiEVNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 09:50:17 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FF2DD58
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 06:50:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w130so15159280oig.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZsFbp/TkypbJ6xxbndSY+Bhahi8JlgpMjkR+ZudhCQ=;
        b=AEUEvcFSl6v+KQvUbyvVGzF1VebeEhH+MTRKedQGPZHE6VoAchVIOBNwj65sXvR8tp
         ayQzWMlqMrSuvtGIpxJ/5LpKaFBJ4Zn1yYlJT0pyF+XsLj9yii7PYgg6Tqq7aRw+8fx1
         1RWPaoWv3POumVxIt5dGzF6s6UZbrORgqd0g2fDhBsrYsmfxClgwsLAERbZEWWALVLoV
         hgCb1NkDwTsrlTvwqJyePWw+s38+C3S+W2LBgjyBQ1ZKDS/GxhGwz8X1xul98G4hXHIZ
         t00qTuNmrjdinUnlrgKFUfFMRpHSu7SOsnww1JXhTnQeENu8W9lfs/meuEGrE7pcwx5s
         gPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZsFbp/TkypbJ6xxbndSY+Bhahi8JlgpMjkR+ZudhCQ=;
        b=Mnb6OXQ9bdQJyyJv/6GlQQRVLprxsyQXMSLrUqhX4BqhcFkGW42BZ/qtbu1ZOY2C2p
         VO/PLaEQ8y341eKQENXRX+5wPNMVa1Y2DAkhZwV22Z8My7B++4oKSnzTITHFGWV66jgT
         7odbPwRPGUQIfc2vdOllewqt7SrV8YJfCsSdX961ljMtSTYaClSBWt+JqzTQvJYNHxwF
         gjBwRLFVCqCaBUpFIiVS0oWaiqZ2LgPYnTjeQMmdGsR9LFiwzZ/rU9gEsy/xsQwjuVBC
         UCdZYUCC852r//myGjgCOicc1nStF3yzXmwgl0tmrWVlLprQK3+qcAx03OUNC1JOIH0d
         wg3Q==
X-Gm-Message-State: AOAM533KbUpJrJlimRrZ7E2rj+W34q6wBhPznnn8Ykcrnaer9EXd8/pG
        aslporc0mMyX83hVMSoCmtGtMeMCsNjrX/lQ+UU=
X-Google-Smtp-Source: ABdhPJwrW7T1NShG18w+3A9FiWxy0AcQCecZiI879Fk0yPex+vPERDuckSkq4vXgT2K7gT2RQu9/TIWvKNO6cQWwRe0=
X-Received: by 2002:a05:6808:148e:b0:326:abe8:af49 with SMTP id
 e14-20020a056808148e00b00326abe8af49mr9829953oiw.73.1653227415472; Sun, 22
 May 2022 06:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <202205220745.AYB1Q33g-lkp@intel.com>
In-Reply-To: <202205220745.AYB1Q33g-lkp@intel.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Sun, 22 May 2022 09:50:04 -0400
Message-ID: <CANCKTBuu3M+5q=UY9Zc82vny4stMHCY+B_f7bSEz5RJT8wyZ5w@mail.gmail.com>
Subject: Re: arch/mips/bmips/dma.c:7:6: warning: no previous prototype for 'arch_sync_dma_for_cpu_all'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 7:16 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Jim,get_mac_address(struct device_node *np, u8 *mac)

$ stbsrv-and-01  3:51pm  [Cwd: /work3/jq921458/git/up-linux-arm64]
                         [Git: pci-regression-for-cm4-w1-v1  2dda4836141d]
$
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6c3f5bec9b40b9437410abb08eccd5cdd1598a3c
> commit: d552ddeaab4a15a8dc157ac007833aa0b3706862 MIPS: bmips: Remove obsolete DMA mapping support
> date:   4 months ago
> config: mips-randconfig-r004-20220522 (https://download.01.org/0day-ci/archive/20220522/202205220745.AYB1Q33g-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d552ddeaab4a15a8dc157ac007833aa0b3706862
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout d552ddeaab4a15a8dc157ac007833aa0b3706862
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/bmips/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/mips/bmips/dma.c:7:6: warning: no previous prototype for 'arch_sync_dma_for_cpu_all' [-Wmissing-prototypes]
>        7 | void arch_sync_dma_for_cpu_all(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +/arch_sync_dma_for_cpu_all +7 arch/mips/bmips/dma.c

Hello,
I will take care of this ASAP.
Regards,
Jim Quinlan
Broadcom STB

>
> d666cd0246f78b arch/mips/bcm3384/dma.c Kevin Cernekee    2014-10-20  6
> 56e35f9c5b87ec arch/mips/bmips/dma.c   Christoph Hellwig 2019-11-07 @7  void arch_sync_dma_for_cpu_all(void)
>
> :::::: The code at line 7 was first introduced by commit
> :::::: 56e35f9c5b87ec1ae93e483284e189c84388de16 dma-mapping: drop the dev argument to arch_sync_dma_for_*
>
> :::::: TO: Christoph Hellwig <hch@lst.de>
> :::::: CC: Christoph Hellwig <hch@lst.de>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
