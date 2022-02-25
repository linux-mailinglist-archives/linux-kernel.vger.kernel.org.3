Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D94C4DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiBYSe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiBYSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:34:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280311A8CA1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645814064; x=1677350064;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X+gL+ayeFkekglLaChjeWnBq47ZhBCUtvIdt9Wmz+hM=;
  b=SCaKCJJwfPvk0o1D3ZzAikPiYnZ5gnxr3N/3oR2p298mzfxBgxSEIFZd
   rHc7mIjYFJzrcFIHPi1Gnd5HuwfLfap5R7fdN0aDLCXWOudD2sgh1IJBk
   LM6KGFQKHDAQW7aj7lvbi6jXPSHK+2IZJ758zOcgYKmwzY+DV3H5nTSsH
   xYjurywVVx1mAe6f5/iCEPRKf8bnRyn6dmY/HMMnJssgYh2lwPy0AM05h
   25zhYNsGV3mvf8hNN1z46LWP6++COf92dFBmZ/eXuojyn62kE84y8p/vB
   JCCMFv18DR7fdfN6i3YL6oMG39T2Z14gvJ+DgRWkZRe5p0MQTE9/RsUdO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="338992328"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="338992328"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 10:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="492056461"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2022 10:34:22 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNfQ5-0004bn-KK; Fri, 25 Feb 2022 18:34:21 +0000
Date:   Sat, 26 Feb 2022 02:34:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [at91:at91-soc 6/6]
 drivers/soc/microchip/mpfs-sys-controller.c:76:6: warning: no previous
 prototype for 'mpfs_sys_controller_put'
Message-ID: <202202260047.AMTP3O8K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git at91-soc
head:   d0054a470c33902f5ae88835ed8a8ecc3cf8faa4
commit: d0054a470c33902f5ae88835ed8a8ecc3cf8faa4 [6/6] soc: add microchip polarfire soc system controller
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220226/202202260047.AMTP3O8K-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/commit/?id=d0054a470c33902f5ae88835ed8a8ecc3cf8faa4
        git remote add at91 https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
        git fetch --no-tags at91 at91-soc
        git checkout d0054a470c33902f5ae88835ed8a8ecc3cf8faa4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/soc/microchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/microchip/mpfs-sys-controller.c:76:6: warning: no previous prototype for 'mpfs_sys_controller_put' [-Wmissing-prototypes]
      76 | void mpfs_sys_controller_put(void *data)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/mpfs_sys_controller_put +76 drivers/soc/microchip/mpfs-sys-controller.c

    75	
  > 76	void mpfs_sys_controller_put(void *data)
    77	{
    78		struct mpfs_sys_controller *sys_controller = data;
    79	
    80		kref_put(&sys_controller->consumers, mpfs_sys_controller_delete);
    81	}
    82	EXPORT_SYMBOL(mpfs_sys_controller_put);
    83	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
