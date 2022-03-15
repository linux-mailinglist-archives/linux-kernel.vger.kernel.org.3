Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1904DA3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351619AbiCOUQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiCOUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:16:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91555AA7E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647375311; x=1678911311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xUG0hkzS/goC/5xJ5P5hK1fpovrTJ9ohyd+Jj2FR0m8=;
  b=BXmkftudbLENdTpRQPk0rX+OwN5EkpPbDfrYzaj8NDQy6N2hvbNv6g9U
   OAinzVEoXHu1zxVmMt/gmHVqPed4dIhyD9aNyNmLWt4I6eu8F+EXiHsVd
   uSArBQy0aJ6gzMrb1kzPM9/hmA/UJH1lw9yatX9GXQFCGAaqmJ2xrtHex
   8UGWNUG/FEcpsaTZQK9Uhq8+bw6zteAdctv/45FHA+5ydV5ul/4aHa037
   95Og/F1aL06h6fT7nPWUQ5+gTGtiZHgsxl2mD5HJyTDCH4Nf25oedeN1G
   O800ZRUOtlxC8zX0Q/yF4Mz7aKP4F/m4YtiS0Q37DIT0f9KG9P0UzFV5C
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="237021855"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="237021855"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="540596143"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2022 13:15:09 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUDZV-000BT6-6Z; Tue, 15 Mar 2022 20:15:09 +0000
Date:   Wed, 16 Mar 2022 04:14:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     hch <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/nvme/host/core.c:3629:64: error: 'ctrl' undeclared
Message-ID: <202203160425.CZRSa5uF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220315-151414/Sungup-Moon/driver-nvme-host-Support-duplicated-nsid-for-the-private-ns/20220314-191232
head:   7101b34f72a97926495a7befec1c27c502c1f792
commit: 7101b34f72a97926495a7befec1c27c502c1f792 driver/nvme/host: Support duplicated nsid for the private ns
date:   13 hours ago
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220316/202203160425.CZRSa5uF-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7101b34f72a97926495a7befec1c27c502c1f792
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220315-151414/Sungup-Moon/driver-nvme-host-Support-duplicated-nsid-for-the-private-ns/20220314-191232
        git checkout 7101b34f72a97926495a7befec1c27c502c1f792
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'nvme_find_ns_head':
>> drivers/nvme/host/core.c:3629:64: error: 'ctrl' undeclared (first use in this function)
    3629 |                 if (h->ns_id != nsid || !nvme_is_uniqueue_nsid(ctrl, head))
         |                                                                ^~~~
   drivers/nvme/host/core.c:3629:64: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/nvme/host/core.c:3629:70: error: 'head' undeclared (first use in this function)
    3629 |                 if (h->ns_id != nsid || !nvme_is_uniqueue_nsid(ctrl, head))
         |                                                                      ^~~~


vim +/ctrl +3629 drivers/nvme/host/core.c

  3615	
  3616	static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
  3617			unsigned nsid)
  3618	{
  3619		struct nvme_ns_head *h;
  3620	
  3621		lockdep_assert_held(&subsys->lock);
  3622	
  3623		list_for_each_entry(h, &subsys->nsheads, entry) {
  3624			/*
  3625			 * Private namespaces can share NSIDs under some conditions.
  3626			 * In that case we can't use the same ns_head for namespaces
  3627			 * with the same NSID.
  3628			 */
> 3629			if (h->ns_id != nsid || !nvme_is_uniqueue_nsid(ctrl, head))
  3630				continue;
  3631			if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
  3632				return h;
  3633		}
  3634	
  3635		return NULL;
  3636	}
  3637	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
