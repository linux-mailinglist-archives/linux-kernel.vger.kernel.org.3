Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D64535BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbiE0Iqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349846AbiE0Iq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:46:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE510FF1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653641184; x=1685177184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AXatNATnQZ0DI67P8R1G6wp0tjlAKIb0dIHnp7dElFI=;
  b=k7T1UuJ8B+5skJxYRuzUk3aG1Zx7NgbnDJENQz062AKfWYj5+Q89WpUz
   s9WRbpjK0rhOUU7aUBzL7T52n6QLrxGM+bo4hKF7iCu7jVFmG+O1W+I7B
   Ikl4WjJWAesbkZNzM0U+/dQPvLYBnyv2RW1Vyyk2IrDWrYbzxnvk/WHgv
   JahhOgtP0Vo58058udcp7TLUSvhlauzmxXCZqmf3Y21zNTEn4Jr8CHkKU
   YMoX4e656xpXUI5j3H8nsFgXRUUU4LxquAFeCLPW3oS2U8l6kfMc+ocuc
   deHZE6l9JXdiRlY5z4PnscfBqNFFef00a3N5FT0h3zgS3gRj5YeKuP8Gf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="337470703"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="337470703"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="579508443"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 May 2022 01:46:22 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuVbx-0004aG-Nu;
        Fri, 27 May 2022 08:46:21 +0000
Date:   Fri, 27 May 2022 16:45:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 3/4] net/core/filter.c:10495:31: sparse: sparse:
 symbol 'tc_qdisc_verifier_ops' was not declared. Should it be static?
Message-ID: <202205271637.tUd44QTA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   d7144f4291a2882e698a6d9d83f7e614d97be9c8
commit: 97c6ce6081d2ec9913eefd690183e4857c8b6cf5 [3/4] net_sched: introduce eBPF based Qdisc
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220527/202205271637.tUd44QTA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://github.com/congwang/linux/commit/97c6ce6081d2ec9913eefd690183e4857c8b6cf5
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout 97c6ce6081d2ec9913eefd690183e4857c8b6cf5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/core/filter.c:1411:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1411:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1411:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:1489:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1489:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1489:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:2296:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] daddr @@     got unsigned int [usertype] ipv4_nh @@
   net/core/filter.c:2296:45: sparse:     expected restricted __be32 [usertype] daddr
   net/core/filter.c:2296:45: sparse:     got unsigned int [usertype] ipv4_nh
   net/core/filter.c:10472:31: sparse: sparse: symbol 'sk_filter_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10479:27: sparse: sparse: symbol 'sk_filter_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10483:31: sparse: sparse: symbol 'tc_cls_act_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10491:27: sparse: sparse: symbol 'tc_cls_act_prog_ops' was not declared. Should it be static?
>> net/core/filter.c:10495:31: sparse: sparse: symbol 'tc_qdisc_verifier_ops' was not declared. Should it be static?
>> net/core/filter.c:10503:27: sparse: sparse: symbol 'tc_qdisc_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10507:31: sparse: sparse: symbol 'xdp_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10518:31: sparse: sparse: symbol 'cg_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10524:27: sparse: sparse: symbol 'cg_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10528:31: sparse: sparse: symbol 'lwt_in_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10534:27: sparse: sparse: symbol 'lwt_in_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10538:31: sparse: sparse: symbol 'lwt_out_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10544:27: sparse: sparse: symbol 'lwt_out_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10548:31: sparse: sparse: symbol 'lwt_xmit_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10555:27: sparse: sparse: symbol 'lwt_xmit_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10559:31: sparse: sparse: symbol 'lwt_seg6local_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10565:27: sparse: sparse: symbol 'lwt_seg6local_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10569:31: sparse: sparse: symbol 'cg_sock_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10575:27: sparse: sparse: symbol 'cg_sock_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10578:31: sparse: sparse: symbol 'cg_sock_addr_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10584:27: sparse: sparse: symbol 'cg_sock_addr_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10587:31: sparse: sparse: symbol 'sock_ops_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10593:27: sparse: sparse: symbol 'sock_ops_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10596:31: sparse: sparse: symbol 'sk_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10603:27: sparse: sparse: symbol 'sk_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10606:31: sparse: sparse: symbol 'sk_msg_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10613:27: sparse: sparse: symbol 'sk_msg_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10616:31: sparse: sparse: symbol 'flow_dissector_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10622:27: sparse: sparse: symbol 'flow_dissector_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10951:31: sparse: sparse: symbol 'sk_reuseport_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10957:27: sparse: sparse: symbol 'sk_reuseport_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11159:27: sparse: sparse: symbol 'sk_lookup_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11163:31: sparse: sparse: symbol 'sk_lookup_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:247:32: sparse: sparse: cast to restricted __be16
   net/core/filter.c:274:32: sparse: sparse: cast to restricted __be32
   net/core/filter.c:1910:43: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1910:43: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:1910:43: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1913:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be16 [usertype] old @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1913:36: sparse:     expected restricted __be16 [usertype] old
   net/core/filter.c:1913:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1913:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] new @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1913:42: sparse:     expected restricted __be16 [usertype] new
   net/core/filter.c:1913:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1916:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1916:36: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:1916:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1916:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1916:42: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:1916:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1961:59: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1961:59: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:1961:59: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1964:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1964:52: sparse:     expected restricted __be16 [usertype] from
   net/core/filter.c:1964:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1964:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be16 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1964:58: sparse:     expected restricted __be16 [usertype] to
   net/core/filter.c:1964:58: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1967:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1967:52: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:1967:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1967:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1967:58: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:1967:58: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:2013:28: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum @@
   net/core/filter.c:2013:28: sparse:     expected unsigned long long
   net/core/filter.c:2013:28: sparse:     got restricted __wsum
   net/core/filter.c:2035:35: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] csum @@
   net/core/filter.c:2035:35: sparse:     expected unsigned long long
   net/core/filter.c:2035:35: sparse:     got restricted __wsum [usertype] csum
   net/core/filter.c:5645:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] spi @@     got restricted __be32 const [usertype] spi @@
   net/core/filter.c:5645:17: sparse:     expected unsigned int [usertype] spi
   net/core/filter.c:5645:17: sparse:     got restricted __be32 const [usertype] spi
   net/core/filter.c:5653:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] remote_ipv4 @@     got restricted __be32 const [usertype] a4 @@
   net/core/filter.c:5653:33: sparse:     expected unsigned int [usertype] remote_ipv4
   net/core/filter.c:5653:33: sparse:     got restricted __be32 const [usertype] a4

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
