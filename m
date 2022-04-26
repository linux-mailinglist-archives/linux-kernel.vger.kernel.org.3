Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C478A51072C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350163AbiDZSjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243381AbiDZSja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:39:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340B4443E1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650998182; x=1682534182;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wJsCX5Aa9D2un5vlCMuAAEe701tH536Gy5Mpl78Szp4=;
  b=NASj8BJGFwwCt3bEArBcDQd0Y+pg7U+S2yEbAzpV7p9lf6UQQ3lMifxt
   GNFFIoeKoI9I+GaQi6kC+UO2TZngQYhDYOpjwbXruPbKl1XY/r9BJFUZn
   Fss27dAGd0RG79mIvvirJ5pJEkVdeBBE+rgjfxZb2oXv3O3ywPzMDb1PK
   095H+nWno4Yik8X6BqdjdQ1plI5ixQOKj7iUgwBt+uA9HoTQ7SlqascP4
   ZGo9s3EWRvvSn8EtK9nT9mLksAIr9875+Tlr9RoTgTNZIwQwjo/rKQf4W
   qjSfq0Xz0OAtOk6zBpCsZUul2w4ag4wlW9EkSs88KNprpSjHK8NN/v2/M
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265491437"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="265491437"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 11:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="532806845"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2022 11:36:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njQ2o-0003tK-H2;
        Tue, 26 Apr 2022 18:36:14 +0000
Date:   Wed, 27 Apr 2022 02:35:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Bonnici <marc.bonnici@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [sudeep-holla:for-next/ffa 1/1]
 drivers/firmware/arm_ffa/driver.c:404:17: warning: suggest explicit braces
 to avoid ambiguous 'else'
Message-ID: <202204270258.eWC4oaGl-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git for-next/ffa
head:   f924bccb73cadccf18a97c3c6a4e8c12120c3cdc
commit: f924bccb73cadccf18a97c3c6a4e8c12120c3cdc [1/1] firmware: arm_ffa: Fix handling of fragmented memory descriptors
config: arm64-randconfig-r023-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270258.eWC4oaGl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?id=f924bccb73cadccf18a97c3c6a4e8c12120c3cdc
        git remote add sudeep-holla https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
        git fetch --no-tags sudeep-holla for-next/ffa
        git checkout f924bccb73cadccf18a97c3c6a4e8c12120c3cdc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/firmware/arm_ffa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/firmware/arm_ffa/driver.c: In function 'ffa_mem_first_frag':
>> drivers/firmware/arm_ffa/driver.c:404:17: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
     404 |         else if (ret.a0 == FFA_MEM_FRAG_RX)
         |                 ^
   drivers/firmware/arm_ffa/driver.c:401:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
     401 |         if (ret.a0 == FFA_SUCCESS)
         |            ^


vim +/else +404 drivers/firmware/arm_ffa/driver.c

   381	
   382	static int ffa_mem_first_frag(u32 func_id, phys_addr_t buf, u32 buf_sz,
   383				      u32 frag_len, u32 len, u64 *handle)
   384	{
   385		ffa_value_t ret;
   386	
   387		invoke_ffa_fn((ffa_value_t){
   388			      .a0 = func_id, .a1 = len, .a2 = frag_len,
   389			      .a3 = buf, .a4 = buf_sz,
   390			      }, &ret);
   391	
   392		while (ret.a0 == FFA_MEM_OP_PAUSE)
   393			invoke_ffa_fn((ffa_value_t){
   394				      .a0 = FFA_MEM_OP_RESUME,
   395				      .a1 = ret.a1, .a2 = ret.a2,
   396				      }, &ret);
   397	
   398		if (ret.a0 == FFA_ERROR)
   399			return ffa_to_linux_errno((int)ret.a2);
   400	
   401		if (ret.a0 == FFA_SUCCESS)
   402			if (handle)
   403				*handle = PACK_HANDLE(ret.a2, ret.a3);
 > 404		else if (ret.a0 == FFA_MEM_FRAG_RX)
   405			if (handle)
   406				*handle = PACK_HANDLE(ret.a1, ret.a2);
   407		else
   408			return -EOPNOTSUPP;
   409	
   410		return frag_len;
   411	}
   412	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
