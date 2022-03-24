Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9244E68A4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbiCXS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352621AbiCXS25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:28:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F198B7C61
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648146445; x=1679682445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ufK9tZGDIrBNM7JdjRcaZZQj8aetI36gS2Cck1HaZ0U=;
  b=fUYhTNFGAf+gC1JI0Ai85UQJgerT3B5kVxIl+kXQg7+zsnn0OR5Slyll
   wCpGo8lxFPO4zdhKbsxZRm85tcVj+7HBqODZ2tmxu1WyDB+QLpBSVg1fk
   Vuoy3yTRikdq+7OoArxihyToOPd4VdEwRUxB/6F2UYGDJR26pUQSobpFH
   Qx9Siy7/ZChjwnD3F/YB2FiUMLjCEZiAWMqUf7qRP1pKWZXpZSaUuaZNq
   JG+Pu+2xNWgJNMm2PQkjp3D3JqorUw/ITKbT9XfpWEf3NbSrMWsYUqN/L
   uz1GbrT1CLXKc0n5fSQ05oTWe8UR71AYGoW/znBYQLGIzAYzquII7TlHN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="256022493"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="256022493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 11:27:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="501504436"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Mar 2022 11:27:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXSB8-000LJI-NN; Thu, 24 Mar 2022 18:27:22 +0000
Date:   Fri, 25 Mar 2022 02:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     YunQiang Su <yunqiang.su@cipunited.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/uart-16550.c:44:6: warning: no previous
 prototype for function 'putc'
Message-ID: <202203250200.mXHo7XPx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ed4643521e6af8ab8ed1e467630a85884d2696cf
commit: 31b2f3dc851c65fee288612432c4fc956f1a264e MIPS: enable both vmlinux.gz.itb and vmlinuz for generic
date:   3 months ago
config: mips-buildonly-randconfig-r006-20220324 (https://download.01.org/0day-ci/archive/20220325/202203250200.mXHo7XPx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31b2f3dc851c65fee288612432c4fc956f1a264e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 31b2f3dc851c65fee288612432c4fc956f1a264e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/boot/compressed/uart-16550.c:44:6: warning: no previous prototype for function 'putc' [-Wmissing-prototypes]
   void putc(char c)
        ^
   arch/mips/boot/compressed/uart-16550.c:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void putc(char c)
   ^
   static 
   1 warning generated.


vim +/putc +44 arch/mips/boot/compressed/uart-16550.c

1b93b3c3e94be26 Wu Zhangjin 2009-10-14  43  
1b93b3c3e94be26 Wu Zhangjin 2009-10-14 @44  void putc(char c)

:::::: The code at line 44 was first introduced by commit
:::::: 1b93b3c3e94be2605759735a89fc935ba5f58dcf MIPS: Add support for GZIP / BZIP2 / LZMA compressed kernel images

:::::: TO: Wu Zhangjin <wuzhangjin@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
