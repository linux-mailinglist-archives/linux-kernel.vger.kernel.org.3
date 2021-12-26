Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC047F977
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 00:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhLZW7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 17:59:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:25742 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234793AbhLZW7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 17:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640559546; x=1672095546;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hM5wnNZEkDJbTZR+5dIGaoAzuNP4gLIVb0lWB80xrB8=;
  b=elPLWdLOzgCBLJkyyvONcL+GwIJRpsgyqNKBHiGuRI7s38hqBhQXteyY
   Syxwk5kp+f/XptxfV81Cr3W5aLvkvHk32dSHE1nqUqDs3vsNj6Yr5+F/G
   B3rmM0pp9J38/+43OBQw0cinLe8mn4He+5MI5CAvKwX1reT7Y8ma1W6qg
   UkFRs2BGT1QLaOWtfRcfjff/yFyV/K7VPjzGqq9WfSUorouDcJ9vQg5s5
   Gnw+SvVDeiC6rqvEHCKZsJjNmWb0bwGSAWb26sPMMgLDNjGImP9tlMhyf
   8N9/dsA7LBOmx/3XB/FN9/bsNt5AY3BjOq+8YBE6MES6g8TmsuhByZVOh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="227973771"
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="227973771"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 14:59:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="509682347"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Dec 2021 14:59:04 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1cTn-0005op-Nx; Sun, 26 Dec 2021 22:59:03 +0000
Date:   Mon, 27 Dec 2021 06:58:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: arch/m68k/68000/dragen2.c:38:13: warning: no previous prototype for
 'init_dragen2'
Message-ID: <202112270633.mzOAjiEs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8ffcd3ab0e5d7332cc75c214fe74e52240b117b
commit: a734bbf694270dca8594a5c33375867dc31503f5 m68k: m68328: move platform code to separate files
date:   1 year, 1 month ago
config: m68k-randconfig-r033-20211227 (https://download.01.org/0day-ci/archive/20211227/202112270633.mzOAjiEs-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a734bbf694270dca8594a5c33375867dc31503f5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a734bbf694270dca8594a5c33375867dc31503f5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/m68k/68000/dragen2.c:38:13: warning: no previous prototype for 'init_dragen2' [-Wmissing-prototypes]
      38 | void __init init_dragen2(char *command, int size)
         |             ^~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
   Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
   Selected by
   - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
   - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC


vim +/init_dragen2 +38 arch/m68k/68000/dragen2.c

    37	
  > 38	void __init init_dragen2(char *command, int size)
    39	{
    40		mach_reset = dragen2_reset;
    41	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
