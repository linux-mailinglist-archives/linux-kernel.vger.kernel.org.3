Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2050CCED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiDWSqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbiDWSq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:46:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516AC18CD9B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650739408; x=1682275408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3iQkj1hxXJ+ZxZkITfGfw2l9erRFzX3a3/vcBaZ8WEo=;
  b=n8vytTaUlnqSLeLiAax0TReY0BlmVs2sBeSIW6yKDtDdIuAksNM9sWPW
   lnNDAFBwiyMjiXjT66Sl5/WUgeZXY0MjLckzuI7L9w3T1Mx7SZSw80gvh
   iCanocIng61+uVWQwzzdggOWFajad3YAc0ABPn8arUuSDXC5zpsSPLgZD
   zB3u1C5tQLBg7ppsfWGzSboVhUZ354IapZWCvmHtDk7CdUl3lACDGKRM/
   h3KIxA8gUMxlrXTAEWWDijq85MKWTRKIMVbvZW1Z7hUUZ4zjzm8UfL4vP
   CqUEInWVnqiGt/c0vDSXSoqUWG/r86EGPRWtlCGkuPBiyVSLqBdLBLoWY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="351386630"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="351386630"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 11:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="512021750"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Apr 2022 11:43:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niKj7-0000Lh-NF;
        Sat, 23 Apr 2022 18:43:25 +0000
Date:   Sun, 24 Apr 2022 02:42:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:127:25: warning:
 'strncpy' specified bound depends on the length of the source argument
Message-ID: <202204240209.hnHqcOEn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huazhong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   45ab9400e73f34103e73c18a73280c9aa1650e98
commit: 77e9184869c9fb00a482357ea8eef3bd7ae3d45a net: hns3: refactor dump bd info of debugfs
date:   11 months ago
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220424/202204240209.hnHqcOEn-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77e9184869c9fb00a482357ea8eef3bd7ae3d45a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 77e9184869c9fb00a482357ea8eef3bd7ae3d45a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns3/ drivers/net/mdio/of_mdio.ko

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
