Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1074F9B75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiDHRSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiDHRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:18:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C70DF1F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649438159; x=1680974159;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qB0q0fqvmsHFyPwGvPxPmeyxmyNVu7+h3oTBX87IKuo=;
  b=QN3XqF72M58RZPFp1DA4V4m6MIqgBe/PN4TKRfE7ZNw0iXJNcC1ywR0H
   87BbKfBjRqAsFSHnagJNi5NQsJdmKbz/gP0FYRG1fzM76ddPeqfEQir+u
   VDQ2glpTAcAjhHKj6iXdBuS/Xz0lAlkshT4VPe/NvcY1oRnRUocOw+U2u
   lV5Cr9vt1Ofy49FjWjaEpnDX9rRGbbNhCKwwWfyOROyL86Ez9Q11hVBSR
   aJldlF52hybIRYLsa80Ue+WwONoDGTwLfzmcVNlyHWMluKuNEiQ1kuEtz
   MMbSuUWiUvUbZA0exdqp7JJ5V6AYDTa8VJXiWwxgizIHCU5M+02qoijo/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241581257"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="241581257"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="698250496"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 10:15:58 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncsDF-0000UT-FQ;
        Fri, 08 Apr 2022 17:15:57 +0000
Date:   Sat, 9 Apr 2022 01:15:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 281/887]
 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c:472:55: sparse:
 sparse: Using plain integer as NULL pointer
Message-ID: <202204090144.S9m5LfZs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 56d0cd616fe11877854ad1b0768b3be67bb30349 [281/887] staging: vc04_services: Add new vc-sm-cma driver
config: csky-randconfig-s031-20220408 (https://download.01.org/0day-ci/archive/20220409/202204090144.S9m5LfZs-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/l1k/linux/commit/56d0cd616fe11877854ad1b0768b3be67bb30349
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 56d0cd616fe11877854ad1b0768b3be67bb30349
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/staging/vc04_services/vc-sm-cma/ drivers/staging/vc04_services/vchiq-mmal/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c:472:55: sparse: sparse: Using plain integer as NULL pointer
   drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c:501:59: sparse: sparse: Using plain integer as NULL pointer

vim +472 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c

   467	
   468	int vc_sm_cma_vchi_free(struct sm_instance *handle, struct vc_sm_free_t *msg,
   469				u32 *cur_trans_id)
   470	{
   471		return vc_sm_cma_vchi_send_msg(handle, VC_SM_MSG_TYPE_FREE,
 > 472					   msg, sizeof(*msg), 0, 0, cur_trans_id, 0);
   473	}
   474	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
