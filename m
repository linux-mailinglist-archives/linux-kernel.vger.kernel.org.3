Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1A54F5AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381968AbiFQKlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381847AbiFQKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:41:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691006B020;
        Fri, 17 Jun 2022 03:41:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q11so4119919iod.8;
        Fri, 17 Jun 2022 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=hNvnsHWLfPD5xPDN3K8AjGOxJosoF61E01tr2mE6ML4=;
        b=mxvBY8hnr2R7JJhQ/6fhF+aItSfMyYliSSHEVT+NEsHpZ8JkDUkGC7aaMxQO8Ozb56
         EtWBGwGYH5ZchsuMaT61MViWqT1FDdosAt6g9znU5U8XC4C2eS7aeyJyGhCHK0M6YtoS
         OZ9IIVR14pFqUxZGx/VJFl1s04gHgx6nBW6wO6AtudgK456sYBmJY7v7Fbjn1hSqKnLS
         gF22OWtsbj2nf/nPagSK3wvGhyDsv2nxV7vtaqE+I+ZkSx31KZa+RQq30lTXQb7VS2r8
         JXgpMsGOZ9a3lt0oDF3iejthclJ7aFA3H4WgTMnCw2IIbctcwbXOnldI/vNyROfTpwYF
         Hjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hNvnsHWLfPD5xPDN3K8AjGOxJosoF61E01tr2mE6ML4=;
        b=B3lJn69ZR46SQfoFzvvNcJQzKOSNHxpieOvS5wNEaDzC8YN/mqD1BgGeIolK1VVmsD
         xOEH9QgUHTls54PwkZ+kTRKEvMSgOffn2FQ77YEQusFPgllo+JxMXxqwK01vPNQRIVSW
         CCut0qYsiX5aObJ/i5z+Yu7FLZglFkWVXayk8yuW4yPtAq/HLwg9UFkDacEdB8x+Mf+e
         Hpii6Y0Yha4FcLAjbtNCBVHU7UyoqbVchfyTeKBqmoQUoL1x/GiAfpe0QtpvYn3YV1KQ
         K7CDkvBSZQbnEnGpR0ExN4X9tSbTpWxJFzYhM11Y8fvRBq/U1Hd5QH1GLvalwpFksZU2
         W4kw==
X-Gm-Message-State: AJIora+7MLormAChVHeJp4OaXTMlnaVck77k4DFQYeQJod1WF/HETehj
        8CWVE+ZrIMo5Wl94zK+wcB6pNvm+zw1r2DCK3QxT1ocAL/3DJw==
X-Google-Smtp-Source: AGRyM1uYI2dptv3O1zZTQ5QfVkXhSnrbYEq9oMlvshIgNDuRCZAMTFEXZI5rYrL9fQjUXY74glfaljjsiJrjS989c6M=
X-Received: by 2002:a05:6638:25c8:b0:332:198c:dbf6 with SMTP id
 u8-20020a05663825c800b00332198cdbf6mr5020981jat.52.1655462506715; Fri, 17 Jun
 2022 03:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104541.16289-1-jslaby@suse.cz> <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com> <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
In-Reply-To: <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Jun 2022 12:41:10 +0200
Message-ID: <CA+icZUXDGdPrPKUnevt99LUpTRPe=ogqF33uHQRYrQ6Kh-iTAw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
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

On Fri, Jun 17, 2022 at 12:35 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
> > > >
> > > > Until the link-vmlinux.sh split (cf. the commit below), the linker was
> > > > run with jobserver set in MAKEFLAGS. After the split, the command in
> > > > Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> > > > is lost.
> > > >
> > > > Restore it as linkers working in parallel (esp. the LTO ones) make a use
> > > > of it.
> > > >
> > > > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > Cc: Michal Marek <michal.lkml@markovi.net>
> > > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > > Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
> > > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > >
> > > Nice catch.
> > > ( I have seen some slowdown in my build-time. Will test and report. )
> > >
> > > Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> > >
> >
> > No measurable difference in build-time.
> >
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)
> >
>
> [ CC Nathan and Sami ]
>
> I re-checked as my build-time takes approx. 15mins more than usual
> with Linux v5.17.
>
> [ Perf - seconds time elapsed ]
> v5.17: approx. 12500
> v5.19: approx. 13500
>
> +1.000 secs = +16,67mins
>
> I am still investigating.
>
> I use LLVM v14.0.4 and CONFIG_LTO_CLANG_THIN=y.
>
> When I check for...
>
> $ egrep 'Makefile.vmlinux_o|jobserver-exec|link-vmlinux.sh'
> build-log_5.19.0-rc2-2-amd64-clang14-lto.txt
> 61414:  sh scripts/link-vmlinux.sh "ld.lld" "-m elf_x86_64
> --thinlto-cache-dir=.thinlto-cache -mllvm -import-instr-limit=5"
> "--emit-relocs --discard-none -z max-page-size=0x200000
> --build-id=sha1  -X --orphan-handling=warn";  true
> 61426:+ make -f ./scripts/Makefile.vmlinux_o
> 61427:  python3 ./scripts/jobserver-exec perl
> scripts/generate_initcall_order.pl arch/x86/kernel/head_64.o
> arch/x86/kernel/head64.o arch/x86/kernel/ebda.o
> arch/x86/kernel/platform-quirks.o init/built-in.a usr/built-in.a
> arch/x86/built-in.a kernel/built-in.a certs/built-in.a mm/built-in.a
> fs/built-in.a ipc/built-in.a security/built-i
> n.a crypto/built-in.a block/built-in.a lib/built-in.a
> arch/x86/lib/built-in.a lib/lib.a arch/x86/lib/lib.a
> drivers/built-in.a sound/built-in.a net/built-in.a virt/buil
> t-in.a arch/x86/pci/built-in.a arch/x86/power/built-in.a
> arch/x86/video/built-in.a > .tmp_initcalls.lds
> 61693:+ echo vmlinux: scripts/link-vmlinux.sh
>
> Plus vmlinux.o
>
> 61428:  ld.lld -m elf_x86_64 --thinlto-cache-dir=.thinlto-cache -mllvm
> -import-instr-limit=5 -r -o vmlinux.o -T .tmp_initcalls.lds
> --whole-archive arch/x86/kernel/head_64.o arch/x86/kernel/head64.o
> arch/x86/kernel/ebda.o arch/x86/kernel/platform-quirks.o
> init/built-in.a usr/built-in.a arch/x86/built-in.a kernel/built-in.a
> certs/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a
> security/built-in.a crypto/built-in.a block/built-in.a lib/built-in.a
> arch/x86/lib/built-in.a  lib/lib.a  arch/x86/lib/lib.a
> drivers/built-in.a sound/built-in.a net/built-in.a virt/built-in.a
> arch/x86/pci/built-in.a arch/x86/power/built-in.a
> arch/x86/video/built-in.a --no-whole-archive --start-group
> --end-group  ; ./tools/objtool/objtool  --hacks=jump_label
> --hacks=noinstr   --mcount  --orc  --retpoline    --static-call
> --uaccess  --link     --
> link vmlinux.o
>
> Pooh, truncated via Gmail? Attached as a file.
>
> Checking via ps...
>
> $ ps -ef | grep l[l]d > lld-jobserver.txt
>
> ...and top util shows me only one lld link-job is running (file attached).
>
> Unsure, if in my setup lld linker benefits from jobserver feature or not.
>
> Am I missing something?
>
> My kernel-config is attached.
>

Found this...

$ ld.lld-14 --help

  --thinlto-jobs=<value>  Number of ThinLTO jobs. Default to --threads=

-Sedat-
