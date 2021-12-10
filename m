Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DAE4709BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbhLJTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:08:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:14661 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343531AbhLJTIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639163118; x=1670699118;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=baJK7YY4ozI4hWSjcpwk5ZyhlDtINvD+RSPE2T6TfkQ=;
  b=QAxckX9APg8gDsbVTLJ5AX/lmhJtCXkKbjWDi9XEnIqYUULD54w1uc/P
   ZKrPxvr9GHH1pqsrSfwMqrlr/8AgZgQomkKzNUoqLdKbeuc85s1frAEW7
   mkHeNdrqiY08emEb5XFHtPJoxGuu89ImrJAKCs4wtjlJMzmTiqvBJh8E5
   UpjVF4cnL+JZGx5JkXarEHrFqQJUJIoULEVvprk9MMR1F2LShuvH4FnHT
   Ujjh/dTxRr+QcU15l4s/Tb8+5XxFNnqKMGZGJbqLAwawWVnFCO7gixPqx
   /iciZLFT7mMwaPtbQ2HJRzy9JZVfDJLzSDfJfLNZTKIUsxN8FyV/RikJ+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238643442"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="238643442"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 11:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="680849716"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2021 11:05:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvlCl-0003aE-Gg; Fri, 10 Dec 2021 19:05:15 +0000
Date:   Sat, 11 Dec 2021 03:04:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: fs/ext4/ioctl.c:45:5: sparse: sparse: symbol
 'ext4_modify_primary_sb' was not declared. Should it be static?
Message-ID: <202112110238.laDrEJqZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211210-231726/Lukas-Czerner/ext4-implement-support-for-get-set-fs-label/20211112-060030
head:   3645884240a4d5f00133b71e3a7fbb2070588706
commit: 3645884240a4d5f00133b71e3a7fbb2070588706 ext4: implement support for get/set fs label
date:   4 hours ago
config: i386-randconfig-s001-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110238.laDrEJqZ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/3645884240a4d5f00133b71e3a7fbb2070588706
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211210-231726/Lukas-Czerner/ext4-implement-support-for-get-set-fs-label/20211112-060030
        git checkout 3645884240a4d5f00133b71e3a7fbb2070588706
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ext4/ioctl.c:45:5: sparse: sparse: symbol 'ext4_modify_primary_sb' was not declared. Should it be static?
>> fs/ext4/ioctl.c:165:5: sparse: sparse: symbol 'ext4_modify_superblocks_fn' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
