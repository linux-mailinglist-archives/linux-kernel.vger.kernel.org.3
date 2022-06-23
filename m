Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CC2558AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiFWV30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFWV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:29:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA43D5251E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:29:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id pk21so871829ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MgVHm7hfEGFFpT89WECbukmwvWQfoQIAD1gRN/MMR4=;
        b=n7GAWxaMj1YQvoYjky86F32/DIqkyAUd/sNAAdAq6jmau341mtT+4q2Maf5NALs4An
         SgXcfJksoRB1B8uYuvAsRuWO7MdPyMAZjZH/Gsf2JZZYIH3vGYzW6f1z4rouXS4BLlNB
         GryqLM4JA59qTNM9xFUkN/6xZVu+iIspE1z+Rr5FH94U5LO/AfAf3AU8fbNMBkQ4HFSt
         EE4JKCXIHShqvaORJG3rrvzWcg7Cd6WKesteYcRYqhXKNcTpwtXYO4ymGPLSU+lPwZmq
         EKVEsN7AvQ/mjuQlNm4qFjuHYJnevXm3gj0oTPowrYcrCmhbtSX2jNSsb7ve+HVRNum8
         y6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MgVHm7hfEGFFpT89WECbukmwvWQfoQIAD1gRN/MMR4=;
        b=V1pYnIUc5XpJfihKNotUMqRjjDzdidxu/rVrez02K6y7L0fS+LK/jz06En4GIto9MG
         bXe5CZnBksKq9AHVntbMBoyoy6nAttuGF0498/E5sx+cXD3aAVtAC62j3C5rDeq5Kw14
         Cr7NOla1swnKtxVbVj0k15sTVndrckXdirATlHBKaDyKzaMLzQ1DypBKcBqLsF4wAGO5
         YSFXa0vFP49MA5xj1zyo1QUkJt4Pq+TAcupZi9BGTwLdCqfnkER7DHMeWupC1fnO2jpX
         96X0xM+8SQfwLJvBk5niGxWTwpWTyjb6sfZVzFTNhrxPc/f3EsxYXvLs3Y4zypHgZDZT
         UIcg==
X-Gm-Message-State: AJIora9aC5QKQbe/4gWCIuVPZ+1pEELviNfikw/YI8oYzYJvYKcU7RsC
        +MQaenm6JBI5WSjt9aYegyz55Llw/jZRc63w1UmVtkuuc1Q=
X-Google-Smtp-Source: AGRyM1uno90QbZ91SwG8r3HvsHhw5rKJPhHQzK+RE5HBZIL7xB7+LX1qCZOvrN1Ov87DW0uPVHuwiJJSUd6eHUkuQfc=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr10273609ejh.497.1656019760286; Thu, 23
 Jun 2022 14:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <202206240410.O3xJ4UZE-lkp@intel.com>
In-Reply-To: <202206240410.O3xJ4UZE-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 23:28:43 +0200
Message-ID: <CAHp75VeaBssymMOvxSkMjyRD4J_BTcA+n3b9qD8-QQTH5uUFTQ@mail.gmail.com>
Subject: Re: [asahilinux:bits/130-cpufreq 3/4] drivers/cpufreq/apple-soc-cpufreq.c:67:19:
 error: implicit declaration of function 'readq_relaxed'; did you mean 'readl_relaxed'?
To:     kernel test robot <lkp@intel.com>
Cc:     Hector Martin <marcan@marcan.st>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 23, 2022 at 11:23 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/AsahiLinux/linux bits/130-cpufreq
> head:   c1f94f72b7ae14d506b361283ef25624368b1a32
> commit: 4b2ae5bd4433c2282e699dc54bd26b066ad28f85 [3/4] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
> config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220624/202206240410.O3xJ4UZE-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/AsahiLinux/linux/commit/4b2ae5bd4433c2282e699dc54bd26b066ad28f85
>         git remote add asahilinux https://github.com/AsahiLinux/linux
>         git fetch --no-tags asahilinux bits/130-cpufreq
>         git checkout 4b2ae5bd4433c2282e699dc54bd26b066ad28f85
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/cpufreq/apple-soc-cpufreq.c: In function 'apple_soc_cpufreq_get_rate':
> >> drivers/cpufreq/apple-soc-cpufreq.c:67:19: error: implicit declaration of function 'readq_relaxed'; did you mean 'readl_relaxed'? [-Werror=implicit-function-declaration]
>       67 |         u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
>          |                   ^~~~~~~~~~~~~
>          |                   readl_relaxed

Consider to use io-64-non-atomic-lo-hi.h or so


-- 
With Best Regards,
Andy Shevchenko
