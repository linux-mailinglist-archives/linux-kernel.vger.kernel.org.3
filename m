Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7E648265A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 03:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiAACsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 21:48:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:54309 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbiAACsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 21:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641005304; x=1672541304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xB9sPVHLrGDtS7AnFwxWetj0wZJR4BB2KzUP5dpluNs=;
  b=eqW0z4z6lrGoPUr0oigo84O3B4k6bUo4y2cuwyOXH4i32sA8d1SFW9H4
   3vi61jiOPr6wWM8oXKGQkeAnpwFudtFKxiIOX0QXxRNGh05ieICf7y29K
   seFAm9jjvFwxT9AndDlIRBr9Q/FfN3vFvTscOkQXhXRHTqSpcanmDJAA6
   egbPtybVpnQImzc6sY4hqpv7ocBFMwHkeHwvPrlylrJe/rSaIQa5C0qE0
   6Gqlrfd25w9z0mQezG2sSdHKOpFQKvnXvRVlicrLQaoBc6cbtlKa5Aa+h
   s3p4RI+fN/SkSq1w2sRyaEPewfNGBZwlFTlKkkp+Q5BQcYhId3QySIsoO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="302613357"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="302613357"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 18:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="471081553"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2021 18:48:22 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3URS-000Buh-4s; Sat, 01 Jan 2022 02:48:22 +0000
Date:   Sat, 1 Jan 2022 10:47:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: WARNING: modpost: vmlinux.o(.text+0xd7dc5): Section mismatch in
 reference from the function __next_node() to the variable
 .init.data:numa_nodes_parsed
Message-ID: <202201011044.3zHljdgM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: 5c88af59f9abc202648a431428ad9d32e5d2a201 lib: inline _find_next_bit() wrappers
date:   8 months ago
config: x86_64-buildonly-randconfig-r005-20211230 (https://download.01.org/0day-ci/archive/20220101/202201011044.3zHljdgM-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5c88af59f9abc202648a431428ad9d32e5d2a201
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5c88af59f9abc202648a431428ad9d32e5d2a201
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xd7dc5): Section mismatch in reference from the function __next_node() to the variable .init.data:numa_nodes_parsed
The function __next_node() references
the variable __initdata numa_nodes_parsed.
This is often because __next_node lacks a __initdata
annotation or the annotation of numa_nodes_parsed is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
