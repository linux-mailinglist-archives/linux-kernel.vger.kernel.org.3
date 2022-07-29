Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048775856CF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiG2WTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiG2WT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:19:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F8F747AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659133168; x=1690669168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7e1IU0/1VL/UlTDUWskyup1/DxjZcpExuYk7fPqQkS4=;
  b=EriA1AuC0pBWUj+d/kIPDTyMNiHKMCzQAPNaxbzG5UZouSY/+PYQ3mZX
   U1KMFpsZznCcHiKCegwcWy1tBxhA3qIG5tRgNS4bkyNVVrrtiIrK4+i4C
   pxUj8rgeH+EsvVOSqQmWqq124YrcoU6fgauUQ0Gl8tLCmAmTkz8fFvfWY
   t882x1KFMpowHND0Z20K1p6VX52oN53IO9imQQ3BQbjC8W3cDhUfvjCKe
   fIXHvXKPRIii2VRoNNlbfkXQtGjYWogFtT7HDPcQdhiDZHbHfefuK2lo0
   F20vLkSTFVukvNV8yX4cXSbLJBfzw6pVcEU8lPxcNwQedfN5eEuotRqsw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="352861652"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="352861652"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 15:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="629537051"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 15:19:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHYKL-000C8r-2A;
        Fri, 29 Jul 2022 22:19:25 +0000
Date:   Sat, 30 Jul 2022 06:18:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 8/8]
 arch/x86/entry/vdso/vgetrandom.c:10:9: warning: no previous prototype for
 function '__vdso_getrandom'
Message-ID: <202207300604.XFoJYXtZ-lkp@intel.com>
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
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220730/202207300604.XFoJYXtZ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7f252f719a107b2d29b14c2f7143a80d4fa14349
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 7f252f719a107b2d29b14c2f7143a80d4fa14349
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vdso/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/vdso/vgetrandom.c:10:9: warning: no previous prototype for function '__vdso_getrandom' [-Wmissing-prototypes]
   ssize_t __vdso_getrandom(void **state, void *buffer, size_t len, unsigned long flags)
           ^
   arch/x86/entry/vdso/vgetrandom.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   ssize_t __vdso_getrandom(void **state, void *buffer, size_t len, unsigned long flags)
   ^
   static 
   1 warning generated.


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
