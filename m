Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948BC4D6980
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbiCKUfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiCKUfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:35:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600781CAF35
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647030847; x=1678566847;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=//oXPNLIg9YdSBvOq2CJZ/COF+LDkTQG9ZKmTky9PRE=;
  b=Csi3KwozaRESbSJ4pcDwlfdG7oYoIo2k1QRw/U7sHBbjnRoxbqC9OigA
   hQb20djOSQpIpQOUUdTQTOVy39vFTZRg0nI79YdeyL8SKm486X4GXLjUu
   r0138T32sT7nCcPNvXzm27g7ZoBC2q6Ais6wVZMsMELf0v5Y7HASc4T2f
   22Y2ssO4RRLzvgtRZSwndomdU51H+Leb6m9Phz7JnIQGsCjkj6hArrgML
   GJFvF/eMhmb5cklV98rBF1DbkGObx3Vqvc4jm9Tw4YHSHbzCLSlZwgRQM
   SExNk1D4If9YKNsw4YdhGRXisgW5htEkhs1V6iIo59AMmLtRq7hGdmTa1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="280394697"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="280394697"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 12:34:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="579408524"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2022 12:34:05 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSlxc-000739-Vp; Fri, 11 Mar 2022 20:34:04 +0000
Date:   Sat, 12 Mar 2022 04:33:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jie Wang <wangjie125@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c:742:61:
 sparse: sparse: incorrect type in argument 3 (different base types)
Message-ID: <202203120417.yiJhIAiF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79b00034e9dcd2b065c1665c8b42f62b6b80a9be
commit: 7428d6c9366560143b9dbb6dbf2141fa811d4bc8 net: hns3: refactor VF rss set APIs with new common rss set APIs
date:   9 weeks ago
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220312/202203120417.yiJhIAiF-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7428d6c9366560143b9dbb6dbf2141fa811d4bc8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7428d6c9366560143b9dbb6dbf2141fa811d4bc8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns3/ drivers/vdpa/mlx5/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c:742:61: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __le16 [usertype] rss_ind_tbl_size @@     got unsigned short [usertype] rss_ind_tbl_size @@
   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c:742:61: sparse:     expected restricted __le16 [usertype] rss_ind_tbl_size
   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c:742:61: sparse:     got unsigned short [usertype] rss_ind_tbl_size

vim +742 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c

   719	
   720	static int hclgevf_get_rss(struct hnae3_handle *handle, u32 *indir, u8 *key,
   721				   u8 *hfunc)
   722	{
   723		struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
   724		struct hclge_comm_rss_cfg *rss_cfg = &hdev->rss_cfg;
   725		int ret;
   726	
   727		if (hdev->ae_dev->dev_version >= HNAE3_DEVICE_VERSION_V2) {
   728			hclge_comm_get_rss_hash_info(rss_cfg, key, hfunc);
   729		} else {
   730			if (hfunc)
   731				*hfunc = ETH_RSS_HASH_TOP;
   732			if (key) {
   733				ret = hclgevf_get_rss_hash_key(hdev);
   734				if (ret)
   735					return ret;
   736				memcpy(key, rss_cfg->rss_hash_key,
   737				       HCLGE_COMM_RSS_KEY_SIZE);
   738			}
   739		}
   740	
   741		hclge_comm_get_rss_indir_tbl(rss_cfg, indir,
 > 742					     hdev->ae_dev->dev_specs.rss_ind_tbl_size);
   743	
   744		return 0;
   745	}
   746	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
