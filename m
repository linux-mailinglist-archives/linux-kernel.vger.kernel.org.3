Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D138856B2FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbiGHGwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbiGHGwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:52:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710FD6EE99
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657263152; x=1688799152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UCgoIzNJOQavXa+zaiB+/6E4QSPY7V0WDfEQ5NKLVx4=;
  b=AUqHR2nKCQGImqiHUy2RCh8nJWiiP6zNtX9OncxqYvXz0Coum6SAIhSN
   mcIaMsb5+vbVKQEUtKA6HqCf/4hBzb9eQRuje/NqBleWdu/nWp5GaWWvh
   n4Bb71GiNjFix90vjROPOKZ+GILrfqdrZ1WgA4G/HRmcvAXadznLgtFME
   X5Ko11cJXjFrw3Qt7m+jNB24yLv5NKsdmUWjDtYtsPQZizzR9KcOPMYOS
   LuBjQdX0FFAh5VyOJL/mXadLKmQpTDjpVlRza5+xOUOMII9mqFdvrrYUh
   yqheMDOOjhSvLUmRRv9ItNr6QmURPAADdpeIl3recuq9CABu4mEFhoiCJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284949287"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="284949287"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 23:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="736239585"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2022 23:52:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9hqo-000N41-1V;
        Fri, 08 Jul 2022 06:52:30 +0000
Date:   Fri, 8 Jul 2022 14:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:t8112/bringup 16/19]
 drivers/hid/dockchannel-hid/dockchannel-hid.c:305:28: error: implicit
 declaration of function 'FIELD_PREP'
Message-ID: <202207081415.Rkx8mCkO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux t8112/bringup
head:   0e7640fed025ba0ce4b845a0bbf2a5fdceab631d
commit: f40be88d7f037e2b682492c4abf36b136d136d22 [16/19] hid: Add Apple DockChannel HID transport driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220708/202207081415.Rkx8mCkO-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/f40be88d7f037e2b682492c4abf36b136d136d22
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux t8112/bringup
        git checkout f40be88d7f037e2b682492c4abf36b136d136d22
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/hid/dockchannel-hid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_cmd':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:305:28: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     305 |         iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
         |                            ^~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from drivers/hid/dockchannel-hid/dockchannel-hid.c:10:
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_handle_ready':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:571:37: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     571 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:571:17: note: in expansion of macro 'dev_err'
     571 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:571:70: note: format string is defined here
     571 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                                                                    ~~^
         |                                                                      |
         |                                                                      long int
         |                                                                    %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_packet_work':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:812:20: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     812 |         int type = FIELD_GET(FLAGS_GROUP, shdr->flags);
         |                    ^~~~~~~~~
         |                    FOLL_GET
   In file included from include/linux/device.h:15,
                    from drivers/hid/dockchannel-hid/dockchannel-hid.c:10:
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:816:37: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'unsigned int' [-Wformat=]
     816 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:816:17: note: in expansion of macro 'dev_err'
     816 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:816:68: note: format string is defined here
     816 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                                                  ~~^
         |                                                                    |
         |                                                                    long int
         |                                                                  %d
   In file included from include/linux/device.h:15,
                    from drivers/hid/dockchannel-hid/dockchannel-hid.c:10:
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_handle_ack':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:842:44: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'unsigned int' [-Wformat=]
     842 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:842:17: note: in expansion of macro 'dev_err'
     842 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:842:75: note: format string is defined here
     842 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                                                         ~~^
         |                                                                           |
         |                                                                           long int
         |                                                                         %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dockchannel_hid_probe':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:962:14: warning: variable 'defer' set but not used [-Wunused-but-set-variable]
     962 |         bool defer = false;
         |              ^~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for APPLE_ADMAC
   Depends on DMADEVICES && (ARCH_APPLE || COMPILE_TEST
   Selected by
   - SND_SOC_APPLE_MCA && SOUND && !UML && SND && SND_SOC && (ARCH_APPLE || COMPILE_TEST


vim +/FIELD_PREP +305 drivers/hid/dockchannel-hid/dockchannel-hid.c

   294	
   295	static int dchid_cmd(struct dchid_iface *iface, u32 type, u32 req,
   296			     void *data, size_t size, void *resp_buf, size_t resp_size)
   297	{
   298		int ret;
   299		int report_id = *(u8*)data;
   300	
   301		mutex_lock(&iface->out_mutex);
   302	
   303		WARN_ON(iface->out_report != -1);
   304		iface->out_report = report_id;
 > 305		iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
   306		iface->resp_buf = resp_buf;
   307		iface->resp_size = resp_size;
   308		reinit_completion(&iface->out_complete);
   309	
   310		ret = dchid_send(iface, iface->out_flags, data, size);
   311		if (ret < 0)
   312			goto done;
   313	
   314		if (!wait_for_completion_timeout(&iface->out_complete, msecs_to_jiffies(1000))) {
   315			dev_err(iface->dchid->dev, "output report 0x%x to iface  %d (%s) timed out\n",
   316				report_id, iface->index, iface->name);
   317			ret = -ETIMEDOUT;
   318			goto done;
   319		}
   320	
   321		ret = iface->resp_size;
   322		if (iface->retcode) {
   323			dev_err(iface->dchid->dev,
   324				"output report 0x%x to iface %d (%s) failed with err 0x%x\n",
   325				report_id, iface->index, iface->name, iface->retcode);
   326			ret = -EIO;
   327		}
   328	
   329	done:
   330		iface->tx_seq++;
   331		iface->out_report = -1;
   332		iface->out_flags = 0;
   333		iface->resp_buf = NULL;
   334		iface->resp_size = 0;
   335		mutex_unlock(&iface->out_mutex);
   336		return ret;
   337	}
   338	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
