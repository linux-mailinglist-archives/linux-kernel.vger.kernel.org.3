Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D252DB17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiESRYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiESRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:23:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB05DA2041
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652981035; x=1684517035;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rmHlTnocugMXl43hhk1m0uJc87YdMHzmKW4SZgB6Jpc=;
  b=UlTq3dyicXKgunakgMQuP6iCD1xxTScADaoWXPrP7V7WYK/t78vPuMzg
   j+6/8vDxbgRURrN0VANfnV/XJzTXfvbCg4338O/TnJ0s9HO7gvUnIgOmi
   26/EmY4cslUS1uwBN2Fg/pr31KMvHJdgiCRz2XHq/3cfwnseaEs/VoR2j
   RWMFUDL7I4M8dF5fm2LDAHQK3JeOues92VYjSlg+xpaPmu6U1T5IjU7ub
   Gm4Thjfn7r7TEEOA3MyZHeLE0aIPhiuPNLZaKL6950Gfh9Mt3/PGwqrPw
   HwpolBXjtwIjfcbow7kLjkGXJTenY5mMzYIte1Mg/KuAZIPIKTdKpZQiu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="269877593"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="269877593"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 10:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="715093600"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2022 10:23:53 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrjsO-0003mn-VX;
        Thu, 19 May 2022 17:23:52 +0000
Date:   Fri, 20 May 2022 01:23:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/4.19 12/15]
 drivers/mmc/core/mmc_ops.c:960:13: warning: variable 'timeout' set but not
 used
Message-ID: <202205200128.tZ7qf9BZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/4.19
head:   735c11789c15fd96455c15316570d55569afada4
commit: 200a3e31fe3e70a6b3c3ab587be7ae82c238ad6a [12/15] mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
config: microblaze-buildonly-randconfig-r001-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200128.tZ7qf9BZ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/200a3e31fe3e70a6b3c3ab587be7ae82c238ad6a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/4.19
        git checkout 200a3e31fe3e70a6b3c3ab587be7ae82c238ad6a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/mmc/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/mmc/core/mmc_ops.c: In function 'mmc_start_bkops':
>> drivers/mmc/core/mmc_ops.c:960:13: warning: variable 'timeout' set but not used [-Wunused-but-set-variable]
     960 |         int timeout;
         |             ^~~~~~~


vim +/timeout +960 drivers/mmc/core/mmc_ops.c

1cf8f7e5af3910 Ulf Hansson   2017-06-09   946  
1cf8f7e5af3910 Ulf Hansson   2017-06-09   947  /**
1cf8f7e5af3910 Ulf Hansson   2017-06-09   948   *	mmc_start_bkops - start BKOPS for supported cards
1cf8f7e5af3910 Ulf Hansson   2017-06-09   949   *	@card: MMC card to start BKOPS
e5d0e17bb6022d Shawn Lin     2017-07-04   950   *	@from_exception: A flag to indicate if this function was
1cf8f7e5af3910 Ulf Hansson   2017-06-09   951   *			 called due to an exception raised by the card
1cf8f7e5af3910 Ulf Hansson   2017-06-09   952   *
1cf8f7e5af3910 Ulf Hansson   2017-06-09   953   *	Start background operations whenever requested.
1cf8f7e5af3910 Ulf Hansson   2017-06-09   954   *	When the urgent BKOPS bit is set in a R1 command response
1cf8f7e5af3910 Ulf Hansson   2017-06-09   955   *	then background operations should be started immediately.
1cf8f7e5af3910 Ulf Hansson   2017-06-09   956  */
1cf8f7e5af3910 Ulf Hansson   2017-06-09   957  void mmc_start_bkops(struct mmc_card *card, bool from_exception)
1cf8f7e5af3910 Ulf Hansson   2017-06-09   958  {
1cf8f7e5af3910 Ulf Hansson   2017-06-09   959  	int err;
1cf8f7e5af3910 Ulf Hansson   2017-06-09  @960  	int timeout;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   961  	bool use_busy_signal;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   962  
1cf8f7e5af3910 Ulf Hansson   2017-06-09   963  	if (!card->ext_csd.man_bkops_en || mmc_card_doing_bkops(card))
1cf8f7e5af3910 Ulf Hansson   2017-06-09   964  		return;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   965  
1cf8f7e5af3910 Ulf Hansson   2017-06-09   966  	err = mmc_read_bkops_status(card);
1cf8f7e5af3910 Ulf Hansson   2017-06-09   967  	if (err) {
1cf8f7e5af3910 Ulf Hansson   2017-06-09   968  		pr_err("%s: Failed to read bkops status: %d\n",
1cf8f7e5af3910 Ulf Hansson   2017-06-09   969  		       mmc_hostname(card->host), err);
1cf8f7e5af3910 Ulf Hansson   2017-06-09   970  		return;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   971  	}
1cf8f7e5af3910 Ulf Hansson   2017-06-09   972  
1cf8f7e5af3910 Ulf Hansson   2017-06-09   973  	if (!card->ext_csd.raw_bkops_status)
1cf8f7e5af3910 Ulf Hansson   2017-06-09   974  		return;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   975  
1cf8f7e5af3910 Ulf Hansson   2017-06-09   976  	if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2 &&
1cf8f7e5af3910 Ulf Hansson   2017-06-09   977  	    from_exception)
1cf8f7e5af3910 Ulf Hansson   2017-06-09   978  		return;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   979  
1cf8f7e5af3910 Ulf Hansson   2017-06-09   980  	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
1cf8f7e5af3910 Ulf Hansson   2017-06-09   981  		timeout = MMC_OPS_TIMEOUT_MS;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   982  		use_busy_signal = true;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   983  	} else {
1cf8f7e5af3910 Ulf Hansson   2017-06-09   984  		timeout = 0;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   985  		use_busy_signal = false;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   986  	}
1cf8f7e5af3910 Ulf Hansson   2017-06-09   987  
1cf8f7e5af3910 Ulf Hansson   2017-06-09   988  	mmc_retune_hold(card->host);
1cf8f7e5af3910 Ulf Hansson   2017-06-09   989  
1cf8f7e5af3910 Ulf Hansson   2017-06-09   990  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
200a3e31fe3e70 Ulf Hansson   2022-05-17   991  			EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS, 0,
1cf8f7e5af3910 Ulf Hansson   2017-06-09   992  			use_busy_signal, true, false);
1cf8f7e5af3910 Ulf Hansson   2017-06-09   993  	if (err) {
1cf8f7e5af3910 Ulf Hansson   2017-06-09   994  		pr_warn("%s: Error %d starting bkops\n",
1cf8f7e5af3910 Ulf Hansson   2017-06-09   995  			mmc_hostname(card->host), err);
1cf8f7e5af3910 Ulf Hansson   2017-06-09   996  		mmc_retune_release(card->host);
9ca28c5cd967e0 Adrian Hunter 2017-09-22   997  		return;
1cf8f7e5af3910 Ulf Hansson   2017-06-09   998  	}
1cf8f7e5af3910 Ulf Hansson   2017-06-09   999  
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1000  	/*
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1001  	 * For urgent bkops status (LEVEL_2 and more)
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1002  	 * bkops executed synchronously, otherwise
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1003  	 * the operation is in progress
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1004  	 */
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1005  	if (!use_busy_signal)
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1006  		mmc_card_set_doing_bkops(card);
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1007  	else
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1008  		mmc_retune_release(card->host);
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1009  }
cb39f61e9b1e67 Adrian Hunter 2017-09-22  1010  EXPORT_SYMBOL(mmc_start_bkops);
1cf8f7e5af3910 Ulf Hansson   2017-06-09  1011  

:::::: The code at line 960 was first introduced by commit
:::::: 1cf8f7e5af3910781a21b84f13a34851aa228fe3 mmc: core: Move mmc bkops functions from core.c to mmc_ops.c

:::::: TO: Ulf Hansson <ulf.hansson@linaro.org>
:::::: CC: Ulf Hansson <ulf.hansson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
