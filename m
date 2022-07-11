Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AAB570C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiGKUvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKUvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:51:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6152E79
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657572703; x=1689108703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uI5LISMrCkRabNwX/UJvuG8REtp/4GAnK09PQc5eSyw=;
  b=a1p427uoTGSR5Q0xy+DQeqSKnRii4YPhsAHHhMqec3MuUQTgeftGVeJG
   DJ/br2Txz4IV62xndLTarM050NG/aqlbPIeo0mRgt9tn1HoVC7X+oVFNu
   2h6DwXzOZ8nRy1KeDwbx85T7mY2ElvXnL0QHMMva0kRG+j9kTp3neSNt3
   5rx95LaD7uXuRiG/Fg4eK9xy/14CO9Nv2MY0L8p9E8C7SG8xbSF695C24
   ZxjMSsx+gXAgVuh0dCIsJHrDUFEe5rZBn2IZapK86Nyo8348iyirxglyX
   mU9/uQmDUbPeGJMf7HFMx6eSyB1Ipwhqhdruyn/mnAO3kCmuR4Oao+RDV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283520895"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="283520895"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 13:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="662691558"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2022 13:51:41 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB0NZ-0001Dp-9L;
        Mon, 11 Jul 2022 20:51:41 +0000
Date:   Tue, 12 Jul 2022 04:50:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, Xiang Gao <xiang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [xiang:erofs/advancedpcl 16/16] fs/erofs/zdata.c:489:34: warning:
 unused variable 'map'
Message-ID: <202207120426.x79ElJvZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git erofs/advancedpcl
head:   00f10658c760bc3e64c14215e6a4a961bda932c7
commit: 00f10658c760bc3e64c14215e6a4a961bda932c7 [16/16] erofs: introduce multi-reference pclusters (fully-referenced)
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220712/202207120426.x79ElJvZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=00f10658c760bc3e64c14215e6a4a961bda932c7
        git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
        git fetch --no-tags xiang erofs/advancedpcl
        git checkout 00f10658c760bc3e64c14215e6a4a961bda932c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/erofs/zdata.c: In function 'z_erofs_lookup_pcluster':
>> fs/erofs/zdata.c:489:34: warning: unused variable 'map' [-Wunused-variable]
     489 |         struct erofs_map_blocks *map = &fe->map;
         |                                  ^~~


vim +/map +489 fs/erofs/zdata.c

3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang 2018-07-26  486  
816bd78aca8450 fs/erofs/zdata.c                  Gao Xiang 2022-06-28  487  static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe)
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang 2018-07-26  488  {
816bd78aca8450 fs/erofs/zdata.c                  Gao Xiang 2022-06-28 @489  	struct erofs_map_blocks *map = &fe->map;
5c6dcc57e2e505 fs/erofs/zdata.c                  Gao Xiang 2022-03-02  490  	struct z_erofs_pcluster *pcl = fe->pcl;
97e86a858bc360 drivers/staging/erofs/zdata.c     Gao Xiang 2019-07-31  491  
64094a04414f0b fs/erofs/zdata.c                  Gao Xiang 2020-02-20  492  	/* to avoid unexpected loop formed by corrupted images */
5c6dcc57e2e505 fs/erofs/zdata.c                  Gao Xiang 2022-03-02  493  	if (fe->owned_head == &pcl->next || pcl == fe->tailpcl) {
bfc4ccb1584129 drivers/staging/erofs/zdata.c     Gao Xiang 2019-08-21  494  		DBG_BUGON(1);
9e579fc123a0c9 fs/erofs/zdata.c                  Gao Xiang 2019-10-08  495  		return -EFSCORRUPTED;
bfc4ccb1584129 drivers/staging/erofs/zdata.c     Gao Xiang 2019-08-21  496  	}
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang 2018-07-26  497  
87ca34a7065db6 fs/erofs/zdata.c                  Gao Xiang 2022-05-29  498  	mutex_lock(&pcl->lock);
bfc4ccb1584129 drivers/staging/erofs/zdata.c     Gao Xiang 2019-08-21  499  	/* used to check tail merging loop due to corrupted images */
5c6dcc57e2e505 fs/erofs/zdata.c                  Gao Xiang 2022-03-02  500  	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
5c6dcc57e2e505 fs/erofs/zdata.c                  Gao Xiang 2022-03-02  501  		fe->tailpcl = pcl;
473e15b0c0f7cf fs/erofs/zdata.c                  Gao Xiang 2020-12-08  502  
5c6dcc57e2e505 fs/erofs/zdata.c                  Gao Xiang 2022-03-02  503  	z_erofs_try_to_claim_pcluster(fe);
9e579fc123a0c9 fs/erofs/zdata.c                  Gao Xiang 2019-10-08  504  	return 0;
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang 2018-07-26  505  }
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang 2018-07-26  506  

:::::: The code at line 489 was first introduced by commit
:::::: 816bd78aca845093ffe6d508aced3a89f3b5b168 erofs: get rid of unneeded `inode', `map' and `sb'

:::::: TO: Gao Xiang <hsiangkao@linux.alibaba.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
