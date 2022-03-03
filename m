Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338DA4CBD4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiCCMDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiCCMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:03:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A402C3C729
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646308973; x=1677844973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=crhtJB5Gcuv0DdnrzUUYVTL/34Xzr9SMWGXEKewhegg=;
  b=HaArOEzGMsdfpo3eHMGYOxgW84MQktxarEgZQmWpQzcRb9RjceWgesjO
   sfRrc5rg5lvPYmbggd9wF3YLBey7MocU0h3kCJXkLuKW/hbY5BsjikPtS
   KXRTl8fra/4fzpUMWMuWLiAkPwKN3xD3hU8zQ/bMFET49CHhzfBQ1CWFf
   y/ANaeuea4JtniUAXSOCYwwqKfMp4GoCZ0gMgleQl6cl5v9lz1gcouM1i
   mqLIRk4IRnpoz3Qw4Nkv53d2/R3L+mZUmhFSQ7aOCF1vMXAvAwg4ndKbp
   Xi8FlQjc1+sHLS+VS3l2RbpYVw4PKmdoR8ausYW6Q3uAD/cncG6rS3wgm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253389488"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253389488"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 04:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="709901429"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Mar 2022 04:02:52 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPkAV-0000Sr-Fd; Thu, 03 Mar 2022 12:02:51 +0000
Date:   Thu, 3 Mar 2022 20:02:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jie Wang <wangjie125@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:4765:55:
 sparse: sparse: incorrect type in argument 3 (different base types)
Message-ID: <202203032008.59zQWB3h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5859a2b1991101d6b978f3feb5325dad39421f29
commit: 1813ee52433103d389da7c9c7ee5f81d113d9566 net: hns3: refactor PF rss set APIs with new common rss set APIs
date:   8 weeks ago
config: ia64-randconfig-s031-20220303 (https://download.01.org/0day-ci/archive/20220303/202203032008.59zQWB3h-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1813ee52433103d389da7c9c7ee5f81d113d9566
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1813ee52433103d389da7c9c7ee5f81d113d9566
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns3/ drivers/net/wwan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:4765:55: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __le16 [usertype] rss_ind_tbl_size @@     got unsigned short [usertype] rss_ind_tbl_size @@
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:4765:55: sparse:     expected restricted __le16 [usertype] rss_ind_tbl_size
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:4765:55: sparse:     got unsigned short [usertype] rss_ind_tbl_size
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:5347:31: sparse: sparse: context imbalance in 'hclge_sync_fd_user_def_cfg' - unexpected unlock

vim +4765 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c

  4754	
  4755	static int hclge_get_rss(struct hnae3_handle *handle, u32 *indir,
  4756				 u8 *key, u8 *hfunc)
  4757	{
  4758		struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
  4759		struct hclge_vport *vport = hclge_get_vport(handle);
  4760		struct hclge_comm_rss_cfg *rss_cfg = &vport->back->rss_cfg;
  4761	
  4762		hclge_comm_get_rss_hash_info(rss_cfg, key, hfunc);
  4763	
  4764		hclge_comm_get_rss_indir_tbl(rss_cfg, indir,
> 4765					     ae_dev->dev_specs.rss_ind_tbl_size);
  4766	
  4767		return 0;
  4768	}
  4769	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
