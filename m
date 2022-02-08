Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7184AE447
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387834AbiBHW3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387240AbiBHWKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:10:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378BC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644358213; x=1675894213;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h02fHfNx7LQhoMNvC37VqDWYOpJW635bruQfZsGYpnI=;
  b=cVcUCSbo52hVTkOmlLgCWlofa5YSRE45AP/DaPLryCAQmI7xU8FSSRnL
   y9h9a+0Py8enmAS+N+yTbvgg4cwJVVibutyPI39BUfmvzmDOY+8r/eNcR
   IYssqXASGe0q+VEJLQshbv8bh3sj3xJEEPEn8FLmhCgibHLiLnSw3ax8Y
   Ix08AnGycC7jDzBPYT4Q6cDZmkeeX+PFeBp6quHmZ2fuJ5fEcCpc2Ik79
   51YexrvT2AVX43w0/eSPBRDecobHzrEP/synE39LNwy37LbM9sfX7gkca
   lu9CBGWnbR5HxnjZ+BEoEn5mdsR4s6IGXJ3DquAStsZ1HsS/2HvWNf+lZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335465723"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="335465723"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 14:10:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="701007986"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2022 14:10:11 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHYgd-0000oP-Ae; Tue, 08 Feb 2022 22:10:11 +0000
Date:   Wed, 9 Feb 2022 06:09:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [saeed:net-next-mlx4 36/89] undefined reference to
 `ipv6_mc_check_mld'
Message-ID: <202202090647.RlBrHxf1-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git net-next-mlx4
head:   c3e676b98326a419f30dd5d956c68fc33323f4fd
commit: 47aeea0d57e80c9449448802aede54526a3d6305 [36/89] net: lan966x: Implement the callback SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED
config: parisc-randconfig-r012-20220208 (https://download.01.org/0day-ci/archive/20220209/202202090647.RlBrHxf1-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=47aeea0d57e80c9449448802aede54526a3d6305
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed net-next-mlx4
        git checkout 47aeea0d57e80c9449448802aede54526a3d6305
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/net/ethernet/microchip/lan966x/lan966x_main.o: in function `lan966x_xtr_irq_handler.part.0':
>> (.text+0x2240): undefined reference to `ipv6_mc_check_mld'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
