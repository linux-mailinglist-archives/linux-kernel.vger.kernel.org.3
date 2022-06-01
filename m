Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3229353A90F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355485AbiFAOVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356113AbiFAOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:20:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4CE15E5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654092568; x=1685628568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2V5yy/ZyYpElz8TO3SMrAwZhRAMEI5LtJeHrrmqpOB0=;
  b=W2WqAbsYSnGtoqCW0wQRNuByyGsVgM3d8aY4uqH8cRgqIRsdqnQb7jxE
   fuCud5dhIPaAybslD0dnbSrpC3dO+0u/fvhDkpjMDWY1iCRK/WQjHWkZL
   KPq3im70zNHzsh0hj0Gqn1ADH1GYBkDUQ0+Du/gpLzOZ/qcrN7h0W4Vww
   j8hAXdYU7MKpGvWU2Q4Zd0TonNXXE/7fN/g4S5vDrIko4x6M1XcYmQX59
   wLtldfmJOSAZVLVlO7CnQwy8xdcBqWsPqQenwS1elUkBNIFIkMqAbMLBz
   VPQBGiAuCIEAzNZz/Hb/wfiE+8zSj5+dx9u/IkhXUd0RjWNN5b1NWS8/6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="336255272"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="336255272"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 07:09:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="667440652"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2022 07:09:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwP1z-00043S-W2;
        Wed, 01 Jun 2022 14:09:03 +0000
Date:   Wed, 1 Jun 2022 22:08:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haowen Bai <baihaowen@meizu.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu
Cc:     kbuild-all@lists.01.org, Haowen Bai <baihaowen@meizu.com>,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coda: remove unused variable
Message-ID: <202206012213.GcFzu36Y-lkp@intel.com>
References: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18 next-20220601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Haowen-Bai/coda-remove-unused-variable/20220601-160014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 700170bf6b4d773e328fa54ebb70ba444007c702
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220601/202206012213.GcFzu36Y-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/627c05172e8d819cb8dca41dfa795baae03ea6f9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Haowen-Bai/coda-remove-unused-variable/20220601-160014
        git checkout 627c05172e8d819cb8dca41dfa795baae03ea6f9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/coda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/coda/upcall.c: In function 'venus_setattr':
   fs/coda/upcall.c:115:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     115 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_close':
   fs/coda/upcall.c:164:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     164 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_rename':
   fs/coda/upcall.c:238:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     238 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_rmdir':
   fs/coda/upcall.c:306:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     306 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_remove':
   fs/coda/upcall.c:329:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     329 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_link':
   fs/coda/upcall.c:383:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     383 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_symlink':
   fs/coda/upcall.c:410:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     410 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_fsync':
   fs/coda/upcall.c:443:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     443 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_access':
   fs/coda/upcall.c:459:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     459 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_pioctl':
>> fs/coda/upcall.c:63:51: error: 'insize' undeclared (first use in this function); did you mean 'iocsize'?
      63 |         inp = (union inputArgs *)alloc_upcall(op, insize); \
         |                                                   ^~~~~~
   fs/coda/upcall.c:483:9: note: in expansion of macro 'UPARG'
     483 |         UPARG(CODA_IOCTL);
         |         ^~~~~
   fs/coda/upcall.c:63:51: note: each undeclared identifier is reported only once for each function it appears in
      63 |         inp = (union inputArgs *)alloc_upcall(op, insize); \
         |                                                   ^~~~~~
   fs/coda/upcall.c:483:9: note: in expansion of macro 'UPARG'
     483 |         UPARG(CODA_IOCTL);
         |         ^~~~~
   fs/coda/upcall.c: In function 'venus_access_intent':
   fs/coda/upcall.c:576:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     576 |         union outputArgs *outp;
         |                           ^~~~


vim +63 fs/coda/upcall.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  60  
^1da177e4c3f41 Linus Torvalds 2005-04-16  61  #define UPARG(op)\
^1da177e4c3f41 Linus Torvalds 2005-04-16  62  do {\
^1da177e4c3f41 Linus Torvalds 2005-04-16 @63  	inp = (union inputArgs *)alloc_upcall(op, insize); \
^1da177e4c3f41 Linus Torvalds 2005-04-16  64          if (IS_ERR(inp)) { return PTR_ERR(inp); }\
^1da177e4c3f41 Linus Torvalds 2005-04-16  65          outp = (union outputArgs *)(inp); \
^1da177e4c3f41 Linus Torvalds 2005-04-16  66          outsize = insize; \
^1da177e4c3f41 Linus Torvalds 2005-04-16  67  } while (0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  68  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
