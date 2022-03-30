Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB09B4EBB32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbiC3Gzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiC3Gzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:55:32 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD8DBB08A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648623225; x=1680159225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cm7zalOPVoseD2/NZNf63+7ZwazgOQ0XcSWIJMqTgps=;
  b=CxZgxK6KpvEpx887b2kY117VzxNSLU3aCcdT8Efd5pU/+kF/7HXEhaso
   Z0QroMuJLJ/7OJShV05H4Zyhlwv5IRqe+DiuIUIrqjN34hnUSBB4bCCBL
   +23goAPkTfzyfgOurkqImZn3mG+RMKO14MiETOxUBhWjjFikgQ00f7g6O
   hvUeMIK+auGVJZDHQ6ORSwbCGoL2NbI1TnSL1b/ndyruV9EhVLLIweHi+
   +nBlNZxPBbIbHjxup8jCY4QCbFmSUDJswYXeoJQndkgv3ZQ/y3BwxK7HT
   eFHVtBEJak5V903zPE2bArxW9is2M+FdUjqi4B/DkUJQ55RrjSq6O3WlS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="320161301"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="320161301"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="503198264"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2022 23:53:43 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZSD8-000150-GS; Wed, 30 Mar 2022 06:53:42 +0000
Date:   Wed, 30 Mar 2022 14:53:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Minchan Kim <minchan@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 4036/5872] WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in
 reference from the function memblock_bottom_up() to the variable
 .meminit.data:memblock
Message-ID: <202203301412.MZ7wQvQz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
commit: 0e0bfc41fdf4d79d39ebe929844cdee44f97366d [4036/5872] UPSTREAM: mm: cma: allocate cma areas bottom-up
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220330/202203301412.MZ7wQvQz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/0e0bfc41fdf4d79d39ebe929844cdee44f97366d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 0e0bfc41fdf4d79d39ebe929844cdee44f97366d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
The function memblock_bottom_up() references
the variable __meminitdata memblock.
This is often because memblock_bottom_up lacks a __meminitdata
annotation or the annotation of memblock is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
