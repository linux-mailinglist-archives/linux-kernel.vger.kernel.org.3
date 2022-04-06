Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BCF4F6DBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiDFWM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiDFWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:12:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78062DAFD5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649283055; x=1680819055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1IAaiWw79qdN3EyKUVMdF1kajhzc7akfzw8AsZvioLU=;
  b=KSbJ6hyUsysZCsP6vmtS4HbIiKpSkw08aK0TAHcnE7ux9XklXiu5hNlE
   pwKW64RrileNMZsLq0IxjwIrLgSdr8oaSL0PX+F835hhB83BGr//i9REU
   whVBXnu4vIiEJjck90KtQMbdBzZMCdqd0T9CzWbfhrFbv8BDl7G0hYynk
   iLjhVYl6BW3Id8Co6wjg7rYVDTITOL6oF6XaD5Tr6LBsQJ1hT2FLZvfA+
   1uvHDxtLE1tt9HCpEJ5G13A5GHN9N64FhH/4OudVLVcfhWoaBPXrWQQLn
   EyE0Y7YSDXoakJF0l4B4E6VfK0RQUq+RQMCZe90sdEHaSzvaHBgPj1iZc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="286140368"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="286140368"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="524657287"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2022 15:10:53 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncDrY-0004nz-K6;
        Wed, 06 Apr 2022 22:10:52 +0000
Date:   Thu, 7 Apr 2022 06:09:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-apple-aic.c:181:1: sparse: sparse: symbol
 'use_fast_ipi' was not declared. Should it be static?
Message-ID: <202204070633.vRp7MVoj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e732ebf7316ac83e8562db7e64cc68aec390a18
commit: 2cf68211664acd2e4bdd1fb66697137b30901981 irqchip/apple-aic: Add Fast IPI support
date:   4 weeks ago
config: arm64-randconfig-s032-20220406 (https://download.01.org/0day-ci/archive/20220407/202204070633.vRp7MVoj-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2cf68211664acd2e4bdd1fb66697137b30901981
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2cf68211664acd2e4bdd1fb66697137b30901981
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/ drivers/remoteproc/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-apple-aic.c:181:1: sparse: sparse: symbol 'use_fast_ipi' was not declared. Should it be static?

vim +/use_fast_ipi +181 drivers/irqchip/irq-apple-aic.c

 > 181	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
