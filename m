Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95950CF0A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbiDXD5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbiDXD5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:57:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF7652B2A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650772442; x=1682308442;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UKJQEnsMftdGE/bY8JiKT7d4w5bXIEmB3cqQhlhwCY4=;
  b=ReCe4X3OLMXSixyLzXJh9IQ9B05WjXEqPG1PIKtRreDgGdIXXjzuQDjz
   a0rdbyUAaun/0r3qtfciOSqpv9IgYuvzSBsb4X+XkYUONR9zPoKW2IrGl
   etW5sR0X2rIH//2ZvhRLopM/WhJrHpGSsvmtuSSW6JlBFxD11iB9q4aph
   b1orzP8rRFwetxSdnbNGmfxOY8QLfnxe5D8ZmfZX59Cuh1j2G8OYqX3Ur
   ERThdgESBuq5/LUgvo+QKQJ4EyTt0KOmiZeDFYtZBQDkKF+HraInM6Whb
   TWbvIZX0hzXZd3si9uoZf8S4r2tqHns+kNn7Ny1G4Rfmzd7OPQA6IbwTe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="245558731"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="245558731"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 20:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="729142199"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 20:54:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niTJv-0000yn-RP;
        Sun, 24 Apr 2022 03:53:59 +0000
Date:   Sun, 24 Apr 2022 11:53:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 35/44]
 include/linux/instrumented.h:101: undefined reference to `fscache_n_updates'
Message-ID: <202204241147.EvsFGZii-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: f343507aeda88b2f1a528a659b8fadaa9b6b0f79 [35/44] netfs: Implement buffered writes through netfs_file_write_iter()
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220424/202204241147.EvsFGZii-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/f343507aeda88b2f1a528a659b8fadaa9b6b0f79
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout f343507aeda88b2f1a528a659b8fadaa9b6b0f79
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: fs/netfs/buffered_write.o: in function `instrument_atomic_read_write':
>> include/linux/instrumented.h:101: undefined reference to `fscache_n_updates'
   ld: fs/netfs/buffered_write.o: in function `arch_atomic_inc':
>> arch/x86/include/asm/atomic.h:95: undefined reference to `fscache_n_updates'
   ld: fs/netfs/output.o: in function `fscache_begin_write_operation':
   include/linux/fscache.h:540: undefined reference to `__fscache_begin_write_operation'


vim +101 include/linux/instrumented.h

36e4d4dd4fc4f1 Marco Elver 2020-01-21   89  
00047c2e6d7c57 Marco Elver 2020-07-24   90  /**
00047c2e6d7c57 Marco Elver 2020-07-24   91   * instrument_atomic_read_write - instrument atomic read-write access
00047c2e6d7c57 Marco Elver 2020-07-24   92   *
00047c2e6d7c57 Marco Elver 2020-07-24   93   * Instrument an atomic read-write access. The instrumentation should be
00047c2e6d7c57 Marco Elver 2020-07-24   94   * inserted before the actual write happens.
00047c2e6d7c57 Marco Elver 2020-07-24   95   *
00047c2e6d7c57 Marco Elver 2020-07-24   96   * @ptr address of access
00047c2e6d7c57 Marco Elver 2020-07-24   97   * @size size of access
00047c2e6d7c57 Marco Elver 2020-07-24   98   */
00047c2e6d7c57 Marco Elver 2020-07-24   99  static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
00047c2e6d7c57 Marco Elver 2020-07-24  100  {
00047c2e6d7c57 Marco Elver 2020-07-24 @101  	kasan_check_write(v, size);
00047c2e6d7c57 Marco Elver 2020-07-24  102  	kcsan_check_atomic_read_write(v, size);
00047c2e6d7c57 Marco Elver 2020-07-24  103  }
00047c2e6d7c57 Marco Elver 2020-07-24  104  

:::::: The code at line 101 was first introduced by commit
:::::: 00047c2e6d7c576c1a847f7db07ef0fc58085f22 instrumented.h: Introduce read-write instrumentation hooks

:::::: TO: Marco Elver <elver@google.com>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
