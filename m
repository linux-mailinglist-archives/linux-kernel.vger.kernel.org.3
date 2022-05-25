Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5AC5335F5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 06:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbiEYEPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 00:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiEYEPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 00:15:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB00527EE;
        Tue, 24 May 2022 21:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653452143; x=1684988143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zoLHpPJlHQj1sMadNZjpddoZi4TuvVOAVFg4iO1UKTM=;
  b=PDdowoHav1Qjqu5ARR3VtCAEI2eXSvI75rEjJTcIF18txAgGoQFiUwpQ
   AlVlPYEXQsGMwCYLSEBAPyw81uf5IQNtYO0e1P4YCcScj1iEKqPobQHjy
   3LzMqgkMTytHlolyprUymfBtIpbEefSFPvcTqsFUJ8RmDM25svMXL6iPE
   ipL5CHNzhWPzZ/qkMz/TyYHXuWuXk9rhq5Ue8bfxNaaM3WGfQcypBarx0
   Ottzq9ZLRr0EQdIkZms7YbTD9h1OXUjl68BHypul5lDMi2UX+tDHlnEqk
   UPCEzotp7V4N3WLyaFDP+VrgC4j3pFH+Lj+n9rZrwYKUmV4lhUce98Dl7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="334356165"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="334356165"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 21:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="608954990"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 May 2022 21:15:40 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntiQu-0002iE-9H;
        Wed, 25 May 2022 04:15:40 +0000
Date:   Wed, 25 May 2022 12:15:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/media/platform/renesas/rcar_drif.c:1470:34: warning: unused
 variable 'rcar_drif_of_table'
Message-ID: <202205251220.mSx58WJG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fdaf9a5840acaab18694a19e0eb0aa51162eeeed
commit: ee4a77a32b39064fdab0aa2b36bbd35ebf57e077 media: platform: place Renesas drivers on a separate dir
date:   2 months ago
config: hexagon-buildonly-randconfig-r001-20220525 (https://download.01.org/0day-ci/archive/20220525/202205251220.mSx58WJG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee4a77a32b39064fdab0aa2b36bbd35ebf57e077
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ee4a77a32b39064fdab0aa2b36bbd35ebf57e077
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clk/imx/ drivers/media/platform/renesas/

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
