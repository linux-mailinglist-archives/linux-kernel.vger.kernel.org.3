Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0D5890DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiHCQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiHCQ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:58:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1802ADFA8;
        Wed,  3 Aug 2022 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659545906; x=1691081906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+B1vsLU39VGsTpHwlt0Hln8FAe8XY68mIqJ4Xlv+sJo=;
  b=F7DHFSD3b6M9nJMGS7G/8ZD/zZiWYdW0jWtQaqGDGmmBmxMmaTcrvTI7
   zHv+RfWeknlGI2sozQ6IJ4aZO5QiXUOH0wb8fCGcTPsj6jaf/arJCmHS2
   7fPHHgIXXHth6/G8oNxhhqdZhQzQG9QZONdQ8epxgWWMkzm2Fkg8U0sVI
   5D9Ob6fqteaFRoPv0MvX7tIV67YDm+mS+2wgOdeqO6mb4bq6v1h4g14Fm
   5WiVvA9cLWsk6UtYG4IXdMzE+SGzhnQf3vcoEECtg4u5jp6Q2twOTiGY9
   v16+9511aH9pd7KRF6JMS9DPrZ/W6hFDZ8SOy2LhFG7YVKhQ5pd3FpEz+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="290943484"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="290943484"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 09:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="692312968"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2022 09:58:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJHhF-000HTV-1t;
        Wed, 03 Aug 2022 16:58:13 +0000
Date:   Thu, 4 Aug 2022 00:57:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Schspa Shi <schspa@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        linux-doc@vger.kernel.org
Subject: fs/btrfs/zstd.c:98: warning: This comment starts with '/**', but
 isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202208040057.KEoGGTvs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2b542100719a93f8cdf6d90185410d38a57a4c1
commit: dd7382a2a7da91a475703810a87a80d6eae14645 btrfs: use non-bh spin_lock in zstd timer callback
date:   3 months ago
config: hexagon-randconfig-r002-20220803 (https://download.01.org/0day-ci/archive/20220804/202208040057.KEoGGTvs-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 495519e5f8232d144ed26e9c18dbcbac6a5f25eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd7382a2a7da91a475703810a87a80d6eae14645
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd7382a2a7da91a475703810a87a80d6eae14645
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
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
