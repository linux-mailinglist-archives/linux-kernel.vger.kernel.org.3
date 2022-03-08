Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF634D2211
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350107AbiCHT4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347820AbiCHT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:56:35 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2774BFFD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646769339; x=1678305339;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MpyhYkOgcr+h4inx23oInHE5S73pLv0sOeisuKOmOUI=;
  b=Orc4Pz1QmdW8LJB0kS3xsoZFD1XMkkDM5f2cTYDYqeEJSVwokIqWeu1E
   cRl8Q++HzEy36NE5avxf+hb0e7bwGTe7Do2kY/Elcn0fSk1p79+E1+Hg4
   tUBnxdRjvjDW9l8VkrGEaMlc0hZ0ZyrP3p3I3FBYCXjJ4y3xL5Pflc4vS
   qHb+VL+cqxdutkVDq9cmblOjsKV620GB/OF2Vh92zHCkwl1lRoUpRXL7D
   moh3i/f45L8AZlB0TqXaEdhF38ej1JW/LX01EwNJ2Nq3ywm+IcvgZE+rZ
   ybjUJujhQRnii+Eug/o1kb8qBhNSw3Sy/Sve83fJ16Jdc8/KSCcFSis2y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254988952"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254988952"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 11:55:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="643782367"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 11:55:37 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRfvk-0001tY-FC; Tue, 08 Mar 2022 19:55:36 +0000
Date:   Wed, 9 Mar 2022 03:55:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:cec 333/345] ERROR: modpost: "__moddi3"
 [drivers/media/platform/amphion/amphion-vpu.ko] undefined!
Message-ID: <202203090325.kOgztPTb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git cec
head:   5a31a11af68144fdafb493ac9c2e7e9af5fc4ba8
commit: 42356ecbdb69e49cffd0c1df791280965f9f90e1 [333/345] media: amphion: add amphion vpu entry in Kconfig and Makefile
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220309/202203090325.kOgztPTb-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree cec
        git checkout 42356ecbdb69e49cffd0c1df791280965f9f90e1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__moddi3" [drivers/media/platform/amphion/amphion-vpu.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/media/platform/amphion/amphion-vpu.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
