Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E44503490
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 08:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiDPG42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 02:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPG40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 02:56:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0923A10EC44
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650092036; x=1681628036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fAE2xMjKJTAYYfojBwucYXlSRxc0bm4fLjTRmufZB7M=;
  b=Z5fgMA8KewDZd6KXhxI6LOfAe5LxrsXDi8UdIu6Ka1dooKzFP/9bW0L5
   XsIo1aWgmt+AkNWmh4ccvOYMSc5RBRBt7DfId9cIkpLtAxx1pe5OUegZv
   v8DN+ngIDe2VlhvPASlw16R2xy1FNZ5lAirf5ykewvI370aDA5lbvTZ95
   2F7HqaygwMvPcJAcaDy/02kkuDlkWdqQMqeoMBXdriVVfMLEDhTzIy/ax
   IJwG1Qxo1dj20ChATlyfZfQmTnE2dnQkHFQ1iS5gwtAiIgmRwaZp1eZvq
   AqQACb8H9McKcU8ofHBRzwHl07NpD3G+ZC1KBRf3M4tfbPM5pgNsIXI2h
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="326175880"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="326175880"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 23:53:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="662698366"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2022 23:53:53 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfcJc-0002sf-MQ;
        Sat, 16 Apr 2022 06:53:52 +0000
Date:   Sat, 16 Apr 2022 14:52:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Wang <zhi.a.wang@intel.com>
Cc:     kbuild-all@lists.01.org, zhenyu.z.wang@intel.com,
        terrence.xu@intel.com, intel-gvt-dev@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [intel-gvt:topic/for-christoph 1/37]
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c:7:10: fatal error:
 display/intel_dmc_regs.h: No such file or directory
Message-ID: <202204161401.AtiDTPRF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tree:   https://github.com/intel/gvt-linux.git topic/for-christoph
head:   fd6f410fe5eced449a4d6467a4f4789a8eb10382
commit: 07de96038f7d8a179287ae178dfcad8f085abb9e [1/37] i915/gvt: Separate the MMIO tracking table from GVT-g
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220416/202204161401.AtiDTPRF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/gvt-linux/commit/07de96038f7d8a179287ae178dfcad8f085abb9e
        git remote add intel-gvt https://github.com/intel/gvt-linux.git
        git fetch --no-tags intel-gvt topic/for-christoph
        git checkout 07de96038f7d8a179287ae178dfcad8f085abb9e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/intel_gvt_mmio_table.c:7:10: fatal error: display/intel_dmc_regs.h: No such file or directory
       7 | #include "display/intel_dmc_regs.h"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +7 drivers/gpu/drm/i915/intel_gvt_mmio_table.c

   > 7	#include "display/intel_dmc_regs.h"
     8	#include "gt/intel_gt_regs.h"
     9	#include "gvt/gvt.h"
    10	#include "i915_drv.h"
    11	#include "i915_pvinfo.h"
    12	#include "i915_reg.h"
    13	#include "intel_gvt.h"
    14	#include "intel_mchbar_regs.h"
    15	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
