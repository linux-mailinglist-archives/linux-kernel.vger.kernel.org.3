Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1FB4FE6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348985AbiDLRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbiDLRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:17:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD833B543
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649783703; x=1681319703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NV8VN9IiHyiIWysazEs9Ul1t5DZqEtxyomRkbpXMdDk=;
  b=Q+4dvr5o9Yi+u2Uxr/akZ0h7fl7hZZNvS+JDuL+IroWXA0xDiqoCei42
   RTwzg2ACRFUd/usI81TJonX4bgv6ob2VSPqbORWImTuVffYSL3vsR6sEh
   /GD/q+ynyb4vmQ/cFEhM2g/FbZfAj2CQkg7IB6f851F3HMVlimvN+mM8c
   1kVpIQSwymTNpgxDic5693MIm60y6dIR5TDv8A4NdTxSDS7iwP7HieCmn
   AAyOAMOkQjL+hZ/9jxitx0ZiJC9rdq60BecR7n5sYFU9bIN/2V3EtOIKm
   SyOtC3nFDw+BUHytFK8+I8bI+TPWwquBHoxOWqDOEKwCGc2y8kil+DuXE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261295549"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="261295549"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 10:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="507639342"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Apr 2022 10:15:00 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neK6W-00031Q-7s;
        Tue, 12 Apr 2022 17:15:00 +0000
Date:   Wed, 13 Apr 2022 01:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/char/ipmi/ipmi_msghandler.c:5283:17: warning: 'strncpy'
 specified bound 11 equals destination size
Message-ID: <202204130109.hJ8G1iNz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
date:   4 months ago
config: arm64-buildonly-randconfig-r003-20220412 (https://download.01.org/0day-ci/archive/20220413/202204130109.hJ8G1iNz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd03762ab608e058c8f390ad9cf667e490089796
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/char/ipmi/ipmi_msghandler.c: In function 'send_panic_events':
>> drivers/char/ipmi/ipmi_msghandler.c:5283:17: warning: 'strncpy' specified bound 11 equals destination size [-Wstringop-truncation]
    5283 |                 strncpy(data+5, p, 11);
         |                 ^~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +5283 drivers/char/ipmi/ipmi_msghandler.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  5143  
a567b6230066e3 Corey Minyard  2018-04-05  5144  static void send_panic_events(struct ipmi_smi *intf, char *str)
^1da177e4c3f41 Linus Torvalds 2005-04-16  5145  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5146  	struct kernel_ipmi_msg msg;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5147  	unsigned char data[16];
^1da177e4c3f41 Linus Torvalds 2005-04-16  5148  	struct ipmi_system_interface_addr *si;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5149  	struct ipmi_addr addr;
91e2dd0a47bae1 Corey Minyard  2018-03-28  5150  	char *p = str;
91e2dd0a47bae1 Corey Minyard  2018-03-28  5151  	struct ipmi_ipmb_addr *ipmb;
91e2dd0a47bae1 Corey Minyard  2018-03-28  5152  	int j;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5153  
1c9f98d1bfbd06 Corey Minyard  2017-08-18  5154  	if (ipmi_send_panic_event == IPMI_SEND_PANIC_EVENT_NONE)
1c9f98d1bfbd06 Corey Minyard  2017-08-18  5155  		return;
1c9f98d1bfbd06 Corey Minyard  2017-08-18  5156  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5157  	si = (struct ipmi_system_interface_addr *) &addr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5158  	si->addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5159  	si->channel = IPMI_BMC_CHANNEL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5160  	si->lun = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5161  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5162  	/* Fill in an event telling that we have failed. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5163  	msg.netfn = 0x04; /* Sensor or Event. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5164  	msg.cmd = 2; /* Platform event command. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5165  	msg.data = data;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5166  	msg.data_len = 8;
cda315aba34ff4 Matt Domsch    2005-12-12  5167  	data[0] = 0x41; /* Kernel generator ID, IPMI table 5-4 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5168  	data[1] = 0x03; /* This is for IPMI 1.0. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5169  	data[2] = 0x20; /* OS Critical Stop, IPMI table 36-3 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5170  	data[4] = 0x6f; /* Sensor specific, IPMI table 36-1 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5171  	data[5] = 0xa1; /* Runtime stop OEM bytes 2 & 3. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5172  
c70d749986f6f1 Corey Minyard  2008-04-29  5173  	/*
c70d749986f6f1 Corey Minyard  2008-04-29  5174  	 * Put a few breadcrumbs in.  Hopefully later we can add more things
c70d749986f6f1 Corey Minyard  2008-04-29  5175  	 * to make the panic events more useful.
c70d749986f6f1 Corey Minyard  2008-04-29  5176  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5177  	if (str) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5178  		data[3] = str[0];
^1da177e4c3f41 Linus Torvalds 2005-04-16  5179  		data[6] = str[1];
^1da177e4c3f41 Linus Torvalds 2005-04-16  5180  		data[7] = str[2];
^1da177e4c3f41 Linus Torvalds 2005-04-16  5181  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  5182  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5183  	/* Send the event announcing the panic. */
895dcfd1cab84d Corey Minyard  2012-03-28  5184  	ipmi_panic_request_and_wait(intf, &addr, &msg);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5185  
c70d749986f6f1 Corey Minyard  2008-04-29  5186  	/*
c70d749986f6f1 Corey Minyard  2008-04-29  5187  	 * On every interface, dump a bunch of OEM event holding the
c70d749986f6f1 Corey Minyard  2008-04-29  5188  	 * string.
c70d749986f6f1 Corey Minyard  2008-04-29  5189  	 */
1c9f98d1bfbd06 Corey Minyard  2017-08-18  5190  	if (ipmi_send_panic_event != IPMI_SEND_PANIC_EVENT_STRING || !str)
^1da177e4c3f41 Linus Torvalds 2005-04-16  5191  		return;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5192  
78ba2faf71c639 Corey Minyard  2007-02-10  5193  	/*
78ba2faf71c639 Corey Minyard  2007-02-10  5194  	 * intf_num is used as an marker to tell if the
78ba2faf71c639 Corey Minyard  2007-02-10  5195  	 * interface is valid.  Thus we need a read barrier to
78ba2faf71c639 Corey Minyard  2007-02-10  5196  	 * make sure data fetched before checking intf_num
78ba2faf71c639 Corey Minyard  2007-02-10  5197  	 * won't be used.
78ba2faf71c639 Corey Minyard  2007-02-10  5198  	 */
78ba2faf71c639 Corey Minyard  2007-02-10  5199  	smp_rmb();
78ba2faf71c639 Corey Minyard  2007-02-10  5200  
c70d749986f6f1 Corey Minyard  2008-04-29  5201  	/*
c70d749986f6f1 Corey Minyard  2008-04-29  5202  	 * First job here is to figure out where to send the
c70d749986f6f1 Corey Minyard  2008-04-29  5203  	 * OEM events.  There's no way in IPMI to send OEM
c70d749986f6f1 Corey Minyard  2008-04-29  5204  	 * events using an event send command, so we have to
c70d749986f6f1 Corey Minyard  2008-04-29  5205  	 * find the SEL to put them in and stick them in
c70d749986f6f1 Corey Minyard  2008-04-29  5206  	 * there.
c70d749986f6f1 Corey Minyard  2008-04-29  5207  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5208  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5209  	/* Get capabilities from the get device id. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5210  	intf->local_sel_device = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5211  	intf->local_event_generator = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5212  	intf->event_receiver = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5213  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5214  	/* Request the device info from the local MC. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5215  	msg.netfn = IPMI_NETFN_APP_REQUEST;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5216  	msg.cmd = IPMI_GET_DEVICE_ID_CMD;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5217  	msg.data = NULL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5218  	msg.data_len = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5219  	intf->null_user_handler = device_id_fetcher;
895dcfd1cab84d Corey Minyard  2012-03-28  5220  	ipmi_panic_request_and_wait(intf, &addr, &msg);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5221  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5222  	if (intf->local_event_generator) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5223  		/* Request the event receiver from the local MC. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5224  		msg.netfn = IPMI_NETFN_SENSOR_EVENT_REQUEST;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5225  		msg.cmd = IPMI_GET_EVENT_RECEIVER_CMD;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5226  		msg.data = NULL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5227  		msg.data_len = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5228  		intf->null_user_handler = event_receiver_fetcher;
895dcfd1cab84d Corey Minyard  2012-03-28  5229  		ipmi_panic_request_and_wait(intf, &addr, &msg);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5230  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  5231  	intf->null_user_handler = NULL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5232  
c70d749986f6f1 Corey Minyard  2008-04-29  5233  	/*
c70d749986f6f1 Corey Minyard  2008-04-29  5234  	 * Validate the event receiver.  The low bit must not
c70d749986f6f1 Corey Minyard  2008-04-29  5235  	 * be 1 (it must be a valid IPMB address), it cannot
c70d749986f6f1 Corey Minyard  2008-04-29  5236  	 * be zero, and it must not be my address.
c70d749986f6f1 Corey Minyard  2008-04-29  5237  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5238  	if (((intf->event_receiver & 1) == 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  5239  	    && (intf->event_receiver != 0)
5fdb1fb2abe647 Corey Minyard  2017-09-05  5240  	    && (intf->event_receiver != intf->addrinfo[0].address)) {
c70d749986f6f1 Corey Minyard  2008-04-29  5241  		/*
c70d749986f6f1 Corey Minyard  2008-04-29  5242  		 * The event receiver is valid, send an IPMB
c70d749986f6f1 Corey Minyard  2008-04-29  5243  		 * message.
c70d749986f6f1 Corey Minyard  2008-04-29  5244  		 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5245  		ipmb = (struct ipmi_ipmb_addr *) &addr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5246  		ipmb->addr_type = IPMI_IPMB_ADDR_TYPE;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5247  		ipmb->channel = 0; /* FIXME - is this right? */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5248  		ipmb->lun = intf->event_receiver_lun;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5249  		ipmb->slave_addr = intf->event_receiver;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5250  	} else if (intf->local_sel_device) {
c70d749986f6f1 Corey Minyard  2008-04-29  5251  		/*
c70d749986f6f1 Corey Minyard  2008-04-29  5252  		 * The event receiver was not valid (or was
c70d749986f6f1 Corey Minyard  2008-04-29  5253  		 * me), but I am an SEL device, just dump it
c70d749986f6f1 Corey Minyard  2008-04-29  5254  		 * in my SEL.
c70d749986f6f1 Corey Minyard  2008-04-29  5255  		 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5256  		si = (struct ipmi_system_interface_addr *) &addr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5257  		si->addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5258  		si->channel = IPMI_BMC_CHANNEL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5259  		si->lun = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5260  	} else
91e2dd0a47bae1 Corey Minyard  2018-03-28  5261  		return; /* No where to send the event. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5262  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5263  	msg.netfn = IPMI_NETFN_STORAGE_REQUEST; /* Storage. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5264  	msg.cmd = IPMI_ADD_SEL_ENTRY_CMD;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5265  	msg.data = data;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5266  	msg.data_len = 16;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5267  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5268  	j = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5269  	while (*p) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5270  		int size = strlen(p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5271  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5272  		if (size > 11)
^1da177e4c3f41 Linus Torvalds 2005-04-16  5273  			size = 11;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5274  		data[0] = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5275  		data[1] = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5276  		data[2] = 0xf0; /* OEM event without timestamp. */
5fdb1fb2abe647 Corey Minyard  2017-09-05  5277  		data[3] = intf->addrinfo[0].address;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5278  		data[4] = j++; /* sequence # */
c70d749986f6f1 Corey Minyard  2008-04-29  5279  		/*
c70d749986f6f1 Corey Minyard  2008-04-29  5280  		 * Always give 11 bytes, so strncpy will fill
c70d749986f6f1 Corey Minyard  2008-04-29  5281  		 * it with zeroes for me.
c70d749986f6f1 Corey Minyard  2008-04-29  5282  		 */
^1da177e4c3f41 Linus Torvalds 2005-04-16 @5283  		strncpy(data+5, p, 11);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5284  		p += size;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5285  
895dcfd1cab84d Corey Minyard  2012-03-28  5286  		ipmi_panic_request_and_wait(intf, &addr, &msg);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5287  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  5288  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  5289  

:::::: The code at line 5283 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
