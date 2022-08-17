Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4D596B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiHQIO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiHQIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F109356C2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724067; x=1692260067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xA3pyXfIFhFP4Vu6qdyg1TVHtuRZcvgrznJgmVfN9v4=;
  b=jp3UELyZWp/4f5U2UdL5qCTvP02nOZ9OXplAIcI2K5UDh8WetKctF/Cv
   IsdSQYVYhtyEQUVIt9ZSbB3dAkgSWz/7H71HUMdlZh7ZF7x4Xs6lmmR0S
   uwcIMsyNNkNxR+UJxio4xUPVyCHJFrwvA/9wOsHDugZGvemuS1RRp6DG1
   jmtocp9gbLsZotes+vMK2ZyFOG/NCJg0AgW45CXp+loVtXGFJyIh+7qTc
   X+I9D/SoOceTv9O9ERTfwqWjLQgg/EO8bUeLqPC8EWWMR1+1nGjTjAtUw
   5Snm4h40EXYV40Sl1R8NGpkNJGMvwJlGqKJoSK3h0C/JBvyhj2OFCFheA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272202848"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272202848"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="696689612"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2022 01:14:15 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOEBq-0000j2-1E;
        Wed, 17 Aug 2022 08:14:14 +0000
Date:   Wed, 17 Aug 2022 16:13:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-unaccepted-memory 11/14] ld.lld: error: undefined
 symbol: arch_kexec_load
Message-ID: <202208171435.ZwLactew-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-unaccepted-memory
head:   86fb61d5824802e1b7c4c8eb1b34029024f52ee6
commit: 820c5c338451079677510d4183ba5d5dc314c030 [11/14] x86: Disable kexec if system has unaccepted memory
config: x86_64-randconfig-a015-20220815 (https://download.01.org/0day-ci/archive/20220817/202208171435.ZwLactew-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/820c5c338451079677510d4183ba5d5dc314c030
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-unaccepted-memory
        git checkout 820c5c338451079677510d4183ba5d5dc314c030
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: arch_kexec_load
   >>> referenced by kexec.c:198 (kernel/kexec.c:198)
   >>>               vmlinux.o:(__x64_sys_kexec_load)
   >>> referenced by kexec_file.c:332 (kernel/kexec_file.c:332)
   >>>               vmlinux.o:(__x64_sys_kexec_file_load)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
