Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6184FCCBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbiDLC4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343671AbiDLC4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:56:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E713D46;
        Mon, 11 Apr 2022 19:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649732073; x=1681268073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZ03kDMABJJZI0UrTuqW+R10I6D2dFdE0aD6w2mgkEE=;
  b=PMctmlVmACmfBs7STF1Ly2d4507Ep1bJLa72/lQnLyuN2ab40oxMEavp
   qFNgUyDJEC51Vm55krE8hseVxldlAByGMf8bR0CKG9JPwYRcJzn3T6YUA
   IBe1hFGhVFMZhBZr8hHy2Pm4Txp2LtS8UJDhzr7kg2F2Xks1pMaA+Gfrn
   J/69Zu/jvFK4vmEmtScJMYngpEXf5XXbRWOAUFPgIhcZlE95ke5g9Haof
   eiHkj7X4Au5qDf2o2mpNOATjCmiKk5NObDfHZFSOWkG69cAie9qFD6Mdi
   FjdHd6vxYqnba70yx7NMfg9DsoVxgDOyfQZLEPxfcH7CN9J7zDsAeINmm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261110559"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261110559"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 19:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="507360781"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2022 19:54:31 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne6fm-0002SA-F0;
        Tue, 12 Apr 2022 02:54:30 +0000
Date:   Tue, 12 Apr 2022 10:53:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH 14/20] ACPICA: executer/exsystem: Inform users about ACPI
 spec violation
Message-ID: <202204121052.HOrN6tpw-lkp@intel.com>
References: <22622452.6Emhk5qWAg@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22622452.6Emhk5qWAg@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Rafael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master linux/master v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-J-Wysocki/ACPICA-ACPICA-20220331/20220412-030922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-a006-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121052.HOrN6tpw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5cdc6166cc35043a80f5f328d6e6b58190c4e46c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rafael-J-Wysocki/ACPICA-ACPICA-20220331/20220412-030922
        git checkout 5cdc6166cc35043a80f5f328d6e6b58190c4e46c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-review/Rafael-J-Wysocki/ACPICA-ACPICA-20220331/20220412-030922 HEAD 32181ae3d3173aeee41f709612dfa4d52951b39d builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> drivers/acpi/acpica/exsystem.c:140:7: error: use of undeclared identifier 'how_long_US'; did you mean 'how_long_us'?
                   if (how_long_US > 100) {
                       ^~~~~~~~~~~
                       how_long_us
   drivers/acpi/acpica/exsystem.c:123:41: note: 'how_long_us' declared here
   acpi_status acpi_ex_system_do_stall(u32 how_long_us)
                                           ^
   1 error generated.


vim +140 drivers/acpi/acpica/exsystem.c

   105	
   106	/*******************************************************************************
   107	 *
   108	 * FUNCTION:    acpi_ex_system_do_stall
   109	 *
   110	 * PARAMETERS:  how_long_us     - The amount of time to stall,
   111	 *                                in microseconds
   112	 *
   113	 * RETURN:      Status
   114	 *
   115	 * DESCRIPTION: Suspend running thread for specified amount of time.
   116	 *              Note: ACPI specification requires that Stall() does not
   117	 *              relinquish the processor, and delays longer than 100 usec
   118	 *              should use Sleep() instead. We allow stalls up to 255 usec
   119	 *              for compatibility with other interpreters and existing BIOSs.
   120	 *
   121	 ******************************************************************************/
   122	
   123	acpi_status acpi_ex_system_do_stall(u32 how_long_us)
   124	{
   125		acpi_status status = AE_OK;
   126	
   127		ACPI_FUNCTION_ENTRY();
   128	
   129		if (how_long_us > 255) {
   130			/*
   131			 * Longer than 255 microseconds, this is an error
   132			 *
   133			 * (ACPI specifies 100 usec as max, but this gives some slack in
   134			 * order to support existing BIOSs)
   135			 */
   136			ACPI_ERROR((AE_INFO,
   137				    "Time parameter is too large (%u)", how_long_us));
   138			status = AE_AML_OPERAND_VALUE;
   139		} else {
 > 140			if (how_long_US > 100) {
   141				ACPI_WARNING((AE_INFO,
   142					      "Time parameter %u us > 100 us violating ACPI spec, please fix the firmware.",
   143					      how_long_us));
   144			}
   145			acpi_os_stall(how_long_us);
   146		}
   147	
   148		return (status);
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
