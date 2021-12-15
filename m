Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F51475B20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbhLOO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:56:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:61197 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237581AbhLOO4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639580165; x=1671116165;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W62eW/yOP2Q9UGzDWMEmW0hbRyBQFVzMOINX49L6lgE=;
  b=XbrEhb/SLTJIym++VgF1+7ikFIEPGG1RfsZbFVGbSTIdQ0Xg7JHcxF1+
   4tzt5Mx/ZmpiGMrbnq8Zozr779M9/bFm7WoNfjp0LJM1azs5e2Cpo52sD
   +01C+a5TrQ0ft81bGwZKnEdH7AfEnNhxzQhnvEDYjjfVQQgdI2wXdA90p
   WdoQzhWCHqEX/S32G8nqKMoXeM+4Dr3fZCr5LyNXzX3xjmjn2NvIrz8CO
   yiXo9VkVAx0+5QWiA2W7DbI9uhuVBahnK2iq6vDeRi/vQzxwDqThktNUM
   DU4NTNot0DlLky5FztEEjWJM21kMYCPCynkfIKvY+M+jgt2G6Rb+2mZZ4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226100457"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226100457"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 06:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="614726272"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2021 06:56:04 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxVhL-0001up-EF; Wed, 15 Dec 2021 14:56:03 +0000
Date:   Wed, 15 Dec 2021 22:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:touchpad/wip 79/82]
 drivers/hid/spi-hid/spi-hid-apple.c:177:22: warning: no previous prototype
 for 'spihid_get_data'
Message-ID: <202112152218.CbejumOS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux touchpad/wip
head:   a2281d64fdbcbab0dae68c6ea75bd5b548332e06
commit: 49c089b290128ddba454c0341a9906337e24751e [79/82] WIP: hid: transport: spi: add apple SPI transport
config: nds32-allyesconfig (https://download.01.org/0day-ci/archive/20211215/202112152218.CbejumOS-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/49c089b290128ddba454c0341a9906337e24751e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux touchpad/wip
        git checkout 49c089b290128ddba454c0341a9906337e24751e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/spi-hid/spi-hid-apple.c:177:22: warning: no previous prototype for 'spihid_get_data' [-Wmissing-prototypes]
     177 | struct spihid_apple *spihid_get_data(struct spihid_input_dev *idev)
         |                      ^~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple.c:189:5: warning: no previous prototype for 'apple_ll_start' [-Wmissing-prototypes]
     189 | int apple_ll_start(struct hid_device *hdev)
         |     ^~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple.c:195:6: warning: no previous prototype for 'apple_ll_stop' [-Wmissing-prototypes]
     195 | void apple_ll_stop(struct hid_device *hdev)
         |      ^~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple.c:202:5: warning: no previous prototype for 'apple_ll_open' [-Wmissing-prototypes]
     202 | int apple_ll_open(struct hid_device *hdev)
         |     ^~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple.c:218:6: warning: no previous prototype for 'apple_ll_close' [-Wmissing-prototypes]
     218 | void apple_ll_close(struct hid_device *hdev)
         |      ^~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple.c:225:5: warning: no previous prototype for 'apple_ll_parse' [-Wmissing-prototypes]
     225 | int apple_ll_parse(struct hid_device *hdev)
         |     ^~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple.c:233:5: warning: no previous prototype for 'apple_ll_raw_request' [-Wmissing-prototypes]
     233 | int apple_ll_raw_request(struct hid_device *hdev, unsigned char reportnum,
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple.c:257:5: warning: no previous prototype for 'apple_ll_output_report' [-Wmissing-prototypes]
     257 | int apple_ll_output_report(struct hid_device *hdev, __u8 *buf, size_t len)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/spi-hid/spi-hid-apple.c: In function 'spi_hid_apple_probe':
   drivers/hid/spi-hid/spi-hid-apple.c:735:15: error: implicit declaration of function 'devm_request_threaded_irq'; did you mean 'devm_request_region'? [-Werror=implicit-function-declaration]
     735 |         err = devm_request_threaded_irq(dev, spihid->irq, NULL,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~
         |               devm_request_region
   drivers/hid/spi-hid/spi-hid-apple.c:736:60: error: 'IRQF_ONESHOT' undeclared (first use in this function); did you mean 'SA_ONESHOT'?
     736 |                                         spi_hid_apple_irq, IRQF_ONESHOT,
         |                                                            ^~~~~~~~~~~~
         |                                                            SA_ONESHOT
   drivers/hid/spi-hid/spi-hid-apple.c:736:60: note: each undeclared identifier is reported only once for each function it appears in
   drivers/hid/spi-hid/spi-hid-apple.c: In function 'spi_hid_apple_remove':
   drivers/hid/spi-hid/spi-hid-apple.c:794:9: error: implicit declaration of function 'disable_irq'; did you mean 'disable_fpu'? [-Werror=implicit-function-declaration]
     794 |         disable_irq(spihid->irq);
         |         ^~~~~~~~~~~
         |         disable_fpu
   cc1: some warnings being treated as errors


vim +/spihid_get_data +177 drivers/hid/spi-hid/spi-hid-apple.c

   176	
 > 177	struct spihid_apple *spihid_get_data(struct spihid_input_dev *idev)
   178	{
   179		switch (idev->id) {
   180		case SPI_HID_DEVICE_ID_KBD:
   181			return container_of(idev, struct spihid_apple, kbd);
   182		case SPI_HID_DEVICE_ID_TP:
   183			return container_of(idev, struct spihid_apple, tp);
   184		default:
   185			return NULL;
   186		}
   187	}
   188	
 > 189	int apple_ll_start(struct hid_device *hdev)
   190	{
   191		/* no-op SPI transport is already setup */
   192		return 0;
   193	};
   194	
 > 195	void apple_ll_stop(struct hid_device *hdev)
   196	{
   197		/* no-op, devices will be desstroyed on driver destruction */
   198		struct spihid_input_dev *idev = hdev->driver_data;
   199		printk(KERN_DEBUG "spihid_apple %s - dev:%hhu", __func__, idev->id);
   200	}
   201	
 > 202	int apple_ll_open(struct hid_device *hdev)
   203	{
   204		struct spihid_apple *spihid;
   205		struct spihid_input_dev *idev = hdev->driver_data;
   206		printk(KERN_DEBUG "spihid_apple %s - dev:%hhu", __func__, idev->id);
   207	
   208		if (idev->hid_desc_len == 0) {
   209			spihid = spihid_get_data(idev);
   210			dev_warn(&spihid->spidev->dev,
   211				 "HID descriptor missing for dev %u", idev->id);
   212		} else
   213			idev->ready = true;
   214	
   215		return 0;
   216	}
   217	
 > 218	void apple_ll_close(struct hid_device *hdev)
   219	{
   220		struct spihid_input_dev *idev = hdev->driver_data;
   221		printk(KERN_DEBUG "spihid_apple %s - dev:%hhu", __func__, idev->id);
   222		idev->ready = false;
   223	}
   224	
 > 225	int apple_ll_parse(struct hid_device *hdev)
   226	{
   227		struct spihid_input_dev *idev = hdev->driver_data;
   228		printk(KERN_DEBUG "spihid_apple %s idev->id:%hhu", __func__, idev->id);
   229	
   230		return hid_parse_report(hdev, idev->hid_desc, idev->hid_desc_len);
   231	}
   232	
 > 233	int apple_ll_raw_request(struct hid_device *hdev, unsigned char reportnum,
   234				 __u8 *buf, size_t len, unsigned char rtype,
   235				 int reqtype)
   236	{
   237		struct spihid_input_dev *idev = hdev->driver_data;
   238		struct spihid_apple *spihid = spihid_get_data(idev);
   239	
   240		dev_dbg(&spihid->spidev->dev, "%s reqtype:%d size:%zu", __func__,
   241			reqtype, len);
   242	
   243		switch (reqtype) {
   244		case HID_REQ_GET_REPORT:
   245			return 0;
   246			// return i2c_hid_get_raw_report(hid, reportnum, buf, len, rtype);
   247		case HID_REQ_SET_REPORT:
   248			if (buf[0] != reportnum)
   249				return -EINVAL;
   250			return 0;
   251			// return i2c_hid_output_raw_report(hid, buf, len, rtype, true);
   252		default:
   253			return -EIO;
   254		}
   255	}
   256	
 > 257	int apple_ll_output_report(struct hid_device *hdev, __u8 *buf, size_t len)
   258	{
   259		struct spihid_input_dev *idev = hdev->driver_data;
   260		struct spihid_apple *spihid = spihid_get_data(idev);
   261		if (!spihid)
   262			return -1;
   263	
   264		dev_dbg(&spihid->spidev->dev, "%s", __func__);
   265	
   266		return 0;
   267	}
   268	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
