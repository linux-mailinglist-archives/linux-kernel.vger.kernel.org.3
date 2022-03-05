Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6904CE6B4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiCEUKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiCEUKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:10:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAC77A982;
        Sat,  5 Mar 2022 12:09:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y2so10209588edc.2;
        Sat, 05 Mar 2022 12:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5PE++IT0SqH+nerQPYhASiAdS43lKhMISvZVQhTLbEg=;
        b=EDVWhlWI7LvbOBwC5MFrncrM4F8LwYzO7Y26iKuIPCyrXgi1PWhpLCTH8+D6Ne3MAv
         9nlSNjgrvZaGgdgiYqr82pUGdFkU5yIfDfG/4bonGeh8X2NICURRvAMmpj9xGXFP7Fml
         znWWon3NdwX49z5OrJOqaObU5zA+orZTWoMoYuQ1JBwoXR1SQmZ6+yip/Zm537wLU8kh
         ihfFClRHE9dvvI9gWGVaWByJewdpeNGB9phyFgZ6VdhTMIJ4mlQJH+xEiPFP1uKnzUCT
         BMvJnM6vcrm87nTV3Xar5QFNnl6TI/JKTMiAI89/OcQno0S4jySgGIk2W2m0v3kt8ciT
         SeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5PE++IT0SqH+nerQPYhASiAdS43lKhMISvZVQhTLbEg=;
        b=2WpqD8lUQFJvCPm49FVK/dhTQSYV9nq7S4TwBi4ReLDIZxXm6JKssBkUpIjAEI6Sje
         8sxciV+HXNcozcy74RJrTy1NSVJzWFvArKzV0WwwMcTwRuDUqafgENgdB6XmKDvylA1h
         8UEBW2ZPuQrN4AgP4v+VdB35KmbhzzrsHgtWHnbGUJY5dLiaaksCOCVX1FB/W0uHtryv
         07hYswvKDOhg/NtmwKNQJN+UVXouETn/Y2z2hgDq1EMNWIBpa16NjzDb96tX3EijbsoL
         DVUcGRPQ53DKLNBWH2F8Jv11Iz2sKOzeZOI2Vf0zQN/WZQQLfFGM5oKUpTlCc08V1vqx
         FtCA==
X-Gm-Message-State: AOAM5320G+bR8BeslL4F0cHd/uKppHUYTgABaLJVeMhubKQ0IN4Atbsd
        oWWS/nWE/8fWlD9LVXT5r6Q=
X-Google-Smtp-Source: ABdhPJxUdD7Gx/19q3e4nu4bpRaOEl4lNk+TUvgRgirTobQYwgy6h24wLDJOyhkHHk9kFjTRE8F6+g==
X-Received: by 2002:a05:6402:2744:b0:415:c590:3ac3 with SMTP id z4-20020a056402274400b00415c5903ac3mr4194670edd.405.1646510958178;
        Sat, 05 Mar 2022 12:09:18 -0800 (PST)
Received: from krava (94.113.247.30.static.b2b.upcbusiness.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm726265ejc.66.2022.03.05.12.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 12:09:17 -0800 (PST)
Date:   Sat, 5 Mar 2022 21:09:14 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-v5.17-rc6] Building tools/perf with perl v5.34
Message-ID: <YiPDaiYffeK4lF+l@krava>
References: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 08:52:18AM +0100, Sedat Dilek wrote:
> Hi,
> 
> I am here on Debian/unstable AMD64 which switched over to perl v5.34
> in February 2022.
> 
> Unfortunately, my perf does not build with this (lib)perl version:
> 
> $ ~/bin/perf -vv
> perf version 5.17-rc6
>                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>               libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
>             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                   aio: [ on  ]  # HAVE_AIO_SUPPORT
>                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>               libpfm4: [ OFF ]  # HAVE_LIBPFM
> 
> $ grep libperl ../make-log_perf-python3.10-install_bin.txt
> 9:Makefile.config:788: Missing perl devel files. Disabling perl
> scripting support, please install perl-ExtUtils-Embed/libperl-dev
> 22:...                       libperl: [ OFF ]
> 
> Checking for these requirements:
> 
> # dpkg -l | grep perl | grep 5.34 | awk '/^ii/ {print $1 " " $2 " "
> $3}' | column -t
> ii  libperl-dev:amd64  5.34.0-3
> ii  libperl5.34:amd64  5.34.0-3
> ii  perl               5.34.0-3
> ii  perl-base          5.34.0-3
> ii  perl-modules-5.34  5.34.0-3
> 
> # dpkg -L perl-modules-5.34 | grep -i ExtUtils | grep -i Embed
> /usr/share/perl/5.34.0/ExtUtils/Embed.pm
> 
> Can you please comment on this?

hi,
is there something in tools/build/feature/test-libperl.make.output ?

jirka
