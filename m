Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E765648C7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355076AbiALQLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:11:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:37552 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355006AbiALQK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642003857; x=1673539857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ipD9hbJokTRSTGdDIxN+I8+vGqTQwY5g/3aB1hWi24M=;
  b=NHk219ySu1HAkne0K0Mo3vvvVeyW78AJZFnmvNLk3gOVaOTgdlJX/xWY
   CMyO+qJI65mux5DIM5UTSPYJJVeBc7HXZgebNQQ02OsumFNtDLHOvirDz
   IZB+i6ystGyZMV2QInoKHSP5vkD+OPD/VBbwWI0NYG5QTh562jyoZ3boP
   wqRfE0ks2XlzRjQXCbuKazmcbYmFIgUSVojyVNxrw0w+quxFUVEXI/XyF
   9d8q7VqdHZC+Fgen/HeU8UoStfASDkcCOUhF7UyoXAY04ExM41unPREgN
   SO6Yue5CY2kRc406I1Puos3sOMLu5R3oPsQMnYtf9C0on17yPC6RD9YOb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="242586675"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="242586675"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 08:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="623492490"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2022 08:09:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7gBK-00065i-4O; Wed, 12 Jan 2022 16:09:02 +0000
Date:   Thu, 13 Jan 2022 00:08:44 +0800
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
Message-ID: <202201130013.KVlPG5Gj-lkp@intel.com>
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
config: m68k-randconfig-m031-20220112 (https://download.01.org/0day-ci/archive/20220113/202201130013.KVlPG5Gj-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6d55159e6626326d9001d4c8f20b914a69c2c40b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yu-Tu/the-UART-driver-compatible-with/20220110-170020
        git checkout 6d55159e6626326d9001d4c8f20b914a69c2c40b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: arch/m68k/kernel/machine_kexec.o: in function `machine_kexec':
   machine_kexec.c:(.text+0x6a): undefined reference to `m68k_mmutype'
   m68k-linux-ld: machine_kexec.c:(.text+0x72): undefined reference to `m68k_cputype'
   m68k-linux-ld: arch/m68k/kernel/relocate_kernel.o:(.m68k_fixup+0x0): undefined reference to `M68K_FIXUP_MEMOFFSET'
   m68k-linux-ld: arch/m68k/kernel/relocate_kernel.o:(.m68k_fixup+0x8): undefined reference to `M68K_FIXUP_MEMOFFSET'
   m68k-linux-ld: arch/m68k/kernel/uboot.o: in function `process_uboot_commandline':
   uboot.c:(.init.text+0x32): undefined reference to `_init_sp'
   m68k-linux-ld: drivers/tty/serial/meson_uart.o: in function `meson_uart_probe_clocks':
   meson_uart.c:(.text+0x4de): undefined reference to `__clk_get_name'
>> m68k-linux-ld: meson_uart.c:(.text+0x53c): undefined reference to `__devm_clk_hw_register_divider'
>> m68k-linux-ld: meson_uart.c:(.text+0x5a8): undefined reference to `__devm_clk_hw_register_mux'
>> m68k-linux-ld: meson_uart.c:(.text+0x5c0): undefined reference to `clk_hw_get_rate'
>> m68k-linux-ld: meson_uart.c:(.text+0x5d2): undefined reference to `clk_hw_get_name'
   m68k-linux-ld: meson_uart.c:(.text+0x622): undefined reference to `__devm_clk_hw_register_divider'
>> m68k-linux-ld: meson_uart.c:(.text+0x63c): undefined reference to `clk_hw_get_clk'
>> m68k-linux-ld: meson_uart.c:(.text+0x666): undefined reference to `__clk_get_name'
>> m68k-linux-ld: meson_uart.c:(.text+0x6ae): undefined reference to `devm_clk_hw_register_fixed_factor'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
