Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8805A50D04C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiDXHsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 03:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbiDXHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 03:48:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A592C112
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650786314; x=1682322314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n7b0QCm9KOzyBcpxED8Rk9JkX+VT9UCHdiRlH1/sFV8=;
  b=PlKdj8wu626mzV8T7LZCciJTiNtA/SiJ/L6PsJOuSbdYqwsCRUomjYnp
   /gubcCxOjSbOHDINjfH0mNfW2THlbxSXBjJBn2VNvuZo/FJkdUK+6D74c
   dc0Mypj+6aPFn7GKOWh+KSybzo50P/tjaqRnwWsPEgMSxWOxrlffhl5DM
   ZeAz1OXtVVBQJ48PJ+hUMER++dF3s6Xw+SMVwMBZnnAMj+Us5A1Tv2ei1
   Gyf8/sqSDiBV2Lzy70PdKU17HLnYwP3YiR5Fj3w2f5HyBm/W5XaZbJcjl
   c2ToqBmqwj4uizKOqTNrYYnGau1Er/G2tj/es4lokKY/+Rz7lV8Vs4QFk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="265180347"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="265180347"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 00:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="649247999"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2022 00:45:12 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niWvg-0001Bb-4n;
        Sun, 24 Apr 2022 07:45:12 +0000
Date:   Sun, 24 Apr 2022 15:44:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 1155/6555]
 drivers/gpu/drm/drm_atomic_uapi.c:366:13: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202204241549.5cRUbpNf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: dfdec43d0411076dc70591a0496a0824a8620695 [1155/6555] UPSTREAM: drm: extract drm_atomic_uapi.c
config: xtensa-randconfig-s032-20220419 (https://download.01.org/0day-ci/archive/20220424/202204241549.5cRUbpNf-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/jsarha/linux/commit/dfdec43d0411076dc70591a0496a0824a8620695
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout dfdec43d0411076dc70591a0496a0824a8620695
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/gpu/drm/ fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/drm_atomic_uapi.c:366:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__pu_addr @@     got signed int [noderef] [usertype] <asn:1> *fence_ptr @@
   drivers/gpu/drm/drm_atomic_uapi.c:366:13: sparse:     expected signed int *__pu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:366:13: sparse:     got signed int [noderef] [usertype] <asn:1> *fence_ptr
>> drivers/gpu/drm/drm_atomic_uapi.c:366:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:1> *to @@     got signed int *__pu_addr @@
   drivers/gpu/drm/drm_atomic_uapi.c:366:13: sparse:     expected void [noderef] <asn:1> *to
   drivers/gpu/drm/drm_atomic_uapi.c:366:13: sparse:     got signed int *__pu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:466:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__pu_addr @@     got signed int [noderef] [usertype] <asn:1> *fence_ptr @@
   drivers/gpu/drm/drm_atomic_uapi.c:466:21: sparse:     expected signed int *__pu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:466:21: sparse:     got signed int [noderef] [usertype] <asn:1> *fence_ptr
   drivers/gpu/drm/drm_atomic_uapi.c:466:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:1> *to @@     got signed int *__pu_addr @@
   drivers/gpu/drm/drm_atomic_uapi.c:466:21: sparse:     expected void [noderef] <asn:1> *to
   drivers/gpu/drm/drm_atomic_uapi.c:466:21: sparse:     got signed int *__pu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1052:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__pu_addr @@     got signed int [noderef] [usertype] <asn:1> *out_fence_ptr @@
   drivers/gpu/drm/drm_atomic_uapi.c:1052:13: sparse:     expected signed int *__pu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1052:13: sparse:     got signed int [noderef] [usertype] <asn:1> *out_fence_ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1052:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:1> *to @@     got signed int *__pu_addr @@
   drivers/gpu/drm/drm_atomic_uapi.c:1052:13: sparse:     expected void [noderef] <asn:1> *to
   drivers/gpu/drm/drm_atomic_uapi.c:1052:13: sparse:     got signed int *__pu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1230:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__pu_addr @@     got signed int [noderef] [usertype] <asn:1> *out_fence_ptr @@
   drivers/gpu/drm/drm_atomic_uapi.c:1230:21: sparse:     expected signed int *__pu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1230:21: sparse:     got signed int [noderef] [usertype] <asn:1> *out_fence_ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1230:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:1> *to @@     got signed int *__pu_addr @@
   drivers/gpu/drm/drm_atomic_uapi.c:1230:21: sparse:     expected void [noderef] <asn:1> *to
   drivers/gpu/drm/drm_atomic_uapi.c:1230:21: sparse:     got signed int *__pu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1297:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] <asn:1> * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1297:21: sparse:     expected unsigned int const *__gu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1297:21: sparse:     got unsigned int [noderef] [usertype] <asn:1> *
>> drivers/gpu/drm/drm_atomic_uapi.c:1297:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got unsigned int const *__gu_addr @@
   drivers/gpu/drm/drm_atomic_uapi.c:1297:21: sparse:     expected void const [noderef] <asn:1> *from
   drivers/gpu/drm/drm_atomic_uapi.c:1297:21: sparse:     got unsigned int const *__gu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1314:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] <asn:1> * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1314:21: sparse:     expected unsigned int const *__gu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1314:21: sparse:     got unsigned int [noderef] [usertype] <asn:1> *
   drivers/gpu/drm/drm_atomic_uapi.c:1314:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got unsigned int const *__gu_addr @@
   drivers/gpu/drm/drm_atomic_uapi.c:1314:21: sparse:     expected void const [noderef] <asn:1> *from
   drivers/gpu/drm/drm_atomic_uapi.c:1314:21: sparse:     got unsigned int const *__gu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1327:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] <asn:1> * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1327:29: sparse:     expected unsigned int const *__gu_addr
   drivers/gpu/drm/drm_atomic_uapi.c:1327:29: sparse:     got unsigned int [noderef] [usertype] <asn:1> *
   drivers/gpu/drm/drm_atomic_uapi.c:1327:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got unsigned int const *__gu_addr @@
   drivers/gpu/drm/drm_atomic_uapi.c:1327:29: sparse:     expected void const [noderef] <asn:1> *from
   drivers/gpu/drm/drm_atomic_uapi.c:1327:29: sparse:     got unsigned int const *__gu_addr
   drivers/gpu/drm/drm_atomic_uapi.c: In function 'complete_signaling':
   drivers/gpu/drm/drm_atomic_uapi.c:1193:26: warning: variable 'crtc' set but not used [-Wunused-but-set-variable]
    1193 |         struct drm_crtc *crtc;
         |                          ^~~~

vim +366 drivers/gpu/drm/drm_atomic_uapi.c

   356	
   357	static int set_out_fence_for_connector(struct drm_atomic_state *state,
   358						struct drm_connector *connector,
   359						s32 __user *fence_ptr)
   360	{
   361		unsigned int index = drm_connector_index(connector);
   362	
   363		if (!fence_ptr)
   364			return 0;
   365	
 > 366		if (put_user(-1, fence_ptr))
   367			return -EFAULT;
   368	
   369		state->connectors[index].out_fence_ptr = fence_ptr;
   370	
   371		return 0;
   372	}
   373	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
