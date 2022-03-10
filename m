Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78714D41A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiCJHOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiCJHOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:14:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C873C7E7D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646896418; x=1678432418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5ernpgFyeVBaec0j6i1p29XPpb2BWKA2H3QhtbjZW8c=;
  b=fIxwBQqkMO59E+5N6y0V5hEgT3gw8N7XjnGrWrQvxW2vq7J4YC+4tMnf
   vbPdRiQuCs+bppu+atvoQ2QtpULBV5MBv45ZYbj/N1Qcgv1aR12ARIC+o
   PH45ipEWjWri0v/WiER/OPLTcyZxnU7jLz8jQqv4Tl79c0wXmz9mi7eXH
   rH0m/vF/DqENUgRz+CyCAj2PMIxQr9rio4wcbJWZMmLKTuD2JAO1tIAzl
   EMj6UY0P66pOJMMYYvmBk9UcjNjVsoH1ECtuoGsTIgWNtzYiXadZxaekc
   u7N9Qn16m9C/edNsfe1C7KGTbRkufsOrJpiiKMOqPc6Vzb0HYMcbKv+i6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318403018"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="318403018"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 23:13:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="712252760"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2022 23:13:36 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSCzP-0004WM-LZ; Thu, 10 Mar 2022 07:13:35 +0000
Date:   Thu, 10 Mar 2022 15:12:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:nfsd-courteous-server 39/39] fs/nfsd/nfs4state.c:2460:60:
 warning: format specifies type 'long' but the argument has type 'u64' (aka
 'unsigned long long')
Message-ID: <202203101509.pWJbkMAO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux nfsd-courteous-server
head:   25cf03b50a8a38217a4e1a9b178af4d9afa2b9ea
commit: 25cf03b50a8a38217a4e1a9b178af4d9afa2b9ea [39/39] NFSD: Show state of courtesy clients in client info
config: arm-colibri_pxa270_defconfig (https://download.01.org/0day-ci/archive/20220310/202203101509.pWJbkMAO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=25cf03b50a8a38217a4e1a9b178af4d9afa2b9ea
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel nfsd-courteous-server
        git checkout 25cf03b50a8a38217a4e1a9b178af4d9afa2b9ea
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/nfsd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/nfsd/nfs4state.c:2460:60: warning: format specifies type 'long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
           seq_printf(m, "time since last renew: %02ld:%02d:%02d\n", hrs, mins, secs);
                                                 ~~~~~               ^~~
                                                 %02llu
   1 warning generated.


vim +2460 fs/nfsd/nfs4state.c

  2437	
  2438	static int client_info_show(struct seq_file *m, void *v)
  2439	{
  2440		struct inode *inode = m->private;
  2441		struct nfs4_client *clp;
  2442		u64 clid, hrs;
  2443		u32 mins, secs;
  2444	
  2445		clp = get_nfsdfs_clp(inode);
  2446		if (!clp)
  2447			return -ENXIO;
  2448		memcpy(&clid, &clp->cl_clientid, sizeof(clid));
  2449		seq_printf(m, "clientid: 0x%llx\n", clid);
  2450		seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
  2451		if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
  2452			seq_puts(m, "status: confirmed\n");
  2453		else
  2454			seq_puts(m, "status: unconfirmed\n");
  2455		seq_printf(m, "courtesy client: %s\n",
  2456			test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
  2457		hrs = div_u64_rem(ktime_get_boottime_seconds() - clp->cl_time,
  2458					3600, &secs);
  2459		mins = div_u64_rem((u64)secs, 60, &secs);
> 2460		seq_printf(m, "time since last renew: %02ld:%02d:%02d\n", hrs, mins, secs);
  2461		seq_printf(m, "name: ");
  2462		seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
  2463		seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
  2464		if (clp->cl_nii_domain.data) {
  2465			seq_printf(m, "Implementation domain: ");
  2466			seq_quote_mem(m, clp->cl_nii_domain.data,
  2467						clp->cl_nii_domain.len);
  2468			seq_printf(m, "\nImplementation name: ");
  2469			seq_quote_mem(m, clp->cl_nii_name.data, clp->cl_nii_name.len);
  2470			seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
  2471				clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
  2472		}
  2473		seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
  2474		seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
  2475		drop_client(clp);
  2476	
  2477		return 0;
  2478	}
  2479	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
