Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BB84DBBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355265AbiCQA7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350471AbiCQA7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:59:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDF113E31
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647478699; x=1679014699;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f8bXk3IskXH8eFFzpaNPyeyddF0leRb7wqn21Yw5bec=;
  b=YVLu8DNzBp+6vacIJ5wNX7YGa9LQBdiGj7ZI6qOLF8pCa3SW0YZPj2Wx
   e4ysYd9i3EWqxv4ZJZ9dOILLu6rsWZ+ReoFmLB9wqmcmKcZOm/P4iiLFV
   8Rad/gIrOT9Fge9AotjA+HauHZMZcUFIOKuiSgHzlNran3iKBOmlozm0+
   kJqsMzQ6gk9lmMSjmcDh7US4WJHX2IEJVsQ787HrfOR+mMLGn+XbIoAcS
   FGQxqAqGtF9SfinYYBYKn/keuHqxrQwg4NXJX8O2vdvmT1ZOhhLR6WtQE
   velMCpwhTC3hKkIxjNWwMRDGfVLdOUir0KbX433tR6dS+NTigVlHT2DoI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236696964"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236696964"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516566728"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 17:58:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUeT2-000D96-OS; Thu, 17 Mar 2022 00:58:16 +0000
Date:   Thu, 17 Mar 2022 08:58:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 915/2335] ./usr/include/linux/if_tunnel.h:5:10:
 fatal error: 'uapi/linux/sockios.h' file not found
Message-ID: <202203170800.LxF9hGll-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: b8d36bc5384ae56de169ae667aec58547181384f [915/2335] headers/deps: Add header dependencies to .h files: <uapi/linux/sockios.h>
config: i386-randconfig-a012-20220314 (https://download.01.org/0day-ci/archive/20220317/202203170800.LxF9hGll-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b8d36bc5384ae56de169ae667aec58547181384f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout b8d36bc5384ae56de169ae667aec58547181384f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/if_tunnel.h:5:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/kcm.h:18:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/x25.h:15:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/rds.h:38:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
