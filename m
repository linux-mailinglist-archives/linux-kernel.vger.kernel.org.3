Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48195A3494
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiH0Ejp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiH0Ejn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:39:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D8B4EB6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 21:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661575180; x=1693111180;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BDyTjUE0L/pHyGEn6bRR3ywSmB0bCXV599TPxm9nzpc=;
  b=AJh1pyvA5c98GdoIvAQMqSymG4IctWGmM0O13ApgDaJGc0/u1Y7sd0YH
   n2g0HV8XaLRcrB0jdb8peBd9spZpLnDo9fELIjjwaGGLn2UvWrSOOBQAl
   1IOdlo8qQ2yYVnR8v79pe4zFTBy+6rMr8bVELNS/XpvZjOBvPEkUBnYOG
   uNAQtkqRQWpAHqUsL2HFCvNS9HhPH9qeOER82oyOGQlp+fNn5PF0aVCnG
   Iyeaz+fulJ+Q37WmbpESjih6CfbZXej64tMKRwALcky6KzVTEkutHgRMw
   M/JpZ/L6fw0IKDi+E2i1OLTJkRIGOAYEL1kJCouxjNTFEzYVNGITvtRfd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="277650792"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="277650792"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 21:39:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="643884396"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Aug 2022 21:39:38 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRnbd-0000zt-18;
        Sat, 27 Aug 2022 04:39:37 +0000
Date:   Sat, 27 Aug 2022 12:39:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: kismet: WARNING: unmet direct dependencies detected for CRYPTO_GCM
 when selected by SEV_GUEST
Message-ID: <202208271202.7RGnCXCY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e022620b5d056e822e42eb9bc0f24fcb97389d86
commit: fce96cf0443083e37455eff8f78fd240c621dae3 virt: Add SEV-SNP guest driver
date:   5 months ago
config: x86_64-kismet-CONFIG_CRYPTO_GCM-CONFIG_SEV_GUEST-0-0 (https://download.01.org/0day-ci/archive/20220827/202208271202.7RGnCXCY-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fce96cf0443083e37455eff8f78fd240c621dae3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fce96cf0443083e37455eff8f78fd240c621dae3
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_CRYPTO_GCM --selectors CONFIG_SEV_GUEST -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CRYPTO_GCM when selected by SEV_GUEST
   
   WARNING: unmet direct dependencies detected for CRYPTO_GCM
     Depends on [n]: CRYPTO [=n]
     Selected by [y]:
     - SEV_GUEST [=y] && VIRT_DRIVERS [=y] && AMD_MEM_ENCRYPT [=y]
   
   WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
     Depends on [n]: CRYPTO [=n]
     Selected by [y]:
     - SEV_GUEST [=y] && VIRT_DRIVERS [=y] && AMD_MEM_ENCRYPT [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
