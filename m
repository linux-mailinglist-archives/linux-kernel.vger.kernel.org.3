Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890024CAB22
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbiCBRIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiCBRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:08:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C31CDBA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646240842; x=1677776842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CgIe1kHyv6NI9EgUPct1h95cPeTgztF8ec5o6Q6LPYM=;
  b=k65FWj57O3gvEjeaQepVjjpwfpU/DCDJIViRJXk/E0bUy47MiRmdZAe2
   /xa74ylkoyN8L4Ypvns03yMBd6FZSmPx6zKNkd/I4ErYiyZX9WwQLcjqH
   XSrUeBmEHF+W8kKaZjeW1M6E+o+Gc2fTDUyHZPSKcHFE+HFfZJo2ed6MR
   07TeYeuSB2I2PMZaONuSASfiZifrw7zKtjETCn1NKMFQtizklHZjLwpoA
   u7V+qP2UeVVULmTy7BP88FGpiN3OACmkI85rOvjEUcwxdNLBRPLv7NWOx
   OCkBhYjcUkPkYay6g7Zyf5ODPkOyY3a4ROnUpfJpxsyiO3hritIrR0BFV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316665026"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="316665026"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:04:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="576174436"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2022 09:04:16 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPSOd-0001cs-Qj; Wed, 02 Mar 2022 17:04:15 +0000
Date:   Thu, 3 Mar 2022 01:04:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Benedict Wong <benedictwong@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Eyal Birger <eyal.birger@gmail.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.9-q-release
 5921/9999] net/xfrm/xfrm_interface.c:739:13: warning: no previous
 declaration for 'xfrmi_get_link_net'
Message-ID: <202203030039.jNXm03Zp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steffen,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.9-q-release
head:   4be78b108a3a1d1ffbc2367c5a45855715451482
commit: f5bb9e918c9307843fbb8e6943ebfcdcac08d2f2 [5921/9999] BACKPORT: xfrm: Add virtual xfrm interfaces
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20220303/202203030039.jNXm03Zp-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/f5bb9e918c9307843fbb8e6943ebfcdcac08d2f2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.9-q-release
        git checkout f5bb9e918c9307843fbb8e6943ebfcdcac08d2f2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/xfrm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kasan.h:4:0,
                    from include/linux/slab.h:118,
                    from include/linux/textsearch.h:8,
                    from include/linux/skbuff.h:30,
                    from include/linux/icmp.h:20,
                    from net/xfrm/xfrm_interface.c:16:
   include/linux/sched.h:1260:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
>> net/xfrm/xfrm_interface.c:739:13: warning: no previous declaration for 'xfrmi_get_link_net' [-Wmissing-declarations]
    struct net *xfrmi_get_link_net(const struct net_device *dev)
                ^~~~~~~~~~~~~~~~~~


vim +/xfrmi_get_link_net +739 net/xfrm/xfrm_interface.c

   738	
 > 739	struct net *xfrmi_get_link_net(const struct net_device *dev)
   740	{
   741		struct xfrm_if *xi = netdev_priv(dev);
   742	
   743		return dev_net(xi->phydev);
   744	}
   745	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
