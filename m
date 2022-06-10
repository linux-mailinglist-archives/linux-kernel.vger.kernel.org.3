Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C7B545FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348271AbiFJIqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348256AbiFJIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:46:37 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891163B3D9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:46:35 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id 68so10998750qkk.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDHFkgu1+zpzbiMkbVNAjHtd/giuN+UF6Mx7hyw7oKQ=;
        b=6QxGnXWQ0Cg5ZmR4nLXJDPLMWCl7WB/+ArxwtKQSvgL94E9qpncpPsH5LX7FraratJ
         KMpiBvpUnSd1G2QpRh/3F3tl7NDkIWYJ/MSGNblrsYbMjQVW3h/E/7YKkHc2IOlUQIQZ
         aIaXiTm3xhlEAeo6PqmAJDA1dhAAs/U3IdCLe7AzR6D/bYCDZAA9GgdYbk2xm/yDnnDl
         /wRP9ostp9JSGAMZh3vRryFsXTo+gp1utaEH3qmZXGEGw9Pv2JuNRBydLCRluW43H1a7
         kYv5NSfyYV0zc7emcPfcr+9psZDyistFjGRMGHJFrJkQCIEutm1phB6vKQNv84U9zdxe
         wQyQ==
X-Gm-Message-State: AOAM532UzvBAMr5iFUT4UtzHEvpOIPfA8FQPiwMrjibjG64QE7jNGeOd
        oGDCfWzWZclteqRNNhBwe9g9r/AFm+reGg==
X-Google-Smtp-Source: ABdhPJzxzga9TnrJ4WpZKbgcEAojo0aMKwQ8MKHX3wmwQjDR78veTrDp9QG3Gu2OnXu0aC1Ifdt/4g==
X-Received: by 2002:a05:620a:4044:b0:6a6:ab00:d4c9 with SMTP id i4-20020a05620a404400b006a6ab00d4c9mr22019963qko.305.1654850794455;
        Fri, 10 Jun 2022 01:46:34 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id ci6-20020a05622a260600b003050de40028sm3027542qtb.84.2022.06.10.01.46.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 01:46:33 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-30c143c41e5so265562677b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:46:33 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr47246570ywa.47.1654850793149; Fri, 10
 Jun 2022 01:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <202206100855.uY63FJUH-lkp@intel.com>
In-Reply-To: <202206100855.uY63FJUH-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Jun 2022 10:46:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVGdzkaT=SR2OWoN9S=Xr-2Ckki41P_p7t4WDgRLzfuGg@mail.gmail.com>
Message-ID: <CAMuHMdVGdzkaT=SR2OWoN9S=Xr-2Ckki41P_p7t4WDgRLzfuGg@mail.gmail.com>
Subject: Re: {standard input}:3978: Error: value 178 out of range
To:     kernel test robot <lkp@intel.com>
Cc:     Sumit Saxena <sumit.saxena@broadcom.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 2:47 AM kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6bfb56e93bcef41859c2d5ab234ffd80b691be35
> commit: 43ca110050988c7a0e581d24ce212ef34a4cdf29 scsi: mpi3mr: Add support for PEL commands
> date:   5 weeks ago
> config: m68k-randconfig-r036-20220608 (https://download.01.org/0day-ci/archive/20220610/202206100855.uY63FJUH-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=43ca110050988c7a0e581d24ce212ef34a4cdf29
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 43ca110050988c7a0e581d24ce212ef34a4cdf29
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    {standard input}: Assembler messages:
> >> {standard input}:3978: Error: value 178 out of range
> >> {standard input}:3978: Error: value of 178 too large for field of 1 byte at 00000fdb

This failure happens while building drivers/scsi/mpi3mr/mpi3mr_fw.o.

How to check:

    make ARCH=m68k drivers/scsi/mpi3mr/mpi3mr_fw.s
    make ARCH=m68k V=1 drivers/scsi/mpi3mr/mpi3mr_fw.o

Run the output from the last command with mpi3mr_fw.c by mpi3mr_fw.s,
so you will get sensible line numbers:

    drivers/scsi/mpi3mr/mpi3mr_fw.s: Assembler messages:
    drivers/scsi/mpi3mr/mpi3mr_fw.s:1849: Error: value -168 out of range
    drivers/scsi/mpi3mr/mpi3mr_fw.s:1849: Error: value of -168 too
large for field of 1 byte at 3175

Note that the value differs, but I'm using a different compiler
(gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04)).

The offending instruction is:

    | drivers/scsi/mpi3mr/mpi3mr_fw.c:299:  switch (host_tag) {
            mvz.w %d2,%d0   | tmp160, host_tag
            mov3q.l #5,%d1  |,
            cmp.l %d0,%d1   | host_tag,
            jcs .L154               |
            tst.w %d6       | host_tag
            jeq .L133               |
            subq.l #2,%d2   |, tmp238
            mvz.w %d2,%d2   | tmp238, tmp240
            mov3q.l #3,%d0  |,
            cmp.l %d2,%d0   | tmp240,
            jcs .L140               |
            add.l %d2,%d2   | tmp244
>>>         move.w .L155(%pc,%d2.l),%d0     |, tmp245
            jra .L186               |

And the table L155 is just too far from the above instruction, so
the displacement is too large, causing the failure.

Looks like a compiler bug to me?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
