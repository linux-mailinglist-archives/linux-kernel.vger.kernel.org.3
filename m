Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFC84E1D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 19:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbiCTShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiCTSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 14:36:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D106C98F71
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647801334; x=1679337334;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CJTg6RW7q07VNR0unQQdewucX2kShEL7FdcEu9hjfdg=;
  b=Jt1tSl231SLO80/aS8tF+Qg5PDp1uG8i5gDhEh533h+19PKFi1/2/8jZ
   c518wXVWu6wbzDEnTayN0AV5r0QgwAI/GmBdrutLkHKyhDM84jQ/AaCkZ
   XuPLudvw72REI6/KG1573G9IXbewucf1BnOsnfFlIFmEQnit//XBC7kdv
   REsL7PRT+GUHhWHz4LnaNQ7X80wI7taA+cb25MsV63/DJMZHOWhSOCn7K
   jC8BdPFpe1DOHiK90kyXzBw0RsH4cYn+lKqBmgJUrmQ/2MW6bXe8xVHJN
   wYbaav6uRqTRJmkR7NmRPbZMM4l6QzuMf0p+XPO54NP8+/nYa+P8VrpYx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="254986064"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254986064"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 11:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="518166623"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2022 11:35:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nW0Oq-000H9X-G5; Sun, 20 Mar 2022 18:35:32 +0000
Date:   Mon, 21 Mar 2022 02:34:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1564/2335] ./usr/include/linux/netdevice.h:29:10:
 fatal error: 'uapi/linux/if.h' file not found
Message-ID: <202203210209.hNJFRhoP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 928b32ae19a729802c77e9754fb7b9d4fe05bf0a [1564/2335] headers/deps: net: Optimize <uapi/linux/netdevice.h>
config: i386-randconfig-a012-20220314 (https://download.01.org/0day-ci/archive/20220321/202203210209.hNJFRhoP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=928b32ae19a729802c77e9754fb7b9d4fe05bf0a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 928b32ae19a729802c77e9754fb7b9d4fe05bf0a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/netdevice.h:29:10: fatal error: 'uapi/linux/if.h' file not found
   #include <uapi/linux/if.h>
            ^~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
