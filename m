Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8034A2B1A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 02:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352110AbiA2BuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 20:50:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:48705 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352068AbiA2BuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643421017; x=1674957017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bmJrVUsxb+MtLQ2Qx+pdstrggeZTOGR4fFIsPW2Os7Y=;
  b=Ch2yxex5WKmuq5vQMon2Z4yI2PqfARPYMcXdZJdsnuxsmj6JSSsNBvpB
   FZq6f/gOeic5rm6EMyaUvvc43jxQCb+jCFvczfnbFFh6ciKHTZS5t6Ue7
   O3Ayqs1rmWrVyZyAnVYv+2rBO1sc8Xn2Kn8RNokEiU1B2dxy9cpeTUmbB
   j+oTqyrxn+yxSkJrpDL0OW9fO2w0u7hnLc4dUPk6PXUnxP0gbgsUOwS1Y
   k5j1Fv44I4P1dv3DgbK5TLAQ5ZTc9yfL99bNn53INn/yxKD4HXDIXQbDR
   D2shozR7nKAeqMvjVet+/04rIsq00hoLAHEFm6t/0zzMNoQhD39DWnpD1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227207413"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="227207413"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 17:50:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="564377908"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2022 17:50:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDcsZ-000OcE-4L; Sat, 29 Jan 2022 01:50:15 +0000
Date:   Sat, 29 Jan 2022 09:49:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:for-v5.18k 104/107] nds32le-linux-ld:
 vimc-capture.c:undefined reference to `vb2_dma_contig_memops'
Message-ID: <202201290904.NmpIpCkd-lkp@intel.com>
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
config: nds32-randconfig-r015-20220127 (https://download.01.org/0day-ci/archive/20220129/202201290904.NmpIpCkd-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.18k
        git checkout 6e0f23d9552db48996f82eaa5659fb50c692c6a2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: drivers/media/test-drivers/vimc/vimc-capture.o: in function `vimc_cap_add':
   vimc-capture.c:(.text+0x87c): undefined reference to `vb2_dma_contig_memops'
>> nds32le-linux-ld: vimc-capture.c:(.text+0x880): undefined reference to `vb2_dma_contig_memops'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
