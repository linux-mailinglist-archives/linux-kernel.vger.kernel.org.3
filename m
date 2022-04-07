Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C0F4F83C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbiDGPp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiDGPpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:45:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F131024
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649346234; x=1680882234;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fMsSAYP+jwGG6DbwDAYSzcCYg9E40r0k7rBWB9j3SVk=;
  b=mvDfTktR/rlvedMN1w4BAoF4b5sdxPRDZN1WIQHTPHJTcHvHdfEbh6v/
   2qLSJ3oEHbulENN6qz+4DRlMXG355ZdIsXRlMNE1RgYPH2PdZB5ARjy1x
   adML1wJvdfl9V5R13hoF/K/n4POY+2RygjHdh8hM5pKxSCXmPSxDXZK5o
   03Upnw8KFxdXBGB2nMOHnU2ImxP9+0Nde5aB2qXHG4+O99rEg0JrSPdr3
   pJt2pkpSgvgYl0ePBkkOCdgf5hErbB6yFw8PIHEEv1kc/LTmkHar4ybp8
   Zj2RfDM63NqdLir1l/f5ylUTao5MPWT3kutzNC4m8b46vFiRTtMwUAsTQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241953163"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="241953163"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 08:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="697839079"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2022 08:43:52 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncUIZ-0005Xv-ST;
        Thu, 07 Apr 2022 15:43:51 +0000
Date:   Thu, 07 Apr 2022 23:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-fam0-uapi] BUILD SUCCESS WITH WARNING
 862abfce15c96ae3daa696f8f125ebefbbb76ce7
Message-ID: <624f069b./33L5YlWDRAAR1MH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-fam0-uapi
branch HEAD: 862abfce15c96ae3daa696f8f125ebefbbb76ce7  treewide: uapi: Replace zero-length arrays with flexible-array members

Warning reports:

https://lore.kernel.org/lkml/202204071723.D6aqUADV-lkp@intel.com

Warning: (recently discovered and may have been fixed)

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

elapsed time: 726m

configs tested: 118
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                        nsim_700_defconfig
powerpc                        warp_defconfig
mips                           ci20_defconfig
arm                             rpc_defconfig
powerpc                 linkstation_defconfig
ia64                             allmodconfig
m68k                        m5407c3_defconfig
powerpc                         wii_defconfig
arc                        vdk_hs38_defconfig
arm                            pleb_defconfig
powerpc64                           defconfig
sh                        apsh4ad0a_defconfig
powerpc                      chrp32_defconfig
parisc64                         alldefconfig
arm                        trizeps4_defconfig
m68k                            q40_defconfig
sh                           se7722_defconfig
nios2                         3c120_defconfig
ia64                         bigsur_defconfig
mips                       capcella_defconfig
sh                          rsk7201_defconfig
sh                          lboxre2_defconfig
ia64                             alldefconfig
powerpc                mpc7448_hpc2_defconfig
arm                            qcom_defconfig
sh                        sh7785lcr_defconfig
arc                          axs101_defconfig
mips                         db1xxx_defconfig
x86_64                           alldefconfig
um                                  defconfig
mips                          rb532_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220406
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220406
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220406
arc                  randconfig-r043-20220407
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220407
powerpc              randconfig-c003-20220406
riscv                randconfig-c006-20220407
riscv                randconfig-c006-20220406
mips                 randconfig-c004-20220407
mips                 randconfig-c004-20220406
arm                  randconfig-c002-20220406
arm                  randconfig-c002-20220407
s390                 randconfig-c005-20220406
arm                       mainstone_defconfig
arm                        multi_v5_defconfig
mips                     cu1830-neo_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
