Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93644E2177
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbiCUHjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiCUHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:39:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45628DAD;
        Mon, 21 Mar 2022 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647848303; x=1679384303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cpzD0G7WlQb79BAELGk4nC4vtuBs/ikyOE9n2dBg9kk=;
  b=lROo1YEysYVD3MraDwexTTJ0ra5QLQpbXT9LhrHuwaDHuhfWJl/Kxvd1
   fbEesNzBt6zS304KKBAW/Wp/5b9Sn7MA+w8QrLxU5/bu9zD/o3A/Pc22u
   LZVdlvmIAI0/mCRG0cw0tfenhUCMYl3UYIeQN4NUt/jYyuHd5GGzQmeKZ
   4fn41c3cqP5KyUGFYyv8w+MWFZhbn/+esY07Qk5z5k/6oW1PvIurSzrjJ
   n5YKZBkXHDKctMd9uWdK2cY535MCcezh/uvrooI1NpRbJ15XB8WmB4EW8
   4UpIPtx0SkxtUyTIRSzun0Vp34UDLnNWmk5os35WVuqyt922ZLjYKfAEM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="320694522"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="320694522"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 00:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="648466434"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2022 00:38:20 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWCcN-000Hbn-NW; Mon, 21 Mar 2022 07:38:19 +0000
Date:   Mon, 21 Mar 2022 15:38:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manish Mandlik <mmandlik@google.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     kbuild-all@lists.01.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Add Intel devcoredump support
Message-ID: <202203211500.z1bvoo6A-lkp@intel.com>
References: <20220320183225.2.I61857ea92be43418b8ce16839f79a4704cc89fa6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320183225.2.I61857ea92be43418b8ce16839f79a4704cc89fa6@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master v5.17 next-20220318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Manish-Mandlik/Bluetooth-Add-support-for-devcoredump/20220321-093553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
config: parisc-randconfig-r023-20220320 (https://download.01.org/0day-ci/archive/20220321/202203211500.z1bvoo6A-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/677f482cb7027ab030842015cfd6c188568df39f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Manish-Mandlik/Bluetooth-Add-support-for-devcoredump/20220321-093553
        git checkout 677f482cb7027ab030842015cfd6c188568df39f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/bluetooth/btintel.c: In function 'btintel_register_devcoredump_support':
>> drivers/bluetooth/btintel.c:1447:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
    1447 |         strncpy(driver_name, driver, DRIVER_NAME_LEN);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +1447 drivers/bluetooth/btintel.c

  1429	
  1430	int btintel_register_devcoredump_support(struct hci_dev *hdev,
  1431						 const char *driver)
  1432	{
  1433		struct intel_debug_features features;
  1434		int err;
  1435	
  1436		err = btintel_read_debug_features(hdev, &features);
  1437		if (err) {
  1438			bt_dev_info(hdev, "Error reading debug features");
  1439			return err;
  1440		}
  1441	
  1442		if (!(features.page1[0] & 0x3f)) {
  1443			bt_dev_info(hdev, "Telemetry exception format not supported");
  1444			return -EOPNOTSUPP;
  1445		}
  1446	
> 1447		strncpy(driver_name, driver, DRIVER_NAME_LEN);
  1448		hci_devcoredump_register(hdev, btintel_dmp_hdr, NULL);
  1449	
  1450		return err;
  1451	}
  1452	EXPORT_SYMBOL_GPL(btintel_register_devcoredump_support);
  1453	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
