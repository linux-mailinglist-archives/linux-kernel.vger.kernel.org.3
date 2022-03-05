Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05674CE388
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 08:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiCEH64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 02:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiCEH6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 02:58:55 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85040522E8;
        Fri,  4 Mar 2022 23:58:05 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id u8so803072ilv.0;
        Fri, 04 Mar 2022 23:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vtF/fnbl8MgG+NykIfC5YN+vxFv+WkRJMgmDqAzHsCA=;
        b=GmHbVKbEEyvIwE2w3MGW64jxl0gF2z+G9w15w/LS3iflGnnLlXKs+RNQYxjnWaCFCL
         wZyf6Oe33VDc5l8sNRHDjB2mLEUU7uaZQ3W/ycIJHpQvVi/2TrNPsnZGNWul6TsLRpS0
         Qr1M2+wJUX5efy/PNECZdfy1SNrpWgWOiHAKCm31xDq0ykIv4vuoOG8xkiYUxolG1UEv
         6ukWUQGwqxyKwml997wUahlOdwmLIvxFiXEInkr414bxVNnhqnXpnv9XvS+vjCAI4UQ9
         eaVpJ/AunTbFgsqjuhUE7UODrN/wd/2wzax+NEzUM+KyDdB7rgbyU6KaYQ/mw/FUUUuY
         aWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vtF/fnbl8MgG+NykIfC5YN+vxFv+WkRJMgmDqAzHsCA=;
        b=sc754NrGswLIfygqNjAgcisFa+kS4G+2m2o4YiZvIsCjqRTS6v9il/k4Nri6NR136t
         Utf68pXnmaKywss9af8ADOSD00C4HatJDLpt0avD5VOMsnLD4d0crcvrjh5IO+g30XcX
         fzXAXMmAvN/Jt1OtBvJX+HGuOtgxd9xk03e1yolJ82hx7ZaJ9ybYGG06I77Gzu1NfGZO
         Bun2+jNIOtx3k0NGA1AQqLKH25gzxmVYuTM2GBmtUs1YaAlUTVTm3nlViaSuvspyvuUP
         meas9WN5utAWMlT9fBVDpp8pWyfr3jNp9bU/6OVIFz444OOBLz0aRA0fcortFu4WLKN0
         QubA==
X-Gm-Message-State: AOAM531/AkBsCmwnnfKiaYuyXlDV+Gx01YIQxZV6MYYqsPBcsgT/Mqt2
        9rsC2JRqfFC9HZIVIQM1aqKCdzVjKoAWY9Q0PxhJ/vJWi3kYuQ==
X-Google-Smtp-Source: ABdhPJwY1Or5oX2Gt/bz3/eAnC5jdQWXbHKBmkaC7aM2Cw/Foc5M0Iy12blgkxnczZLiGflEzpW0q0AL4xypgPpFxE8=
X-Received: by 2002:a05:6e02:18cd:b0:2c2:f50c:278 with SMTP id
 s13-20020a056e0218cd00b002c2f50c0278mr2292350ilu.1.1646467084930; Fri, 04 Mar
 2022 23:58:04 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
In-Reply-To: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 5 Mar 2022 08:57:28 +0100
Message-ID: <CA+icZUW7LESaDG5gLQs9kOJp=0Anp=+jNb8L1u91iAf625m6wA@mail.gmail.com>
Subject: Re: [Linux-v5.17-rc6] Building tools/perf with perl v5.34
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Mar 5, 2022 at 8:52 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
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
>
> Thanks.
>
> Regards,
> - Sedat -
>
> [1] https://unix.stackexchange.com/questions/167292/what-is-debian-equivalent-of-rpm-package-perl-extutils-embed

My command-line:

cd /path/to/linux.git

$ make V=1 -j4 HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld
HOSTAR=llvm-ar CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm
OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size
READELF=llvm-readelf STRIP=llvm-strip LLVM_IAS=1 -C tools/perf
PYTHON=python3.10 install-bin

I use the -gnu-std-11 patchset plus some own:

$ git log --oneline v5.17-rc6.. | grep 'std=gnu11'
05d8e9b88918 tools: libtraceevent: Use -std=gnu11
ee44279e6b01 tools: libsubcmd: Use -std=gnu11
411fa2d6da5c tools: libapi: Use -std=gnu11
3f0092b7e1b9 tools: perf: Use -std=gnu11
0cf56ddf2b41 tools: libbpf: Use -std=gnu11
96a4222bdd4c Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
6a7cc105b238 Kbuild: move to -std=gnu11

If this matters...

- Sedat -
