Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F89C4B8104
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiBPHIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:08:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiBPHIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:08:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6322D25578C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644995283; x=1676531283;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zCBY54+JmxckkDlyoAab9FyBk2PlV6C5DTPXolWb/IA=;
  b=XOWCjMpCVF6n5NFtKFx9NYrcCOC+dFb4mYt9KYpim+Iow7H+kAd10rPA
   rlEXzK19rl+d5curYeyHptmSsqgn5sVK67OXLiBuWr80mdcQW0NPXEgwe
   hkCIyUWp0KxKTVMPFyQla9C4pAzLEMakdi5EvOEgcjA2SB+KKncjA322K
   +oH1dz4i0daY7xNqJl4XjiJZLp3DF8oBtUtINyMOQfUzRs9sdT6lZPN6t
   bGBudU0UsJqwvzk13KGihgi8fZMWuOU/NVUSdk8xpwU0JvQaKbifvZfMW
   DHDL7O5oOo+q/MW2iQ9UxWukbC99y63P9pIXmgrPY5cdOfapR4pm4okB5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="231165793"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="231165793"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="588245466"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2022 23:07:29 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKEPQ-000AYO-D7; Wed, 16 Feb 2022 07:07:28 +0000
Date:   Wed, 16 Feb 2022 15:07:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-fam0-uapi] BUILD SUCCESS WITH WARNING
 d2d045d04ce9d694796e30ae6f8362d2788003a5
Message-ID: <620ca2a5.NkAEIDEfiYoxE9/u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-fam0-uapi
branch HEAD: d2d045d04ce9d694796e30ae6f8362d2788003a5  treewide: uapi: Replace zero-length arrays with flexible-array members

Warning reports:

https://lore.kernel.org/lkml/202202160827.ultVqzuo-lkp@intel.com

Warning in current branch:

./usr/include/linux/netfilter/x_tables.h:66:25: warning: field 'target' with variable sized type 'struct xt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/linux/netfilter_ipv6/ip6_tables.h:131:20: warning: field 'entry' with variable sized type 'struct ip6t_entry' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/linux/seg6_hmac.h:12:17: warning: field 'tlvhdr' with variable sized type 'struct sr6_tlv' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1016:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_handle::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1016:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1029:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_count::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1029:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1046:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_tunnel::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1046:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1064:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_esp::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1064:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1091:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_gre::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1091:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1114:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_mpls::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1114:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:436:34: warning: field 'base' with variable sized type 'struct ib_uverbs_create_cq_resp' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:644:34: warning: field 'base' with variable sized type 'struct ib_uverbs_create_qp_resp' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:740:29: warning: field 'base' with variable sized type 'struct ib_uverbs_modify_qp' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:916:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_eth::(anonymous at ./usr/include/rdma/ib_user_verbs.h:916:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:938:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_ipv4::(anonymous at ./usr/include/rdma/ib_user_verbs.h:938:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:956:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_tcp_udp::(anonymous at ./usr/include/rdma/ib_user_verbs.h:956:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:979:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_ipv6::(anonymous at ./usr/include/rdma/ib_user_verbs.h:979:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:992:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_tag::(anonymous at ./usr/include/rdma/ib_user_verbs.h:992:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-buildonly-randconfig-r006-20220214
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|-- i386-randconfig-a002-20220214
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|-- i386-randconfig-a004
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|-- i386-randconfig-a006
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|-- i386-randconfig-a013
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|-- i386-randconfig-c001
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|-- x86_64-allyesconfig
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|-- x86_64-randconfig-a001-20220214
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|-- x86_64-randconfig-a003-20220214
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|-- x86_64-randconfig-a005-20220214
|   |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
`-- x86_64-randconfig-a016
    |-- usr-include-linux-netfilter-x_tables.h:warning:field-target-with-variable-sized-type-struct-xt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
    |-- usr-include-linux-netfilter_ipv6-ip6_tables.h:warning:field-entry-with-variable-sized-type-struct-ip6t_entry-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
    |-- usr-include-linux-seg6_hmac.h:warning:field-tlvhdr-with-variable-sized-type-struct-sr6_tlv-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_cq_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_create_qp_resp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-base-with-variable-sized-type-struct-ib_uverbs_modify_qp-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
    `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU

elapsed time: 723m

configs tested: 197
configs skipped: 5

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220214
mips                 randconfig-c004-20220214
i386                          randconfig-c001
mips                 randconfig-c004-20220216
sh                           se7751_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                      fuloong2e_defconfig
sh                        sh7763rdp_defconfig
arm                        realview_defconfig
csky                                defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
powerpc                     taishan_defconfig
arm                         assabet_defconfig
arc                     nsimosci_hs_defconfig
m68k                       m5208evb_defconfig
arm                            hisi_defconfig
sh                        edosk7705_defconfig
sh                          lboxre2_defconfig
arm                           corgi_defconfig
arc                      axs103_smp_defconfig
xtensa                           alldefconfig
microblaze                      mmu_defconfig
arm                       omap2plus_defconfig
arm                        shmobile_defconfig
sh                             espt_defconfig
nios2                               defconfig
arm                        spear6xx_defconfig
mips                         mpc30x_defconfig
powerpc                     mpc83xx_defconfig
sh                   sh7724_generic_defconfig
mips                  maltasmvp_eva_defconfig
arm                         s3c6400_defconfig
h8300                    h8300h-sim_defconfig
mips                        vocore2_defconfig
sh                             sh03_defconfig
arm                            lart_defconfig
mips                          rb532_defconfig
arm                          badge4_defconfig
sh                           se7750_defconfig
arm                           stm32_defconfig
arm                      integrator_defconfig
arm                           sunxi_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          gemini_defconfig
m68k                             allmodconfig
powerpc                         wii_defconfig
mips                       bmips_be_defconfig
m68k                       m5475evb_defconfig
powerpc                      arches_defconfig
arm                          pxa910_defconfig
arm                           u8500_defconfig
arm                        oxnas_v6_defconfig
sh                          kfr2r09_defconfig
arm                            xcep_defconfig
m68k                        stmark2_defconfig
s390                                defconfig
nds32                               defconfig
openrisc                 simple_smp_defconfig
sh                                  defconfig
m68k                             alldefconfig
arm                       aspeed_g5_defconfig
xtensa                  nommu_kc705_defconfig
arm                           viper_defconfig
arm                            mps2_defconfig
arm                      jornada720_defconfig
m68k                          atari_defconfig
arm64                            alldefconfig
sh                            shmin_defconfig
sh                        sh7757lcr_defconfig
openrisc                  or1klitex_defconfig
powerpc                        warp_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
i386                             alldefconfig
sh                           se7724_defconfig
sh                        edosk7760_defconfig
sparc                            allyesconfig
mips                       capcella_defconfig
arm                        cerfcube_defconfig
mips                      loongson3_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220214
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a013-20220214
x86_64               randconfig-a014-20220214
x86_64               randconfig-a012-20220214
x86_64               randconfig-a015-20220214
x86_64               randconfig-a011-20220214
x86_64               randconfig-a016-20220214
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
riscv                randconfig-r042-20220214
arc                  randconfig-r043-20220214
s390                 randconfig-r044-20220214
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220214
i386                 randconfig-c001-20220214
x86_64               randconfig-c007-20220214
powerpc              randconfig-c003-20220214
arm                  randconfig-c002-20220214
mips                 randconfig-c004-20220214
riscv                randconfig-c006-20220216
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220216
arm                  randconfig-c002-20220216
i386                          randconfig-c001
mips                 randconfig-c004-20220216
arm                        neponset_defconfig
powerpc                      ppc44x_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc832x_mds_defconfig
riscv                             allnoconfig
powerpc               mpc834x_itxgp_defconfig
mips                          rm200_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
powerpc                     kmeter1_defconfig
powerpc                     tqm8560_defconfig
arm                         lpc32xx_defconfig
powerpc                  mpc885_ads_defconfig
mips                         tb0287_defconfig
powerpc                      walnut_defconfig
x86_64               randconfig-a002-20220214
x86_64               randconfig-a006-20220214
x86_64               randconfig-a005-20220214
x86_64               randconfig-a004-20220214
x86_64               randconfig-a003-20220214
x86_64               randconfig-a001-20220214
i386                 randconfig-a004-20220214
i386                 randconfig-a005-20220214
i386                 randconfig-a006-20220214
i386                 randconfig-a002-20220214
i386                 randconfig-a003-20220214
i386                 randconfig-a001-20220214
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220214
hexagon              randconfig-r041-20220214
hexagon              randconfig-r045-20220216
hexagon              randconfig-r041-20220216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
