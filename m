Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAEB585DA0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 07:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiGaFJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 01:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiGaFJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 01:09:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED313DE3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 22:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659244162; x=1690780162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4MkDPWucBtTo8n//4AUx9bX+U8MS5kpW1L2mV3z9Hj0=;
  b=kTV4kNppqWi0Re9UzjPC0dquGa5U/zTWeah3/kH5y/fwHe+sXKkcZCcr
   7SgA6x2s3O42QLTX/Zn8q89E5qf1/V2FJ6dQd5V+Bt9cYxhzOqKUuSAph
   5Cq7OoEwmAhNc2VHlYUxbkhaAU0fA49z//ouBe2RJRnGtpx8N6IRyqtKj
   bsokRJLQScGbwsayfsLl3jerapLvWbZNWYYPWHN/1YIEVZWNa8U+Pe5i5
   4QiggrDec5nZhevh5uBAazawASQcj9SvDTPphQR+6EWst+4OXgJ1nMe6x
   7DdFl5jOCXcuP4qLay0S1dTE1mzH5uZX+YNRXQwQc5keMTxsEG1CjjDVv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="269350450"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="269350450"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 22:09:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="728122968"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2022 22:09:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI1Ca-000DiT-0Z;
        Sun, 31 Jul 2022 05:09:20 +0000
Date:   Sun, 31 Jul 2022 13:08:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 17/21]
 drivers/hid/dockchannel-hid/dockchannel-hid.c:303:21: error: call to
 undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202207311303.fsxdJJ2i-lkp@intel.com>
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
head:   e784b825a3358d79e5da5d9426c6eb37f79819b3
commit: fca5de56d067159949909e595e6bf3ee10af0a91 [17/21] hid: Add Apple DockChannel HID transport driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20220731/202207311303.fsxdJJ2i-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/fca5de56d067159949909e595e6bf3ee10af0a91
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout fca5de56d067159949909e595e6bf3ee10af0a91
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hid/dockchannel-hid/

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
