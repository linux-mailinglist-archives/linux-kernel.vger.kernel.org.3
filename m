Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4A5684F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiGFKNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiGFKM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:12:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650B7B1C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657102376; x=1688638376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QMMhdvCG9FjyCtyumzPckJrvlAeX2XLKCU12ZXfpmqs=;
  b=gmib3cQfDs51oi2vXo0B2aUb8hUWzfXy872tBijcGxjOnAq9YmhtobC6
   xTCra8PL7Imc0usElrqArFLTbNKfSUjNjek4vsoZiQnnPXqb/pnDCNBKJ
   gHNmV+zFhpbU2YBJh9C3pZ8FovfqSAE6SChU+9TFQXpe0696A7g3TA/oq
   bs6Y8+kTXFtvNxzFFtQxbFn4Z/kBvCO9ubqaeLJzK+K936HFowXmznP/4
   JtnDmxppXTXXVLwgoXtNTD+MiUBmGm9jKL1ikmezt1KSsHf8qvEziSb7H
   e+YtLJ8t+ta8HTyiBhpNhtUZmFBaPcqpIDH5zK2zsRu3SI4uPZQ+skwGa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263489021"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="263489021"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="660911159"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2022 03:12:54 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o921e-000KQ9-9r;
        Wed, 06 Jul 2022 10:12:54 +0000
Date:   Wed, 6 Jul 2022 18:12:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:127:25: warning:
 'strncpy' specified bound depends on the length of the source argument
Message-ID: <202207061829.J89nFLKY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huazhong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e35e5b6f695d241ffb1d223207da58a1fbcdff4b
commit: 77e9184869c9fb00a482357ea8eef3bd7ae3d45a net: hns3: refactor dump bd info of debugfs
date:   1 year, 2 months ago
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207061829.J89nFLKY-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77e9184869c9fb00a482357ea8eef3bd7ae3d45a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 77e9184869c9fb00a482357ea8eef3bd7ae3d45a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpio/ drivers/net/ethernet/hisilicon/hns3/ drivers/net/netdevsim/ drivers/tty/serial/ sound/soc/intel/

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
