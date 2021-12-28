Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666F14805D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 04:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhL1DHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 22:07:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:16984 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234588AbhL1DHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 22:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640660870; x=1672196870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IKGyivILWUkPi+oFLWA34xmU0l3xFxIwYMD78Wz0EY4=;
  b=XQ2eOi/6bruQAR6vEJXiVMbneoPonr39BRy2YrS0fR7NHqGs8S85vojY
   +tb31o0nrechhVXVupU1l7MSBae5RfbTX9NHj1gq/tGPU9irwTxU+rHZp
   KiZmsolXQDuJBbEcDBYk5FQ0OGo3rSrclk9QfkTyagwGTqJ595v/KvMiK
   oEo5vc8pclFpcrP2BmrBdMuw0uVqhahX9JvqutLhyO3LIkXMd5f4CtPLv
   BLAwKWswAEiY+zSHJjOzCwY4iuzBxkkZ43Hzio1AVBbpdMe/WQbLQXYi+
   Zd1K04jb1n4I/fKI4FJsQiqt4JJ71xOWAih/GuM3K9qCO4HA/8weIaVuH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="302056337"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="302056337"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 19:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="469898288"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Dec 2021 19:07:48 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n22q3-0007Ay-KN; Tue, 28 Dec 2021 03:07:47 +0000
Date:   Tue, 28 Dec 2021 11:07:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/5.15 1116/2170] ERROR: modpost:
 "clk_set_parent" [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
Message-ID: <202112281034.8zUmU0BW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.15
head:   f0c9869ba6f4a1f5c9e19917c891befce3a0e025
commit: 3d0f4ae1ad757ab4ee6ac31a7fd49eea2835c787 [1116/2170] mips: lantiq: add support for clk_get_parent()
config: mips-randconfig-r023-20211228 (https://download.01.org/0day-ci/archive/20211228/202112281034.8zUmU0BW-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=3d0f4ae1ad757ab4ee6ac31a7fd49eea2835c787
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.15
        git checkout 3d0f4ae1ad757ab4ee6ac31a7fd49eea2835c787
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "clk_set_parent" [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
>> ERROR: modpost: "clk_set_parent" [sound/soc/atmel/snd-soc-atmel-i2s.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
