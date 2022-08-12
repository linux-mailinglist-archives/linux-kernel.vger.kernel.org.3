Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A92591506
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbiHLRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiHLRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:38:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE90B2761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660325932; x=1691861932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mF/OP/Iab3Tfnry5GMh4CCBq6ehsp1JKERMUd2ZqK6I=;
  b=ZDDNl4kGtgvp787l35dic+QVZAGY9qs6Z34doNmV57luPA/kx7bJjSSs
   VSeVj9KeWqp2JxpmI3GrXnx1BIwa6SS5ZxJNvlvPKl3GcdWe0kFIFwyyT
   z4UOIGSTDkjaDCSy10KWeSBmqjchsMdnPksuMa9tMOSFoPT7oj5psQ3Wh
   ohsIsiUsTP5Oossaam9iuo2S8wNylPYDzL/qrefLZH1XU2rJ+JEy5BS0t
   kL3IDMV9h5sVMm6dL9DLWYNHTV52AkjEI3dYyjgAqyMq/Yx3IDP3rcyCF
   fXa8Ioe0b8HsmzstLmOLTngUZBKA5QJrHAQY96LKx4YQw4gOUvfES4Cfr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="272040301"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="272040301"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 10:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="638968237"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2022 10:38:50 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMYcT-0000mx-2s;
        Fri, 12 Aug 2022 17:38:49 +0000
Date:   Sat, 13 Aug 2022 01:38:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/mips/kernel/jump_label.c:93:6: warning: no previous prototype
 for 'jump_label_apply_nops'
Message-ID: <202208130145.n64kApSL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ebfc85e2cd7b08f518b526173e9a33b56b3913b
commit: fdfd42892f311e2b3695852036e5be23661dc590 jump_label: mips: move module NOP patching into arch code
date:   7 weeks ago
config: mips-randconfig-r001-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130145.n64kApSL-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fdfd42892f311e2b3695852036e5be23661dc590
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fdfd42892f311e2b3695852036e5be23661dc590
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/kernel/jump_label.c:93:6: warning: no previous prototype for 'jump_label_apply_nops' [-Wmissing-prototypes]
      93 | void jump_label_apply_nops(struct module *mod)
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/jump_label_apply_nops +93 arch/mips/kernel/jump_label.c

    91	
    92	#ifdef CONFIG_MODULES
  > 93	void jump_label_apply_nops(struct module *mod)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
