Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586C350EDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbiDZApK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiDZApH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:45:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C5B66AC9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650933722; x=1682469722;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MMbvmHnyHTi+LwuQwDlkQnBVChKjFO2/kj4vi/wOjKU=;
  b=iWfpqVdjYMpfGcKLJvi5ZHAIHohSfW2yiTSmbRV0JQYaNJdq3T3CHsEh
   hLz1M9liG8Huid48XamDg4FOjBxr3ugu8zJafRzoP+in/pyxcDzM2ND7q
   LYce9xzflzpEynLwrx4xf8n5lKLlHU/lGGl8c/nynl1UzqdCg4j0dj2BT
   kF1KDUw0SLLFF2xyUgaaFzlKSUu+6cOa4rn/UVUAXQGhjbhWNO+L6MDrj
   DHFopNVF9f7X9MDFDwGHJjj/NBfgxyOaNh6Hn58pJIV95EAodCIcFsZuN
   9ddCd7bL570PIVcISvNdeluJgiarULKHO/rJ6H6XZwuLnTpCusMCWbY+5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264925804"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="264925804"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 17:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="512888381"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Apr 2022 17:42:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj9HD-00034A-FU;
        Tue, 26 Apr 2022 00:41:59 +0000
Date:   Tue, 26 Apr 2022 08:41:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergey Matyukevich <sergey.matyukevich@synopsys.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>
Subject: [vgupta-arc:for-next 3/4] arch/arc/kernel/disasm.c:494:23: error:
 'struct pt_regs' has no member named 'gp'; did you mean 'fp'?
Message-ID: <202204260826.d9fdltJm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git for-next
head:   e88856183749fd59759cd4c617f9ecec8280d8fa
commit: b08a66fb680018b621fd8be641c537c625132ab3 [3/4] ARC: disasm: handle ARCv2 case in kprobe get/set functions
config: arc-randconfig-r012-20220425 (https://download.01.org/0day-ci/archive/20220426/202204260826.d9fdltJm-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/commit/?id=b08a66fb680018b621fd8be641c537c625132ab3
        git remote add vgupta-arc https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git
        git fetch --no-tags vgupta-arc for-next
        git checkout b08a66fb680018b621fd8be641c537c625132ab3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arc/kernel/disasm.c: In function 'disasm_instr':
   arch/arc/kernel/disasm.c:28:19: warning: variable 'ins_ptr' set but not used [-Wunused-but-set-variable]
      28 |         uint16_t *ins_ptr;
         |                   ^~~~~~~
   arch/arc/kernel/disasm.c: In function 'set_reg':
>> arch/arc/kernel/disasm.c:494:23: error: 'struct pt_regs' has no member named 'gp'; did you mean 'fp'?
     494 |                 regs->gp = val;
         |                       ^~
         |                       fp


vim +494 arch/arc/kernel/disasm.c

   475	
   476	void __kprobes set_reg(int reg, long val, struct pt_regs *regs,
   477			struct callee_regs *cregs)
   478	{
   479		long *p;
   480	
   481	#if defined(CONFIG_ISA_ARCOMPACT)
   482		switch (reg) {
   483		case 0 ... 12:
   484			p = &regs->r0;
   485			p[-reg] = val;
   486			break;
   487		case 13 ... 25:
   488			if (cregs) {
   489				p = &cregs->r13;
   490				p[13 - reg] = val;
   491			}
   492			break;
   493		case 26:
 > 494			regs->gp = val;
   495			break;
   496		case 27:
   497			regs->fp = val;
   498			break;
   499		case 28:
   500			regs->sp = val;
   501			break;
   502		case 31:
   503			regs->blink = val;
   504			break;
   505		default:
   506			break;
   507		}
   508	#else /* CONFIG_ISA_ARCV2 */
   509		switch (reg) {
   510		case 0 ... 11:
   511			p = &regs->r0;
   512			p[reg] = val;
   513			break;
   514		case 12:
   515			regs->r12 = val;
   516			break;
   517		case 13 ... 25:
   518			if (cregs) {
   519				p = &cregs->r13;
   520				p[13 - reg] = val;
   521			}
   522			break;
   523		case 26:
   524			regs->r26 = val;
   525			break;
   526		case 27:
   527			regs->fp = val;
   528			break;
   529		case 28:
   530			regs->sp = val;
   531			break;
   532		case 30:
   533			regs->r30 = val;
   534			break;
   535		case 31:
   536			regs->blink = val;
   537			break;
   538	#ifdef CONFIG_ARC_HAS_ACCL_REGS
   539		case 58:
   540			regs->r58 = val;
   541			break;
   542		case 59:
   543			regs->r59 = val;
   544			break;
   545	#endif
   546		default:
   547			break;
   548		}
   549	#endif
   550	}
   551	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
