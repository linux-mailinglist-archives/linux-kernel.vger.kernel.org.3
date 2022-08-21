Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5299059B238
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 08:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiHUGKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 02:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHUGKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:10:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C31EC4B
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661062236; x=1692598236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JqGXlJ/ZDtcWBOKcPNhOBICCfUAo4bNBzhMNo0aWdto=;
  b=JXC5Fqtyno0J8SJRP8wAjIVnxa26enI36ROsniOq3VUIFRZmiqat/kcM
   o/saavF5jX9HjbiGizpNYz6YbMAJBNgfgkGn2Oc6W3uq8S8dazFC8LbvJ
   Fw2H+8gueFmUBbj9FO+hdE/FOEWHy1OaQ9CAGTArRaytuV8HAoJ3nlmqT
   Q6pbJNF8eJ4ZagteRYRhq8N4oA7jqikm6+LlcQoQAD4On93FsRZWzjCN3
   da4NsBQC5Jws2ELndrMQjzj3S78HBP+N65w4oPXgZ4nqXTzE0GGYAUxQG
   PFrKCv5e8ADpHUIhDbUj0npk83q4n4FXgyi+f8odTQ4LI8luZML/MRCjK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="293225623"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="293225623"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 23:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="936654104"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2022 23:10:35 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPeAM-0003ji-2g;
        Sun, 21 Aug 2022 06:10:34 +0000
Date:   Sun, 21 Aug 2022 14:09:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 5/42]
 drivers/net/wwan/t7xx/t7xx_port_devlink.c:465:42: error:
 'DEVLINK_SUPPORT_FLASH_UPDATE_COMPONENT' undeclared here (not in a
 function); did you mean 'DEVLINK_ATTR_FLASH_UPDATE_COMPONENT'?
Message-ID: <202208211443.W5A3Y2z1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   e7096f2b22b32bd60568d91d12b562b3314bc8cc
commit: d8cf683bc939bf07c19efa964a98f10829e30df4 [5/42] net: devlink: extend info_get() version put to indicate a flash component
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220821/202208211443.W5A3Y2z1-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/d8cf683bc939bf07c19efa964a98f10829e30df4
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout d8cf683bc939bf07c19efa964a98f10829e30df4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wwan/t7xx/t7xx_port_devlink.c:465:42: error: 'DEVLINK_SUPPORT_FLASH_UPDATE_COMPONENT' undeclared here (not in a function); did you mean 'DEVLINK_ATTR_FLASH_UPDATE_COMPONENT'?
     465 |         .supported_flash_update_params = DEVLINK_SUPPORT_FLASH_UPDATE_COMPONENT,
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          DEVLINK_ATTR_FLASH_UPDATE_COMPONENT


vim +465 drivers/net/wwan/t7xx/t7xx_port_devlink.c

87dae9e70bf7be2 M Chetan Kumar 2022-08-16  462  
87dae9e70bf7be2 M Chetan Kumar 2022-08-16  463  /* Call back function for devlink ops */
87dae9e70bf7be2 M Chetan Kumar 2022-08-16  464  static const struct devlink_ops devlink_flash_ops = {
87dae9e70bf7be2 M Chetan Kumar 2022-08-16 @465  	.supported_flash_update_params = DEVLINK_SUPPORT_FLASH_UPDATE_COMPONENT,
87dae9e70bf7be2 M Chetan Kumar 2022-08-16  466  	.flash_update = t7xx_devlink_flash_update,
87dae9e70bf7be2 M Chetan Kumar 2022-08-16  467  	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
87dae9e70bf7be2 M Chetan Kumar 2022-08-16  468  			  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
87dae9e70bf7be2 M Chetan Kumar 2022-08-16  469  	.reload_down = t7xx_devlink_reload_down,
87dae9e70bf7be2 M Chetan Kumar 2022-08-16  470  	.reload_up = t7xx_devlink_reload_up,
87dae9e70bf7be2 M Chetan Kumar 2022-08-16  471  };
87dae9e70bf7be2 M Chetan Kumar 2022-08-16  472  

:::::: The code at line 465 was first introduced by commit
:::::: 87dae9e70bf7be2bd8a3c561fe3ddf666eb8a7a4 net: wwan: t7xx: Enable devlink based fw flashing and coredump collection

:::::: TO: M Chetan Kumar <m.chetan.kumar@linux.intel.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
