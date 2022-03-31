Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5B4EE182
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiCaTOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbiCaTOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:14:42 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B66223B3CA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:12:54 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f38so1151971ybi.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIQLufNb37SCfOzkOCArPbhqd4DOihH6/n5qO8AwDXA=;
        b=R6I0ltOcDsZE6TO42XqLU2pi6aXqi+axzt6tZ9WuRhnhuxPDo1JlBgaiUiR+ry/fUZ
         z7cFv/K0drAop+xXPPRstFPeHGpQX0I6MxK1zt4zCc88oCflCsWodPCJMUUZ8xOsztDO
         UDd7ulS9tN1vEdzhjIk5RjB13wFcMOZkSDOVPCuKDau6HommqV3hbo88nhqujXLFvnwt
         w/r4MqFDxq0wMDjtqSAiCAnivUbkQQ6Xa/oFbN1rg9w5Oz4CF535vdZx0m81y7/8fVf7
         A3RCvBMoYUtuJA2LhR3ed7A4QOvKZ+B61zCsk8gW5eeGW0zQBi+B90qNLbCj1wIkfzt1
         5Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIQLufNb37SCfOzkOCArPbhqd4DOihH6/n5qO8AwDXA=;
        b=My6bXAIpfYuJaNjsDnNkBwnhmkvcdyqtM5MnQ1F+Eh4ytw0Sxx08lUz+KYHBMzi8zc
         MMqy3tqAmJrKn9B2FApCBvO8o/lMZnza6kIWLPy6ORS0RS/jat/CrTsp/uv3oGngJ18A
         O6feV9xP7g9GyOUmdoPpjgAzy5nbNMfpOoRaSXag/QQ0z58VSxM3m6PI4p1ovaPh6UyK
         go22Xd4n5XCOmWWs6Xzn80TDP4zlZjWS4K9gfiM6asmTb9xtUKJU71IiIE6mXNOO70Hd
         g0NUx2fW2TL7R6n7yu+zWWmVkuXvk51A245qfmI67qX8Gt64wsVZX9VWUx0KpFCTBfX7
         SLEQ==
X-Gm-Message-State: AOAM533MX8UDIeFbW/bEsoArP1bw3teg7c8GhtLK5NLXNO2V16C+ybAc
        Wof9eWRwxWpy/OabX/ZPwoXERvtJ9acNSaLUn4xDWQ==
X-Google-Smtp-Source: ABdhPJy3BzUmaImydhy+NihrdMz3H2/nNTM0A39THzkTz6E06FD9WgG+878ejt/YRoBL1zcjCZHBODNNUeHDpoeDEbU=
X-Received: by 2002:a25:b6c6:0:b0:63c:923b:c02a with SMTP id
 f6-20020a25b6c6000000b0063c923bc02amr5569490ybm.441.1648753973511; Thu, 31
 Mar 2022 12:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <202203311842.wFWvHrHn-lkp@intel.com>
In-Reply-To: <202203311842.wFWvHrHn-lkp@intel.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 31 Mar 2022 12:12:42 -0700
Message-ID: <CAJuCfpEObhCKuJeHNqxna1=N1+f738dTDnUjGPFST1PqqAqcVQ@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 1060/5872] arch/arm64/mm/mmu.c:1499:5: warning: no previous prototype for 'check_range_driver_managed'
To:     kernel test robot <lkp@intel.com>
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 3:17 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Sudarshan,
>
> FYI, the error/warning still remains.

The warnings has been fixed in later patch:
https://android-review.googlesource.com/c/kernel/common/+/1668705
android12-trusty-5.10 needs to rebase to the latest android12-5.10 to fix this.

>
> tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
> head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
> commit: 1b4aca7d82ae9b40145484fa09ceab38a6a06062 [1060/5872] ANDROID: arm64/mm: implement {populate/depopulate}_range_driver_managed
> config: arm64-buildonly-randconfig-r005-20220331 (https://download.01.org/0day-ci/archive/20220331/202203311842.wFWvHrHn-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/1b4aca7d82ae9b40145484fa09ceab38a6a06062
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
>         git checkout 1b4aca7d82ae9b40145484fa09ceab38a6a06062
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/ drivers/gpu/drm/hisilicon/kirin/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/arm64/mm/mmu.c:1499:5: warning: no previous prototype for 'check_range_driver_managed' [-Wmissing-prototypes]
>     1499 | int check_range_driver_managed(u64 start, u64 size, const char *resource_name)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/printk.h:7,
>                     from include/linux/kernel.h:16,
>                     from arch/arm64/mm/mmu.c:11:
>    arch/arm64/mm/mmu.c: In function 'check_range_driver_managed':
>    include/linux/kern_levels.h:5:25: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
>        5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
>          |                         ^~~~~~
>    include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
>       11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
>          |                         ^~~~~~~~
>    include/linux/printk.h:343:16: note: in expansion of macro 'KERN_ERR'
>      343 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>          |                ^~~~~~~~
>    arch/arm64/mm/mmu.c:1509:17: note: in expansion of macro 'pr_err'
>     1509 |                 pr_err("%s: couldn't find memory resource for start 0x%lx\n",
>          |                 ^~~~~~
>
>
> vim +/check_range_driver_managed +1499 arch/arm64/mm/mmu.c
>
>   1498
> > 1499  int check_range_driver_managed(u64 start, u64 size, const char *resource_name)
>   1500  {
>   1501          struct mem_section *ms;
>   1502          unsigned long pfn = __phys_to_pfn(start);
>   1503          unsigned long end_pfn = __phys_to_pfn(start + size);
>   1504          struct resource *res;
>   1505          unsigned long flags;
>   1506
>   1507          res = lookup_resource(&iomem_resource, start);
>   1508          if (!res) {
>   1509                  pr_err("%s: couldn't find memory resource for start 0x%lx\n",
>   1510                             __func__, start);
>   1511                  return -EINVAL;
>   1512          }
>   1513
>   1514          flags = res->flags;
>   1515
>   1516          if (!(flags & IORESOURCE_SYSRAM_DRIVER_MANAGED) ||
>   1517              strstr(resource_name, "System RAM (") != resource_name)
>   1518                  return -EINVAL;
>   1519
>   1520          for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>   1521                  ms = __pfn_to_section(pfn);
>   1522                  if (early_section(ms))
>   1523                          return -EINVAL;
>   1524          }
>   1525
>   1526          return 0;
>   1527  }
>   1528
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
