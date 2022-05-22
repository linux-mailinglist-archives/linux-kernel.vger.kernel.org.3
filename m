Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4290A530161
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbiEVGul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 02:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244601AbiEVGuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 02:50:39 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145CA366A8;
        Sat, 21 May 2022 23:50:36 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 24M6oAek017213;
        Sun, 22 May 2022 15:50:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 24M6oAek017213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653202211;
        bh=5TwfumVCNM+fvix8eWg6i86pc65IzESlNEbAwwhHqrU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ojV6XLeO60FMwlo+YWIjhWtRGEEawpk4CVTb4L9aglvOsxoK5f7z7QbZSOZfJ/tak
         alBhcAPXcIxYqPD77l9IRzaTuM1+hmJzoN/AY0CLlXq3RF133ODYyShafJ1NmxJjCa
         q0lpyWHvIylOEdH/w5NWWS57WrNaaAJ1LH6EpwkqOq/sHCzQtTbTby/WMAjGehyBu4
         kVp9a8pzx79AFXB+F86AeNMng169Yna619lykZelRBT/YmqMzU/NmFg613kiYe1zhM
         gliHIyRLAvkJUkXtL+XM5BQLs9Sn5t2kQlyC6svng8bF7Ur/kDDSJ0tasHLmdhpwVA
         4ZAHOIk6oYabQ==
X-Nifty-SrcIP: [209.85.210.176]
Received: by mail-pf1-f176.google.com with SMTP id j6so11048580pfe.13;
        Sat, 21 May 2022 23:50:11 -0700 (PDT)
X-Gm-Message-State: AOAM532fMMBst104p0OK6IfasNpJJ+yYm0/NoVVgVsywwWk3D97q1g1L
        YfOKYFhFVqsZOA/3WLXxgrlEa/opzqqV8kKt0/c=
X-Google-Smtp-Source: ABdhPJxhJ2rh9Olkm7eNlJF8gpCf6NRGhN1KHbnGfK8m1IcXzz+fxX+v0f9XGq/1eBPx2nbsbhKNAZoEfz+GfSITou8=
X-Received: by 2002:a63:9043:0:b0:3f9:6c36:3de3 with SMTP id
 a64-20020a639043000000b003f96c363de3mr8127619pge.616.1653202210391; Sat, 21
 May 2022 23:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org> <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <CA+icZUUWww3fXvjQcefgFuq=tPO6+FYDbHE2E5PmL-BSJg4+cw@mail.gmail.com>
In-Reply-To: <CA+icZUUWww3fXvjQcefgFuq=tPO6+FYDbHE2E5PmL-BSJg4+cw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 22 May 2022 15:49:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNATx1QcM6BdqBSascV8J8rD6etRgRZj9PjBno5Qrb=p3Yg@mail.gmail.com>
Message-ID: <CAK7LNATx1QcM6BdqBSascV8J8rD6etRgRZj9PjBno5Qrb=p3Yg@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 10:45 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, May 13, 2022 at 4:31 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Fri, May 13, 2022 at 8:42 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > >
> > > This is the third batch of cleanups in this development cycle.
> > >
> >
> >
> > This series is available at
> > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> >  lto-cleanup-v6
> >
>
> Hi Masahiro,
>
> I cloned the repository on top of latest Linus Git.
>
> Not able to boot in Quemu - Not able to boot on bare metal.
>
> $ grep module_layout log_quemu-5.18.0-rc7-2-amd64-clang14-lto.txt
> 366:[    2.173265] floppy: disagrees about version of symbol module_layout
> 367:[    2.198746] scsi_common: disagrees about version of symbol module_layout
> 368:[    2.205573] i2c_piix4: disagrees about version of symbol module_layout
> 369:[    2.210610] psmouse: disagrees about version of symbol module_layout
> 370:[    2.225138] scsi_common: disagrees about version of symbol module_layout
> 371:[    2.235536] scsi_common: disagrees about version of symbol module_layout
> 375:Begin: Running /scripts/local-premount ... [    2.298555]
> crc32c_intel: disagrees about version of symbol module_layout
> 376:[    2.303335] crc32c_generic: disagrees about version of symbol
> module_layout
> 377:[    2.306667] libcrc32c: disagrees about version of symbol module_layout
>
> Infos: LLVM-14 + CONFIG_LTO_CLANG_THIN=y
>
> My linux-config and qemu-log are attached.
>


Thanks for your testing.

I was also able to reproduce this issue.


The problematic parts are:

[    2.298555] crc32c_intel: disagrees about version of symbol module_layout
[    2.303335] crc32c_generic: disagrees about version of symbol module_layout
[    2.306667] libcrc32c: disagrees about version of symbol module_layout



When CONFIG_LTO_CLANG_THIN=y,
I cannot see any __crc_* symbols in "nm  vmlinux".

Perhaps, LTO might have discarded all the __crc_* symbols
from vmlinux, but I am still checking the details...



-- 
Best Regards
Masahiro Yamada
