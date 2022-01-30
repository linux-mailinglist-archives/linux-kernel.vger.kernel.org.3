Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F04A3AAF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347767AbiA3W25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:28:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:3611 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbiA3W24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643581736; x=1675117736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZC7OE0lDP+xDtW8KXwLG96nUCiMtxsUbhe9Qwbr3DQ4=;
  b=e1eLKifYy81CTN+YwwiwBh2UjItSTYe5Wjd58AuFbGXDtuKerMF8j7LV
   +HhZNAWiUVe4eUrcVDoxlyHOL69xvlI2tnJbexfjuqHnxVWGB1X4Pb5FJ
   thb/gwQo5ku3y4StWz9Zyulw+u9ZOYzRFaQE6LhcIPDgJsPPEkqD0PwDN
   GbgeY7AvbXH9hK1beYRBnmx4iCSzAYEN5/cOUOuG5LEwbKLS5F/3QdZlY
   q++A7Z3Uq8u8ucjKRtbjeNiqJ81pUqvNdlgdAkr5LWSy2V9ByDzdaZsqB
   eqtpWGatYlbM9kpgYNwb1h3j+xn/AyMEvsqbX+40hx7bviCnZgzXJSlmm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247150030"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="247150030"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 14:28:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="478865837"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2022 14:28:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEIgn-000R3U-T7; Sun, 30 Jan 2022 22:28:53 +0000
Date:   Mon, 31 Jan 2022 06:28:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [clangbuiltlinux:instrumentation2 91/91]
 drivers/misc/mei/interrupt.o: warning: objtool:
 mei_irq_write_handler.part.0() falls through to next function
 mei_irq_write_handler()
Message-ID: <202201310516.HfJRtwoh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ClangBuiltLinux/linux instrumentation2
head:   a6c990592cb23c14052c5c7b9caab08b5a30a387
commit: a6c990592cb23c14052c5c7b9caab08b5a30a387 [91/91] x86: bug.h: inline ASM_UD2
config: x86_64-buildonly-randconfig-r001-20220124 (https://download.01.org/0day-ci/archive/20220131/202201310516.HfJRtwoh-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ClangBuiltLinux/linux/commit/a6c990592cb23c14052c5c7b9caab08b5a30a387
        git remote add clangbuiltlinux https://github.com/ClangBuiltLinux/linux
        git fetch --no-tags clangbuiltlinux instrumentation2
        git checkout a6c990592cb23c14052c5c7b9caab08b5a30a387
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/ block// crypto// drivers/ fs// init// ipc// kernel// lib// mm// security/ sound/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/mei/interrupt.o: warning: objtool: mei_irq_write_handler.part.0() falls through to next function mei_irq_write_handler()
--
>> drivers/mfd/retu-mfd.o: warning: objtool: retu_regmap_read() falls through to next function retu_regmap_write()
>> drivers/mfd/retu-mfd.o: warning: objtool: retu_regmap_write() falls through to next function retu_probe()
--
>> drivers/dma/ti/edma.o: warning: objtool: edma_tx_status() falls through to next function dma_irq_handler()
   drivers/dma/ti/edma.o: warning: objtool: dma_irq_handler() falls through to next function edma_alloc_slot()
--
>> drivers/dma/ti/omap-dma.o: warning: objtool: omap_dma_tx_status() falls through to next function omap_dma_irq()
>> drivers/dma/ti/omap-dma.o: warning: objtool: omap_dma_irq() falls through to next function omap_dma_prep_dma_memcpy()
--
>> drivers/dma/dw/core.o: warning: objtool: dwc_descriptor_complete() falls through to next function dwc_scan_descriptors()
>> drivers/dma/dw/core.o: warning: objtool: dwc_free_chan_resources() falls through to next function do_dw_dma_on()
--
>> drivers/nvdimm/btt.o: warning: objtool: btt_rw_page() falls through to next function btt_freelist_init()
--
>> drivers/gpu/drm/gma500/psb_intel_lvds.o: warning: objtool: psb_intel_lvds_set_brightness() falls through to next function psb_intel_lvds_init()
--
>> drivers/gpu/drm/gma500/psb_irq.o: warning: objtool: psb_disable_pipestat.part.0() falls through to next function psb_enable_pipestat.part.0()
>> drivers/gpu/drm/gma500/psb_irq.o: warning: objtool: psb_enable_pipestat.part.0() falls through to next function psb_enable_pipestat()
>> drivers/gpu/drm/gma500/psb_irq.o: warning: objtool: psb_enable_vblank() falls through to next function psb_disable_vblank()
--
>> drivers/gpu/drm/tidss/tidss_irq.o: warning: objtool: tidss_irq_update() falls through to next function tidss_irq_handler()
--
>> sound/virtio/virtio_ctl_msg.o: warning: objtool: virtsnd_ctl_msg_request() falls through to next function virtsnd_ctl_msg_response()
>> sound/virtio/virtio_ctl_msg.o: warning: objtool: virtsnd_ctl_msg_response() falls through to next function virtsnd_ctl_msg_alloc()
--
>> crypto/keywrap.o: warning: objtool: crypto_kw_scatterlist_ff() falls through to next function crypto_kw_decrypt()
..

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
