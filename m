Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3296954E212
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377074AbiFPNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376839AbiFPNgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:36:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC1E220EB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655386562; x=1686922562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lZ7LdJzLzTp3TOQzB6WHSMJVfTKOBtpkE263PHLhVVA=;
  b=YcWi2tcO4ZEbNR0f/KFC3ZReclC7DZjpbCYWhXAGNTisz3kMFdofgQpB
   GfWIa4WV/4mfnUJwHM/GJVS8DtQMgRz0+FTqXCMiaSZiv5Ykb1O2fKJs9
   Ygqc9XOwVErhUoulaYAmnHDhoApFglN8/MzeOsDBZPUNfN0ojL4+/V6lw
   qG7jXfy2KbrftsLW26cBABHFsxjwL7jGFyiK5D5XPwsMjONGLsD35QfG/
   Zcs7KPvo4MXjENMihbCk010KXXg3X1iUPSAXhrsPHjO1TmdgVdZZbOpYp
   LnpKB3g9XbAkhEGp9iooTNhtPIOrSzaVgvY3CSv+zFpfn3pCGuRmpp1xi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="267937296"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="267937296"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="687822640"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2022 06:36:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1pfE-000OPp-Fv;
        Thu, 16 Jun 2022 13:36:00 +0000
Date:   Thu, 16 Jun 2022 21:35:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [sudeep-holla:wip/acpi_ffh_opregion 2/3] drivers/acpi/bus.c:301:6:
 sparse: sparse: symbol 'osc_sb_ffh_opregion_support_confirmed' was not
 declared. Should it be static?
Message-ID: <202206162156.TTEhmMTa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git wip/acpi_ffh_opregion
head:   aca46ad097a20fee2f395f051d575d323c15ffff
commit: 42de507063eebc8c7d728fbac4012e35c8b854df [2/3] ACPI: Implement a generic FFH Opregion handler
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220616/202206162156.TTEhmMTa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?id=42de507063eebc8c7d728fbac4012e35c8b854df
        git remote add sudeep-holla https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
        git fetch --no-tags sudeep-holla wip/acpi_ffh_opregion
        git checkout 42de507063eebc8c7d728fbac4012e35c8b854df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/bus.c:301:6: sparse: sparse: symbol 'osc_sb_ffh_opregion_support_confirmed' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
