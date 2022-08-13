Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F83591976
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiHMImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 04:42:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D007C771
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660380137; x=1691916137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dje4Bwu5WhwsdCPS9deeYtrDdGTX8BgieA63nTu7tK8=;
  b=nV2mJ4f6WhkBciiPs24OR2dppfMnf53TsTjxYJva93XNGOgESGl/meIN
   gWiQCo0SslopLZHWGoDhIdFf6SYwZj0bNAK0gQfx9p9fHdqMRcW9KEon5
   QoC3TzU13WeHXn+HaYg3ORqL8cr8jkeP8BXKQY05VzMjqTlnficPqdD/b
   PmTFPS5iL7Xb3Yzd7/P1jCD6lorxhb6gEGECpF75lUnHPAiozJ3kbwTbv
   dxxZCN34F9/5UCsuCxax7Nzx0cbynuI4KpKe+/xFmsa7PfNjveD4W+wN1
   SVQG0TDuYxogfaA6F5rmexaSqq6Z5f9fMyA6s0uchhGKCDIbpuhskEOuT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355746921"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355746921"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 01:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="602725412"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Aug 2022 01:42:13 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMmij-0001VH-09;
        Sat, 13 Aug 2022 08:42:13 +0000
Date:   Sat, 13 Aug 2022 16:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [stable:linux-5.15.y 5773/9027] <instantiation>:5:8: error: expected
 relocatable expression
Message-ID: <202208131620.5cpNx6DK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
head:   7217df81279835a7aee62a07aabb7b8fb8c766f2
commit: 33db9912ff7c491f839c89a08e98f755aa09598f [5773/9027] ubsan: remove CONFIG_UBSAN_OBJECT_SIZE
config: s390-randconfig-r031-20220812 (https://download.01.org/0day-ci/archive/20220813/202208131620.5cpNx6DK-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=33db9912ff7c491f839c89a08e98f755aa09598f
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.15.y
        git checkout 33db9912ff7c491f839c89a08e98f755aa09598f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   <instantiation>:3:19: error: too many positional arguments
           GR_NUM  b2, 1       /* Base register */
                               ^
   lib/raid6/s390vx8.c:73:16: note: while in macro instantiation
           asm volatile ("VSTM %2,%3,0,1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VSTM 0,7,0,1
           ^
   <instantiation>:3:19: error: too many positional arguments
           GR_NUM  b2, 1       /* Base register */
                               ^
   lib/raid6/s390vx8.c:73:16: note: while in macro instantiation
           asm volatile ("VSTM %2,%3,0,1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VSTM 8,15,0,1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 0,7,0,%r1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 16,23,0,%r1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 16,23,0,%r1
           ^
   <instantiation>:3:19: error: too many positional arguments
           GR_NUM  b2, 1       /* Base register */
                               ^
   lib/raid6/s390vx8.c:73:16: note: while in macro instantiation
           asm volatile ("VSTM %2,%3,0,1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VSTM 16,23,0,1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 16,23,0,%r1
           ^
   <instantiation>:3:19: error: too many positional arguments
           GR_NUM  b2, 1       /* Base register */
                               ^
   lib/raid6/s390vx8.c:73:16: note: while in macro instantiation
           asm volatile ("VSTM %2,%3,0,1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VSTM 16,23,0,1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 0,7,0,%r1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 16,23,0,%r1
           ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   12 warnings and 20 errors generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
