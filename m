Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12B856605A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiGEAfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGEAfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:35:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1258DB4B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656981333; x=1688517333;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NYmgvKAhl2k7Tv/SaLxaBcWeFZASdYXW3kUWtebHjrg=;
  b=TEdCC1meJrfS0DgJQQ0FEVueOg3BlLaLFMNirwc6UVtGoQRfsPNJECxH
   0CwV+aGxzUzKLoy8J9v7FgghCtP54hCynyrgn8+RARkJxokoQ52/o2dd3
   nld8fnIN/HgrLkks6qMuOWM0TiwQcvru2D3FqVq4I4W5Nsra0zWj9DfH3
   V1wAAfT/CDs2eIENA4YjpUuGTmYXy17Nyeda0t798mNIKfn/q5UM752D5
   RvtoyeBXIG0dFfLHU6zQJZmdx4Mq0/TSZ5V1FfpiULXOEUV6t+ZH068dn
   IbTam0tiomagZpiNkwKEzGvDxLUIVX2yA2Iqhm57aXwFlZhzaTBIG+VLV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="280770529"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="280770529"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 17:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="919503242"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2022 17:35:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8WXK-000IVF-Tv;
        Tue, 05 Jul 2022 00:35:30 +0000
Date:   Tue, 5 Jul 2022 08:35:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ogabbay:habanalabs-next 52/74] ld.lld: error: undefined symbol:
 __umoddi3
Message-ID: <202207050806.cPkBIh3x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   dd59146d7ce2b160b57e747e6ca70afbcb4b41a5
commit: c5c630faa00de0cc343fa0e5a236ed117ef454a3 [52/74] habanalabs: add gaudi2 asic-specific code
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220705/202207050806.cPkBIh3x-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=c5c630faa00de0cc343fa0e5a236ed117ef454a3
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout c5c630faa00de0cc343fa0e5a236ed117ef454a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __umoddi3
   >>> referenced by gaudi2.c
   >>>               misc/habanalabs/gaudi2/gaudi2.o:(gaudi2_cpucp_info_get) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
