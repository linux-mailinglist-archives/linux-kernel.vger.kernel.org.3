Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA149F276
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346026AbiA1EYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:24:22 -0500
Received: from mx.socionext.com ([202.248.49.38]:32419 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233877AbiA1EYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:24:22 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Jan 2022 13:24:21 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E1C462083C4C;
        Fri, 28 Jan 2022 13:24:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 28 Jan 2022 13:24:20 +0900
Received: from [10.212.180.105] (unknown [10.212.180.105])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 4D760C1E22;
        Fri, 28 Jan 2022 13:24:20 +0900 (JST)
Subject: Re: [PATCH 2/3] pinctrl: uniphier: Divide pinmux group to support 1ch
 and 2ch I2S
To:     Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>
References: <1643283344-24911-3-git-send-email-hayashi.kunihiko@socionext.com>
 <202201280448.njc6LUNd-lkp@intel.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <66679643-05a3-a404-adac-a18f008d7e65@socionext.com>
Date:   Fri, 28 Jan 2022 13:24:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202201280448.njc6LUNd-lkp@intel.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/28 6:00, kernel test robot wrote:
> Hi Kunihiko,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linusw-pinctrl/devel]
> [also build test ERROR on v5.17-rc1 next-20220127]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/Kunihiko-Hayashi/pinctrl-uniphier
> -Add-some-more-pinmux-settings/20220127-193715
> base:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> devel
> config: openrisc-buildonly-randconfig-r003-20220124
> (https://download.01.org/0day-ci/archive/20220128/202201280448.njc6LUNd-lk
> p@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          #
> https://github.com/0day-ci/linux/commit/e0e366a006b79517336423f8a2c7266117
> 8d5e41
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review
> Kunihiko-Hayashi/pinctrl-uniphier-Add-some-more-pinmux-settings/20220127-1
> 93715
>          git checkout e0e366a006b79517336423f8a2c72661178d5e41
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross
> O=build_dir ARCH=openrisc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:
> 12:
>>> drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:958:34: error:
> 'aout4_groups' undeclared here (not in a function); did you mean
> 'aout3_groups'?
>       958 |         UNIPHIER_PINMUX_FUNCTION(aout4),
>           |                                  ^~~~~
>     drivers/pinctrl/uniphier/pinctrl-uniphier.h:179:27: note: in definition
> of macro 'UNIPHIER_PINMUX_FUNCTION'
>       179 |                 .groups = func##_groups,
> \
>           |                           ^~~~
>     In file included from include/linux/container_of.h:5,
>                      from include/linux/kernel.h:21,
>                      from drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:
> 6:
>>> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width
> not an integer constant
>        16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct {
> int:(-!!(e)); })))
>           |                                                   ^
>     include/linux/compiler.h:258:33: note: in expansion of macro
> 'BUILD_BUG_ON_ZERO'
>       258 | #define __must_be_array(a)
> BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>           |                                 ^~~~~~~~~~~~~~~~~
>     include/linux/kernel.h:55:59: note: in expansion of macro
> '__must_be_array'
>        55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
> __must_be_array(arr))
>           |
> ^~~~~~~~~~~~~~~
>     drivers/pinctrl/uniphier/pinctrl-uniphier.h:180:31: note: in expansion
> of macro 'ARRAY_SIZE'
>       180 |                 .num_groups = ARRAY_SIZE(func##_groups),
> \
>           |                               ^~~~~~~~~~
>     drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:958:9: note: in
> expansion of macro 'UNIPHIER_PINMUX_FUNCTION'
>       958 |         UNIPHIER_PINMUX_FUNCTION(aout4),
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +958 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
> 
>     949	
>     950	static const struct uniphier_pinmux_function
> uniphier_pxs2_functions[] = {
>     951		UNIPHIER_PINMUX_FUNCTION(ain1),
>     952		UNIPHIER_PINMUX_FUNCTION(ain2),
>     953		UNIPHIER_PINMUX_FUNCTION(ain3),
>     954		UNIPHIER_PINMUX_FUNCTION(ainiec1),
>     955		UNIPHIER_PINMUX_FUNCTION(aout1),
>     956		UNIPHIER_PINMUX_FUNCTION(aout2),
>     957		UNIPHIER_PINMUX_FUNCTION(aout3),
>   > 958		UNIPHIER_PINMUX_FUNCTION(aout4),

The aout4 function doesn't exist now. I'll remove them in next.

Thank you,

>     959		UNIPHIER_PINMUX_FUNCTION(aoutiec1),
>     960		UNIPHIER_PINMUX_FUNCTION(aoutiec2),
>     961		UNIPHIER_PINMUX_FUNCTION(emmc),
>     962		UNIPHIER_PINMUX_FUNCTION(ether_mii),
>     963		UNIPHIER_PINMUX_FUNCTION(ether_rgmii),
>     964		UNIPHIER_PINMUX_FUNCTION(ether_rmii),
>     965		UNIPHIER_PINMUX_FUNCTION(i2c0),
>     966		UNIPHIER_PINMUX_FUNCTION(i2c1),
>     967		UNIPHIER_PINMUX_FUNCTION(i2c2),
>     968		UNIPHIER_PINMUX_FUNCTION(i2c3),
>     969		UNIPHIER_PINMUX_FUNCTION(i2c5),
>     970		UNIPHIER_PINMUX_FUNCTION(i2c6),
>     971		UNIPHIER_PINMUX_FUNCTION(nand),
>     972		UNIPHIER_PINMUX_FUNCTION(sd),
>     973		UNIPHIER_PINMUX_FUNCTION(spi0),
>     974		UNIPHIER_PINMUX_FUNCTION(spi1),
>     975		UNIPHIER_PINMUX_FUNCTION(system_bus),
>     976		UNIPHIER_PINMUX_FUNCTION(uart0),
>     977		UNIPHIER_PINMUX_FUNCTION(uart1),
>     978		UNIPHIER_PINMUX_FUNCTION(uart2),
>     979		UNIPHIER_PINMUX_FUNCTION(uart3),
>     980		UNIPHIER_PINMUX_FUNCTION(usb0),
>     981		UNIPHIER_PINMUX_FUNCTION(usb1),
>     982		UNIPHIER_PINMUX_FUNCTION(usb2),
>     983		UNIPHIER_PINMUX_FUNCTION(usb3),
>     984	};
>     985	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

-- 
---
Best Regards
Kunihiko Hayashi
