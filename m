Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A804147AA44
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhLTNVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:21:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:42409 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhLTNVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640006469; x=1671542469;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YThZBUEq0yAKsOgu78DkFbSC/NdCkyI0c/T5ERBRNlk=;
  b=HgyIq7PNUORjeBQQqZHgt71YnMnGjqtUfwkNaO0/icL4o5CGAVvtvvua
   MHZAphePoDH+pV7V/nKra6LO6+RtcscW+U0zg70sHw/UUJCykXsnfvwkf
   Vi2XSGYIyl0mozZoyZGhyVSYyKeCXnPweYJWETem068JktpMmQestIjqI
   /1nWKzIVQQB0lBW7bhAXj5THhxkDLZIt7NXpcyq7UZIehf+csoWnR/ZC5
   /4CT9GwX3lueT83mvhj7AVMj/L9DgzuV9aIyJbS3PqeXWESH9v2s7N0q+
   kAgI3R3hpXqgJKvQQNUmnH21iLbld7veTPAWr+d+yD3Z+HGAgfeiYuJNn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="326459129"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="326459129"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 05:21:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="467385509"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2021 05:21:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzIbC-0007nC-U0; Mon, 20 Dec 2021 13:21:06 +0000
Date:   Mon, 20 Dec 2021 21:20:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [hyperv:hyperv-next 1/5] swiotlb.c:undefined reference to `memremap'
Message-ID: <202112202134.o20RMLOK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
head:   63cd06c67a2f46009da6e88ca46f9c7231ab8998
commit: f16dc95481e2ef2c385008f8b7bd382ea6919ee2 [1/5] swiotlb: Add swiotlb bounce buffer remap function for HV IVM
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20211220/202112202134.o20RMLOK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=f16dc95481e2ef2c385008f8b7bd382ea6919ee2
        git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
        git fetch --no-tags hyperv hyperv-next
        git checkout f16dc95481e2ef2c385008f8b7bd382ea6919ee2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/swiotlb.o: in function `swiotlb_update_mem_attributes':
>> swiotlb.c:(.init.text+0x146): undefined reference to `memremap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
