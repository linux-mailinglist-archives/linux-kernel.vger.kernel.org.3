Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454B3470666
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbhLJQzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:55:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:15527 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244062AbhLJQzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639155133; x=1670691133;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rtmio2JZdFBgMjVlC4ULf1CSskyTDC6ixBmFQ8JL9MA=;
  b=XkmAquB3ZQpvc8Eg/FNeUoidHY/jIqxWXuVgfTt016a8B4cX/K+Z5HAs
   TrNJB1fbTPksNLrXtZ7vfhntLoEXCHfQ5F2kevu65uKlv46rBL9RqbzJd
   +gqsuyzlAJBxxZKMo1CuerGBNclEYavKpUEGg2CK7mJoeeYhQlZfnGqNb
   CCMUWM3oBzHJ6xOErIFXrku0btmPGFNJxH+bPJMSDGc70woVmXMyVlfO3
   GH82OgNWqV896lQaKIbPzOV7A/dRo4GgzJjmWnL9YcQOe7Lh0x/qqZlu1
   3kZ+wu6t/ZcDsmBWAS0ubdq5O6QVB5UathaKnS4Dvs7TOkP90n58Sz4yv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="301764125"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="301764125"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="463724230"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2021 08:52:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvj7z-0003Ob-4o; Fri, 10 Dec 2021 16:52:11 +0000
Date:   Sat, 11 Dec 2021 00:51:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:auth-dh 24/24] drivers/nvme/host/auth.c:11:10:
 fatal error: crypto/ffdhe.h: No such file or directory
Message-ID: <202112110052.PK2rNLR2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth-dh
head:   d0619245e5615b7909488f564d7fd992016a2f5b
commit: d0619245e5615b7909488f564d7fd992016a2f5b [24/24] nvme: Implement In-Band authentication
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211211/202112110052.PK2rNLR2-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=d0619245e5615b7909488f564d7fd992016a2f5b
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth-dh
        git checkout d0619245e5615b7909488f564d7fd992016a2f5b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvme/host/auth.c:11:10: fatal error: crypto/ffdhe.h: No such file or directory
      11 | #include <crypto/ffdhe.h>
         |          ^~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 drivers/nvme/host/auth.c

  > 11	#include <crypto/ffdhe.h>
    12	#include "nvme.h"
    13	#include "fabrics.h"
    14	#include "auth.h"
    15	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
