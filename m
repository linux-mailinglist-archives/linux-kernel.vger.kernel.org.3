Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0CC5204C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbiEISyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbiEISyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:54:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D6A1AF20
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652122254; x=1683658254;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G49Hulu3ioqnykK7y88D6Yayvp+sdPAw6mjkylAaETI=;
  b=nXaGiHhitAd9OnpQkwRL3iBN8s/XyYbBnoK1WyHJe6Ji5wboy/HqPIOG
   O/11OVZJ3j9qdm10seS2vnVuH4Qok8c+wc9cMrr3eZD6fSTnMPDHCVb2e
   MAdA6wn42LeiTzfg2msUSeCwN/faC41iiGHe6y4OttfQBN7Os31PTUBVJ
   MvWxa9ptWw313B28fcjesFKl2Hu88Ow7v1eYkxvCOGBaoYMbeFVZFruuF
   8KUYRLaBxO99Qn/vch8iLnETzZ3rzD4BYmuZqw2AlsyFxe/2VFlsSJEpw
   8ps1OmnlKX5CSESKJI2fdmp01nM8iGHd/nBgw4RP0wugzbDQGdvvMfpAH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249042681"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="249042681"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 11:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="570296319"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 May 2022 11:50:52 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no8T6-000Gn6-0D;
        Mon, 09 May 2022 18:50:52 +0000
Date:   Tue, 10 May 2022 02:50:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ricky Wu <Ricky_wu@realtek.com>
Subject: [char-misc:char-misc-testing 2/25]
 drivers/misc/cardreader/rts5261.c:406:13: warning: variable 'setting_reg2'
 is used uninitialized whenever 'if' condition is false
Message-ID: <202205100220.WyAyhKap-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-testing
head:   33a1c6618677fe33f8e84cb7bedc45abbce89a50
commit: b1c5f3085149e9643b125eb10aae0e74644d7dcc [2/25] misc: rtsx: add rts5261 efuse function
config: riscv-randconfig-c006-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100220.WyAyhKap-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a385645b470e2d3a1534aae618ea56b31177639f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=b1c5f3085149e9643b125eb10aae0e74644d7dcc
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch --no-tags char-misc char-misc-testing
        git checkout b1c5f3085149e9643b125eb10aae0e74644d7dcc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/misc/cardreader/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/cardreader/rts5261.c:406:13: warning: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (efuse_valid == 0) {
                      ^~~~~~~~~~~~~~~~
   drivers/misc/cardreader/rts5261.c:412:30: note: uninitialized use occurs here
           pci_read_config_dword(pdev, setting_reg2, &lval2);
                                       ^~~~~~~~~~~~
   drivers/misc/cardreader/rts5261.c:406:9: note: remove the 'if' if its condition is always true
           } else if (efuse_valid == 0) {
                  ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/cardreader/rts5261.c:364:32: note: initialize the variable 'setting_reg2' to silence this warning
           u16 setting_reg1, setting_reg2;
                                         ^
                                          = 0
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +406 drivers/misc/cardreader/rts5261.c

   359	
   360	static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
   361	{
   362		struct pci_dev *pdev = pcr->pci;
   363		u32 lval1, lval2, i;
   364		u16 setting_reg1, setting_reg2;
   365		u8 valid, efuse_valid, tmp;
   366	
   367		rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
   368			REG_EFUSE_POR | REG_EFUSE_POWER_MASK,
   369			REG_EFUSE_POR | REG_EFUSE_POWERON);
   370		udelay(1);
   371		rtsx_pci_write_register(pcr, RTS5261_EFUSE_ADDR,
   372			RTS5261_EFUSE_ADDR_MASK, 0x00);
   373		rtsx_pci_write_register(pcr, RTS5261_EFUSE_CTL,
   374			RTS5261_EFUSE_ENABLE | RTS5261_EFUSE_MODE_MASK,
   375			RTS5261_EFUSE_ENABLE);
   376	
   377		/* Wait transfer end */
   378		for (i = 0; i < MAX_RW_REG_CNT; i++) {
   379			rtsx_pci_read_register(pcr, RTS5261_EFUSE_CTL, &tmp);
   380			if ((tmp & 0x80) == 0)
   381				break;
   382		}
   383		rtsx_pci_read_register(pcr, RTS5261_EFUSE_READ_DATA, &tmp);
   384		efuse_valid = ((tmp & 0x0C) >> 2);
   385		pcr_dbg(pcr, "Load efuse valid: 0x%x\n", efuse_valid);
   386	
   387		pci_read_config_dword(pdev, PCR_SETTING_REG2, &lval2);
   388		pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, lval2);
   389		/* 0x816 */
   390		valid = (u8)((lval2 >> 16) & 0x03);
   391	
   392		rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
   393			REG_EFUSE_POR, 0);
   394		pcr_dbg(pcr, "Disable efuse por!\n");
   395	
   396		if (efuse_valid == 2 || efuse_valid == 3) {
   397			if (valid == 3) {
   398				/* Bypass efuse */
   399				setting_reg1 = PCR_SETTING_REG1;
   400				setting_reg2 = PCR_SETTING_REG2;
   401			} else {
   402				/* Use efuse data */
   403				setting_reg1 = PCR_SETTING_REG4;
   404				setting_reg2 = PCR_SETTING_REG5;
   405			}
 > 406		} else if (efuse_valid == 0) {
   407			// default
   408			setting_reg1 = PCR_SETTING_REG1;
   409			setting_reg2 = PCR_SETTING_REG2;
   410		}
   411	
   412		pci_read_config_dword(pdev, setting_reg2, &lval2);
   413		pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", setting_reg2, lval2);
   414	
   415		if (!rts5261_vendor_setting_valid(lval2)) {
   416			/* Not support MMC default */
   417			pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
   418			pcr_dbg(pcr, "skip fetch vendor setting\n");
   419			return;
   420		}
   421	
   422		if (!rts5261_reg_check_mmc_support(lval2))
   423			pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
   424	
   425		pcr->rtd3_en = rts5261_reg_to_rtd3(lval2);
   426	
   427		if (rts5261_reg_check_reverse_socket(lval2))
   428			pcr->flags |= PCR_REVERSE_SOCKET;
   429	
   430		pci_read_config_dword(pdev, setting_reg1, &lval1);
   431		pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", setting_reg1, lval1);
   432	
   433		pcr->aspm_en = rts5261_reg_to_aspm(lval1);
   434		pcr->sd30_drive_sel_1v8 = rts5261_reg_to_sd30_drive_sel_1v8(lval1);
   435		pcr->sd30_drive_sel_3v3 = rts5261_reg_to_sd30_drive_sel_3v3(lval1);
   436	
   437		if (setting_reg1 == PCR_SETTING_REG1) {
   438			/* store setting */
   439			rtsx_pci_write_register(pcr, 0xFF0C, 0xFF, (u8)(lval1 & 0xFF));
   440			rtsx_pci_write_register(pcr, 0xFF0D, 0xFF, (u8)((lval1 >> 8) & 0xFF));
   441			rtsx_pci_write_register(pcr, 0xFF0E, 0xFF, (u8)((lval1 >> 16) & 0xFF));
   442			rtsx_pci_write_register(pcr, 0xFF0F, 0xFF, (u8)((lval1 >> 24) & 0xFF));
   443			rtsx_pci_write_register(pcr, 0xFF10, 0xFF, (u8)(lval2 & 0xFF));
   444			rtsx_pci_write_register(pcr, 0xFF11, 0xFF, (u8)((lval2 >> 8) & 0xFF));
   445			rtsx_pci_write_register(pcr, 0xFF12, 0xFF, (u8)((lval2 >> 16) & 0xFF));
   446	
   447			pci_write_config_dword(pdev, PCR_SETTING_REG4, lval1);
   448			lval2 = lval2 & 0x00FFFFFF;
   449			pci_write_config_dword(pdev, PCR_SETTING_REG5, lval2);
   450		}
   451	}
   452	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
