Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89453DEFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 01:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351810AbiFEXq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 19:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348623AbiFEXqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 19:46:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651323668E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 16:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654472776; x=1686008776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GLVAJY2cQcs3ytkeeSsqmfyLuasvjP5Wq6+i2HWoWTo=;
  b=da7jsf5Om1F3ne47W1f5MXQkkUZrWqGjT/OP35QtOcobNM/3SOj0SyFC
   7WTOTYllL2D6uepTWd7Vxi5aFWYqbVc5gPJUFK9Hdx0wyKnxx7+kzsCUI
   0KdKcaHkQYti3I1PtA3FIsiREcAVlS4dpTeWX86fqYJf+VjU2FDNgRfgl
   99ccIGzcolxCQUwrFsRhIzFLd0s5pZpp+ZygL9NfDphFXKT7Gv9KyqNOt
   4C7F+HQiPul+hNCJw+vXZcfhQAjwctsu+hV5Zkyi2h5emL7v2QpGfsU6m
   G8Hh0tgzyOpwb1m9skpMzJTScbLukRvoISg4Hs8XmlJVFxthagvyHmjSK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276642300"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276642300"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 16:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="708839520"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2022 16:46:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxzwW-000CKs-J6;
        Sun, 05 Jun 2022 23:46:00 +0000
Date:   Mon, 6 Jun 2022 07:45:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/hid/hid-hyperv.c:218:9: sparse: sparse: cast from restricted
 __le16
Message-ID: <202206060703.BhX0IBxu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d717180e7f9775d468f415c10a4a474640146001
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   4 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220606/202206060703.BhX0IBxu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hid/ samples/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/hid/hid-hyperv.c:202:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] report_desc_size @@     got restricted __le16 [usertype] wDescriptorLength @@
   drivers/hid/hid-hyperv.c:202:40: sparse:     expected unsigned int [usertype] report_desc_size
   drivers/hid/hid-hyperv.c:202:40: sparse:     got restricted __le16 [usertype] wDescriptorLength
>> drivers/hid/hid-hyperv.c:218:9: sparse: sparse: cast from restricted __le16

vim +218 drivers/hid/hid-hyperv.c

b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  180  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  181  static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  182  				struct synthhid_device_info *device_info)
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  183  {
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  184  	int ret = 0;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  185  	struct hid_descriptor *desc;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  186  	struct mousevsc_prt_msg ack;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  187  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  188  	input_device->dev_info_status = -ENOMEM;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  189  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  190  	input_device->hid_dev_info = device_info->hid_dev_info;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  191  	desc = &device_info->hid_descriptor;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  192  	if (desc->bLength == 0)
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  193  		goto cleanup;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  194  
af13f9ed6f9aa6 Dexuan Cui       2019-11-19  195  	/* The pointer is not NULL when we resume from hibernation */
af13f9ed6f9aa6 Dexuan Cui       2019-11-19  196  	kfree(input_device->hid_desc);
a4a23f6d68ad2c Thomas Meyer     2013-06-01  197  	input_device->hid_desc = kmemdup(desc, desc->bLength, GFP_ATOMIC);
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  198  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  199  	if (!input_device->hid_desc)
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  200  		goto cleanup;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  201  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17 @202  	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  203  	if (input_device->report_desc_size == 0) {
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  204  		input_device->dev_info_status = -EINVAL;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  205  		goto cleanup;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  206  	}
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  207  
af13f9ed6f9aa6 Dexuan Cui       2019-11-19  208  	/* The pointer is not NULL when we resume from hibernation */
af13f9ed6f9aa6 Dexuan Cui       2019-11-19  209  	kfree(input_device->report_desc);
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  210  	input_device->report_desc = kzalloc(input_device->report_desc_size,
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  211  					  GFP_ATOMIC);
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  212  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  213  	if (!input_device->report_desc) {
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  214  		input_device->dev_info_status = -ENOMEM;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  215  		goto cleanup;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  216  	}
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  217  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17 @218  	memcpy(input_device->report_desc,
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  219  	       ((unsigned char *)desc) + desc->bLength,
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  220  	       desc->desc[0].wDescriptorLength);
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  221  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  222  	/* Send the ack */
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  223  	memset(&ack, 0, sizeof(struct mousevsc_prt_msg));
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  224  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  225  	ack.type = PIPE_MESSAGE_DATA;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  226  	ack.size = sizeof(struct synthhid_device_info_ack);
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  227  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  228  	ack.ack.header.type = SYNTH_HID_INITIAL_DEVICE_INFO_ACK;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  229  	ack.ack.header.size = 1;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  230  	ack.ack.reserved = 0;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  231  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  232  	ret = vmbus_sendpacket(input_device->device->channel,
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  233  			&ack,
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  234  			sizeof(struct pipe_prt_msg) - sizeof(unsigned char) +
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  235  			sizeof(struct synthhid_device_info_ack),
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  236  			(unsigned long)&ack,
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  237  			VM_PKT_DATA_INBAND,
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  238  			VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  239  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  240  	if (!ret)
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  241  		input_device->dev_info_status = 0;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  242  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  243  cleanup:
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  244  	complete(&input_device->wait_event);
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  245  
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  246  	return;
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  247  }
b95f5bcb811e39 K. Y. Srinivasan 2011-11-17  248  

:::::: The code at line 218 was first introduced by commit
:::::: b95f5bcb811e3905b5376f87789da8d097fee682 HID: Move the hid-hyperv driver out of staging

:::::: TO: K. Y. Srinivasan <kys@microsoft.com>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
