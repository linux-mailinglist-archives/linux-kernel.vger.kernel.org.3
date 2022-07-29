Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28F35856C3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbiG2WIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiG2WI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:08:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0116C61D84
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659132507; x=1690668507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FOAG1AFFLl+h+ks+8I2hpNBymq2OBD3Oz+LgO1hiAFE=;
  b=jSV2lttsk+7KmMc64rdxic1Ni8+1IKolKrg7J7CwgCaE21L+6uW9mKHW
   ptWyh0QkmgbrJmnp9KQgc7XHZrqla863VJcAQXslXrwJSJSEGNt2IkPmF
   mbh09RCf+NB7wYETvvlZ8SShq8VaKvN3gfhFJ4bRpM+mZryLQn/mMwrL1
   n3SUD3ixV1v6QOAsRpefFAIuVrjfB5mmV6QR1AX+RppXEx+0/TpDwrWeh
   p2dTm2OddVwJvNW53k8F8txrfXcAwokuxur1raPFPHD2aM3IwsmW0Nnkg
   VIpGZkUkqw+weesu1TJcXvT2GcOqGQDjrIDf5GdGmlGU8nGjEYQNzo39Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="350561600"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="350561600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 15:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="743668383"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2022 15:08:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHY9h-000C8X-1C;
        Fri, 29 Jul 2022 22:08:25 +0000
Date:   Sat, 30 Jul 2022 06:08:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 8/8]
 arch/x86/entry/vdso/vgetrandom.c:10:9: warning: no previous prototype for
 '__vdso_getrandom'
Message-ID: <202207300625.hQvJunv9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   7f252f719a107b2d29b14c2f7143a80d4fa14349
commit: 7f252f719a107b2d29b14c2f7143a80d4fa14349 [8/8] random: implement getrandom() in vDSO
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220730/202207300625.hQvJunv9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/7f252f719a107b2d29b14c2f7143a80d4fa14349
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 7f252f719a107b2d29b14c2f7143a80d4fa14349
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vdso/ lib/vdso/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/entry/vdso/vgetrandom.c:8:
>> arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:102:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     102 | static ssize_t __always_inline
         | ^~~~~~
>> arch/x86/entry/vdso/vgetrandom.c:10:9: warning: no previous prototype for '__vdso_getrandom' [-Wmissing-prototypes]
      10 | ssize_t __vdso_getrandom(void **state, void *buffer, size_t len, unsigned long flags)
         |         ^~~~~~~~~~~~~~~~


vim +/__vdso_getrandom +10 arch/x86/entry/vdso/vgetrandom.c

     9	
  > 10	ssize_t __vdso_getrandom(void **state, void *buffer, size_t len, unsigned long flags)
    11	{
    12		return __cvdso_getrandom(state, buffer, len, flags);
    13	}
    14	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
