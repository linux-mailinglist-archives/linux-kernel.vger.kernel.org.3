Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D594BD077
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbiBTRqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:46:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiBTRqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:46:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B14C43C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 09:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645379147; x=1676915147;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kPWamF18+3uayzkEvIG/RE3/V46F9kV8YNM12YzBwyQ=;
  b=FZ+1BKKiFtxgf1TBqci64QqbdH2kGD7iHRDYWSsakMDzKFpDiIexJ3Vt
   PM70kp9lbA93wH1yaxHHp7sg/cGbGwK8WpETJORHcsRVasOmB5Wt6HW4w
   aJGA2ZbMOq2YfGwSmgWZhuyEWmE4yhdraC9LngJajZFUiQlm94D8t2Kh9
   9fClYKXdlSqJTpaQQbHMD3iW10S6ymY6EbMkm1jmZdxgQX7MlR8XHpZ22
   mwwm+mXu9jFa8fHB6gjcbCEmQeBYLYGWIIAoy5CuApRwv91foy+X0ig5X
   +Vlfju8mq0xdAsO1maMEjHgO+0u9yQ4UEcsyXKK8yQTAXBY1F+Pk1gEwq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314654303"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="314654303"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 09:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="705975874"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2022 09:45:45 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLqHI-0000Wt-Ng; Sun, 20 Feb 2022 17:45:44 +0000
Date:   Mon, 21 Feb 2022 01:45:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof:modules-next 1/10] kernel/module/main.c:4802:6: warning: no
 previous prototype for function 'module_layout'
Message-ID: <202202210111.TM1W8D5R-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
head:   c55dc78176e6fe97a9e92d24a7ff3015b14ac858
commit: 87b31159f78ab89d8ccda30d3eb9966af51bca64 [1/10] module: Move all into module/
config: hexagon-randconfig-r041-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210111.TM1W8D5R-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=87b31159f78ab89d8ccda30d3eb9966af51bca64
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof modules-next
        git checkout 87b31159f78ab89d8ccda30d3eb9966af51bca64
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/module/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/module/main.c:4802:6: warning: no previous prototype for function 'module_layout' [-Wmissing-prototypes]
   void module_layout(struct module *mod,
        ^
   kernel/module/main.c:4802:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void module_layout(struct module *mod,
   ^
   static 
   1 warning generated.


vim +/module_layout +4802 kernel/module/main.c

^1da177e4c3f41 kernel/module.c Linus Torvalds  2005-04-16  4796  
^1da177e4c3f41 kernel/module.c Linus Torvalds  2005-04-16  4797  #ifdef CONFIG_MODVERSIONS
24b9f0d2208145 kernel/module.c Sergey Shtylyov 2020-11-07  4798  /*
24b9f0d2208145 kernel/module.c Sergey Shtylyov 2020-11-07  4799   * Generate the signature for all relevant module structures here.
24b9f0d2208145 kernel/module.c Sergey Shtylyov 2020-11-07  4800   * If these change, we don't want to try to parse the module.
24b9f0d2208145 kernel/module.c Sergey Shtylyov 2020-11-07  4801   */
8c8ef42aee8fcf kernel/module.c Rusty Russell   2009-03-31 @4802  void module_layout(struct module *mod,

:::::: The code at line 4802 was first introduced by commit
:::::: 8c8ef42aee8fcfb4128bb94c50d55c9f80ade525 module: include other structures in module version check

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Rusty Russell <rusty@rustcorp.com.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
