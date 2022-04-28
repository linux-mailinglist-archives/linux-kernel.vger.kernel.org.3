Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037C512939
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiD1CDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiD1CDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:03:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BD05EBF3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651111226; x=1682647226;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=09fwBt5NTG8zE9oBVyCvL9wplaqEJlEJuPl7ITQb8yI=;
  b=LeNbengOR3SjDryqlDaP17Vhl6NvLEJl6etA6lF2hSY6ZHEm6ODP1IzG
   TJEu5kfsgekq/Oj7NPKCjK98t5hMWPjHjyLcI9UByDJpANsWhBhAZlpP/
   ejPKAS2rfQc5H/RpaKnmVHkvTqaq9MBlnoEEw5Kjkpx/zVaIcXKKxgWAK
   Bqy75nk4QX0ckNjrUT4LYLcmYBPgSOy5zkBY2EzDLbdD8TMXxezhnWEMO
   LTQKUGMLL+eFsck1jOUggpvFatk3nKcdJvsi9y6DZRpgR1tbmIm5APyBJ
   uxa8wtWhrjsQeZl6KBxpZ49ebo8FSYqM42sgHI1nplh2z7IKO8IYPXjGw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="329074373"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="329074373"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 19:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="661511058"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Apr 2022 19:00:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njtSB-0004y6-Qb;
        Thu, 28 Apr 2022 02:00:23 +0000
Date:   Thu, 28 Apr 2022 09:59:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thierryreding:for-5.19/work 136/141]
 drivers/soc/tegra/cbb/tegra234-cbb.c:262:44: warning: variable 'access_id'
 set but not used
Message-ID: <202204280421.ZryXtvpl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/thierryreding/linux for-5.19/work
head:   a39ec325554470289e8384e30d06a22960d1dd7b
commit: be6da5e3f83c6e1afd33a2a5ac85dfab6d8903b1 [136/141] cbb fixup
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220428/202204280421.ZryXtvpl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/thierryreding/linux/commit/be6da5e3f83c6e1afd33a2a5ac85dfab6d8903b1
        git remote add thierryreding https://github.com/thierryreding/linux
        git fetch --no-tags thierryreding for-5.19/work
        git checkout be6da5e3f83c6e1afd33a2a5ac85dfab6d8903b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/tegra/cbb/tegra234-cbb.c: In function 'print_errlog_err':
>> drivers/soc/tegra/cbb/tegra234-cbb.c:262:44: warning: variable 'access_id' set but not used [-Wunused-but-set-variable]
     262 |         u8 beat_size = 0, access_type = 0, access_id = 0;
         |                                            ^~~~~~~~~


vim +/access_id +262 drivers/soc/tegra/cbb/tegra234-cbb.c

613d0729a43e56 Sumit Gupta 2021-12-17  257  
613d0729a43e56 Sumit Gupta 2021-12-17  258  static void print_errlog_err(struct seq_file *file, struct tegra_cbb_errmon_record *errmon)
613d0729a43e56 Sumit Gupta 2021-12-17  259  {
613d0729a43e56 Sumit Gupta 2021-12-17  260  	u8 cache_type = 0, prot_type = 0, burst_length = 0;
613d0729a43e56 Sumit Gupta 2021-12-17  261  	u8 mstr_id = 0, grpsec = 0, vqc = 0, falconsec = 0;
613d0729a43e56 Sumit Gupta 2021-12-17 @262  	u8 beat_size = 0, access_type = 0, access_id = 0;
b5a0ef51e3d243 Sumit Gupta 2021-12-17  263  	u8 requester_socket_id = 0, local_socket_id = 0;
613d0729a43e56 Sumit Gupta 2021-12-17  264  	u8 slave_id = 0, fab_id = 0, burst_type = 0;
613d0729a43e56 Sumit Gupta 2021-12-17  265  	char fabric_name[20];
b5a0ef51e3d243 Sumit Gupta 2021-12-17  266  	bool is_numa = 0;
b5a0ef51e3d243 Sumit Gupta 2021-12-17  267  
b5a0ef51e3d243 Sumit Gupta 2021-12-17  268  	if (num_possible_nodes() > 1)
b5a0ef51e3d243 Sumit Gupta 2021-12-17  269  		is_numa = true;
613d0729a43e56 Sumit Gupta 2021-12-17  270  
613d0729a43e56 Sumit Gupta 2021-12-17  271  	mstr_id   = FIELD_GET(FAB_EM_EL_MSTRID, errmon->mn_user_bits);
613d0729a43e56 Sumit Gupta 2021-12-17  272  	vqc	  = FIELD_GET(FAB_EM_EL_VQC, errmon->mn_user_bits);
613d0729a43e56 Sumit Gupta 2021-12-17  273  	grpsec	  = FIELD_GET(FAB_EM_EL_GRPSEC, errmon->mn_user_bits);
613d0729a43e56 Sumit Gupta 2021-12-17  274  	falconsec = FIELD_GET(FAB_EM_EL_FALCONSEC, errmon->mn_user_bits);
613d0729a43e56 Sumit Gupta 2021-12-17  275  
b5a0ef51e3d243 Sumit Gupta 2021-12-17  276  	/*
b5a0ef51e3d243 Sumit Gupta 2021-12-17  277  	 * For SOC with multiple NUMA nodes, print cross socket access
b5a0ef51e3d243 Sumit Gupta 2021-12-17  278  	 * errors only if initiator/master_id is CCPLEX, CPMU or GPU.
b5a0ef51e3d243 Sumit Gupta 2021-12-17  279  	 */
b5a0ef51e3d243 Sumit Gupta 2021-12-17  280  	if (is_numa) {
b5a0ef51e3d243 Sumit Gupta 2021-12-17  281  		local_socket_id = numa_node_id();
b5a0ef51e3d243 Sumit Gupta 2021-12-17  282  		requester_socket_id = FIELD_GET(REQ_SOCKET_ID, errmon->mn_attr2);
b5a0ef51e3d243 Sumit Gupta 2021-12-17  283  
b5a0ef51e3d243 Sumit Gupta 2021-12-17  284  		if (requester_socket_id != local_socket_id) {
b5a0ef51e3d243 Sumit Gupta 2021-12-17  285  			if ((mstr_id != 0x1) && (mstr_id != 0x2) && (mstr_id != 0xB))
b5a0ef51e3d243 Sumit Gupta 2021-12-17  286  				return;
b5a0ef51e3d243 Sumit Gupta 2021-12-17  287  		}
b5a0ef51e3d243 Sumit Gupta 2021-12-17  288  	}
b5a0ef51e3d243 Sumit Gupta 2021-12-17  289  
613d0729a43e56 Sumit Gupta 2021-12-17  290  	fab_id	   = FIELD_GET(FAB_EM_EL_FABID, errmon->mn_attr2);
613d0729a43e56 Sumit Gupta 2021-12-17  291  	slave_id   = FIELD_GET(FAB_EM_EL_SLAVEID, errmon->mn_attr2);
613d0729a43e56 Sumit Gupta 2021-12-17  292  
613d0729a43e56 Sumit Gupta 2021-12-17  293  	access_id  = FIELD_GET(FAB_EM_EL_ACCESSID, errmon->mn_attr1);
613d0729a43e56 Sumit Gupta 2021-12-17  294  
613d0729a43e56 Sumit Gupta 2021-12-17  295  	cache_type   = FIELD_GET(FAB_EM_EL_AXCACHE, errmon->mn_attr0);
613d0729a43e56 Sumit Gupta 2021-12-17  296  	prot_type    = FIELD_GET(FAB_EM_EL_AXPROT, errmon->mn_attr0);
613d0729a43e56 Sumit Gupta 2021-12-17  297  	burst_length = FIELD_GET(FAB_EM_EL_BURSTLENGTH, errmon->mn_attr0);
613d0729a43e56 Sumit Gupta 2021-12-17  298  	burst_type   = FIELD_GET(FAB_EM_EL_BURSTTYPE, errmon->mn_attr0);
613d0729a43e56 Sumit Gupta 2021-12-17  299  	beat_size    = FIELD_GET(FAB_EM_EL_BEATSIZE, errmon->mn_attr0);
613d0729a43e56 Sumit Gupta 2021-12-17  300  	access_type  = FIELD_GET(FAB_EM_EL_ACCESSTYPE, errmon->mn_attr0);
613d0729a43e56 Sumit Gupta 2021-12-17  301  
b5a0ef51e3d243 Sumit Gupta 2021-12-17  302  	print_cbb_err(file, "\n");
b5a0ef51e3d243 Sumit Gupta 2021-12-17  303  	print_cbb_err(file, "\t  Error Code\t\t: %s\n",
613d0729a43e56 Sumit Gupta 2021-12-17  304  		      t234_errmon_errors[errmon->err_type].errcode);
613d0729a43e56 Sumit Gupta 2021-12-17  305  
613d0729a43e56 Sumit Gupta 2021-12-17  306  	print_cbb_err(file, "\t  MASTER_ID\t\t: %s\n", errmon->tegra_cbb_master_id[mstr_id]);
613d0729a43e56 Sumit Gupta 2021-12-17  307  	print_cbb_err(file, "\t  Address\t\t: 0x%llx\n", (u64)errmon->addr_access);
613d0729a43e56 Sumit Gupta 2021-12-17  308  
613d0729a43e56 Sumit Gupta 2021-12-17  309  	print_cache(file, cache_type);
613d0729a43e56 Sumit Gupta 2021-12-17  310  	print_prot(file, prot_type);
613d0729a43e56 Sumit Gupta 2021-12-17  311  
613d0729a43e56 Sumit Gupta 2021-12-17  312  	print_cbb_err(file, "\t  Access_Type\t\t: %s", (access_type) ? "Write\n" : "Read\n");
613d0729a43e56 Sumit Gupta 2021-12-17  313  
613d0729a43e56 Sumit Gupta 2021-12-17  314  	if (fab_id == PSC_FAB_ID)
613d0729a43e56 Sumit Gupta 2021-12-17  315  		strcpy(fabric_name, "psc-fabric");
613d0729a43e56 Sumit Gupta 2021-12-17  316  	else if (fab_id == FSI_FAB_ID)
613d0729a43e56 Sumit Gupta 2021-12-17  317  		strcpy(fabric_name, "fsi-fabric");
613d0729a43e56 Sumit Gupta 2021-12-17  318  	else
613d0729a43e56 Sumit Gupta 2021-12-17  319  		strcpy(fabric_name, errmon->name);
613d0729a43e56 Sumit Gupta 2021-12-17  320  
b5a0ef51e3d243 Sumit Gupta 2021-12-17  321  	if (is_numa) {
b5a0ef51e3d243 Sumit Gupta 2021-12-17  322  		print_cbb_err(file, "\t  Requester_Socket_Id\t: 0x%x\n",
b5a0ef51e3d243 Sumit Gupta 2021-12-17  323  			      requester_socket_id);
b5a0ef51e3d243 Sumit Gupta 2021-12-17  324  		print_cbb_err(file, "\t  Local_Socket_Id\t: 0x%x\n",
b5a0ef51e3d243 Sumit Gupta 2021-12-17  325  			      local_socket_id);
b5a0ef51e3d243 Sumit Gupta 2021-12-17  326  		print_cbb_err(file, "\t  No. of NUMA_NODES\t: 0x%x\n",
b5a0ef51e3d243 Sumit Gupta 2021-12-17  327  			      num_possible_nodes());
b5a0ef51e3d243 Sumit Gupta 2021-12-17  328  	}
b5a0ef51e3d243 Sumit Gupta 2021-12-17  329  
613d0729a43e56 Sumit Gupta 2021-12-17  330  	print_cbb_err(file, "\t  Fabric\t\t: %s\n", fabric_name);
613d0729a43e56 Sumit Gupta 2021-12-17  331  	print_cbb_err(file, "\t  Slave_Id\t\t: 0x%x\n", slave_id);
613d0729a43e56 Sumit Gupta 2021-12-17  332  	print_cbb_err(file, "\t  Burst_length\t\t: 0x%x\n", burst_length);
613d0729a43e56 Sumit Gupta 2021-12-17  333  	print_cbb_err(file, "\t  Burst_type\t\t: 0x%x\n", burst_type);
613d0729a43e56 Sumit Gupta 2021-12-17  334  	print_cbb_err(file, "\t  Beat_size\t\t: 0x%x\n", beat_size);
613d0729a43e56 Sumit Gupta 2021-12-17  335  	print_cbb_err(file, "\t  VQC\t\t\t: 0x%x\n", vqc);
613d0729a43e56 Sumit Gupta 2021-12-17  336  	print_cbb_err(file, "\t  GRPSEC\t\t: 0x%x\n", grpsec);
613d0729a43e56 Sumit Gupta 2021-12-17  337  	print_cbb_err(file, "\t  FALCONSEC\t\t: 0x%x\n", falconsec);
613d0729a43e56 Sumit Gupta 2021-12-17  338  
613d0729a43e56 Sumit Gupta 2021-12-17  339  	if ((fab_id == PSC_FAB_ID) || (fab_id == FSI_FAB_ID))
613d0729a43e56 Sumit Gupta 2021-12-17  340  		return;
613d0729a43e56 Sumit Gupta 2021-12-17  341  
613d0729a43e56 Sumit Gupta 2021-12-17  342  	if (!strcmp(errmon->noc_errors[errmon->err_type].errcode, "TIMEOUT_ERR")) {
613d0729a43e56 Sumit Gupta 2021-12-17  343  		tegra234_lookup_slave_timeout(file, errmon, slave_id, fab_id);
613d0729a43e56 Sumit Gupta 2021-12-17  344  		return;
613d0729a43e56 Sumit Gupta 2021-12-17  345  	}
613d0729a43e56 Sumit Gupta 2021-12-17  346  	print_cbb_err(file, "\t  Slave\t\t\t: %s\n", errmon->sn_addr_map[slave_id].slave_name);
613d0729a43e56 Sumit Gupta 2021-12-17  347  }
613d0729a43e56 Sumit Gupta 2021-12-17  348  

:::::: The code at line 262 was first introduced by commit
:::::: 613d0729a43e56adbf74adf7ea4a0c3dd1fac47d soc: tegra: cbb: Add driver for Tegra234 CBB2.0

:::::: TO: Sumit Gupta <sumitg@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
