Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4039B4C9779
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiCAVFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiCAVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:05:13 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEEB70337
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646168671; x=1677704671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JkBpiGS9qT2A5/AO8ZoQHW0JjgI9k0Vg9Eiwm+kBaEU=;
  b=T80kjfOwWDXOidMtxI9TOh3GIX2AzvLqmWHjj7OOjb3sS1sGIydpmftX
   6371v5p0DXAis3WjCpiWG6jvYqGA5Hq3Ii7a+8hoDmbooZG6e8Hn6Uchy
   gr4KrEHUTq7+JNOmA8QAYENt0WDKOPnWCr2t1K1KhdcmzYtkVFOXsmrvu
   4YmVFIWPXNLcS2f/nM3SfZtlbHxns0bWbNC1oZTi69uo/hCwafIUFGGUf
   MPGfWuVv4QG16t7vVxs/8eJG05aitTgRLw1gvmVX/Em/wHdhvPR1MZEcg
   o7ZqMRgZgGNOEe+BlOsaauYwnXQn9JnCmJpro5Y3+4MW9NEhyrY2J2yS2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="313961779"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="313961779"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 13:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="641421998"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2022 13:04:30 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP9fZ-00011o-8l; Tue, 01 Mar 2022 21:04:29 +0000
Date:   Wed, 2 Mar 2022 05:03:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 80/96] Error:
 arch/arm/boot/dts/mstar-infinity2m-ssd201-wirelesstag-ido-som2d01.dtsi:18.1-9
 Label or path pm_uart not found
Message-ID: <202203020419.Kj7avg87-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   8ac61fd8fe35232e1061ab5e3e7b665cac918068
commit: a129af18616a3b5ad4c4af70458703a052da2d63 [80/96] ARM: dts: mstar: Add top level dts for ssd201-som2d01
config: arm-randconfig-r006-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020419.Kj7avg87-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/linux-chenxing/linux/commit/a129af18616a3b5ad4c4af70458703a052da2d63
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout a129af18616a3b5ad4c4af70458703a052da2d63
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/mstar-infinity2m-ssd201-wirelesstag-ido-som2d01.dtsi:18.1-9 Label or path pm_uart not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
