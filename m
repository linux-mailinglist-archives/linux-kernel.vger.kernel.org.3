Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4827D4716DE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhLKVoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:44:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:8654 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhLKVoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639259094; x=1670795094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S7/s37vGFgZgKl4rhGtVa+aLJ+ppq+5mC9TF0EFuJPM=;
  b=HejzHSmscw414pYvhfm5ntGFFfZw7Vvht4CZsZrBFdVDAx92VB+CDt4f
   MaAL6DBIoT5wVvh+3rtZ8VQEt2ToNqtymUJfEOGnLSZW+68d13fp/blly
   ON1npD1kAjiev3Wga8O+IceaB/yi0pj/x1og9EzUsqj47qu7Rt5uqw968
   1qMZ2Kvr2VYIMKlXbaILUGtuBF9XAQhF8FrkBTnPeX0VkK+mRx/FQopkN
   peA+r/55p7qUq6qGxXLHV4hHLP/8KwH31oClNePQnctr5aiW8rFWZ/dyX
   t4BSfrr+KI0Sc6L6GMfPzDKKW8HDp3NiNyWt8AQ6snqk3WOHZdcJ7JQAA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="299347484"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="299347484"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 13:44:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="462954357"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Dec 2021 13:44:52 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwAAm-00056v-2G; Sat, 11 Dec 2021 21:44:52 +0000
Date:   Sun, 12 Dec 2021 05:44:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [chanwoo:devfreq-next 1/1] sun8i-a33-mbus.c:undefined reference to
 `clk_rate_exclusive_put'
Message-ID: <202112120540.XTnqQCNb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-next
head:   8bfd4858b4bba8fec14e4296cbac71aa55260d60
commit: 8bfd4858b4bba8fec14e4296cbac71aa55260d60 [1/1] PM / devfreq: Add a driver for the sun8i/sun50i MBUS
config: sh-buildonly-randconfig-r005-20211211 (https://download.01.org/0day-ci/archive/20211212/202112120540.XTnqQCNb-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=8bfd4858b4bba8fec14e4296cbac71aa55260d60
        git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
        git fetch --no-tags chanwoo devfreq-next
        git checkout 8bfd4858b4bba8fec14e4296cbac71aa55260d60
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/devfreq/sun8i-a33-mbus.o: in function `sun8i_a33_mbus_remove':
>> sun8i-a33-mbus.c:(.text+0x500): undefined reference to `clk_rate_exclusive_put'
   sh4-linux-ld: drivers/devfreq/sun8i-a33-mbus.o: in function `sun8i_a33_mbus_probe':
>> sun8i-a33-mbus.c:(.text+0xa74): undefined reference to `clk_rate_exclusive_get'
>> sh4-linux-ld: sun8i-a33-mbus.c:(.text+0xc70): undefined reference to `clk_rate_exclusive_put'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
