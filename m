Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631B355CCB6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbiF0XwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiF0XwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:52:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A2013E85
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656373928; x=1687909928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jRlfJrmzmoqiWxnoKgDqszgHgzY49pCLtdOn0Ib/tfE=;
  b=aQie/5dH0ezpUo9nUfRJShEc1syoc4FbFhpnwEA1bIguXyd72h++G3ZV
   yO6Eyef8FNU2DJZKfGxNWP+Jn6rDmC45xpe8tsjlV/VQnOfaFoHJ/eiho
   XqfFIx+qDB2ckV+dtKVuofVYgX0PNG6ypwL1d+ZgmdxDPMfRGjb+XxUp6
   MWoXyR2Hj6SdGfToWcfqHlsill4SpzAUsJuLkShZW0LTHRH9RRVMm7ZK0
   PWSRgMYTdvPRCzvFqgiq5Qf0CUG2xA78A27UnAK9mN6xWdQTb0f93pkiD
   GlInZGhqKOwmTXC8R+4q6svNb+hF05J46mI8L3w+q9KdO08RmnNYTo0PL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281627422"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281627422"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 16:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732523813"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2022 16:52:07 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5yWV-0009EY-2N;
        Mon, 27 Jun 2022 23:52:07 +0000
Date:   Tue, 28 Jun 2022 07:51:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 292/442]
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_in+0xcd:
 stack state mismatch: cfa1=5+16 cfa2=4+8
Message-ID: <202206280731.i5e1UxsC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   8af973ebaf30642129fc1ca63f155a469f9615ed
commit: 2ec4ebb86a3cdada98b938dcc6fcd8efd078d3d7 [292/442] [REVERTME] fix undefined symbol of cc_init
config: x86_64-randconfig-a014-20220627 (https://download.01.org/0day-ci/archive/20220628/202206280731.i5e1UxsC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/2ec4ebb86a3cdada98b938dcc6fcd8efd078d3d7
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 2ec4ebb86a3cdada98b938dcc6fcd8efd078d3d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_in+0xcd: stack state mismatch: cfa1=5+16 cfa2=4+8
>> drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_port_hb_out+0xd3: stack state mismatch: cfa1=5+16 cfa2=4+8

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
