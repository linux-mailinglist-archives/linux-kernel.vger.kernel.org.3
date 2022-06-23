Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C5355899C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiFWT4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiFWT4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:56:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7782F661
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656014198; x=1687550198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0VTzvJA0Gl2kb/wPFNFbyrNjSRdnhPyKMdGhL0neyZo=;
  b=IQwhnWfDKIpLzJJBJsyFBHBtQPiEVBJ8h8ZR/Xua31zWcGHzR800NWk2
   Y5ULjgjU9e4PUya9qdrMcULwdTlb01BhVO3CSWsOYzeRXvfFXZJCt/ahV
   x89hGoh7JL8kWX19imNytQukhTQk4LvqQABQLy+MJm/qchGMcKt22HdT2
   yY+ISk7NYsn85sT5gJBmj3GgCeMNbWrf5qcra845w7a6qJ0DRulBPJzbv
   n9qwmd/TBLXHugHmVAdBWcedzoqiqbDkDhmyjXIZw2q0n7nbWuzlS2mjZ
   q4R5/YkYdvKcy3NfoHbw5oDILJNLx4mEWV1Dbr6YjkmgaepWyR/yzQYhX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="278373727"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="278373727"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 12:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="656324211"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2022 12:56:37 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4SwO-00033b-KF;
        Thu, 23 Jun 2022 19:56:36 +0000
Date:   Fri, 24 Jun 2022 03:56:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-compat-alignment-fixups 2/2]
 arch/arm64/kernel/compat_alignment.c:391:5: warning: no previous prototype
 for 'do_compat_alignment_fixup'
Message-ID: <202206240300.IJJqMAVn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-compat-alignment-fixups
head:   16de979d9372710aaa42cd93d3af1e9a43d53369
commit: 16de979d9372710aaa42cd93d3af1e9a43d53369 [2/2] arm64: compat: Implement misalignment fixups for multiword loads
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220624/202206240300.IJJqMAVn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=16de979d9372710aaa42cd93d3af1e9a43d53369
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-compat-alignment-fixups
        git checkout 16de979d9372710aaa42cd93d3af1e9a43d53369
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/compat_alignment.c:391:5: warning: no previous prototype for 'do_compat_alignment_fixup' [-Wmissing-prototypes]
     391 | int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/do_compat_alignment_fixup +391 arch/arm64/kernel/compat_alignment.c

   390	
 > 391	int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
