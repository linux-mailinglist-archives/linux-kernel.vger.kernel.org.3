Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88AE5237E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbiEKP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344129AbiEKPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:55:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B2D9FD7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652284555; x=1683820555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LFcw0j01w3IpEoyEw/QzyrHm8FNlUD6f0jmiMKbeBL0=;
  b=OuLP/s2XrjZg9JHcIjz5E8fGOQatGAWKIitLFCu9MP08HDGKi0DiNXvM
   lVmuLxWenUzUzCIVkIUCA9Yu6wPLJMoqeBlcWnWufqgzUKAJApaUD7MNw
   HQ7ahRd5jpbVmxyvsMS59rBGgntSuMXoPMbySEYIQD7SEzoa83xunjBVQ
   zliY+Hzyxck1JGQhO8GEjMuapECWaOer1FmrJ04IEKIQ4p1TIe6d7WrRY
   y5HAZfuuxlTqrIsT/n82o1Fn+fwfpr5PGo8q4qtAsPYlELtMs3wVe/DNc
   bCngG8C4yo73MRwn7WYG5cltPBRTc10qME6iqGilYSpWT1maZitkRrthu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="250265178"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="250265178"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:55:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="542365197"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 May 2022 08:55:52 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noogq-000JG6-2D;
        Wed, 11 May 2022 15:55:52 +0000
Date:   Wed, 11 May 2022 23:55:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/m68k/math-emu/fp_movem.S:137: Error: scale factor invalid on
 this architecture; needs cpu32 or 68020 or higher -- statement `lea
 (-12,%a1,%d0*8),%a1' ignored
Message-ID: <202205112329.yal6dyLU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: b47c7b6f9f97f3e5596c348bea433ed09cad131d m68k: allow ColdFire m5441x parts to run with MMU enabled
date:   4 years, 6 months ago
config: m68k-buildonly-randconfig-r003-20220511 (https://download.01.org/0day-ci/archive/20220511/202205112329.yal6dyLU-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b47c7b6f9f97f3e5596c348bea433ed09cad131d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b47c7b6f9f97f3e5596c348bea433ed09cad131d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/m68k/math-emu/fp_movem.S: Assembler messages:
   arch/m68k/math-emu/fp_movem.S:54: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#24,#8},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:56: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#25,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:61: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `addq.w #1,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:62: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `lsr.b #1,%d0' ignored
   arch/m68k/math-emu/fp_movem.S:81: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#10,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:81: Error: invalid operand mode for this architecture; needs 68020 or higher -- statement `jmp ([0f:w,%pc,%d0*4])' ignored
   arch/m68k/math-emu/fp_movem.S:90: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:95: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:95: Error: invalid index size for coldfire -- statement `lea (%a0,%d1.w*4),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:95: Error: invalid index size for coldfire -- statement `lea (%a0,%d1.w*8),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:99: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:99: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `neg.w %d1' ignored
   arch/m68k/math-emu/fp_movem.S:99: Error: invalid index size for coldfire -- statement `lea (%a0,%d1.w*4),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:99: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `add.w %d1,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:99: Error: invalid index size for coldfire -- statement `lea (%a0,%d1.w*4),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:105: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:105: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%a1' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%d2' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `add.w %d0,%a1' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#17,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `rol.w #7,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `and.w #3,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#26,#2},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid operand mode for this architecture; needs 68020 or higher -- statement `jmp ([0f:w,%pc,%d0*4])' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesl %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l (%a1),%a1' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#17,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `rol.w #7,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `and.w #3,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `and.w %d2,%d0' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l (%a1),%a1' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#30,#2},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid operand mode for this architecture; needs 68020 or higher -- statement `jmp ([0f:w,%pc,%d0*4])' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:109: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesl %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:113: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:114: Error: invalid operand mode for this architecture; needs 68020 or higher -- statement `jmp ([0f:w,%pc,%d0*4])' ignored
   arch/m68k/math-emu/fp_movem.S:124: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:128: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesl %sp@((48)+4)@(0),%a0' ignored
>> arch/m68k/math-emu/fp_movem.S:137: Error: scale factor invalid on this architecture; needs cpu32 or 68020 or higher -- statement `lea (-12,%a1,%d0*8),%a1' ignored
   arch/m68k/math-emu/fp_movem.S:144: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l (%a0)+,%d2' ignored
   arch/m68k/math-emu/fp_movem.S:147: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `lsr.w #1,%d2' ignored
   arch/m68k/math-emu/fp_movem.S:149: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l (%a0)+,%d2' ignored
   arch/m68k/math-emu/fp_movem.S:151: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l (%a0),%d2' ignored
   arch/m68k/math-emu/fp_movem.S:157: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `lsl.b #1,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:164: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `lsl.w #1,%d2' ignored
   arch/m68k/math-emu/fp_movem.S:167: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l %d2,(%a0)+' ignored
   arch/m68k/math-emu/fp_movem.S:169: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l %d2,(%a0)+' ignored
   arch/m68k/math-emu/fp_movem.S:171: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l %d2,(%a0)' ignored
   arch/m68k/math-emu/fp_movem.S:176: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `lsl.b #1,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:206: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#19,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:210: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `addq.w #1,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:225: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#10,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:225: Error: invalid operand mode for this architecture; needs 68020 or higher -- statement `jmp ([0f:w,%pc,%d0*4])' ignored
   arch/m68k/math-emu/fp_movem.S:233: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:235: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d2{#19,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:236: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.w #19,%d0' ignored
   arch/m68k/math-emu/fp_movem.S:237: Error: byte displacement out of range -- statement `lea ((944+36+96),%a2,%d0.w*4),%a1' ignored
   arch/m68k/math-emu/fp_movem.S:249: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:261: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:265: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:265: Error: invalid index size for coldfire -- statement `lea (%a0,%d1.w*4),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:269: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:269: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `neg.w %d1' ignored
   arch/m68k/math-emu/fp_movem.S:269: Error: invalid index size for coldfire -- statement `lea (%a0,%d1.w*4),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:273: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:273: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%a1' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%d2' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `add.w %d0,%a1' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#17,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `rol.w #7,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `and.w #3,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#26,#2},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid operand mode for this architecture; needs 68020 or higher -- statement `jmp ([0f:w,%pc,%d0*4])' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesl %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l (%a1),%a1' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#17,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `rol.w #7,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `and.w #3,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `and.w %d2,%d0' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l (%a1),%a1' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#30,#2},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid operand mode for this architecture; needs 68020 or higher -- statement `jmp ([0f:w,%pc,%d0*4])' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:277: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesl %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:281: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu %d2{#13,#3},%d0' ignored
   arch/m68k/math-emu/fp_movem.S:282: Error: invalid operand mode for this architecture; needs 68020 or higher -- statement `jmp ([0f:w,%pc,%d0*4])' ignored
   arch/m68k/math-emu/fp_movem.S:292: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesw %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:296: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `movesl %sp@((48)+4)@(0),%a0' ignored
   arch/m68k/math-emu/fp_movem.S:301: Error: invalid index size for coldfire -- statement `lea (%a0,%d1.w*4),%a1' ignored
   arch/m68k/math-emu/fp_movem.S:328: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l (%a0)+,%d0' ignored
   arch/m68k/math-emu/fp_movem.S:331: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `lsl.b #1,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:339: Error: invalid instruction for this architecture; needs 68010 or higher (68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `moves.l %d0,(%a0)+' ignored
   arch/m68k/math-emu/fp_movem.S:341: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `lsl.b #1,%d1' ignored
   arch/m68k/math-emu/fp_movem.S:346: Error: operands mismatch -- statement `and.l #0x0000fff0,((944+36+96),%a2)' ignored
   arch/m68k/math-emu/fp_movem.S:347: Error: operands mismatch -- statement `and.l #0x0ffffff8,((944+36+100),%a2)' ignored


vim +137 arch/m68k/math-emu/fp_movem.S

^1da177e4c3f41 Linus Torvalds 2005-04-16  130  
^1da177e4c3f41 Linus Torvalds 2005-04-16  131  fpr_do_movem:
^1da177e4c3f41 Linus Torvalds 2005-04-16  132  	swap	%d1			| get fpu register list
^1da177e4c3f41 Linus Torvalds 2005-04-16  133  	lea	(FPD_FPREG,FPDATA),%a1
^1da177e4c3f41 Linus Torvalds 2005-04-16  134  	moveq	#12,%d0
^1da177e4c3f41 Linus Torvalds 2005-04-16  135  	btst	#12,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  136  	jne	1f
^1da177e4c3f41 Linus Torvalds 2005-04-16 @137  	lea	(-12,%a1,%d0*8),%a1
^1da177e4c3f41 Linus Torvalds 2005-04-16  138  	neg.l	%d0
^1da177e4c3f41 Linus Torvalds 2005-04-16  139  1:	btst	#13,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  140  	jne	4f
^1da177e4c3f41 Linus Torvalds 2005-04-16  141  	| move register from memory into fpu
^1da177e4c3f41 Linus Torvalds 2005-04-16  142  	jra	3f
^1da177e4c3f41 Linus Torvalds 2005-04-16  143  1:	printf	PMOVEM,"(%p>%p)",2,%a0,%a1
^1da177e4c3f41 Linus Torvalds 2005-04-16  144  	getuser.l (%a0)+,%d2,fp_err_ua1,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  145  	lsr.l	#8,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  146  	lsr.l	#7,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  147  	lsr.w	#1,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  148  	move.l	%d2,(%a1)+
^1da177e4c3f41 Linus Torvalds 2005-04-16  149  	getuser.l (%a0)+,%d2,fp_err_ua1,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  150  	move.l	%d2,(%a1)+
^1da177e4c3f41 Linus Torvalds 2005-04-16  151  	getuser.l (%a0),%d2,fp_err_ua1,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  152  	move.l	%d2,(%a1)
^1da177e4c3f41 Linus Torvalds 2005-04-16  153  	subq.l	#8,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  154  	subq.l	#8,%a1
^1da177e4c3f41 Linus Torvalds 2005-04-16  155  	add.l	%d0,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  156  2:	add.l	%d0,%a1
^1da177e4c3f41 Linus Torvalds 2005-04-16  157  3:	lsl.b	#1,%d1
^1da177e4c3f41 Linus Torvalds 2005-04-16  158  	jcs	1b
^1da177e4c3f41 Linus Torvalds 2005-04-16  159  	jne	2b
^1da177e4c3f41 Linus Torvalds 2005-04-16  160  	jra	5f
^1da177e4c3f41 Linus Torvalds 2005-04-16  161  	| move register from fpu into memory
^1da177e4c3f41 Linus Torvalds 2005-04-16  162  1:	printf	PMOVEM,"(%p>%p)",2,%a1,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  163  	move.l	(%a1)+,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  164  	lsl.w	#1,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  165  	lsl.l	#7,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  166  	lsl.l	#8,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  167  	putuser.l %d2,(%a0)+,fp_err_ua1,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  168  	move.l	(%a1)+,%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  169  	putuser.l %d2,(%a0)+,fp_err_ua1,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  170  	move.l	(%a1),%d2
^1da177e4c3f41 Linus Torvalds 2005-04-16  171  	putuser.l %d2,(%a0),fp_err_ua1,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  172  	subq.l	#8,%a1
^1da177e4c3f41 Linus Torvalds 2005-04-16  173  	subq.l	#8,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  174  	add.l	%d0,%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  175  2:	add.l	%d0,%a1
^1da177e4c3f41 Linus Torvalds 2005-04-16  176  4:	lsl.b	#1,%d1
^1da177e4c3f41 Linus Torvalds 2005-04-16  177  	jcs	1b
^1da177e4c3f41 Linus Torvalds 2005-04-16  178  	jne	2b
^1da177e4c3f41 Linus Torvalds 2005-04-16  179  5:
^1da177e4c3f41 Linus Torvalds 2005-04-16  180  	printf	PDECODE,"\n"
^1da177e4c3f41 Linus Torvalds 2005-04-16  181  #if 0
^1da177e4c3f41 Linus Torvalds 2005-04-16  182  	lea	(FPD_FPREG,FPDATA),%a0
^1da177e4c3f41 Linus Torvalds 2005-04-16  183  	printf	PMOVEM,"fp:"
^1da177e4c3f41 Linus Torvalds 2005-04-16  184  	printx	PMOVEM,%a0@(0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  185  	printx	PMOVEM,%a0@(12)
^1da177e4c3f41 Linus Torvalds 2005-04-16  186  	printf	PMOVEM,"\n   "
^1da177e4c3f41 Linus Torvalds 2005-04-16  187  	printx	PMOVEM,%a0@(24)
^1da177e4c3f41 Linus Torvalds 2005-04-16  188  	printx	PMOVEM,%a0@(36)
^1da177e4c3f41 Linus Torvalds 2005-04-16  189  	printf	PMOVEM,"\n   "
^1da177e4c3f41 Linus Torvalds 2005-04-16  190  	printx	PMOVEM,%a0@(48)
^1da177e4c3f41 Linus Torvalds 2005-04-16  191  	printx	PMOVEM,%a0@(60)
^1da177e4c3f41 Linus Torvalds 2005-04-16  192  	printf	PMOVEM,"\n   "
^1da177e4c3f41 Linus Torvalds 2005-04-16  193  	printx	PMOVEM,%a0@(72)
^1da177e4c3f41 Linus Torvalds 2005-04-16  194  	printx	PMOVEM,%a0@(84)
^1da177e4c3f41 Linus Torvalds 2005-04-16  195  	printf	PMOVEM,"\n"
^1da177e4c3f41 Linus Torvalds 2005-04-16  196  #endif
^1da177e4c3f41 Linus Torvalds 2005-04-16  197  	jra	fp_end
^1da177e4c3f41 Linus Torvalds 2005-04-16  198  

:::::: The code at line 137 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
