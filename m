Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06563581C63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiGZXX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiGZXXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:23:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67622127E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658877803; x=1690413803;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8FV2pkOGXJlVvvGq9dFBaKk8h+o74EtM6qshyOqHOXE=;
  b=e+zo+LNwtUxZk48tJ2/3/iBYFxd0WuG6AQEdRkoJo57Rhautx6ymViCO
   zYS91TQbZTpBys/o24oyiyxMkhhgCAjnxgQa31cpvkAN5hjRw1ijBv6D2
   SiAQTfUpeWdBx8+9pSbtYAjusRHEBzXCqA5ng1eDgFTjIOpR8j2YOtuf8
   ZIDecJ0GwFTp24XW1wGZLnFMbeD4E02ANMyco0Pa0u2FaO8JWaxBq05Lc
   FezoBxeM33lAWE+JOEViG+FPlzPOTSybU6y5ITPkszm/aeeBHJtZzrPGN
   01xd6JZgra3PD/d/pl9Ya7CdkgyiqI9IyWwFEbofogf9o1Qeujh3mpPDf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="374396186"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="374396186"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 16:23:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="668106490"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2022 16:23:22 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGTtZ-0007yE-2O;
        Tue, 26 Jul 2022 23:23:21 +0000
Date:   Wed, 27 Jul 2022 07:23:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Faycal Benmlih <faycal.benmlih@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/platform/x86/socwatch/sw_pmt.c:232:8: sparse: sparse: symbol
 's_endpoint_index' was not declared. Should it be static?
Message-ID: <202207270752.rRUYdUH1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_10
head:   c55df4a2b60fc7c6c4d00fd9f9fb447087833513
commit: cd0ae8e45c3cc66d1cfb9bfc5046d6a1e9b04d19 SEP/SOCWATCH Update SoCWatch driver after rebasing to linux v5.7
date:   1 year, 10 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220727/202207270752.rRUYdUH1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/mchinth/linux/commit/cd0ae8e45c3cc66d1cfb9bfc5046d6a1e9b04d19
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_10
        git checkout cd0ae8e45c3cc66d1cfb9bfc5046d6a1e9b04d19
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/socwatch/sw_pmt.c:232:8: sparse: sparse: symbol 's_endpoint_index' was not declared. Should it be static?
--
>> drivers/platform/x86/socwatch/sw_pci.c:64:6: sparse: sparse: symbol 'sw_print_pci_devices_i' was not declared. Should it be static?

vim +/s_endpoint_index +232 drivers/platform/x86/socwatch/sw_pmt.c

4f5db8d9f7a900 drivers/platform/x86/socwatch/sw_cta.c Faycal Benmlih 2019-10-15  224  
4f5db8d9f7a900 drivers/platform/x86/socwatch/sw_cta.c Faycal Benmlih 2019-10-15  225  /* *********************************
cd0ae8e45c3cc6 drivers/platform/x86/socwatch/sw_pmt.c Faycal Benmlih 2020-05-01  226   * End PMT driver import
4f5db8d9f7a900 drivers/platform/x86/socwatch/sw_cta.c Faycal Benmlih 2019-10-15  227   * *********************************
4f5db8d9f7a900 drivers/platform/x86/socwatch/sw_cta.c Faycal Benmlih 2019-10-15  228   */
4f5db8d9f7a900 drivers/platform/x86/socwatch/sw_cta.c Faycal Benmlih 2019-10-15  229  
cd0ae8e45c3cc6 drivers/platform/x86/socwatch/sw_pmt.c Faycal Benmlih 2020-05-01  230  #define MAX_TELEM_ENDPOINTS MAX_AGGR_TELEM_ENDPOINTS /* For now */
4f5db8d9f7a900 drivers/platform/x86/socwatch/sw_cta.c Faycal Benmlih 2019-10-15  231  static struct telem_endpoint *s_telem_endpoints[MAX_TELEM_ENDPOINTS]; /* TODO: make this a linked list instead */
4f5db8d9f7a900 drivers/platform/x86/socwatch/sw_cta.c Faycal Benmlih 2019-10-15 @232  size_t s_endpoint_index = 0;
4f5db8d9f7a900 drivers/platform/x86/socwatch/sw_cta.c Faycal Benmlih 2019-10-15  233  

:::::: The code at line 232 was first introduced by commit
:::::: 4f5db8d9f7a900abd8cc574d4852045bca86c31f platform/x86: Update SoCWatch driver for 5.4 pull

:::::: TO: Faycal Benmlih <faycal.benmlih@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
