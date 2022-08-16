Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8995961EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiHPSG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbiHPSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:06:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF18305C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660673160; x=1692209160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=49X/CqJK7o6r57TgsFbBXqQA3rnCet0L8eUbTEs6Z7U=;
  b=cKF5lZceKVOQl/sSkvBa7vr9kU08YUAZRQRY8B4IJyMzXW+G2W5MFgTA
   RVQfc6Z13wUwRdRsGrZQedP01J6R3dpvLy+7RV4wFoStxpOEqy6olk2JD
   fx5P/9QsprM+vOWqp2DVgarj0815io36VhfELZXRnhN1HN4i4xsKbYEQR
   o6lC56wY/1ZtnPo0sEIDiDg7HdiHd3nbX8PlwDavEXnjmpt629NyV3W0e
   /mklZGJ3VmyQuuxLCAht2Y6JX+flthrNWWLQH+9TusWH69vQ9/E1ePnV1
   TUqLFhNcFukiiyvPvH+H5tAhrbK2AapdsgIng8fKMeCK5miGQgJ4iSrvI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272060926"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="272060926"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 11:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="935019876"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 11:05:58 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO0ww-00007Y-11;
        Tue, 16 Aug 2022 18:05:58 +0000
Date:   Wed, 17 Aug 2022 02:05:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 17/22]
 drivers/hid/dockchannel-hid/dockchannel-hid.c:303:21: error: call to
 undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202208170255.mWeqUzWX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   480924e97dddd088c4ed360eb12ecf92a30f19b1
commit: 1d801ad9c4b08a5675701e82f600d9f462211a79 [17/22] hid: Add Apple DockChannel HID transport driver
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220817/202208170255.mWeqUzWX-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/1d801ad9c4b08a5675701e82f600d9f462211a79
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 1d801ad9c4b08a5675701e82f600d9f462211a79
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/hid/dockchannel-hid/ drivers/platform/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/hid/dockchannel-hid/dockchannel-hid.c:303:21: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
                              ^
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:569:62: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                   dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
                                                                      ~~~     ^~~~~~
                                                                      %zu
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:825:13: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           int type = FIELD_GET(FLAGS_GROUP, shdr->flags);
                      ^
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:830:18: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
                           shdr->length, work->hdr.length - sizeof(*shdr));
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:856:18: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
                           shdr->length, hdr->length - sizeof(*shdr));
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:975:7: warning: variable 'defer' set but not used [-Wunused-but-set-variable]
           bool defer = false;
                ^
   4 warnings and 2 errors generated.


vim +/FIELD_PREP +303 drivers/hid/dockchannel-hid/dockchannel-hid.c

   292	
   293	static int dchid_cmd(struct dchid_iface *iface, u32 type, u32 req,
   294			     void *data, size_t size, void *resp_buf, size_t resp_size)
   295	{
   296		int ret;
   297		int report_id = *(u8*)data;
   298	
   299		mutex_lock(&iface->out_mutex);
   300	
   301		WARN_ON(iface->out_report != -1);
   302		iface->out_report = report_id;
 > 303		iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
   304		iface->resp_buf = resp_buf;
   305		iface->resp_size = resp_size;
   306		reinit_completion(&iface->out_complete);
   307	
   308		ret = dchid_send(iface, iface->out_flags, data, size);
   309		if (ret < 0)
   310			goto done;
   311	
   312		if (!wait_for_completion_timeout(&iface->out_complete, msecs_to_jiffies(1000))) {
   313			dev_err(iface->dchid->dev, "output report 0x%x to iface  %d (%s) timed out\n",
   314				report_id, iface->index, iface->name);
   315			ret = -ETIMEDOUT;
   316			goto done;
   317		}
   318	
   319		ret = iface->resp_size;
   320		if (iface->retcode) {
   321			dev_err(iface->dchid->dev,
   322				"output report 0x%x to iface %d (%s) failed with err 0x%x\n",
   323				report_id, iface->index, iface->name, iface->retcode);
   324			ret = -EIO;
   325		}
   326	
   327	done:
   328		iface->tx_seq++;
   329		iface->out_report = -1;
   330		iface->out_flags = 0;
   331		iface->resp_buf = NULL;
   332		iface->resp_size = 0;
   333		mutex_unlock(&iface->out_mutex);
   334		return ret;
   335	}
   336	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
