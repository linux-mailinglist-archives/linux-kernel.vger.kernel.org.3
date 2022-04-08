Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0E4F9985
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiDHPdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiDHPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:33:22 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088532274EE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:31:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p21so11042871ioj.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=B8ymBNv6Jw8LBNDiT/gJa9h4mEV71VhWO39YxSHrj0I=;
        b=ACJpYMw1RME5H8vuVk/PVw0+Hv5QnEZi2iDMoA0IC9kyN4pf9i5l+Isi14BDuWJDHq
         /beRXCCn2PSMf/m0kyHhd2CsaKlMAmgDlw+gq8DSuwkV5LrIO/a135aWFWLvnkkFmT7d
         vWlnKx1wYuqOd10SHjoE5ehmiG8nXfF+CH79wkiYQta+oGHSj/t/t/VWzQEPV3Fmg7y6
         ZaqEuqR/ooD6bXGlypvU+2nD4yaB4MecBL6EkdEQ+m9AXcuglR97b4OEenI20SKl1YyU
         CMkMaDFyFUjSZ7zqLh9PuhTSbhDBQPgAUKTZoDyzdctPAtckVnCJ2hkDOmaIZa52Uwsp
         9Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=B8ymBNv6Jw8LBNDiT/gJa9h4mEV71VhWO39YxSHrj0I=;
        b=YwrN4yzRwr8zyDHPLAFRvTIJfgo45zhCu3IxIXgXUagdpvDINSbnK1Z9w/p2RDivtC
         MNPZhuwmRjaM9dK3eR4qdMWPbwIs21AqB4SZOaDCbVQniIZtfvo6SaBqi2pdkXdC8O+K
         TuRBPePLPGUUtxAd3Uh1hMq7fG8n7Tt1aTvtX1Vklcr42wlptieYPbvJzIRN+GHj+ABx
         +XxtM/FAxQo/uxvh2quBDdYL/RC13YlMFT+ZcMgEwLWqn6vCf5NiYmsqUuiM69HrMW56
         TM7bTXePVMwc/KEJkUB34hQOcpcbEHGzREyLpMKC4rJxyuazYH/6KrhJSQunM0JtalPJ
         D0hg==
X-Gm-Message-State: AOAM533SEUsamIIdWZsX2sVEXOtaRQhj2wcympod8vZLI1b9V2nvTZHl
        Y7fpigR2+RNRMWmGXUCzE6p8xm/6ckgZLxFA4VY=
X-Google-Smtp-Source: ABdhPJxgh2uVYJLhchWKhubcUgO7gNOEh637vK8NchbYEZu0uBrSvkQ/D0aTO8WV8DnoTAMCP/T12GrK1aISjmNHzMQ=
X-Received: by 2002:a05:6638:480f:b0:323:777c:8e35 with SMTP id
 cp15-20020a056638480f00b00323777c8e35mr9538886jab.199.1649431876087; Fri, 08
 Apr 2022 08:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <YktYX2OnLtyobRYD@kernel.org> <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
 <YkxWcYzph5pC1EK8@kernel.org> <CA+icZUVMtrqRA-a3k8N0fVcszm=Sn2Jb9nMfF8mXqvSTu2HUhw@mail.gmail.com>
 <Ykyfzn6Z8Wkf1Ccl@kernel.org> <Yky4TjOLiVvOcLYN@kernel.org> <YlBLh6Y0WWEVuN1F@kernel.org>
In-Reply-To: <YlBLh6Y0WWEVuN1F@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 8 Apr 2022 17:30:39 +0200
Message-ID: <CA+icZUUnj-CjG3AsypSdJ3szx93mx49uD7MaBCeSbHqa50QYuw@mail.gmail.com>
Subject: Re: Build perf with clang, failure with libperf
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000e807305dc2649b9"
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NUMERIC_HTTP_ADDR,
        OBFU_TEXT_ATTACH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_SPAMMY_FILENAME,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000e807305dc2649b9
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 8, 2022 at 4:49 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Apr 05, 2022 at 06:44:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Apr 05, 2022 at 05:00:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Apr 05, 2022 at 05:46:00PM +0200, Sedat Dilek escreveu:
> > > > So, we should include scripts/Makefile.clang or enhance
> > > > tools/scripts/Makefile.include where LLVM/Clang stuff is defined (and
> > > > can be overridden).
> > >
> > > > Jiri pointed out he needed two options (when I recall correctly):
> > > >
> > > > [1] -Wno-unused-command-line-argument
> >
> > I didn't see this one so far, but this one, and for the python case,
> > appears on clang 13 on:
> >
> >   22    45.02 archlinux:base                : FAIL clang version 13.0.1
> >
> >   CC      /tmp/build/perf/arch/x86/util/pmu.o
> > clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> > error: command '/usr/sbin/clang' failed with exit code 1
> >   MKDIR   /tmp/build/perf/ui/stdio/
> > cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory
> >   CC      /tmp/build/perf/arch/x86/util/kvm-stat.o
> > make[2]: *** [Makefile.perf:639: /tmp/build/perf/python/perf.so] Error 1
> > make[2]: *** Waiting for unfinished jobs....
>
> So this one is more involved, see the two patches below, the first fixes
> the clang command option probing mechanism used and the second filters
> out -ffat-lto-objects.
>
> Its all in my tmp.perf/urgent branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git.
>
> The full test suite is still running, but so far the failures are
> unrelated to the problems in this thread:
>
> [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.18.0-rc1.tar.xz
> [perfbuilder@five ~]$ time dm
>    1   115.87 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
>    2    74.26 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
>    3    67.82 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
>    4    71.32 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
>    5    77.05 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>    6    76.76 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>    7    79.36 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>    8   111.26 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>    9   118.37 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
>   10   124.39 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>   11   135.45 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
>   12   129.24 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
>   13   124.49 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
>   14   115.27 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
>   15    62.59 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
>   16    90.90 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
>   17    89.19 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
>   18    90.50 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.1
>   19    64.00 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
>   20   100.13 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
>   21   116.67 amazonlinux:devel             : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
>   22   105.61 archlinux:base                : Ok   gcc (GCC) 11.2.0 , clang version 13.0.1
>   23    98.90 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
>   24   112.45 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.0 (Red Hat 13.0.0-3.module_el8.6.0+1074+380cef3f)
>   25    51.53 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20220330 releases/gcc-11.2.0-949-g511e8b6122 , clang version 13.0.0
>   26    79.15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
>   27    84.48 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
>   28    98.81 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
>   29   115.79 debian:experimental           : Ok   gcc (Debian 11.2.0-19) 11.2.0 , Debian clang version 13.0.1-3+b2
>   30    24.66 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0
>   31    20.25 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0
>   32    22.06 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
>   33    22.76 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0
>   34    22.55 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
>   35    68.41 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
>   36    80.65 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
>   37    18.13 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
>   38    81.54 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
>   39    95.09 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
>   40    97.18 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
>   41   109.33 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
>   42   115.85 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
>   43   118.65 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
>   44   111.13 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
>   45   105.95 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
>   46   104.95 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
>   47   112.06 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
>   48    20.44 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
>   49    18.44 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
>   50   113.69 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
>   51    30.08 fedora:36                     : FAIL gcc version 12.0.1 20220308 (Red Hat 12.0.1-0) (GCC)
>       + make PYTHON=python3 ARCH= CROSS_COMPILE= EXTRA_CFLAGS= LIBTRACEEVENT_DYNAMIC=1 -C tools/perf O=/tmp/build/perf
>     make: Entering directory '/git/perf-5.18.0-rc1/tools/perf'
>       BUILD:   Doing 'make -j32' parallel build
>     Makefile.config:728: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
>     Makefile.config:1011: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
>     Makefile.config:1118: *** Error: No libtraceevent devel library found, please install libtraceevent-devel.  Stop.
>     make[1]: *** [Makefile.perf:240: sub-make] Error 2
>
>   52   126.52 fedora:rawhide                : Ok   gcc (GCC) 12.0.1 20220308 (Red Hat 12.0.1-0) , clang version 14.0.0 (Fedora 14.0.0-1.fc37)
>   53    96.02 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
>   54    82.86 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
>   55    43.11 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
>           yychar = yylex (&yylval, &yylloc, scanner);
>                    ^
>     #define yylex           parse_events_lex
>                             ^
>     1 error generated.
>     make[3]: *** [/git/perf-5.18.0-rc1/tools/build/Makefile.build:139: util] Error 2
>   56   107.45 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
>   57     6.58 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC)
>     In file included from builtin-bench.c:22:
>     bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
>        66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
>           |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     In file included from bench/bench.h:64,
>                      from builtin-bench.c:22:
>     /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
>       394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
>           |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
>     ld: warning: -r and --icf may not be used together, disabling --icf
>     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
>     ld: warning: -r and --icf may not be used together, disabling --icf
>     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
>     ld: warning: -r and --icf may not be used together, disabling --icf
>   58     6.48 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC)
>     In file included from builtin-bench.c:22:
>     bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
>        66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
>           |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     In file included from bench/bench.h:64,
>                      from builtin-bench.c:22:
>     /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
>       394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
>           |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
>     ld: warning: -r and --icf may not be used together, disabling --icf
>     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
>     ld: warning: -r and --icf may not be used together, disabling --icf
>     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
>     ld: warning: -r and --icf may not be used together, disabling --icf
>   59   118.04 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
>   60   127.98 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
>   61   122.86 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1
>   62   133.70 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
>   63   133.30 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
>   64   158.92 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20211124 [revision 7510c23c1ec53aa4a62705f0384079661342ff7b] , clang version 13.0.0
>   65   114.77 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
>   66: rockylinux:8
>
> - Arnaldo
>
> From 73fb827d72906bd2d78c6ca091b0c74f90183a95 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Fri, 8 Apr 2022 10:08:07 -0300
> Subject: [PATCH 1/2] perf python: Fix probing for some clang command line
>  options
>
> The clang compiler complains about some options even without a source
> file being available, while others require one, so use the simple
> tools/build/feature/test-hello.c file.
>
> Then check for the "is not supported" string in its output, in addition
> to the "unknown argument" already being looked for.
>
> This was noticed when building with clang-13 where -ffat-lto-objects
> isn't supported and since we were looking just for "unknown argument"
> and not providing a source code to clang, was mistakenly assumed as
> being available and not being filtered to set of command line options
> provided to clang, leading to a build failure.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Keeping <john@metanate.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Link: http://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/setup.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 483f05004e682081..6156bb87ee3e34cf 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -1,12 +1,14 @@
> -from os import getenv
> +from os import getenv, path
>  from subprocess import Popen, PIPE
>  from re import sub
>
>  cc = getenv("CC")
>  cc_is_clang = b"clang version" in Popen([cc.split()[0], "-v"], stderr=PIPE).stderr.readline()
> +src_feature_tests  = getenv('srctree') + '/tools/build/feature'
>
>  def clang_has_option(option):
> -    return [o for o in Popen([cc, option], stderr=PIPE).stderr.readlines() if b"unknown argument" in o] == [ ]
> +    cc_output = Popen([cc, option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> +    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
>
>  if cc_is_clang:
>      from distutils.sysconfig import get_config_vars
> --
> 2.35.1
>
> From e807abf709ee26af99588bd13e725fb45011b167 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Thu, 7 Apr 2022 11:04:20 -0300
> Subject: [PATCH 2/2] perf build: Don't use -ffat-lto-objects in the python
>  feature test when building with clang-13
>
> Using -ffat-lto-objects in the python feature test when building with
> clang-13 results in:
>
>   clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
>   error: command '/usr/sbin/clang' failed with exit code 1
>   cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory
>   make[2]: *** [Makefile.perf:639: /tmp/build/perf/python/perf.so] Error 1
>
> Noticed when building on a docker.io/library/archlinux:base container.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Keeping <john@metanate.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.config | 3 +++
>  tools/perf/util/setup.py   | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5b5ba475a5c00c0f..f3bf9297bcc03c5e 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -272,6 +272,9 @@ ifdef PYTHON_CONFIG
>    PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
>    PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
>    FLAGS_PYTHON_EMBED := $(PYTHON_EMBED_CCOPTS) $(PYTHON_EMBED_LDOPTS)
> +  ifeq ($(CC_NO_CLANG), 0)
> +    PYTHON_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PYTHON_EMBED_CCOPTS))
> +  endif
>  endif
>
>  FEATURE_CHECK_CFLAGS-libpython := $(PYTHON_EMBED_CCOPTS)
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 6156bb87ee3e34cf..c255a2c90cd672b1 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -25,6 +25,8 @@ if cc_is_clang:
>              vars[var] = sub("-fstack-protector-strong", "", vars[var])
>          if not clang_has_option("-fno-semantic-interposition"):
>              vars[var] = sub("-fno-semantic-interposition", "", vars[var])
> +        if not clang_has_option("-ffat-lto-objects"):
> +            vars[var] = sub("-ffat-lto-objects", "", vars[var])
>
>  from distutils.core import setup, Extension
>
> --
> 2.35.1
>

Thanks for the followup patches.

I have tested with the last 4 commits from [1].

[ INSTRUCTIONS ]

1103  2022-04-08 17:14:40 LLVM_MVER="14"
1104  2022-04-08 17:14:40 LLVM_TOOLCHAIN_PATH="/usr/lib/llvm-${LLVM_MVER}/bin"
1105  2022-04-08 17:14:40 ##LLVM_TOOLCHAIN_PATH="/opt/llvm-toolchain/bin"
1106  2022-04-08 17:14:40 if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"; fi
1107  2022-04-08 17:14:40 echo $PATH
1108  2022-04-08 17:14:40 PYTHON_VER="3.10"
1109  2022-04-08 17:14:40 MAKE="make"
1110  2022-04-08 17:14:40 MAKE_OPTS="V=1 -j4 HOSTCC=clang
HOSTLD=ld.lld HOSTAR=llvm-ar CC=clang LD=ld.lld AR=llvm-ar
STRIP=llvm-strip"
1111  2022-04-08 17:14:40 echo $PYTHON_VER $MAKE $MAKE_OPTS

3.10 make V=1 -j4 HOSTCC=clang HOSTLD=ld.lld HOSTAR=llvm-ar CC=clang
LD=ld.lld AR=llvm-ar STRIP=llvm-strip

1112  2022-04-08 17:14:50 LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
clean 2>&1 | tee ../make-log_perf-clean.txt
1113  2022-04-08 17:15:43 LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
PYTHON=python${PYTHON_VER} install-bin 2>&1 | tee
../make-log_perf-python${PYTHON_VER}-install_bin_debian-llvm14_perf-urgent-acme-20220408.txt

Please feel free to add my...

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v14 (x86-64)

My perf build-log is attached.

- sed@ -

P.S.: I requested to bump perl to version 5.34.1 (see [2]) plus diff from [3].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/urgent
[2] https://bugs.debian.org/1009170
[3] https://bugs.debian.org/1009149

--0000000000000e807305dc2649b9
Content-Type: application/octet-stream; 
	name="make-log_perf-python3.10-install_bin_debian-llvm14_perf-urgent-acme-20220408.txt.zst"
Content-Disposition: attachment; 
	filename="make-log_perf-python3.10-install_bin_debian-llvm14_perf-urgent-acme-20220408.txt.zst"
Content-Transfer-Encoding: base64
Content-ID: <f_l1qkzo2b0>
X-Attachment-Id: f_l1qkzo2b0

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
4MOt8pTmmDyEpHwcFNSf0lAjKDhI1w==
--0000000000000e807305dc2649b9
Content-Type: application/octet-stream; 
	name="make-log_perf-python3.10-install_bin_debian-llvm14_perf-urgent-acme-20220408.txt.zst.sha256"
Content-Disposition: attachment; 
	filename="make-log_perf-python3.10-install_bin_debian-llvm14_perf-urgent-acme-20220408.txt.zst.sha256"
Content-Transfer-Encoding: base64
Content-ID: <f_l1qkzrrn1>
X-Attachment-Id: f_l1qkzrrn1

YWM5YTgwYjYwODk2NjJlOGVmODE0Nzc5MjIwMDQzMjE3YzczYzJkYjcxZjU4YmFhMTg1ZDEyOWJk
YWVmYzdiNSAgbWFrZS1sb2dfcGVyZi1weXRob24zLjEwLWluc3RhbGxfYmluX2RlYmlhbi1sbHZt
MTRfcGVyZi11cmdlbnQtYWNtZS0yMDIyMDQwOC50eHQuenN0Cg==
--0000000000000e807305dc2649b9--
