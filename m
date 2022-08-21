Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08159B216
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 07:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiHUF3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 01:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUF3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:29:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F12B18F
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661059776; x=1692595776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LPXXsTJb75anKjvRsLfVn5v387PcNPtkQFCgjaMQWA0=;
  b=Y9NZ0xVvl/aM5t1kLaVKtYuda6tYmw72WHbzOm76fC4ouNK+vCa+qynu
   7deuxDP3vzizcizcbFWkhZEWQs5F7VvXl/6LfRnQllQCp9WAa1vm5jdMT
   GLlKHWHiKcKYtqTHj/d8SIZkFQPhA06+f37j7Ju/7kjRh4EYxwRrEkWsk
   GTrbhjrdbmNXYt54VeEPveSP86tZ5Btr/QHu9QEaOtTNXIEnkiVgSZGFY
   qI3YM4mrjUE1+bPzkMHhHJDoUpMTF53KULV0Veae/8WKjDvFoySU3Bhsh
   TmKuhEhwIIBZjXFvLi/EDBwSDQYVdFNSfW3QxpnffADH7hbbn51Smg0bW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="273613684"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="273613684"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 22:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="637759365"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2022 22:29:33 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPdWe-0003hP-2W;
        Sun, 21 Aug 2022 05:29:32 +0000
Date:   Sun, 21 Aug 2022 13:28:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Gardner <rob.gardner@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/sparc/kernel/traps_64.c:268:6: error: no previous declaration
 for 'is_no_fault_exception'
Message-ID: <202208211303.SUJk39Cv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c
commit: b6fe1089667a7afcc2cf92cdaec590c7b8381715 sparc64: Handle additional cases of no fault loads
date:   4 years, 11 months ago
config: sparc64-randconfig-c033-20220821 (https://download.01.org/0day-ci/archive/20220821/202208211303.SUJk39Cv-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b6fe1089667a7afcc2cf92cdaec590c7b8381715
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b6fe1089667a7afcc2cf92cdaec590c7b8381715
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/sparc/kernel/traps_64.c:268:6: error: no previous declaration for 'is_no_fault_exception' [-Werror=missing-declarations]
    bool is_no_fault_exception(struct pt_regs *regs)
         ^~~~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/traps_64.c:2117:6: error: no previous declaration for 'sun4v_nonresum_error_user_handled' [-Werror=missing-declarations]
    bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/is_no_fault_exception +268 arch/sparc/kernel/traps_64.c

   267	
 > 268	bool is_no_fault_exception(struct pt_regs *regs)
   269	{
   270		unsigned char asi;
   271		u32 insn;
   272	
   273		if (get_user(insn, (u32 __user *)regs->tpc) == -EFAULT)
   274			return false;
   275	
   276		/*
   277		 * Must do a little instruction decoding here in order to
   278		 * decide on a course of action. The bits of interest are:
   279		 *  insn[31:30] = op, where 3 indicates the load/store group
   280		 *  insn[24:19] = op3, which identifies individual opcodes
   281		 *  insn[13] indicates an immediate offset
   282		 *  op3[4]=1 identifies alternate space instructions
   283		 *  op3[5:4]=3 identifies floating point instructions
   284		 *  op3[2]=1 identifies stores
   285		 * See "Opcode Maps" in the appendix of any Sparc V9
   286		 * architecture spec for full details.
   287		 */
   288		if ((insn & 0xc0800000) == 0xc0800000) {    /* op=3, op3[4]=1   */
   289			if (insn & 0x2000)		    /* immediate offset */
   290				asi = (regs->tstate >> 24); /* saved %asi       */
   291			else
   292				asi = (insn >> 5);	    /* immediate asi    */
   293			if ((asi & 0xf2) == ASI_PNF) {
   294				if (insn & 0x1000000) {     /* op3[5:4]=3       */
   295					handle_ldf_stq(insn, regs);
   296					return true;
   297				} else if (insn & 0x200000) { /* op3[2], stores */
   298					return false;
   299				}
   300				handle_ld_nf(insn, regs);
   301				return true;
   302			}
   303		}
   304		return false;
   305	}
   306	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
