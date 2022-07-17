Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85452577310
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 03:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiGQBoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 21:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGQBoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 21:44:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF24101FD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 18:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658022244; x=1689558244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KTw1/7rD4CM9ru0woEWvt/samsWn6ttAkZIXhusjOTM=;
  b=OBlvD/pKqJN9Bo/2MgbyGvKkqKoAtXW43B7iiD5etwlh6z1Gswv74h0l
   x7Tjw5wc2Sy1fIbPA51HxrEapcUtra65lhqlnTmFVUs+yXLpG6qmP4QOD
   PwTO65ekngUBq34ZI+MzEbJ9/8d0E4oOkwL2j1rHXddTJ3vS6o2cKzGTH
   4jst5ncTJr9ZUPcM/ad8YP8ZUmV/Dqvwo9LxMC2orsCYtfHEFTNAjLnEc
   Qhvb09j/s7whJB56loBUfBVhrIhql/JtqSruSjZPF8VVWateaCubARrGB
   Swzwf2KslRiWw2Rqsxb3tz3TXJUQDKqvLjlTR3qmmwbw4q1ugY3HONRfV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="287163173"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="287163173"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 18:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="547078073"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2022 18:44:02 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCtKD-0002Qo-Qi;
        Sun, 17 Jul 2022 01:44:01 +0000
Date:   Sun, 17 Jul 2022 09:43:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/120-spmi 4/4]
 drivers/spmi/spmi-apple-controller.c:98:15: warning: variable 'rsp' set but
 not used
Message-ID: <202207170930.CP6Weylo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/120-spmi
head:   33e9b741cc336eae2465b02a86130c0c3f74e898
commit: 33e9b741cc336eae2465b02a86130c0c3f74e898 [4/4] spmi: apple: Properly wait for status data after write
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220717/202207170930.CP6Weylo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/33e9b741cc336eae2465b02a86130c0c3f74e898
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/120-spmi
        git checkout 33e9b741cc336eae2465b02a86130c0c3f74e898
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/block/ drivers/iio/light/ drivers/media/i2c/ drivers/net/pcs/ drivers/pinctrl/nuvoton/ drivers/spmi/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spmi/spmi-apple-controller.c:98:15: warning: variable 'rsp' set but not used [-Wunused-but-set-variable]
           volatile u32 rsp;
                        ^
   1 warning generated.


vim +/rsp +98 drivers/spmi/spmi-apple-controller.c

c6ab839751d160 Jean-Francois Bortolotti 2022-02-04   92  
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04   93  static int spmi_write_cmd(struct spmi_controller *ctrl,
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04   94  			  u8 opc, u8 slave_id, u16 slave_addr, const u8 *__buf, size_t bc)
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04   95  {
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04   96      struct apple_spmi *spmi;
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04   97  	u32 spmi_cmd = opc|slave_id<<8|slave_addr<<16|(bc-1)|(1<<15);
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  @98  	volatile u32 rsp;
33e9b741cc336e Hector Martin            2022-07-02   99  	volatile u32 status;
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  100  	size_t i=0,j;
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  101  
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  102  	spmi = spmi_controller_get_drvdata(ctrl);
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  103  
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  104  	write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  105  
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  106  	while (i<bc) {
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  107  		j=0;
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  108  		spmi_cmd=0;
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  109  		while ((j<4)&(i<bc)) {
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  110  			spmi_cmd |= __buf[i++]<<(j++*8);
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  111  		}
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  112  		write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  113  	}
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  114  
33e9b741cc336e Hector Martin            2022-07-02  115  	/* Wait for Rx FIFO to have something */
33e9b741cc336e Hector Martin            2022-07-02  116  	/* Quite ugly msleep, need to find a better way to do it */
33e9b741cc336e Hector Martin            2022-07-02  117  	i=0;
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  118  	do {
33e9b741cc336e Hector Martin            2022-07-02  119  		status=read_reg(spmi, SPMI_STATUS_REG);
33e9b741cc336e Hector Martin            2022-07-02  120  		msleep(10);
33e9b741cc336e Hector Martin            2022-07-02  121  		i+=1;
33e9b741cc336e Hector Martin            2022-07-02  122  	} while ((status & SPMI_RX_FIFO_EMPTY) && i<5);
33e9b741cc336e Hector Martin            2022-07-02  123  
33e9b741cc336e Hector Martin            2022-07-02  124  	if(i>=5){
33e9b741cc336e Hector Martin            2022-07-02  125  		dev_err(&ctrl->dev,"spmi_write_cmd:took to long to get the status");
33e9b741cc336e Hector Martin            2022-07-02  126  		return -1;
33e9b741cc336e Hector Martin            2022-07-02  127  	}
33e9b741cc336e Hector Martin            2022-07-02  128  
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  129  	rsp = read_reg(spmi, SPMI_RSP_REG);
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  130  
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  131  	return 0;
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  132  }
c6ab839751d160 Jean-Francois Bortolotti 2022-02-04  133  

:::::: The code at line 98 was first introduced by commit
:::::: c6ab839751d160e1fcdd94636e4fe40f88a91a42 spmi: add a first basic spmi driver for Apple SoC

:::::: TO: Jean-Francois Bortolotti <jeff@borto.fr>
:::::: CC: Hector Martin <marcan@marcan.st>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
