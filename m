Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CAD4FAE00
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 15:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiDJNPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiDJNPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 09:15:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5342A35
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649596392; x=1681132392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Oa5bpy+gNfChABbpxEkWgNikKQpwd0lEyDIMcNwzXHM=;
  b=VvlLgtNzVCZlGEjCiv/M97M83J/TUfbDeQy+QVSxzUtSm/TifIHV/7hm
   kaZ66Av1/6R+xWLHhkf6lHa6hj6z06cNRS4dC7a1fJoxSgyMz+nVxv7hW
   v2vPkJXlFvA/Z5jSL4Zbfstr7gvfJgoIbAV2Vhnl2+9ixu757EvXhNoKy
   yFznYpS4l0dYN+6ZYD1m9E+pHl6ZaJ56HqtAiTRuTvD1dxRou7aWEIpsG
   pJHjMcPKT6+BsEhC+5+MibUcVLDBBk4oXQe68Ub2gSnv1GPdD21FGpaGi
   afaLeXL+ooa9aPmO4pYr/BpZGcozYTgffG66zV3nfzoCWUztz+Rk+hDhK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="259566228"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="259566228"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 06:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="525627479"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2022 06:13:09 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndXNN-0000tr-5d;
        Sun, 10 Apr 2022 13:13:09 +0000
Date:   Sun, 10 Apr 2022 21:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-04 6/12] net/core/filter.c:10530:31: sparse:
 sparse: symbol 'dequeue_verifier_ops' was not declared. Should it be static?
Message-ID: <202204102150.YZdkMTrK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-04
head:   d67202baf237752a91366c8ba9bd801942e5fdaf
commit: 8a45b14641ca025c0927e9e7fd502c11125ae864 [6/12] xdp: add dequeue program type for getting packets from a PIFO
config: alpha-randconfig-s031-20220410 (https://download.01.org/0day-ci/archive/20220410/202204102150.YZdkMTrK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=8a45b14641ca025c0927e9e7fd502c11125ae864
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-04
        git checkout 8a45b14641ca025c0927e9e7fd502c11125ae864
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/core/filter.c:5931:9: sparse: sparse: switch with no cases
   net/core/filter.c:5972:9: sparse: sparse: switch with no cases
   net/core/filter.c:1410:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1410:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1410:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:1488:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1488:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1488:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:10496:31: sparse: sparse: symbol 'sk_filter_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10503:27: sparse: sparse: symbol 'sk_filter_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10507:31: sparse: sparse: symbol 'tc_cls_act_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10515:27: sparse: sparse: symbol 'tc_cls_act_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10519:31: sparse: sparse: symbol 'xdp_verifier_ops' was not declared. Should it be static?
>> net/core/filter.c:10530:31: sparse: sparse: symbol 'dequeue_verifier_ops' was not declared. Should it be static?
>> net/core/filter.c:10537:27: sparse: sparse: symbol 'dequeue_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10541:31: sparse: sparse: symbol 'cg_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10547:27: sparse: sparse: symbol 'cg_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10551:31: sparse: sparse: symbol 'lwt_in_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10557:27: sparse: sparse: symbol 'lwt_in_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10561:31: sparse: sparse: symbol 'lwt_out_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10567:27: sparse: sparse: symbol 'lwt_out_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10571:31: sparse: sparse: symbol 'lwt_xmit_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10578:27: sparse: sparse: symbol 'lwt_xmit_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10582:31: sparse: sparse: symbol 'lwt_seg6local_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10588:27: sparse: sparse: symbol 'lwt_seg6local_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10592:31: sparse: sparse: symbol 'cg_sock_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10598:27: sparse: sparse: symbol 'cg_sock_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10601:31: sparse: sparse: symbol 'cg_sock_addr_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10607:27: sparse: sparse: symbol 'cg_sock_addr_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10610:31: sparse: sparse: symbol 'sock_ops_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10616:27: sparse: sparse: symbol 'sock_ops_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10619:31: sparse: sparse: symbol 'sk_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10626:27: sparse: sparse: symbol 'sk_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10629:31: sparse: sparse: symbol 'sk_msg_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10636:27: sparse: sparse: symbol 'sk_msg_prog_ops' was not declared. Should it be static?
   net/core/filter.c:10639:31: sparse: sparse: symbol 'flow_dissector_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:10645:27: sparse: sparse: symbol 'flow_dissector_prog_ops' was not declared. Should it be static?
   net/core/filter.c:246:32: sparse: sparse: cast to restricted __be16
   net/core/filter.c:246:32: sparse: sparse: cast to restricted __be16
   net/core/filter.c:246:32: sparse: sparse: cast to restricted __be16
   net/core/filter.c:246:32: sparse: sparse: cast to restricted __be16
   net/core/filter.c:273:32: sparse: sparse: cast to restricted __be32
   net/core/filter.c:273:32: sparse: sparse: cast to restricted __be32
   net/core/filter.c:273:32: sparse: sparse: cast to restricted __be32
   net/core/filter.c:273:32: sparse: sparse: cast to restricted __be32
   net/core/filter.c:273:32: sparse: sparse: cast to restricted __be32
   net/core/filter.c:273:32: sparse: sparse: cast to restricted __be32
   net/core/filter.c:1909:43: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1909:43: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:1909:43: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1912:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be16 [usertype] old @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1912:36: sparse:     expected restricted __be16 [usertype] old
   net/core/filter.c:1912:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1912:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] new @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1912:42: sparse:     expected restricted __be16 [usertype] new
   net/core/filter.c:1912:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1915:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1915:36: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:1915:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1915:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1915:42: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:1915:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1960:59: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1960:59: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:1960:59: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1963:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1963:52: sparse:     expected restricted __be16 [usertype] from
   net/core/filter.c:1963:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1963:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be16 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1963:58: sparse:     expected restricted __be16 [usertype] to
   net/core/filter.c:1963:58: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1966:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1966:52: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:1966:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1966:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1966:58: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:1966:58: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:2012:28: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum @@
   net/core/filter.c:2012:28: sparse:     expected unsigned long long
   net/core/filter.c:2012:28: sparse:     got restricted __wsum
   net/core/filter.c:2034:35: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] csum @@
   net/core/filter.c:2034:35: sparse:     expected unsigned long long
   net/core/filter.c:2034:35: sparse:     got restricted __wsum [usertype] csum

vim +/dequeue_verifier_ops +10530 net/core/filter.c

 10529	
 10530	const struct bpf_verifier_ops dequeue_verifier_ops = {
 10531		.get_func_proto		= dequeue_func_proto,
 10532		.is_valid_access	= dequeue_is_valid_access,
 10533		.convert_ctx_access	= dequeue_convert_ctx_access,
 10534		.gen_prologue		= bpf_noop_prologue,
 10535	};
 10536	
 10537	const struct bpf_prog_ops dequeue_prog_ops = {
 10538		.test_run		= bpf_prog_test_run_dequeue,
 10539	};
 10540	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
