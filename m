Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CAD58B32E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiHFBR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 21:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiHFBRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 21:17:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC7A2A275
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 18:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659748674; x=1691284674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hHX9/ISd+NDQ5w+x8XftX/j4/DS2vRJ7IK0YGQQFZqQ=;
  b=bOPJDPsV631c2zGprbVpi8B2dShTzDq61Bl0GfOqTR2ouwSsmFq5/D+H
   2qWeneX16IJs0mguLv0/fB+suBDw2NmN4fq7SZ7GB4kdI0CobbtzGiXKx
   Jatpb8sx7olMxRYwbHCPOTrcO+tN9KK3arkggoHTDkqNTVYqHlQDhFrqZ
   Jn5JHXqMIFzZwb+8eGjHyFF+8CGHTUItkmRt0JU+CnXU33CrW1xnG6CTb
   BOyXI4p1p7RmYeolA32vM3Q2xr/jGd3FPdUdaKEmJ0poNa+DYH3ICXBcg
   MpDPKOnUTejis/Y/eD/HJVx+JuWZI4GWAw2T7pr9DCnevvjdCQHu4ZiB7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="290333649"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="290333649"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 18:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="579706100"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 18:17:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK8Rd-000Jt5-21;
        Sat, 06 Aug 2022 01:17:37 +0000
Date:   Sat, 6 Aug 2022 09:17:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danielle Ratson <danieller@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Amit Cohen <amcohen@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h:159:5: warning:
 no previous prototype for 'mlxsw_sp_ptp_txhdr_construct'
Message-ID: <202208060935.1nNlUNZG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: 24157bc69f45e8340af5ed72422afe8a248e0153 mlxsw: Send PTP packets as data packets to overcome a limitation
date:   8 days ago
config: csky-randconfig-c033-20220805 (https://download.01.org/0day-ci/archive/20220806/202208060935.1nNlUNZG-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24157bc69f45e8340af5ed72422afe8a248e0153
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 24157bc69f45e8340af5ed72422afe8a248e0153
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/mellanox/mlxsw/spectrum.c:46:
>> drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h:159:5: warning: no previous prototype for 'mlxsw_sp_ptp_txhdr_construct' [-Wmissing-prototypes]
     159 | int mlxsw_sp_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h:187:5: warning: no previous prototype for 'mlxsw_sp2_ptp_txhdr_construct' [-Wmissing-prototypes]
     187 | int mlxsw_sp2_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mlxsw_sp_ptp_txhdr_construct +159 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h

   158	
 > 159	int mlxsw_sp_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
   160					 struct mlxsw_sp_port *mlxsw_sp_port,
   161					 struct sk_buff *skb,
   162					 const struct mlxsw_tx_info *tx_info)
   163	{
   164		return -EOPNOTSUPP;
   165	}
   166	
   167	static inline struct mlxsw_sp_ptp_clock *
   168	mlxsw_sp2_ptp_clock_init(struct mlxsw_sp *mlxsw_sp, struct device *dev)
   169	{
   170		return NULL;
   171	}
   172	
   173	static inline void mlxsw_sp2_ptp_clock_fini(struct mlxsw_sp_ptp_clock *clock)
   174	{
   175	}
   176	
   177	static inline struct mlxsw_sp_ptp_state *
   178	mlxsw_sp2_ptp_init(struct mlxsw_sp *mlxsw_sp)
   179	{
   180		return NULL;
   181	}
   182	
   183	static inline void mlxsw_sp2_ptp_fini(struct mlxsw_sp_ptp_state *ptp_state)
   184	{
   185	}
   186	
 > 187	int mlxsw_sp2_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
   188					  struct mlxsw_sp_port *mlxsw_sp_port,
   189					  struct sk_buff *skb,
   190					  const struct mlxsw_tx_info *tx_info)
   191	{
   192		return -EOPNOTSUPP;
   193	}
   194	#endif
   195	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
