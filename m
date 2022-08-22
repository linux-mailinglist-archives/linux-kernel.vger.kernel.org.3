Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843B259BD9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiHVKby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiHVKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:31:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC42F3A7;
        Mon, 22 Aug 2022 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661164307; x=1692700307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OA61iMl2LAMBDM5zyrTEbmJe1CFMJNkn6xjVOIt/ELk=;
  b=J+Yd1rFb9jR4BaBPx9GPzqT4btKzQ1Z/SBCOb6ZNxq3QGMSVEV+GStPp
   zez05EeYTOM670PCoiYHTZgGQwPBaIJhyl2wI/vnU7BQqY64Gk05j0uJH
   evFF6aUwjIqb1gJfRaCcRN1Jj4swF5nCg783vz5kFkAKIEtpr1l00DLXu
   /b2zyYdz8wbegB3ulI0qmO3cLCVl15I6fyX3RhW6SfhHmfYaLAFgDOEtJ
   zdtvhfnVY4u0lAaSDrkn/1w/kyZ9IIlW+FjURdUZfC/XM6lrMg/3A3QP7
   blw+HtGbRAR3sXQoLKftxrEEVfy9wPxpnP5wp+XGq3m/mref/O0P31pnT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="355109729"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="355109729"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 03:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="641981514"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2022 03:31:45 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ4ie-0005DB-27;
        Mon, 22 Aug 2022 10:31:44 +0000
Date:   Mon, 22 Aug 2022 18:31:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: arch/mips/pci/pci-ar2315.c:6: warning: This comment starts with
 '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202208221854.8ASrzjKa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c23f9e627a7b412978b4e852793c5e3c3efc555
commit: 3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf scripts: kernel-doc: add warning for comment not following kernel-doc syntax
date:   1 year, 5 months ago
config: mips-randconfig-r016-20220821 (https://download.01.org/0day-ci/archive/20220822/202208221854.8ASrzjKa-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/pci/pci-ar2315.c:6: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Both AR2315 and AR2316 chips have PCI interface unit, which supports DMA


vim +6 arch/mips/pci/pci-ar2315.c

3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  @6   * Both AR2315 and AR2316 chips have PCI interface unit, which supports DMA
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29   7   * and interrupt. PCI interface supports MMIO access method, but does not
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29   8   * seem to support I/O ports.
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29   9   *
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  10   * Read/write operation in the region 0x80000000-0xBFFFFFFF causes
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  11   * a memory read/write command on the PCI bus. 30 LSBs of address on
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  12   * the bus are taken from memory read/write request and 2 MSBs are
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  13   * determined by PCI unit configuration.
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  14   *
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  15   * To work with the configuration space instead of memory is necessary set
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  16   * the CFG_SEL bit in the PCI_MISC_CONFIG register.
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  17   *
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  18   * Devices on the bus can perform DMA requests via chip BAR1. PCI host
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  19   * controller BARs are programmend as if an external device is programmed.
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  20   * Which means that during configuration, IDSEL pin of the chip should be
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  21   * asserted.
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  22   *
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  23   * We know (and support) only one board that uses the PCI interface -
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  24   * Fonera 2.0g (FON2202). It has a USB EHCI controller connected to the
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  25   * AR2315 PCI bus. IDSEL pin of USB controller is connected to AD[13] line
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  26   * and IDSEL pin of AR2315 is connected to AD[16] line.
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  27   */
3ed7a2a702dc0f Sergey Ryazanov 2014-10-29  28  

:::::: The code at line 6 was first introduced by commit
:::::: 3ed7a2a702dc0f5bc44d67f27a1a289356b5dc42 MIPS: ath25: add AR2315 PCI host controller driver

:::::: TO: Sergey Ryazanov <ryazanov.s.a@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
