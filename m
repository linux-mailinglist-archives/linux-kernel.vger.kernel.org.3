Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21A0471391
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhLKLLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:11:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:40806 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhLKLLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639221099; x=1670757099;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fAbFi60IFUUD+KE5+DIHwvZ064IOF1cxiI6X2theHD8=;
  b=j56oAt3fzapwKnORbFvwqEUnxqtMsW9oZvMxvqTOQWJ9Gz0Nv210kO/6
   /rvqYqgD5poJ2G24MGYTUp064cW69FlwqEJ4IrxjSCWQi6wQv4SrY1GFM
   PKYhfoB4cHSoIolyqzH1co4GnMvQnBcnURTVt9EUF/uSIwJ+x8WGjhhmu
   o/GTlx74HTciVwa0TxCL7lGke5Vdz5eZ32EYiO4tyvRd/svnJ4g3bdHII
   jzrawiAl3B1gZ2zZdZAI7rLEI3sodC6dkdoFzNDek2pWdAtdSDOM+jZlW
   Ef9SFTujO8azsJ+p5+bpTrb/cqUort6wZZDnKhnxmQd0GtgzHetDSjppd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238335328"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="238335328"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 03:11:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="753571652"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Dec 2021 03:11:38 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mw0Hx-0004VE-Fu; Sat, 11 Dec 2021 11:11:37 +0000
Date:   Sat, 11 Dec 2021 19:10:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:auth-dh 25/29] auth.c:undefined reference to
 `crypto_dh_key_len'
Message-ID: <202112111917.4CtkYXOJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth-dh
head:   d0e23c18f321001215bc2eff13edcbbc4d1ce601
commit: ae9949f36ed1e27a1dae07c0022a5c89baef1d89 [25/29] nvme-auth: Diffie-Hellman key exchange support
config: s390-randconfig-r025-20211211 (https://download.01.org/0day-ci/archive/20211211/202112111917.4CtkYXOJ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=ae9949f36ed1e27a1dae07c0022a5c89baef1d89
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth-dh
        git checkout ae9949f36ed1e27a1dae07c0022a5c89baef1d89
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/nvme/host/auth.o: in function `nvme_auth_gen_privkey':
>> auth.c:(.text+0x5fea): undefined reference to `crypto_dh_key_len'
>> s390-linux-ld: auth.c:(.text+0x6024): undefined reference to `crypto_dh_encode_key'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_DH_GROUPS_RFC7919
   Depends on CRYPTO && CRYPTO_DH
   Selected by
   - NVME_AUTH && NVME_CORE

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
