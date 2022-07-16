Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316C1577178
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 22:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiGPU5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 16:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPU5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 16:57:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2E1C10A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658005058; x=1689541058;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NbZSQDIhF1WK4gTQXnAWuTTrGqcT5/UgIa62bZA/NgM=;
  b=hZhLD6lec44kthd4pqsNLPGRi1CIFH2PPfnFa+0iq1Ce9KdgSxjt30f2
   wLBVYzr1tiobQuHE0Ec0V28hRbAadOe75gDkW/b4Og0lSAAQq2+5aGZFA
   zgvq9+ppICt4zdwv1eFUWe05XNZK9nXAAeXTE+fQewYRAP46CXxzKqkYD
   tFnbxik1OcUUGhKQjo/ICBxCAi5ziOo1YQ2CxpzuR0a6Wgum4x48M2b3b
   jJcTXIwPjZzycbmf5BZeb1xFBQIxBPcYroW7PtqATYflkhErSYT/Fx3gK
   brDnAd0BFLpivZPYxW0oSW54SL8O7tYdODVw93dFCWOGHKoqqZLc+UfoE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="266413726"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="266413726"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 13:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="739030727"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2022 13:57:37 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCor2-000295-Nz;
        Sat, 16 Jul 2022 20:57:36 +0000
Date:   Sun, 17 Jul 2022 04:56:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 17/18]
 drivers/hid/dockchannel-hid/dockchannel-hid.c:304:28: error: implicit
 declaration of function 'FIELD_PREP'
Message-ID: <202207170409.ZBilnoON-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   2902ed1bd2d6ac439a835c53841122c7f3455a6c
commit: e24c3dd5875015f606e146e07ede25ae4d866fcc [17/18] hid: Add Apple DockChannel HID transport driver
config: openrisc-randconfig-c032-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170409.ZBilnoON-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/e24c3dd5875015f606e146e07ede25ae4d866fcc
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout e24c3dd5875015f606e146e07ede25ae4d866fcc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_cmd':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:304:28: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     304 |         iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
         |                            ^~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from drivers/hid/dockchannel-hid/dockchannel-hid.c:10:
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_handle_ready':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:570:37: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     570 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:570:17: note: in expansion of macro 'dev_err'
     570 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:570:70: note: format string is defined here
     570 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                                                                    ~~^
         |                                                                      |
         |                                                                      long int
         |                                                                    %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_packet_work':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:826:20: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     826 |         int type = FIELD_GET(FLAGS_GROUP, shdr->flags);
         |                    ^~~~~~~~~
         |                    FOLL_GET
   drivers/hid/dockchannel-hid/dockchannel-hid.c:830:37: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'unsigned int' [-Wformat=]
     830 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:830:17: note: in expansion of macro 'dev_err'
     830 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:830:68: note: format string is defined here
     830 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                                                  ~~^
         |                                                                    |
         |                                                                    long int
         |                                                                  %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_handle_ack':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:856:44: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'unsigned int' [-Wformat=]
     856 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:856:17: note: in expansion of macro 'dev_err'
     856 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:856:75: note: format string is defined here
     856 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                                                         ~~^
         |                                                                           |
         |                                                                           long int
         |                                                                         %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dockchannel_hid_probe':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:976:14: warning: variable 'defer' set but not used [-Wunused-but-set-variable]
     976 |         bool defer = false;
         |              ^~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +304 drivers/hid/dockchannel-hid/dockchannel-hid.c

   293	
   294	static int dchid_cmd(struct dchid_iface *iface, u32 type, u32 req,
   295			     void *data, size_t size, void *resp_buf, size_t resp_size)
   296	{
   297		int ret;
   298		int report_id = *(u8*)data;
   299	
   300		mutex_lock(&iface->out_mutex);
   301	
   302		WARN_ON(iface->out_report != -1);
   303		iface->out_report = report_id;
 > 304		iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
   305		iface->resp_buf = resp_buf;
   306		iface->resp_size = resp_size;
   307		reinit_completion(&iface->out_complete);
   308	
   309		ret = dchid_send(iface, iface->out_flags, data, size);
   310		if (ret < 0)
   311			goto done;
   312	
   313		if (!wait_for_completion_timeout(&iface->out_complete, msecs_to_jiffies(1000))) {
   314			dev_err(iface->dchid->dev, "output report 0x%x to iface  %d (%s) timed out\n",
   315				report_id, iface->index, iface->name);
   316			ret = -ETIMEDOUT;
   317			goto done;
   318		}
   319	
   320		ret = iface->resp_size;
   321		if (iface->retcode) {
   322			dev_err(iface->dchid->dev,
   323				"output report 0x%x to iface %d (%s) failed with err 0x%x\n",
   324				report_id, iface->index, iface->name, iface->retcode);
   325			ret = -EIO;
   326		}
   327	
   328	done:
   329		iface->tx_seq++;
   330		iface->out_report = -1;
   331		iface->out_flags = 0;
   332		iface->resp_buf = NULL;
   333		iface->resp_size = 0;
   334		mutex_unlock(&iface->out_mutex);
   335		return ret;
   336	}
   337	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
