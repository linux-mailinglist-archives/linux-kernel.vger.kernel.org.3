Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A59585990
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiG3J1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiG3J1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:27:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0FB402F9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659173222; x=1690709222;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZDDSd/0tgLFk6lpLJt/WUEGCyfcouSQz+j+g3fCmbjA=;
  b=mcAzIPF9wqkn2vzsFYbOnwfJEYqgrp9pwmRwpje1bI5nArEQSl7vaJ7h
   6Ysruvf0Z5pbz0Ae/fyaDB7G8tOFqS+xOG98QhlVktZF50F56dkOzh4G/
   cHFgKPoyCW6TiHAVdxzTFNg3/6kZFCC+fVGL28bv6MuNA3heJgsotys33
   7ITCRBEpakwvFcUwPptAshazEdhMkYgCJwpwWs0gjYO+1Ngz5EMnE/dm+
   ylzWFiNWngsglJ8hC6Kc8VaqRRSn9+NZSMkLM6pUOqVCHZyfbjFY/ARCB
   zk+4YgisIFt+2/ZzBr+uifOmaT7AP7m4ZdYdESIH4YScnk1TsTsuI/yIS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="287661653"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="287661653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 02:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="577218637"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Jul 2022 02:26:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHikN-000Cgb-0D;
        Sat, 30 Jul 2022 09:26:59 +0000
Date:   Sat, 30 Jul 2022 17:26:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc_snapshot 15/25] WARNING: modpost:
 vmlinux.o(.text+0xb94): Section mismatch in reference from the function
 regulator_set_voltage_sel_regmap() to the function
 .init.text:alloc_tree_node()
Message-ID: <202207301718.zVuhqhyF-lkp@intel.com>
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

tree:   https://github.com/atishp04/linux kvm_perf_rfc_snapshot
head:   42182a0a79a8768e22fd70232c3aca2bc1a26a43
commit: 20c5f15d297fb5a842bb1488be2781826b65a1dd [15/25] COVER
config: parisc-randconfig-r014-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301718.zVuhqhyF-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/20c5f15d297fb5a842bb1488be2781826b65a1dd
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc_snapshot
        git checkout 20c5f15d297fb5a842bb1488be2781826b65a1dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xb94): Section mismatch in reference from the function regulator_set_voltage_sel_regmap() to the function .init.text:alloc_tree_node()
The function regulator_set_voltage_sel_regmap() references
the function __init alloc_tree_node().
This is often because regulator_set_voltage_sel_regmap lacks a __init
annotation or the annotation of alloc_tree_node is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
