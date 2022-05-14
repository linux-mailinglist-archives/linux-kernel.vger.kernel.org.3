Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CE5526F2D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiENCwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiENCwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:52:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D023087F0;
        Fri, 13 May 2022 17:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652489737; x=1684025737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ZbrGrP7cxNMuGCiRcEz9C5bHEQF1KFXcDuzuJA6vYk=;
  b=KCp8mPQ3M0wO/XOaTEgnseLz2KyNT75gCdP1Zut3387/TgcqdFThzrUx
   8mnjigj7iXIShV8ncffv9r/ygTH2+TCRrgZ6DQiguTw7vTe7rSbP/7luW
   8m8jwZ1Gq2H4pzF3Wad/Ovffpkjj1XcK1RAcPU37bt/6ixLjUrMUljY0G
   mdZpRZj5ZGw8SWo3NF0rpGb0retLSwGVBECDKVvhUfxrYyDvl2fK0/zPy
   gaeIOm+9cHDX3knqJa18uKYi3YaoYo+dbBLz9EHncmKeas+bLEMfeDpCz
   tMTPk9N4UsH2iZo9W7t9iv/6fKSg5xOtAYW/f5dXxj4VscaYlTR/ExUtx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="268033165"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="268033165"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 17:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="604048939"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 May 2022 17:31:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npfgr-000MFY-Sf;
        Sat, 14 May 2022 00:31:25 +0000
Date:   Sat, 14 May 2022 08:30:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] kbuild: copy scripts/atomic/atomic-*.h to
 include/generated/atomic-*.h
Message-ID: <202205140803.I96fumS7-lkp@intel.com>
References: <20220513185340.239753-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513185340.239753-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on linux/master linus/master v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-copy-scripts-atomic-atomic-h-to-include-generated-atomic-h/20220514-025623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220514/202205140803.I96fumS7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3f6dd60121830fdd3733dd804d9ae163d88acc98
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/kbuild-copy-scripts-atomic-atomic-h-to-include-generated-atomic-h/20220514-025623
        git checkout 3f6dd60121830fdd3733dd804d9ae163d88acc98
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from scripts/mod/devicetable-offsets.c:3:
   In file included from include/linux/mod_devicetable.h:13:
   In file included from include/linux/uuid.h:12:
   In file included from include/linux/string.h:20:
   In file included from arch/x86/include/asm/string.h:5:
   In file included from arch/x86/include/asm/string_64.h:6:
   In file included from include/linux/jump_label.h:256:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:2:10: fatal error: 'generated/atomic-arch-fallback.h' file not found
   #include <generated/atomic-arch-fallback.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[2]: *** [scripts/Makefile.build:121: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +2 include/linux/atomic/atomic-arch-fallback.h

   > 2	#include <generated/atomic-arch-fallback.h>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
