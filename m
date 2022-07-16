Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09990577216
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiGPXBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPXBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:01:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AAF1AF2E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658012459; x=1689548459;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rXKqPUBPLqmkrmr2Fuw1SFMFQm1tbZXGwvaTDwF8Bzs=;
  b=NW+rSRJR/9Cw0pwdCB2T60GDXRg1LWvVu39J2oZkbhBzfMLuDEq5gK4b
   f3ah1vCHlgmi7Kt+t0bgX43kwePJAx6DGykGDEJHO5Qnp1glWbW2jJLeX
   3hKPBtFX9t2SN/oMetvkUDVdVAndRuMsNjOX4txuJ/MVaCYzkadbmhljB
   hxtcZ48A47tjX4gsgkaXPk+029vwvK9NVTxhrPWC00SSozOnS2q/nsK8g
   1AbGaokb0BG1IRXQd+nUu4sePuVP1w/YEoMX7XYuNSksXbYAccShkecgr
   32yWvPetJkQT0jRzgX2feTbudYj138VXbIiAENkdsjNQzE368EkkTAN87
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="266419101"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="266419101"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 16:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="842890786"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2022 16:00:58 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCqmP-0002HK-Mk;
        Sat, 16 Jul 2022 23:00:57 +0000
Date:   Sun, 17 Jul 2022 07:00:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jian Shen <shenjian15@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:90:25:
 warning: 'strncpy' output truncated before terminating nul copying as many
 bytes from a string as its length
Message-ID: <202207170606.7WtHs9yS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5fe7a97f20c7f3070ac870144515c0fabc6b999
commit: 0ca821da86a5ec24eb2ece24fe87e5bf518c5939 net: hns3: add debugfs support for vlan configuration
date:   1 year, 2 months ago
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20220717/202207170606.7WtHs9yS-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ca821da86a5ec24eb2ece24fe87e5bf518c5939
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0ca821da86a5ec24eb2ece24fe87e5bf518c5939
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns3/hns3pf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_vlan_filter_config.constprop' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:2080:2:
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:92:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      92 |                         strncpy(pos, items[i].name, strlen(items[i].name));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_vlan_filter_config.constprop' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:2102:3:
>> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:90:25: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
      90 |                         strncpy(pos, result[i], strlen(result[i]));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_mac_list' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:1872:2:
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:92:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      92 |                         strncpy(pos, items[i].name, strlen(items[i].name));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_mac_list' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:1887:4:
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:90:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      90 |                         strncpy(pos, result[i], strlen(result[i]));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_tm_pg' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:735:2:
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:92:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      92 |                         strncpy(pos, items[i].name, strlen(items[i].name));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_tm_pg' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:775:3:
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:90:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      90 |                         strncpy(pos, result[i], strlen(result[i]));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_tm_qset' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:1027:2:
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:92:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      92 |                         strncpy(pos, items[i].name, strlen(items[i].name));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_tm_qset' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:1059:3:
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:90:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      90 |                         strncpy(pos, result[i], strlen(result[i]));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_vlan_offload_config' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:2123:2:
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:92:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      92 |                         strncpy(pos, items[i].name, strlen(items[i].name));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hclge_dbg_fill_content',
       inlined from 'hclge_dbg_dump_vlan_offload_config' at drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:2154:3:
>> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:90:25: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
      90 |                         strncpy(pos, result[i], strlen(result[i]));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LOCKDEP
   Depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
   Selected by
   - PROVE_LOCKING && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
   - LOCK_STAT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
   - DEBUG_LOCK_ALLOC && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT


vim +/strncpy +90 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c

a582b78dfc33d2 Zhongzhu Liu 2019-08-28  79  
1556ea9120ffcf Huazhong Tan 2021-05-14  80  static void hclge_dbg_fill_content(char *content, u16 len,
1556ea9120ffcf Huazhong Tan 2021-05-14  81  				   const struct hclge_dbg_item *items,
1556ea9120ffcf Huazhong Tan 2021-05-14  82  				   const char **result, u16 size)
1556ea9120ffcf Huazhong Tan 2021-05-14  83  {
1556ea9120ffcf Huazhong Tan 2021-05-14  84  	char *pos = content;
1556ea9120ffcf Huazhong Tan 2021-05-14  85  	u16 i;
1556ea9120ffcf Huazhong Tan 2021-05-14  86  
1556ea9120ffcf Huazhong Tan 2021-05-14  87  	memset(content, ' ', len);
1556ea9120ffcf Huazhong Tan 2021-05-14  88  	for (i = 0; i < size; i++) {
1556ea9120ffcf Huazhong Tan 2021-05-14  89  		if (result)
1556ea9120ffcf Huazhong Tan 2021-05-14 @90  			strncpy(pos, result[i], strlen(result[i]));
1556ea9120ffcf Huazhong Tan 2021-05-14  91  		else
1556ea9120ffcf Huazhong Tan 2021-05-14  92  			strncpy(pos, items[i].name, strlen(items[i].name));
1556ea9120ffcf Huazhong Tan 2021-05-14  93  		pos += strlen(items[i].name) + items[i].interval;
1556ea9120ffcf Huazhong Tan 2021-05-14  94  	}
1556ea9120ffcf Huazhong Tan 2021-05-14  95  	*pos++ = '\n';
1556ea9120ffcf Huazhong Tan 2021-05-14  96  	*pos++ = '\0';
1556ea9120ffcf Huazhong Tan 2021-05-14  97  }
1556ea9120ffcf Huazhong Tan 2021-05-14  98  

:::::: The code at line 90 was first introduced by commit
:::::: 1556ea9120ffcf4faf7ac6b62a6e28216f260a23 net: hns3: refactor dump mac list of debugfs

:::::: TO: Huazhong Tan <tanhuazhong@huawei.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
