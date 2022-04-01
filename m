Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9744A4EE672
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 05:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbiDADIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 23:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244416AbiDADH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:07:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323D2193B6A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648782367; x=1680318367;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1jMhE+wlXcSrwZHUyZJJVNNkGGdZo9BkN/DGLNUMaPc=;
  b=BHhU7qTzqcVntFg30Vlljy/RGoMOfnMSqBhDra1ih1k8HA+rqNGNbSzb
   9qZVBlLiRI66lpHMiepHQ4e54gphkWZz46BwyttZQ0FdKLFKVvd0S6xfY
   /WNa7Gem5l4UdMpuIe/j+1ZEVzqZtxhxQFdNvehG3CirJbiuebfVu1ppv
   /rwTt0j+nNlaZOqstY76xWAZfGNfzUcTyGNXkQTqobo21tZXdFFnnV+FC
   p+QZnMCAPaekdPPp6FJ5ZVn5QagE8Amk3oQ2xFguBDCOrtd/h3iK3IeTk
   9z7d40C1Cd/kcaSHR+4bFQDZ98f/iPR3k4tT3rPri8ACZ09bj+5MDpL5a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="284956460"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="284956460"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 20:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="522611839"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2022 20:06:05 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na7bw-0000sO-IW;
        Fri, 01 Apr 2022 03:06:04 +0000
Date:   Fri, 1 Apr 2022 11:05:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-attest 5/6] ./usr/include/misc/tdx.h:38:19: error:
 expected ':', ',', ';', '}' or '__attribute__' before '__user'
Message-ID: <202204011027.5UDMOzNv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-attest
head:   9247fade9db5ae6eb183b2f92fdedb898282376a
commit: 054b22e81e88379a5a8459c19e89a335531c1bdd [5/6] platform/x86: intel_tdx_attest: Add TDX Guest attestation interface driver
config: i386-randconfig-a014 (https://download.01.org/0day-ci/archive/20220401/202204011027.5UDMOzNv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/054b22e81e88379a5a8459c19e89a335531c1bdd
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-attest
        git checkout 054b22e81e88379a5a8459c19e89a335531c1bdd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/misc/tdx.h:38:19: error: expected ':', ',', ';', '}' or '__attribute__' before '__user'
      38 |         void *buf __user;
         |                   ^~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
