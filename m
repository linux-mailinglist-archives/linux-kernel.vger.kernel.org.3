Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF258BC91
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiHGSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiHGSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:46:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C77365F3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659898010; x=1691434010;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=48ZM6HWH5zYVKkU5Oy/JRtAGxqcrvYcVde5TJQbKhgQ=;
  b=SGFjbuaqpUQ89K+MVwLk1ToRvJyGnwz5eSln/LrQ0x8v1/aPs+k08X63
   Hesn6VoZT8n779EZeo2kBYfFLhppshPtL2IVm4Y4+WNmm2Yq8ySPR+V05
   rWhXkCNC5P0DrmHztwwJiZbENYdiyWv9d4+Mw0Y7wPoEXvgiRlf3AETnq
   PUFkluqD2qVG8ynp++fuDg+SQa39K1x21+TIMKS7rnrex2kqGTNX48JHl
   6UVG6caKBSxt2CHVDG/SCLW9mtJrE9rEIsVOLxKYdbN91z1d1UEukDWPp
   Zn4drRU5VDTnO3vJFYg1bPDbcddzX+rIzlaA+FbNZLT+IK4bMneRLn7yr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="291232292"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="291232292"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 11:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="672225523"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2022 11:46:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKlIV-000LZb-1b;
        Sun, 07 Aug 2022 18:46:47 +0000
Date:   Mon, 8 Aug 2022 02:46:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jean-Francois Bortolotti <jeff@borto.fr>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/120-spmi 1/4]
 drivers/spmi/spmi-apple-controller.c:81 spmi_read_cmd() warn: inconsistent
 indenting
Message-ID: <202208080200.DoRX2CoQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/120-spmi
head:   0324791a3cdc3e93df57f6293e2cfaaadc264aeb
commit: 69860806b247b72cc354ca35ea147c2d1538ea85 [1/4] spmi: add a first basic spmi driver for Apple SoC
config: xtensa-randconfig-m031-20220803 (https://download.01.org/0day-ci/archive/20220808/202208080200.DoRX2CoQ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/spmi/spmi-apple-controller.c:81 spmi_read_cmd() warn: inconsistent indenting
drivers/spmi/spmi-apple-controller.c:97 spmi_write_cmd() warn: inconsistent indenting

Old smatch warnings:
drivers/spmi/spmi-apple-controller.c:83 spmi_read_cmd() warn: inconsistent indenting
drivers/spmi/spmi-apple-controller.c:86 spmi_read_cmd() warn: inconsistent indenting
drivers/spmi/spmi-apple-controller.c:90 spmi_read_cmd() warn: inconsistent indenting

vim +81 drivers/spmi/spmi-apple-controller.c

    47	
    48	static int spmi_read_cmd(struct spmi_controller *ctrl,
    49				 u8 opc, u8 slave_id, u16 slave_addr, u8 *__buf, size_t bc)
    50	{
    51		struct apple_spmi *spmi;
    52		u32 spmi_cmd = opc|slave_id<<8|slave_addr<<16|(bc-1)|(1<<15);
    53		u32 rsp;
    54		volatile u32 status;
    55		size_t len_to_read;
    56		u8 i;
    57	
    58		spmi = spmi_controller_get_drvdata(ctrl);
    59	
    60		write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
    61	
    62		/* Wait for Rx FIFO to have something */
    63		/* Quite ugly msleep, need to find a better way to do it */
    64		i=0;
    65		do {
    66			status=read_reg(spmi, SPMI_STATUS_REG);
    67			msleep(10);
    68			i+=1;
    69		} while ((status & SPMI_RX_FIFO_EMPTY) && i<5);
    70	
    71		if(i>=5){
    72			dev_err(&ctrl->dev,"spmi_read_cmd:took to long to get the status");
    73			return -1;
    74		}
    75	
    76		/* Read SPMI reply status */
    77		rsp=read_reg(spmi, SPMI_RSP_REG);
    78	
    79		len_to_read = 0;
    80		/* Read SPMI data reply */
  > 81	    while (!( status & SPMI_RX_FIFO_EMPTY ) && (len_to_read < bc )) {
    82	        rsp=read_reg(spmi, SPMI_RSP_REG);
    83			i=0;
    84			while ((len_to_read<bc)&&(i<4)) {
    85				__buf[len_to_read++]=((0xff<<(8*i))&rsp)>>(8*i);
    86				 i+=1;
    87			}
    88		}
    89	
    90		return 0;
    91	}
    92	
    93	static int spmi_write_cmd(struct spmi_controller *ctrl,
    94				  u8 opc, u8 slave_id, u16 slave_addr, const u8 *__buf, size_t bc)
    95	{
    96	    struct apple_spmi *spmi;
  > 97		u32 spmi_cmd = opc|slave_id<<8|slave_addr<<16|(bc-1)|(1<<15);
    98		volatile u32 rsp;
    99		size_t i=0,j;
   100	
   101		spmi = spmi_controller_get_drvdata(ctrl);
   102	
   103		write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
   104	
   105		while (i<bc) {
   106			j=0;
   107			spmi_cmd=0;
   108			while ((j<4)&(i<bc)) {
   109				spmi_cmd |= __buf[i++]<<(j++*8);
   110			}
   111			write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
   112		}
   113	
   114		/* Read SPMI reply status */
   115		/* do we need this while loop ?
   116			if yes what for ? */
   117		do {
   118			rsp=read_reg(spmi, SPMI_RSP_REG);
   119		} while (rsp==0);
   120	
   121		return 0;
   122	}
   123	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
