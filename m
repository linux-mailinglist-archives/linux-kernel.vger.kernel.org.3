Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6585324A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiEXH7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiEXH6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:58:52 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F69B18D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:39 -0700 (PDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24O7w3fv022514
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:58:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24O7w3fv022514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653379084;
        bh=TArsvHHMXGn0/Jl86yZIhdjKalu11cTv6MpZFJeFQGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Whz1a9+ynRory3SBbCdAtRY/g028nY0DHZXrAwRWevEQcVo+K2AVePrDcW4fih+Cb
         Ipt21agOXk+Yc42ECyUBhUKItCaKfRghIaAwWRwTCPiDcil7cj5M1YKQmsThTW4Ral
         wfE68+XlciGtE4RS7npOfgrh0k2D5NXFPlEEIRgAPkTYAhGwDayG6YGN5KDJIo1FCt
         U3MeiREL4fEIpv+g7qmT7PMrRHrmR0P6n6fEIplLRtsi3Y2Ph3GtP+XH7I4OtURzaM
         ArkAuzV7W5D/AEfGF025TiPrt7W2A7Km02NEbMCr7MFIllzMuJdnYiREVgc5nq1/HG
         Da7d0fvr2JlSg==
X-Nifty-SrcIP: [209.85.210.171]
Received: by mail-pf1-f171.google.com with SMTP id x143so15768620pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:03 -0700 (PDT)
X-Gm-Message-State: AOAM531IcE1rMG8GI832Hg2iH+TwtaCZNF+/6d3qtKzqBiTr9QBSqqIK
        7owHYUF4Qr7SwyapXWQI5ihY6uSxFQt/De2xuOI=
X-Google-Smtp-Source: ABdhPJy8J0xrZRGNNU0fNkFuBdSJ/rZg6/1qE7YhYjmxYYBULT0P0rku94nZx88Fo+BekM2tENtT7m66uPCjHcg917A=
X-Received: by 2002:a05:6a00:a02:b0:4fd:f9dd:5494 with SMTP id
 p2-20020a056a000a0200b004fdf9dd5494mr28124979pfh.68.1653379083014; Tue, 24
 May 2022 00:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <202205240952.93aQKXmM-lkp@intel.com>
In-Reply-To: <202205240952.93aQKXmM-lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 May 2022 16:56:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROKoR=_yhUzb9MmB_UKW-cGVKr8a-Jv4m9uvAXDOXCJg@mail.gmail.com>
Message-ID: <CAK7LNAROKoR=_yhUzb9MmB_UKW-cGVKr8a-Jv4m9uvAXDOXCJg@mail.gmail.com>
Subject: Re: [masahiroy:kbuild 54/64] <command-line>: warning: missing
 terminating " character
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:20 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild
> head:   193ce6b16e10632abf21c2d756c1c181d6ecdf40
> commit: 5255bb025ec27c5fa9acbfb079544920426313ec [54/64] kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
> config: m68k-randconfig-r021-20220522 (https://download.01.org/0day-ci/archive/20220524/202205240952.93aQKXmM-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=5255bb025ec27c5fa9acbfb079544920426313ec
>         git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>         git fetch --no-tags masahiroy kbuild
>         git checkout 5255bb025ec27c5fa9acbfb079544920426313ec
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> <command-line>: warning: missing terminating " character
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp


Thanks for the report.

I locally fixed up my commit.



-- 
Best Regards
Masahiro Yamada
