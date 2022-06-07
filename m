Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF56353FA66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiFGJx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiFGJxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:53:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF94C580C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654595632; x=1686131632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4MYxWixXXeFkYzqpLsRkGqZgqtADSRc+X+29/9R2/D4=;
  b=ESjmSzcecZRiqxSl3bF4ZS7H3mx6WUoLay5e3Q7/dsqYpUVwqGrr2aTt
   KfH4ypcuXrjnUqCsxz7zMcMmDyOjS7P6zAUDqmhV7to3Ydm8FbFpogAvN
   wIrvHKtedvlW/IZQmBqaBOjPk1Mhpe7PFKiygja1vgZZU5Q58SbrmYJog
   AC1AUkjLgyB5zzdRy8YzalsDjsAx6k7S4sSd10PS8/JXXsEw3ytS/uqs6
   OSlYcV2K5ORFDGC7TCigt2y32iCuXbfdQ8zYlrtymX5KY6A9KNIoVHLU4
   8kM/hyaR2q6wsDF2r8kDzrcJ6T53C6lfhvBI3jgkea+UfEEJNSUSra7RO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="257158835"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="257158835"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 02:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="709416568"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2022 02:53:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyVuH-000DZ3-GP;
        Tue, 07 Jun 2022 09:53:49 +0000
Date:   Tue, 7 Jun 2022 17:53:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: kernel/module/main.c:4515:14: warning: variable 'exit' set but not
 used
Message-ID: <202206071718.QNuYKpUb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e71e60cd74df9386c3f684c54888f2367050b831
commit: cfc1d277891eb499b3b5354df33b30f598683e90 module: Move all into module/
date:   9 weeks ago
config: arm64-buildonly-randconfig-r011-20220607 (https://download.01.org/0day-ci/archive/20220607/202206071718.QNuYKpUb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cfc1d277891eb499b3b5354df33b30f598683e90
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cfc1d277891eb499b3b5354df33b30f598683e90
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/module/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/module/main.c:4515:14: warning: variable 'exit' set but not used [-Wunused-but-set-variable]
           exitcall_t *exit;
                       ^
   kernel/module/main.c:4802:6: warning: no previous prototype for function 'module_layout' [-Wmissing-prototypes]
   void module_layout(struct module *mod,
        ^
   kernel/module/main.c:4802:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void module_layout(struct module *mod,
   ^
   static 
   2 warnings generated.


vim +/exit +4515 kernel/module/main.c

^1da177e4c3f41 kernel/module.c Linus Torvalds 2005-04-16  4510  
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4511  static void cfi_init(struct module *mod)
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4512  {
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4513  #ifdef CONFIG_CFI_CLANG
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4514  	initcall_t *init;
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08 @4515  	exitcall_t *exit;
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4516  
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4517  	rcu_read_lock_sched();
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4518  	mod->cfi_check = (cfi_check_fn)
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4519  		find_kallsyms_symbol_value(mod, "__cfi_check");
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4520  	init = (initcall_t *)
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4521  		find_kallsyms_symbol_value(mod, "__cfi_jt_init_module");
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4522  	exit = (exitcall_t *)
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4523  		find_kallsyms_symbol_value(mod, "__cfi_jt_cleanup_module");
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4524  	rcu_read_unlock_sched();
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4525  
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4526  	/* Fix init/exit functions to point to the CFI jump table */
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4527  	if (init)
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4528  		mod->init = *init;
0d67e332e6df72 kernel/module.c Arnd Bergmann  2021-09-27  4529  #ifdef CONFIG_MODULE_UNLOAD
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4530  	if (exit)
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4531  		mod->exit = *exit;
0d67e332e6df72 kernel/module.c Arnd Bergmann  2021-09-27  4532  #endif
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4533  
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4534  	cfi_module_add(mod, module_addr_min);
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4535  #endif
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4536  }
cf68fffb66d60d kernel/module.c Sami Tolvanen  2021-04-08  4537  

:::::: The code at line 4515 was first introduced by commit
:::::: cf68fffb66d60d96209446bfc4a15291dc5a5d41 add support for Clang CFI

:::::: TO: Sami Tolvanen <samitolvanen@google.com>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
