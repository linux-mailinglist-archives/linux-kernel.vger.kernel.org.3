Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AE54E3102
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352871AbiCUUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiCUUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:03:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7485850B33
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647892894; x=1679428894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cNo0jptrH7A1z6MbWEF0PmuWlYaPNWNxRipYv7rH21k=;
  b=NG30+/1D0fnLGEm6NdRqfZ0dejJzhA8SpNm+a2XkIh5ClOuFzI1VJOWk
   2XAOkai/cACVRWwlgadKDYt8sMkGSuppmSCo/Ak3bBMhiiA6VGsq3+IDZ
   +aKqiAEZH9oI4VhTIQ6a3FT2T36IONGCdmFVjz9enhol+r9VqF5xdZKCw
   KntjbWTurziaUVRufkMMq8ch9lmKhuF6jt57MWYUtwebVPSK1kpPE2fwR
   tkXrefi1rdR8mr/yOOTx1XgE+lXxFdvwO8ikxoq2eOae59O8tyEasDB/j
   LKmMYidtBvY96v7L+0ry14AYfnJpXN+SvhoVPXaE7yScET8lni8rImOS8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="320840910"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="320840910"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 13:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="543363892"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Mar 2022 13:01:32 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWODb-000I6o-P4; Mon, 21 Mar 2022 20:01:31 +0000
Date:   Tue, 22 Mar 2022 04:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: sound/pci/ca0106/ca0106.h:62:9: warning: 'PTR' macro redefined
Message-ID: <202203220433.6STDC254-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f443e374ae131c168a065ea1748feac6b2e76613
commit: f0b7ddbd794bdffade370f22bb7a774002208ef4 MIPS: retire "asm/llsc.h"
date:   3 months ago
config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20220322/202203220433.6STDC254-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f0b7ddbd794bdffade370f22bb7a774002208ef4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f0b7ddbd794bdffade370f22bb7a774002208ef4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash sound/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from sound/pci/ca0106/ca0106_main.c:156:
>> sound/pci/ca0106/ca0106.h:62:9: warning: 'PTR' macro redefined [-Wmacro-redefined]
   #define PTR                     0x00            /* Indexed register set pointer register        */
           ^
   arch/mips/include/asm/asm.h:288:9: note: previous definition is here
   #define PTR             .word
           ^
   1 warning generated.


vim +/PTR +62 sound/pci/ca0106/ca0106.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  61  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @62  #define PTR			0x00		/* Indexed register set pointer register	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  63  						/* NOTE: The CHANNELNUM and ADDRESS words can	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  64  						/* be modified independently of each other.	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  65  						/* CNL[1:0], ADDR[27:16]                        */
^1da177e4c3f41 Linus Torvalds 2005-04-16  66  

:::::: The code at line 62 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
