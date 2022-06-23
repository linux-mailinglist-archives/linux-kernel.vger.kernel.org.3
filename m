Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA8556F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 02:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiFWAOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFWAOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 20:14:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0243DDE5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655943262; x=1687479262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wv/x0SggOBuMSekTiGHOlSxtbm0NYQUsAzBciXbRuRg=;
  b=NSHOZPrYIh7WIMPX8bBSNDjy7LuymxpVoEXvRIG59RVOahQttOfHEif5
   WK71npDy7KicoS7J8wXMnMM0lWzUHxJYp5giQuFkztBkzhv5+8/vGt9dM
   ChM7RP96DPgoqgzGA5TkB/JdyH1pI43iRlwUzdH885sgvEsoFqsMva+0a
   6XuNFDDG5r/uM/K3Rwc16QUL+yxoYhX7IBS1kB1bLZpUk7J635KBP6h6e
   Z86FLeSBjyKPG8uAVYKoXVIReKczbGMwH1MldrZ+zlbJysUM0ZEcrbDdt
   +41JH+qrhJes2UIZdSxfCwgcG3vKWG2xQXAixkOriMwMlG+khvBaSdqnR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="261014625"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="261014625"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="834382085"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 17:14:20 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4AUG-0001sH-8b;
        Thu, 23 Jun 2022 00:14:20 +0000
Date:   Thu, 23 Jun 2022 08:13:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [ammarfaizi2-block:powerpc/linux/next-test 1/8]
 arch/powerpc/platforms/powermac/setup.c:324:6: warning: no previous
 prototype for 'note_scsi_host'
Message-ID: <202206230832.VJx0qePJ-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block powerpc/linux/next-test
head:   612d6fddf359556217a89c3e42a6c3a6475e2e1d
commit: 113fe88eed53af08800f54a03e463636105831e0 [1/8] powerpc: Don't include asm/setup.h in asm/machdep.h
config: powerpc-randconfig-r016-20220623 (https://download.01.org/0day-ci/archive/20220623/202206230832.VJx0qePJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/113fe88eed53af08800f54a03e463636105831e0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block powerpc/linux/next-test
        git checkout 113fe88eed53af08800f54a03e463636105831e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/powermac/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/platforms/powermac/setup.c:324:6: warning: no previous prototype for 'note_scsi_host' [-Wmissing-prototypes]
     324 | void note_scsi_host(struct device_node *node, void *host)
         |      ^~~~~~~~~~~~~~


vim +/note_scsi_host +324 arch/powerpc/platforms/powermac/setup.c

14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  322  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  323  #ifdef CONFIG_SCSI
405861a0429113f arch/powerpc/platforms/powermac/setup.c      Li Yang        2007-05-23 @324  void note_scsi_host(struct device_node *node, void *host)
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  325  {
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  326  }
9b6b563c0d2d25e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-10-06  327  EXPORT_SYMBOL(note_scsi_host);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  328  #endif
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  329  

:::::: The code at line 324 was first introduced by commit
:::::: 405861a0429113f8e426092af09dd05ec6209410 [POWERPC] Fix Section mismatch warnings

:::::: TO: Li Yang <leoli@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
