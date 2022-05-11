Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7BC522E43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243593AbiEKIXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243565AbiEKIXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:23:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAFF3CFF7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652257416; x=1683793416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c8yFjI/vXth0xQYdEZ39Vhtg6TjCyTIBFEPXkMzEnQY=;
  b=CpGSE+BCN66znbtnliAe1uFSKo+AXQvW2nN7WH7/92MpUcSLHcg/fe6b
   kn0gqYHLlHUOumCbSKDB6NUa7r9TRYekivw2sFCVQefxtvWzZK8i+Apgl
   MMmTlFQ1/QA8DeF9NQKtGcUBxn43vbnrgoh/68ZPphodu4vjBSI8ivW9i
   CCHkTg10Cx6gG4+d51b/EaZG7DhzUXNRc796JJyR0H5/DRqRcjIUlLuyy
   SXDghSkfu4Fr3uN75HCGjXBJtfyb+xMxHEy5ePO6uVJM9CxTG8T2bKTTo
   4buWglDhnTdJhFvEsnjhN9To5nLXHtHYIEd567Tvdyhb0vVM9bEgTtGoZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="257172418"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="257172418"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 01:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="697474313"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2022 01:23:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nohd8-000ItQ-6R;
        Wed, 11 May 2022 08:23:34 +0000
Date:   Wed, 11 May 2022 16:23:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: {standard input}:1155: Error: operands mismatch -- statement `divu.l
 %d0,%d3:%d7' ignored
Message-ID: <202205111652.rA2Gh5Sy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: 9012d011660ea5cf2a623e1de207a2bc0ca6936d compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
date:   3 years ago
config: m68k-randconfig-r003-20220509 (https://download.01.org/0day-ci/archive/20220511/202205111652.rA2Gh5Sy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9012d011660ea5cf2a623e1de207a2bc0ca6936d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9012d011660ea5cf2a623e1de207a2bc0ca6936d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
   {standard input}:272: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d1,%d3' ignored
   {standard input}:369: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `add.b %d3,%d1' ignored
   {standard input}:505: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d3,%d1' ignored
   {standard input}:609: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a1){%d0,#8},%d0' ignored
   {standard input}:650: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a0){%d1,#8},%d1' ignored
   {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
   {standard input}:752: Error: operands mismatch -- statement `mulu.l 8(%a0),%d2:%d4' ignored
   {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d7:%d6' ignored
   {standard input}:755: Error: operands mismatch -- statement `mulu.l 8(%a0),%d7:%d5' ignored
   {standard input}:765: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxl.l #1,%d0' ignored
   {standard input}:768: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxl.l #1,%d3' ignored
   {standard input}:819: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d0{#0,#32},%d2' ignored
   {standard input}:835: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
   {standard input}:835: Error: operands mismatch -- statement `mulu.l 8(%a0),%d2:%d4' ignored
   {standard input}:835: Error: operands mismatch -- statement `mulu.l 4(%a0),%d7:%d6' ignored
   {standard input}:838: Error: operands mismatch -- statement `mulu.l 8(%a0),%d7:%d5' ignored
   {standard input}:853: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d2{#0,#32},%d0' ignored
   {standard input}:926: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d3{#0,#32},%d2' ignored
   {standard input}:937: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d3{#0,#32},%d0' ignored
   {standard input}:1062: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a0){%d0,#8},%d0' ignored
>> {standard input}:1155: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored
>> {standard input}:1166: Error: operands mismatch -- statement `divu.l %d2,%d4:%d1' ignored
>> {standard input}:1166: Error: operands mismatch -- statement `mulu.l %d1,%d3:%d0' ignored
>> {standard input}:1169: Error: operands mismatch -- statement `mulu.l %d3,%d2:%d7' ignored
>> {standard input}:1174: Error: operands mismatch -- statement `mulu.l 4(%a1),%d0:%d1' ignored
   {standard input}:1211: Error: operands mismatch -- statement `divu.l %d2,%d4:%d1' ignored
   {standard input}:1211: Error: operands mismatch -- statement `mulu.l %d1,%d3:%d0' ignored
   {standard input}:1215: Error: operands mismatch -- statement `mulu.l %d3,%d2:%d7' ignored
   {standard input}:1223: Error: operands mismatch -- statement `mulu.l 4(%a1),%d0:%d1' ignored
   {standard input}:1282: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored
   {standard input}:1293: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d1{#0,#32},%d2' ignored
   {standard input}:1314: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d1{#0,#32},%d2' ignored
   {standard input}:1416: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxr.l #1,%d0' ignored
   {standard input}:1420: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxr.l #1,%d2' ignored
   {standard input}:1425: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxr.l #1,%d0' ignored
   {standard input}:1451: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d0{#0,#32},%d2' ignored
   {standard input}:1461: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d0{#0,#32},%d2' ignored
   {standard input}:1554: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a0){%d0,#8},%d0' ignored
   {standard input}:2057: Error: operands mismatch -- statement `mulu.l %d3,%d3:%d0' ignored
   {standard input}:2269: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a3){%d0,#8},%d0' ignored
   {standard input}:2401: Error: operands mismatch -- statement `divu.l 4(%a4),%d0:%d1' ignored
   {standard input}:2483: Error: operands mismatch -- statement `divu.l %d3,%d0:%d1' ignored
   {standard input}:2585: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a3){%d0,#8},%d0' ignored
   {standard input}:2970: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a3){%d1,#8},%d1' ignored

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for NEED_MULTIPLE_NODES
   Depends on DISCONTIGMEM || NUMA
   Selected by
   - SINGLE_MEMORY_CHUNK && MMU
   WARNING: unmet direct dependencies detected for NEED_MULTIPLE_NODES
   Depends on DISCONTIGMEM || NUMA
   Selected by
   - SINGLE_MEMORY_CHUNK && MMU

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
