Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C766A59F110
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiHXBgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXBgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:36:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB06057259
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661304975; x=1692840975;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZSQdgFUsPfJRnOYbqUKECCoXJ23M8lFz2oYprolTziI=;
  b=oKOx5NQM9UKkoWp6mlkYWhrqAcLwGRX3qCHBx3ofZV2Ef53bzhdQLKNK
   ptRC6C91St3WfDH/Y03UqNG9CEH27vh/eUgwWzgfs4Ke5JnWD2fUouxzC
   /BV7et/UpjPFnjFKN1xnEvKgG+Oapm9hRJKX1er6z3YCdnVBe/vQv88Xi
   zSbQDkJOuawJYeX87wkzElhHxP8eAWjdwbMCMiwAW/Jy7ABAOq6zE1Yfo
   bpbR5xUwT00dJAb3/NhmENq0yvDvOCkx1fvLLpqVhlrzAX7bqktD4qBAK
   d8d9z0mDLoAcVzched8UTxx+i1zs4T8iAwDzW4DxjQqbFdINgkPMPhQLD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="319893655"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="319893655"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 18:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="560398672"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2022 18:36:13 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQfJV-0000oh-0A;
        Wed, 24 Aug 2022 01:36:13 +0000
Date:   Wed, 24 Aug 2022 09:35:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/alternatives/rework 15/18]
 arch/arm64/kernel/alternative.c:269:14: warning: no previous prototype for
 function 'alt_cb_patch_nops'
Message-ID: <202208240946.qpIze2KD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/alternatives/rework
head:   fad62c713602c963008575fd972d316569a32d12
commit: e5a9b245aeab3e0d83fbc7f9861351e8bb0e4823 [15/18] arm64: alternatives: add shared NOP callback
config: arm64-randconfig-r022-20220823 (https://download.01.org/0day-ci/archive/20220824/202208240946.qpIze2KD-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project b04d01c009d7f66bcca9138d2ce40999eedf104d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=e5a9b245aeab3e0d83fbc7f9861351e8bb0e4823
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/alternatives/rework
        git checkout e5a9b245aeab3e0d83fbc7f9861351e8bb0e4823
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ arch/arm64/mm/ kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:269:14: warning: no previous prototype for function 'alt_cb_patch_nops' [-Wmissing-prototypes]
   noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
                ^
   arch/arm64/kernel/alternative.c:269:9: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
           ^
           static 
   1 warning generated.


vim +/alt_cb_patch_nops +269 arch/arm64/kernel/alternative.c

   268	
 > 269	noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
