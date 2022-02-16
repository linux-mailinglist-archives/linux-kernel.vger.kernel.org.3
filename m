Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400774B7C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbiBPAvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:51:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbiBPAva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:51:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C28F94E9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644972679; x=1676508679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lnQWnOzrFyN20ZzA/jR+vqWBYV2njOmB1jkxkii9tOM=;
  b=P9Zecf0jlssd+rUaztDJG1/pduzuE9nLSV2xq5Mw0In3Iys7G9QDsXsB
   xoRk6LhMGiGILZ6prOdSrbDZvXwOUXk1TzU43NiFNoIWGNJonRGzDGGYn
   n0ocbu1fKo2FVPqSBk+KqbxXqMaDokZpPe7jmMtfI17v42UAV0/tkaOub
   Ko6YbZHZkDE63D9EgGsxVK8aOvDQFv6QAv3A/JAcCXofVNJlJvr76a4LE
   9EjXObEk+N1ZlpsFtLJO7oY3+gKksq8CtLAeS7axdQk+BELZVXOfLnVRV
   jMWznFVixHTQyjiipPVMhUuXEx31ce27S4r9G6WPpoas7Oxnyv7YxrP/e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313768062"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313768062"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 16:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="502757110"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2022 16:51:17 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK8XM-000ADq-Te; Wed, 16 Feb 2022 00:51:16 +0000
Date:   Wed, 16 Feb 2022 08:50:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-fam0-uapi 1/1]
 ./usr/include/linux/netfilter/x_tables.h:66:25: warning: field 'target' with
 variable sized type 'struct xt_entry_target' not at the end of a struct or
 class is a GNU extension
Message-ID: <202202160827.ultVqzuo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-fam0-uapi
head:   d2d045d04ce9d694796e30ae6f8362d2788003a5
commit: d2d045d04ce9d694796e30ae6f8362d2788003a5 [1/1] treewide: uapi: Replace zero-length arrays with flexible-array members
config: i386-randconfig-a002-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160827.ultVqzuo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=d2d045d04ce9d694796e30ae6f8362d2788003a5
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars for-next/kspp-fam0-uapi
        git checkout d2d045d04ce9d694796e30ae6f8362d2788003a5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/netfilter/x_tables.h:66:25: warning: field 'target' with variable sized type 'struct xt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct xt_entry_target target;
                                  ^
   ./usr/include/linux/netfilter/x_tables.h:71:25: warning: field 'target' with variable sized type 'struct xt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct xt_entry_target target;
                                  ^
   2 warnings generated.
--
   In file included from <built-in>:1:
   In file included from ./usr/include/linux/smc_diag.h:7:
>> ./usr/include/rdma/ib_user_verbs.h:436:34: warning: field 'base' with variable sized type 'struct ib_uverbs_create_cq_resp' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct ib_uverbs_create_cq_resp base;
                                           ^
>> ./usr/include/rdma/ib_user_verbs.h:644:34: warning: field 'base' with variable sized type 'struct ib_uverbs_create_qp_resp' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct ib_uverbs_create_qp_resp base;
                                           ^
>> ./usr/include/rdma/ib_user_verbs.h:740:29: warning: field 'base' with variable sized type 'struct ib_uverbs_modify_qp' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct ib_uverbs_modify_qp base;
                                      ^
>> ./usr/include/rdma/ib_user_verbs.h:916:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_eth::(anonymous at ./usr/include/rdma/ib_user_verbs.h:916:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:938:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_ipv4::(anonymous at ./usr/include/rdma/ib_user_verbs.h:938:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:956:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_tcp_udp::(anonymous at ./usr/include/rdma/ib_user_verbs.h:956:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:979:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_ipv6::(anonymous at ./usr/include/rdma/ib_user_verbs.h:979:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:992:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_tag::(anonymous at ./usr/include/rdma/ib_user_verbs.h:992:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:1016:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_handle::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1016:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:1029:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_count::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1029:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:1046:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_tunnel::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1046:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:1064:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_esp::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1064:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:1091:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_gre::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1091:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
>> ./usr/include/rdma/ib_user_verbs.h:1114:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_mpls::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1114:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           union {
           ^
   14 warnings generated.
--
   In file included from <built-in>:1:
   In file included from ./usr/include/linux/netfilter_ipv6/ip6_tables.h:24:
>> ./usr/include/linux/netfilter/x_tables.h:66:25: warning: field 'target' with variable sized type 'struct xt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct xt_entry_target target;
                                  ^
   ./usr/include/linux/netfilter/x_tables.h:71:25: warning: field 'target' with variable sized type 'struct xt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct xt_entry_target target;
                                  ^
   In file included from <built-in>:1:
>> ./usr/include/linux/netfilter_ipv6/ip6_tables.h:131:20: warning: field 'entry' with variable sized type 'struct ip6t_entry' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct ip6t_entry entry;
                             ^
   ./usr/include/linux/netfilter_ipv6/ip6_tables.h:136:20: warning: field 'entry' with variable sized type 'struct ip6t_entry' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct ip6t_entry entry;
                             ^
   4 warnings generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/seg6_hmac.h:12:17: warning: field 'tlvhdr' with variable sized type 'struct sr6_tlv' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct sr6_tlv tlvhdr;
                          ^
   1 warning generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
