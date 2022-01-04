Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17795484B22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 00:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiADXWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 18:22:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:61437 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234277AbiADXWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641338540; x=1672874540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SGQtGG2CLoHFdMZhX3UAsNYja1VzFXWjyMBEuuiW5ws=;
  b=mn1I+qR0LwC2Bc6hebOJ+4DbfmdciFy6m8dbBd6hQAKVTdskmgHwjnsq
   6fxgU7whSp5RCRw2FRPT/+XJXSX2AND6EDl7IeGlZchlukucdxIe1JlUN
   cc6PizsHyHwxEwWeSx0/BdMPrBdyjKvY4+xOXFvbuQ/xxVnZOYtlQ9VO9
   i+7mWm6GpMfIdcVVlmrDAnFQWngXZXCXRhK0I7LgN+NnecJ1o5H4qrfpW
   /GzaZ2e9acJVskfcoAoEuItq3oIHIF2eUtJKxNFVSvpcTv9IreB+FHxA0
   VtnL2abH5mpbP6PyOfYzwcfCk+npmmCDReEO93AzTrFI1nOdETzvSlW0J
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="328665377"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="328665377"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 15:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="574173049"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2022 15:22:17 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4t8C-000G0K-KL; Tue, 04 Jan 2022 23:22:16 +0000
Date:   Wed, 5 Jan 2022 07:22:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     kbuild-all@lists.01.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] mailbox: imx: Add support for identifying SCU wakeup
 source from sysfs
Message-ID: <202201050712.94b9xX70-lkp@intel.com>
References: <20220104062547.2103016-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104062547.2103016-4-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on robh/for-next linus/master v5.16-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Peng-Fan-OSS/mailbox-imx-misc-fix-and-SECO-MU-support/20220104-142853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220105/202201050712.94b9xX70-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/565bba9e401bda77a3c936df0262681cd2622d80
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/mailbox-imx-misc-fix-and-SECO-MU-support/20220104-142853
        git checkout 565bba9e401bda77a3c936df0262681cd2622d80
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "pm_system_irq_wakeup" [drivers/mailbox/imx-mailbox.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
