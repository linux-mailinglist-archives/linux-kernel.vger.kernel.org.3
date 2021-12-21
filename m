Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCEE47C4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbhLURRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:17:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:60149 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240285AbhLURRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640107061; x=1671643061;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uu33LOK4qwWzfdPXRVzPelHHg68k1vySkIq6nh44PRg=;
  b=Ta4QJ065AgZEY29ZbDKWd82n88sd0R0sgLiQgFxyJ8NC2Uzz8/FeNV0Q
   ZlhQK7+ML7BPne2J1BSwgkxwF50dsOWbNhNiy3d0rK+jjKcihVP/TGKS9
   AGOSb3ErjgCGf12tlOflsPjA34o+GKfBLHy7hOrUoj0LVlzviN34W/pV/
   mCr9rmfyb6BcJrYzIEv2wOsj7nEbW2ZEIa69TvkgIqaRgNIqJafsyOTXf
   NItXpqt1mGTEqaJYhvdeHrxfa8ZL0pr6cOPrYgBRuRWqf132LyVmN2mwX
   dCjk7t9fYlYI2oMvO/zMISbjszh+CpbQp/9hhuwSLnBY18G6bwRx9+7kI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="303810001"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="303810001"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 09:16:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="484479443"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Dec 2021 09:16:01 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzik5-0009F8-0E; Tue, 21 Dec 2021 17:16:01 +0000
Date:   Wed, 22 Dec 2021 01:15:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: [davidhildenbrand:node_hotadd 2/4] page_alloc.c:undefined reference
 to `node_data'
Message-ID: <202112220034.O29PTsoB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux node_hotadd
head:   5d8ab9307e53b2fdd73069b778c41518a6427e3a
commit: a05404ee36ed7baa83d2758eb024c2f712660b78 [2/4] mm: handle uninitialized numa nodes gracefully
config: mips-ip27_defconfig (https://download.01.org/0day-ci/archive/20211222/202112220034.O29PTsoB-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/davidhildenbrand/linux/commit/a05404ee36ed7baa83d2758eb024c2f712660b78
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand node_hotadd
        git checkout a05404ee36ed7baa83d2758eb024c2f712660b78
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
>> page_alloc.c:(.init.text+0x1dfc): undefined reference to `node_data'
>> mips64-linux-ld: page_alloc.c:(.init.text+0x1e1c): undefined reference to `node_data'
   mips64-linux-ld: page_alloc.c:(.init.text+0x1e20): undefined reference to `node_data'
   mips64-linux-ld: page_alloc.c:(.init.text+0x1e34): undefined reference to `node_data'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
