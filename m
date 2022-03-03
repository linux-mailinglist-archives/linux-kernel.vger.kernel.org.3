Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD184CBDA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiCCMYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiCCMYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:24:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD1F47E9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646310234; x=1677846234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YlWiPlnQT/J4CWX3oOcwnxjiyCoPKF45JgGeKXxefBw=;
  b=Ha469Kt3jK7NrAeiI8sYr0YGDXlI2Fq2duk6tnhUsT5LpC7gDgs+toki
   3LhngEzAC/aRDkDAFDaECyjHP63b+sqFhazDLdA9cGrr5xY6xZcr/0e2c
   HYP6CNcH7brTbtlJPhtZdXy74JQWRf/uhqBBIe36sLdDWDBw5aWOO1svg
   5j+n7wQWzJswXVoI3deam/2Iww004lvbSOdRP70tXGFKSghMxXrUHWvyj
   SLROkRJeggZhK2xOpeDBb0z+pqgp9fsCQqeK/2dnfUX2KZWpACfI2GGog
   8alNj/lMe6gem8ygF6iUCHk9Lm8K/Thel25bv3dQ3IxubmJsVXsM8TVse
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234273266"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="234273266"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 04:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="511412803"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2022 04:23:52 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPkUq-0000UP-34; Thu, 03 Mar 2022 12:23:52 +0000
Date:   Thu, 3 Mar 2022 20:23:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [netfilter-nf-next:master 9/12]
 net/netfilter/nf_conntrack_core.c:670:19: error: no member named 'ecache' in
 'struct nf_conntrack_net'
Message-ID: <202203032033.frsNjH8R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git master
head:   25485ffb54ac073e82957218404e303469477c2f
commit: 3ad61edaa5ac46811b4ea07a994428ead31e7468 [9/12] netfilter: conntrack: remove the percpu dying list
config: riscv-randconfig-r042-20220303 (https://download.01.org/0day-ci/archive/20220303/202203032033.frsNjH8R-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=3ad61edaa5ac46811b4ea07a994428ead31e7468
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next master
        git checkout 3ad61edaa5ac46811b4ea07a994428ead31e7468
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/netfilter/nf_conntrack_core.c:670:19: error: no member named 'ecache' in 'struct nf_conntrack_net'
           spin_lock(&cnet->ecache.dying_lock);
                      ~~~~  ^
   net/netfilter/nf_conntrack_core.c:672:13: error: no member named 'ecache' in 'struct nf_conntrack_net'
                                    &cnet->ecache.dying_list);
                                     ~~~~  ^
   net/netfilter/nf_conntrack_core.c:673:21: error: no member named 'ecache' in 'struct nf_conntrack_net'
           spin_unlock(&cnet->ecache.dying_lock);
                        ~~~~  ^
   3 errors generated.


vim +670 net/netfilter/nf_conntrack_core.c

dd7669a92c6066 Pablo Neira Ayuso 2009-06-13  665  
38a419ee4e646c Florian Westphal  2022-02-24  666  static void nf_ct_add_to_ecache_list(struct nf_conn *ct)
38a419ee4e646c Florian Westphal  2022-02-24  667  {
38a419ee4e646c Florian Westphal  2022-02-24  668  	struct nf_conntrack_net *cnet = nf_ct_pernet(nf_ct_net(ct));
38a419ee4e646c Florian Westphal  2022-02-24  669  
38a419ee4e646c Florian Westphal  2022-02-24 @670  	spin_lock(&cnet->ecache.dying_lock);
38a419ee4e646c Florian Westphal  2022-02-24  671  	hlist_nulls_add_head_rcu(&ct->tuplehash[IP_CT_DIR_ORIGINAL].hnnode,
38a419ee4e646c Florian Westphal  2022-02-24  672  				 &cnet->ecache.dying_list);
38a419ee4e646c Florian Westphal  2022-02-24  673  	spin_unlock(&cnet->ecache.dying_lock);
38a419ee4e646c Florian Westphal  2022-02-24  674  }
38a419ee4e646c Florian Westphal  2022-02-24  675  

:::::: The code at line 670 was first introduced by commit
:::::: 38a419ee4e646c1a6427f98717ad0bfac9762607 netfilter: ecache: use dedicated list for event redelivery

:::::: TO: Florian Westphal <fw@strlen.de>
:::::: CC: Pablo Neira Ayuso <pablo@netfilter.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
