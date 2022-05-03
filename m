Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE1517C48
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiECDmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiECDmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:42:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A113C4AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651549158; x=1683085158;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qsSxSoixTolxl3cYXyNTDeVmDSh0PrMwxNVUbGZ6qb4=;
  b=Z5MigZtGzf7wtm0qMAlMbEw02Qt9X9LKWBJN1Q79nR3o2wCUDRWuzoqj
   nwYjP6LvBy89uy9SKKb0v5aOl8A+g6kOMRw2eTNXV89ZiqaFj+ARgAzm7
   ldoZH60fHEWxRyVd21GrC40UZOZDjdyMdlNjs69dVZ4KUrUTnqYhWZ9dd
   PFFHT956QsodrzyyzO3YD8KmUlhVcKjcHM7LA7+ex3OC6lPVFMLSK/iEe
   9H1Pe7PMPrpib8S1UoibGLOmg7J8Vam+MiUllR7jB6/yA0QBKIRDJJSO/
   pFhLFdVJr3CM8eo+mOdjLnEk/6ceIb+JQTSQDw21HWGIU3WKbg+lbgSOb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="254850566"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="254850566"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 20:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="546972078"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2022 20:39:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nljNb-000A7v-T7;
        Tue, 03 May 2022 03:39:15 +0000
Date:   Tue, 3 May 2022 11:38:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 31/32] ERROR: modpost:
 "acpi_register_lps0_dev" [drivers/platform/x86/thinkpad_acpi.ko] undefined!
Message-ID: <202205031133.L8N6SZbu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   acbb6b34258ea867c21d47ab53934ef9dbc442a0
commit: a50dfa903391d542025a92c92606425fbccc8323 [31/32] platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of laptops
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20220503/202205031133.L8N6SZbu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=a50dfa903391d542025a92c92606425fbccc8323
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout a50dfa903391d542025a92c92606425fbccc8323
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "acpi_register_lps0_dev" [drivers/platform/x86/thinkpad_acpi.ko] undefined!
>> ERROR: modpost: "acpi_unregister_lps0_dev" [drivers/platform/x86/thinkpad_acpi.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
