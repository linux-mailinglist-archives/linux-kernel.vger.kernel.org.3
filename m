Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C144D3ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiCJBks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiCJBkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:40:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675456C935
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646876387; x=1678412387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GXyw24t9S6s0GTQgiC3rxZJAVgMfm6NGFt4A01bJz6k=;
  b=fWJBR0WTzYbLbAsnQdaEyCMOYHj850SLTkWOgunhM9n5qO5isxVOYxcm
   n4XuIQXP1Xz5w3UngjW0t0AuYgWZn1dtafTW+52c3H7NHbjYo+ayWJ3Co
   HvW/d+pF19Gy/agMNmHX28MnKVyBSXjJ5WZEj6eADqjX9oq+AhvrhfFU9
   tRh0JkuAYO4GEbudttXWMO9mJfSZyAKkLzbEC/MeSpQYKVlpIfC8QEb9A
   3cc3vVLGB/5v0sMjzccli2Cac7saHk0+TsQlx1+1d7wMgVAOxzJ0UJ0HH
   RsF3HuSM9bx4SC13ZKJZLPE6h7rDDNKszY6vKFM0NYmrFFdBICPNQEY0p
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235742452"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="235742452"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="513779559"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2022 17:39:45 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS7mK-00049M-RC; Thu, 10 Mar 2022 01:39:44 +0000
Date:   Thu, 10 Mar 2022 09:38:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Delva <adelva@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 47/9999] drivers/gpu/drm/drm_dp_mst_topology.c:1843
 drm_dp_mst_update_dsc_info() warn: inconsistent indenting
Message-ID: <202203100907.5COiye7E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   3fba6c6e70994eff4dcc5be475c9d2bd3848b83d
commit: b572376bedc67f334d005dabd7727dd318eeba44 [47/9999] ANDROID: GKI: Add 'dsc_info' to struct drm_dp_mst_port
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220310/202203100907.5COiye7E-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/gpu/drm/drm_dp_mst_topology.c:1843 drm_dp_mst_update_dsc_info() warn: inconsistent indenting

vim +1843 drivers/gpu/drm/drm_dp_mst_topology.c

  1830	
  1831	int drm_dp_mst_update_dsc_info(struct drm_dp_mst_topology_mgr *mgr,
  1832			struct drm_dp_mst_port *port,
  1833			struct drm_dp_mst_dsc_info *dsc_info)
  1834	{
  1835		if (!dsc_info)
  1836			return -EINVAL;
  1837	
  1838		port = drm_dp_get_validated_port_ref(mgr, port);
  1839		if (!port)
  1840			return -EINVAL;
  1841	
  1842		memcpy(&port->dsc_info, dsc_info, sizeof(struct drm_dp_mst_dsc_info));
> 1843			drm_dp_put_port(port);
  1844	
  1845		return 0;
  1846	}
  1847	EXPORT_SYMBOL_GPL(drm_dp_mst_update_dsc_info);
  1848	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
