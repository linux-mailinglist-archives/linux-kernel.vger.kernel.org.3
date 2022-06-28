Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35155EB63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiF1Ryi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiF1Rye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:54:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7688D98
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656438873; x=1687974873;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H61tCWwcgYy9OdKfOC3WuAnS2P6R5eqCfcjkV1kzIiY=;
  b=hYU/xMenFmTeUKD7pMd76yDYk7JVIGJDLMfnm4XspY5M7TlHzxVyAv5z
   J8UTerd6CDdM+voCsDGDrNtUNxXtzzvs0epSHNYsKMQ48HZcjMZAPBoZC
   n3vH6CL1stlwuwqeieqhGEYU3DAofd2U+1ptdlkgUFJlUsqkOhrVJ+GTh
   wNOgHkEFn9mZBi0rbRmuUjLADVa8v6qhkRhPNqYZhu2F5OYkjT82tnRs/
   gva4K6IkkeGKlRi8rWp0wCdlf5WW2j8kezzTw7LUtN2+HikNHSK9XARIl
   oDPsSGm7C8rFObGEuLc9Mmw3BT2VwU0JvoSIhnJrblEhPrmFk/n6tEQar
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282903851"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="282903851"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 10:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="658221548"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 10:54:27 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6FPu-000ATw-Pf;
        Tue, 28 Jun 2022 17:54:26 +0000
Date:   Wed, 29 Jun 2022 01:54:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 21/21]
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2002:25: warning: unused
 variable 'devlink'
Message-ID: <202206290113.qppTEFqZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   9162f3d685ec59a9811d91e44c3f79c51714d077
commit: 9162f3d685ec59a9811d91e44c3f79c51714d077 [21/21] x
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220629/202206290113.qppTEFqZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/jpirko/linux_mlxsw/commit/9162f3d685ec59a9811d91e44c3f79c51714d077
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout 9162f3d685ec59a9811d91e44c3f79c51714d077
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function 'mlxsw_sp_ports_remove':
>> drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2002:25: warning: unused variable 'devlink' [-Wunused-variable]
    2002 |         struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
         |                         ^~~~~~~


vim +/devlink +2002 drivers/net/ethernet/mellanox/mlxsw/spectrum.c

b0ec003e9a9064 Jiri Pirko    2022-04-18  1998  
56ade8fe3fe1e1 Jiri Pirko    2015-10-16  1999  static void mlxsw_sp_ports_remove(struct mlxsw_sp *mlxsw_sp)
56ade8fe3fe1e1 Jiri Pirko    2015-10-16  2000  {
b0ec003e9a9064 Jiri Pirko    2022-04-18  2001  	unsigned int max_ports = mlxsw_core_max_ports(mlxsw_sp->core);
adc6462376b1a2 Jiri Pirko    2022-04-18 @2002  	struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
56ade8fe3fe1e1 Jiri Pirko    2015-10-16  2003  	int i;
56ade8fe3fe1e1 Jiri Pirko    2015-10-16  2004  
b0ec003e9a9064 Jiri Pirko    2022-04-18  2005  	for (i = 1; i < max_ports; i++)
b0ec003e9a9064 Jiri Pirko    2022-04-18  2006  		mlxsw_sp_port_mapping_event_set(mlxsw_sp, i, false);
b0ec003e9a9064 Jiri Pirko    2022-04-18  2007  	/* Make sure all scheduled events are processed */
b0ec003e9a9064 Jiri Pirko    2022-04-18  2008  	__mlxsw_sp_port_mapping_events_cancel(mlxsw_sp);
b0ec003e9a9064 Jiri Pirko    2022-04-18  2009  
b0ec003e9a9064 Jiri Pirko    2022-04-18  2010  	for (i = 1; i < max_ports; i++)
f83e21027b4d88 Jiri Pirko    2016-10-28  2011  		if (mlxsw_sp_port_created(mlxsw_sp, i))
56ade8fe3fe1e1 Jiri Pirko    2015-10-16  2012  			mlxsw_sp_port_remove(mlxsw_sp, i);
28b1987ef5064d Shalom Toledo 2019-09-16  2013  	mlxsw_sp_cpu_port_remove(mlxsw_sp);
56ade8fe3fe1e1 Jiri Pirko    2015-10-16  2014  	kfree(mlxsw_sp->ports);
4340f42f207eac Jiri Pirko    2020-05-21  2015  	mlxsw_sp->ports = NULL;
56ade8fe3fe1e1 Jiri Pirko    2015-10-16  2016  }
56ade8fe3fe1e1 Jiri Pirko    2015-10-16  2017  

:::::: The code at line 2002 was first introduced by commit
:::::: adc6462376b1a22d486ab5f6e624ba9528a380da mlxsw: Narrow the critical section of devl_lock during ports creation/removal

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
