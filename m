Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00D4DC4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiCQL1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCQL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:27:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01A1E3E0D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647516393; x=1679052393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iJqvGVWhzDVUcAPg0HUz1xEF0GH29mLyFmMcU266Tbs=;
  b=ATpkQ75wDGL67e+VcRip4QWbcWThpTQZysIXQhKU79Pogu52OM/Ht+RP
   qHIkhqmZ5+nuYS6ffyJ1dkSb//Ev2w6dgFwePpD2TBQ3vEaEN8hQOIdqg
   XPY6lzusBqunednSJIpgh/9FRPyZwJqyOLlfbND/utG86tepBrn30ypd/
   OtcNUWJaxAentVdhKH8f4M2u5nuzO4tbH/TP7aWYjHfcP9reoif/5LXv5
   xESHYiaICKDgd8Nz4p44RFFQxifKkiBLnAe/nkKq6shEyuJ1zwYAW4ATK
   b6Zrr5HOheAujeda6trsl3hrPIcu/FVNXVqIe34wHVxMKa/Q/r4efBWes
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="237453613"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237453613"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 04:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="714998094"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2022 04:26:32 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUoH1-000DdL-Ev; Thu, 17 Mar 2022 11:26:31 +0000
Date:   Thu, 17 Mar 2022 19:26:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kishen Maloor <kishen.maloor@intel.com>
Cc:     kbuild-all@lists.01.org, mathew.j.martineau@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [martineau:kbuild-mptcp-enabled 7/19] net/mptcp/pm_netlink.c:397:23:
 warning: variable 'pernet' set but not used
Message-ID: <202203171940.XUdtPaZP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git kbuild-mptcp-enabled
head:   1842e2df09dac50790d935c8db37aae18f7ad5ab
commit: 11b70f473e519350157fa74fefbdb6d12a99a199 [7/19] mptcp: handle local addrs announced by userspace PMs
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220317/202203171940.XUdtPaZP-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/commit/?id=11b70f473e519350157fa74fefbdb6d12a99a199
        git remote add martineau https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
        git fetch --no-tags martineau kbuild-mptcp-enabled
        git checkout 11b70f473e519350157fa74fefbdb6d12a99a199
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash net/mptcp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/mptcp/pm_netlink.c: In function 'mptcp_free_local_addr_list':
>> net/mptcp/pm_netlink.c:397:23: warning: variable 'pernet' set but not used [-Wunused-but-set-variable]
     397 |  struct pm_nl_pernet *pernet;
         |                       ^~~~~~
   At top level:
   net/mptcp/pm_netlink.c:902:12: warning: 'mptcp_userspace_pm_append_new_local_addr' defined but not used [-Wunused-function]
     902 | static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pernet +397 net/mptcp/pm_netlink.c

   392	
   393	void mptcp_free_local_addr_list(struct mptcp_sock *msk)
   394	{
   395		struct mptcp_pm_addr_entry *entry, *tmp;
   396		struct sock *sk = (struct sock *)msk;
 > 397		struct pm_nl_pernet *pernet;
   398		LIST_HEAD(free_list);
   399	
   400		if (!mptcp_pm_is_userspace(msk))
   401			return;
   402	
   403		pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
   404	
   405		mptcp_data_lock(sk);
   406		list_splice_init(&msk->local_addr_list, &free_list);
   407		mptcp_data_unlock(sk);
   408	
   409		list_for_each_entry_safe(entry, tmp, &free_list, list) {
   410			sock_kfree_s(sk, entry, sizeof(*entry));
   411		}
   412	}
   413	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
