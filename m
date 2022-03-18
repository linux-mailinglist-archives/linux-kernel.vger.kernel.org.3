Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D484DDA0D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiCRNCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiCRNCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:02:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF72D25A9;
        Fri, 18 Mar 2022 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647608443; x=1679144443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tlb0Oa3iKmUPJmNv1OT28opAXtAx9ub/Hx+6e+uVH60=;
  b=YG3ChxOQ+b3NBZsgVAX6VhZZzKXcP7XcPzfkWuM5A3gdjS6n3frimp9g
   ZV1kOx4jV3X9nhkZvkB2tI7BuVFiL71re4XDPe6G7h4wFcmHAMKRZPaah
   L1RZhC1cTTcIEslW1Q1VOUs/24njS2CI8i/nwMka3UNvw99892lV4jzoj
   a+wMJf7Xcjn3Ld7MP6DfbZbLycsC6qby6+oWtLleOR5XLKuLbWb32ggQC
   mR2VpxB/qVSNgdQyfZkJBCe16/izo0eDqtksmT0lPRetGJbnOeV0jryoR
   /G4+8mvYJx5aiYF3e7p41IOU6AMD8Ur3xYxUQJix9/6oPGrRDfcI0yiDK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257078822"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257078822"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="647452945"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2022 06:00:40 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVCDf-000Elh-Ht; Fri, 18 Mar 2022 13:00:39 +0000
Date:   Fri, 18 Mar 2022 21:00:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [mchehab-media-next:master 262/331]
 drivers/media/platform/renesas/rcar_drif.c:1470:34: warning: unused variable
 'rcar_drif_of_table'
Message-ID: <202203182022.SpPMtxPN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   git://linuxtv.org/mchehab/media-next.git master
head:   47aa866f248c89b319b99ac7b21a0a961ed2264a
commit: ee4a77a32b39064fdab0aa2b36bbd35ebf57e077 [262/331] media: platform: place Renesas drivers on a separate dir
config: hexagon-randconfig-r015-20220317 (https://download.01.org/0day-ci/archive/20220318/202203182022.SpPMtxPN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add mchehab-media-next git://linuxtv.org/mchehab/media-next.git
        git fetch --no-tags mchehab-media-next master
        git checkout ee4a77a32b39064fdab0aa2b36bbd35ebf57e077
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/renesas/rcar_drif.c:1470:34: warning: unused variable 'rcar_drif_of_table' [-Wunused-const-variable]
   static const struct of_device_id rcar_drif_of_table[] = {
                                    ^
   1 warning generated.


vim +/rcar_drif_of_table +1470 drivers/media/platform/renesas/rcar_drif.c

7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1466  
7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1467  static SIMPLE_DEV_PM_OPS(rcar_drif_pm_ops, rcar_drif_suspend,
7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1468  			 rcar_drif_resume);
7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1469  
7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12 @1470  static const struct of_device_id rcar_drif_of_table[] = {
7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1471  	{ .compatible = "renesas,rcar-gen3-drif" },
7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1472  	{ }
7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1473  };
7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1474  MODULE_DEVICE_TABLE(of, rcar_drif_of_table);
7625ee981af166 drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1475  

:::::: The code at line 1470 was first introduced by commit
:::::: 7625ee981af166ddb569e2e6c0006e2af471326f [media] media: platform: rcar_drif: Add DRIF support

:::::: TO: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
