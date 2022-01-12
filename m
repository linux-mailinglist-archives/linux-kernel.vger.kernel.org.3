Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145AE48CCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiALUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:06:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:55196 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357289AbiALUGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642018009; x=1673554009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPjwaqN1NK/KnSeTr6fLaDsnH7HkZg/G64JzzF8F/AY=;
  b=jflL6kAG7xY+Twd9BTi7fYGZyRpFMAHvfP0CsQ+3orCXLp3AV/iCMaM5
   sqIS34T/9pfqCZB9ok6Ysw1lFKdtLiufA34eoJk/Lo0oEaz2Kqvg9P4aS
   hrHvtVL/FdCvwdZRE7yLCv53TvQid/C/o2+hSQ8ZDfs1KbaUl1tL6nkK2
   xsagItgKh6ULnHN2cYexgvGBNgiRcYaQvUBK5Xzza01nxE2ye3YjdNOJ1
   ePiKms27q7BSF9qxc4GGB89L1Gd8lfGJA9X3s9LxgwlEAGUVW+6O/z6Cs
   z15mSYC+HNfX1IjGD6fy+0P1BsO8Z6orJ4RSE8fbhCwI741VpFNh42aaP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="224535854"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="224535854"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 12:06:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="623595595"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2022 12:06:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7jso-0006Kq-9Z; Wed, 12 Jan 2022 20:06:10 +0000
Date:   Thu, 13 Jan 2022 04:05:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V4 3/5] tty: serial: meson: The UART baud rate
Message-ID: <202201130331.dzluDr3h-lkp@intel.com>
References: <20220110085604.18042-4-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110085604.18042-4-yu.tu@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on next-20220112]
[cannot apply to robh/for-next soc/for-next clk/clk-next v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yu-Tu/the-UART-driver-compatible-with/20220110-170020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: powerpc-randconfig-s031-20220112 (https://download.01.org/0day-ci/archive/20220113/202201130331.dzluDr3h-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/6d55159e6626326d9001d4c8f20b914a69c2c40b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yu-Tu/the-UART-driver-compatible-with/20220110-170020
        git checkout 6d55159e6626326d9001d4c8f20b914a69c2c40b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/tty/serial/meson_uart.o: in function `meson_uart_probe_clocks':
   meson_uart.c:(.text+0x464): undefined reference to `__clk_get_name'
>> powerpc-linux-ld: meson_uart.c:(.text+0x4bc): undefined reference to `__devm_clk_hw_register_divider'
>> powerpc-linux-ld: meson_uart.c:(.text+0x4fc): undefined reference to `__clk_get_name'
>> powerpc-linux-ld: meson_uart.c:(.text+0x518): undefined reference to `devm_clk_hw_register_fixed_factor'
>> powerpc-linux-ld: meson_uart.c:(.text+0x5a8): undefined reference to `__devm_clk_hw_register_mux'
>> powerpc-linux-ld: meson_uart.c:(.text+0x5c0): undefined reference to `clk_hw_get_rate'
>> powerpc-linux-ld: meson_uart.c:(.text+0x5f8): undefined reference to `clk_hw_get_name'
   powerpc-linux-ld: meson_uart.c:(.text+0x640): undefined reference to `__devm_clk_hw_register_divider'
>> powerpc-linux-ld: meson_uart.c:(.text+0x65c): undefined reference to `clk_hw_get_clk'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
