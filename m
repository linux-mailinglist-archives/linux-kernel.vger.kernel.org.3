Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34A0515F51
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383172AbiD3Qoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383169AbiD3Qoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:44:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2061A824
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651336870; x=1682872870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uDxIPh1uye+uJJf7dVhmWzNhTsY/pRGws8jFAb9xpKs=;
  b=ULNbtcPza8vQ6nDKIkb7HGnSgabznocGYWwXR82VRo6xU/hTXzvLQwqA
   hZ/VbXVl9awFVvEiAQf+Ma6zgRYacqUYStfbL78DO+DeOOj81DUDoXwah
   mAK/yQHDIDGK70Dc3CFwVuPIjxOPdZ4WZOBTvvnfCWSPxARPZznHd3QIi
   e9aI3FQ+Ts9qKADjaUF9RRyjDZBsXfsPVAsIEIPdxJ2K+AnyMUl36cDji
   PgNR2iLBHF+uYYl+e0P2+/ixiQAdKHYq5Mf/yRKZQdwjPMXQSNyX23+MY
   Z/QjuONWMa0+TJ8EnAlSLXarrUdae6rTdPjMvoouvAzc05o9YKm12nfnl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="353329260"
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="353329260"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 09:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="515335433"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Apr 2022 09:41:08 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkq9b-0007Pb-JD;
        Sat, 30 Apr 2022 16:41:07 +0000
Date:   Sun, 1 May 2022 00:40:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:nfsd-courteous-server 3/7] fs/nfsd/nfsd.h:180:59: error:
 expected ';' after return statement
Message-ID: <202205010039.npL4Bn76-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux nfsd-courteous-server
head:   d5b28de053a07bebbf61359a4bbceeaef3b48962
commit: 5e58ea722404baa3052c44d8e68129502b34f135 [3/7] NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220501/202205010039.npL4Bn76-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=5e58ea722404baa3052c44d8e68129502b34f135
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel nfsd-courteous-server
        git checkout 5e58ea722404baa3052c44d8e68129502b34f135
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/nfsd/nfssvc.c:27:
>> fs/nfsd/nfsd.h:180:59: error: expected ';' after return statement
   static inline int nfsd4_create_laundry_wq(void) { return 0 };
                                                             ^
                                                             ;
   1 error generated.
--
   In file included from fs/nfsd/export.c:21:
>> fs/nfsd/nfsd.h:180:59: error: expected ';' after return statement
   static inline int nfsd4_create_laundry_wq(void) { return 0 };
                                                             ^
                                                             ;
   fs/nfsd/export.c:979:17: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
           struct inode            *inode;
                                    ^
   1 warning and 1 error generated.
--
   In file included from fs/nfsd/trace.c:4:
   In file included from fs/nfsd/trace.h:442:
   In file included from fs/nfsd/state.h:42:
>> fs/nfsd/nfsd.h:180:59: error: expected ';' after return statement
   static inline int nfsd4_create_laundry_wq(void) { return 0 };
                                                             ^
                                                             ;
   In file included from fs/nfsd/trace.c:4:
   In file included from fs/nfsd/trace.h:1130:
   include/trace/define_trace.h:95:10: fatal error: './trace.h' file not found
   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:90:32: note: expanded from macro 'TRACE_INCLUDE'
   # define TRACE_INCLUDE(system) __TRACE_INCLUDE(system)
                                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:87:34: note: expanded from macro '__TRACE_INCLUDE'
   # define __TRACE_INCLUDE(system) __stringify(TRACE_INCLUDE_PATH/system.h)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stringify.h:10:27: note: expanded from macro '__stringify'
   #define __stringify(x...)       __stringify_1(x)
                                   ^~~~~~~~~~~~~~~~
   include/linux/stringify.h:9:29: note: expanded from macro '__stringify_1'
   #define __stringify_1(x...)     #x
                                   ^~
   <scratch space>:45:1: note: expanded from here
   "./trace.h"
   ^~~~~~~~~~~
   2 errors generated.


vim +180 fs/nfsd/nfsd.h

   150	
   151	/* 
   152	 * NFSv4 State
   153	 */
   154	#ifdef CONFIG_NFSD_V4
   155	extern unsigned long max_delegations;
   156	int nfsd4_init_slabs(void);
   157	void nfsd4_free_slabs(void);
   158	int nfs4_state_start(void);
   159	int nfs4_state_start_net(struct net *net);
   160	void nfs4_state_shutdown(void);
   161	void nfs4_state_shutdown_net(struct net *net);
   162	int nfs4_reset_recoverydir(char *recdir);
   163	char * nfs4_recoverydir(void);
   164	bool nfsd4_spo_must_allow(struct svc_rqst *rqstp);
   165	int nfsd4_create_laundry_wq(void);
   166	void nfsd4_destroy_laundry_wq(void);
   167	#else
   168	static inline int nfsd4_init_slabs(void) { return 0; }
   169	static inline void nfsd4_free_slabs(void) { }
   170	static inline int nfs4_state_start(void) { return 0; }
   171	static inline int nfs4_state_start_net(struct net *net) { return 0; }
   172	static inline void nfs4_state_shutdown(void) { }
   173	static inline void nfs4_state_shutdown_net(struct net *net) { }
   174	static inline int nfs4_reset_recoverydir(char *recdir) { return 0; }
   175	static inline char * nfs4_recoverydir(void) {return NULL; }
   176	static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
   177	{
   178		return false;
   179	}
 > 180	static inline int nfsd4_create_laundry_wq(void) { return 0 };
   181	static inline void nfsd4_destroy_laundry_wq(void) {};
   182	#endif
   183	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
