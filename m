Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C63485604
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbiAEPix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:38:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:13792 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbiAEPiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641397130; x=1672933130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Udd+hqo7mjhdSgvH5P3a4lWSts8UFfCNta3ovtkSO6c=;
  b=KexXNOutqlJ4oAfe5EVWcd62QggYHX503loDTBwE9a2ISOpDNnHkmlnS
   dlCypG0T2nJOq/HZH6ImiHGc/BYCukACfdmQI3a/2r1HoecyF4/ztcQL2
   rbfrJxYhLcJwSi2F60GhC1IxCtYEtyjCI/Qz4mxFwLrwTc3hChyk6zZMA
   j0aZzpza8TziLRuTiH1/TdN/ebX3ab7kO3YG8srmO7585Nx4muFZ5Asqd
   KDc0ALE4BsXQ2fWuhhl2/TBOenL/FhhPk6ggMEyoWJQOpiT3V9Jc6ExrJ
   SloWsb8BOpPH9H83lfgRGukceNdP7aIGaVuz5L313DCdDiY0PPGThJm4o
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242423546"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="242423546"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 07:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="512991328"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 07:38:45 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n58NA-000Go7-IG; Wed, 05 Jan 2022 15:38:44 +0000
Date:   Wed, 5 Jan 2022 23:38:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Travkin <nikita@trvn.ru>, dmitry.torokhov@gmail.com
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org,
        Michael.Srba@seznam.cz, linus.walleij@linaro.org,
        broonie@kernel.org, luca@z3ntu.xyz, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] input: zinitix: Add touchkey support
Message-ID: <202201052355.c806rw3s-lkp@intel.com>
References: <20220105060323.7928-7-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105060323.7928-7-nikita@trvn.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on robh/for-next hid/for-next linus/master v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nikita-Travkin/Add-touch-keys-support-to-the-Zinitix-touch-driver/20220105-140610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: powerpc-randconfig-s031-20220105 (https://download.01.org/0day-ci/archive/20220105/202201052355.c806rw3s-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/545e0de93da58f29350c2908498a4621f5ef59e4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nikita-Travkin/Add-touch-keys-support-to-the-Zinitix-touch-driver/20220105-140610
        git checkout 545e0de93da58f29350c2908498a4621f5ef59e4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/ata/ drivers/input/touchscreen/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/input/touchscreen/zinitix.c:371:24: sparse: sparse: restricted __le16 degrades to integer

vim +371 drivers/input/touchscreen/zinitix.c

   352	
   353	static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
   354	{
   355		struct bt541_ts_data *bt541 = bt541_handler;
   356		struct i2c_client *client = bt541->client;
   357		struct touch_event touch_event;
   358		int error;
   359		int i;
   360		__le16 icon_events = 0;
   361	
   362		memset(&touch_event, 0, sizeof(struct touch_event));
   363	
   364		error = zinitix_read_data(bt541->client, BT541_POINT_STATUS_REG,
   365					  &touch_event, sizeof(struct touch_event));
   366		if (error) {
   367			dev_err(&client->dev, "Failed to read in touchpoint struct\n");
   368			goto out;
   369		}
   370	
 > 371		if (touch_event.status & BIT_ICON_EVENT) {
   372			error = zinitix_read_data(bt541->client, BT541_ICON_STATUS_REG,
   373						  &icon_events, sizeof(icon_events));
   374			if (error) {
   375				dev_err(&client->dev, "Failed to read icon events\n");
   376				goto out;
   377			}
   378	
   379			zinitix_report_keys(bt541, le16_to_cpu(icon_events));
   380		}
   381	
   382		for (i = 0; i < MAX_SUPPORTED_FINGER_NUM; i++)
   383			if (touch_event.point_coord[i].sub_status & SUB_BIT_EXIST)
   384				zinitix_report_finger(bt541, i,
   385						      &touch_event.point_coord[i]);
   386	
   387		input_mt_sync_frame(bt541->input_dev);
   388		input_sync(bt541->input_dev);
   389	
   390	out:
   391		zinitix_write_cmd(bt541->client, BT541_CLEAR_INT_STATUS_CMD);
   392		return IRQ_HANDLED;
   393	}
   394	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
