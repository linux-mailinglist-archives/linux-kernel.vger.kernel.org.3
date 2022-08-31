Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6065A88F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiHaWYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiHaWYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:24:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C24F14F0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661984679; x=1693520679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9NWdnoqf+O6O26orIczq8V8p4v7hr/baEiv5+Y4VkvU=;
  b=ZStGU62t3FHnLU1xAAYMq2S6MmsbXG/yX9wNS16q236YQEE7JKi11uDb
   CE0mm4A2w0gG3W6MHxNVVH2q+3wgK5zjuYqjDwmmDAa/JU+D+dSNVZlHw
   UEdjqT9gi3aNuz2Tb1AwOCtDxrDBlkEh/RntPr3tflTpEn/RwCAesFrjD
   fFi8AqcmrB09QNbBYr2OLu0Vv05UFcuqMheBznDyelechDx1iRV0/aA3h
   vuhaqD/vqWG9S9lI/9BGK2svFbZVdZWm1fBvLNB+IUKC8pDYj0bairNoD
   wusU7f5tDzWZ7uiLfdFet5rX8yzX/nOAg3JMJ+U4HyM1pxkbX3aSfOYFO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="381853631"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="381853631"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 15:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="940594907"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2022 15:24:32 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTW8N-0000ly-2B;
        Wed, 31 Aug 2022 22:24:31 +0000
Date:   Thu, 1 Sep 2022 06:24:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Timo Alho <talho@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: drivers/firmware/tegra/bpmp.c:204:17: sparse: sparse: incorrect type
 in argument 2 (different address spaces)
Message-ID: <202209010603.Ui3eZ89D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5e4d5e99162ba8025d58a3af7ad103f155d2df7
commit: a4740b148a04dc60e14fe6a1dfe216d3bae214fd firmware: tegra: bpmp: Do only aligned access to IPC memory area
date:   10 weeks ago
config: arm-randconfig-s042-20220831 (https://download.01.org/0day-ci/archive/20220901/202209010603.Ui3eZ89D-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a4740b148a04dc60e14fe6a1dfe216d3bae214fd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a4740b148a04dc60e14fe6a1dfe216d3bae214fd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/firmware/tegra/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/tegra/bpmp.c:204:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got unsigned char * @@
   drivers/firmware/tegra/bpmp.c:204:17: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/firmware/tegra/bpmp.c:204:17: sparse:     got unsigned char *
>> drivers/firmware/tegra/bpmp.c:248:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got unsigned char * @@
   drivers/firmware/tegra/bpmp.c:248:17: sparse:     expected void volatile [noderef] __iomem *to
   drivers/firmware/tegra/bpmp.c:248:17: sparse:     got unsigned char *
   drivers/firmware/tegra/bpmp.c:423:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got unsigned char * @@
   drivers/firmware/tegra/bpmp.c:423:17: sparse:     expected void volatile [noderef] __iomem *to
   drivers/firmware/tegra/bpmp.c:423:17: sparse:     got unsigned char *
   drivers/firmware/tegra/bpmp.c:505:53: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] mrq @@     got restricted __le32 [usertype] @@
   drivers/firmware/tegra/bpmp.c:505:53: sparse:     expected unsigned int [usertype] mrq
   drivers/firmware/tegra/bpmp.c:505:53: sparse:     got restricted __le32 [usertype]

vim +204 drivers/firmware/tegra/bpmp.c

   197	
   198	static ssize_t __tegra_bpmp_channel_read(struct tegra_bpmp_channel *channel,
   199						 void *data, size_t size, int *ret)
   200	{
   201		int err;
   202	
   203		if (data && size > 0)
 > 204			memcpy_fromio(data, channel->ib->data, size);
   205	
   206		err = tegra_bpmp_ack_response(channel);
   207		if (err < 0)
   208			return err;
   209	
   210		*ret = channel->ib->code;
   211	
   212		return 0;
   213	}
   214	
   215	static ssize_t tegra_bpmp_channel_read(struct tegra_bpmp_channel *channel,
   216					       void *data, size_t size, int *ret)
   217	{
   218		struct tegra_bpmp *bpmp = channel->bpmp;
   219		unsigned long flags;
   220		ssize_t err;
   221		int index;
   222	
   223		index = tegra_bpmp_channel_get_thread_index(channel);
   224		if (index < 0) {
   225			err = index;
   226			goto unlock;
   227		}
   228	
   229		spin_lock_irqsave(&bpmp->lock, flags);
   230		err = __tegra_bpmp_channel_read(channel, data, size, ret);
   231		clear_bit(index, bpmp->threaded.allocated);
   232		spin_unlock_irqrestore(&bpmp->lock, flags);
   233	
   234	unlock:
   235		up(&bpmp->threaded.lock);
   236	
   237		return err;
   238	}
   239	
   240	static ssize_t __tegra_bpmp_channel_write(struct tegra_bpmp_channel *channel,
   241						  unsigned int mrq, unsigned long flags,
   242						  const void *data, size_t size)
   243	{
   244		channel->ob->code = mrq;
   245		channel->ob->flags = flags;
   246	
   247		if (data && size > 0)
 > 248			memcpy_toio(channel->ob->data, data, size);
   249	
   250		return tegra_bpmp_post_request(channel);
   251	}
   252	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
