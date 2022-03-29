Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259684EA87A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiC2H07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiC2H06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:26:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109F231936
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648538716; x=1680074716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nXCzK7eNroax6VfJWHr3xtpZ++gimyG6n8VcC7uqn6I=;
  b=JO0xZX2y3t7PuWHCgIShSf0sChY1Z+J05M1WQOCp/bHuFuQibgUKLs8a
   AVmSoAlHvDm+B453mkRxXYDMfKP29th2wi4Y0GFpEpLV4IcYTl/zZdDqf
   K0aQ/G/8r0wtBjXgRGiSwNE3JDDylm8wW910sUrzkAE4UoR/YaUs2r04d
   taKy5hXKoIAl5w4bAeMDfASc0hAtkGOPRm8bVRz6MjOqu2+m45qB41+R8
   HytaIASnuSgRg9AmqrlSQ526toqp7eAriZlR1IT5pqWaZlk65Ls3G4RB2
   bJ42/NBwDLrz5+JizwZbdWFVggHvEyv6Roqq6V2mCjVvScsk/NgSBpVQW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="258012081"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="258012081"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 00:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="652734975"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2022 00:25:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ6Dr-0002mf-L6; Tue, 29 Mar 2022 07:24:59 +0000
Date:   Tue, 29 Mar 2022 15:23:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Colin Downs-Razouk <colindr@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Chris Morin <cmtm@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-kiwi-5.10
 8832/9999] drivers/virtio/virtio_pvclock.c:49:6: warning: no previous
 prototype for function 'update_suspend_time'
Message-ID: <202203291512.gezfy3Lu-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-kiwi-5.10
head:   9c6bdae16301919fcab74129dee1083eba844952
commit: 029865ac9555743665dd106b4bbefb2f371849e9 [8832/9999] ANDROID: virtio: virtio_pvclock: initial driver impl
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220329/202203291512.gezfy3Lu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/029865ac9555743665dd106b4bbefb2f371849e9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-kiwi-5.10
        git checkout 029865ac9555743665dd106b4bbefb2f371849e9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_pvclock.c:49:6: warning: no previous prototype for function 'update_suspend_time' [-Wmissing-prototypes]
   void update_suspend_time(struct work_struct *work)
        ^
   drivers/virtio/virtio_pvclock.c:49:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void update_suspend_time(struct work_struct *work)
   ^
   static 
>> drivers/virtio/virtio_pvclock.c:295:11: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
           uint32_t rating =
                    ^
   2 warnings generated.


vim +/update_suspend_time +49 drivers/virtio/virtio_pvclock.c

    48	
  > 49	void update_suspend_time(struct work_struct *work)
    50	{
    51		u64 suspend_ns, suspend_time_delta = 0;
    52		struct timespec64 inject_time;
    53		struct virtio_pvclock *vp;
    54	
    55		vp = container_of(work, struct virtio_pvclock,
    56				  update_suspend_time_work);
    57	
    58		virtio_cread(vp->vdev, struct virtio_pvclock_config, suspend_time_ns,
    59			     &suspend_ns);
    60	
    61		mutex_lock(&vp->inject_suspend_lock);
    62		if (suspend_ns > vp->injected_suspend_ns) {
    63			suspend_time_delta = suspend_ns - vp->injected_suspend_ns;
    64			vp->injected_suspend_ns = suspend_ns;
    65		}
    66		mutex_unlock(&vp->inject_suspend_lock);
    67	
    68		if (suspend_time_delta == 0) {
    69			dev_err(&vp->vdev->dev,
    70				"%s: suspend_time_ns is less than injected_suspend_ns\n",
    71				__func__);
    72			return;
    73		}
    74	
    75		inject_time = ns_to_timespec64(suspend_time_delta);
    76	
    77		timekeeping_inject_sleeptime64(&inject_time);
    78	
    79		dev_info(&vp->vdev->dev, "injected sleeptime: %llu ns\n",
    80			 suspend_time_delta);
    81	}
    82	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
