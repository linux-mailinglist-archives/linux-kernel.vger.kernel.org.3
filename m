Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65D49FECA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343542AbiA1RRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:17:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:14547 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237031AbiA1RRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643390260; x=1674926260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ke2wrUMps46nHfuBAnrVSoXp2njP9IujpN3LbU8dadY=;
  b=l+EHs0sIew6ySate3ufTP6B1TFUa+KzLAGaZ7J7wEQ3nHbxA9lP16H6s
   haB+FtVHv33SeozOohTToRmumvs322I36LmUhXFS/HXLhwo+XUcEsoStg
   qjAUJkTEcfYoVUye3x4GWYMiypHvU6EQIFWk85Lia23DuJ5cuRyFZy/ni
   H8fHRjyBns9bBXI0BLf7Pye9ut5PyIuN5RFeQfaRqEtnJIaHfCdlGMRG0
   er9d578Y7wKnzbWsjzYRULAujIjiByvVMWtlpBoFMQj5nIrxpYTPMuQQ6
   A9CyDoNLCMt9ngAN32Dkn29IBE18rCtzMZ6VMktd6Mda/IVMjM7y3M8zV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="333512984"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="333512984"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 09:17:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="675150176"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2022 09:17:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDUsU-000O8E-Dp; Fri, 28 Jan 2022 17:17:38 +0000
Date:   Sat, 29 Jan 2022 01:16:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:for-v5.18k 104/107] vimc-capture.c:undefined
 reference to `vb2_dma_contig_memops'
Message-ID: <202201290150.rJgwsyjj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.18k
head:   ab1804e24c2d3bb0b511db538d9e834e260db16b
commit: 6e0f23d9552db48996f82eaa5659fb50c692c6a2 [104/107] media: vimc: Add support for contiguous DMA buffers
config: m68k-randconfig-r026-20220126 (https://download.01.org/0day-ci/archive/20220129/202201290150.rJgwsyjj-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.18k
        git checkout 6e0f23d9552db48996f82eaa5659fb50c692c6a2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/media/test-drivers/vimc/vimc-capture.o: in function `vimc_cap_add':
>> vimc-capture.c:(.text+0x6f0): undefined reference to `vb2_dma_contig_memops'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
