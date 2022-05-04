Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4284651AE63
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355589AbiEDT56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiEDT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:57:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82D14DF78
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:54:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p18so2901803edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 12:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzBKrifr7mkPiYJG21R0/9X6KZhWc9gfTpNCQaGfxR8=;
        b=PuHMG+DO/TH1jPO9lTz0dH3ySyZK5V/CIBQq40IyvujtcseG/7DfxU0O1ZTDwNiFx7
         2pItBt7+u2ZGOauSTGoSQhBtVYJU/oSTrw7my3vrpuRc7XaT2YY5u50RnkhEA/ZbFzHd
         mHyspYVQJGFdhiGe694yZVOqVMbEmj+pI8BZZ2wCjQNmku10olU4vUHLsQ1vyvDSbJDR
         e1P/pBOtWZD87T8IV8aXvWZGerQDOQ8rLiVvHRSHLjQ8Mbc9cUh//qN28Ue7sfqeShPL
         kmy0TKX9w0JdyF7drD5sUtAVpbmeV1kKE7KSBicggpTzG7513xQ2rnJtASC4jYrWbX1j
         1hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzBKrifr7mkPiYJG21R0/9X6KZhWc9gfTpNCQaGfxR8=;
        b=VCBAZlzH0oTMVsF1NrUcGXzrF4joyqEF2NHwNx07j1y6qEZHFLwaie5eZ4kIGfAv+1
         i84UMAqDMzb4tN3row0TjeCk3Ua/hKI/XfJsEW9y/Qlfz2QTtuucDPLCcDXvdEohQJEQ
         t0drwbV7UgiZIUzvqmoDD5n2y08Q548p61TYQB12cOke6Kl9rGH4wgsmr+NqqLRzRft5
         vQrfYgmIuV2LDmawq/ceIlaK3KEfQgjGeb7386ClOo0pPnbGzLcdoR0qNs0iDeu7UAvo
         Z2e1KeC7BtdbwjlgHa7du2EH7W34odUNHuAGhajE72vM5x31AmUPZGf6X0Rtj5UNnriM
         zTiw==
X-Gm-Message-State: AOAM531mCihowJPe5ncMNQRnqS3oOC9uJY5qxLhGvIOnhL59p6BULbFd
        KRilyxFyk4W25NFydY6WvJOHXr8YW5my3gRHrYo=
X-Google-Smtp-Source: ABdhPJz9RDsDEQW1vZTDpmWQt9JtrfFaGK06BHhHkG/8Y+pfrinEx1EcQ9NvCauraCZy5Eamm4kKS3YwbmaPzR11kjo=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr24782167edu.158.1651694057438; Wed, 04
 May 2022 12:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <202205042019.gOXJsH4f-lkp@intel.com>
In-Reply-To: <202205042019.gOXJsH4f-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 May 2022 21:53:41 +0200
Message-ID: <CAHp75Vf9wUOKpxa5q8=tJNju_3uzTMbEGcQxAr_f14c_wp-jAQ@mail.gmail.com>
Subject: Re: [chanwoo:devfreq-testing 5/5] include/linux/list.h:638:9:
 warning: this 'for' clause does not guard...
To:     kernel test robot <lkp@intel.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, kbuild-all@lists.01.org,
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

On Wed, May 4, 2022 at 7:02 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
> head:   40eaf97ddb3a7e661942296ccf192af0edd3d77d
> commit: 40eaf97ddb3a7e661942296ccf192af0edd3d77d [5/5] PM / devfreq: Use cpufreq_policy instead of NR_CPU
> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220504/202205042019.gOXJsH4f-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=40eaf97ddb3a7e661942296ccf192af0edd3d77d
>         git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
>         git fetch --no-tags chanwoo devfreq-testing
>         git checkout 40eaf97ddb3a7e661942296ccf192af0edd3d77d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Seems like LIST_HEAD_INIT() calls in the above mentioned patch miss the &.

-- 
With Best Regards,
Andy Shevchenko
