Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC18C4D707A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 20:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiCLSzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiCLSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:55:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41835674E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647111280; x=1678647280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/C+X50XIym/9/G7FN2nAQTz/HBnTGMTkyOqZkGvP/vE=;
  b=Ukm31gM7Au7LX8bBtI1R5heBE8fKAghfGTR1H8zccFgwAOhBc+nK/F90
   9UgNU/24LlEDDg4sjvO9dk5sZxfrycJ9v0jSgKiFUDiSk7nW8CTglZZ0k
   mWEnCT7wSaJgAaTJYx1GbCqRmtOiMZUYPhSMnQcb8BxPCRZOWjEOXVjbN
   n9rsZlH05XIECapRN4xr7GFzMplhVqrEL6Fyibza+hivxhE4ZV+Bu7wbe
   mF4iLzG1/VJUoki+M+3ozhqV8nRCYVzll6h2DZqfy5RdYTRY+pWlxalko
   uArVUVDs7dDb6LJqO41jY2EV6TynPNECauzvj7m+bcPVOgzZBbWBCMxMr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="319040431"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="319040431"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 10:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="514923155"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2022 10:54:38 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT6sw-0008BA-3l; Sat, 12 Mar 2022 18:54:38 +0000
Date:   Sun, 13 Mar 2022 02:53:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-01
 1260/9999] drivers/base/core.c:1542:5: sparse: sparse: symbol
 'fw_devlink_relax_cycle' was not declared. Should it be static?
Message-ID: <202203130202.16VYUo7S-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-01
head:   d262b276948e382dbaa38474845bac692bae4236
commit: 1df699c140a778ed678d7d4b2fa8ffb2c62573e1 [1260/9999] UPSTREAM: driver core: Handle cycles in device links created by fw_devlink
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220313/202203130202.16VYUo7S-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/1df699c140a778ed678d7d4b2fa8ffb2c62573e1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-01
        git checkout 1df699c140a778ed678d7d4b2fa8ffb2c62573e1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/base/ drivers/dma-buf/ drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/base/core.c:1542:5: sparse: sparse: symbol 'fw_devlink_relax_cycle' was not declared. Should it be static?

vim +/fw_devlink_relax_cycle +1542 drivers/base/core.c

  1527	
  1528	/**
  1529	 * fw_devlink_relax_cycle - Convert cyclic links to SYNC_STATE_ONLY links
  1530	 * @con: Device to check dependencies for.
  1531	 * @sup: Device to check against.
  1532	 *
  1533	 * Check if @sup depends on @con or any device dependent on it (its child or
  1534	 * its consumer etc).  When such a cyclic dependency is found, convert all
  1535	 * device links created solely by fw_devlink into SYNC_STATE_ONLY device links.
  1536	 * This is the equivalent of doing fw_devlink=permissive just between the
  1537	 * devices in the cycle. We need to do this because, at this point, fw_devlink
  1538	 * can't tell which of these dependencies is not a real dependency.
  1539	 *
  1540	 * Return 1 if a cycle is found. Otherwise, return 0.
  1541	 */
> 1542	int fw_devlink_relax_cycle(struct device *con, void *sup)
  1543	{
  1544		struct device_link *link;
  1545		int ret;
  1546	
  1547		if (con == sup)
  1548			return 1;
  1549	
  1550		ret = device_for_each_child(con, sup, fw_devlink_relax_cycle);
  1551		if (ret)
  1552			return ret;
  1553	
  1554		list_for_each_entry(link, &con->links.consumers, s_node) {
  1555			if ((link->flags & ~DL_FLAG_INFERRED) ==
  1556			    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
  1557				continue;
  1558	
  1559			if (!fw_devlink_relax_cycle(link->consumer, sup))
  1560				continue;
  1561	
  1562			ret = 1;
  1563	
  1564			if (!(link->flags & DL_FLAG_INFERRED))
  1565				continue;
  1566	
  1567			pm_runtime_drop_link(link);
  1568			link->flags = DL_FLAG_MANAGED | FW_DEVLINK_FLAGS_PERMISSIVE;
  1569			dev_dbg(link->consumer, "Relaxing link with %s\n",
  1570				dev_name(link->supplier));
  1571		}
  1572		return ret;
  1573	}
  1574	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
