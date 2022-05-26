Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5E8534760
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbiEZAOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345612AbiEZAOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:14:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47916391
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:14:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q21so190101ejm.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUN1Hk+wVODcst4ocCxem+PCWnT3RpL+w2LVEy5CkRA=;
        b=RtP6hh4X8z+2MahAiAUIOJVM9Cfmt7V5Ll8iE25tjBROyYvHx4EOB8CtLSuOQeapQd
         BR1dE4Yip3iyeN1fJom8sECDjU2+AKUGFOFdW94NxU5AyV9Js4RicQo7nhg6MqqySr/r
         MsiOZh3uZVfiTEimtdnWO4N2hsnqY1z1fITBrp8gZrKtOs8rtHAtWN82Jm4FaGK04oEk
         SM1JaUH0FbWOBZC7d6+39nmFWIrPZJ+9Fy/gxfH1Q/NPCP8GuV8eC+jeaecUcSbUXcr8
         1LN/htRrUOFLscNprtUKZdz2aJSfLLMANVSpubh492YLFpHnbRNWZwvq4j3iFsl4EzSp
         uJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUN1Hk+wVODcst4ocCxem+PCWnT3RpL+w2LVEy5CkRA=;
        b=wl/DubnmgaJIFym4OsuoM3ze1e6UFOgfvZE1gGpNVo1m0/dt8Lm6KfcaMevdw5Ssb9
         yS9AxvCrdR/d/AyTDkM07tuXFz+m1brjn29eGtMNFlATT52w5K3hbTm6S+lnm2RvC+9E
         kc17wBUbpFMhXqMkFlednVh0WP0+JoITWxk3cRbxeb1SvmxsOs5MBsXlJnjvIMl2glJl
         XtV8l11TEui8ti+HotGd4ue8VpSW57US84RvMWIPISPkZLLjIwB+gpneqbBH/PdJ3vqt
         BMvbg9rW2YBBxSAO6U/qndZiB3zCzZtnDxw8rCKaA4aQ0KKrBu3yVZ+V0fjwRw+Oa3G2
         JhYg==
X-Gm-Message-State: AOAM531n5kCYJVB6LJbj2CFgAVLKkCiuO7d6eiTEBVG8c53HBB6SnOEq
        vbQg50BeQq3TNdWJqTbh0aD1aG1D/LJT2TACFDg=
X-Google-Smtp-Source: ABdhPJyO00AJg5mswWV1wx6ajRW6tH6ji4ANJHj6fdfFPQFeCDOUk7NVjUlDeNuLLnBukt35NG5sW7tLc1W4JwY9K+I=
X-Received: by 2002:a17:907:62a0:b0:6fe:69f3:88de with SMTP id
 nd32-20020a17090762a000b006fe69f388demr30054330ejc.214.1653524078459; Wed, 25
 May 2022 17:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <202205021042.xPjJ6Z4J-lkp@intel.com>
In-Reply-To: <202205021042.xPjJ6Z4J-lkp@intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 25 May 2022 21:14:30 -0300
Message-ID: <CAOMZO5Dg8_vDbW0vau4YFspZZ-RS=in8xEavkyYvBAQB41xTWA@mail.gmail.com>
Subject: Re: drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer
 type 'enum imx_dma_type' from 'const void *'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
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

On Sun, May 1, 2022 at 11:13 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Fabio,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
> commit: 0ab785c894e618587e83bb67e8a8e96649868ad1 dmaengine: imx-dma: Remove unused .id_table
> date:   1 year, 5 months ago
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205021042.xPjJ6Z4J-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ab785c894e618587e83bb67e8a8e96649868ad1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0ab785c894e618587e83bb67e8a8e96649868ad1
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/dma/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer type 'enum imx_dma_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>            imxdma->devtype = (enum imx_dma_type)of_device_get_match_data(&pdev->dev);
>                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.

Does anyone know how to fix this clang warning?

Thanks
