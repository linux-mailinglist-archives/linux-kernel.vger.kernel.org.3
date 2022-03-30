Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89B44ECF64
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351486AbiC3WPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbiC3WPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:15:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF45F8B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:14:04 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j2so39258793ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohUWdk6Jv4uJ7zckc+ZPE6o/UzyPHrqVidE3nB9Y/io=;
        b=PogmDeYUl/eypsEXkLeet0WhRAoDMh6f38F2N76vij2zPAC8y90JL9MU4vcDEV9LjF
         7ih2jUnRHHnGY3igDrZvZNMIQb6ywhQZO8ImF9am0UByH4BY+qudLWX6eBGZXg2bds1f
         fSsvgqRHXHIa61wLRKQXVypCg7kUehZBDuoiRiutFmRQDkqlPty5aYaam5L+NKkLWSYx
         Fu3345HdTsFJwz/LN3pO76LHXodqtrj0+ZNF9ss24Z+pcaLebrXVVZxaSBuMXYNdO9cL
         BLeMQoXdPFjyGDPMlCXLQrlMWX4t8q7xcvfuAOox++5c/0xdx9gv+1KfFdQuXhb54SCd
         L8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohUWdk6Jv4uJ7zckc+ZPE6o/UzyPHrqVidE3nB9Y/io=;
        b=uuzy4SbJERFRApocANNA0dkjJosio8AXMYATVk5iiT1mBAC2F9YfscGL8aWn6banZq
         L5OeK8NN970Jp4Ww3cPiGcP0BjkZtPQUPsW2F267N+ga0LN2GfJyHzzQw04GMQeeem56
         XlCyUKVdtj08QRyN3uXMNsNkFSf1Y3+dZWLDD+RDW2b9pKXLRkcBT3Zt0IPqW7pmpXPA
         AXXsycnsulYGojKXDvkc+SYkCxFTqEDgfVhi6D6DnCTlHcUeVPa0cX8aLS80VQ5i8/pI
         0sNMN3q2rOCmVMTtcvoyk44fkyw572zt9AA8JgjtVk44L/B6vtZAnG2lhzWJKmYgucZ/
         BJEQ==
X-Gm-Message-State: AOAM5320NMIrS5XMYbRK9Qf4XxHZ+jKpVlctmtPzIxyuwei3Mz8T6xJj
        kJ4POzVSN3YGptFmN6KPMIQg4g9U8kiCq/T3ondSGA==
X-Google-Smtp-Source: ABdhPJyF7b99kJY78kD00gUjvcpr8Yge4gTbtMxUjw2qC+5vXXsI2OytH/lZhWGiymk5czKjtKawMEb+KwlUc7JzHks=
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr1766360ybs.543.1648678443446; Wed, 30
 Mar 2022 15:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <202203301416.uykWxBeR-lkp@intel.com>
In-Reply-To: <202203301416.uykWxBeR-lkp@intel.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 30 Mar 2022 15:13:52 -0700
Message-ID: <CAJuCfpG_em1O+11oE0fC4htmKd11ygT_phF5hOjbyfxw68Xq1A@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5835/5872] mm/compaction.c:766:15: error: redefinition of 'isolate_and_split_free_page'
To:     kernel test robot <lkp@intel.com>
Cc:     Charan Teja Reddy <charante@codeaurora.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 11:32 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
> head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
> commit: 8cd9aa93b7269460e8d5e4407738f21fe5d6e720 [5835/5872] ANDROID: implement wrapper for reverse migration
> config: arm64-randconfig-r036-20220327 (https://download.01.org/0day-ci/archive/20220330/202203301416.uykWxBeR-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/ammarfaizi2/linux-block/commit/8cd9aa93b7269460e8d5e4407738f21fe5d6e720
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
>         git checkout 8cd9aa93b7269460e8d5e4407738f21fe5d6e720
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> mm/compaction.c:766:15: error: redefinition of 'isolate_and_split_free_page'
>    unsigned long isolate_and_split_free_page(struct page *page,
>                  ^
>    include/linux/compaction.h:241:22: note: previous definition is here
>    static unsigned long isolate_and_split_free_page(struct page *page,
>                         ^
>    1 error generated.
>

This issue has been fixed by
https://android-review.googlesource.com/c/kernel/common/+/1685698


>
> vim +/isolate_and_split_free_page +766 mm/compaction.c
>
>    765
>  > 766  unsigned long isolate_and_split_free_page(struct page *page,
>    767                                                  struct list_head *list)
>    768  {
>    769          unsigned long isolated;
>    770          unsigned int order;
>    771
>    772          if (!PageBuddy(page))
>    773                  return 0;
>    774
>    775          order = buddy_order(page);
>    776          isolated = __isolate_free_page(page, order);
>    777          if (!isolated)
>    778                  return 0;
>    779
>    780          set_page_private(page, order);
>    781          list_add(&page->lru, list);
>    782
>    783          split_map_pages(list);
>    784
>    785          return isolated;
>    786  }
>    787  EXPORT_SYMBOL_GPL(isolate_and_split_free_page);
>    788
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
