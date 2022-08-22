Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9359C2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiHVPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiHVPgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:36:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4543D15A10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661182611; x=1692718611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ae3uY5vcHYYdkA1iSn6bDiqBIxHXZBLkzaKpsokkNgw=;
  b=H5ZFNqpOmaOIiOxhTajG5CwZsidmfh5SpHG1MQDJav3NJ1Bp05BzrgZj
   ZSrRcwOrrOxt9WFkmuDf3VIjiOkGM4ruBquB9fHskNt52QbzWZbDcq96F
   oKSr4kMZP0hEOkL5CR//88e8KcVCgpZyXyRWGzZapKi/QjBVEcOfEd131
   fB7oA2ZmcmY6aHccWvw4IQu6eTltPGcsE0VHmWjSC/Hnjb+ZPI0654843
   gORG6rfv4NgrLnfaQnXcanh46ZrhJrVdNPx9ar8ZFIR/0C5luuNZrrvBO
   NWMWvNRgLRmRXzD/mhpl8g8+eY+8Mm5TbryuPyJFiSzfE4xrr0gNDDz/W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="290999853"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="290999853"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 08:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="784893016"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2022 08:36:49 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ9Tt-0000Ot-0r;
        Mon, 22 Aug 2022 15:36:49 +0000
Date:   Mon, 22 Aug 2022 23:36:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:for-kernelci 10/30]
 drivers/firmware/efi/libstub/zboot.c:47:23: warning: no previous prototype
 for 'efi_zboot_entry'
Message-ID: <202208222322.17taWGXs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   7a0f96975fe1b1ce53deba8c5a0b47d2d5e25cb7
commit: 0b28daf254f3affc5b04e93e804e8dd1333abf7a [10/30] efi/libstub: implement generic EFI zboot
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220822/202208222322.17taWGXs-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=0b28daf254f3affc5b04e93e804e8dd1333abf7a
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout 0b28daf254f3affc5b04e93e804e8dd1333abf7a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/firmware/efi/libstub/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/zboot.c:47:23: warning: no previous prototype for 'efi_zboot_entry' [-Wmissing-prototypes]
      47 | efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
         |                       ^~~~~~~~~~~~~~~


vim +/efi_zboot_entry +47 drivers/firmware/efi/libstub/zboot.c

    46	
  > 47	efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
