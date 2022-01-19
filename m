Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D26493556
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351965AbiASHV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:21:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:57179 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351201AbiASHVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642576883; x=1674112883;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U9Cs0/eYhOxqWtZtqx6m6V7eRm9ZISPAQYWTdhpFB4M=;
  b=XEp9agXBUiTFeOtxKJ6DDCkTvL6WYaiCnIpBgNfQ1x88Q8D22P3GM7Ku
   J6NH0ESK7paJVP3h6MEHc3+YTVaeqeIp4okl3OJy02fbvQx132toVEsWw
   iInjJ+SQUBvkPEh/I9AryeLwflV5edKcCVv/NwJUDTgKAxWM+mH641c6x
   67HhslSyb1djqqdel0kqe7PP/3nLa7Meu1fuTfS0XNdf7G9RboF9du1tu
   8wZcL0D9X3zsiMzOVt50gIKq9hxn1MjZCa95jdPaukzoHDZYG9rUK6JNR
   LOmF4C4buttIqy4Lo/K2O/38O8S5nPzhx8EsFb69cZWip6rT6eSqRzwq9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="243826197"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="243826197"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 23:21:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="532150752"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 23:21:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA5HV-000DMj-51; Wed, 19 Jan 2022 07:21:21 +0000
Date:   Wed, 19 Jan 2022 15:20:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 21/80] ld.lld: error: duplicate symbol: memset
Message-ID: <202201191516.DcDnH6lu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 55f013c0bc3e224cf34271c3cc11f7443b11553f [21/80] riscv: optimized memset
config: riscv-randconfig-r042-20220118 (https://download.01.org/0day-ci/archive/20220119/202201191516.DcDnH6lu-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/55f013c0bc3e224cf34271c3cc11f7443b11553f
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 55f013c0bc3e224cf34271c3cc11f7443b11553f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: memset
   >>> defined at shadow.c
   >>> kasan/shadow.o:(memset) in archive mm/built-in.a
   >>> defined at string.c
   >>> string.o:(.text+0x1398) in archive lib/lib.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
