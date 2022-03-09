Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D534D25ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiCIBO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiCIBNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9B18020C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646787784; x=1678323784;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=scepsH2Uv6wYPB3QkRsBNH+h+6F589st9pGGxe9r+3I=;
  b=TCXwdhKa1bdyQnwUq4CvK5rKJIpeGlxDRSCD+1bMKsVFAqGqDNL7ZhL+
   ktzZkQWmKjV6rLO6UWpfHW11lyjKlnGSEqqueMIfm2nP5uFFKXZj4Chn/
   Sh8WBdHn+QveD0zhKuCORWSp0cbhEDhAgsab79sEvaSZ/txB5WMTOwvsm
   uCCMuPb9g3cdIf3LyQa/2mSSUdLMp1XCKaExGzLGbS6QbOJptwZx6hJhr
   EKUK7E84h73D0K++71k66p1fHD9Bu/SXVCFto56915ro+Rn9UcOAN8NL1
   mZpLrVBz2qgrF3NA6i4pIsT4PfnHfc0YjthDpm39GC+KvWLs95P/P26BL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="318083476"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="318083476"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 17:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="510312196"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2022 17:02:45 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRkiy-0002Hl-N9; Wed, 09 Mar 2022 01:02:44 +0000
Date:   Wed, 9 Mar 2022 09:02:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:127:25: warning:
 'strncpy' specified bound depends on the length of the source argument
Message-ID: <202203090830.THfDfibc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huazhong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92f90cc9fe0e7a984ea3d4bf3d120e30ba8a2118
commit: 77e9184869c9fb00a482357ea8eef3bd7ae3d45a net: hns3: refactor dump bd info of debugfs
date:   10 months ago
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203090830.THfDfibc-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77e9184869c9fb00a482357ea8eef3bd7ae3d45a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 77e9184869c9fb00a482357ea8eef3bd7ae3d45a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c: In function 'hns3_dbg_fill_content.constprop':
>> drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:127:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
     127 |                         strncpy(pos, items[i].name, strlen(items[i].name));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:125:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
     125 |                         strncpy(pos, result[i], strlen(result[i]));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hns3_dbg_fill_content',
       inlined from 'hns3_dbg_tx_bd_info' at drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:432:2:
>> drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:127:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
     127 |                         strncpy(pos, items[i].name, strlen(items[i].name));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'hns3_dbg_fill_content',
       inlined from 'hns3_dbg_rx_bd_info' at drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:358:2:
>> drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:127:25: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
     127 |                         strncpy(pos, items[i].name, strlen(items[i].name));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +127 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c

   114	
   115	static void hns3_dbg_fill_content(char *content, u16 len,
   116					  const struct hns3_dbg_item *items,
   117					  const char **result, u16 size)
   118	{
   119		char *pos = content;
   120		u16 i;
   121	
   122		memset(content, ' ', len);
   123		for (i = 0; i < size; i++) {
   124			if (result)
   125				strncpy(pos, result[i], strlen(result[i]));
   126			else
 > 127				strncpy(pos, items[i].name, strlen(items[i].name));
   128	
   129			pos += strlen(items[i].name) + items[i].interval;
   130		}
   131	
   132		*pos++ = '\n';
   133		*pos++ = '\0';
   134	}
   135	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
