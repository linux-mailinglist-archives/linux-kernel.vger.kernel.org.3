Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE284CCD9C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiCDGNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiCDGNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:13:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3323F333
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646374364; x=1677910364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q0mGxd7pl8bf20YnSSuvgxU1qcj39tmEm7ezyQxKtnk=;
  b=m1FaEdXHJTBJdnZuFvazifjc+2NvsG7hj1HocHw5jb5n/enC1yvae3PF
   R0QAmKaSnEwXHiJVD4EqL9EgXbpNn4G/AIJ2MDnp6Bw5YP7rduT0utdqo
   8qfnqsg10G9ejt/zIsUtyDNZVvLYY1nvoMoIoWH/3hF7mn5SkFZaB3PmC
   k2za73KUZGtNqXmlnLG8Q2oWZpdRDaO4jhGq19e3CwIzQeeuLysLQ7olh
   zAvQuBVSmfTGxgECn05w+uFD8gjScI4HyRgY91dWEyEwD+TeVTVAslA3l
   IzKfql84TILLAJjD1FOb40BcmFWQFp+c9dEoBbFkO9SSXo/vinv8hy/d7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="233864697"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="233864697"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 22:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="494230578"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2022 22:12:43 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nQ1BC-0001MW-F6; Fri, 04 Mar 2022 06:12:42 +0000
Date:   Fri, 4 Mar 2022 14:12:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:tuxsuite 38/42] dp_debug.c:undefined reference to
 `dp_panel_tpg_config'
Message-ID: <202203041449.Vjeq8NwE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel tuxsuite
head:   0fff1d7836dde54d8a7ce2f9010fd46a40f23aee
commit: d90a75330159d88d87dd7f7462b0060a17fb1e95 [38/42] drm/msm/dp: Make it possible to enable the test pattern
config: openrisc-buildonly-randconfig-r001-20220304 (https://download.01.org/0day-ci/archive/20220304/202203041449.Vjeq8NwE-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/d90a75330159d88d87dd7f7462b0060a17fb1e95
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson tuxsuite
        git checkout d90a75330159d88d87dd7f7462b0060a17fb1e95
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/gpu/drm/msm/dp/dp_debug.o: in function `dp_test_active_write':
>> dp_debug.c:(.text+0x624): undefined reference to `dp_panel_tpg_config'
   dp_debug.c:(.text+0x624): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `dp_panel_tpg_config'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
