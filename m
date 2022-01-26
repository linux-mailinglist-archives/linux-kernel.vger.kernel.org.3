Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0B49C5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbiAZJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:11:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:40662 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbiAZJLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643188305; x=1674724305;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PvvtYfl2HUF46D+WyYOGZGq53eSaKPGzv5SscntUonM=;
  b=Oxninn7GC9R/XgYXxB8+SyHrr+JRJ7yo/7h4iwEsr6WXniv5tSm4c9JX
   /PIRyvolZglOyPs2oq8ExXg8b4OsgmQksjMys9H+YeJbiVbGlr+WZ0c9R
   sgTHkYTKRBWh5GxRHlruaVznWIccCKm/GVtHlvbOkTLBUcWtbOm1wUDx6
   1iTkSTb3q2CdzkShJQdn/JxsZ/4uYUH2tfaTOlFTnp2EwKDS1tyE2+zej
   hL1mPyMEfzwURTOfDzhA/DDDZCY3eWuwq+inORvmpDIzFLIAwrqWQJCFy
   Br+UxkUJWPw+B8O1WieKz+flFjp7z+oKsMIxjpuQ5x8KJ4LOTOPzgvn9l
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309826862"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="309826862"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 01:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="535112572"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2022 01:11:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCeL9-000L1f-SF; Wed, 26 Jan 2022 09:11:43 +0000
Date:   Wed, 26 Jan 2022 17:11:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 84/137] drivers/acpi/arm64/mpam.c:244:12:
 warning: no previous prototype for 'acpi_mpam_parse'
Message-ID: <202201261729.TYtOlqcK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: b841feb1820b7008977aa2684994b5debe450b18 [84/137] ACPI / MPAM: Parse the MPAM table
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201261729.TYtOlqcK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=b841feb1820b7008977aa2684994b5debe450b18
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout b841feb1820b7008977aa2684994b5debe450b18
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/arm64/ drivers/platform/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/arm64/mpam.c:244:12: warning: no previous prototype for 'acpi_mpam_parse' [-Wmissing-prototypes]
     244 | int __init acpi_mpam_parse(void)
         |            ^~~~~~~~~~~~~~~


vim +/acpi_mpam_parse +244 drivers/acpi/arm64/mpam.c

   243	
 > 244	int __init acpi_mpam_parse(void)
   245	{
   246		struct acpi_table_header *mpam;
   247		acpi_status status;
   248		int err;
   249	
   250		if (acpi_disabled || !mpam_cpus_have_feature())
   251			return 0;
   252	
   253		status = acpi_get_table(ACPI_SIG_MPAM, 0, &mpam);
   254		if (ACPI_FAILURE(status))
   255			return -ENOENT;
   256	
   257		err = _parse_table(mpam);
   258		acpi_put_table(mpam);
   259	
   260		return err;
   261	}
   262	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
