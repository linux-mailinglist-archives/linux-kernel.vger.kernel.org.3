Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904CF559769
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiFXKLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiFXKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:11:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51447A6D2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656065473; x=1687601473;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FfQ6/iTGj3dm1Jej1uJtVstGk6neJmy0zcVax3kz2Tg=;
  b=U+KVgQKSVeK7VJYylflPK2SvD4VuETOuRgAi84Skl3N27z5vv3t/843U
   Ur0BZmt3ZFHq43HIKR9tmqlC/D3T0iK935eVMA/3TpEbsEESbbW4JHW2F
   M4FZEwgAWmIj9yCLFLxAedXgoFfgTU3NKa3fJjZmNCa087pbFvo1x+TVT
   nUhqvn38CHTvqAAz7o1KMzsdb0wGeoHJq6sjp5CsR7p5gpe8PPMo3cJXm
   /w2IiEsrmQUI+lOpc+V0RWZc/GKPX6RQALhk7YMWEPoGhRlB5x+G4VKuj
   iiGjMFvgbhqO8bWiw8oTLjfylOAc8fl739ul90wxjFYNU4UuiiNlI0bDe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342658447"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="342658447"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 03:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="691465744"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2022 03:10:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4gH7-0003yt-0U;
        Fri, 24 Jun 2022 10:10:53 +0000
Date:   Fri, 24 Jun 2022 18:09:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/for-next-fam0-uapi] BUILD SUCCESS
 a4ce15b7c918104a2a8689b7b312059ff0eff23a
Message-ID: <62b58d70.TofKa+JW2ompOhK5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/for-next-fam0-uapi
branch HEAD: a4ce15b7c918104a2a8689b7b312059ff0eff23a  treewide: uapi: Replace zero-length arrays with flexible-array members

Warning reports:

https://lore.kernel.org/lkml/202206241055.Eh9MKMAE-lkp@intel.com

Unverified Warning (likely false positive, please contact us if interested):

./usr/include/rdma/ib_user_verbs.h:1016:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_handle::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1016:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1029:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_count::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1029:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1046:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_tunnel::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1046:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1064:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_esp::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1064:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1091:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_gre::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1091:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:1114:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_mpls::(anonymous at ./usr/include/rdma/ib_user_verbs.h:1114:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:916:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_eth::(anonymous at ./usr/include/rdma/ib_user_verbs.h:916:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:938:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_ipv4::(anonymous at ./usr/include/rdma/ib_user_verbs.h:938:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:956:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_tcp_udp::(anonymous at ./usr/include/rdma/ib_user_verbs.h:956:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:979:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_ipv6::(anonymous at ./usr/include/rdma/ib_user_verbs.h:979:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
./usr/include/rdma/ib_user_verbs.h:992:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_tag::(anonymous at ./usr/include/rdma/ib_user_verbs.h:992:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:1016:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_handle::(anonymous at usr/include/rdma/ib_user_verbs.h:1016:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:1029:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_count::(anonymous at usr/include/rdma/ib_user_verbs.h:1029:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:1046:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_tunnel::(anonymous at usr/include/rdma/ib_user_verbs.h:1046:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:1064:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_esp::(anonymous at usr/include/rdma/ib_user_verbs.h:1064:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:1091:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_gre::(anonymous at usr/include/rdma/ib_user_verbs.h:1091:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:1114:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_mpls::(anonymous at usr/include/rdma/ib_user_verbs.h:1114:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:916:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_eth::(anonymous at usr/include/rdma/ib_user_verbs.h:916:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:938:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_ipv4::(anonymous at usr/include/rdma/ib_user_verbs.h:938:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:956:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_tcp_udp::(anonymous at usr/include/rdma/ib_user_verbs.h:956:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:979:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_ipv6::(anonymous at usr/include/rdma/ib_user_verbs.h:979:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
usr/include/rdma/ib_user_verbs.h:992:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_action_tag::(anonymous at usr/include/rdma/ib_user_verbs.h:992:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-randconfig-a004
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-G
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|-- i386-randconfig-a006
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-G
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|-- i386-randconfig-a013
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-G
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-
|   |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
|   `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
`-- x86_64-randconfig-a016
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_count::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-i
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_handle::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_action_tag::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-G
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_esp::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_eth::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ex
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_gre::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-exte
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv4::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_ipv6::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_mpls::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-ext
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GN
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tcp_udp::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-
    |-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-.-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU
    `-- usr-include-rdma-ib_user_verbs.h:warning:field-with-variable-sized-type-union-ib_uverbs_flow_spec_tunnel::(anonymous-at-usr-include-rdma-ib_user_verbs.h)-not-at-the-end-of-a-struct-or-class-is-a-GNU-e

elapsed time: 727m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220622
arm                         lubbock_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220622
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                 mpc8560_ads_defconfig
hexagon                             defconfig
powerpc                 mpc836x_mds_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622
hexagon              randconfig-r041-20220623
hexagon              randconfig-r045-20220623

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
