Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7698556F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377520AbiFVXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377494AbiFVXeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:34:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1182D2F657;
        Wed, 22 Jun 2022 16:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655940860; x=1687476860;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MtpP6KaJSVSdiH7d+5TEm0dDvUmVQLm06+z3a7CH9Dg=;
  b=H7pBMnIE7SSe7QuRELrSpXokUrP0xmdFpZGHkBA6qtLyPm5ri0yqE1KH
   PyhdKR7T7KEWGIXX2TH21qQ3mMmWWuchpVlzLrEjQfX2EBIOGVFnukwRG
   yDBvUwrtAYTN8YqKJ1OWIKHWPMBQH236Aw8thTSGqyRo1AvsX1kUj30kf
   5/WdMn2DdcfRIiVo+iFrTB7kE3SDiWZ4JrH1BzRPskYTk99qFo50ZWtfp
   7GaGwl+rDM/ms60IoX6kkIlEtf9AQytjhvLauMTlcVBBo4Dk40pkKys9j
   ZQUaY39ACWfme9JLdZs43WfeuNKYfKWfVFIrxxzGUVb+UPMqwvmpVSgbD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280620701"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="280620701"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 16:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="677803307"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2022 16:34:18 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o49rV-0001pj-VT;
        Wed, 22 Jun 2022 23:34:17 +0000
Date:   Thu, 23 Jun 2022 07:33:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harita Chilukuri <harita.chilukuri@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_15 2/2]
 drivers/platform/x86/socwatch/sw_telem.c:635: warning: This comment starts
 with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202206230700.Lw6vkxpn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_15
head:   3af50f40725e78c505cbf840fb0be424c2f33e5e
commit: 3af50f40725e78c505cbf840fb0be424c2f33e5e [2/2] Pull socwatch driver to intel-next 5.15
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220623/202206230700.Lw6vkxpn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/mchinth/linux/commit/3af50f40725e78c505cbf840fb0be424c2f33e5e
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_15
        git checkout 3af50f40725e78c505cbf840fb0be424c2f33e5e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/socwatch/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/x86/socwatch/sw_telem.c:334: warning: Function parameter or member 'addrs' not described in 'setup_telem'
   drivers/platform/x86/socwatch/sw_telem.c:376: warning: Function parameter or member 'events' not described in 'get_or_set_id'
   drivers/platform/x86/socwatch/sw_telem.c:376: warning: Function parameter or member 'unit_idx' not described in 'get_or_set_id'
   drivers/platform/x86/socwatch/sw_telem.c:376: warning: Function parameter or member 'id' not described in 'get_or_set_id'
   drivers/platform/x86/socwatch/sw_telem.c:437: warning: Cannot understand  * @returns timestamp (1st entry of SSRAM)
    on line 437 - I thought it was a doc line
>> drivers/platform/x86/socwatch/sw_telem.c:635: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Configurs events + starts counters
   drivers/platform/x86/socwatch/sw_telem.c:858: warning: expecting prototype for sw_available_telem(). Prototype was for sw_telem_available() instead
--
>> drivers/platform/x86/socwatch/sw_ops_provider.c:830: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Decide if the socperf interface is available for use


vim +635 drivers/platform/x86/socwatch/sw_telem.c

688e338c753b33 Faycal Benmlih 2019-04-23 @635   * Configurs events + starts counters

:::::: The code at line 635 was first introduced by commit
:::::: 688e338c753b33c023de3b774f7347effbf537a4 Platform/x86: Update SoCWatch driver code to 2.10

:::::: TO: Faycal Benmlih <faycal.benmlih@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
