Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF855F39A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiF2CxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiF2Cw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:52:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F6A33E2E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 19:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656471170; x=1688007170;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Peyu7ZRX4ch03zpq+DdistMLsdoqCn76LTkgdA3JSNw=;
  b=RHZPofeqvlxxw4P3JvS6+oSeG1qr5WTbIeHt68MPbbmiABVl7/QzgC0s
   I3J+hz0qNPYCXnvgbJRS1NS5hmfRfZwks7jm2YwPvqZtqKg2GkxmUYpnl
   Eb0MvT1uO7PhPJKIV0KKpkFVMdoJh02FO5T/Ht5JKXqZN7jpVHhRzTpNf
   MvXwpEicnBUWp+ibf5LGeYQVDXa3oGZBb0Q69180cPeedNFhL4v66Dppr
   YDmaUgcjmJxnnKBjiCgWpCRAICLqpdNCQdapf9eI0kkFBQQo4BzR8kjLL
   ygUPihxKup30r1kgjYILkfeb76KmQ1t7OWvqG12+XGBn8VL0gTKUPuDRg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281938887"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="281938887"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 19:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="693377988"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2022 19:52:45 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6Noq-000Aqc-QG;
        Wed, 29 Jun 2022 02:52:44 +0000
Date:   Wed, 29 Jun 2022 10:52:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@suse.de>, Mimi Zohar <zohar@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: [tip:x86/kdump 1/1] WARNING: modpost: vmlinux.o(.text+0x1e7210c):
 Section mismatch in reference from the function ima_free_kexec_buffer() to
 the function .meminit.text:memblock_phys_free()
Message-ID: <202206291039.yGgljGbx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/kdump
head:   69243968bd526641e549ed231c750ce92e3eeb35
commit: 69243968bd526641e549ed231c750ce92e3eeb35 [1/1] x86/kexec: Carry forward IMA measurement log on kexec
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220629/202206291039.yGgljGbx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project df18167ac56d05f2ab55f9d874aee7ab6d5bc9a2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=69243968bd526641e549ed231c750ce92e3eeb35
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/kdump
        git checkout 69243968bd526641e549ed231c750ce92e3eeb35
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x1e7210c): Section mismatch in reference from the function ima_free_kexec_buffer() to the function .meminit.text:memblock_phys_free()
The function ima_free_kexec_buffer() references
the function __meminit memblock_phys_free().
This is often because ima_free_kexec_buffer lacks a __meminit
annotation or the annotation of memblock_phys_free is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
