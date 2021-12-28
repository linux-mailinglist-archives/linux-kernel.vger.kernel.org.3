Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AAB480773
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhL1IhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:37:23 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:34673 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhL1IhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:37:22 -0500
Received: by mail-ua1-f46.google.com with SMTP id t18so23359238uaj.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQlFNR8cZsfmJYOadbGaTb/yUlOB1dRG6fgInli2WVA=;
        b=8Caj/iiz8364qYEN0d1OWoJMy50J5PU0LwnZMdd13qL8RSoiMKQptB2NmNVXMvvjYa
         l0Y+Fyk2Sb/OtUSvMWS3Z0FWgQlK4J7sySODqMW3w7FAFez+jXt5QALfyieVWMSX6iL+
         SmltHJ21kjMweIWpusyRhSz9gxot34VYouu+hx4yPQyhT602FXWhhZjNeiMLjYbQxfLP
         Y2ooueSlleZJk/ruLUGmdv1Kg0hbBNQzC+1CbLtc0pHlnzRubt30rt1gyRY8L7VAgWEu
         3eguZSv9h4pWMxLZzxT/wc60TD9wHHnytYfCk5C/EO73yKR7JuyMDNti8qT5IkLw3d/8
         5X7w==
X-Gm-Message-State: AOAM531SYOJrnPxWC3ohbV/t/k9WdIrQcapUh1qr6Rc56YBgrUpw70bO
        1r6fW4e6VZs/AlR8j20uDZYAuz3oC2F4Sw==
X-Google-Smtp-Source: ABdhPJykBdAIdHUv9qyxuL85qxDXwaGYG7A8UC6jvK6f0yrNcWDNJlUccSlSHamG9yuBIpZV4IrRxQ==
X-Received: by 2002:a67:e351:: with SMTP id s17mr4876205vsm.63.1640680641535;
        Tue, 28 Dec 2021 00:37:21 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id d25sm3688370vsk.15.2021.12.28.00.37.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 00:37:21 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id v12so19018312uar.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:37:21 -0800 (PST)
X-Received: by 2002:ab0:15a1:: with SMTP id i30mr6096810uae.122.1640680640883;
 Tue, 28 Dec 2021 00:37:20 -0800 (PST)
MIME-Version: 1.0
References: <202112280309.fgjGevFd-lkp@intel.com>
In-Reply-To: <202112280309.fgjGevFd-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 09:37:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdXMqUDjeXsvFbSNk8hKcDAms-Z5JK+pGAcYvykyCzwg@mail.gmail.com>
Message-ID: <CAMuHMdVdXMqUDjeXsvFbSNk8hKcDAms-Z5JK+pGAcYvykyCzwg@mail.gmail.com>
Subject: Re: [atishp04:isa_ext_support 3/4] arch/riscv/kernel/cpufeature.c:82:24:
 warning: address of array 'edata->dtprop' will always evaluate to 'true'
To:     kernel test robot <lkp@intel.com>
Cc:     Atish Patra <atishp@rivosinc.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 9:21 AM kernel test robot <lkp@intel.com> wrote:
> tree:   https://github.com/atishp04/linux isa_ext_support
> head:   cf2f3fa532aa7c672f681ca0685046c738bfb45f
> commit: ae97a995345b68c472f3a904fc8fbefaa97ae26a [3/4] RISC-V: Provide a framework for parsing multi-letter ISA extensions
> config: riscv-randconfig-c006-20211226 (https://download.01.org/0day-ci/archive/20211228/202112280309.fgjGevFd-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 0c553cc1af2e4c14100df6cf4a6fc91987e778e6)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/atishp04/linux/commit/ae97a995345b68c472f3a904fc8fbefaa97ae26a
>         git remote add atishp04 https://github.com/atishp04/linux
>         git fetch --no-tags atishp04 isa_ext_support
>         git checkout ae97a995345b68c472f3a904fc8fbefaa97ae26a
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/riscv/kernel/cpufeature.c:82:24: warning: address of array 'edata->dtprop' will always evaluate to 'true' [-Wpointer-bool-conversion]
>            if (!edata || !edata->dtprop)
>                          ~~~~~~~~^~~~~~
>    1 warning generated.
>
>
> vim +82 arch/riscv/kernel/cpufeature.c
>
>     76
>     77  int riscv_isa_ext_list_add(struct riscv_isa_ext_data *edata)
>     78  {
>     79          struct device_node *node, *enode;
>     80          int eid;
>     81
>   > 82          if (!edata || !edata->dtprop)

if (!edata || !edata->dtprop[0])

>     83                  return -EINVAL;
>     84
>     85          node = of_find_node_by_path("/cpus");
>     86          if (!node) {
>     87                  pr_err("No CPU information found in DT\n");
>     88                  return -ENOENT;
>     89          }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
