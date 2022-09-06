Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB25AF0FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiIFQrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiIFQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:46:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EA280025
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662481652; x=1694017652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cNcXjFRx5QCGmuchY23RjmKjohdA9Bi7wgu2eaRP5bU=;
  b=N2TQ7nQv+VoXsT3wQ/zKUflgEDGA7qasrwiNFbsIEAAHCvEWWj5Ax8Hj
   q32JDnac56HVY9VSVVl2hbL+QNoWjqbddRruNnnlJgxU7nVC7FBV6/HT7
   F9Zhvid6ZWVoYnkIJ8C8P7UvD9svbeZSR35pPIciLKlRdDpruAXv2drU1
   fggCFt2otdmBkGWaQxL/ii0volXmce6M6YK3a8gh24iL+j9tyCSEbdPKf
   2Nod8q6Pv1hef/72IbEkgmMyCq7NLWeH/4EKDcqlm1QQ51dPMqilzqDBE
   QIIsDbb5xUOTIqcqQ6rcvhiv9JLAI5XZQm+cApsf60kmXqYEUSopa88G6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283635531"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283635531"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 09:27:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="682455573"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2022 09:27:30 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVbQA-0005KJ-10;
        Tue, 06 Sep 2022 16:27:30 +0000
Date:   Wed, 7 Sep 2022 00:26:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/alternatives/rework 8/9]
 arch/arm64/kernel/alternative.c:267:14: warning: no previous prototype for
 function 'alt_cb_patch_nops'
Message-ID: <202209070048.vOezJs1e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/alternatives/rework
head:   2d5c57125128db8b4934846ad39b00f79cd1637d
commit: 1121255e431de4b5c9a295d6fb6adac10e708534 [8/9] arm64: alternatives: add shared NOP callback
config: arm64-randconfig-r031-20220906 (https://download.01.org/0day-ci/archive/20220907/202209070048.vOezJs1e-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=1121255e431de4b5c9a295d6fb6adac10e708534
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/alternatives/rework
        git checkout 1121255e431de4b5c9a295d6fb6adac10e708534
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:267:14: warning: no previous prototype for function 'alt_cb_patch_nops' [-Wmissing-prototypes]
   noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
                ^
   arch/arm64/kernel/alternative.c:267:9: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
           ^
           static 
   1 warning generated.


vim +/alt_cb_patch_nops +267 arch/arm64/kernel/alternative.c

   266	
 > 267	noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
