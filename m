Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B571F4EDBAF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbiCaObi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiCaObf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:31:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4F61B0BC4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648736977;
        bh=gcookGORwAh+F6R0JewZC6/rL+9v25CzSrBx3y0lGu8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cU8TJt3mUztmoTr+ZgI0bxuB5i/Al1X3EZTo2Hnervkq1XDbjsKbVNTbYidEA/3g7
         7UmHwbukXj50GkYpMYgksA8ZGs/f60Sbj2Pmz2MFEqohy9gYgsqHxJ7a2QVSWgf+PF
         ajon6fVM+gWTbr51GZ/NEVmQ3tmdJk0ZOIcEhh5Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.186.82]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1oFI642OHh-00gEtJ; Thu, 31
 Mar 2022 16:29:37 +0200
Message-ID: <50980608-4e4a-f479-29cd-47b88519dbcf@gmx.de>
Date:   Thu, 31 Mar 2022 16:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [deller-parisc:for-next 2/3] block/blk-map.c:318:17: error:
 implicit declaration of function 'invalidate_kernel_vmap_range'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202203312108.YiMaVSNd-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202203312108.YiMaVSNd-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dca/USF29o+diW66CMyQ/XyLTjWGj5N/kdLb8/xTC1VjAdyzcG9
 2NEJTORh77AUDmUfZaLEwX74jBEqfN2mIHqSoq7xBwxGQniIVVumjfG3znYpOXHFECcbpey
 aQR7+a/KF1VT3dAjXaF4oGCUsTpZaptbVeAQoQQntoWGi9UazKGx3wCWo0HxsJkg1BHGHAa
 dRW52yIioS0KHFbmUoBtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jiCWqIeJbT0=:gUGJKEv8c+jQtWmkEZRfPY
 IplqcCxGgcQPu18qm8ADMwNawKsA5gwJOvG0FUpg5Ir7DIJ2FVZaB5mvBk8zWYSoZEe42MAXV
 iaGdLef2GVp+zLbsdYXeF1vJXoHnF1rdlme02QttdhUMVXdSu2pLiuei62Wz+KDAz3NF1aGtG
 Rgt+DBu6m9INuSGinRTT269V9/4zMJmNzline6uf12zwHvnLc6lzh6+WDHauNe+QMBUwVFOla
 HVlQup6PfhWECDuim9uWVHq6VlNyMbqS9gRKsg3hpzpVj85ZibM0fZacNuXJP16zXMZVZvm63
 qtjQwL/H7ZlOPN/OcLAg1x8RRKMFxbrL4zqw1iJuMH0V+AKkjH3tKGHIegopetnQwiO9GOZsW
 kVUcBtCumow4Z+pJvNFU8aseQUXqJmf2DdvKMYbXPNl2beRvr8CooTmlp7x9e4/GeCf/YOk9S
 beiRlhG1ID2eVYv/G7QxMXxEA8gajK8m9FzrPRU2C6ZIqDSG9Yg0baOhY8DbEnXLr8OrzxB8V
 hVntpPy1uu7lBUq+KBerugzPce8PNeqHjrFmOlaMMCyka5p5fJtbW6a0EyxrVVB1bzGX9noUF
 G1S6g8x3tsNVyauzJvdNrkQ6fdT+doclvV8r47nHfw1I4LVv95VMqBUEUUaSZNutUl/4V6Wnr
 lczVzazpIqln51AJRK8x82f0NfZjVQ9D1qqIBFcHm/hVJbEa/c5LCqGig4RXZS71qNIMwW9Vv
 LNU+c+en33yWYnDKYAMQ222R+p6rDD6iYTNIYxkhxrSN1g/+ypVgGqbZWI27jUK+M7vy8MmbO
 dXfVJf5b2u2iTHAZUxTyRuek+Y6cIVIabqUss2l2pC4Km39FlGIkoytstgS+YYN7Q2ksgRkrc
 J7z7wC9l+Jhs0i2hMzrGzks6KGk28jhpyslwZ5frfO7zPdw3IaixUs4rCofhO8F9nvh8SneU0
 ERZZnFvCF/bLsTPjr0kvbjnS8yOccHnoxcvXYwvU2HpnpxFGi1VRs8c6JfBK99UiKILzGWD+0
 UlK3eSRYjBTe70jJs37NDne/q2ruBEu9qVTSnBD83o2S7E9UXoAcNDIwS92YmV7Mza0/C/IhB
 YlmvRnIDRMXczQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 16:01, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-li=
nux.git for-next
> head:   22fe34a0015587b8b1c7eddbf97752b046c24927
> commit: 5753bafd53dc8cdcbf6a3388747e11bc8d634ce1 [2/3] parisc: Implement=
 flush_cache_vmap_vunmap
> config: parisc-defconfig (https://download.01.org/0day-ci/archive/202203=
31/202203312108.YiMaVSNd-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-=
linux.git/commit/?id=3D5753bafd53dc8cdcbf6a3388747e11bc8d634ce1
>         git remote add deller-parisc https://git.kernel.org/pub/scm/linu=
x/kernel/git/deller/parisc-linux.git
>         git fetch --no-tags deller-parisc for-next
>         git checkout 5753bafd53dc8cdcbf6a3388747e11bc8d634ce1
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash arch/parisc/kernel/ bloc=
k/ drivers/md/ sound/core/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from include/linux/cacheflush.h:5,
>                     from include/linux/highmem.h:8,
>                     from include/linux/pagemap.h:11,
>                     from arch/parisc/kernel/cache.c:19:
>>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" r=
edefined
>       44 | #define flush_cache_vmap(start, end)            flush_cache_a=
ll()
>          |
>    arch/parisc/include/asm/cacheflush.h:41: note: this is the location o=
f the previous definition
>       41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunm=
ap(start, end)
>          |
>>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap"=
 redefined
>       45 | #define flush_cache_vunmap(start, end)          flush_cache_a=
ll()
>          |
>    arch/parisc/include/asm/cacheflush.h:42: note: this is the location o=
f the previous definition
>       42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunm=
ap(start, end)
>          |
>>> arch/parisc/kernel/cache.c:623:6: warning: no previous prototype for '=
flush_kernel_vmap_range' [-Wmissing-prototypes]
>      623 | void flush_kernel_vmap_range(void *vaddr, int size)

I fixed that up.
Thanks,
Helge
