Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B265687C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiGFMGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiGFMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:06:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACD02982F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657109163; x=1688645163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zxL04VaxVE567Eropn8E/Xy28wSTQqFoMmVBALQrmoY=;
  b=RCmUhbNJVVRGuxoFFxUw9bRpcrr/kVtnJ/BslJpDxEbTPDBCgh3KjEcC
   PlSpRWs2W0o7rmneM7eSjRmdCyp6wdmzRcwsSfmSTa8U0Y6watS6IMw8t
   Mp2n3mkWBemJMON2D5XxglfwW4GqSBdFga0SaiPGGEbl+pAnA8gaZJzGW
   Hpcrp79hS27SihT+H33FgLEw2j6kK+CyVZl3ieBtKXl5/ofptuh8F4oY7
   lfcmA/1vq8IO89UU2Bj6d12X1NvP6bVHjZAu//anRCQ+z3Ua942lNS47g
   7ALKA69IxAYsg93uNw2Hy5EWHDZFZk6E4IeF5UdcD5/gdFjs7n3vy94al
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="370045349"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="370045349"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="543373484"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2022 05:06:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o93n7-000KYS-Ae;
        Wed, 06 Jul 2022 12:06:01 +0000
Date:   Wed, 6 Jul 2022 20:05:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/master 1/1]
 include/linux/random.h:109:10: fatal error: 'asm/archrandom.h' file not
 found
Message-ID: <202207061956.AGbuqVuj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/master
head:   b06ae5cc5acfc776074b6fa7580a3e33fd999734
commit: b06ae5cc5acfc776074b6fa7580a3e33fd999734 [1/1] random: remove CONFIG_ARCH_RANDOM
config: hexagon-randconfig-r041-20220703 (https://download.01.org/0day-ci/archive/20220706/202207061956.AGbuqVuj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b06ae5cc5acfc776074b6fa7580a3e33fd999734
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/master
        git checkout b06ae5cc5acfc776074b6fa7580a3e33fd999734
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/base/core.c:27:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:26:
   In file included from include/linux/net.h:18:
>> include/linux/random.h:109:10: fatal error: 'asm/archrandom.h' file not found
   #include <asm/archrandom.h>
            ^~~~~~~~~~~~~~~~~~
   1 error generated.


vim +109 include/linux/random.h

5960164fde9bc2 Joe Eykholt        2010-05-26  108  
63d77173266c17 H. Peter Anvin     2011-07-31 @109  #include <asm/archrandom.h>
b06ae5cc5acfc7 Jason A. Donenfeld 2022-07-05  110  

:::::: The code at line 109 was first introduced by commit
:::::: 63d77173266c1791f1553e9e8ccea65dc87c4485 random: Add support for architectural random hooks

:::::: TO: H. Peter Anvin <hpa@zytor.com>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
