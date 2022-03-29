Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25B4EB580
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiC2WES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiC2WEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:04:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66E174B97
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648591351; x=1680127351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kE4i7O3iNpfpPPdlilDl2xcDaCDRhO5Bp1CRJr/0xDg=;
  b=KwWPTP2iwShJACtJe2MuAsISDgub4g5/j38JcgEdH1XjTAkSllPW2M3w
   +WpKRe3MQhwAryIidSwQWuCIcdl4k3i8vHudg43+FfFXM2oIVezGBeumm
   Ti/MB4fmfoQC9aTUZV4XAQIZa85LR887W5OP2cGntj7VSc1NNuxTu8Fpu
   D/BK8ze9kcEnaozmJjJr6LIf8QVnTLf1fXRZHVdWG0JAUR2FPeZfanjnz
   QLqazxsCwaFTlTVugOiWNvbBv/FVnJkBVGiXddAWAQx3oD0GQO0kJBwtS
   IBYHFiXl/aEv5V5CcUSUcpkKExN6LY56KJ2rSdQbmNrKoCWJct55wBLzs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="246880246"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="246880246"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="503070367"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2022 15:02:29 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZJv2-0000iU-Ts; Tue, 29 Mar 2022 22:02:28 +0000
Date:   Wed, 30 Mar 2022 06:02:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Raed Salem <raeds@nvidia.com>
Subject: [ammarfaizi2-block:mellanox/linux/queue-next 58/75]
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:133:38: warning:
 variable 'ft' is uninitialized when used here
Message-ID: <202203300512.PH9IjvZr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block mellanox/linux/queue-next
head:   e38dcd0822f6663f12798eb3b0273a0a77f3c286
commit: 75f668fca4309df2dd7c1bf49d9489fbb7b049f6 [58/75] net/mlx5: Make sure that no dangling IPsec FS pointers exist
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220330/202203300512.PH9IjvZr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/75f668fca4309df2dd7c1bf49d9489fbb7b049f6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block mellanox/linux/queue-next
        git checkout 75f668fca4309df2dd7c1bf49d9489fbb7b049f6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/ net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:133:38: warning: variable 'ft' is uninitialized when used here [-Wuninitialized]
           miss_group = mlx5_create_flow_group(ft, flow_group_in);
                                               ^~
   drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:119:28: note: initialize the variable 'ft' to silence this warning
           struct mlx5_flow_table *ft;
                                     ^
                                      = NULL
   1 warning generated.


vim +/ft +133 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c

5e466345291a91 Huy Nguyen      2020-06-05  110  
5e466345291a91 Huy Nguyen      2020-06-05  111  static int rx_fs_create(struct mlx5e_priv *priv,
5e466345291a91 Huy Nguyen      2020-06-05  112  			struct mlx5e_accel_fs_esp_prot *fs_prot)
5e466345291a91 Huy Nguyen      2020-06-05  113  {
5e466345291a91 Huy Nguyen      2020-06-05  114  	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
5e466345291a91 Huy Nguyen      2020-06-05  115  	struct mlx5_flow_group *miss_group;
5e466345291a91 Huy Nguyen      2020-06-05  116  	struct mlx5_flow_handle *miss_rule;
5e466345291a91 Huy Nguyen      2020-06-05  117  	MLX5_DECLARE_FLOW_ACT(flow_act);
5e466345291a91 Huy Nguyen      2020-06-05  118  	struct mlx5_flow_spec *spec;
5e466345291a91 Huy Nguyen      2020-06-05  119  	struct mlx5_flow_table *ft;
5e466345291a91 Huy Nguyen      2020-06-05  120  	u32 *flow_group_in;
75f668fca4309d Leon Romanovsky 2022-03-10  121  	int err;
5e466345291a91 Huy Nguyen      2020-06-05  122  
5e466345291a91 Huy Nguyen      2020-06-05  123  	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
5e466345291a91 Huy Nguyen      2020-06-05  124  	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
5e466345291a91 Huy Nguyen      2020-06-05  125  	if (!flow_group_in || !spec) {
5e466345291a91 Huy Nguyen      2020-06-05  126  		err = -ENOMEM;
75f668fca4309d Leon Romanovsky 2022-03-10  127  		goto err_alloc;
5e466345291a91 Huy Nguyen      2020-06-05  128  	}
5e466345291a91 Huy Nguyen      2020-06-05  129  
5e466345291a91 Huy Nguyen      2020-06-05  130  	/* Create miss_group */
5e466345291a91 Huy Nguyen      2020-06-05  131  	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, ft->max_fte - 1);
5e466345291a91 Huy Nguyen      2020-06-05  132  	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, ft->max_fte - 1);
5e466345291a91 Huy Nguyen      2020-06-05 @133  	miss_group = mlx5_create_flow_group(ft, flow_group_in);
5e466345291a91 Huy Nguyen      2020-06-05  134  	if (IS_ERR(miss_group)) {
5e466345291a91 Huy Nguyen      2020-06-05  135  		err = PTR_ERR(miss_group);
5e466345291a91 Huy Nguyen      2020-06-05  136  		netdev_err(priv->netdev, "fail to create ipsec rx miss_group err=%d\n", err);
75f668fca4309d Leon Romanovsky 2022-03-10  137  		goto err_alloc;
5e466345291a91 Huy Nguyen      2020-06-05  138  	}
5e466345291a91 Huy Nguyen      2020-06-05  139  	fs_prot->miss_group = miss_group;
5e466345291a91 Huy Nguyen      2020-06-05  140  
5e466345291a91 Huy Nguyen      2020-06-05  141  	/* Create miss rule */
5e466345291a91 Huy Nguyen      2020-06-05  142  	miss_rule = mlx5_add_flow_rules(ft, spec, &flow_act, &fs_prot->default_dest, 1);
5e466345291a91 Huy Nguyen      2020-06-05  143  	if (IS_ERR(miss_rule)) {
5e466345291a91 Huy Nguyen      2020-06-05  144  		err = PTR_ERR(miss_rule);
5e466345291a91 Huy Nguyen      2020-06-05  145  		netdev_err(priv->netdev, "fail to create ipsec rx miss_rule err=%d\n", err);
75f668fca4309d Leon Romanovsky 2022-03-10  146  		goto err_add_rule;
5e466345291a91 Huy Nguyen      2020-06-05  147  	}
5e466345291a91 Huy Nguyen      2020-06-05  148  	fs_prot->miss_rule = miss_rule;
75f668fca4309d Leon Romanovsky 2022-03-10  149  	return 0;
5e466345291a91 Huy Nguyen      2020-06-05  150  
75f668fca4309d Leon Romanovsky 2022-03-10  151  err_add_rule:
75f668fca4309d Leon Romanovsky 2022-03-10  152  	mlx5_destroy_flow_group(fs_prot->miss_group);
75f668fca4309d Leon Romanovsky 2022-03-10  153  err_alloc:
22db4c24452a66 Denis Efremov   2020-09-21  154  	kvfree(flow_group_in);
22db4c24452a66 Denis Efremov   2020-09-21  155  	kvfree(spec);
5e466345291a91 Huy Nguyen      2020-06-05  156  	return err;
5e466345291a91 Huy Nguyen      2020-06-05  157  }
5e466345291a91 Huy Nguyen      2020-06-05  158  

:::::: The code at line 133 was first introduced by commit
:::::: 5e466345291a91d1722e7198497198becda29e22 net/mlx5e: IPsec: Add IPsec steering in local NIC RX

:::::: TO: Huy Nguyen <huyn@mellanox.com>
:::::: CC: Saeed Mahameed <saeedm@mellanox.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
