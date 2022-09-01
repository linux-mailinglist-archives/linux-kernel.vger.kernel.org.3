Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234D5AA104
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiIAUmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIAUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:42:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41EB79A4E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662064919; x=1693600919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UTrSzcsF7PCYUTH4D0eI8mkVOvcpLFcC14kgCZOebSQ=;
  b=hfd6bFJVxjdQMJuRSHRsRoYrYJZ3h2wZYeBZiRTsipfje3KjlWkGYjGr
   UqpWYTzqNbcO6OiaIk9RDlDTqPhgS2l2o/ZPmQ/NAW8f3DeHy0qNusmwb
   RJJeV5dzGXdUgQzgzqEMzRHOuYIl1FNhYGPY9C4Razts7S7OkOflk+BlE
   FS21YMTtd9lfmL81Xgq6fvIFbqQWPy+3iB9+/uPBulILVepc5kPszRmhR
   XRLjuv2+a+N/E70rFrrdjMEdArbyAOiwGoRrZuBiPj+6W7IaWTn+3T6v8
   ZQOb+SwedXjxNfiWqOZHb0VxVZmAXcFp5SbfE51g7mj7wzxrS8bJnKph3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="297107454"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="297107454"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589702563"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 13:41:56 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTr0e-0000kf-0g;
        Thu, 01 Sep 2022 20:41:56 +0000
Date:   Fri, 2 Sep 2022 04:41:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: drivers/acpi/x86/apple.c:30:6: warning: no previous declaration for
 'acpi_extract_apple_properties'
Message-ID: <202209020412.Ts31BZrs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42e66b1cc3a070671001f8a1e933a80818a192bf
commit: 899596e090ea21918c55cbccea594be840af44ea ACPI / property: Support Apple _DSM properties
date:   5 years ago
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220902/202209020412.Ts31BZrs-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=899596e090ea21918c55cbccea594be840af44ea
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 899596e090ea21918c55cbccea594be840af44ea
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/ arch/x86/kvm/ drivers/acpi/ virt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/x86/apple.c:30:6: warning: no previous declaration for 'acpi_extract_apple_properties' [-Wmissing-declarations]
    void acpi_extract_apple_properties(struct acpi_device *adev)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/acpi_extract_apple_properties +30 drivers/acpi/x86/apple.c

    14	
    15	/* Apple _DSM device properties GUID */
    16	static const guid_t apple_prp_guid =
    17		GUID_INIT(0xa0b5b7c6, 0x1318, 0x441c,
    18			  0xb0, 0xc9, 0xfe, 0x69, 0x5e, 0xaf, 0x94, 0x9b);
    19	
    20	/**
    21	 * acpi_extract_apple_properties - retrieve and convert Apple _DSM properties
    22	 * @adev: ACPI device for which to retrieve the properties
    23	 *
    24	 * Invoke Apple's custom _DSM once to check the protocol version and once more
    25	 * to retrieve the properties.  They are marshalled up in a single package as
    26	 * alternating key/value elements, unlike _DSD which stores them as a package
    27	 * of 2-element packages.  Convert to _DSD format and make them available under
    28	 * the primary fwnode.
    29	 */
  > 30	void acpi_extract_apple_properties(struct acpi_device *adev)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
