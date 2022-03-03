Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEDD4CB7FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiCCHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiCCHig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:38:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF160DD97C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646293070; x=1677829070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3m0xlW4G3N4NYJBnqvRxXN+aZNtQxm1Juf0w1u73FM4=;
  b=Ac7GOvADfy3Jkoa/Ty/fkdkVzo6lgOX05HgXQspBsSJ+/AJufuGFqrSJ
   OxYCSGmQE9fmSELftu5e63zrBuojtzrO3HOpWqcMC/tad7r4pV1UMFswj
   +UmHufpHa38Hyd5cnO84PAtoR0TxhnJjLkyNsJeW32+RjDZy48L+p1Ez9
   szTloytI3PYfnhwBrxGk4Qn9/BwLlhX2qgTdA3dJ0ptP/8S4uzmclMniv
   8rOcqmfzpJHUl5m83XI2+g+vNbrL7pjcnbtaROVs5svxe8HHzVkCq1ZIK
   Of2zjjLnx4eTo6vYNGX+TUGS8C6Dl8Eakfhu6XrfVbxNCpO/ZY7+fyIqf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253792643"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253792643"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 23:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="709819180"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2022 23:37:48 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPg1z-0000H2-61; Thu, 03 Mar 2022 07:37:47 +0000
Date:   Thu, 3 Mar 2022 15:37:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Connor O'Brien <connoro@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-stable
 640/9999] kernel/bpf/core.c:1500:31: sparse: sparse: incorrect type in
 return expression (different address spaces)
Message-ID: <202203031539.NvXuofDv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-stable
head:   4ab5bac1598e3ed91a6267f6cada336467312112
commit: 9e61c87b1f47b4dc3d48de83d85e9f17c320f91e [640/9999] UPSTREAM: bpf: multi program support for cgroup+bpf
config: i386-randconfig-s001-20211019 (https://download.01.org/0day-ci/archive/20220303/202203031539.NvXuofDv-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/9e61c87b1f47b4dc3d48de83d85e9f17c320f91e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-stable
        git checkout 9e61c87b1f47b4dc3d48de83d85e9f17c320f91e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/bpf/core.c:1095:43: sparse: sparse: arithmetics on pointers to functions
>> kernel/bpf/core.c:1500:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct bpf_prog_array [noderef] <asn:4> * @@     got void * @@
   kernel/bpf/core.c:1500:31: sparse:     expected struct bpf_prog_array [noderef] <asn:4> *
   kernel/bpf/core.c:1500:31: sparse:     got void *
>> kernel/bpf/core.c:1504:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct bpf_prog_array [noderef] <asn:4> * @@     got struct bpf_prog_array * @@
   kernel/bpf/core.c:1504:17: sparse:     expected struct bpf_prog_array [noderef] <asn:4> *
   kernel/bpf/core.c:1504:17: sparse:     got struct bpf_prog_array *
   kernel/bpf/core.c:1512:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] <asn:4> * @@
   kernel/bpf/core.c:1512:9: sparse:     expected struct callback_head *head
   kernel/bpf/core.c:1512:9: sparse:     got struct callback_head [noderef] <asn:4> *

vim +1500 kernel/bpf/core.c

  1496	
  1497	struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
  1498	{
  1499		if (prog_cnt)
> 1500			return kzalloc(sizeof(struct bpf_prog_array) +
  1501				       sizeof(struct bpf_prog *) * (prog_cnt + 1),
  1502				       flags);
  1503	
> 1504		return &empty_prog_array.hdr;
  1505	}
  1506	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
