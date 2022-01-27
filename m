Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F349DBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiA0Hwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:52:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:41124 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237540AbiA0Hwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643269970; x=1674805970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rOSNyt8LwuutsvbkFAa3ddom53RdqKFV+3NFqkbPovw=;
  b=OEaKfhQ5wV4ABBmE5ksY4wjuyk+2loAppeJnev0izd9NpepH2LFlvmW4
   49y0n00XE/6b4a6IIpnuqxMoPIH9Kg/NaQi1XS5p03k/GDxQBXb4drO96
   Aklx6D8twmqi0LeEiXninbJcPB8kcHgg+f3hysNKmVTuLMwhI7bVVqkY0
   /JswudVNhNJC6+b9wu7ccPg/U1WJ156QyVF6nqjdZpJ03gf4P2+WWadTL
   leBFNRn6xnrEzoVJylFaH+A4MdsiwgIHr8/braJLm6HrXIZFKtE9HSosG
   EUWFv4HgGqm+u7zfbBU3jqaKm3L6VcYPayDhKMioakf0TwDVNUsZlRo0X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244378098"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="244378098"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:52:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="521117404"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Jan 2022 23:52:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCzaJ-000MK8-6l; Thu, 27 Jan 2022 07:52:47 +0000
Date:   Thu, 27 Jan 2022 15:51:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 50/60] region.c:undefined reference to `__umoddi3'
Message-ID: <202201271546.AxCMqNSX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   41c2d219a2c8e14de644f4e953e0c57402c3e884
commit: 84dbaed92240cd65eb70045a3c61b6b4050822c2 [50/60] cxl/region: Introduce a cxl_region driver
config: powerpc-randconfig-c004-20220124 (https://download.01.org/0day-ci/archive/20220127/202201271546.AxCMqNSX-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=84dbaed92240cd65eb70045a3c61b6b4050822c2
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 84dbaed92240cd65eb70045a3c61b6b4050822c2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/cxl/region.o: in function `cxl_region_probe':
>> region.c:(.text+0x168): undefined reference to `__umoddi3'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
