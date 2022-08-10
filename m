Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A958E9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiHJJd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiHJJdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:33:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9766CF45
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660124031; x=1691660031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qoKW/Cz1qGesjhHB49g5j61PLM1OEdVCCfEBfbS5leI=;
  b=Pe+uQv39vdDku9rUp2ku5JhXU39P9rSnU05AFNjUcdUwYFtEfNwmumKf
   YzGham817FmJTwHlhon969UKTKdBVltIwbOYppwB9Xv7jfP4yBDUtgjQj
   mUUo9SHvc4fp+T6w3BHF3JhNrUp6nA9NuUcWkheteW9bgG6zPju6UbPNh
   XoVW4g/DBNzFM3xaZCvHVA1LuxJ6bT6uTVTU/iIenVb23vs9I2eqemQjZ
   b3ErLE37hdwQSsN1VJtLod/sRO/se3MBS2We8zXll1YbmBDanXskkXixR
   TLCN+2ERBQdjISPflZ7EDsZCpUCa3JatxUFhF/YLFVIG5F18oC85AH0t6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="316988185"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="316988185"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 02:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="932823182"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2022 02:33:45 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLi5w-000079-27;
        Wed, 10 Aug 2022 09:33:44 +0000
Date:   Wed, 10 Aug 2022 17:33:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202208101744.QhbtwKI7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d4252071b97d2027d246f6a82cbee4d52f618b47
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   6 weeks ago
config: arm-randconfig-s053-20220810 (https://download.01.org/0day-ci/archive/20220810/202208101744.QhbtwKI7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/ drivers/video/fbdev/aty/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/hptiop.c:150:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:171:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:208:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:208:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:208:18: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:209:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:209:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:209:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:244:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] result @@     got int @@
   drivers/scsi/hptiop.c:244:44: sparse:     expected restricted __le32 [usertype] result
   drivers/scsi/hptiop.c:244:44: sparse:     got int
   drivers/scsi/hptiop.c:289:35: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:276:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:277:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_rptr @@     got restricted __le32 [usertype] outlist_rptr @@
   drivers/scsi/hptiop.c:277:34: sparse:     expected unsigned int [usertype] cur_rptr
   drivers/scsi/hptiop.c:277:34: sparse:     got restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:283:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] _tag @@     got restricted __le32 [usertype] val @@
   drivers/scsi/hptiop.c:283:38: sparse:     expected unsigned int [usertype] _tag
   drivers/scsi/hptiop.c:283:38: sparse:     got restricted __le32 [usertype] val
   drivers/scsi/hptiop.c:288:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int [assigned] [usertype] cur_rptr @@
   drivers/scsi/hptiop.c:288:52: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:288:52: sparse:     got unsigned int [assigned] [usertype] cur_rptr
   drivers/scsi/hptiop.c:369:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:369:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:369:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:370:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:370:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:370:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:453:64: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct hpt_iop_request_get_config *info @@     got struct hpt_iop_request_get_config [noderef] __iomem *config @@
   drivers/scsi/hptiop.c:453:64: sparse:     expected struct hpt_iop_request_get_config *info
   drivers/scsi/hptiop.c:453:64: sparse:     got struct hpt_iop_request_get_config [noderef] __iomem *config
   drivers/scsi/hptiop.c:455:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:557:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:557:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:557:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:637:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hpt_iopmv_regs *regs @@     got void [noderef] __iomem * @@
   drivers/scsi/hptiop.c:637:24: sparse:     expected struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:637:24: sparse:     got void [noderef] __iomem *
>> drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:643:34: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/hptiop.c:643:34: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:667:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:667:26: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/hptiop.c:667:26: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:938:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:939:30: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:943:43: sparse: sparse: invalid assignment: &=
   drivers/scsi/hptiop.c:943:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:943:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:944:43: sparse: sparse: invalid assignment: ^=
   drivers/scsi/hptiop.c:944:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:944:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:949:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:949:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] intrfc_len @@     got unsigned int @@
   drivers/scsi/hptiop.c:949:48: sparse:     expected restricted __le32 [usertype] intrfc_len
   drivers/scsi/hptiop.c:949:48: sparse:     got unsigned int
   drivers/scsi/hptiop.c:950:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:975:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:977:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:980:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:982:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:985:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:987:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:990:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] inlist_wptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:990:35: sparse:     expected restricted __le32 [usertype] inlist_wptr
   drivers/scsi/hptiop.c:990:35: sparse:     got unsigned int
   drivers/scsi/hptiop.c:991:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int @@
   drivers/scsi/hptiop.c:991:37: sparse:     expected restricted __le32 [usertype]
   drivers/scsi/hptiop.c:991:37: sparse:     got unsigned int
   drivers/scsi/hptiop.c:992:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:992:36: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:992:36: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1534:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1534:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1534:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:1535:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1535:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1535:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression
--
>> drivers/video/fbdev/aty/atyfb_base.c:3741:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got unsigned char [usertype] *addr @@
   drivers/video/fbdev/aty/atyfb_base.c:3741:37: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/video/fbdev/aty/atyfb_base.c:3741:37: sparse:     got unsigned char [usertype] *addr

vim +643 drivers/scsi/hptiop.c

00f5970193e22c4 HighPoint Linux Team 2007-12-13  449  
286aa031664ba52 HighPoint Linux Team 2012-10-25  450  static int iop_get_config_mvfrey(struct hptiop_hba *hba,
286aa031664ba52 HighPoint Linux Team 2012-10-25  451  				struct hpt_iop_request_get_config *config)
286aa031664ba52 HighPoint Linux Team 2012-10-25  452  {
286aa031664ba52 HighPoint Linux Team 2012-10-25 @453  	struct hpt_iop_request_get_config *info = hba->u.mvfrey.config;
286aa031664ba52 HighPoint Linux Team 2012-10-25  454  
286aa031664ba52 HighPoint Linux Team 2012-10-25  455  	if (info->header.size != sizeof(struct hpt_iop_request_get_config) ||
286aa031664ba52 HighPoint Linux Team 2012-10-25  456  			info->header.type != IOP_REQUEST_TYPE_GET_CONFIG)
286aa031664ba52 HighPoint Linux Team 2012-10-25  457  		return -1;
286aa031664ba52 HighPoint Linux Team 2012-10-25  458  
286aa031664ba52 HighPoint Linux Team 2012-10-25  459  	config->interface_version = info->interface_version;
286aa031664ba52 HighPoint Linux Team 2012-10-25  460  	config->firmware_version = info->firmware_version;
286aa031664ba52 HighPoint Linux Team 2012-10-25  461  	config->max_requests = info->max_requests;
286aa031664ba52 HighPoint Linux Team 2012-10-25  462  	config->request_size = info->request_size;
286aa031664ba52 HighPoint Linux Team 2012-10-25  463  	config->max_sg_count = info->max_sg_count;
286aa031664ba52 HighPoint Linux Team 2012-10-25  464  	config->data_transfer_length = info->data_transfer_length;
286aa031664ba52 HighPoint Linux Team 2012-10-25  465  	config->alignment_mask = info->alignment_mask;
286aa031664ba52 HighPoint Linux Team 2012-10-25  466  	config->max_devices = info->max_devices;
286aa031664ba52 HighPoint Linux Team 2012-10-25  467  	config->sdram_size = info->sdram_size;
286aa031664ba52 HighPoint Linux Team 2012-10-25  468  
286aa031664ba52 HighPoint Linux Team 2012-10-25  469  	return 0;
286aa031664ba52 HighPoint Linux Team 2012-10-25  470  }
286aa031664ba52 HighPoint Linux Team 2012-10-25  471  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  472  static int iop_set_config_itl(struct hptiop_hba *hba,
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  473  				struct hpt_iop_request_set_config *config)
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  474  {
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  475  	u32 req32;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  476  	struct hpt_iop_request_set_config __iomem *req;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  477  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  478  	req32 = readl(&hba->u.itl.iop->inbound_queue);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  479  	if (req32 == IOPMU_QUEUE_EMPTY)
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  480  		return -1;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  481  
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  482  	req = (struct hpt_iop_request_set_config __iomem *)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  483  			((unsigned long)hba->u.itl.iop + req32);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  484  
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  485  	memcpy_toio((u8 __iomem *)req + sizeof(struct hpt_iop_request_header),
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  486  		(u8 *)config + sizeof(struct hpt_iop_request_header),
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  487  		sizeof(struct hpt_iop_request_set_config) -
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  488  			sizeof(struct hpt_iop_request_header));
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  489  
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  490  	writel(0, &req->header.flags);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  491  	writel(IOP_REQUEST_TYPE_SET_CONFIG, &req->header.type);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  492  	writel(sizeof(struct hpt_iop_request_set_config), &req->header.size);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  493  	writel(IOP_RESULT_PENDING, &req->header.result);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  494  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  495  	if (iop_send_sync_request_itl(hba, req, 20000)) {
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  496  		dprintk("Set config send cmd failed\n");
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  497  		return -1;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  498  	}
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  499  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  500  	writel(req32, &hba->u.itl.iop->outbound_queue);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  501  	return 0;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  502  }
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  503  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  504  static int iop_set_config_mv(struct hptiop_hba *hba,
00f5970193e22c4 HighPoint Linux Team 2007-12-13  505  				struct hpt_iop_request_set_config *config)
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  506  {
00f5970193e22c4 HighPoint Linux Team 2007-12-13  507  	struct hpt_iop_request_set_config *req = hba->u.mv.internal_req;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  508  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  509  	memcpy(req, config, sizeof(struct hpt_iop_request_set_config));
00f5970193e22c4 HighPoint Linux Team 2007-12-13  510  	req->header.flags = cpu_to_le32(IOP_REQUEST_FLAG_OUTPUT_CONTEXT);
00f5970193e22c4 HighPoint Linux Team 2007-12-13  511  	req->header.type = cpu_to_le32(IOP_REQUEST_TYPE_SET_CONFIG);
00f5970193e22c4 HighPoint Linux Team 2007-12-13  512  	req->header.size =
00f5970193e22c4 HighPoint Linux Team 2007-12-13  513  		cpu_to_le32(sizeof(struct hpt_iop_request_set_config));
00f5970193e22c4 HighPoint Linux Team 2007-12-13  514  	req->header.result = cpu_to_le32(IOP_RESULT_PENDING);
f6b196a2f3058c6 James Bottomley      2008-03-30  515  	req->header.context = cpu_to_le32(IOP_REQUEST_TYPE_SET_CONFIG<<5);
f6b196a2f3058c6 James Bottomley      2008-03-30  516  	req->header.context_hi32 = 0;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  517  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  518  	if (iop_send_sync_request_mv(hba, 0, 20000)) {
00f5970193e22c4 HighPoint Linux Team 2007-12-13  519  		dprintk("Set config send cmd failed\n");
00f5970193e22c4 HighPoint Linux Team 2007-12-13  520  		return -1;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  521  	}
00f5970193e22c4 HighPoint Linux Team 2007-12-13  522  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  523  	return 0;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  524  }
00f5970193e22c4 HighPoint Linux Team 2007-12-13  525  
286aa031664ba52 HighPoint Linux Team 2012-10-25  526  static int iop_set_config_mvfrey(struct hptiop_hba *hba,
286aa031664ba52 HighPoint Linux Team 2012-10-25  527  				struct hpt_iop_request_set_config *config)
286aa031664ba52 HighPoint Linux Team 2012-10-25  528  {
286aa031664ba52 HighPoint Linux Team 2012-10-25  529  	struct hpt_iop_request_set_config *req =
286aa031664ba52 HighPoint Linux Team 2012-10-25  530  		hba->u.mvfrey.internal_req.req_virt;
286aa031664ba52 HighPoint Linux Team 2012-10-25  531  
286aa031664ba52 HighPoint Linux Team 2012-10-25  532  	memcpy(req, config, sizeof(struct hpt_iop_request_set_config));
286aa031664ba52 HighPoint Linux Team 2012-10-25  533  	req->header.flags = cpu_to_le32(IOP_REQUEST_FLAG_OUTPUT_CONTEXT);
286aa031664ba52 HighPoint Linux Team 2012-10-25  534  	req->header.type = cpu_to_le32(IOP_REQUEST_TYPE_SET_CONFIG);
286aa031664ba52 HighPoint Linux Team 2012-10-25  535  	req->header.size =
286aa031664ba52 HighPoint Linux Team 2012-10-25  536  		cpu_to_le32(sizeof(struct hpt_iop_request_set_config));
286aa031664ba52 HighPoint Linux Team 2012-10-25  537  	req->header.result = cpu_to_le32(IOP_RESULT_PENDING);
286aa031664ba52 HighPoint Linux Team 2012-10-25  538  	req->header.context = cpu_to_le32(IOP_REQUEST_TYPE_SET_CONFIG<<5);
286aa031664ba52 HighPoint Linux Team 2012-10-25  539  	req->header.context_hi32 = 0;
286aa031664ba52 HighPoint Linux Team 2012-10-25  540  
286aa031664ba52 HighPoint Linux Team 2012-10-25  541  	if (iop_send_sync_request_mvfrey(hba, 0, 20000)) {
286aa031664ba52 HighPoint Linux Team 2012-10-25  542  		dprintk("Set config send cmd failed\n");
286aa031664ba52 HighPoint Linux Team 2012-10-25  543  		return -1;
286aa031664ba52 HighPoint Linux Team 2012-10-25  544  	}
286aa031664ba52 HighPoint Linux Team 2012-10-25  545  
286aa031664ba52 HighPoint Linux Team 2012-10-25  546  	return 0;
286aa031664ba52 HighPoint Linux Team 2012-10-25  547  }
286aa031664ba52 HighPoint Linux Team 2012-10-25  548  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  549  static void hptiop_enable_intr_itl(struct hptiop_hba *hba)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  550  {
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  551  	writel(~(IOPMU_OUTBOUND_INT_POSTQUEUE | IOPMU_OUTBOUND_INT_MSG0),
00f5970193e22c4 HighPoint Linux Team 2007-12-13  552  		&hba->u.itl.iop->outbound_intmask);
00f5970193e22c4 HighPoint Linux Team 2007-12-13  553  }
00f5970193e22c4 HighPoint Linux Team 2007-12-13  554  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  555  static void hptiop_enable_intr_mv(struct hptiop_hba *hba)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  556  {
00f5970193e22c4 HighPoint Linux Team 2007-12-13  557  	writel(MVIOP_MU_OUTBOUND_INT_POSTQUEUE | MVIOP_MU_OUTBOUND_INT_MSG,
00f5970193e22c4 HighPoint Linux Team 2007-12-13  558  		&hba->u.mv.regs->outbound_intmask);
00f5970193e22c4 HighPoint Linux Team 2007-12-13  559  }
00f5970193e22c4 HighPoint Linux Team 2007-12-13  560  
286aa031664ba52 HighPoint Linux Team 2012-10-25  561  static void hptiop_enable_intr_mvfrey(struct hptiop_hba *hba)
286aa031664ba52 HighPoint Linux Team 2012-10-25  562  {
286aa031664ba52 HighPoint Linux Team 2012-10-25  563  	writel(CPU_TO_F0_DRBL_MSG_BIT, &(hba->u.mvfrey.mu->f0_doorbell_enable));
286aa031664ba52 HighPoint Linux Team 2012-10-25  564  	writel(0x1, &(hba->u.mvfrey.mu->isr_enable));
286aa031664ba52 HighPoint Linux Team 2012-10-25  565  	writel(0x1010, &(hba->u.mvfrey.mu->pcie_f0_int_enable));
286aa031664ba52 HighPoint Linux Team 2012-10-25  566  }
286aa031664ba52 HighPoint Linux Team 2012-10-25  567  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  568  static int hptiop_initialize_iop(struct hptiop_hba *hba)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  569  {
00f5970193e22c4 HighPoint Linux Team 2007-12-13  570  	/* enable interrupts */
00f5970193e22c4 HighPoint Linux Team 2007-12-13  571  	hba->ops->enable_intr(hba);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  572  
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  573  	hba->initialized = 1;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  574  
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  575  	/* start background tasks */
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  576  	if (iop_send_sync_msg(hba,
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  577  			IOPMU_INBOUND_MSG0_START_BACKGROUND_TASK, 5000)) {
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  578  		printk(KERN_ERR "scsi%d: fail to start background task\n",
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  579  			hba->host->host_no);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  580  		return -1;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  581  	}
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  582  	return 0;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  583  }
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  584  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  585  static void __iomem *hptiop_map_pci_bar(struct hptiop_hba *hba, int index)
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  586  {
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  587  	u32 mem_base_phy, length;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  588  	void __iomem *mem_base_virt;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  589  
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  590  	struct pci_dev *pcidev = hba->pcidev;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  591  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  592  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  593  	if (!(pci_resource_flags(pcidev, index) & IORESOURCE_MEM)) {
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  594  		printk(KERN_ERR "scsi%d: pci resource invalid\n",
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  595  				hba->host->host_no);
9bcf091083065c7 Harvey Harrison      2008-05-22  596  		return NULL;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  597  	}
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  598  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  599  	mem_base_phy = pci_resource_start(pcidev, index);
00f5970193e22c4 HighPoint Linux Team 2007-12-13  600  	length = pci_resource_len(pcidev, index);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  601  	mem_base_virt = ioremap(mem_base_phy, length);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  602  
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  603  	if (!mem_base_virt) {
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  604  		printk(KERN_ERR "scsi%d: Fail to ioremap memory space\n",
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  605  				hba->host->host_no);
9bcf091083065c7 Harvey Harrison      2008-05-22  606  		return NULL;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  607  	}
00f5970193e22c4 HighPoint Linux Team 2007-12-13  608  	return mem_base_virt;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  609  }
00f5970193e22c4 HighPoint Linux Team 2007-12-13  610  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  611  static int hptiop_map_pci_bar_itl(struct hptiop_hba *hba)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  612  {
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  613  	struct pci_dev *pcidev = hba->pcidev;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  614  	hba->u.itl.iop = hptiop_map_pci_bar(hba, 0);
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  615  	if (hba->u.itl.iop == NULL)
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  616  		return -1;
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  617  	if ((pcidev->device & 0xff00) == 0x4400) {
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  618  		hba->u.itl.plx = hba->u.itl.iop;
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  619  		hba->u.itl.iop = hptiop_map_pci_bar(hba, 2);
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  620  		if (hba->u.itl.iop == NULL) {
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  621  			iounmap(hba->u.itl.plx);
00f5970193e22c4 HighPoint Linux Team 2007-12-13  622  			return -1;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  623  		}
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  624  	}
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  625  	return 0;
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  626  }
00f5970193e22c4 HighPoint Linux Team 2007-12-13  627  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  628  static void hptiop_unmap_pci_bar_itl(struct hptiop_hba *hba)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  629  {
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  630  	if (hba->u.itl.plx)
3bfc13c239fd56e HighPoint Linux Team 2009-09-11  631  		iounmap(hba->u.itl.plx);
00f5970193e22c4 HighPoint Linux Team 2007-12-13  632  	iounmap(hba->u.itl.iop);
00f5970193e22c4 HighPoint Linux Team 2007-12-13  633  }
00f5970193e22c4 HighPoint Linux Team 2007-12-13  634  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  635  static int hptiop_map_pci_bar_mv(struct hptiop_hba *hba)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  636  {
00f5970193e22c4 HighPoint Linux Team 2007-12-13  637  	hba->u.mv.regs = hptiop_map_pci_bar(hba, 0);
9bcf091083065c7 Harvey Harrison      2008-05-22  638  	if (hba->u.mv.regs == NULL)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  639  		return -1;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  640  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  641  	hba->u.mv.mu = hptiop_map_pci_bar(hba, 2);
9bcf091083065c7 Harvey Harrison      2008-05-22  642  	if (hba->u.mv.mu == NULL) {
00f5970193e22c4 HighPoint Linux Team 2007-12-13 @643  		iounmap(hba->u.mv.regs);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  644  		return -1;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  645  	}
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  646  
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  647  	return 0;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  648  }
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  649  

:::::: The code at line 643 was first introduced by commit
:::::: 00f5970193e22c48f399a2430635d6416b51befe [SCSI] hptiop: add more adapter models and other fixes

:::::: TO: HighPoint Linux Team <linux@highpoint-tech.com>
:::::: CC: James Bottomley <James.Bottomley@HansenPartnership.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
