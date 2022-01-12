Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4318048C713
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354759AbiALPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:19:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:32184 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354529AbiALPS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642000737; x=1673536737;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EmMRGHo4Nr7gr2CBCoSSj4+UCrefbL0nyNIfOseDHmw=;
  b=QPUih7lM+fCs34KjdhSfjqE79xcXGpvbXEu+dFbX2VYMbY84gkRsPYwk
   GGohdmsEU3/ErJmN+ZsJXC7EKJ59Jn5BiAkdQMI/Whzjqy8gsy+8SkXz0
   yoazq4jmqDv7i6+W65YRm2MSckcNGQB3OzBm/2W8jbQ0qu3QV+X4xVtBN
   d5AaO7TT5Ry+GjhHuaggTksxRQbDxvQHAHuA+Fke/f0kX2LVzyWrnoPvz
   x58f1VlVgm7//5UfzNQcTN9zVDFtBGE3lijOglmgw1gz6PZonjFYELsv1
   0dbhGOYGtKlG6dORQtwvwLVvQGlvWY98S1RSKPksUtt0uXIi8/Ofvaghb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="242573130"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="242573130"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 07:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="490762367"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2022 07:18:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7fOo-000600-Mq; Wed, 12 Jan 2022 15:18:54 +0000
Date:   Wed, 12 Jan 2022 23:18:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/acpi/acpi_pcc.c:34:22: sparse: sparse: symbol 'pcc_ctx' was
 not declared. Should it be static?
Message-ID: <202201122308.6u2N4BuL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   daadb3bd0e8d3e317e36bc2c1542e86c528665e5
commit: 77e2a04745ff8e391ad402e2d2d1157a5d3a7ebc ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype
date:   8 days ago
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220112/202201122308.6u2N4BuL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77e2a04745ff8e391ad402e2d2d1157a5d3a7ebc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 77e2a04745ff8e391ad402e2d2d1157a5d3a7ebc
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/acpi_pcc.c:34:22: sparse: sparse: symbol 'pcc_ctx' was not declared. Should it be static?

vim +/pcc_ctx +34 drivers/acpi/acpi_pcc.c

    33	
  > 34	struct acpi_pcc_info pcc_ctx;
    35	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
