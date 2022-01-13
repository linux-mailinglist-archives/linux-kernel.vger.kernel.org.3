Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1948D24E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiAMGWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:22:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:39425 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbiAMGWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642054956; x=1673590956;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3NglaHSd1LaK5qTDG9TPwr4f9o6AybnD0bCxlmKIe5M=;
  b=ANqKq8dMze9roy59nvqOxWopaWMB2S8Ss1RYKqZH304TwE8kdcYAoJns
   jQcoOaSHc+9n3gABKQltyzOEgCUGCOvDlY5vb9x+q8L9/XNhtwjqjvHX7
   EsmxMjlHS2dNUOgselrresm+rdI0b/6hKF6nVRFYBWn60XXWAATtSd0RX
   iUosQYmvKCX1dtVILAACSiaQsO+E5iN7c/6t7sbtoKe+qmt/DJhXxS8Yb
   F53ZiS6XZ4JmmI7zMRpAetwwPBu8DweTVSp/w63zzwSmusiSAxDlOKvHZ
   u3V6p5dnLgT49gurXVnDxbKHxx2QLxGh5nilT7lNitaV7rIigLWtlA3rV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="330290055"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="330290055"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 22:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="623751250"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2022 22:22:34 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7tVJ-0006uK-RP; Thu, 13 Jan 2022 06:22:33 +0000
Date:   Thu, 13 Jan 2022 14:22:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
Message-ID: <202201131441.gBtxgYek-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   455e73a07f6e288b0061dfcf4fcf54fa9fe06458
commit: 5ba3747dbc9ade2d22a8f5bff3c928cb41d35030 regulator: bd71815: add select to fix build
date:   8 months ago
config: nios2-randconfig-m031-20220113 (https://download.01.org/0day-ci/archive/20220113/202201131441.gBtxgYek-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ba3747dbc9ade2d22a8f5bff3c928cb41d35030
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5ba3747dbc9ade2d22a8f5bff3c928cb41d35030
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
