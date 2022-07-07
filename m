Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD256A066
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiGGKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGGKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:50:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE96C5721E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657191040; x=1688727040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IFN87Xx6xcn5JCKm3HPm2UfjNx08/PG7zuzmWutpQCo=;
  b=dNUtpHu/kvlizfzsUptvJ0fhNTQ1nNaeimpKlqVl7KLzDqcMSiqjHPal
   Ag+WHdNHeXuw9rScT90vlVR3xyYgNF4pk5LsGp4whC0jbOrHDs9GLIVAJ
   tmrGa1W2m74ru2zZe3zOMA2he3mEWeB1DufOIvbV06lMUb9DQk83SJzLe
   pJVGnXAymSaH6MHnkskW5sqd/InP8aPC51ngUGyL+4POe2Ae+6GkfTQO5
   ELHHhlPM+t9E4OhyCkUNy2xrxsJr/bXXvXfIAwk1dR5eiHoSWs2iZrIVI
   qCKxpwQ6s5nevu3psu28Asu1GmFwR9ftk1g6JGHaUJZ7fBo61kW/hJdi3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="281542505"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="281542505"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 03:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="620742386"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2022 03:50:39 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9P5i-000Lti-NO;
        Thu, 07 Jul 2022 10:50:38 +0000
Date:   Thu, 7 Jul 2022 18:50:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/kernel/irq.c:51:12: sparse: sparse: symbol
 '__pcpu_scope_irq_stack_ptr' was not declared. Should it be static?
Message-ID: <202207071821.c9MBQzRh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f09069cde34dcd86f5ecf3a3139fd752020812f
commit: cafc0eab168917ec9c0cd47d530a40cd40eb2928 ARM: v7m: enable support for IRQ stacks
date:   7 months ago
config: arm-randconfig-s032-20220707 (https://download.01.org/0day-ci/archive/20220707/202207071821.c9MBQzRh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cafc0eab168917ec9c0cd47d530a40cd40eb2928
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cafc0eab168917ec9c0cd47d530a40cd40eb2928
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ drivers/clk/qcom/ drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm/kernel/irq.c:51:12: sparse: sparse: symbol '__pcpu_scope_irq_stack_ptr' was not declared. Should it be static?

vim +/__pcpu_scope_irq_stack_ptr +51 arch/arm/kernel/irq.c

d4664b6c987f803 Ard Biesheuvel 2021-10-05  50  
d4664b6c987f803 Ard Biesheuvel 2021-10-05 @51  asmlinkage DEFINE_PER_CPU_READ_MOSTLY(u8 *, irq_stack_ptr);
d4664b6c987f803 Ard Biesheuvel 2021-10-05  52  

:::::: The code at line 51 was first introduced by commit
:::::: d4664b6c987f80338407889c1e3f3abe7e16be94 ARM: implement IRQ stacks

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
