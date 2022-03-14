Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB974D8AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbiCNRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbiCNRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:36:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A99FC7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647279332; x=1678815332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0V5PxXs4rysOGClpalbI+15QZlt52WVH1UhdqXGq8Rs=;
  b=T26a45+LqR6cxCo2J59SGDKljEAu5oYprnmvUFXDTpDHDemrXbs/Hv8p
   vM3JD9IqsZ42jRow0cJOMLArwUCitlebxO2podK7V0hDXQwDp1bdQajEi
   G0V1tAAw3hwAK7u8GIFKIYRQZmg2EdnNiN96lFW/6zFoIgUe6IKx5pkQI
   EoUTJwCicebgY3HsG4HZX/LHXypjVMG3ON7ZmjdrPvEk6gZiP1un+9Dzc
   7svn33jrs49gFf8v82rJjEt7m3EsFGwfVLr1WWTmKWXjopQTRBzXLfzB+
   GNyirNvWoPoOP5SzS5KMa4kOoiPrjJUYxzuuRRoG274pVNkD/AqTpkjqB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="253654307"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="253654307"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 10:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="713805287"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Mar 2022 10:35:20 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTob8-000A4j-1l; Mon, 14 Mar 2022 17:35:10 +0000
Date:   Tue, 15 Mar 2022 01:34:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhengding chen <chenzhengding@oppo.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10
 2348/9999] drivers/android/binder.c:1373:70: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202203150146.7GOxXHYj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10
head:   f3ca80cced4e447653b51be876c026c337d84702
commit: 35014985c266face161f6d107f8d8338e02a0b2d [2348/9999] ANDROID: vendor_hooks: Add hooks for binder proc transaction
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220315/202203150146.7GOxXHYj-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/35014985c266face161f6d107f8d8338e02a0b2d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10
        git checkout 35014985c266face161f6d107f8d8338e02a0b2d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/android/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/android/binder.c:1373:70: sparse: sparse: Using plain integer as NULL pointer
   drivers/android/binder.c:2508:41: sparse: sparse: Using plain integer as NULL pointer
   drivers/android/binder.c:4580:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   drivers/android/binder.c:4580:24: sparse:     expected restricted __poll_t
   drivers/android/binder.c:4580:24: sparse:     got int

vim +1373 drivers/android/binder.c

  1363	
  1364	/**
  1365	 * binder_free_ref() - free the binder_ref
  1366	 * @ref:	ref to free
  1367	 *
  1368	 * Free the binder_ref. Free the binder_node indicated by ref->node
  1369	 * (if non-NULL) and the binder_ref_death indicated by ref->death.
  1370	 */
  1371	static void binder_free_ref(struct binder_ref *ref)
  1372	{
> 1373		trace_android_vh_binder_del_ref(ref->proc ? ref->proc->tsk : 0, ref->data.desc);
  1374		if (ref->node)
  1375			binder_free_node(ref->node);
  1376		kfree(ref->death);
  1377		kfree(ref);
  1378	}
  1379	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
