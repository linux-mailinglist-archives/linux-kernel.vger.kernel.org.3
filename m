Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE734797B9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 01:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhLRAHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 19:07:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:25241 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhLRAH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 19:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639786049; x=1671322049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tY9H97mhZQZZUfy1ssG1riRgiBvv3oOnmpjkH2DiLIQ=;
  b=D4Qz38dYudSqq+vPJ9u9Ot0tm88pg3MVrSNx6GC3GDS3koLDqk3i6FbC
   Fk2IwaF8lQY9Qtaps0wSqpNTPdgW0D9j06xItDEp6hdYOMj8/ZJR99PU0
   4SEFBRhpSSH5VxrQsKhZFAGmMqWpsX4EOtn4mKpLOOw2p5u39G6cp08M2
   i783OkswHmXf+K/Vr9cABvlI5NYOWhozVTDNuAusLUuM+EZWOZscx4u1y
   +VDX3CTXCGJifNaNeRECupw8iBp+oGH+rmKFU6FGUrLn1RlnWyjsIAutZ
   sMffFlhCPD4n0JNCpYc0nTduXZ1pwbDUySsQYmiEXsfjzlq+RcUP4+ueZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="303236360"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="303236360"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 16:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="546565540"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2021 16:07:25 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myNG1-0005MI-0A; Sat, 18 Dec 2021 00:07:25 +0000
Date:   Sat, 18 Dec 2021 08:07:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Gupta <sumitg@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org
Cc:     kbuild-all@lists.01.org, sumitg@nvidia.com, bbasu@nvidia.com,
        vsethi@nvidia.com, jsequeira@nvidia.com
Subject: Re: [Patch v2 8/9] soc: tegra: cbb: Add driver for Tegra234 CBB2.0
Message-ID: <202112180744.BM6U6RpD-lkp@intel.com>
References: <20211217120656.16480-9-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217120656.16480-9-sumitg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on tegra-drm/drm/tegra/for-next v5.16-rc5 next-20211217]
[cannot apply to tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sumit-Gupta/CBB-driver-for-Tegra194-Tegra234-Tegra-Grace/20211217-200840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211218/202112180744.BM6U6RpD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/79bd78736f10c5f36ba4a18c6d313d62cae7b010
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sumit-Gupta/CBB-driver-for-Tegra194-Tegra234-Tegra-Grace/20211217-200840
        git checkout 79bd78736f10c5f36ba4a18c6d313d62cae7b010
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/tegra/cbb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/tegra/cbb/tegra234-cbb.c: In function 'print_errlog_err':
>> drivers/soc/tegra/cbb/tegra234-cbb.c:260:44: warning: variable 'access_id' set but not used [-Wunused-but-set-variable]
     260 |         u8 beat_size = 0, access_type = 0, access_id = 0;
         |                                            ^~~~~~~~~


vim +/access_id +260 drivers/soc/tegra/cbb/tegra234-cbb.c

   255	
   256	static void print_errlog_err(struct seq_file *file, struct tegra_cbb_errmon_record *errmon)
   257	{
   258		u8 cache_type = 0, prot_type = 0, burst_length = 0;
   259		u8 mstr_id = 0, grpsec = 0, vqc = 0, falconsec = 0;
 > 260		u8 beat_size = 0, access_type = 0, access_id = 0;
   261		u8 slave_id = 0, fab_id = 0, burst_type = 0;
   262		char fabric_name[20];
   263	
   264		mstr_id   = FIELD_GET(FAB_EM_EL_MSTRID, errmon->mn_user_bits);
   265		vqc	  = FIELD_GET(FAB_EM_EL_VQC, errmon->mn_user_bits);
   266		grpsec	  = FIELD_GET(FAB_EM_EL_GRPSEC, errmon->mn_user_bits);
   267		falconsec = FIELD_GET(FAB_EM_EL_FALCONSEC, errmon->mn_user_bits);
   268	
   269		fab_id	   = FIELD_GET(FAB_EM_EL_FABID, errmon->mn_attr2);
   270		slave_id   = FIELD_GET(FAB_EM_EL_SLAVEID, errmon->mn_attr2);
   271	
   272		access_id  = FIELD_GET(FAB_EM_EL_ACCESSID, errmon->mn_attr1);
   273	
   274		cache_type   = FIELD_GET(FAB_EM_EL_AXCACHE, errmon->mn_attr0);
   275		prot_type    = FIELD_GET(FAB_EM_EL_AXPROT, errmon->mn_attr0);
   276		burst_length = FIELD_GET(FAB_EM_EL_BURSTLENGTH, errmon->mn_attr0);
   277		burst_type   = FIELD_GET(FAB_EM_EL_BURSTTYPE, errmon->mn_attr0);
   278		beat_size    = FIELD_GET(FAB_EM_EL_BEATSIZE, errmon->mn_attr0);
   279		access_type  = FIELD_GET(FAB_EM_EL_ACCESSTYPE, errmon->mn_attr0);
   280	
   281		print_cbb_err(file, "\t  First logged Err Code : %s\n",
   282			      t234_errmon_errors[errmon->err_type].errcode);
   283	
   284		print_cbb_err(file, "\t  MASTER_ID\t\t: %s\n", errmon->tegra_cbb_master_id[mstr_id]);
   285		print_cbb_err(file, "\t  Address\t\t: 0x%llx\n", (u64)errmon->addr_access);
   286	
   287		print_cache(file, cache_type);
   288		print_prot(file, prot_type);
   289	
   290		print_cbb_err(file, "\t  Access_Type\t\t: %s", (access_type) ? "Write\n" : "Read\n");
   291	
   292		if (fab_id == PSC_FAB_ID)
   293			strcpy(fabric_name, "psc-fabric");
   294		else if (fab_id == FSI_FAB_ID)
   295			strcpy(fabric_name, "fsi-fabric");
   296		else
   297			strcpy(fabric_name, errmon->name);
   298	
   299		print_cbb_err(file, "\t  Fabric\t\t: %s\n", fabric_name);
   300		print_cbb_err(file, "\t  Slave_Id\t\t: 0x%x\n", slave_id);
   301		print_cbb_err(file, "\t  Burst_length\t\t: 0x%x\n", burst_length);
   302		print_cbb_err(file, "\t  Burst_type\t\t: 0x%x\n", burst_type);
   303		print_cbb_err(file, "\t  Beat_size\t\t: 0x%x\n", beat_size);
   304		print_cbb_err(file, "\t  VQC\t\t\t: 0x%x\n", vqc);
   305		print_cbb_err(file, "\t  GRPSEC\t\t: 0x%x\n", grpsec);
   306		print_cbb_err(file, "\t  FALCONSEC\t\t: 0x%x\n", falconsec);
   307	
   308		if ((fab_id == PSC_FAB_ID) || (fab_id == FSI_FAB_ID))
   309			return;
   310	
   311		if (!strcmp(errmon->noc_errors[errmon->err_type].errcode, "TIMEOUT_ERR")) {
   312			tegra234_lookup_slave_timeout(file, errmon, slave_id, fab_id);
   313			return;
   314		}
   315		print_cbb_err(file, "\t  Slave\t\t\t: %s\n", errmon->sn_addr_map[slave_id].slave_name);
   316	}
   317	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
