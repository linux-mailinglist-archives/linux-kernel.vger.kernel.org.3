Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01DE5028DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352690AbiDOLas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbiDOLap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:30:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59365823;
        Fri, 15 Apr 2022 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650022098; x=1681558098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m0mb6HYDSFX9ETisSpP+Q9Z89pB6kB8Hcj7Qvd78dk0=;
  b=a9d2p0Fe8UofmknBtgHjLY5Gx9R8I9LbWJ7Fl+gNC/rFSko/hJbck7vZ
   y1SoJKIQSCYFhJqucF7vEu3Q7C5UcexAWX40Bx9q0TjLrL4KqNcJQLTS3
   yDyTnm90MShRtsf4iSdLvzxwmR8DwV2+nN3TVYtJ1fiD5YYn7X+HzjYSD
   /finmT0BBICXTCP61B+Exlxh51L/byzoBsBMm8A7mV47s6QvyRdsXre+q
   9h1A3xplsyScuOWimJoOHFXiall64ZiV8GdlPmLUcJFyz/Bhv7hVmFPi/
   nRaNZo/LGgQX8/a4Drg4PXcHnOXokXGoL5Q030vH/qZysncTjejW2aXGC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243071956"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="243071956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 04:28:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="508916656"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2022 04:28:07 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfK7S-0001u1-TP;
        Fri, 15 Apr 2022 11:28:06 +0000
Date:   Fri, 15 Apr 2022 19:27:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Schspa Shi <schspa@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>, linux-doc@vger.kernel.org
Subject: [kdave-btrfs-devel:misc-next 105/114] fs/btrfs/zstd.c:98: warning:
 This comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202204151934.CkKcnvuJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git misc-next
head:   550a34e972578538fd0826916ae4fc407b62bb68
commit: b672526e2ee9352854d286f400122f7690f70970 [105/114] btrfs: use non-bh spin_lock in zstd timer callback
config: alpha-randconfig-r003-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151934.CkKcnvuJ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/kdave/btrfs-devel/commit/b672526e2ee9352854d286f400122f7690f70970
        git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-devel.git
        git fetch --no-tags kdave-btrfs-devel misc-next
        git checkout b672526e2ee9352854d286f400122f7690f70970
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/zstd.c:98: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Timer callback to free unused workspaces.


vim +98 fs/btrfs/zstd.c

    96	
    97	/**
  > 98	 * Timer callback to free unused workspaces.
    99	 *
   100	 * @t: timer
   101	 *
   102	 * This scans the lru_list and attempts to reclaim any workspace that hasn't
   103	 * been used for ZSTD_BTRFS_RECLAIM_JIFFIES.
   104	 *
   105	 * The context is softirq and does not need the _bh locking primitives.
   106	 */
   107	static void zstd_reclaim_timer_fn(struct timer_list *timer)
   108	{
   109		unsigned long reclaim_threshold = jiffies - ZSTD_BTRFS_RECLAIM_JIFFIES;
   110		struct list_head *pos, *next;
   111	
   112		spin_lock(&wsm.lock);
   113	
   114		if (list_empty(&wsm.lru_list)) {
   115			spin_unlock(&wsm.lock);
   116			return;
   117		}
   118	
   119		list_for_each_prev_safe(pos, next, &wsm.lru_list) {
   120			struct workspace *victim = container_of(pos, struct workspace,
   121								lru_list);
   122			unsigned int level;
   123	
   124			if (time_after(victim->last_used, reclaim_threshold))
   125				break;
   126	
   127			/* workspace is in use */
   128			if (victim->req_level)
   129				continue;
   130	
   131			level = victim->level;
   132			list_del(&victim->lru_list);
   133			list_del(&victim->list);
   134			zstd_free_workspace(&victim->list);
   135	
   136			if (list_empty(&wsm.idle_ws[level - 1]))
   137				clear_bit(level - 1, &wsm.active_map);
   138	
   139		}
   140	
   141		if (!list_empty(&wsm.lru_list))
   142			mod_timer(&wsm.timer, jiffies + ZSTD_BTRFS_RECLAIM_JIFFIES);
   143	
   144		spin_unlock(&wsm.lock);
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
