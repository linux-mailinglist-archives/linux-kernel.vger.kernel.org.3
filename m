Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8389B49FECB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbiA1RRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:17:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:51240 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343563AbiA1RRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643390263; x=1674926263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EAstl1vDPwM9ulW0eXI5zn1dN21JS95VyBeJuSj82zI=;
  b=K5n9UGfeBYLlJvcKih/0F67QTQMHfrCxfmZk7VVVatW2VqwQQQ1rLtR4
   e4KYlVkIXIXkLQLl40TtlW64BdrWoLBKsORWLw8xTjz5TE36XAps5f4ZZ
   tV0/lA9BUfAV22zvonjTWjD2avlU2rbuhGuGTPAbPlhZeuhZZ9OV2fNoX
   SMWa/bVhjTMsupMWKqJawEEBxKECW/QXx1zFRK6XzTSOYAKFuUmGTMlZ8
   4UuOhbm/mqGp1oPKj/zR8B/fNvf0iF9hGlxQGJXNMTgwOai/YlLowIofg
   DbrvtebtT4JOWP00iEJM0ljoiz0no+Mqv5mDMdx3iw/8V5SHuVVd1wlWZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="230737823"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="230737823"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 09:17:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="480806704"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2022 09:17:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDUsU-000O8G-EU; Fri, 28 Jan 2022 17:17:38 +0000
Date:   Sat, 29 Jan 2022 01:16:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhanglianjie <zhanglianjie@uniontech.com>, keescook@chromium.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        yzaikin@google.com, mcgrof@kernel.org, akpm@linux-foundation.org,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: Re: [PATCH] mm: move page-writeback sysctls to is own file
Message-ID: <202201290051.7pu9CEMG-lkp@intel.com>
References: <20220128091901.18074-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128091901.18074-1-zhanglianjie@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhanglianjie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17-rc1 next-20220128]
[cannot apply to hnaz-mm/master linux/master kees/for-next/pstore]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhanglianjie/mm-move-page-writeback-sysctls-to-is-own-file/20220128-172052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 23a46422c56144939c091c76cf389aa863ce9c18
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220129/202201290051.7pu9CEMG-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/d24502aa729978894feb2de10481cd139ae5bb42
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhanglianjie/mm-move-page-writeback-sysctls-to-is-own-file/20220128-172052
        git checkout d24502aa729978894feb2de10481cd139ae5bb42
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/page-writeback.c:509:5: warning: no previous prototype for 'dirty_background_ratio_handler' [-Wmissing-prototypes]
     509 | int dirty_background_ratio_handler(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/page-writeback.c:520:5: warning: no previous prototype for 'dirty_background_bytes_handler' [-Wmissing-prototypes]
     520 | int dirty_background_bytes_handler(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/page-writeback.c:531:5: warning: no previous prototype for 'dirty_ratio_handler' [-Wmissing-prototypes]
     531 | int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
         |     ^~~~~~~~~~~~~~~~~~~
>> mm/page-writeback.c:545:5: warning: no previous prototype for 'dirty_bytes_handler' [-Wmissing-prototypes]
     545 | int dirty_bytes_handler(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~
>> mm/page-writeback.c:2002:5: warning: no previous prototype for 'dirty_writeback_centisecs_handler' [-Wmissing-prototypes]
    2002 | int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/dirty_background_ratio_handler +509 mm/page-writeback.c

a756cf5908530e Johannes Weiner   2012-01-10  508  
2da02997e08d3e David Rientjes    2009-01-06 @509  int dirty_background_ratio_handler(struct ctl_table *table, int write,
32927393dc1ccd Christoph Hellwig 2020-04-24  510  		void *buffer, size_t *lenp, loff_t *ppos)
2da02997e08d3e David Rientjes    2009-01-06  511  {
2da02997e08d3e David Rientjes    2009-01-06  512  	int ret;
2da02997e08d3e David Rientjes    2009-01-06  513  
8d65af789f3e2c Alexey Dobriyan   2009-09-23  514  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
2da02997e08d3e David Rientjes    2009-01-06  515  	if (ret == 0 && write)
2da02997e08d3e David Rientjes    2009-01-06  516  		dirty_background_bytes = 0;
2da02997e08d3e David Rientjes    2009-01-06  517  	return ret;
2da02997e08d3e David Rientjes    2009-01-06  518  }
2da02997e08d3e David Rientjes    2009-01-06  519  
2da02997e08d3e David Rientjes    2009-01-06 @520  int dirty_background_bytes_handler(struct ctl_table *table, int write,
32927393dc1ccd Christoph Hellwig 2020-04-24  521  		void *buffer, size_t *lenp, loff_t *ppos)
2da02997e08d3e David Rientjes    2009-01-06  522  {
2da02997e08d3e David Rientjes    2009-01-06  523  	int ret;
2da02997e08d3e David Rientjes    2009-01-06  524  
8d65af789f3e2c Alexey Dobriyan   2009-09-23  525  	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
2da02997e08d3e David Rientjes    2009-01-06  526  	if (ret == 0 && write)
2da02997e08d3e David Rientjes    2009-01-06  527  		dirty_background_ratio = 0;
2da02997e08d3e David Rientjes    2009-01-06  528  	return ret;
2da02997e08d3e David Rientjes    2009-01-06  529  }
2da02997e08d3e David Rientjes    2009-01-06  530  
32927393dc1ccd Christoph Hellwig 2020-04-24 @531  int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
32927393dc1ccd Christoph Hellwig 2020-04-24  532  		size_t *lenp, loff_t *ppos)
04fbfdc14e5f48 Peter Zijlstra    2007-10-16  533  {
04fbfdc14e5f48 Peter Zijlstra    2007-10-16  534  	int old_ratio = vm_dirty_ratio;
2da02997e08d3e David Rientjes    2009-01-06  535  	int ret;
2da02997e08d3e David Rientjes    2009-01-06  536  
8d65af789f3e2c Alexey Dobriyan   2009-09-23  537  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
04fbfdc14e5f48 Peter Zijlstra    2007-10-16  538  	if (ret == 0 && write && vm_dirty_ratio != old_ratio) {
eb608e3a344b3a Jan Kara          2012-05-24  539  		writeback_set_ratelimit();
2da02997e08d3e David Rientjes    2009-01-06  540  		vm_dirty_bytes = 0;
2da02997e08d3e David Rientjes    2009-01-06  541  	}
2da02997e08d3e David Rientjes    2009-01-06  542  	return ret;
2da02997e08d3e David Rientjes    2009-01-06  543  }
2da02997e08d3e David Rientjes    2009-01-06  544  
2da02997e08d3e David Rientjes    2009-01-06 @545  int dirty_bytes_handler(struct ctl_table *table, int write,
32927393dc1ccd Christoph Hellwig 2020-04-24  546  		void *buffer, size_t *lenp, loff_t *ppos)
2da02997e08d3e David Rientjes    2009-01-06  547  {
fc3501d411d348 Sven Wegener      2009-02-11  548  	unsigned long old_bytes = vm_dirty_bytes;
2da02997e08d3e David Rientjes    2009-01-06  549  	int ret;
2da02997e08d3e David Rientjes    2009-01-06  550  
8d65af789f3e2c Alexey Dobriyan   2009-09-23  551  	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
2da02997e08d3e David Rientjes    2009-01-06  552  	if (ret == 0 && write && vm_dirty_bytes != old_bytes) {
eb608e3a344b3a Jan Kara          2012-05-24  553  		writeback_set_ratelimit();
2da02997e08d3e David Rientjes    2009-01-06  554  		vm_dirty_ratio = 0;
04fbfdc14e5f48 Peter Zijlstra    2007-10-16  555  	}
04fbfdc14e5f48 Peter Zijlstra    2007-10-16  556  	return ret;
04fbfdc14e5f48 Peter Zijlstra    2007-10-16  557  }
04fbfdc14e5f48 Peter Zijlstra    2007-10-16  558  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
