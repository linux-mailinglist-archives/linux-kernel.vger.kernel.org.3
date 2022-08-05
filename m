Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14FC58A4EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 05:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiHEDOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 23:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHEDOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:14:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325402127A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 20:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659669250; x=1691205250;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0cX+DQoW2QryIy+M2qCtgHGKyzKjLOtceyNmjms8I8k=;
  b=n4HQrI2cXvFjZZmT6vDrV5UlPYcOHTYW/MMhTG/yrKliqdeC8g08MUqb
   vk4RRhz2YAX3at4CImTaWhUu0h5vPKjv2bMhV2BH/MEOJ8epBApgTjMWq
   eVubJzcS7CfiRx/2t8gQcAGd6orDdlw4/uyH4naw0c6zq3lzSzB8/nnxw
   /1sB9juxWEXDA/AOoxqXY/FFfnD37TrDtWw8d47Ph31dkKsuo+clVfY6X
   kfdRkAmv1xU009LBM5KFr7GbcYWSYaidgV1A7Y/eQRW312VOOUtm2iuyf
   3ZLnOSCabw+RoNocHhtPAUbxbmy56u2d9E+XPcvbNASoJkEnDmzTzC4b/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="351822765"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="351822765"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 20:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671541637"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2022 20:14:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJnmp-000J5p-35;
        Fri, 05 Aug 2022 03:14:07 +0000
Date:   Fri, 5 Aug 2022 11:14:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dylan Yudaken <dylany@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: io_uring/net.c:564:44: sparse: sparse: incorrect type in assignment
 (different address spaces)
Message-ID: <202208051104.7NeIlCzj-lkp@intel.com>
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
head:   31be1d0fbd950395701d9fd47d8fb1f99c996f61
commit: 9bb66906f23e50d6db1e11f7498b72dfca1982a2 io_uring: support multishot in recvmsg
date:   11 days ago
config: alpha-randconfig-s043-20220804 (https://download.01.org/0day-ci/archive/20220805/202208051104.7NeIlCzj-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bb66906f23e50d6db1e11f7498b72dfca1982a2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9bb66906f23e50d6db1e11f7498b72dfca1982a2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   io_uring/net.c: note: in included file (through io_uring/io_uring.h):
   io_uring/slist.h:138:29: sparse: sparse: no newline at end of file
>> io_uring/net.c:564:44: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *msg_control_user @@     got void * @@
   io_uring/net.c:564:44: sparse:     expected void [noderef] __user *msg_control_user
   io_uring/net.c:564:44: sparse:     got void *
>> io_uring/net.c:569:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   io_uring/net.c:569:14: sparse:     expected void [noderef] __user *
   io_uring/net.c:569:14: sparse:     got void *

vim +564 io_uring/net.c

   548	
   549	static int io_recvmsg_prep_multishot(struct io_async_msghdr *kmsg,
   550					     struct io_sr_msg *sr, void __user **buf,
   551					     size_t *len)
   552	{
   553		unsigned long ubuf = (unsigned long) *buf;
   554		unsigned long hdr;
   555	
   556		hdr = sizeof(struct io_uring_recvmsg_out) + kmsg->namelen +
   557			kmsg->controllen;
   558		if (*len < hdr)
   559			return -EFAULT;
   560	
   561		if (kmsg->controllen) {
   562			unsigned long control = ubuf + hdr - kmsg->controllen;
   563	
 > 564			kmsg->msg.msg_control_user = (void *) control;
   565			kmsg->msg.msg_controllen = kmsg->controllen;
   566		}
   567	
   568		sr->buf = *buf; /* stash for later copy */
 > 569		*buf = (void *) (ubuf + hdr);
   570		kmsg->payloadlen = *len = *len - hdr;
   571		return 0;
   572	}
   573	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
