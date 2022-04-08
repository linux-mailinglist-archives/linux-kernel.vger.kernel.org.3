Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A964F9FB1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbiDHWp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiDHWp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 18:45:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5410D2A735
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 15:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649457831; x=1680993831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/YUsEacme9zgEJS0g716IpeNDAcQA+qDcloDLKbaqRk=;
  b=Hm287s+58HsBjyySZk83HA8EEehPaCocueinyQQRmftr4+jZh2UrvT+R
   OP/7qCHu6fr/r+3iJJcJDn9AfquxLfCmEvo+nKhj91qGPQrYpzPBxQn7l
   iE3PFPbx4Gy/wX66Ie0v0YUXTHzFjXiGEBJ7JDZb2WzmtsQ+l3xfVIOgP
   5/GLHZJSV38HE2TL1w9evzZw2voZmUHYll4dvrk9ZaUFX/MWTqvLpJjII
   h9iL/2d7ntOWR4Is57RgvHFtFMRuiMIUdbkxa/mv4NkmvlDwVaBTc7K65
   SONmE1Cy9aKOHx1uEwQcqqLpuJA7HEoPO1QUknn2xjE41pzLrNZcqsjCO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="260552417"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="260552417"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 15:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="621819670"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2022 15:43:49 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncxKW-0000gn-Vl;
        Fri, 08 Apr 2022 22:43:48 +0000
Date:   Sat, 9 Apr 2022 06:43:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 63/888] drivers/mmc/host/bcm2835-sdhost.c:941:6:
 warning: no previous prototype for 'bcm2835_sdhost_send_command'
Message-ID: <202204090623.LSWv6fqx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: b4327d167cad927cc9ea17f690aa1692fb550c16 [63/888] Adding bcm2835-sdhost driver, and an overlay to enable it
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220409/202204090623.LSWv6fqx-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/b4327d167cad927cc9ea17f690aa1692fb550c16
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout b4327d167cad927cc9ea17f690aa1692fb550c16
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/lib/ drivers/char/ drivers/gpio/ drivers/mmc/host/ drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/bcm2835-sdhost.c:941:6: warning: no previous prototype for 'bcm2835_sdhost_send_command' [-Wmissing-prototypes]
     941 | bool bcm2835_sdhost_send_command(struct bcm2835_host *host,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/bcm2835-sdhost.c:1525:6: warning: no previous prototype for 'bcm2835_sdhost_set_clock' [-Wmissing-prototypes]
    1525 | void bcm2835_sdhost_set_clock(struct bcm2835_host *host, unsigned int clock)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/bcm2835-sdhost.c:1889:5: warning: no previous prototype for 'bcm2835_sdhost_add_host' [-Wmissing-prototypes]
    1889 | int bcm2835_sdhost_add_host(struct bcm2835_host *host)
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/bcm2835_sdhost_send_command +941 drivers/mmc/host/bcm2835-sdhost.c

   940	
 > 941	bool bcm2835_sdhost_send_command(struct bcm2835_host *host,
   942					 struct mmc_command *cmd)
   943	{
   944		u32 sdcmd, sdhsts;
   945		unsigned long timeout;
   946		int delay;
   947	
   948		WARN_ON(host->cmd);
   949		log_event("CMD<", cmd->opcode, cmd->arg);
   950	
   951		if (cmd->data)
   952			pr_debug("%s: send_command %d 0x%x "
   953				 "(flags 0x%x) - %s %d*%d\n",
   954				 mmc_hostname(host->mmc),
   955				 cmd->opcode, cmd->arg, cmd->flags,
   956				 (cmd->data->flags & MMC_DATA_READ) ?
   957				 "read" : "write", cmd->data->blocks,
   958				 cmd->data->blksz);
   959		else
   960			pr_debug("%s: send_command %d 0x%x (flags 0x%x)\n",
   961				 mmc_hostname(host->mmc),
   962				 cmd->opcode, cmd->arg, cmd->flags);
   963	
   964		/* Wait max 100 ms */
   965		timeout = 10000;
   966	
   967		while (bcm2835_sdhost_read(host, SDCMD) & SDCMD_NEW_FLAG) {
   968			if (timeout == 0) {
   969				pr_warn("%s: previous command never completed.\n",
   970					mmc_hostname(host->mmc));
   971				if (host->debug)
   972					bcm2835_sdhost_dumpregs(host);
   973				cmd->error = -EILSEQ;
   974				tasklet_schedule(&host->finish_tasklet);
   975				return false;
   976			}
   977			timeout--;
   978			udelay(10);
   979		}
   980	
   981		delay = (10000 - timeout)/100;
   982		if (delay > host->max_delay) {
   983			host->max_delay = delay;
   984			pr_warn("%s: controller hung for %d ms\n",
   985				   mmc_hostname(host->mmc),
   986				   host->max_delay);
   987		}
   988	
   989		timeout = jiffies;
   990		if (!cmd->data && cmd->busy_timeout > 9000)
   991			timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
   992		else
   993			timeout += 10 * HZ;
   994		mod_timer(&host->timer, timeout);
   995	
   996		host->cmd = cmd;
   997	
   998		/* Clear any error flags */
   999		sdhsts = bcm2835_sdhost_read(host, SDHSTS);
  1000		if (sdhsts & SDHSTS_ERROR_MASK)
  1001			bcm2835_sdhost_write(host, sdhsts, SDHSTS);
  1002	
  1003		if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
  1004			pr_err("%s: unsupported response type!\n",
  1005				mmc_hostname(host->mmc));
  1006			cmd->error = -EINVAL;
  1007			tasklet_schedule(&host->finish_tasklet);
  1008			return false;
  1009		}
  1010	
  1011		bcm2835_sdhost_prepare_data(host, cmd);
  1012	
  1013		bcm2835_sdhost_write(host, cmd->arg, SDARG);
  1014	
  1015		sdcmd = cmd->opcode & SDCMD_CMD_MASK;
  1016	
  1017		host->use_busy = 0;
  1018		if (!(cmd->flags & MMC_RSP_PRESENT)) {
  1019			sdcmd |= SDCMD_NO_RESPONSE;
  1020		} else {
  1021			if (cmd->flags & MMC_RSP_136)
  1022				sdcmd |= SDCMD_LONG_RESPONSE;
  1023			if (cmd->flags & MMC_RSP_BUSY) {
  1024				sdcmd |= SDCMD_BUSYWAIT;
  1025				host->use_busy = 1;
  1026			}
  1027		}
  1028	
  1029		if (cmd->data) {
  1030			log_event("CMDD", cmd->data->blocks, cmd->data->blksz);
  1031			if (host->delay_after_this_stop) {
  1032				struct timespec64 now;
  1033				int time_since_stop;
  1034	
  1035				ktime_get_real_ts64(&now);
  1036				time_since_stop = now.tv_sec - host->stop_time.tv_sec;
  1037				if (time_since_stop < 2) {
  1038					/* Possibly less than one second */
  1039					time_since_stop = time_since_stop * 1000000 +
  1040						(now.tv_nsec - host->stop_time.tv_nsec)/1000;
  1041					if (time_since_stop <
  1042					    host->delay_after_this_stop)
  1043						udelay(host->delay_after_this_stop -
  1044						       time_since_stop);
  1045				}
  1046			}
  1047	
  1048			host->delay_after_this_stop = host->delay_after_stop;
  1049			if ((cmd->data->flags & MMC_DATA_READ) && !host->use_sbc) {
  1050				/* See if read crosses one of the hazardous sectors */
  1051				u32 first_blk, last_blk;
  1052	
  1053				/* Intentionally include the following sector because
  1054				   without CMD23/SBC the read may run on. */
  1055				first_blk = host->mrq->cmd->arg;
  1056				last_blk = first_blk + cmd->data->blocks;
  1057	
  1058				if (((last_blk >= (host->sectors - 64)) &&
  1059				     (first_blk <= (host->sectors - 64))) ||
  1060				    ((last_blk >= (host->sectors - 32)) &&
  1061				     (first_blk <= (host->sectors - 32)))) {
  1062					host->delay_after_this_stop =
  1063						max(250u, host->delay_after_stop);
  1064				}
  1065			}
  1066	
  1067			if (cmd->data->flags & MMC_DATA_WRITE)
  1068				sdcmd |= SDCMD_WRITE_CMD;
  1069			if (cmd->data->flags & MMC_DATA_READ)
  1070				sdcmd |= SDCMD_READ_CMD;
  1071		}
  1072	
  1073		bcm2835_sdhost_write(host, sdcmd | SDCMD_NEW_FLAG, SDCMD);
  1074	
  1075		return true;
  1076	}
  1077	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
