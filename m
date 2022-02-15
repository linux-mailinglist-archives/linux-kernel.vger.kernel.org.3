Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2B4B7B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbiBOXtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:49:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbiBOXt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:49:28 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A5DDAAFE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644968957; x=1676504957;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hO6d4nhTJaxkqNk/wzEFqZo0tgEE/3SKs2w+Zizo43g=;
  b=XEUuA6EwtGZ4djt0xLTy3KAQCg8VGBO3cmphTINMQgFVitFErAmq6jQZ
   r0crDEKjNBj1r0wvxLhiy2mTawF8vTy7Y9/6CvXQd0a5GR9JPhonbbrta
   0/aUuGj6fV3GB80bKywLL5mE7+axGlYSl9cz0y3AnfMl/xO6BgxzKjAmT
   mAe2oY5JoPSyDyI1iF1vjMIhT4zNaaSgMtYSLVO/Fs5Uu4LXdm/yeM4Wj
   loCYTanJDeCGs5vX6vQrRx3iKQDXFmItCNiYlon493S1w5Ag5FpNS4FiJ
   1yxWCroZHoV8dLPSc4UzDk4Xl8en/OsPzI0wtxwliRkV+fDdTLNAaXA7n
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311225338"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="311225338"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 15:49:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="486481735"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Feb 2022 15:49:15 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK7ZK-000A9j-RV; Tue, 15 Feb 2022 23:49:14 +0000
Date:   Wed, 16 Feb 2022 07:48:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 2/34]
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:664:35: warning: format '%ld'
 expects argument of type 'long int', but argument 4 has type 'size_t' {aka
 'unsigned int'}
Message-ID: <202202160733.1Egjqp9Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   076172cdc7ab4983ed7596a53b95851849269e5a
commit: a6c40b178092f41b9d6cc8615697c14b1e5a1c3a [2/34] drm/amdgpu: Show IP discovery in sysfs
config: arm-randconfig-r005-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160733.1Egjqp9Y-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout a6c40b178092f41b9d6cc8615697c14b1e5a1c3a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h:29,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:43,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:26:
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c: In function 'amdgpu_discovery_sysfs_ips':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:664:35: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     664 |                         DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~      ~~~~~~~~~
         |                                                                   |
         |                                                                   size_t {aka unsigned int}
   include/drm/drm_print.h:526:32: note: in definition of macro 'DRM_DEBUG'
     526 |         __drm_dbg(DRM_UT_CORE, fmt, ##__VA_ARGS__)
         |                                ^~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:664:59: note: format string is defined here
     664 |                         DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
         |                                                         ~~^
         |                                                           |
         |                                                           long int
         |                                                         %d


vim +664 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c

   639	
   640	static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
   641					      struct ip_die_entry *ip_die_entry,
   642					      const size_t _ip_offset, const int num_ips)
   643	{
   644		int ii, jj, kk, res;
   645	
   646		DRM_DEBUG("num_ips:%d", num_ips);
   647	
   648		/* Find all IPs of a given HW ID, and add their instance to
   649		 * #die/#hw_id/#instance/<attributes>
   650		 */
   651		for (ii = 0; ii < HW_ID_MAX; ii++) {
   652			struct ip_hw_id *ip_hw_id = NULL;
   653			size_t ip_offset = _ip_offset;
   654	
   655			for (jj = 0; jj < num_ips; jj++) {
   656				struct ip *ip;
   657				struct ip_hw_instance *ip_hw_instance;
   658	
   659				ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
   660				if (amdgpu_discovery_validate_ip(ip) ||
   661				    le16_to_cpu(ip->hw_id) != ii)
   662					goto next_ip;
   663	
 > 664				DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
   665	
   666				/* We have a hw_id match; register the hw
   667				 * block if not yet registered.
   668				 */
   669				if (!ip_hw_id) {
   670					ip_hw_id = kzalloc(sizeof(*ip_hw_id), GFP_KERNEL);
   671					if (!ip_hw_id)
   672						return -ENOMEM;
   673					ip_hw_id->hw_id = ii;
   674	
   675					kobject_set_name(&ip_hw_id->hw_id_kset.kobj, "%d", ii);
   676					ip_hw_id->hw_id_kset.kobj.kset = &ip_die_entry->ip_kset;
   677					ip_hw_id->hw_id_kset.kobj.ktype = &ip_hw_id_ktype;
   678					res = kset_register(&ip_hw_id->hw_id_kset);
   679					if (res) {
   680						DRM_ERROR("Couldn't register ip_hw_id kset");
   681						kfree(ip_hw_id);
   682						return res;
   683					}
   684					if (hw_id_names[ii]) {
   685						res = sysfs_create_link(&ip_die_entry->ip_kset.kobj,
   686									&ip_hw_id->hw_id_kset.kobj,
   687									hw_id_names[ii]);
   688						if (res) {
   689							DRM_ERROR("Couldn't create IP link %s in IP Die:%s\n",
   690								  hw_id_names[ii],
   691								  kobject_name(&ip_die_entry->ip_kset.kobj));
   692						}
   693					}
   694				}
   695	
   696				/* Now register its instance.
   697				 */
   698				ip_hw_instance = kzalloc(struct_size(ip_hw_instance,
   699								     base_addr,
   700								     ip->num_base_address),
   701							 GFP_KERNEL);
   702				if (!ip_hw_instance) {
   703					DRM_ERROR("no memory for ip_hw_instance");
   704					return -ENOMEM;
   705				}
   706				ip_hw_instance->hw_id = le16_to_cpu(ip->hw_id); /* == ii */
   707				ip_hw_instance->num_instance = ip->number_instance;
   708				ip_hw_instance->major = ip->major;
   709				ip_hw_instance->minor = ip->minor;
   710				ip_hw_instance->revision = ip->revision;
   711				ip_hw_instance->num_base_addresses = ip->num_base_address;
   712	
   713				for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
   714					ip_hw_instance->base_addr[kk] = ip->base_address[kk];
   715	
   716				kobject_init(&ip_hw_instance->kobj, &ip_hw_instance_ktype);
   717				ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
   718				res = kobject_add(&ip_hw_instance->kobj, NULL,
   719						  "%d", ip_hw_instance->num_instance);
   720	next_ip:
   721				ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
   722			}
   723		}
   724	
   725		return 0;
   726	}
   727	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
