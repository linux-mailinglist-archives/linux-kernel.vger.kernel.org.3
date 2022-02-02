Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E984A694F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbiBBArZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:47:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:19069 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbiBBArX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643762843; x=1675298843;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jm+v7AhBx35H/68NrlWBCe4U7A2AsXxzK3bKc1V7OFI=;
  b=JeX1295iRcWGkALaxvZ5wsqj3MDP4PDnAUcwS+Sk+HO66sJkgptG+VOb
   DaDZLMeqY2+UtZje+hoGVk07Ef0YJc2ib67gBd5o+PRcrNdIw9IfGIeoU
   TBNIpcnO2s7uL9PJe1nlGJ0MxDRiiiGd2iZwAJKROmwQ+7drON1fBIYRx
   K/vYvwVQfCO5p0qsdXdPT/gvxIP9Gd+gNG/24t7BLZJFZ56t4yYBPjcIW
   GRWhsb+E2GRHev/wYtwCWc9mS9xrKlB8LnfcKQw77wnx5kSqv2kaRMj4T
   SifqO4KtROrQgzQNzyMGoeIo78dCD+B1L317O9QihjAPnrAln1ioq51us
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="248048196"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="248048196"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 16:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="538049421"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Feb 2022 16:47:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF3nr-000Tte-VM; Wed, 02 Feb 2022 00:47:19 +0000
Date:   Wed, 2 Feb 2022 08:47:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/ath12k-bringup 275/275]
 drivers/net/wireless/ath/ath12k/debugfs.c:250:13: warning: assignment to
 'void *' from 'int' makes pointer from integer without a cast
Message-ID: <202202020835.JgAG7kJa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/ath12k-bringup
head:   f40abb4788a2a3868606a29d99583421e0874350
commit: f40abb4788a2a3868606a29d99583421e0874350 [275/275] ath12k: New driver for Qualcomm 11be hw family
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220202/202202020835.JgAG7kJa-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f40abb4788a2a3868606a29d99583421e0874350
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/ath12k-bringup
        git checkout f40abb4788a2a3868606a29d99583421e0874350
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/ath/ath12k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/ath/ath12k/debugfs.c: In function 'ath12k_open_pdev_stats':
   drivers/net/wireless/ath/ath12k/debugfs.c:250:15: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
     250 |         buf = vmalloc(ATH12K_FW_STATS_BUF_SIZE);
         |               ^~~~~~~
         |               kvmalloc
>> drivers/net/wireless/ath/ath12k/debugfs.c:250:13: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     250 |         buf = vmalloc(ATH12K_FW_STATS_BUF_SIZE);
         |             ^
   drivers/net/wireless/ath/ath12k/debugfs.c:275:9: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
     275 |         vfree(buf);
         |         ^~~~~
         |         kvfree
   drivers/net/wireless/ath/ath12k/debugfs.c: In function 'ath12k_open_vdev_stats':
   drivers/net/wireless/ath/ath12k/debugfs.c:321:13: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     321 |         buf = vmalloc(ATH12K_FW_STATS_BUF_SIZE);
         |             ^
   drivers/net/wireless/ath/ath12k/debugfs.c: In function 'ath12k_open_bcn_stats':
   drivers/net/wireless/ath/ath12k/debugfs.c:400:13: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     400 |         buf = vmalloc(ATH12K_FW_STATS_BUF_SIZE);
         |             ^
   cc1: some warnings being treated as errors


vim +250 drivers/net/wireless/ath/ath12k/debugfs.c

   234	
   235	static int ath12k_open_pdev_stats(struct inode *inode, struct file *file)
   236	{
   237		struct ath12k *ar = inode->i_private;
   238		struct ath12k_base *ab = ar->ab;
   239		struct stats_request_params req_param;
   240		void *buf = NULL;
   241		int ret;
   242	
   243		mutex_lock(&ar->conf_mutex);
   244	
   245		if (ar->state != ATH12K_STATE_ON) {
   246			ret = -ENETDOWN;
   247			goto err_unlock;
   248		}
   249	
 > 250		buf = vmalloc(ATH12K_FW_STATS_BUF_SIZE);
   251		if (!buf) {
   252			ret = -ENOMEM;
   253			goto err_unlock;
   254		}
   255	
   256		req_param.pdev_id = ar->pdev->pdev_id;
   257		req_param.vdev_id = 0;
   258		req_param.stats_id = WMI_REQUEST_PDEV_STAT;
   259	
   260		ret = ath12k_debugfs_fw_stats_request(ar, &req_param);
   261		if (ret) {
   262			ath12k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
   263			goto err_free;
   264		}
   265	
   266		ath12k_wmi_fw_stats_fill(ar, &ar->debug.fw_stats, req_param.stats_id,
   267					 buf);
   268	
   269		file->private_data = buf;
   270	
   271		mutex_unlock(&ar->conf_mutex);
   272		return 0;
   273	
   274	err_free:
   275		vfree(buf);
   276	
   277	err_unlock:
   278		mutex_unlock(&ar->conf_mutex);
   279		return ret;
   280	}
   281	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
