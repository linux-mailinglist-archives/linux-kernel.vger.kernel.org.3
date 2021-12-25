Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEC947F487
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 22:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhLYVpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 16:45:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:23610 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhLYVpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 16:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640468723; x=1672004723;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VCxZJtOgYtLREyUv4kAp4wSXCA/NLtb7DCnNvRQqhjc=;
  b=QhXeEI5dvWUvlA9isn+Zq14HTV9B3cTyiKYrTdBGsDvbC91NdMU2H+k2
   GIrSKdaJYDCUE1nYJJaQOlXPUCFskIrX4/XlOChbSI/Qyrsm1cYkT7La5
   HQ8LXebsPMTyQnqCc9HBZyOwaLDwW3zNP3EIlcceD+7k1z7KHlAKF/x9F
   +hW0JVXw0KPBPZcPaVSZVJx3f+ll6IAG1b7vtNhph44YnP5FebMyElvC4
   blXCXOuaIKPbzNC2afBkD/rwrqKXBDoy23fO1UegY8uEHtJwuD2BSQuxZ
   ycSykKvo6/CQPZfaQAe52ihF0e44T3EsqNGeDNoj4z9nbgD+4DAfYETF+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="304435176"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="304435176"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 13:45:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="618020176"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Dec 2021 13:45:21 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1Equ-0004hw-NV; Sat, 25 Dec 2021 21:45:20 +0000
Date:   Sun, 26 Dec 2021 05:45:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:90:25:
 warning: 'strncpy' specified bound depends on the length of the source
 argument
Message-ID: <202112260546.UoXtfDb5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huazhong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b927dfc67d05a72167ab980c375ed98b2ee9c2c6
commit: 1556ea9120ffcf4faf7ac6b62a6e28216f260a23 net: hns3: refactor dump mac list of debugfs
date:   8 months ago
config: parisc-randconfig-r021-20211226 (https://download.01.org/0day-ci/archive/20211226/202112260546.UoXtfDb5-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1556ea9120ffcf4faf7ac6b62a6e28216f260a23
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1556ea9120ffcf4faf7ac6b62a6e28216f260a23
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns3/hns3pf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c: In function 'hclge_dbg_fill_content.constprop':
>> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:90:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      90 |                         strncpy(pos, items[i].name, strlen(items[i].name));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:88:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      88 |                         strncpy(pos, result[i], strlen(result[i]));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +90 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c

    77	
    78	static void hclge_dbg_fill_content(char *content, u16 len,
    79					   const struct hclge_dbg_item *items,
    80					   const char **result, u16 size)
    81	{
    82		char *pos = content;
    83		u16 i;
    84	
    85		memset(content, ' ', len);
    86		for (i = 0; i < size; i++) {
    87			if (result)
    88				strncpy(pos, result[i], strlen(result[i]));
    89			else
  > 90				strncpy(pos, items[i].name, strlen(items[i].name));
    91			pos += strlen(items[i].name) + items[i].interval;
    92		}
    93		*pos++ = '\n';
    94		*pos++ = '\0';
    95	}
    96	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
