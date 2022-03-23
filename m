Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D854E57E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbiCWRyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbiCWRyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:54:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24A18595F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648057959; x=1679593959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+TFoyt2jaGi0RcR+Zuqss7klX/zPEKATGsssd5gMLHY=;
  b=RT1mdO77l557PBLByfqauowZBUJAN9CPLd55WM58LHfue+i8ZDyG5ONP
   sa+HtSQ0NHZVLF/082q9sobepiLY+9xuNf0VaQ0HQZC9x7i62ZNrekRf3
   +6t9dClf5s+5YgsML8V9tCyaLwrE+79xCJvJY+kbmL9h8UEUpUsoQWcUG
   odqHxO8D1g7jJcfHX9e+OOWbI7akshPD6h5PdNMD4RYMzkCBljrHsSsk+
   d4MCq/WBoH89PwL1f9v190DikXAwl5XcML35atYzapgm5ryp1BmT+0g0s
   eKVVsEQrIhWHeHhW6i1YivBPEr6Rl4ohyjW4nu1MySrfvPS4vxxuAtM1E
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258379004"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="258379004"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 10:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="515876130"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2022 10:52:37 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX59w-000KHo-LK; Wed, 23 Mar 2022 17:52:36 +0000
Date:   Thu, 24 Mar 2022 01:51:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Lai <jason.lai@genesyslogic.com.tw>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [ulfh-mmc:wip_uhs_v3 45/46] drivers/mmc/core/sd_uhs2.c:420:20:
 sparse: sparse: incorrect type in assignment (different base types)
Message-ID: <202203240105.h6vaETsa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git wip_uhs_v3
head:   88e61f681a2427ed18a4dfa4fdd14b011a0f7847
commit: 904c9867969e3672e160eab8bcd4f4e89be104e9 [45/46] mmc: Implement content of UHS-II card initialization functions
config: sh-randconfig-s031-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240105.h6vaETsa-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?id=904c9867969e3672e160eab8bcd4f4e89be104e9
        git remote add ulfh-mmc git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
        git fetch --no-tags ulfh-mmc wip_uhs_v3
        git checkout 904c9867969e3672e160eab8bcd4f4e89be104e9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/mmc/core/sd_uhs2.c:420:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:420:20: sparse:     expected unsigned int
   drivers/mmc/core/sd_uhs2.c:420:20: sparse:     got restricted __be32 [usertype]
   drivers/mmc/core/sd_uhs2.c:421:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:421:20: sparse:     expected unsigned int
   drivers/mmc/core/sd_uhs2.c:421:20: sparse:     got restricted __be32 [usertype]
   drivers/mmc/core/sd_uhs2.c:467:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:467:20: sparse:     expected unsigned int
   drivers/mmc/core/sd_uhs2.c:467:20: sparse:     got restricted __be32 [usertype]
   drivers/mmc/core/sd_uhs2.c:468:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:468:20: sparse:     expected unsigned int
   drivers/mmc/core/sd_uhs2.c:468:20: sparse:     got restricted __be32 [usertype]
   drivers/mmc/core/sd_uhs2.c:515:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:515:20: sparse:     expected unsigned int
   drivers/mmc/core/sd_uhs2.c:515:20: sparse:     got restricted __be32 [usertype]
   drivers/mmc/core/sd_uhs2.c:516:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:516:20: sparse:     expected unsigned int
   drivers/mmc/core/sd_uhs2.c:516:20: sparse:     got restricted __be32 [usertype]
   drivers/mmc/core/sd_uhs2.c:535:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:535:20: sparse:     expected unsigned int
   drivers/mmc/core/sd_uhs2.c:535:20: sparse:     got restricted __be32 [usertype]
   drivers/mmc/core/sd_uhs2.c:536:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:536:20: sparse:     expected unsigned int
   drivers/mmc/core/sd_uhs2.c:536:20: sparse:     got restricted __be32 [usertype]
>> drivers/mmc/core/sd_uhs2.c:978:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:978:36: sparse:     expected unsigned int [usertype]
   drivers/mmc/core/sd_uhs2.c:978:36: sparse:     got restricted __be32 [usertype]
   drivers/mmc/core/sd_uhs2.c:980:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:980:36: sparse:     expected unsigned int [usertype]
   drivers/mmc/core/sd_uhs2.c:980:36: sparse:     got restricted __be32 [usertype]
   drivers/mmc/core/sd_uhs2.c:986:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/mmc/core/sd_uhs2.c:986:20: sparse:     expected unsigned int [usertype]
   drivers/mmc/core/sd_uhs2.c:986:20: sparse:     got restricted __be32 [usertype]

vim +420 drivers/mmc/core/sd_uhs2.c

   369	
   370	/*
   371	 * Based on the card's and host's UHS-II capabilities, let's update the
   372	 * configuration of the card and the host. This may also include to move to a
   373	 * greater speed range/mode. Depending on the updated configuration, we may need
   374	 * to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
   375	 *
   376	 * In the final step, let's check if the card signals "config completion", which
   377	 * indicates that the card has moved from config state into active state.
   378	 */
   379	static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
   380	{
   381		struct mmc_command cmd = {0};
   382		struct uhs2_command uhs2_cmd = {};
   383		u16 header = 0, arg = 0;
   384		u32 payload[2];
   385		u8 nMinDataGap;
   386		u8 plen;
   387		int err;
   388		u8 resp[5] = {0};
   389		u8 resp_len = 5;
   390	
   391		header = UHS2_NATIVE_PACKET |
   392			 UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
   393		arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
   394		       UHS2_NATIVE_CMD_WRITE |
   395		       UHS2_NATIVE_CMD_PLEN_8B |
   396		       (UHS2_DEV_CONFIG_GEN_SET >> 8);
   397	
   398		if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
   399		    host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
   400			/* Support HD */
   401			host->uhs2_caps.flags |= MMC_UHS2_2L_HD;
   402			nMinDataGap = 1;
   403		} else {
   404			/* Only support 2L-FD so far */
   405			host->uhs2_caps.flags &= ~MMC_UHS2_2L_HD;
   406			nMinDataGap = 3;
   407		}
   408	
   409		/*
   410		 * Most UHS-II cards only support FD and 2L-HD mode. Other lane numbers
   411		 * defined in UHS-II addendem Ver1.01 are optional.
   412		 */
   413		host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
   414		card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
   415	
   416		plen = 2;
   417		payload[0] = card->uhs2_config.n_lanes_set <<
   418			     UHS2_DEV_CONFIG_N_LANES_POS;
   419		payload[1] = 0;
 > 420		payload[0] = cpu_to_be32(payload[0]);
   421		payload[1] = cpu_to_be32(payload[1]);
   422	
   423		/*
   424		 * There is no payload because per spec, there should be
   425		 * no payload field for read CCMD.
   426		 * Plen is set in arg. Per spec, plen for read CCMD
   427		 * represents the len of read data which is assigned in payload
   428		 * of following RES (p136).
   429		 */
   430		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
   431	
   432		err = mmc_wait_for_cmd(host, &cmd, 0);
   433		if (err) {
   434			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
   435			       mmc_hostname(host), __func__, err);
   436			return -EIO;
   437		}
   438	
   439		arg = ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
   440		       UHS2_NATIVE_CMD_WRITE |
   441		       UHS2_NATIVE_CMD_PLEN_8B |
   442		       (UHS2_DEV_CONFIG_PHY_SET >> 8);
   443	
   444		if (host->uhs2_caps.speed_range == UHS2_DEV_CONFIG_PHY_SET_SPEED_B) {
   445			host->uhs2_caps.flags |= MMC_UHS2_SPEED_B;
   446			card->uhs2_config.speed_range_set =
   447						UHS2_DEV_CONFIG_PHY_SET_SPEED_B;
   448		} else {
   449			card->uhs2_config.speed_range_set = UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
   450			host->uhs2_caps.flags &= ~MMC_UHS2_SPEED_B;
   451		}
   452	
   453		payload[0] = card->uhs2_config.speed_range_set << UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
   454	
   455		card->uhs2_config.n_lss_sync_set = (max(card->uhs2_config.n_lss_sync,
   456							host->uhs2_caps.n_lss_sync) >> 2) &
   457						   UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
   458		host->uhs2_caps.n_lss_sync_set = card->uhs2_config.n_lss_sync_set;
   459	
   460		card->uhs2_config.n_lss_dir_set = (max(card->uhs2_config.n_lss_dir,
   461						       host->uhs2_caps.n_lss_dir) >> 3) &
   462						  UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
   463		host->uhs2_caps.n_lss_dir_set = card->uhs2_config.n_lss_dir_set;
   464	
   465		payload[1] = (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
   466			     card->uhs2_config.n_lss_sync_set;
   467		payload[0] = cpu_to_be32(payload[0]);
   468		payload[1] = cpu_to_be32(payload[1]);
   469	
   470		resp_len = 4;
   471		memset(resp, 0, sizeof(resp));
   472	
   473		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, resp, resp_len);
   474	
   475		err = mmc_wait_for_cmd(host, &cmd, 0);
   476		if (err) {
   477			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
   478			       mmc_hostname(host), __func__, err);
   479			return -EIO;
   480		}
   481	
   482		if ((resp[2] & 0x80)) {
   483			pr_err("%s: %s: UHS2 CMD not accepted, resp= 0x%x!\n",
   484			       mmc_hostname(host), __func__, resp[2]);
   485			return -EIO;
   486		}
   487	
   488		arg = ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
   489			UHS2_NATIVE_CMD_WRITE |
   490			UHS2_NATIVE_CMD_PLEN_8B |
   491			(UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
   492	
   493		plen = 2;
   494	
   495		if (card->uhs2_config.app_type == UHS2_DEV_CONFIG_APP_SD_MEM)
   496			card->uhs2_config.maxblk_len_set = UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN;
   497		else
   498			card->uhs2_config.maxblk_len_set = min(card->uhs2_config.maxblk_len,
   499							       host->uhs2_caps.maxblk_len);
   500		host->uhs2_caps.maxblk_len_set = card->uhs2_config.maxblk_len_set;
   501	
   502		card->uhs2_config.n_fcu_set = min(card->uhs2_config.n_fcu, host->uhs2_caps.n_fcu);
   503		host->uhs2_caps.n_fcu_set = card->uhs2_config.n_fcu_set;
   504	
   505		card->uhs2_config.n_data_gap_set = max(nMinDataGap, card->uhs2_config.n_data_gap);
   506		host->uhs2_caps.n_data_gap_set = card->uhs2_config.n_data_gap_set;
   507	
   508		host->uhs2_caps.max_retry_set = 3;
   509		card->uhs2_config.max_retry_set = host->uhs2_caps.max_retry_set;
   510	
   511		payload[0] = (card->uhs2_config.maxblk_len_set << UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
   512			     (card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
   513			     (card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FCU_POS);
   514		payload[1] = card->uhs2_config.n_data_gap_set;
   515		payload[0] = cpu_to_be32(payload[0]);
   516		payload[1] = cpu_to_be32(payload[1]);
   517	
   518		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
   519	
   520		err = mmc_wait_for_cmd(host, &cmd, 0);
   521		if (err) {
   522			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
   523			       mmc_hostname(host), __func__, err);
   524			return -EIO;
   525		}
   526	
   527		arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
   528		       UHS2_NATIVE_CMD_WRITE |
   529		       UHS2_NATIVE_CMD_PLEN_8B |
   530		       (UHS2_DEV_CONFIG_GEN_SET >> 8);
   531	
   532		plen = 2;
   533		payload[0] = 0;
   534		payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
   535		payload[0] = cpu_to_be32(payload[0]);
   536		payload[1] = cpu_to_be32(payload[1]);
   537	
   538		resp_len = 5;
   539		memset(resp, 0, sizeof(resp));
   540		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, resp, resp_len);
   541	
   542		err = mmc_wait_for_cmd(host, &cmd, 0);
   543		if (err) {
   544			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
   545			       mmc_hostname(host), __func__, err);
   546			return -EIO;
   547		}
   548	
   549		/* Set host Config Setting registers */
   550		if (!host->ops->uhs2_control(host, UHS2_SET_CONFIG)) {
   551			pr_err("%s: %s: UHS2 SET_CONFIG fail!\n", mmc_hostname(host), __func__);
   552			return -EIO;
   553		}
   554	
   555		return 0;
   556	}
   557	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
