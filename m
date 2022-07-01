Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BCC562AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiGAFgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGAFgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:36:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1C68A22
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656653808; x=1688189808;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MKMkWixYGmPLe69VkgmZnHTT6exv/Uv7l0i3wC5kYQ8=;
  b=Oyj5FDr83wonSI2bYVlfmPp2XMu56vPfm4Kit4Yw4IcM6rV9z8InnNIn
   iyqI0fLqOQCqxf0SXxtDU5cs1XsrfAR8SNqNt3a54EanyI94O51KUuEGk
   OyZUcuLvFK00sXagKUyTYxE5Sq725PS3pBh3R+6VHHL9sZwbWIRzvIg9k
   Bq6id278c/NJ3sAsX0y9Hl3SaVloXV0HfKf1EjUCiaFPhBzCzP7RS5Vpb
   NRWwhbzo8Q3IB27cUnJdHdeYueP3Wr7zVd0WXPUzHtZAhvcP9zvrLYbVj
   JMpjbnSY3ASZMuNd6Fcvp6PGqJEzqrjqHl7tTbujzknpFKMCkUv5zj/8m
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="308068872"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="308068872"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 22:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="918340400"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2022 22:36:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o79KN-000Dbi-SQ;
        Fri, 01 Jul 2022 05:36:27 +0000
Date:   Fri, 1 Jul 2022 13:35:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 21/24]
 net/core/devlink.c:9957: warning: expecting prototype for
 devlink_port_unregister(). Prototype was for devl_port_unregister() instead
Message-ID: <202207011317.bJ95opGj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   4f8833297c6cff331e180ef6146c9196aa50d7a2
commit: f2ccd8029224bd9592d91da3daa27da50af65520 [21/24] net: devlink: Fix lockless vs locked functions descriptions
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220701/202207011317.bJ95opGj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/f2ccd8029224bd9592d91da3daa27da50af65520
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout f2ccd8029224bd9592d91da3daa27da50af65520
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/core/devlink.c:9957: warning: expecting prototype for devlink_port_unregister(). Prototype was for devl_port_unregister() instead


vim +9957 net/core/devlink.c

d7907a2b1a3b89 Leon Romanovsky 2021-07-28  9950  
f2ccd8029224bd Jiri Pirko      2022-06-30  9951  /**
f2ccd8029224bd Jiri Pirko      2022-06-30  9952   *	devlink_port_unregister - Unregister devlink port
f2ccd8029224bd Jiri Pirko      2022-06-30  9953   *
f2ccd8029224bd Jiri Pirko      2022-06-30  9954   *	@devlink_port: devlink port
f2ccd8029224bd Jiri Pirko      2022-06-30  9955   */
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9956  void devl_port_unregister(struct devlink_port *devlink_port)
2cb7b4890d6e7f Jakub Kicinski  2022-03-14 @9957  {
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9958  	lockdep_assert_held(&devlink_port->devlink->lock);
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9959  
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9960  	devlink_port_type_warn_cancel(devlink_port);
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9961  	devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9962  	list_del(&devlink_port->list);
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9963  	WARN_ON(!list_empty(&devlink_port->reporter_list));
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9964  	WARN_ON(!list_empty(&devlink_port->region_list));
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9965  	mutex_destroy(&devlink_port->reporters_lock);
bf7974710a40aa Jiri Pirko      2016-04-14  9966  }
2cb7b4890d6e7f Jakub Kicinski  2022-03-14  9967  EXPORT_SYMBOL_GPL(devl_port_unregister);
bf7974710a40aa Jiri Pirko      2016-04-14  9968  

:::::: The code at line 9957 was first introduced by commit
:::::: 2cb7b4890d6e7f20560dc251e7f8d3cc68b0d554 devlink: expose instance locking and add locked port registering

:::::: TO: Jakub Kicinski <kuba@kernel.org>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
