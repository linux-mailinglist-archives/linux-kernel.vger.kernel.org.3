Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839CB56C794
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 08:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiGIGkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 02:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiGIGka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 02:40:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A4419A6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657348829; x=1688884829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G+BoR8wm+nr7ZKLBztHNG61qEu73r2abCgp17a+KsP8=;
  b=nAOdXqNVIa9fAAvoGOMLqxWBxaG8kbqZjLF4Avb8V4mfyQFX25oMadEb
   zn6RJxdD+dZoIkOCrDTV45WzBOnTvUpLYmqonsp4m3E1jZjzFTMiR0DlC
   vQKz9I8R9qbrFj7OcqnQ+JR2OuRq6uGeQDnFcBeTX3zmWWV6r3eTwdEYh
   5m8yyp4LgcvVXZLWxPwkTduKeCJum041/ENYxryQZbwWwPmQzRL8waAgx
   lUH65DHjC+c0IdYVzeJlvpLJJD7I56kZiq3HsiOZQtyDvEKZyoKV2sudT
   EVfplA0MVmRVyZJPsU1amKoTxyagqHXqJ/q9cobalhvJHWDRCWN6gO+hW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="310004272"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="310004272"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 23:40:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="626937272"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2022 23:40:26 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA48g-000OOk-9k;
        Sat, 09 Jul 2022 06:40:26 +0000
Date:   Sat, 9 Jul 2022 14:40:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 156/161]
 drivers/irqchip/irq-gic-v3.c:666:9: error: expected ';' before 'err'
Message-ID: <202207091422.mERbR7Ce-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   ab88938c957f2e2edc60e19ab6df7830fc1c6914
commit: 66b9343ecbdd4d09a72bc854094a03ca858c2077 [156/161] irqchip/gic-v3: Ensure pseudo-NMIs have an ISB between ack and handling
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220709/202207091422.mERbR7Ce-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/66b9343ecbdd4d09a72bc854094a03ca858c2077
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout 66b9343ecbdd4d09a72bc854094a03ca858c2077
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3.c: In function 'gic_handle_nmi':
>> drivers/irqchip/irq-gic-v3.c:666:9: error: expected ';' before 'err'
     666 |         err = handle_domain_nmi(gic_data.domain, irqnr, regs);
         |         ^~~


vim +666 drivers/irqchip/irq-gic-v3.c

f32c926651dcd1 Julien Thierry 2019-01-31  646  
f32c926651dcd1 Julien Thierry 2019-01-31  647  static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
f32c926651dcd1 Julien Thierry 2019-01-31  648  {
17ce302f3117e9 Julien Thierry 2019-06-11  649  	bool irqs_enabled = interrupts_enabled(regs);
f32c926651dcd1 Julien Thierry 2019-01-31  650  	int err;
f32c926651dcd1 Julien Thierry 2019-01-31  651  
17ce302f3117e9 Julien Thierry 2019-06-11  652  	if (irqs_enabled)
17ce302f3117e9 Julien Thierry 2019-06-11  653  		nmi_enter();
17ce302f3117e9 Julien Thierry 2019-06-11  654  
f32c926651dcd1 Julien Thierry 2019-01-31  655  	if (static_branch_likely(&supports_deactivate_key))
f32c926651dcd1 Julien Thierry 2019-01-31  656  		gic_write_eoir(irqnr);
66b9343ecbdd4d Mark Rutland   2022-05-13  657  	else
66b9343ecbdd4d Mark Rutland   2022-05-13  658  		isb()
66b9343ecbdd4d Mark Rutland   2022-05-13  659  
f32c926651dcd1 Julien Thierry 2019-01-31  660  	/*
f32c926651dcd1 Julien Thierry 2019-01-31  661  	 * Leave the PSR.I bit set to prevent other NMIs to be
f32c926651dcd1 Julien Thierry 2019-01-31  662  	 * received while handling this one.
f32c926651dcd1 Julien Thierry 2019-01-31  663  	 * PSR.I will be restored when we ERET to the
f32c926651dcd1 Julien Thierry 2019-01-31  664  	 * interrupted context.
f32c926651dcd1 Julien Thierry 2019-01-31  665  	 */
f32c926651dcd1 Julien Thierry 2019-01-31 @666  	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
f32c926651dcd1 Julien Thierry 2019-01-31  667  	if (err)
f32c926651dcd1 Julien Thierry 2019-01-31  668  		gic_deactivate_unhandled(irqnr);
17ce302f3117e9 Julien Thierry 2019-06-11  669  
17ce302f3117e9 Julien Thierry 2019-06-11  670  	if (irqs_enabled)
17ce302f3117e9 Julien Thierry 2019-06-11  671  		nmi_exit();
f32c926651dcd1 Julien Thierry 2019-01-31  672  }
f32c926651dcd1 Julien Thierry 2019-01-31  673  

:::::: The code at line 666 was first introduced by commit
:::::: f32c926651dcd1683f4d896ee52609000a62a3dc irqchip/gic-v3: Handle pseudo-NMIs

:::::: TO: Julien Thierry <julien.thierry@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
