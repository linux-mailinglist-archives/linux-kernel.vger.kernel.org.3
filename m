Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8198E4BAA34
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbiBQTse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:48:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiBQTsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:48:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5B27CDA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127285; x=1676663285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nAAYaCD4IIcWYqLGBC8NhvGHt/9FQRRnQ/MY7O4cfQs=;
  b=LOgyGABtWe57utEn472qhmLAja1fxx1KFXPYeS981+wV8uoGyhBx/knQ
   SCUffZSXd2sMRsj+3EeyHfpiIO+LLOSzoWVURMPEdDM+i0iY5D1FJHESI
   4/dFPdUZbTHeB+QiY40tuWrZcOzJ0aHFv/vVbl7yAxnjSPrpClRxBfLJ/
   PAulmiRbTEznm2+9mrLg8D2Q5xK7ffrtOMCE+5q3hAkqJUv2DJx8mVdMG
   c06vRjK/+3hC6jSHsG7LtVD9lfz6d66b37onZVXJkwGsrwZl+BP0FNE5B
   HZGR24wu/I7fUm9M5UxeUoDOiqvSgBrFaZP24/4JwP+Q1dIRBR9T+G1AQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="275553308"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="275553308"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:48:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="503216462"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Feb 2022 11:48:02 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmkz-0000Xx-KZ; Thu, 17 Feb 2022 19:48:01 +0000
Date:   Fri, 18 Feb 2022 03:47:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [ulfh-mmc:next 20/24] drivers/memstick/core/ms_block.c:158:13:
 error: implicit declaration of function 'bitmap_weight_eq'; did you mean
 'bitmap_weight'?
Message-ID: <202202180309.LIPKYeon-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
head:   4b67100bafbb3f60e6eecf87631e4d400d9b6f17
commit: 5f8d171cd8a93ff425556e7fde5d59fefc677bf7 [20/24] memstick: replace bitmap_weight with bitmap_weight_eq where appropriate
config: alpha-randconfig-r004-20220217 (https://download.01.org/0day-ci/archive/20220218/202202180309.LIPKYeon-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?id=5f8d171cd8a93ff425556e7fde5d59fefc677bf7
        git remote add ulfh-mmc git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
        git fetch --no-tags ulfh-mmc next
        git checkout 5f8d171cd8a93ff425556e7fde5d59fefc677bf7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/memstick/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/memstick/core/ms_block.c: In function 'msb_validate_used_block_bitmap':
>> drivers/memstick/core/ms_block.c:158:13: error: implicit declaration of function 'bitmap_weight_eq'; did you mean 'bitmap_weight'? [-Werror=implicit-function-declaration]
     158 |         if (bitmap_weight_eq(msb->used_blocks_bitmap, msb->block_count,
         |             ^~~~~~~~~~~~~~~~
         |             bitmap_weight
   cc1: some warnings being treated as errors


vim +158 drivers/memstick/core/ms_block.c

   145	
   146	/* Debug test to validate free block counts */
   147	static int msb_validate_used_block_bitmap(struct msb_data *msb)
   148	{
   149		int total_free_blocks = 0;
   150		int i;
   151	
   152		if (!debug)
   153			return 0;
   154	
   155		for (i = 0; i < msb->zone_count; i++)
   156			total_free_blocks += msb->free_block_count[i];
   157	
 > 158		if (bitmap_weight_eq(msb->used_blocks_bitmap, msb->block_count,
   159					msb->block_count - total_free_blocks))
   160			return 0;
   161	
   162		pr_err("BUG: free block counts don't match the bitmap");
   163		msb->read_only = true;
   164		return -EINVAL;
   165	}
   166	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
