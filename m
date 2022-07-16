Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6F5771BD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiGPWJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGPWI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:08:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A5D5F90
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658009338; x=1689545338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t5GpY4jgF18n1WGAjUgHPB/dhzS3yRLUknQv4wWEc0E=;
  b=LI5ZhyqrrOUiZRLFNH3TXojIxfGBxZa61IGpWymBDRhJSvNEc7BkVB84
   D2pkBhISF6zDKE3+47c/i4crewRkxkIKFMBSt3Ngk/fWq8oe+wx98bNAT
   MQ4pJ1EU4dDGP1oZECGTeq+AJ+n+3Mj0Z1CiZc8UZU7w4expvpGGlwJz1
   E0jPE4nsRh4k09ZhfN0/p40TXWZ6TJ5ualLc+ZbaBnASqIHBWWJtedgNi
   ejV5HBOU6i8aHff/a8INokzJ5sobylZ5cum4askPBCiqcsDYYWoOnRaPu
   O5eL368j+WX9anZXOcHWjdyEq6CCgje9n+5z/uAX5k2yrvS1A18x0PtZp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="286031621"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="286031621"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 15:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="594084211"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2022 15:08:56 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCpy3-0002De-Nt;
        Sat, 16 Jul 2022 22:08:55 +0000
Date:   Sun, 17 Jul 2022 06:08:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/bus/fsl-mc/dprc.c:494:9: warning: 'strncpy' specified bound
 16 equals destination size
Message-ID: <202207170606.cuF9v1tA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5fe7a97f20c7f3070ac870144515c0fabc6b999
commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
date:   7 months ago
config: arm64-randconfig-r003-20220717 (https://download.01.org/0day-ci/archive/20220717/202207170606.cuF9v1tA-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd03762ab608e058c8f390ad9cf667e490089796
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/bus/fsl-mc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/bus/fsl-mc/dprc.c: In function 'dprc_get_obj':
   drivers/bus/fsl-mc/dprc.c:453:9: warning: 'strncpy' output may be truncated copying 15 bytes from a string of length 15 [-Wstringop-truncation]
     453 |         strncpy(obj_desc->type, rsp_params->type, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/dprc.c:455:9: warning: 'strncpy' output may be truncated copying 15 bytes from a string of length 15 [-Wstringop-truncation]
     455 |         strncpy(obj_desc->label, rsp_params->label, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/dprc.c: In function 'dprc_set_obj_irq':
>> drivers/bus/fsl-mc/dprc.c:494:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     494 |         strncpy(cmd_params->obj_type, obj_type, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/dprc.c: In function 'dprc_get_obj_region':
   drivers/bus/fsl-mc/dprc.c:567:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     567 |         strncpy(cmd_params->obj_type, obj_type, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +494 drivers/bus/fsl-mc/dprc.c

31c889653c10dd drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-03-05  460  
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  461  /**
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  462   * dprc_set_obj_irq() - Set IRQ information for object to trigger an interrupt.
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  463   * @mc_io:	Pointer to MC portal's I/O object
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  464   * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  465   * @token:	Token of DPRC object
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  466   * @obj_type:	Type of the object to set its IRQ
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  467   * @obj_id:	ID of the object to set its IRQ
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  468   * @irq_index:	The interrupt index to configure
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  469   * @irq_cfg:	IRQ configuration
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  470   *
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  471   * Return:	'0' on Success; Error code otherwise.
e9bf3f206bd5e6 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  472   */
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  473  int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
ba72f25b2588e1 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-25  474  		     u32 cmd_flags,
ba72f25b2588e1 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-25  475  		     u16 token,
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  476  		     char *obj_type,
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  477  		     int obj_id,
ba72f25b2588e1 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-25  478  		     u8 irq_index,
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  479  		     struct dprc_irq_cfg *irq_cfg)
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  480  {
5b04cedeca1888 drivers/bus/fsl-mc/dprc.c         Ioana Ciornei    2018-03-15  481  	struct fsl_mc_command cmd = { 0 };
9989b59961a8ad drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  482  	struct dprc_cmd_set_obj_irq *cmd_params;
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  483  
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  484  	/* prepare command */
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  485  	cmd.header = mc_encode_cmd_header(DPRC_CMDID_SET_OBJ_IRQ,
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  486  					  cmd_flags,
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  487  					  token);
9989b59961a8ad drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  488  	cmd_params = (struct dprc_cmd_set_obj_irq *)cmd.params;
9989b59961a8ad drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  489  	cmd_params->irq_val = cpu_to_le32(irq_cfg->val);
9989b59961a8ad drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  490  	cmd_params->irq_index = irq_index;
9989b59961a8ad drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  491  	cmd_params->irq_addr = cpu_to_le64(irq_cfg->paddr);
9989b59961a8ad drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  492  	cmd_params->irq_num = cpu_to_le32(irq_cfg->irq_num);
9989b59961a8ad drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  493  	cmd_params->obj_id = cpu_to_le32(obj_id);
9989b59961a8ad drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22 @494  	strncpy(cmd_params->obj_type, obj_type, 16);
9989b59961a8ad drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  495  	cmd_params->obj_type[15] = '\0';
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  496  
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  497  	/* send command to mc*/
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  498  	return mc_send_command(mc_io, &cmd);
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  499  }
c9d57ea0b6fb0b drivers/staging/fsl-mc/bus/dprc.c Laurentiu Tudor  2017-11-17  500  EXPORT_SYMBOL_GPL(dprc_set_obj_irq);
1ee695fab32e25 drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  501  

:::::: The code at line 494 was first introduced by commit
:::::: 9989b59961a8ad55d92df4588b556f0c6c838ec7 staging: fsl-mc: convert mc command build/parse to use C structs

:::::: TO: Ioana Radulescu <ruxandra.radulescu@nxp.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
