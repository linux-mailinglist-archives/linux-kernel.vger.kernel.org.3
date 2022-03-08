Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5E84D15F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346350AbiCHLOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346386AbiCHLOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:14:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A793AA5D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646738002; x=1678274002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SgFlLyhZap8eNw/AK5DH4h0j97Zqi/QT6WmpeTYc2/o=;
  b=iHzFWH0XtriV+m9rB0w+flLYVqfsz0NxaIhPZ8xGL1lTLZeOdwtqv9j+
   5djujUXnBuTsLKZWl4VsQOwl0iI+28Ntc+iYmkcYDXG9xCxdp8v9RU3S5
   UVR0sVZiy1GEYwOohtSYr0ti4xDxh9L09Irc6fERx0bIWMLAeRzYXF3n1
   2OW2cf+IxTkuRjUsX4gQysHtHNAiAScBv/9jt0IgpA6WIVQbrhfVqlsj6
   1CBd7HncDfZKIvP23mfiqFa8Oe5RAeDCQXiZa8U3DMvt/XMwSaFaSd8tY
   ts7rSPJKdptI5WVISxiRhlRXK3dW2syrGfggfBXdMFUWpNIBkSoy7xIUE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254848899"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254848899"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="577960819"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2022 03:13:20 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRXmJ-0001Jc-HC; Tue, 08 Mar 2022 11:13:19 +0000
Date:   Tue, 8 Mar 2022 19:12:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [ammarfaizi2-block:powerpc/linux/next-test 142/143]
 arch/powerpc/kernel/prom_init.c:3302:22: error: no previous prototype for
 'prom_init'
Message-ID: <202203081921.SpUkNaaj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block powerpc/linux/next-test
head:   0a448e06d10e149bf5ed23202d49246b6c4cf77b
commit: 21dad3fa76176d992e8ddf3f49ad0866a5424da5 [142/143] powerpc: Move C prototypes out of asm-prototypes.h
config: powerpc64-randconfig-s031-20220307 (https://download.01.org/0day-ci/archive/20220308/202203081921.SpUkNaaj-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/21dad3fa76176d992e8ddf3f49ad0866a5424da5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block powerpc/linux/next-test
        git checkout 21dad3fa76176d992e8ddf3f49ad0866a5424da5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/prom_init.c:3302:22: error: no previous prototype for 'prom_init' [-Werror=missing-prototypes]
    3302 | unsigned long __init prom_init(unsigned long r3, unsigned long r4,
         |                      ^~~~~~~~~
   cc1: all warnings being treated as errors


vim +/prom_init +3302 arch/powerpc/kernel/prom_init.c

6a9c930bd7751b Ram Pai        2019-08-19  3296  
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3297  /*
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3298   * We enter here early on, when the Open Firmware prom is still
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3299   * handling exceptions and the MMU hash table for us.
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3300   */
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3301  
9b6b563c0d2d25 Paul Mackerras 2005-10-06 @3302  unsigned long __init prom_init(unsigned long r3, unsigned long r4,
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3303  			       unsigned long pp,
549e8152de8039 Paul Mackerras 2008-08-30  3304  			       unsigned long r6, unsigned long r7,
549e8152de8039 Paul Mackerras 2008-08-30  3305  			       unsigned long kbase)
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3306  {	
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3307  	unsigned long hdr;
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3308  

:::::: The code at line 3302 was first introduced by commit
:::::: 9b6b563c0d2d25ecc3111916031aa7255543fbfb powerpc: Merge in the ppc64 version of the prom code.

:::::: TO: Paul Mackerras <paulus@samba.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
