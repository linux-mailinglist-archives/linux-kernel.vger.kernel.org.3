Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93A04FC5BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349849AbiDKU1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiDKU1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:27:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13633584C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649708692; x=1681244692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V7Uy1mATUqvrpHiI+mrEfE74gw8XVuz63+OC085XC9s=;
  b=Vs9m7JLRhOTwcLE+OuTNLnPiHn0zWyVL609S4fc6qDAvKXmgWc/AOk0W
   ZBlpqpMd79aYWfj5yDZeu1ERPud1mR16Fqw+1IxxmVX7fM92NbqLw1dJk
   VuX6uuQE78YtJVgIgE0ZbCY868nhsveD2mA2f9x4xjietSmcPchuEnr6a
   aXhnHQObym0S0iyi6n+9X4us6OdxAQMVDva9o4jqOYLr5aMMFyaiYdZbs
   auSKkM0qw22TsgIJ9F+qtEmywL2yXGDKMlPgFCs24nx+kDX1qlj7yDrI5
   I2mEIJKCh/fK9fhFVlxr6aMM0W38qepVyHr4ptHHKG97AuSMnN6TvZvxr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261953743"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261953743"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 13:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="526137688"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2022 13:24:51 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne0ag-0002Ak-HP;
        Mon, 11 Apr 2022 20:24:50 +0000
Date:   Tue, 12 Apr 2022 04:24:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ls-zhu:get_dev_config_submit 5/5] drivers/vdpa/vdpa.c:823:20:
 sparse: sparse: incorrect type in assignment (different base types)
Message-ID: <202204120428.0TpzQuA8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ls-zhu/linux get_dev_config_submit
head:   c4a67f3ac1a9cc5a7bdc0121a9076c67a4f20af9
commit: c4a67f3ac1a9cc5a7bdc0121a9076c67a4f20af9 [5/5] vDPA: answer num of queue pairs = 1 to userspace when VIRTIO_NET_F_MQ == 0
config: m68k-randconfig-s031-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120428.0TpzQuA8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ls-zhu/linux/commit/c4a67f3ac1a9cc5a7bdc0121a9076c67a4f20af9
        git remote add ls-zhu https://github.com/ls-zhu/linux
        git fetch --no-tags ls-zhu get_dev_config_submit
        git checkout c4a67f3ac1a9cc5a7bdc0121a9076c67a4f20af9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash drivers/vdpa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/vdpa/vdpa.c:823:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] mq @@     got restricted __virtio16 const [usertype] max_virtqueue_pairs @@
   drivers/vdpa/vdpa.c:823:20: sparse:     expected unsigned short [assigned] [usertype] mq
   drivers/vdpa/vdpa.c:823:20: sparse:     got restricted __virtio16 const [usertype] max_virtqueue_pairs
   drivers/vdpa/vdpa.c:825:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:825:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:825:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:825:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:842:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:842:19: sparse: sparse: cast from restricted __virtio16
   drivers/vdpa/vdpa.c:842:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:842:19: sparse: sparse: cast from restricted __virtio16
   drivers/vdpa/vdpa.c:842:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:842:19: sparse: sparse: cast from restricted __virtio16
   drivers/vdpa/vdpa.c:842:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:842:19: sparse: sparse: cast from restricted __virtio16
   drivers/vdpa/vdpa.c:846:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:846:19: sparse: sparse: cast from restricted __virtio16
   drivers/vdpa/vdpa.c:846:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:846:19: sparse: sparse: cast from restricted __virtio16
   drivers/vdpa/vdpa.c:846:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:846:19: sparse: sparse: cast from restricted __virtio16
   drivers/vdpa/vdpa.c:846:19: sparse: sparse: cast to restricted __le16
   drivers/vdpa/vdpa.c:846:19: sparse: sparse: cast from restricted __virtio16

vim +823 drivers/vdpa/vdpa.c

   813	
   814	static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
   815					       struct sk_buff *msg, u64 features,
   816					       const struct virtio_net_config *config)
   817	{
   818		u16 val_u16, mq;
   819	
   820		if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0) {
   821			mq = 1;
   822		} else
 > 823			mq = config->max_virtqueue_pairs;
   824	
   825		val_u16 = le16_to_cpu(mq);
   826	
   827		return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
   828	}
   829	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
