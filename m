Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498D64B833B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiBPIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:47:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiBPIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:47:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C42701B0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645001252; x=1676537252;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fpeEP05FMDbRzh01LBBr/Jl1CI6ElWiSZ65HQxu/idc=;
  b=bncyC5qKI9gpcu2BlQVOUskLMhbidgpgq/4/m88PGYW08EMRwYbcEcvS
   JRgV4OeDd+c7gauw+SEiaOZH/cKxXJOl43ZlVr2PD/qnlM92AL3uCud1A
   k2Wc84UP/3mVuGXaT5EkF7kyt0huobveGVTwdmyeRxMpIxa4B3c7qvb9s
   VUIe+724Umg0JLyagfSS6yDfWkQZQyPjxxQgp8Z7ImPHe40KIJOA47rNs
   5IKdPNBMes7Of9h6yfU79ZpXKoQPXqJu926Q0oJ3O47kXqPxbtvYxTv0M
   YFsySWrl7InX4SCESAo4D6uAIrbwKnljo8q0QXzC9qaPlZ63KY8PmIcNV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250498469"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="250498469"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:47:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="604249867"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Feb 2022 00:47:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKFyE-000Acr-Ew; Wed, 16 Feb 2022 08:47:30 +0000
Date:   Wed, 16 Feb 2022 16:47:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:127:25: warning:
 'strncpy' specified bound depends on the length of the source argument
Message-ID: <202202161610.iSAoPT4T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   c5d9ae265b105d9a67575fb67bd4650a6fc08e25
commit: 77e9184869c9fb00a482357ea8eef3bd7ae3d45a net: hns3: refactor dump bd info of debugfs
date:   9 months ago
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220216/202202161610.iSAoPT4T-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77e9184869c9fb00a482357ea8eef3bd7ae3d45a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 77e9184869c9fb00a482357ea8eef3bd7ae3d45a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/fpga/ drivers/net/ethernet/hisilicon/hns3/

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
