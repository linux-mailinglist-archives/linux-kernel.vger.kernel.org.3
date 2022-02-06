Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06994AAF19
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiBFL4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiBFL4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:56:01 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED12C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 03:56:00 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id m4so34136994ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 03:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sGw9Hb8Vg5WwALbs3wJZ2aN1dEchxWfwoAwXEGqCDSg=;
        b=Ehp9h82WEWKjcgP+KByrOwaHTYcUTKb42JchcM2S5pAvAhnNlK4DagaMEf56n8BQax
         3ydjTks+B6HWTKVF3Izb+EmdyMUvpzuiH3sYmnDkq4wkpuyE9PUmTB9GOdh+k7mHb5DH
         YnmcKfc+KAnF+tyt9qUJdde+4La/plmAwtRkhf26ao7UnV1tnVJ9MTLz8ZTD07ZPkadt
         XkrJ42rQze4tl8F/2fBNGMzFdiSF1nOevypQ2qWVrXc2izLOfcZOetfLRQNvvypvxpWJ
         cK/3lcPkdaupImZkXI4Ue9IuajoVCM8Lb4/opQpU/ffXu8T8BzC9iY+b5uV6Y3uKQmmd
         uvMw==
X-Gm-Message-State: AOAM533ChC4Ry6apaJCD+mMz9rPjzmwUb4jo3a70DgvK22IeEa5IGy7K
        ltbIE7olJLXpyfFw+fz8OhTjUjfP0Mo=
X-Google-Smtp-Source: ABdhPJxv3i+v5ctIhzy0MVF43VzrUVWvrLzTOn5YQymmpTcA2Zr73Gay5In18xwWkDxbNDE3e91n+g==
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr6077972ejc.700.1644148559163;
        Sun, 06 Feb 2022 03:55:59 -0800 (PST)
Received: from [192.168.0.83] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id g9sm2507091ejf.33.2022.02.06.03.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 03:55:58 -0800 (PST)
Message-ID: <67f432e2-1bfd-29dc-f2ed-051b47ef0844@kernel.org>
Date:   Sun, 6 Feb 2022 12:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: ld.lld: error: undefined symbol: socfpga_reset_init
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
References: <202202050539.Mtk9I4Ef-lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <202202050539.Mtk9I4Ef-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2022 22:12, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dcb85f85fa6f142aae1fe86f399d4503d49f2b60
> commit: 4483397b03536506535d611b0cb28a81a69e8edf ARM: socfpga: drop ARCH_SOCFPGA
> date:   11 months ago
> config: arm-socfpga_defconfig (https://download.01.org/0day-ci/archive/20220205/202202050539.Mtk9I4Ef-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4483397b03536506535d611b0cb28a81a69e8edf
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 4483397b03536506535d611b0cb28a81a69e8edf
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: socfpga_reset_init
>    >>> referenced by socfpga.c
>    >>>               socfpga.o:(socfpga_init_irq) in archive arch/arm/mach-socfpga/built-in.a
>    >>> referenced by socfpga.c
>    >>>               socfpga.o:(socfpga_arria10_init_irq) in archive arch/arm/mach-socfpga/built-in.a
> 

This looks like a false positive. On the socfpga defconfig arm build,
the socfpga_reset_init() (drivers/reset/reset-socfpga.c) is built.

I also could not reproduce it with GCC.

Best regards,
Krzysztof
