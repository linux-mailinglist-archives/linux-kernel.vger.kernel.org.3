Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D4949F646
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbiA1J1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:27:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:20585 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237840AbiA1J1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643362030; x=1674898030;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZcobntPAeKqqhAbPbwLLTMHri359Hp9UlkTZaVU0VXI=;
  b=TtM6pLl1BxYfvYiL5UmcAq7zxC2IFUl049ZZyC+0GTOd1CERlpyYMXPr
   7fUBmyN+ZCaePoQNVceB3n3FhjIEnXTDgNpVmmcMR7/Av0qQqkrryyz3d
   e12fG2CLFW39S8d2/1q0bYY0p6EHr+yMbOin5wCcefQ/0JLszEnDHrFkC
   oqru7j7FR/1epCgjdgCLlTqp0DWIelTYWVAkuZR6z0vUCTZWKKi/l25ID
   c2f1VuH2NzKNdZreDY3aYW58KlWxGk7Tsw7dqNQwKmIhRs+iwsFBN4rJH
   G0wddr5sipi/VnqYdFfWxxwJyXG0jnsiqYnw9mqcfUtjuftTtuEzJvEz9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="245927140"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="245927140"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="496080559"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2022 01:27:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDNX9-000Nhc-1n; Fri, 28 Jan 2022 09:27:07 +0000
Date:   Fri, 28 Jan 2022 17:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 8/18] ERROR: modpost: "__umoddi3"
 [drivers/cxl/cxl_region.ko] undefined!
Message-ID: <202201281738.B25FjsyO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   639e187dc9ae68fe9f0abe899e0e9ad2a3eab638
commit: 1af38ef70b9a726e8fb1cdd9967842ff809a2377 [8/18] cxl/region: Introduce a cxl_region driver
config: i386-randconfig-a004-20220124 (https://download.01.org/0day-ci/archive/20220128/202201281738.B25FjsyO-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=1af38ef70b9a726e8fb1cdd9967842ff809a2377
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 1af38ef70b9a726e8fb1cdd9967842ff809a2377
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/cxl/cxl_region.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
