Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE84F91EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiDHJUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiDHJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:16:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CD92128CA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649409133; x=1680945133;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kTnNSyd2KSejwef/fzCMx5wyaT0+JL9g6RKbnrj0wq4=;
  b=S2cPLYfRTZSShf6MfjY4KDVdr5HQfH9HU/6WIUiHLvugBXnBA2IU7CdZ
   jTOKVzjU+TjOKx25m5g/em1/wHVWbRZjCqWfuQ0oga1yL3xzFP1XbjBvm
   BPvW8IDmtrgd/I9EsoLoFTjUcG0kbp5wHruA4sB/10MGh7HnqSOU2CVkI
   tGwy+iN9UmbT5RicxOIVXtSPHBHNHsSg/EH9PSoLaN3GMJSxLxGAA6Yad
   OOcwchT8xR3PcoMTcvx6dNyAQ6kS5UallM72AwuO52vWWng4udrVqVBNa
   UWF0f60sSRs8l/iEzjfCC3nn9AzVbs8UmgourSte7XBx+95ENw4h1lF9z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="242145909"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="242145909"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 02:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="659419507"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2022 02:12:11 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nckf4-00006b-P4;
        Fri, 08 Apr 2022 09:12:10 +0000
Date:   Fri, 8 Apr 2022 17:11:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     popcornmix <popcornmix@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [l1k:smsc95xx_5.17 279/887] drivers/char/broadcom/rpivid-mem.c:52:
 warning: expecting prototype for rpivid(). Prototype was for DRIVER_NAME()
 instead
Message-ID: <202204081732.FRe9Lg4m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi popcornmix,

First bad commit (maybe != root cause):

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 369c3a505f84640f4c10f4caf67c22bf5f9b1d56 [279/887] char: Add broadcom char drivers back to build files
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220408/202204081732.FRe9Lg4m-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/369c3a505f84640f4c10f4caf67c22bf5f9b1d56
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 369c3a505f84640f4c10f4caf67c22bf5f9b1d56
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/char/broadcom/ drivers/gpu/drm/panel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/char/broadcom/rpivid-mem.c:52: warning: expecting prototype for rpivid(). Prototype was for DRIVER_NAME() instead
--
>> drivers/char/broadcom/bcm2835-gpiomem.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * GPIO memory device driver


vim +52 drivers/char/broadcom/rpivid-mem.c

8900af03fcebd0 Jonathan Bell 2019-05-09  51  
8900af03fcebd0 Jonathan Bell 2019-05-09 @52  #define DRIVER_NAME "rpivid-mem"
8900af03fcebd0 Jonathan Bell 2019-05-09  53  #define DEVICE_MINOR 0
8900af03fcebd0 Jonathan Bell 2019-05-09  54  

:::::: The code at line 52 was first introduced by commit
:::::: 8900af03fcebd0065244b505c394ce12164624d8 drivers: char: add chardev for mmap'ing the RPiVid control registers

:::::: TO: Jonathan Bell <jonathan@raspberrypi.org>
:::::: CC: Dom Cobley <popcornmix@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
