Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A24456CBCC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGIWkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIWkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:40:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23B011A39
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657406420; x=1688942420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BkpJxB7LGRg/KFhERgzktu4pQo4ZAgVtQ7dfqBk3D4Q=;
  b=Hy4cKQFc7J3dWFoEkO2LSmZHFU9fv38wBwaNh2zYyiT3XQ2Shm4BXOTL
   eq6OwBD2xBq62rQj5iC0Hcwb4f6euGe8kts7lLiEDQzgO8gAEcNsd0xcp
   MjB3WKQHKaCyUqu3N/qhJvsmm2ToomZlsE6fiKpPDgvwdsc1MGe+oCzi/
   1jI8BpNKjL+LzUgg3IhbGoC2jlR8CJoAMX1BYsVoKYB2ogSdvXmy/VG04
   ZgsaBBoxmSLAKIRGDvYugGN0AmjkDxH+ZglWEI3TjE2NlWNsWsY/M1zgG
   PRU3mHODB1fwS0Nr8STnNANSN1pdMlHu/rcC4roxSHKXHa4cdDLeCJBvO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="285591364"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="285591364"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 15:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="594475987"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2022 15:40:19 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAJ7a-000PCu-CI;
        Sat, 09 Jul 2022 22:40:18 +0000
Date:   Sun, 10 Jul 2022 06:40:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:tip 1/2] arch/x86/kernel/kexec-bzimage64.c:219:19:
 error: 'const struct kimage' has no member named 'ima_buffer_size'
Message-ID: <202207100642.LSXZkwwQ-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tip
head:   532de96923f9c8e0ec456c1b91499327579c2aba
commit: acc53fc31a5e3d990d8241a09438d98b1a6aee1f [1/2] x86/setup: Use rng seeds from setup_data
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220710/202207100642.LSXZkwwQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=acc53fc31a5e3d990d8241a09438d98b1a6aee1f
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random tip
        git checkout acc53fc31a5e3d990d8241a09438d98b1a6aee1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/kexec-bzimage64.c: In function 'setup_ima_state':
>> arch/x86/kernel/kexec-bzimage64.c:219:19: error: 'const struct kimage' has no member named 'ima_buffer_size'
     219 |         if (!image->ima_buffer_size)
         |                   ^~
>> arch/x86/kernel/kexec-bzimage64.c:226:26: error: 'const struct kimage' has no member named 'ima_buffer_addr'
     226 |         ima->addr = image->ima_buffer_addr;
         |                          ^~
   arch/x86/kernel/kexec-bzimage64.c:227:26: error: 'const struct kimage' has no member named 'ima_buffer_size'
     227 |         ima->size = image->ima_buffer_size;
         |                          ^~


vim +219 arch/x86/kernel/kexec-bzimage64.c

6a2c20e7d8900e Vivek Goyal       2014-08-08  209  
b69a2afd5afce9 Jonathan McDowell 2022-06-30  210  static void
b69a2afd5afce9 Jonathan McDowell 2022-06-30  211  setup_ima_state(const struct kimage *image, struct boot_params *params,
b69a2afd5afce9 Jonathan McDowell 2022-06-30  212  		unsigned long params_load_addr,
b69a2afd5afce9 Jonathan McDowell 2022-06-30  213  		unsigned int ima_setup_data_offset)
b69a2afd5afce9 Jonathan McDowell 2022-06-30  214  {
b69a2afd5afce9 Jonathan McDowell 2022-06-30  215  	struct setup_data *sd = (void *)params + ima_setup_data_offset;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  216  	unsigned long setup_data_phys;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  217  	struct ima_setup_data *ima;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  218  
b69a2afd5afce9 Jonathan McDowell 2022-06-30 @219  	if (!image->ima_buffer_size)
b69a2afd5afce9 Jonathan McDowell 2022-06-30  220  		return;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  221  
b69a2afd5afce9 Jonathan McDowell 2022-06-30  222  	sd->type = SETUP_IMA;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  223  	sd->len = sizeof(*ima);
b69a2afd5afce9 Jonathan McDowell 2022-06-30  224  
b69a2afd5afce9 Jonathan McDowell 2022-06-30  225  	ima = (void *)sd + sizeof(struct setup_data);
b69a2afd5afce9 Jonathan McDowell 2022-06-30 @226  	ima->addr = image->ima_buffer_addr;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  227  	ima->size = image->ima_buffer_size;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  228  
b69a2afd5afce9 Jonathan McDowell 2022-06-30  229  	/* Add setup data */
b69a2afd5afce9 Jonathan McDowell 2022-06-30  230  	setup_data_phys = params_load_addr + ima_setup_data_offset;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  231  	sd->next = params->hdr.setup_data;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  232  	params->hdr.setup_data = setup_data_phys;
b69a2afd5afce9 Jonathan McDowell 2022-06-30  233  }
b69a2afd5afce9 Jonathan McDowell 2022-06-30  234  

:::::: The code at line 219 was first introduced by commit
:::::: b69a2afd5afce9bf6d56e349d6ab592c916e20f2 x86/kexec: Carry forward IMA measurement log on kexec

:::::: TO: Jonathan McDowell <noodles@fb.com>
:::::: CC: Borislav Petkov <bp@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
