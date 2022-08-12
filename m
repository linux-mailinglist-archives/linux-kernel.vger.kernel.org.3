Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B4B591322
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiHLPgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiHLPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:36:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2055F61B0A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660318559; x=1691854559;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9nCkuBoIInZ7STf7GvlqrGGfkSDNn9Q9zATuL7B0rxA=;
  b=epjK+bg4lxpwauTaOPI2u1HJmO6Z9Cq35jXoscn5otULmfSukK5sl7ou
   FsYteV9v2VbXj+y4L2+ghDPR2VaUPTC1dmYpYzwRR8qhpUj+3ZSe59toS
   +hG7xVz1pNPGzMafCafJN9uwHEG1esKrT3QVIj1UH/P8rJnyX6ciXX85h
   WlPpXwTMOcbw95ieBDucxWjH0aJS9qgZui6wRf9KoctRt/nqIcvdcoWTb
   XEZOfeJZTq48za9LgItHDul9pUGUYq5FTy89DS6UhE/l8jrwkh3e7H/Ay
   ejk5mhihR7cGQMRXi+/NvONLm/OC/znExDU8FuXZMStugOsywXD4zDJR0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="271388771"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="271388771"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 08:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="556548117"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Aug 2022 08:35:47 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMWhO-0000gN-2L;
        Fri, 12 Aug 2022 15:35:46 +0000
Date:   Fri, 12 Aug 2022 23:35:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 17/22]
 drivers/hid/dockchannel-hid/dockchannel-hid.c:303:28: error: implicit
 declaration of function 'FIELD_PREP'
Message-ID: <202208122354.DE7laDoz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   cc847c79fbb5106249dcfd91aa041cce0116c897
commit: 55af457be82d0853857bab148c649a328aa58ffa [17/22] hid: Add Apple DockChannel HID transport driver
config: riscv-randconfig-s041-20220811 (https://download.01.org/0day-ci/archive/20220812/202208122354.DE7laDoz-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/55af457be82d0853857bab148c649a328aa58ffa
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 55af457be82d0853857bab148c649a328aa58ffa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/hid/dockchannel-hid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_cmd':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:303:28: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     303 |         iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
         |                            ^~~~~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_packet_work':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:825:20: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     825 |         int type = FIELD_GET(FLAGS_GROUP, shdr->flags);
         |                    ^~~~~~~~~
         |                    FOLL_GET
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dockchannel_hid_probe':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:975:14: warning: variable 'defer' set but not used [-Wunused-but-set-variable]
     975 |         bool defer = false;
         |              ^~~~~
   cc1: some warnings being treated as errors


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
