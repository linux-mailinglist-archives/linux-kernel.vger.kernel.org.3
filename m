Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4354ADEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbiFNKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiFNKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:05:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644AC24BFC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655201126; x=1686737126;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dsgoiB8XvqF52CKdoeF1VABZ0d80s1a4cxLSoNWEjEY=;
  b=QXYlxEmwgCFG+h4ApD5MOVVGXmL8pLltOGadaFN9arsPZZYysUIO+CYG
   aldsuS/cr4L0Fia29w2NjClqhPVan2LHL0Qcb+U+uGBSGWprVcbT68uVZ
   qDcckF60x5bmYmeiqHh5D1hqe/lOT4WcZcdlvRW1nU3bLGl1hXGLPXm1R
   76CYTdFSXQwTrIVfZY4qiJMvuiEtfzrgOUSGPh8Dnh5+8tO49ElHK6sBo
   tGolSILl4jdCi0JW+RHw2tHAehVnXuDyPnw4GAGw2+wmNRPDqo/eqVi1R
   SnzlHblyHV1VAeVQ43xsC4EtBhp6bhQTv1kzPFhh7XbyrG7xQuJ9VqtKa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364909526"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="364909526"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 03:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640282144"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2022 03:05:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o13QK-000LlS-G7;
        Tue, 14 Jun 2022 10:05:24 +0000
Date:   Tue, 14 Jun 2022 18:04:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 23/33]
 arch/microblaze/include/asm/page.h:130: Error: junk at end of line, first
 unrecognized character is `{'
Message-ID: <202206141700.Z7jYs3Rm-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   62fa3e7c2288a1f8d5b9bb2c1f31cee3c26df806
commit: ff24dffbd3b9ca146bea98a2f4b76042e03267c9 [23/33] microblaze: Make virt_to_pfn() a static inline
config: microblaze-randconfig-r003-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141700.Z7jYs3Rm-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=ff24dffbd3b9ca146bea98a2f4b76042e03267c9
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout ff24dffbd3b9ca146bea98a2f4b76042e03267c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/microblaze/include/asm/page.h: Assembler messages:
   arch/microblaze/include/asm/page.h:129: Error: unknown opcode "static"
>> arch/microblaze/include/asm/page.h:130: Error: junk at end of line, first unrecognized character is `{'
   arch/microblaze/include/asm/page.h:131: Error: unknown opcode "return"
   arch/microblaze/include/asm/page.h:132: Error: junk at end of line, first unrecognized character is `}'


vim +130 arch/microblaze/include/asm/page.h

   128	
   129	static inline unsigned long virt_to_pfn(const void *vaddr)
 > 130	{
   131		return phys_to_pfn(__pa(vaddr));
   132	}
   133	# define pfn_to_virt(pfn)	__va(pfn_to_phys((pfn)))
   134	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
