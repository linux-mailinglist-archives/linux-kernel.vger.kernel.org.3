Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64134E84A9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 00:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiCZXkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 19:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCZXkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 19:40:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0946338F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648337922; x=1679873922;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p1wjTOYbuXsU+nAHmhSFbOEvFUHM7rU459WZNKbiCNc=;
  b=cknYCtM26bO2QITtdcuq/EVPkCtB5py9+K1iz+QnRJl64ioTZIL5vZeF
   qI0PKJwzvWqWGJPE6Z00Gc/K8EvgSLX52mDUWpaakpY2UwR6guMaB4/Ft
   T+xBIAGR0zvTXe152sjNDDChEdCqv9rblb1LKOMog6xGHl2uEvFOF31Dr
   ZEvP3rTnCHaINF9YKYaT9PzF5z9EBz0rpUAMOUQchfE5PRIuLZqSwyO2Q
   VI+0YH6OFUJ+6Df+q9d8OTGQbAG7hs1i32Fd4CVBC5UGd5vPFCC8fOSiP
   tex0m976vp5BW4U4rDMWEK21v7vwWh8oynD9DgYg6nCJrGXfP5PcwvQWp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="258526658"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="258526658"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 16:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="520576215"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 16:38:40 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYFzT-0000Vb-Lk; Sat, 26 Mar 2022 23:38:39 +0000
Date:   Sun, 27 Mar 2022 07:37:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/afs-testing 44/45]
 arch/sparc/include/asm/cmpxchg_64.h:95:36: sparse: sparse: cast truncates
 bits from constant value (5e5ee5e5 becomes e5e5)
Message-ID: <202203270732.dEGMthw5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/afs-testing
head:   bd9f21ac2aa3a4b3332c504a89afe0019a56391a
commit: 17b80dadaf0195ee91f7f115d78b0ea93ae3355c [44/45] Check for dead timer
config: sparc-randconfig-s031-20220327 (https://download.01.org/0day-ci/archive/20220327/202203270732.dEGMthw5-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/17b80dadaf0195ee91f7f115d78b0ea93ae3355c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/afs-testing
        git checkout 17b80dadaf0195ee91f7f115d78b0ea93ae3355c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/time/timer.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_64.h, arch/sparc/include/asm/atomic.h, ...):
>> arch/sparc/include/asm/cmpxchg_64.h:95:36: sparse: sparse: cast truncates bits from constant value (5e5ee5e5 becomes e5e5)

vim +95 arch/sparc/include/asm/cmpxchg_64.h

79d39e2bab60d1 Babu Moger    2017-05-24   89  
d550bbd40c0e10 David Howells 2012-03-28   90  static inline unsigned long __xchg(unsigned long x, __volatile__ void * ptr,
d550bbd40c0e10 David Howells 2012-03-28   91  				       int size)
d550bbd40c0e10 David Howells 2012-03-28   92  {
d550bbd40c0e10 David Howells 2012-03-28   93  	switch (size) {
79d39e2bab60d1 Babu Moger    2017-05-24   94  	case 2:
79d39e2bab60d1 Babu Moger    2017-05-24  @95  		return xchg16(ptr, x);
d550bbd40c0e10 David Howells 2012-03-28   96  	case 4:
d550bbd40c0e10 David Howells 2012-03-28   97  		return xchg32(ptr, x);
d550bbd40c0e10 David Howells 2012-03-28   98  	case 8:
d550bbd40c0e10 David Howells 2012-03-28   99  		return xchg64(ptr, x);
d550bbd40c0e10 David Howells 2012-03-28  100  	}
d550bbd40c0e10 David Howells 2012-03-28  101  	__xchg_called_with_bad_pointer();
d550bbd40c0e10 David Howells 2012-03-28  102  	return x;
d550bbd40c0e10 David Howells 2012-03-28  103  }
d550bbd40c0e10 David Howells 2012-03-28  104  

:::::: The code at line 95 was first introduced by commit
:::::: 79d39e2bab60d18a68a5abc00be4506864397efc arch/sparc: Introduce xchg16 for SPARC

:::::: TO: Babu Moger <babu.moger@oracle.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
