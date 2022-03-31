Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F654ED789
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiCaKIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiCaKHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:07:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704A1369CD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648721163; x=1680257163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t6rtuVex6kfLXyQePPLSELG9mI79uCe2m6zG+ykhcUY=;
  b=OsVg/zo562+qMpKd9FcukjB7QJ7fXxuFkYci1SA1cpnfAGLjEpGJd+4v
   0tSbRk1HLIHYCIH1sO6hBc38QHmqTye+1PxGISjkfUPaYzWS1YlJfLjLb
   WNOzEvj+YORfpz5zYVO4Y4nFL+l2IQx2BOd8XRg4FKpfdPgpKvYh5vlj/
   mnreFbl+CDh4Z+Bw0OJTzU1UPTeHoGnYfjYxUbLZ6dWCX4gQuoMANExn0
   wc3nMbacxivGQutzEBs4iVpjiOphEqvC02uHd+rxPt/dtzbunL50UoMV9
   g/VqG8kRXUkrN8Cp6w/R5aim05INvo6DLy13I8gO9ZC76CHCXaPpnRDlS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241935941"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="241935941"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 03:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="520396453"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Mar 2022 03:06:01 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZrgm-00009O-J8;
        Thu, 31 Mar 2022 10:06:00 +0000
Date:   Thu, 31 Mar 2022 18:05:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vishal:cxl-osc 1/3] include/linux/acpi.h:1013:55: warning: 'struct
 acpi_osc_context' declared inside parameter list will not be visible outside
 of this definition or declaration
Message-ID: <202203311740.yZ2pqEBy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vishal/linux.git cxl-osc
head:   1b14cb29c313c4288f576c2480ba62a7721a2e9b
commit: c2618c3e767f53a8a62b82eaa919082378c925e5 [1/3] acpi: add a helper for retrieving _OSC Control DWORDs
config: arc-randconfig-r031-20220331 (https://download.01.org/0day-ci/archive/20220331/202203311740.yZ2pqEBy-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vishal/linux.git/commit/?id=c2618c3e767f53a8a62b82eaa919082378c925e5
        git remote add vishal https://git.kernel.org/pub/scm/linux/kernel/git/vishal/linux.git
        git fetch --no-tags vishal cxl-osc
        git checkout c2618c3e767f53a8a62b82eaa919082378c925e5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/iio/light/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/i2c.h:13,
                    from drivers/iio/light/adjd_s311.c:15:
>> include/linux/acpi.h:1013:55: warning: 'struct acpi_osc_context' declared inside parameter list will not be visible outside of this definition or declaration
    1013 | static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
         |                                                       ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/i2c.h:13,
                    from drivers/iio/light/max44009.c:18:
>> include/linux/acpi.h:1013:55: warning: 'struct acpi_osc_context' declared inside parameter list will not be visible outside of this definition or declaration
    1013 | static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
         |                                                       ^~~~~~~~~~~~~~~~
   drivers/iio/light/max44009.c:546:34: warning: 'max44009_of_match' defined but not used [-Wunused-const-variable=]
     546 | static const struct of_device_id max44009_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~
--
   In file included from drivers/iio/light/pa12203001.c:12:
>> include/linux/acpi.h:1013:55: warning: 'struct acpi_osc_context' declared inside parameter list will not be visible outside of this definition or declaration
    1013 | static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
         |                                                       ^~~~~~~~~~~~~~~~
   drivers/iio/light/pa12203001.c:454:36: warning: 'pa12203001_acpi_match' defined but not used [-Wunused-const-variable=]
     454 | static const struct acpi_device_id pa12203001_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/iio/light/stk3310.c:10:
>> include/linux/acpi.h:1013:55: warning: 'struct acpi_osc_context' declared inside parameter list will not be visible outside of this definition or declaration
    1013 | static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
         |                                                       ^~~~~~~~~~~~~~~~
   drivers/iio/light/stk3310.c:674:36: warning: 'stk3310_acpi_id' defined but not used [-Wunused-const-variable=]
     674 | static const struct acpi_device_id stk3310_acpi_id[] = {
         |                                    ^~~~~~~~~~~~~~~
--
   In file included from drivers/iio/light/us5182d.c:12:
>> include/linux/acpi.h:1013:55: warning: 'struct acpi_osc_context' declared inside parameter list will not be visible outside of this definition or declaration
    1013 | static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
         |                                                       ^~~~~~~~~~~~~~~~
   drivers/iio/light/us5182d.c:949:36: warning: 'us5182d_acpi_match' defined but not used [-Wunused-const-variable=]
     949 | static const struct acpi_device_id us5182d_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~


vim +1013 include/linux/acpi.h

  1009	
  1010	static inline void acpi_unregister_wakeup_handler(
  1011		bool (*wakeup)(void *context), void *context) { }
  1012	
> 1013	static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
  1014	{
  1015		return 0;
  1016	}
  1017	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
