Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC64502655
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347356AbiDOHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiDOHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:46:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F042B1ABF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650008651; x=1681544651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g84P2W3BTYDSB1xzcWvTRj90XvlvAwoYNdOYEV4T8Mw=;
  b=ZttL1JHYqrR6eOIt4sqzDqONfPNwgLRpQAS2Uaz20z/kyLGPwtA1b3Ih
   V0XtRblNkmX24NCcik97jx+ZBPjQLIWHz0Yqd2Z2ycbNkJUtzCQe1EmXS
   BLDMlypcttWX+lB/mg0RpO/xNnESow5h2FseOcnM9sEYvhfc32enkfAEX
   TXdHK/gUvNco0yijk3dc2F+Oc286c5VKHr38TSaRIuA6DpMMgGWyH9nXB
   uxi+Ann3lOeaRiTj7VTLeC/dR5SwWjK4D7Y3L2+91sjJCtTO02ntZGhK3
   GM/LoNfPqw2ZSueuJCCjDB0e3+gBB3TUYhc627CoqDstv+Sg5bqWRXNP2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243699336"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="243699336"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 00:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="645982542"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2022 00:44:09 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfGcj-0001jy-3f;
        Fri, 15 Apr 2022 07:44:09 +0000
Date:   Fri, 15 Apr 2022 15:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [cminyard-ipmi:for-next 9/11]
 drivers/char/ipmi/ipmi_msghandler.c:2387:3: error: called object type
 'char[23]' is not a function or function pointer
Message-ID: <202204151545.BSqW9sPa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/cminyard/linux-ipmi for-next
head:   d2e94b3095bb7886bce0fb313bc9f65a94dc6ce5
commit: 7cd75d3cce636c70f968287dfeaee1458564d1ba [9/11] ipmi: Convert pr_debug() to dev_dbg()
config: arm-randconfig-c002-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151545.BSqW9sPa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/cminyard/linux-ipmi/commit/7cd75d3cce636c70f968287dfeaee1458564d1ba
        git remote add cminyard-ipmi https://github.com/cminyard/linux-ipmi
        git fetch --no-tags cminyard-ipmi for-next
        git checkout 7cd75d3cce636c70f968287dfeaee1458564d1ba
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/char/ipmi/ipmi_msghandler.c:2387:3: error: called object type 'char[23]' is not a function or function pointer
                   dev_dbg(intf->si_dev, "Send: %*ph\n",
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:2: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
           ^                    ~~~~~~~~~~~~
   include/linux/dynamic_debug.h:166:2: note: expanded from macro 'dynamic_dev_dbg'
           _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
           ^                  ~~~
   include/linux/dynamic_debug.h:152:2: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
           ^                                             ~~~~
   include/linux/dynamic_debug.h:134:7: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                   ~~~~^
   drivers/char/ipmi/ipmi_msghandler.c:3926:3: error: called object type 'char[23]' is not a function or function pointer
                   dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:2: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
           ^                    ~~~~~~~~~~~~
   include/linux/dynamic_debug.h:166:2: note: expanded from macro 'dynamic_dev_dbg'
           _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
           ^                  ~~~
   include/linux/dynamic_debug.h:152:2: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
           ^                                             ~~~~
   include/linux/dynamic_debug.h:134:7: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                   ~~~~^
   drivers/char/ipmi/ipmi_msghandler.c:4535:2: error: called object type 'char[23]' is not a function or function pointer
           dev_dbg(intf->si_dev, "Recv: %*ph\n", msg->rsp_size, msg->rsp);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:2: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
           ^                    ~~~~~~~~~~~~
   include/linux/dynamic_debug.h:166:2: note: expanded from macro 'dynamic_dev_dbg'
           _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
           ^                  ~~~
   include/linux/dynamic_debug.h:152:2: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
           ^                                             ~~~~
   include/linux/dynamic_debug.h:134:7: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                   ~~~~^
   drivers/char/ipmi/ipmi_msghandler.c:4917:2: error: called object type 'char[23]' is not a function or function pointer
           dev_dbg(intf->si_dev, "Resend: %*ph\n",
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:2: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
           ^                    ~~~~~~~~~~~~
   include/linux/dynamic_debug.h:166:2: note: expanded from macro 'dynamic_dev_dbg'
           _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
           ^                  ~~~
   include/linux/dynamic_debug.h:152:2: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
           ^                                             ~~~~
   include/linux/dynamic_debug.h:134:7: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                   ~~~~^
   4 errors generated.


vim +2387 drivers/char/ipmi/ipmi_msghandler.c

  2290	
  2291	/*
  2292	 * Separate from ipmi_request so that the user does not have to be
  2293	 * supplied in certain circumstances (mainly at panic time).  If
  2294	 * messages are supplied, they will be freed, even if an error
  2295	 * occurs.
  2296	 */
  2297	static int i_ipmi_request(struct ipmi_user     *user,
  2298				  struct ipmi_smi      *intf,
  2299				  struct ipmi_addr     *addr,
  2300				  long                 msgid,
  2301				  struct kernel_ipmi_msg *msg,
  2302				  void                 *user_msg_data,
  2303				  void                 *supplied_smi,
  2304				  struct ipmi_recv_msg *supplied_recv,
  2305				  int                  priority,
  2306				  unsigned char        source_address,
  2307				  unsigned char        source_lun,
  2308				  int                  retries,
  2309				  unsigned int         retry_time_ms)
  2310	{
  2311		struct ipmi_smi_msg *smi_msg;
  2312		struct ipmi_recv_msg *recv_msg;
  2313		int rv = 0;
  2314	
  2315		if (user) {
  2316			if (atomic_add_return(1, &user->nr_msgs) > max_msgs_per_user) {
  2317				/* Decrement will happen at the end of the routine. */
  2318				rv = -EBUSY;
  2319				goto out;
  2320			}
  2321		}
  2322	
  2323		if (supplied_recv)
  2324			recv_msg = supplied_recv;
  2325		else {
  2326			recv_msg = ipmi_alloc_recv_msg();
  2327			if (recv_msg == NULL) {
  2328				rv = -ENOMEM;
  2329				goto out;
  2330			}
  2331		}
  2332		recv_msg->user_msg_data = user_msg_data;
  2333	
  2334		if (supplied_smi)
  2335			smi_msg = (struct ipmi_smi_msg *) supplied_smi;
  2336		else {
  2337			smi_msg = ipmi_alloc_smi_msg();
  2338			if (smi_msg == NULL) {
  2339				if (!supplied_recv)
  2340					ipmi_free_recv_msg(recv_msg);
  2341				rv = -ENOMEM;
  2342				goto out;
  2343			}
  2344		}
  2345	
  2346		rcu_read_lock();
  2347		if (intf->in_shutdown) {
  2348			rv = -ENODEV;
  2349			goto out_err;
  2350		}
  2351	
  2352		recv_msg->user = user;
  2353		if (user)
  2354			/* The put happens when the message is freed. */
  2355			kref_get(&user->refcount);
  2356		recv_msg->msgid = msgid;
  2357		/*
  2358		 * Store the message to send in the receive message so timeout
  2359		 * responses can get the proper response data.
  2360		 */
  2361		recv_msg->msg = *msg;
  2362	
  2363		if (addr->addr_type == IPMI_SYSTEM_INTERFACE_ADDR_TYPE) {
  2364			rv = i_ipmi_req_sysintf(intf, addr, msgid, msg, smi_msg,
  2365						recv_msg, retries, retry_time_ms);
  2366		} else if (is_ipmb_addr(addr) || is_ipmb_bcast_addr(addr)) {
  2367			rv = i_ipmi_req_ipmb(intf, addr, msgid, msg, smi_msg, recv_msg,
  2368					     source_address, source_lun,
  2369					     retries, retry_time_ms);
  2370		} else if (is_ipmb_direct_addr(addr)) {
  2371			rv = i_ipmi_req_ipmb_direct(intf, addr, msgid, msg, smi_msg,
  2372						    recv_msg, source_lun);
  2373		} else if (is_lan_addr(addr)) {
  2374			rv = i_ipmi_req_lan(intf, addr, msgid, msg, smi_msg, recv_msg,
  2375					    source_lun, retries, retry_time_ms);
  2376		} else {
  2377		    /* Unknown address type. */
  2378			ipmi_inc_stat(intf, sent_invalid_commands);
  2379			rv = -EINVAL;
  2380		}
  2381	
  2382		if (rv) {
  2383	out_err:
  2384			ipmi_free_smi_msg(smi_msg);
  2385			ipmi_free_recv_msg(recv_msg);
  2386		} else {
> 2387			dev_dbg(intf->si_dev, "Send: %*ph\n",
  2388				smi_msg->data_size, smi_msg->data);
  2389	
  2390			smi_send(intf, intf->handlers, smi_msg, priority);
  2391		}
  2392		rcu_read_unlock();
  2393	
  2394	out:
  2395		if (rv && user)
  2396			atomic_dec(&user->nr_msgs);
  2397		return rv;
  2398	}
  2399	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
