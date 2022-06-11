Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F10547498
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 14:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiFKMpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 08:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiFKMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:45:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCC1434B2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654951515; x=1686487515;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f5+4vXeyg96IHdeAF1KSCGhwtArxoLS8aJLuxGx6Gnk=;
  b=aiKmzed757c7o/B+oSMAOz7bYbUf4VCsWGK2ZCZdkSM/UUDmFtaNtcxG
   RFZ71ef/p9kv/lJiX53pUzePHlkR6Y4V1ZM3qoTAEAKpSwqx4Z8if17eJ
   tNppDDxtU+inAlQuLOWc+3rBiVEHqMO9oBWzrRHpVtGBxp7VJkB6H58fX
   GGTjH10UCocZnoR83vJtOf4xDBKTZrOwO4V1CLByP3RQkfnpOBsmkG3/2
   JBK+bO9TEwM+L5Mo6Vre72ryhZ1O73jaC4pbeTrrSa+0lNq/UF/AvtvBb
   HoNT8hs5GXJqvY3mslLCAvF0Q7pcPyF79+VhjJKy/VYzxD5DPo7l9ecY7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="277917973"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="277917973"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 05:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="685083842"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2022 05:45:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o00UL-000Iu1-RA;
        Sat, 11 Jun 2022 12:45:13 +0000
Date:   Sat, 11 Jun 2022 20:45:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:efi-rng-seed 5/7] arch/mips/kernel/jump_label.c:94:44: error:
 invalid use of undefined type 'struct module'
Message-ID: <202206112036.OEu6i0fw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git efi-rng-seed
head:   4952aff51641e19ec5c635f12fa2a386f05dc742
commit: 345dcf437d10e6d1576053a7f9a167e9d11edcfe [5/7] jump_label: mips: move module NOP patching into arch code
config: mips-randconfig-r031-20220611 (https://download.01.org/0day-ci/archive/20220611/202206112036.OEu6i0fw-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=345dcf437d10e6d1576053a7f9a167e9d11edcfe
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb efi-rng-seed
        git checkout 345dcf437d10e6d1576053a7f9a167e9d11edcfe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/kernel/jump_label.c:92:6: warning: no previous prototype for 'jump_label_apply_nops' [-Wmissing-prototypes]
      92 | void jump_label_apply_nops(struct module *mod)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/jump_label.c: In function 'jump_label_apply_nops':
>> arch/mips/kernel/jump_label.c:94:44: error: invalid use of undefined type 'struct module'
      94 |         struct jump_entry *iter_start = mod->jump_entries;
         |                                            ^~
   arch/mips/kernel/jump_label.c:95:56: error: invalid use of undefined type 'struct module'
      95 |         struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
         |                                                        ^~


vim +94 arch/mips/kernel/jump_label.c

    91	
    92	void jump_label_apply_nops(struct module *mod)
    93	{
  > 94		struct jump_entry *iter_start = mod->jump_entries;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
