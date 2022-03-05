Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE6A4CE383
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 08:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiCEHxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 02:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiCEHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 02:53:44 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDE46384;
        Fri,  4 Mar 2022 23:52:54 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q8so11939381iod.2;
        Fri, 04 Mar 2022 23:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=sBBxgRvmPyMbFmesC6PfBojq8OF5jYFT/zSk89dxKRw=;
        b=oudWkOCQ2E+K7ho3q5/V7UU8wYU6HoriUSt7iD/SfUNVWZGnRf/y4nOWY7nS5gf7hP
         3SHoGMCl4v78ZbPjlilOJyaQdpcViv+wQFH2hKTQNTar+fx1nSN2avCgyi1zpIdC8b6A
         4/L6GH1yYDbL+Pt86pL+qcZ8fSmXBxu5flTl/g7QZjmROCZf9JLVHOw3ObCBwV5W8PNc
         rMmrpUrtXKMT3IYgMJ3ufz+DSogm8jXmK7hPb6ZDCrVhPN1HSq2aJenhT3w8xsVUmMrI
         W4p+uiszx8DeZKIEm5V+v30I5p3523MTcZwT4+l6ERDZiKqixLb9cd7y+eTlzroCwIxb
         XsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=sBBxgRvmPyMbFmesC6PfBojq8OF5jYFT/zSk89dxKRw=;
        b=oTMjQ+/8z8MLE9BZOVDxra6mhg1LoDMFgO6liMRbm6yBsHG8R/6oEJF+gHkiDGW4x3
         NMtP8OLwXJRG3YxtIz8dZnO6IwKm0M8ypHmEzd0m7tHdHdnUAOd4yz+Zyl9ZV4zJLkPz
         7ESyqnOBSJiBqNJynBk+97jg3qalmEaKqMR1sHA3PTNUBMBH1Z2jb6Z30g2gzIOnUzoL
         zU/CUkBU19xiPVNQBVKjkApE+CIGyEA8IyiVMFYeEhgbQKFG5B4Gg7/SunSXOJ+NwfYf
         AZr4/W38Orf6JhQu4nIilSbeZeKQw7T3McfMROEbAtwf/pht9RRP9vWuTBi1uVa+4ifk
         b4Dw==
X-Gm-Message-State: AOAM531qM9g5v7wKcXiE/PxKbRS/Bn16ENJfG67epza3YYXapjcwFkl8
        gBP6Y6eNB2Td6X0zOHqUbnDWpB+ZUixOc9jUATs=
X-Google-Smtp-Source: ABdhPJyYB34OOd6mh85qDvNQEgE+PObHyF08crHwNQYSOKb+/z5KgY2EJiSuFWVNckEQTRxfrDpsVx1Qdb65ea9wiHA=
X-Received: by 2002:a02:c733:0:b0:2fe:ab40:d2cc with SMTP id
 h19-20020a02c733000000b002feab40d2ccmr2189466jao.126.1646466774005; Fri, 04
 Mar 2022 23:52:54 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 5 Mar 2022 08:52:18 +0100
Message-ID: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
Subject: [Linux-v5.17-rc6] Building tools/perf with perl v5.34
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

Hi,

I am here on Debian/unstable AMD64 which switched over to perl v5.34
in February 2022.

Unfortunately, my perf does not build with this (lib)perl version:

$ ~/bin/perf -vv
perf version 5.17-rc6
                dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
   dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
        syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
               libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
               libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
              libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
              libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
            libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
             libslang: [ on  ]  # HAVE_SLANG_SUPPORT
            libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
            libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
   libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                 zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                 lzma: [ on  ]  # HAVE_LZMA_SUPPORT
            get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                  bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                  aio: [ on  ]  # HAVE_AIO_SUPPORT
                 zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
              libpfm4: [ OFF ]  # HAVE_LIBPFM

$ grep libperl ../make-log_perf-python3.10-install_bin.txt
9:Makefile.config:788: Missing perl devel files. Disabling perl
scripting support, please install perl-ExtUtils-Embed/libperl-dev
22:...                       libperl: [ OFF ]

Checking for these requirements:

# dpkg -l | grep perl | grep 5.34 | awk '/^ii/ {print $1 " " $2 " "
$3}' | column -t
ii  libperl-dev:amd64  5.34.0-3
ii  libperl5.34:amd64  5.34.0-3
ii  perl               5.34.0-3
ii  perl-base          5.34.0-3
ii  perl-modules-5.34  5.34.0-3

# dpkg -L perl-modules-5.34 | grep -i ExtUtils | grep -i Embed
/usr/share/perl/5.34.0/ExtUtils/Embed.pm

Can you please comment on this?

Thanks.

Regards,
- Sedat -

[1] https://unix.stackexchange.com/questions/167292/what-is-debian-equivalent-of-rpm-package-perl-extutils-embed
