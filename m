Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE35809D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbiGZDOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiGZDOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:14:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400E2A270
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658805271; x=1690341271;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hyS8F4+I4RY/4rYRz7tUgKWmAGM8MQqI0BySA/jeO9Q=;
  b=BtSRf2Fftn21Cc8cuE2y2bEfJSGpMcGhSSEk4nxDCpTTgnZnN5tE+CzY
   aPpl72pxPdjX/aKCCUWQAMgzLiXoC0aHIAjEbZ6tr15j5TifEjkKSqIk3
   hT3AtQSfh+sZMB0vChkYHa40pMYnYiIPzUDvVcbg8k9ywBB8wnzW77aA4
   rT/uQkS1wRaMy+OggoyYqFJcM/f9Rdv1IGYHDbbjmL3HuP0Ie2XDxs073
   Q15+dAYbeHw1jKeK92zIdmC+f1BcyXN/fhxF643Dl6B9rkCn8kxY3ReCd
   ehbZmSSv01zp7CUcHlPNw79GkV2UqkbXp+Y3R05b/2hT7M2GJ1GtK4R9W
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="267617915"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="267617915"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 20:14:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575313106"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2022 20:14:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGB1h-0005v2-0L;
        Tue, 26 Jul 2022 03:14:29 +0000
Date:   Tue, 26 Jul 2022 11:14:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: {standard input}:19: Error: unrecognized opcode: `iccci'
Message-ID: <202207261146.BmW3AhRs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: de39b19452e784de5f90ae899851ab29a29bb42c powerpc: Rewrite 4xx flush_cache_instruction() in C
date:   1 year, 11 months ago
config: powerpc-klondike_defconfig (https://download.01.org/0day-ci/archive/20220726/202207261146.BmW3AhRs-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de39b19452e784de5f90ae899851ab29a29bb42c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout de39b19452e784de5f90ae899851ab29a29bb42c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:19: Error: unrecognized opcode: `iccci'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
