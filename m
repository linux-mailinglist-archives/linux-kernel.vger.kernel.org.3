Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7674BCF10
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiBTOmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:42:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiBTOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:42:05 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D61D0D6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 06:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645368103; x=1676904103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Z8zDh3Yv0piKL5w+7BoRO4epVkGNJymFFSSeTelIDI=;
  b=l/zpoRb4U9SCJoUTrK/8ZhjdbyyU7b3oN/j0ZPamAWQeakaHxiaosdYX
   s4CRTjLt0r2rTgpNOs0E3ak7/pcvuhjE5empM4Q7jTsKSVa9wRSW8eIu2
   N32SUVqnukeN0bSwyHGKPvFdnDZVABmP0VYFdSTxy6rVF1dPGCC2PG5VS
   ri+lBtE/mvUAWZ0mMZcDIciaUeXOrtv2sXaqp67FsOish4YPFG8S5Efw9
   v4dPJ5ZtuqPK1bTetbx5PpLGIoVV7dD3DlMsGbPXEDIrCOa5NcxbnP9cj
   840VC9Gl54/Wu9Uo62JBUBOuj3Byr0uxm73GVSuSSqs68Rm8qERtcyML/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="250198315"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="250198315"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 06:41:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="705933204"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2022 06:41:40 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLnPA-0000Ok-7P; Sun, 20 Feb 2022 14:41:40 +0000
Date:   Sun, 20 Feb 2022 22:41:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 521/552]
 drivers/dma/apple-admac.c:353:6: warning: no previous prototype for
 'admac_start_current_tx'
Message-ID: <202202202235.KKqNQju1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: bee62b9888b1bd6bd610383080a17ba0c9bb215b [521/552] dmaengine: apple-admac: Add Apple ADMAC driver
config: nds32-randconfig-p002-20220220 (https://download.01.org/0day-ci/archive/20220220/202202202235.KKqNQju1-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/bee62b9888b1bd6bd610383080a17ba0c9bb215b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout bee62b9888b1bd6bd610383080a17ba0c9bb215b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma/apple-admac.c:132:14: warning: no previous prototype for 'admac_tx_submit' [-Wmissing-prototypes]
     132 | dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
         |              ^~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:154:33: warning: no previous prototype for 'admac_prep_dma_cyclic' [-Wmissing-prototypes]
     154 | struct dma_async_tx_descriptor *admac_prep_dma_cyclic(
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:2:
   drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
   drivers/dma/apple-admac.c:200:26: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     200 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ^~~
   include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                             ^~~~~~~
   drivers/dma/apple-admac.c:200:9: note: in expansion of macro 'dev_dbg'
     200 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |         ^~~~~~~
   drivers/dma/apple-admac.c:200:54: note: format string is defined here
     200 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |                                                   ~~~^
         |                                                      |
         |                                                      long long unsigned int
         |                                                   %x
   drivers/dma/apple-admac.c:204:53: warning: right shift count >= width of type [-Wshift-count-overflow]
     204 |         admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
         |                                                     ^~
   drivers/dma/apple-admac.c: At top level:
   drivers/dma/apple-admac.c:228:5: warning: no previous prototype for 'admac_alloc_chan_resources' [-Wmissing-prototypes]
     228 | int admac_alloc_chan_resources(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:233:6: warning: no previous prototype for 'admac_free_chan_resources' [-Wmissing-prototypes]
     233 | void admac_free_chan_resources(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:238:5: warning: no previous prototype for 'admac_ring_noccupied_slots' [-Wmissing-prototypes]
     238 | int admac_ring_noccupied_slots(int ringval)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c: In function 'admac_ring_noccupied_slots':
   drivers/dma/apple-admac.c:240:22: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     240 |         int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
         |                      ^~~~~~~~~
         |                      FOLL_GET
   drivers/dma/apple-admac.c: At top level:
   drivers/dma/apple-admac.c:258:5: warning: no previous prototype for 'admac_cyclic_read_residue' [-Wmissing-prototypes]
     258 | u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:284:17: warning: no previous prototype for 'admac_tx_status' [-Wmissing-prototypes]
     284 | enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
         |                 ^~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:353:6: warning: no previous prototype for 'admac_start_current_tx' [-Wmissing-prototypes]
     353 | void admac_start_current_tx(struct admac_chan *adchan)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:367:6: warning: no previous prototype for 'admac_issue_pending' [-Wmissing-prototypes]
     367 | void admac_issue_pending(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:386:5: warning: no previous prototype for 'admac_pause' [-Wmissing-prototypes]
     386 | int admac_pause(struct dma_chan *chan)
         |     ^~~~~~~~~~~
   drivers/dma/apple-admac.c:395:5: warning: no previous prototype for 'admac_resume' [-Wmissing-prototypes]
     395 | int admac_resume(struct dma_chan *chan)
         |     ^~~~~~~~~~~~
   drivers/dma/apple-admac.c:404:5: warning: no previous prototype for 'admac_terminate_all' [-Wmissing-prototypes]
     404 | int admac_terminate_all(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for NFSD_V2_ACL
   Depends on NETWORK_FILESYSTEMS && NFSD
   Selected by
   - NFSD_V3_ACL && NETWORK_FILESYSTEMS


vim +/admac_start_current_tx +353 drivers/dma/apple-admac.c

   352	
 > 353	void admac_start_current_tx(struct admac_chan *adchan)
   354	{
   355		struct admac_data *ad = adchan->host;
   356		int ch = adchan->no;
   357	
   358		admac_poke(ad, REG_CHAN_INTSTATUS1(ch), STATUS_DESC_DONE | STATUS_ERR);
   359		admac_poke(ad, REG_CHAN_CTL(ch), REG_CHAN_CTL_RST_RINGS);
   360		admac_poke(ad, REG_CHAN_CTL(ch), 0);
   361	
   362		admac_cyclic_write_one_desc(ad, ch, adchan->current_tx);
   363		admac_start_chan(adchan);
   364		admac_cyclic_write_desc(ad, ch, adchan->current_tx);
   365	}
   366	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
