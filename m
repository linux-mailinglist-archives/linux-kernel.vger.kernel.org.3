Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40DB591B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiHMPm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiHMPmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:42:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80092AE19
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660405343; x=1691941343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VB/PcJMaVCoLLAmK7NLDHktq+XG2Uv/dpCQjBWs76r4=;
  b=WLxKp9/vhApzHo/uecWB6dnWwoj6+FFnjszJHXKECdeecd4+FJsBx+WD
   IA6mWhuW2kOGQkmeL5i6VDuFF9JovwcCnKRa08eZodhsu8n0WDstQQnGW
   LvNWXmzZFhSgyL7WIY/Sr8QKYgHlKvxQ9YbdMgRnxezqtWsaA9VsYj3r5
   8QDLWV9RhIl+yUHyx6BD1LdIG0P3+IDO+iDzCr7xBwG2BGhEP0jJhkpnf
   5GcL+IpVlBEm8Qgk3qpziyHqGTaq3jl1w8D/B1wFHG6N/4/yuZwbRfkhG
   1e3p/RIIfOXF5F13gh6Rnp4ppP6l65ksxZjDmeuEpmqnnVSj0yr++DmM1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353503191"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="353503191"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 08:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="582408332"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Aug 2022 08:42:22 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMtHJ-0001ov-1c;
        Sat, 13 Aug 2022 15:42:21 +0000
Date:   Sat, 13 Aug 2022 23:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:io_uring/dma-register-v3 7/8] io_uring/io_uring.c:3791:45:
 error: passing argument 2 of 'file_dma_map' from incompatible pointer type
Message-ID: <202208132330.PC5BGFCf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git io_uring/dma-register-v3
head:   e1c6d38d05e532b3aaf12a5ab8707929bcdc1180
commit: bb54dc361fec200988cb7f0a32cea77db3a7e6fe [7/8] io_uring: add support for dma pre-mapping
config: m68k-buildonly-randconfig-r001-20220804 (https://download.01.org/0day-ci/archive/20220813/202208132330.PC5BGFCf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=bb54dc361fec200988cb7f0a32cea77db3a7e6fe
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch io_uring/dma-register-v3
        git checkout bb54dc361fec200988cb7f0a32cea77db3a7e6fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from io_uring/io_uring.c:45:
   include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   io_uring/io_uring.c: In function '__io_submit_flush_completions':
   io_uring/io_uring.c:1183:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    1183 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   io_uring/io_uring.c: In function 'io_register_map_buffers':
>> io_uring/io_uring.c:3791:45: error: passing argument 2 of 'file_dma_map' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3791 |                 tag = file_dma_map(file, imu->bvec, imu->nr_bvecs);
         |                                          ~~~^~~~~~
         |                                             |
         |                                             struct bio_vec *
   include/linux/fs.h:3610:69: note: expected 'struct bio_vec *' but argument is of type 'struct bio_vec *'
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                     ~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/file_dma_map +3791 io_uring/io_uring.c

  3758	
  3759	static int io_register_map_buffers(struct io_ring_ctx *ctx, void __user *arg)
  3760	{
  3761		struct io_uring_map_buffers map;
  3762		struct io_fixed_file *file_slot;
  3763		struct file *file;
  3764		int ret, i;
  3765	
  3766		if (!capable(CAP_SYS_ADMIN))
  3767			return -EPERM;
  3768	
  3769		ret = get_map_range(ctx, &map, arg);
  3770		if (ret < 0)
  3771			return ret;
  3772	
  3773		file_slot = io_fixed_file_slot(&ctx->file_table,
  3774				array_index_nospec(map.fd, ctx->nr_user_files));
  3775		if (!file_slot->file_ptr)
  3776			return -EBADF;
  3777	
  3778		file = io_file_from_fixed(file_slot);
  3779		if (!(file->f_flags & O_DIRECT))
  3780			return -EOPNOTSUPP;
  3781	
  3782		for (i = map.buf_start; i < map.buf_end; i++) {
  3783			struct io_mapped_ubuf *imu = ctx->user_bufs[i];
  3784			void *tag;
  3785	
  3786			if (imu->dma_tag) {
  3787				ret = -EBUSY;
  3788				goto err;
  3789			}
  3790	
> 3791			tag = file_dma_map(file, imu->bvec, imu->nr_bvecs);
  3792			if (IS_ERR(tag)) {
  3793				ret = PTR_ERR(tag);
  3794				goto err;
  3795			}
  3796	
  3797			imu->dma_tag = tag;
  3798			imu->dma_file = file;
  3799		}
  3800	
  3801		return 0;
  3802	err:
  3803		while (--i >= map.buf_start) {
  3804			struct io_mapped_ubuf *imu = ctx->user_bufs[i];
  3805	
  3806			io_dma_unmap(imu);
  3807		}
  3808		return ret;
  3809	}
  3810	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
