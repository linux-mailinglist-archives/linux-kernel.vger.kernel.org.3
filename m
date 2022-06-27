Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9882055D4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiF0GVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiF0GVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:21:05 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651AF2BCC;
        Sun, 26 Jun 2022 23:21:04 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s17so8548757iob.7;
        Sun, 26 Jun 2022 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+Ua18/p8hkHhPEFibJ7/14yqoaJ6Vlr8Bwa0LwoGmco=;
        b=AgGZJExEG28jIEYgz0q7+FWzHtSIrG685VZQRA0qSFwJOzD0b5+SfHxij9xZXoPYQ0
         EYrr3Sr2h72eK2PK9o4Ri0E3T4mds7HlVYApbtVhMj5WChyv2JQrkgQiF9fzVcrzRttf
         WuD26hfwQXAaqToChLfQsqycbE4QKTkaosnOC6h6pLk2ozxzyZyy+NHvwmh+5YcE6aDn
         f4UkIeg88PxhuGOoeF69lPb5WSK/0GkzAgkN/HUxxGDMX6TFzUf6QocWwlXATWxvMcvs
         LjLt1gR1lEXzgbBrz5fJcbMxKkhad+VTKPG7z+DFqtjgpavSVZ46mblqfNIw5wOvGS99
         6kxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+Ua18/p8hkHhPEFibJ7/14yqoaJ6Vlr8Bwa0LwoGmco=;
        b=PJXgEfKx/B1sZhOtcHr75H6zy9sS6OJC6ko2xhqRJWSt5VG7W4JfQ+NA8f0YIUjZ57
         carhtb85yaWFp0r1WtebjDm2QbkhQf4Ri6Pb+YT+SDIqiSq2KdroOp9Yz48t43qDpHF7
         5lz6C1Ch7Hw3JglfV5ychLhSFEchxaaZwaf6AfLDBtxDa55CgB7JSFoliOKN/Ci/zQRU
         JPUBPe6OR6VcmxPpJ8/TXqN/Tolntynwj9k7OLemVLTDf4jZTEL62mpLAfyyFory4m+D
         OqhsRT+HylnUQ29DVmTO0vE0u7ywhfNGmDUtG/nr9o5eHru/x5vhSR+GZb1I2VqdZbcr
         0uLw==
X-Gm-Message-State: AJIora9HUeQHpUAY4Gx23qyi8vDbEuqdlvRusXUiEU6Zo9t1K++cBuCp
        E36erKG/Cz+KUHaatay0TIZo19IW307vZWakzGY=
X-Google-Smtp-Source: AGRyM1spyVdearMCY8BhTc2GpLt3ndrewBGOYQFb3iYqgwxAOES/t4SaLMpcB+yWfLPLRcNF6K4toXeKvJBs+ISL25A=
X-Received: by 2002:a05:6638:1415:b0:331:d318:83ab with SMTP id
 k21-20020a056638141500b00331d31883abmr7162512jad.126.1656310863812; Sun, 26
 Jun 2022 23:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220607000851.39798-1-irogers@google.com> <CA+icZUWpSF6ge76JVp1qBC5QhC1AwNacs5Di=e1QSbAD+SVKUA@mail.gmail.com>
 <YqjggY64PKfog0YW@kernel.org> <CA+icZUUx_Re+w9S7eHXma9aC=8T8ypp8=+tkJy7zJMrUocMSKQ@mail.gmail.com>
 <Yrh7uSL0AybSqd0V@kernel.org>
In-Reply-To: <Yrh7uSL0AybSqd0V@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 27 Jun 2022 08:20:27 +0200
Message-ID: <CA+icZUXt8rBadACnXPUdeQbR_nJbqYG+pGPF=767jHV+B2uYsA@mail.gmail.com>
Subject: Re: [Linux v5.19-rc1] tools/perf/a.out remains after make -C
 tools/perf clean
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Jun 26, 2022 at 5:31 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Jun 15, 2022 at 12:11:48AM +0200, Sedat Dilek escreveu:
> > On Tue, Jun 14, 2022 at 9:24 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Tue, Jun 07, 2022 at 08:59:31PM +0200, Sedat Dilek escreveu:
> > > > Hi,
> > > >
> > > > I observed this some time ago - so this is not only Linux v5.19-rc1 related.
> > > >
> > > > $ LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt
> > > > make: Entering directory '/home/dileks/src/linux-kernel/git/tools/perf'
> > > >  CLEAN   x86
> > > >  CLEAN   libtraceevent
> > > >  CLEAN   libapi
> > > >  CLEAN   libbpf
> > > >  CLEAN   libsubcmd
> > > >  CLEAN   libperf
> > > >  CLEAN   fixdep
> > > >  CLEAN   feature-detect
> > > >  CLEAN   python
> > > >  CLEAN   bpf-skel
> > > >  CLEAN   core-objs
> > > >  CLEAN   core-progs
> > > >  CLEAN   core-gen
> > > >  CLEAN   Documentation
> > > > make: Leaving directory '/home/dileks/src/linux-kernel/git/tools/perf'
> > > >
> > > > $ git status -s
> > > > M tools/perf/util/unwind-libunwind-local.c
> > > > ?? tools/perf/a.out
> > > >
> > > > $ rm -v tools/perf/a.out
> > > > 'tools/perf/a.out' deleted
> > > >
> > > > $ git checkout -- tools/perf/util/unwind-libunwind-local.c
> > > >
> > > > $ git status -s
> > > > [ empty ]
> > >
> > > Interesting, since Linus complained at some point that after building
> > > perf some new temp file was left there I added 'git status' to my
> > > scripts to always get this flagged.
> > >
> > > I'm not seeing this here.
> > >
> >
> > Just re-checked with Linux v5.19-rc2 and attaching tools/perf/a.out +
> > tools/perf/Makefile.config.
> >
> > Check perf binary:
> >
> > $ ~/bin/perf -vv
> > perf version 5.19.0-rc2
> >                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> >    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> >                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
> >         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> >                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
> >            debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
> >                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> >             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> >    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> >                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> >             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >                   aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> >               libpfm4: [ OFF ]  # HAVE_LIBPFM
> >
> > Tried `make distclean`.
> > Tried `make tools/ clean` but tools/tracing/rtla produces errors (rm clean).
> > Still exists: tools/perf/a.out.
>
> I started seeing this here, will investigate and re-read your reports,
> thanks for sending them!
>

Thanks for the feedback.

If you need further information or have something for testing, please
let me know.

-sed@-
