Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3703B4C8F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbiCAP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiCAP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:57:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A280B56C2E;
        Tue,  1 Mar 2022 07:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646150194; x=1677686194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dbno6f2IDbHjP13l+blnOurXonIAQbpx6n0jL1TaOYY=;
  b=W6UUN38HCXC+hkRb8YQ1BnA35zx+Ggy2W7moz7rBu9Us3+6c5f2H5A7Q
   i6XOYjexiu+ei3YfHxxH9tBsEh8PfXORAu50EvdWIVr121iBa6BGJ7GtE
   ILEm2rV8fZh+YCxp22EnyiQPfr/OOhh6Qsvk8EhQ2QdltCIMoGFxyeADL
   qeHlSIpH4dX6+jDH2+zixUgbxQh5XpZEfcTvEXg1tvtli2JBfX18ydQTC
   MMZrV/XODJL4qLsf0osPl85Q8iiiQzE94Nb/Sm3xwzkv7kbkT64hHEIJh
   LTH99tWcVUZ6SdsDPUhChySbOAlK2jkj2EVDmxWjhehqkMamiN0Hwfz4r
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233129340"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233129340"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="575741547"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2022 07:56:30 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP4rW-0000ew-24; Tue, 01 Mar 2022 15:56:30 +0000
Date:   Tue, 1 Mar 2022 23:55:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] mmc: rtsx: Fix build errors/warnings for unused variable
Message-ID: <202203012329.tsb96XPG-lkp@intel.com>
References: <20220301115300.64332-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301115300.64332-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220228]
[cannot apply to soc/for-next linux/master linus/master v5.17-rc6 v5.17-rc5 v5.17-rc4 v5.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ulf-Hansson/mmc-rtsx-Fix-build-errors-warnings-for-unused-variable/20220301-195325
base:    6705cd745adbbeac6b13002c7a30060f7b2568a5
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220301/202203012329.tsb96XPG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/392366d45e7f16e01727e7e82a08085301ca3de8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ulf-Hansson/mmc-rtsx-Fix-build-errors-warnings-for-unused-variable/20220301-195325
        git checkout 392366d45e7f16e01727e7e82a08085301ca3de8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mmc/host/rtsx_pci_sdmmc.c:825:22: error: use of undeclared identifier 'dev'
           pm_runtime_get_sync(dev);
                               ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:862:28: error: use of undeclared identifier 'dev'
           pm_runtime_mark_last_busy(dev);
                                     ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:863:29: error: use of undeclared identifier 'dev'
           pm_runtime_put_autosuspend(dev);
                                      ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1094:22: error: use of undeclared identifier 'dev'
           pm_runtime_get_sync(dev);
                               ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1128:28: error: use of undeclared identifier 'dev'
           pm_runtime_mark_last_busy(dev);
                                     ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1129:29: error: use of undeclared identifier 'dev'
           pm_runtime_put_autosuspend(dev);
                                      ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1144:22: error: use of undeclared identifier 'dev'
           pm_runtime_get_sync(dev);
                               ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1154:28: error: use of undeclared identifier 'dev'
           pm_runtime_mark_last_busy(dev);
                                     ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1155:29: error: use of undeclared identifier 'dev'
           pm_runtime_put_autosuspend(dev);
                                      ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1172:22: error: use of undeclared identifier 'dev'
           pm_runtime_get_sync(dev);
                               ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1182:28: error: use of undeclared identifier 'dev'
           pm_runtime_mark_last_busy(dev);
                                     ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1183:29: error: use of undeclared identifier 'dev'
           pm_runtime_put_autosuspend(dev);
                                      ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1280:22: error: use of undeclared identifier 'dev'
           pm_runtime_get_sync(dev);
                               ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1310:28: error: use of undeclared identifier 'dev'
           pm_runtime_mark_last_busy(dev);
                                     ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1311:29: error: use of undeclared identifier 'dev'
           pm_runtime_put_autosuspend(dev);
                                      ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1331:22: error: use of undeclared identifier 'dev'
           pm_runtime_get_sync(dev);
                               ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1364:28: error: use of undeclared identifier 'dev'
           pm_runtime_mark_last_busy(dev);
                                     ^
   drivers/mmc/host/rtsx_pci_sdmmc.c:1365:29: error: use of undeclared identifier 'dev'
           pm_runtime_put_autosuspend(dev);
                                      ^
   18 errors generated.


vim +/dev +825 drivers/mmc/host/rtsx_pci_sdmmc.c

6291e7153a173f Micky Ching   2014-06-06  798  
6291e7153a173f Micky Ching   2014-06-06  799  static void sd_request(struct work_struct *work)
6291e7153a173f Micky Ching   2014-06-06  800  {
6291e7153a173f Micky Ching   2014-06-06  801  	struct realtek_pci_sdmmc *host = container_of(work,
6291e7153a173f Micky Ching   2014-06-06  802  			struct realtek_pci_sdmmc, work);
ff984e57d36e8a Wei WANG      2012-10-29  803  	struct rtsx_pcr *pcr = host->pcr;
6291e7153a173f Micky Ching   2014-06-06  804  
6291e7153a173f Micky Ching   2014-06-06  805  	struct mmc_host *mmc = host->mmc;
6291e7153a173f Micky Ching   2014-06-06  806  	struct mmc_request *mrq = host->mrq;
ff984e57d36e8a Wei WANG      2012-10-29  807  	struct mmc_command *cmd = mrq->cmd;
ff984e57d36e8a Wei WANG      2012-10-29  808  	struct mmc_data *data = mrq->data;
6291e7153a173f Micky Ching   2014-06-06  809  
ff984e57d36e8a Wei WANG      2012-10-29  810  	unsigned int data_size = 0;
c3481955f6c78c Wei WANG      2013-02-08  811  	int err;
ff984e57d36e8a Wei WANG      2012-10-29  812  
b22217f966f585 Micky Ching   2015-01-14  813  	if (host->eject || !sd_get_cd_int(host)) {
ff984e57d36e8a Wei WANG      2012-10-29  814  		cmd->error = -ENOMEDIUM;
ff984e57d36e8a Wei WANG      2012-10-29  815  		goto finish;
ff984e57d36e8a Wei WANG      2012-10-29  816  	}
ff984e57d36e8a Wei WANG      2012-10-29  817  
c3481955f6c78c Wei WANG      2013-02-08  818  	err = rtsx_pci_card_exclusive_check(host->pcr, RTSX_SD_CARD);
c3481955f6c78c Wei WANG      2013-02-08  819  	if (err) {
c3481955f6c78c Wei WANG      2013-02-08  820  		cmd->error = err;
c3481955f6c78c Wei WANG      2013-02-08  821  		goto finish;
c3481955f6c78c Wei WANG      2013-02-08  822  	}
c3481955f6c78c Wei WANG      2013-02-08  823  
98fcc5762dcecb Micky Ching   2014-04-29  824  	mutex_lock(&pcr->pcr_mutex);
7499b529d97f75 Kai-Heng Feng 2022-01-25 @825  	pm_runtime_get_sync(dev);
98fcc5762dcecb Micky Ching   2014-04-29  826  
ff984e57d36e8a Wei WANG      2012-10-29  827  	rtsx_pci_start_run(pcr);
ff984e57d36e8a Wei WANG      2012-10-29  828  
ff984e57d36e8a Wei WANG      2012-10-29  829  	rtsx_pci_switch_clock(pcr, host->clock, host->ssc_depth,
ff984e57d36e8a Wei WANG      2012-10-29  830  			host->initial_mode, host->double_clk, host->vpclk);
ff984e57d36e8a Wei WANG      2012-10-29  831  	rtsx_pci_write_register(pcr, CARD_SELECT, 0x07, SD_MOD_SEL);
ff984e57d36e8a Wei WANG      2012-10-29  832  	rtsx_pci_write_register(pcr, CARD_SHARE_MODE,
ff984e57d36e8a Wei WANG      2012-10-29  833  			CARD_SHARE_MASK, CARD_SHARE_48_SD);
ff984e57d36e8a Wei WANG      2012-10-29  834  
98fcc5762dcecb Micky Ching   2014-04-29  835  	mutex_lock(&host->host_mutex);
98fcc5762dcecb Micky Ching   2014-04-29  836  	host->mrq = mrq;
98fcc5762dcecb Micky Ching   2014-04-29  837  	mutex_unlock(&host->host_mutex);
98fcc5762dcecb Micky Ching   2014-04-29  838  
ff984e57d36e8a Wei WANG      2012-10-29  839  	if (mrq->data)
ff984e57d36e8a Wei WANG      2012-10-29  840  		data_size = data->blocks * data->blksz;
ff984e57d36e8a Wei WANG      2012-10-29  841  
1dcb35799e8fb5 Micky Ching   2014-12-23  842  	if (!data_size) {
98fcc5762dcecb Micky Ching   2014-04-29  843  		sd_send_cmd_get_rsp(host, cmd);
1dcb35799e8fb5 Micky Ching   2014-12-23  844  	} else if (sd_rw_cmd(cmd) || sdio_extblock_cmd(cmd, data)) {
1dcb35799e8fb5 Micky Ching   2014-12-23  845  		cmd->error = sd_rw_multi(host, mrq);
6291e7153a173f Micky Ching   2014-06-06  846  		if (!host->using_cookie)
6291e7153a173f Micky Ching   2014-06-06  847  			sdmmc_post_req(host->mmc, host->mrq, 0);
98fcc5762dcecb Micky Ching   2014-04-29  848  
98fcc5762dcecb Micky Ching   2014-04-29  849  		if (mmc_op_multi(cmd->opcode) && mrq->stop)
98fcc5762dcecb Micky Ching   2014-04-29  850  			sd_send_cmd_get_rsp(host, mrq->stop);
ff984e57d36e8a Wei WANG      2012-10-29  851  	} else {
ff984e57d36e8a Wei WANG      2012-10-29  852  		sd_normal_rw(host, mrq);
ff984e57d36e8a Wei WANG      2012-10-29  853  	}
98fcc5762dcecb Micky Ching   2014-04-29  854  
98fcc5762dcecb Micky Ching   2014-04-29  855  	if (mrq->data) {
98fcc5762dcecb Micky Ching   2014-04-29  856  		if (cmd->error || data->error)
98fcc5762dcecb Micky Ching   2014-04-29  857  			data->bytes_xfered = 0;
98fcc5762dcecb Micky Ching   2014-04-29  858  		else
98fcc5762dcecb Micky Ching   2014-04-29  859  			data->bytes_xfered = data->blocks * data->blksz;
98fcc5762dcecb Micky Ching   2014-04-29  860  	}
98fcc5762dcecb Micky Ching   2014-04-29  861  
7499b529d97f75 Kai-Heng Feng 2022-01-25  862  	pm_runtime_mark_last_busy(dev);
7499b529d97f75 Kai-Heng Feng 2022-01-25  863  	pm_runtime_put_autosuspend(dev);
98fcc5762dcecb Micky Ching   2014-04-29  864  	mutex_unlock(&pcr->pcr_mutex);
ff984e57d36e8a Wei WANG      2012-10-29  865  
ff984e57d36e8a Wei WANG      2012-10-29  866  finish:
1dcb35799e8fb5 Micky Ching   2014-12-23  867  	if (cmd->error) {
1dcb35799e8fb5 Micky Ching   2014-12-23  868  		dev_dbg(sdmmc_dev(host), "CMD %d 0x%08x error(%d)\n",
1dcb35799e8fb5 Micky Ching   2014-12-23  869  			cmd->opcode, cmd->arg, cmd->error);
1dcb35799e8fb5 Micky Ching   2014-12-23  870  	}
98fcc5762dcecb Micky Ching   2014-04-29  871  
98fcc5762dcecb Micky Ching   2014-04-29  872  	mutex_lock(&host->host_mutex);
98fcc5762dcecb Micky Ching   2014-04-29  873  	host->mrq = NULL;
98fcc5762dcecb Micky Ching   2014-04-29  874  	mutex_unlock(&host->host_mutex);
98fcc5762dcecb Micky Ching   2014-04-29  875  
98fcc5762dcecb Micky Ching   2014-04-29  876  	mmc_request_done(mmc, mrq);
ff984e57d36e8a Wei WANG      2012-10-29  877  }
ff984e57d36e8a Wei WANG      2012-10-29  878  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
