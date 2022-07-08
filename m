Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDD56B295
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiGHGLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbiGHGLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:11:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521525E8D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657260690; x=1688796690;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bAjwa3MZ5cjlMsVd+KIETMGzC+DZm5Y3Qj3WZJIAXH0=;
  b=G1jBZNFpkz2aX4Q1zIKNWNY6mHTgReFoPdaT4TrvIZ2FIsUKAMJHm/9P
   W2p+I8TKIMSyWdce/5sZlhpGnqra01eDNjqT6yXSPVU0UFpf+qMmsFBOt
   nDJhSSg06DFsRmSTVXN+NOuhArnEu/hK8NUL/L7dZmG/t8+CXHHf/PPGG
   C1Oy1I2dwDYRe/MHPMxqDFd5PLwvuMCLgHlQGpUO73bmcMypXWex42wNo
   hcXQC3+GEJ36Qq2DnV/+eUMa/eQpyBCHMnPPLDwbdDFy/idgOiGcnFwyo
   YCIhzmbQiv1UeSQy6gjqnsiE+kvpQv135ETLYQZEjcDqkc7eeFjiSGfUt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="282952748"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="282952748"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 23:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="840194876"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2022 23:11:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9hD5-000N0o-PO;
        Fri, 08 Jul 2022 06:11:27 +0000
Date:   Fri, 8 Jul 2022 14:10:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:t8112/bringup 11/19]
 drivers/spmi/spmi-apple-controller.c:98:22: warning: variable 'rsp' set but
 not used
Message-ID: <202207081436.xHlkVYWP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux t8112/bringup
head:   0e7640fed025ba0ce4b845a0bbf2a5fdceab631d
commit: b781679f65b2f7b376e32d2b8b7f9283dfb94f5d [11/19] spmi: apple: Properly wait for status data after write
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220708/202207081436.xHlkVYWP-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/b781679f65b2f7b376e32d2b8b7f9283dfb94f5d
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux t8112/bringup
        git checkout b781679f65b2f7b376e32d2b8b7f9283dfb94f5d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/hid/ drivers/spmi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/spmi/spmi-apple-controller.c: In function 'spmi_write_cmd':
>> drivers/spmi/spmi-apple-controller.c:98:22: warning: variable 'rsp' set but not used [-Wunused-but-set-variable]
      98 |         volatile u32 rsp;
         |                      ^~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for APPLE_ADMAC
   Depends on DMADEVICES && (ARCH_APPLE || COMPILE_TEST
   Selected by
   - SND_SOC_APPLE_MCA && SOUND && !UML && SND && SND_SOC && (ARCH_APPLE || COMPILE_TEST


vim +/rsp +98 drivers/spmi/spmi-apple-controller.c

6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04   92  
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04   93  static int spmi_write_cmd(struct spmi_controller *ctrl,
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04   94  			  u8 opc, u8 slave_id, u16 slave_addr, const u8 *__buf, size_t bc)
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04   95  {
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04   96      struct apple_spmi *spmi;
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04   97  	u32 spmi_cmd = opc|slave_id<<8|slave_addr<<16|(bc-1)|(1<<15);
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  @98  	volatile u32 rsp;
b781679f65b2f7 Hector Martin            2022-07-02   99  	volatile u32 status;
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  100  	size_t i=0,j;
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  101  
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  102  	spmi = spmi_controller_get_drvdata(ctrl);
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  103  
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  104  	write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  105  
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  106  	while (i<bc) {
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  107  		j=0;
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  108  		spmi_cmd=0;
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  109  		while ((j<4)&(i<bc)) {
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  110  			spmi_cmd |= __buf[i++]<<(j++*8);
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  111  		}
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  112  		write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  113  	}
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  114  
b781679f65b2f7 Hector Martin            2022-07-02  115  	/* Wait for Rx FIFO to have something */
b781679f65b2f7 Hector Martin            2022-07-02  116  	/* Quite ugly msleep, need to find a better way to do it */
b781679f65b2f7 Hector Martin            2022-07-02  117  	i=0;
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  118  	do {
b781679f65b2f7 Hector Martin            2022-07-02  119  		status=read_reg(spmi, SPMI_STATUS_REG);
b781679f65b2f7 Hector Martin            2022-07-02  120  		msleep(10);
b781679f65b2f7 Hector Martin            2022-07-02  121  		i+=1;
b781679f65b2f7 Hector Martin            2022-07-02  122  	} while ((status & SPMI_RX_FIFO_EMPTY) && i<5);
b781679f65b2f7 Hector Martin            2022-07-02  123  
b781679f65b2f7 Hector Martin            2022-07-02  124  	if(i>=5){
b781679f65b2f7 Hector Martin            2022-07-02  125  		dev_err(&ctrl->dev,"spmi_write_cmd:took to long to get the status");
b781679f65b2f7 Hector Martin            2022-07-02  126  		return -1;
b781679f65b2f7 Hector Martin            2022-07-02  127  	}
b781679f65b2f7 Hector Martin            2022-07-02  128  
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  129  	rsp = read_reg(spmi, SPMI_RSP_REG);
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  130  
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  131  	return 0;
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  132  }
6ebdfe55de1288 Jean-Francois Bortolotti 2022-02-04  133  

:::::: The code at line 98 was first introduced by commit
:::::: 6ebdfe55de12883ccf9df0c84900873a1b349b1a spmi: add a first basic spmi driver for Apple SoC

:::::: TO: Jean-Francois Bortolotti <jeff@borto.fr>
:::::: CC: Hector Martin <marcan@marcan.st>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
