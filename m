Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B15511E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiD0Rv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiD0Rvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:51:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B863B292
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651081723; x=1682617723;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BAgtZv3LL6vYocWtwL+398lVVpady9I/YbNdXUVxTOQ=;
  b=mzyNXwPSScwzUzdHYaST0jJkjsNtvQSMClZvbSDRONf2MVjiylTjRE2y
   sIK/pO1OH8NSvBOzhEn+DxP+BKuMHwSPQCSYes2DAq9GSKQOs4NirfXHR
   VdOANN8s5QQWyTlofwdkhIzTq+NhPUcOHQoIqZXJO8uEnz2PWXfpe/shs
   m3sL02oh0s/l7ii7eupwt04rn+3ps0EDQjlEdUqSVOy6AiKn9QLuzUWm8
   O7Ar1UC3DQb7XvyGz/Ew398oHNOqjXav6+b+z+mhbMUgUT82mhY/J9UY5
   64jZNkqKgnSwysISveONqIRbzzsJbLrGL424DXOHc3iGlCFRBOoMYuAwQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="328959565"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="328959565"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="617631023"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2022 10:48:41 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njlmK-0004pi-DK;
        Wed, 27 Apr 2022 17:48:40 +0000
Date:   Thu, 28 Apr 2022 01:47:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: drivers/staging/r8188eu/os_dep/ioctl_linux.c:3431:31: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202204280108.t15hLKmX-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   46cf2c613f4b10eb12f749207b0fd2c1bfae3088
commit: 0a2b782a00f33e7d06dc43d099fa071ae97bee77 fortify: Make pointer arguments const
date:   2 months ago
config: mips-randconfig-s032-20220427 (https://download.01.org/0day-ci/archive/20220428/202204280108.t15hLKmX-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0a2b782a00f33e7d06dc43d099fa071ae97bee77
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0a2b782a00f33e7d06dc43d099fa071ae97bee77
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3430:17: sparse: sparse: cast removes address space '__user' of expression
>> drivers/staging/r8188eu/os_dep/ioctl_linux.c:3431:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __user *pointer @@
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3431:31: sparse:     expected void const *const p
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3431:31: sparse:     got void [noderef] __user *pointer
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3433:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __user *pointer @@
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3433:38: sparse:     expected void const *const p
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3433:38: sparse:     got void [noderef] __user *pointer
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3435:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __user *pointer @@
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3435:38: sparse:     expected void const *const p
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3435:38: sparse:     got void [noderef] __user *pointer
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3437:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __user *pointer @@
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3437:38: sparse:     expected void const *const p
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3437:38: sparse:     got void [noderef] __user *pointer
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3439:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __user *pointer @@
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3439:38: sparse:     expected void const *const p
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3439:38: sparse:     got void [noderef] __user *pointer
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3442:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __user *pointer @@
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3442:38: sparse:     expected void const *const p
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3442:38: sparse:     got void [noderef] __user *pointer
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3444:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __user *pointer @@
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3444:38: sparse:     expected void const *const p
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3444:38: sparse:     got void [noderef] __user *pointer
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3447:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __user *pointer @@
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3447:38: sparse:     expected void const *const p
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3447:38: sparse:     got void [noderef] __user *pointer
   drivers/staging/r8188eu/os_dep/ioctl_linux.c:3459:9: sparse: sparse: cast removes address space '__user' of expression

vim +3431 drivers/staging/r8188eu/os_dep/ioctl_linux.c

2b42bd58b32155 Phillip Potter 2021-07-28  3420  
2b42bd58b32155 Phillip Potter 2021-07-28  3421  static int rtw_p2p_get(struct net_device *dev,
2b42bd58b32155 Phillip Potter 2021-07-28  3422  			       struct iw_request_info *info,
2b42bd58b32155 Phillip Potter 2021-07-28  3423  			       union iwreq_data *wrqu, char *extra)
2b42bd58b32155 Phillip Potter 2021-07-28  3424  {
2b42bd58b32155 Phillip Potter 2021-07-28  3425  	int ret = 0;
2b42bd58b32155 Phillip Potter 2021-07-28  3426  
2b42bd58b32155 Phillip Potter 2021-07-28  3427  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
2b42bd58b32155 Phillip Potter 2021-07-28  3428  
2b42bd58b32155 Phillip Potter 2021-07-28  3429  	if (padapter->bShowGetP2PState)
2b42bd58b32155 Phillip Potter 2021-07-28 @3430  		DBG_88E("[%s] extra = %s\n", __func__, (char *)wrqu->data.pointer);
2b42bd58b32155 Phillip Potter 2021-07-28 @3431  	if (!memcmp(wrqu->data.pointer, "status", 6)) {
2b42bd58b32155 Phillip Potter 2021-07-28  3432  		rtw_p2p_get_status(dev, info, wrqu, extra);
2b42bd58b32155 Phillip Potter 2021-07-28  3433  	} else if (!memcmp(wrqu->data.pointer, "role", 4)) {
2b42bd58b32155 Phillip Potter 2021-07-28  3434  		rtw_p2p_get_role(dev, info, wrqu, extra);
2b42bd58b32155 Phillip Potter 2021-07-28  3435  	} else if (!memcmp(wrqu->data.pointer, "peer_ifa", 8)) {
2b42bd58b32155 Phillip Potter 2021-07-28  3436  		rtw_p2p_get_peer_ifaddr(dev, info, wrqu, extra);
2b42bd58b32155 Phillip Potter 2021-07-28  3437  	} else if (!memcmp(wrqu->data.pointer, "req_cm", 6)) {
2b42bd58b32155 Phillip Potter 2021-07-28  3438  		rtw_p2p_get_req_cm(dev, info, wrqu, extra);
2b42bd58b32155 Phillip Potter 2021-07-28  3439  	} else if (!memcmp(wrqu->data.pointer, "peer_deva", 9)) {
2b42bd58b32155 Phillip Potter 2021-07-28  3440  		/*	Get the P2P device address when receiving the provision discovery request frame. */
2b42bd58b32155 Phillip Potter 2021-07-28  3441  		rtw_p2p_get_peer_devaddr(dev, info, wrqu, extra);
2b42bd58b32155 Phillip Potter 2021-07-28  3442  	} else if (!memcmp(wrqu->data.pointer, "group_id", 8)) {
2b42bd58b32155 Phillip Potter 2021-07-28  3443  		rtw_p2p_get_groupid(dev, info, wrqu, extra);
2b42bd58b32155 Phillip Potter 2021-07-28  3444  	} else if (!memcmp(wrqu->data.pointer, "peer_deva_inv", 9)) {
2b42bd58b32155 Phillip Potter 2021-07-28  3445  		/*	Get the P2P device address when receiving the P2P Invitation request frame. */
2b42bd58b32155 Phillip Potter 2021-07-28  3446  		rtw_p2p_get_peer_devaddr_by_invitation(dev, info, wrqu, extra);
2b42bd58b32155 Phillip Potter 2021-07-28  3447  	} else if (!memcmp(wrqu->data.pointer, "op_ch", 5)) {
2b42bd58b32155 Phillip Potter 2021-07-28  3448  		rtw_p2p_get_op_ch(dev, info, wrqu, extra);
2b42bd58b32155 Phillip Potter 2021-07-28  3449  	}
2b42bd58b32155 Phillip Potter 2021-07-28  3450  	return ret;
2b42bd58b32155 Phillip Potter 2021-07-28  3451  }
2b42bd58b32155 Phillip Potter 2021-07-28  3452  

:::::: The code at line 3431 was first introduced by commit
:::::: 2b42bd58b32155a1be4dd78991845dec05aaef9e staging: r8188eu: introduce new os_dep dir for RTL8188eu driver

:::::: TO: Phillip Potter <phil@philpotter.co.uk>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
