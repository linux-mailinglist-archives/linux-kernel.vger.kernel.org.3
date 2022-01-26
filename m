Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE80749D33E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiAZUOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:14:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:15905 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbiAZUOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643228057; x=1674764057;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2ehbgywxOL2x8icon0SdEK2VZ1lmwx8B+ceEeAzmDHA=;
  b=VsiXCDT22+7sUjpXoWZE6cG08RqNRarNA6hhBvAvfNKoGM+5dIimEb6A
   MbkrVh1zW3QzfiWMsB9E0NuB8s+ZQJlpFQJnaKPuP5FOuqsxuHD28Za6l
   x2frn2vMV89MjoYEofEpqyvndPDHBtoxqfKTZZpHWVSbQNhSFJ/z6XEkU
   zFGDHR/knx0xh94sRUymr66HdfucaoUw3RAdaH09qwNsQfNBXbPS7B0qm
   5ZgcecZ2V23x1B2KXOS8G5TTwiUAmyliM6KUhZrhfEHJHz3On4VDS1W6w
   t4Dhkqnbk5fNQMbLG3Va3S5fCExS9aAi4nOas6PzTIQPiWmoU1gvUOUwC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246419393"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="246419393"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:14:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="480008581"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2022 12:14:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCogJ-000Lc5-Cs; Wed, 26 Jan 2022 20:14:15 +0000
Date:   Thu, 27 Jan 2022 04:14:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: [kdave-btrfs-devel:misc-next 42/42] ERROR: modpost: "__umoddi3"
 [fs/btrfs/btrfs.ko] undefined!
Message-ID: <202201270444.Mr7lq3UP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git misc-next
head:   f498cd59825cbf77b3e2dedc0ab6cf754a1049b4
commit: f498cd59825cbf77b3e2dedc0ab6cf754a1049b4 [42/42] btrfs: add support for multiple global roots
config: openrisc-buildonly-randconfig-r003-20220124 (https://download.01.org/0day-ci/archive/20220127/202201270444.Mr7lq3UP-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/kdave/btrfs-devel/commit/f498cd59825cbf77b3e2dedc0ab6cf754a1049b4
        git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-devel.git
        git fetch --no-tags kdave-btrfs-devel misc-next
        git checkout f498cd59825cbf77b3e2dedc0ab6cf754a1049b4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
