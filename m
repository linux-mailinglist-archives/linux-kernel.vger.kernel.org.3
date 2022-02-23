Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5494C1378
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiBWNAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiBWNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:00:14 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215F233E85
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:59:46 -0800 (PST)
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MX0Xf-1nlNBw26xd-00XOVO for <linux-kernel@vger.kernel.org>; Wed, 23 Feb
 2022 13:59:45 +0100
Received: by mail-wm1-f41.google.com with SMTP id c18-20020a7bc852000000b003806ce86c6dso1456227wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:59:45 -0800 (PST)
X-Gm-Message-State: AOAM530QwHEWVDhSLR7Az8RD7QMKvS0dltSG2wFgoiCWcJ5B2Pv+KHv+
        uVrthyarchfJnGJuNANiociQpYSLVjQ6UlwfycU=
X-Google-Smtp-Source: ABdhPJwrXMZ2Sp+1Yv51dw7LJzOihjOcH8LsPOt8g857TtX9P2CjdxvZ6l9BpnSV+7TOp6DTTWj/oYgAaIYR4u/i5CU=
X-Received: by 2002:a05:600c:2108:b0:34e:870:966e with SMTP id
 u8-20020a05600c210800b0034e0870966emr7466945wml.173.1645621185080; Wed, 23
 Feb 2022 04:59:45 -0800 (PST)
MIME-Version: 1.0
References: <202202231910.H30peLyl-lkp@intel.com>
In-Reply-To: <202202231910.H30peLyl-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Feb 2022 13:59:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3dL3AJ31c7znroXH+hZaEJvxdqszxTU6D6Q2BgcV0Mog@mail.gmail.com>
Message-ID: <CAK8P3a3dL3AJ31c7znroXH+hZaEJvxdqszxTU6D6Q2BgcV0Mog@mail.gmail.com>
Subject: Re: include/linux/eventpoll.h:81:13: sparse: sparse: restricted
 __poll_t degrades to integer
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7lZZiMMcE4sxb5PPSWsaHcvrOFY+0hX1yBez0v/Y5wnh85F6iQC
 W+2pjrzPewOa+5itR8nYFepCA0xd8m6qG6dHN3gRUmjBKMoVR7qEUFMmlhQed8In6tuL9eD
 25JcOEnLGi4f/xRqr8+qegK0ckPHpL74goQMrE5RVO5QFjuFv4oylTTGMtdzlSDGRcFD63i
 4flh0gOrJzN7vmH+ycnmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3awXs+FJazk=:Yx//eCWcuB93h9MaeRhMjq
 p5T/+Y3/Ogt5Mo31HfpiItc3ZORoUpPjR1TaG8Q8upURaMjgTAoGF5lYwudYYiw6am+V7OrhU
 l/8nQVK+PmhRtEJ7WuqEacbwdUMJnIiFtenlsNSPAsvvGfhuSfH9Lr4NY52pCMA2zGM/Rumuy
 QimaAhT0PPj+nKf8xcJ6dLRHAH/pelj7xi3KHkAZiaCmOP9XsISgc9DYfdHn0dtQ+7zMWU62L
 JUEM7JCoNNP/JEM1G+RsgJtsNOGeNoVfKv4TqTWCW/cGPkx8nYV1y/jM+OI4Sn7vZNKOPP5bm
 XXxjLzflWl/99VyBXiLHVLmKg43pQ9rUjw2aUYNLZCT6mQsNFTvbjsdUZRQ2c5zg8UwTinSH+
 jXUrWRFspVNHAR+1Dx1JCQa9nVz5WmTbgu76H2RN0PZr5IueWmw0EUM9y1wsWvPdFw6CMkmdD
 rLNQZSegZwV4GHeyuyIj1LqAQ/TUGVS9XTNP008Dq6xDAgE0AIJ+LNq5v9WmJQqrV1DmkCXGF
 Os85N44XNGqKcV99Q8dIj8MSaQmf9hfhXvHKNfDOrBDTdDbIx3fzlIh/YGzyFup4r94OFB45s
 mYx+tNmh4xs+DQbzECi3hdzLXAUnr8n1uENUansAey27KUJP9gpbjdCwkE+TIivIdv7xGL2ZO
 3IfzvLjRd8+ZlMwE/K55HiV7CCfa3A8YEfGC9BLd1NjUVuhs9JwJPx4EI+vyL23xI51c=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 1:47 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5c1ee569660d4a205dced9cb4d0306b907fb7599
> commit: 249dbe74d3c4b568a623fb55c56cddf19fdf0b89 ARM: 9108/1: oabi-compat: rework epoll_wait/epoll_pwait emulation
> date:   6 months ago
> config: riscv-randconfig-s031-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231910.H30peLyl-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=249dbe74d3c4b568a623fb55c56cddf19fdf0b89
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 249dbe74d3c4b568a623fb55c56cddf19fdf0b89
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>    fs/eventpoll.c: note: in included file:
> >> include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t degrades to integer
> >> include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t degrades to integer
>    include/linux/eventpoll.h:81:13: sparse: sparse: cast from restricted __poll_t

The code is only moved from one file to another, so I don't think this
adds a new sparse
warning but only changes the build log contents.

>     77  static inline struct epoll_event __user *
>     78  epoll_put_uevent(__poll_t revents, __u64 data,
>     79                   struct epoll_event __user *uevent)
>     80  {
>   > 81          if (__put_user(revents, &uevent->events) ||
>     82              __put_user(data, &uevent->data))
>     83                  return NULL;
>     84

I think the problem is the riscv __put_user() macro, this should not
warn when storing a __poll_t into a __user*__poll_t pointer.

       Arnd
