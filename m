Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5FC47D291
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbhLVNAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:00:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:3847 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245117AbhLVNAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640178044; x=1671714044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xdmrSRTYKfyydf1mkoVn3w/fix+3qP0dG8Soyz55F98=;
  b=ZZVAx8Xpe4bvE4yoW4YOo3zYXN85kOCFegqDFicLmllFP7VQcNNmdh3y
   R8RLtEgHfhWUJTkVJSwWV+w8wScY5xcYsuorT+0WMtUCpRZaTfLEw0KVX
   AhLdSKo8nNZ3sxAwK7y55uDrbtfqpt2nUjYbwbPU9uYXQr/xe43ViAqHm
   c22qWq2wKp4ZIicAQ2WaHYjrPl4XEZB84Tokq3Ra98Kd8HvthegKyQO/p
   3YpCsYTdHaLNKhac6BySWEhfvNf+bXh+DYJdn42Y5RdYRF67Jxj+bycIe
   uHrmXFCzm7AH0pA02Yplwvn7qmTbHOk6PgLj1xLdHN5pf0iwjb65B+oW6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="221288025"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="221288025"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 05:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="617127026"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Dec 2021 05:00:42 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n01EY-0000SL-28; Wed, 22 Dec 2021 13:00:42 +0000
Date:   Wed, 22 Dec 2021 21:00:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: sound/pci/hda/patch_realtek.c:886:20: warning: unused function
 'alc_shutup'
Message-ID: <202112222030.pe8E3Bq0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f47a9a4dfa3674fad19a49b40c5103a9a8e1589
commit: 327b34f2a97d72c41d4854d61336c9ae6ffe4a44 ALSA: hda: Nuke unused reboot_notify callback
date:   4 months ago
config: mips-buildonly-randconfig-r003-20211222 (https://download.01.org/0day-ci/archive/20211222/202112222030.pe8E3Bq0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=327b34f2a97d72c41d4854d61336c9ae6ffe4a44
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 327b34f2a97d72c41d4854d61336c9ae6ffe4a44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/ sound/pci/hda/

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
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-de4e0195ae/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers fs include kernel mm nr_bisected scripts sound source usr


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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
