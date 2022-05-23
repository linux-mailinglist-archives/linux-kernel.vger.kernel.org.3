Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF25307C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353107AbiEWCms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353070AbiEWCmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:42:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D4377CB
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653273753; x=1684809753;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TqjUYBj3xQpANT+99CewSw6nfFUz70d/qo8dv6oPqz0=;
  b=ZuLnVAUTe5McWc9XfaaK301qy/Qq96/Z1J/YK3eZ2KL6UMzk7wfsYBs3
   MaRnBBrRi/fSB95yUe4qAdPuS1Vcom8iLtPcPI+XQKC/FZ6ZdehCGa0L3
   8pzGezIGh5kL3wr0ZHzbg+dAl9WoxqK/vYtaverTnL5fQblpWrKpxWblH
   ciX6aoHmkQktZPpsAFL0TDdZO+c16v2Oj3xJrqRAbAZMF5GqSf9mTtua1
   JhwPecyTstYOZ7hj8bep0YZnjadFAy65sIBzSMBGHhJOy8cHsePiR32fs
   EJxQmoL76lktK/Va1rApxy7ZiR9Itvz+TChF8VUgf8LXrBhwPI1aIWh90
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="359476666"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="359476666"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 19:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="744475767"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 May 2022 19:42:31 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsy1e-0000pS-JY;
        Mon, 23 May 2022 02:42:30 +0000
Date:   Mon, 23 May 2022 10:42:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tomoyo-tomoyo-test1:master 1/1] drivers/staging/wfx/bh.c:298:2:
 warning: call to __warn_flushing_systemwide_wq declared with 'warning'
 attribute: Please avoid flushing system-wide workqueues.
Message-ID: <202205231025.i4fdy5M0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git master
head:   84baad17cb8286b6b53b675f8c3d7343ee6a990c
commit: 84baad17cb8286b6b53b675f8c3d7343ee6a990c [1/1] workqueue: Wrap flush_workqueue() using a macro
config: hexagon-randconfig-r045-20220522 (https://download.01.org/0day-ci/archive/20220523/202205231025.i4fdy5M0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 768a1ca5eccb678947f4155e38a5f5744dcefb56)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add tomoyo-tomoyo-test1 git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git
        git fetch --no-tags tomoyo-tomoyo-test1 master
        git checkout 84baad17cb8286b6b53b675f8c3d7343ee6a990c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/infiniband/core/ drivers/input/mouse/ drivers/staging/wfx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/wfx/bh.c:298:2: warning: call to __warn_flushing_systemwide_wq declared with 'warning' attribute: Please avoid flushing system-wide workqueues. [-Wattribute-warning]
           flush_workqueue(system_highpri_wq);
           ^
   include/linux/workqueue.h:695:3: note: expanded from macro 'flush_workqueue'
                   __warn_flushing_systemwide_wq();                        \
                   ^
   1 warning generated.
--
>> drivers/staging/wfx/hif_tx.c:76:3: warning: call to __warn_flushing_systemwide_wq declared with 'warning' attribute: Please avoid flushing system-wide workqueues. [-Wattribute-warning]
                   flush_workqueue(system_highpri_wq);
                   ^
   include/linux/workqueue.h:695:3: note: expanded from macro 'flush_workqueue'
                   __warn_flushing_systemwide_wq();                        \
                   ^
   1 warning generated.
--
>> drivers/input/mouse/psmouse-smbus.c:320:2: warning: call to __warn_flushing_systemwide_wq declared with 'warning' attribute: Please avoid flushing system-wide workqueues. [-Wattribute-warning]
           flush_scheduled_work();
           ^
   include/linux/workqueue.h:705:32: note: expanded from macro 'flush_scheduled_work'
   #define flush_scheduled_work() flush_workqueue(system_wq)
                                  ^
   include/linux/workqueue.h:695:3: note: expanded from macro 'flush_workqueue'
                   __warn_flushing_systemwide_wq();                        \
                   ^
   1 warning generated.
--
>> drivers/infiniband/core/device.c:2857:2: warning: call to __warn_flushing_systemwide_wq declared with 'warning' attribute: Please avoid flushing system-wide workqueues. [-Wattribute-warning]
           flush_workqueue(system_unbound_wq);
           ^
   include/linux/workqueue.h:695:3: note: expanded from macro 'flush_workqueue'
                   __warn_flushing_systemwide_wq();                        \
                   ^
   1 warning generated.


vim +/warning +298 drivers/staging/wfx/bh.c

b0998f0c040daf Jérôme Pouiller 2019-09-19  285  
f545b23d477552 Jérôme Pouiller 2022-01-13  286  /* If IRQ is not available, this function allow to manually poll the control register and simulate
f545b23d477552 Jérôme Pouiller 2022-01-13  287   * an IRQ ahen an event happened.
57aa557f110d9f Jérôme Pouiller 2020-05-05  288   *
f545b23d477552 Jérôme Pouiller 2022-01-13  289   * Note that the device has a bug: If an IRQ raise while host read control register, the IRQ is
f545b23d477552 Jérôme Pouiller 2022-01-13  290   * lost. So, use this function carefully (only duing device initialisation).
57aa557f110d9f Jérôme Pouiller 2020-05-05  291   */
57aa557f110d9f Jérôme Pouiller 2020-05-05  292  void wfx_bh_poll_irq(struct wfx_dev *wdev)
57aa557f110d9f Jérôme Pouiller 2020-05-05  293  {
57aa557f110d9f Jérôme Pouiller 2020-05-05  294  	ktime_t now, start;
57aa557f110d9f Jérôme Pouiller 2020-05-05  295  	u32 reg;
57aa557f110d9f Jérôme Pouiller 2020-05-05  296  
f00dc1d789e1ca Jérôme Pouiller 2020-05-05  297  	WARN(!wdev->poll_irq, "unexpected IRQ polling can mask IRQ");
c86176d51340d5 Jérôme Pouiller 2022-02-25 @298  	flush_workqueue(system_highpri_wq);
57aa557f110d9f Jérôme Pouiller 2020-05-05  299  	start = ktime_get();
57aa557f110d9f Jérôme Pouiller 2020-05-05  300  	for (;;) {
c1d193c5058e72 Jérôme Pouiller 2022-01-13  301  		wfx_control_reg_read(wdev, &reg);
57aa557f110d9f Jérôme Pouiller 2020-05-05  302  		now = ktime_get();
57aa557f110d9f Jérôme Pouiller 2020-05-05  303  		if (reg & 0xFFF)
57aa557f110d9f Jérôme Pouiller 2020-05-05  304  			break;
57aa557f110d9f Jérôme Pouiller 2020-05-05  305  		if (ktime_after(now, ktime_add_ms(start, 1000))) {
57aa557f110d9f Jérôme Pouiller 2020-05-05  306  			dev_err(wdev->dev, "time out while polling control register\n");
57aa557f110d9f Jérôme Pouiller 2020-05-05  307  			return;
57aa557f110d9f Jérôme Pouiller 2020-05-05  308  		}
57aa557f110d9f Jérôme Pouiller 2020-05-05  309  		udelay(200);
57aa557f110d9f Jérôme Pouiller 2020-05-05  310  	}
57aa557f110d9f Jérôme Pouiller 2020-05-05  311  	wfx_bh_request_rx(wdev);
57aa557f110d9f Jérôme Pouiller 2020-05-05  312  }
57aa557f110d9f Jérôme Pouiller 2020-05-05  313  

:::::: The code at line 298 was first introduced by commit
:::::: c86176d51340d5ee29afffce63d79c4ece5d96bb staging: wfx: ensure HIF request has been sent before polling

:::::: TO: Jérôme Pouiller <jerome.pouiller@silabs.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
