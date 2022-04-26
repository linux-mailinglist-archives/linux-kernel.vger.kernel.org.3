Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D650FC31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349644AbiDZLsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiDZLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:48:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3738A2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650973505; x=1682509505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6hJbZFcBpw7ynGE4LfFl0OhmDBYgY8WNxZLYB5+VIVo=;
  b=OwJLbW3pMbzH7sLjV9gOitPbfDMcw5ParTanDV9ULzpyXOfjcwHALc6N
   lPi2VbQU2r+8H7YJwI5jwGVEzFcbJ8fRYP/y0GehKShl9o5oYmvek6a5d
   VVe2949byAcgITfxgFpGDkTvEHvMmcXttRZSQMPN3Zmj8Z1/pPpuSmsT8
   kJ48+KlsA0wDXO8C/lKX4MNWwaUuGo8O4g1I5cX2SXTVS+6OggsiqnrlE
   QtK5NbOzZ8aadrzw6PdLHGXhQgrYzqSGW1h+6C0HAdjuG0fXjY/qHEXli
   N1TUKVOAVv4GT9UYy6I2i+EA4+/ZbDBWCgtVlOYCW/JkEZyRaPcSPtZhw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="263144561"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="263144561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 04:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="616960293"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Apr 2022 04:45:03 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njJct-0003VC-7c;
        Tue, 26 Apr 2022 11:45:03 +0000
Date:   Tue, 26 Apr 2022 19:44:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: sound/pci/hda/patch_realtek.c:886:20: warning: unused function
 'alc_shutup'
Message-ID: <202204261914.HwEctUql-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d615b5416f8a1afeb82d13b238f8152c572d59c0
commit: 327b34f2a97d72c41d4854d61336c9ae6ffe4a44 ALSA: hda: Nuke unused reboot_notify callback
date:   9 months ago
config: mips-randconfig-r003-20220426 (https://download.01.org/0day-ci/archive/20220426/202204261914.HwEctUql-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=327b34f2a97d72c41d4854d61336c9ae6ffe4a44
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 327b34f2a97d72c41d4854d61336c9ae6ffe4a44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/crypto/ sound/pci/hda/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/pci/hda/patch_realtek.c:886:20: warning: unused function 'alc_shutup'
   static inline void alc_shutup(struct hda_codec
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/bitops.h", .line = 105, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   or $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-15: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-1cddcfdc3c/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers include kernel nr_bisected scripts sound source usr


vim +/alc_shutup +886 sound/pci/hda/patch_realtek.c

a361d84bfcd938 Kailang Yang 2007-06-05  885  
08c189f2c5523e Takashi Iwai 2012-12-19 @886  static inline void alc_shutup(struct hda_codec *codec)
a361d84bfcd938 Kailang Yang 2007-06-05  887  {
1d045db96ad9b8 Takashi Iwai 2011-07-07  888  	struct alc_spec *spec = codec->spec;
a361d84bfcd938 Kailang Yang 2007-06-05  889  
c7273bd6c1922a Takashi Iwai 2018-06-12  890  	if (!snd_hda_get_bool_hint(codec, "shutup"))
c7273bd6c1922a Takashi Iwai 2018-06-12  891  		return; /* disabled explicitly by hints */
c7273bd6c1922a Takashi Iwai 2018-06-12  892  
08c189f2c5523e Takashi Iwai 2012-12-19  893  	if (spec && spec->shutup)
08c189f2c5523e Takashi Iwai 2012-12-19  894  		spec->shutup(codec);
9bfb2844a2f9e6 Takashi Iwai 2013-07-24  895  	else
c0ca5eced22215 Takashi Iwai 2019-02-20  896  		alc_shutup_pins(codec);
1d045db96ad9b8 Takashi Iwai 2011-07-07  897  }
1f0f4b8036b1fe Takashi Iwai 2011-06-27  898  

:::::: The code at line 886 was first introduced by commit
:::::: 08c189f2c5523eda847cddb89eb8f44c0b957431 ALSA: hda - Use generic parser codes for Realtek driver

:::::: TO: Takashi Iwai <tiwai@suse.de>
:::::: CC: Takashi Iwai <tiwai@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
