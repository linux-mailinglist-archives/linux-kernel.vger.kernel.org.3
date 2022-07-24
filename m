Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84057F7B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 01:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiGXXjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 19:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGXXjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 19:39:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E796101DA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658705981; x=1690241981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cmcc62Z22WVmqvg95FJmm2mKK7QSEaTKlickELw2Lc4=;
  b=gb6C46omSjV/6c6iiKhZ2rHLR1qfRJLhEC6VRZpRZWW+hbdgCeXgMN4P
   FZr1ccpGhrSe9z+n3l3A9qkbFDNCDCXxEIW3ZkgMrZKJXns3sdxfwy0PV
   3mgISmAjT3xg/68kso2SjLR3YelDYGfrphBVxiVya66OF2wJcM/kJ1oV7
   81PtjlBUKb7I/pXQDtiYMw7tXmlGg1MDONVGuZXeRB1VyfpkqH9j/fThB
   SPTQAA5T6sPKyraC9RaFOxs3XFNjQnxK0z3SszOXt528dx5uTNb/P+rk4
   47a6SnoWDbw+lcdjKmGvvGAMoV2+Ax5iMPRKGvVh8Hl22FZ04rx86DrAG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="274439225"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="274439225"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 16:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="627225588"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Jul 2022 16:39:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFlC9-0004PZ-35;
        Sun, 24 Jul 2022 23:39:33 +0000
Date:   Mon, 25 Jul 2022 07:39:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 6/7] net/core/filter.c:10694:31: sparse: sparse:
 symbol 'tc_qdisc_verifier_ops' was not declared. Should it be static?
Message-ID: <202207250703.q4wpPOoI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   0be7ca64fe67b71e74518da3e635ccd8d67e01ac
commit: 0bec1c7a1a13130703df8fdaf637f22901b0a99e [6/7] net_sched: introduce eBPF based Qdisc
config: arm64-randconfig-s032-20220724 (https://download.01.org/0day-ci/archive/20220725/202207250703.q4wpPOoI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/congwang/linux/commit/0bec1c7a1a13130703df8fdaf637f22901b0a99e
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout 0bec1c7a1a13130703df8fdaf637f22901b0a99e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   net/core/filter.c:5980:9: sparse: sparse: switch with no cases
   net/core/filter.c:6021:9: sparse: sparse: switch with no cases
   net/core/filter.c:1411:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1411:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1411:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:1489:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1489:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1489:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:10671:31: sparse: sparse: symbol 'sk_filter_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10678:27: sparse: sparse: symbol 'sk_filter_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10682:31: sparse: sparse: symbol 'tc_cls_act_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10690:27: sparse: sparse: symbol 'tc_cls_act_prog_ops' was not declared. Should it be static?
>> net/core/filter.c:10694:31: sparse: sparse: symbol 'tc_qdisc_verifier_ops' was not declared. Should it be static?
>> net/core/filter.c:10702:27: sparse: sparse: symbol 'tc_qdisc_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10706:31: sparse: sparse: symbol 'xdp_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10717:31: sparse: sparse: symbol 'cg_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10723:27: sparse: sparse: symbol 'cg_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10727:31: sparse: sparse: symbol 'lwt_in_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10733:27: sparse: sparse: symbol 'lwt_in_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10737:31: sparse: sparse: symbol 'lwt_out_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10743:27: sparse: sparse: symbol 'lwt_out_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10747:31: sparse: sparse: symbol 'lwt_xmit_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10754:27: sparse: sparse: symbol 'lwt_xmit_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10758:31: sparse: sparse: symbol 'lwt_seg6local_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10764:27: sparse: sparse: symbol 'lwt_seg6local_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10768:31: sparse: sparse: symbol 'cg_sock_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10774:27: sparse: sparse: symbol 'cg_sock_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10777:31: sparse: sparse: symbol 'cg_sock_addr_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10783:27: sparse: sparse: symbol 'cg_sock_addr_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10786:31: sparse: sparse: symbol 'sock_ops_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10792:27: sparse: sparse: symbol 'sock_ops_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10795:31: sparse: sparse: symbol 'sk_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10802:27: sparse: sparse: symbol 'sk_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10805:31: sparse: sparse: symbol 'sk_msg_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10812:27: sparse: sparse: symbol 'sk_msg_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10815:31: sparse: sparse: symbol 'flow_dissector_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10821:27: sparse: sparse: symbol 'flow_dissector_prog_ops' was not declared. Should it be static?
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

vim +/tc_qdisc_verifier_ops +10694 net/core/filter.c

 10693	
 10694	const struct bpf_verifier_ops tc_qdisc_verifier_ops = {
 10695		.get_func_proto		= tc_qdisc_func_proto,
 10696		.is_valid_access	= tc_cls_act_is_valid_access,
 10697		.convert_ctx_access	= tc_cls_act_convert_ctx_access,
 10698		.gen_prologue		= tc_cls_act_prologue,
 10699		.gen_ld_abs		= bpf_gen_ld_abs,
 10700	};
 10701	
 10702	const struct bpf_prog_ops tc_qdisc_prog_ops = {
 10703		.test_run		= bpf_prog_test_run_skb,
 10704	};
 10705	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
