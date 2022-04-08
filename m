Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFEB4F9EED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbiDHVOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbiDHVON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:14:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99D18857E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649452328; x=1680988328;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oOnE/mTJZo1cLGs58Bcvu0FFjsM9iac91CNW9O8kwGw=;
  b=l9X72tegVRuJnsrdR7AZYivAyfjEl9mqFPKJ8stm7XrG4GRc4JN78/iY
   wSETKojPqL0lbpxhgvyvQnd+Q4I/LKyqDWLuxozG9RQyfVUyTmqa/bOpm
   lsWefWmajBOom6p45Dfh1rOBConVKwEIQ2j3IyDZEXP+qXToMrLgp4YcR
   yXwVjFxcSeg3c5KejobksQZkaHKxOpJhU0OEwWWfyt2kv2akfv0oAT++I
   8fGRoaMsIqn4DHB+fMIkKPdIegLR/ploE5pzjZUQKrOuvfE1XpF1T+fQO
   jYM4H/WIURQ2EkHuX2wWH5t+LmvfHFfdJyulQ08dvMiaKn9mASeR8UJAT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="249213359"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="249213359"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 14:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="698314316"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 14:12:05 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncvtk-0000dw-Li;
        Fri, 08 Apr 2022 21:12:04 +0000
Date:   Sat, 9 Apr 2022 05:11:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     gellert <gellert@raspberrypi.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Lukas Wunner <lukas@wunner.de>,
        Yaroslav Rosomakho <yaroslavros@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Juerg Haefliger <juergh@canonical.com>
Subject: [l1k:smsc95xx_5.17 62/888] drivers/mmc/host/bcm2835-mmc.c:655:6:
 warning: no previous prototype for 'bcm2835_mmc_send_command'
Message-ID: <202204090513.DJZRq10M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: 07021b7ee2fdb60a60c3289c983cc1c1d1494c71 [62/888] MMC: added alternative MMC driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220409/202204090513.DJZRq10M-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/07021b7ee2fdb60a60c3289c983cc1c1d1494c71
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 07021b7ee2fdb60a60c3289c983cc1c1d1494c71
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/lib/ drivers/char/ drivers/gpio/ drivers/mmc/host/ drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/bcm2835-mmc.c:655:6: warning: no previous prototype for 'bcm2835_mmc_send_command' [-Wmissing-prototypes]
     655 | void bcm2835_mmc_send_command(struct bcm2835_host *host, struct mmc_command *cmd)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/bcm2835-mmc.c:1063:6: warning: no previous prototype for 'bcm2835_mmc_set_clock' [-Wmissing-prototypes]
    1063 | void bcm2835_mmc_set_clock(struct bcm2835_host *host, unsigned int clock)
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/bcm2835_mmc_send_command +655 drivers/mmc/host/bcm2835-mmc.c

   654	
 > 655	void bcm2835_mmc_send_command(struct bcm2835_host *host, struct mmc_command *cmd)
   656	{
   657		int flags;
   658		u32 mask;
   659		unsigned long timeout;
   660	
   661		WARN_ON(host->cmd);
   662	
   663		/* Wait max 10 ms */
   664		timeout = 1000;
   665	
   666		mask = SDHCI_CMD_INHIBIT;
   667		if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
   668			mask |= SDHCI_DATA_INHIBIT;
   669	
   670		/* We shouldn't wait for data inihibit for stop commands, even
   671		   though they might use busy signaling */
   672		if (host->mrq->data && (cmd == host->mrq->data->stop))
   673			mask &= ~SDHCI_DATA_INHIBIT;
   674	
   675		while (bcm2835_mmc_readl(host, SDHCI_PRESENT_STATE) & mask) {
   676			if (timeout == 0) {
   677				pr_err("%s: Controller never released inhibit bit(s).\n",
   678					mmc_hostname(host->mmc));
   679				bcm2835_mmc_dumpregs(host);
   680				cmd->error = -EIO;
   681				tasklet_schedule(&host->finish_tasklet);
   682				return;
   683			}
   684			timeout--;
   685			udelay(10);
   686		}
   687	
   688		if ((1000-timeout)/100 > 1 && (1000-timeout)/100 > host->max_delay) {
   689			host->max_delay = (1000-timeout)/100;
   690			pr_warn("Warning: MMC controller hung for %d ms\n", host->max_delay);
   691		}
   692	
   693		timeout = jiffies;
   694		if (!cmd->data && cmd->busy_timeout > 9000)
   695			timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
   696		else
   697			timeout += 10 * HZ;
   698		mod_timer(&host->timer, timeout);
   699	
   700		host->cmd = cmd;
   701		host->use_dma = false;
   702	
   703		bcm2835_mmc_prepare_data(host, cmd);
   704	
   705		bcm2835_mmc_writel(host, cmd->arg, SDHCI_ARGUMENT, 6);
   706	
   707		bcm2835_mmc_set_transfer_mode(host, cmd);
   708	
   709		if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
   710			pr_err("%s: Unsupported response type!\n",
   711				mmc_hostname(host->mmc));
   712			cmd->error = -EINVAL;
   713			tasklet_schedule(&host->finish_tasklet);
   714			return;
   715		}
   716	
   717		if (!(cmd->flags & MMC_RSP_PRESENT))
   718			flags = SDHCI_CMD_RESP_NONE;
   719		else if (cmd->flags & MMC_RSP_136)
   720			flags = SDHCI_CMD_RESP_LONG;
   721		else if (cmd->flags & MMC_RSP_BUSY)
   722			flags = SDHCI_CMD_RESP_SHORT_BUSY;
   723		else
   724			flags = SDHCI_CMD_RESP_SHORT;
   725	
   726		if (cmd->flags & MMC_RSP_CRC)
   727			flags |= SDHCI_CMD_CRC;
   728		if (cmd->flags & MMC_RSP_OPCODE)
   729			flags |= SDHCI_CMD_INDEX;
   730	
   731		if (cmd->data)
   732			flags |= SDHCI_CMD_DATA;
   733	
   734		bcm2835_mmc_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
   735	}
   736	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
