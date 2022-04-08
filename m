Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E54F9C17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiDHR7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiDHR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:59:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F41110FAD2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649440621; x=1680976621;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T0bWQ5abTairCRnQxQX6+JL8QxYCGJDKinCflGG4JXE=;
  b=bODbdUjHoNsj22UVUdpgzLB6DEUuTpouEF7GmklqA7RIE260GzWRXw/Y
   yc7f0WGDHGZEsyJZTrAzu8lkMqLN6kqe0LdLDKTWREdVXICGMiaEHIidD
   MggAoDSvdnH4UTYapQm2yF5Z5uw9iYWsCEzN3vihoJY/IurYSZUQwX3hZ
   9Y4uj4fhvTciDdwoqYrn9TdnZ9hv5JZxi5lY/fWMT+SFBzsoMbNEN7nCP
   0iKWe9S/14hOHnWdzamC1J00tYzHQPtM91N+lA6uaVYUkbwQYkV3Xx9wC
   PbCElOigH/HTbFdpMZcG6aqHYEaq4ILa1qJ1cVU2chZ0lAEP2AyB2O0ah
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261644540"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261644540"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="723476017"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2022 10:56:59 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncsqw-0000WH-Ka;
        Fri, 08 Apr 2022 17:56:58 +0000
Date:   Sat, 9 Apr 2022 01:56:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: drivers/firmware/efi/capsule-loader.c:84:12: warning: no previous
 declaration for 'efi_capsule_setup_info'
Message-ID: <202204090125.wgI0L7F3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1831fed559732b132aef0ea8261ac77e73f7eadf
commit: 3fabd628d5ea24b02ddb1230ffca1df0f779f84e efi/capsule-loader: Redirect calls to efi_capsule_setup_info() via weak alias
date:   4 years, 10 months ago
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220409/202204090125.wgI0L7F3-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fabd628d5ea24b02ddb1230ffca1df0f779f84e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3fabd628d5ea24b02ddb1230ffca1df0f779f84e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/platform/efi/ drivers/firmware/efi/ drivers/net/dsa/ fs/f2fs/ fs/xfs/ net/sunrpc/xprtrdma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/capsule-loader.c:84:12: warning: no previous declaration for 'efi_capsule_setup_info' [-Wmissing-declarations]
    int __weak efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
               ^~~~~~~~~~~~~~~~~~~~~~


vim +/efi_capsule_setup_info +84 drivers/firmware/efi/capsule-loader.c

    72	
    73	/**
    74	 * efi_capsule_setup_info - obtain the efi capsule header in the binary and
    75	 *			    setup capsule_info structure
    76	 * @cap_info: pointer to current instance of capsule_info structure
    77	 * @kbuff: a mapped first page buffer pointer
    78	 * @hdr_bytes: the total received number of bytes for efi header
    79	 *
    80	 * Platforms with non-standard capsule update mechanisms can override
    81	 * this __weak function so they can perform any required capsule
    82	 * image munging. See quark_quirk_function() for an example.
    83	 **/
  > 84	int __weak efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
    85					  size_t hdr_bytes)
    86	{
    87		/* Only process data block that is larger than efi header size */
    88		if (hdr_bytes < sizeof(efi_capsule_header_t))
    89			return 0;
    90	
    91		memcpy(&cap_info->header, kbuff, sizeof(cap_info->header));
    92		cap_info->total_size = cap_info->header.imagesize;
    93	
    94		return __efi_capsule_setup_info(cap_info);
    95	}
    96	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
