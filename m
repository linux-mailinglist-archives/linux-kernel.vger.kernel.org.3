Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587F25882F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiHBUKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiHBUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:10:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C0BFD39
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659471033; x=1691007033;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aNqlGem3NFF0GkVpiptfTkjgnKFDgSyWE10bhVq+Y7o=;
  b=JxWthWvPl2P6kurtGQAZ/yLGd7ykxbgLr+sJhg6l+sgDezfmYOmKuKFP
   MbyeJDS45eEQffTnAZZPUCSZC4HY+/DguW9NHkAhmBHa2PWY8FOYLYZOI
   XzlihBMVMflNKVp9tOS63I6+Wv5vUFTcOiP9svBg+sjeLtryed0Tkqye1
   NlextHCEvJvIGaq2ePUVZmQTmDUqbMvQM72mkh6v0qYE2i468wna7H0xx
   MQ/Q4OVLPVucGsU+irogJoA37XSWew99/m85pPlIinG1oLdKHB9g1fAf1
   JGcUyuYMVA3m8szjY60/4hFpTRbVBWazLzWjWUSZ2NmpKxjgezDcq4VcJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="289521963"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="289521963"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 13:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="553049848"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2022 13:10:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIyDn-000GOB-1P;
        Tue, 02 Aug 2022 20:10:31 +0000
Date:   Wed, 3 Aug 2022 04:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/mips/kernel/jump_label.c:93:6: warning: no previous prototype
 for 'jump_label_apply_nops'
Message-ID: <202208030454.88LesR4N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1dbe9a1c86da098a29dcdca1a67b65e2de7ec3a
commit: fdfd42892f311e2b3695852036e5be23661dc590 jump_label: mips: move module NOP patching into arch code
date:   6 weeks ago
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220803/202208030454.88LesR4N-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
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
