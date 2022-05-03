Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74110518C47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbiECS2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiECS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:27:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6CF3EF20
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651602263; x=1683138263;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1NimRXR5w2gE8Cm6XyyDPk8nK+QWl2C1Ah3ld0TAn30=;
  b=kAxek5jfOn9W3WvXEObj20rrshaNVCCqLL1JPe6ErAvlErXylwG+LAFC
   UujEJpO++h6BE947xrDHNhzu3pGK0JN0mN7kxzwrWp9iWsdGDrMLOOVAq
   wZh5sBDshJIqtmy3eWtuThAtXvkhrJVx/lFYkqHY83I03rgQGP2cES63q
   UHTPXRb7aE5Th3fjnrn+khAP8i5jcTQjQf/LiGqyB7ncmv8ShfOxW9qtG
   FrUVyaGFimjtoeX8/m5SDbNzHujzrzNWO7dFSS4FlanhM0gzBbxa6XUCC
   FaSFmi1MkIo4YtY8/5WW1BeV/R9X2XSmMHeO8NKiu5vldcnwVI8+jTIcT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="249533208"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="249533208"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 11:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="734028828"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2022 11:24:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlxC8-000Ahd-Sc;
        Tue, 03 May 2022 18:24:20 +0000
Date:   Wed, 4 May 2022 02:24:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 31/32]
 drivers/platform/x86/thinkpad_acpi.c:322:20: sparse: sparse: symbol
 'quirk_s2idle_bug' was not declared. Should it be static?
Message-ID: <202205040241.QemV1sMH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   acbb6b34258ea867c21d47ab53934ef9dbc442a0
commit: a50dfa903391d542025a92c92606425fbccc8323 [31/32] platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of laptops
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220504/202205040241.QemV1sMH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=a50dfa903391d542025a92c92606425fbccc8323
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout a50dfa903391d542025a92c92606425fbccc8323
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/platform/x86/thinkpad_acpi.c:318:20: sparse: sparse: symbol 'quirk_btusb_bug' was not declared. Should it be static?
>> drivers/platform/x86/thinkpad_acpi.c:322:20: sparse: sparse: symbol 'quirk_s2idle_bug' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
