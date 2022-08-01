Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45920586344
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiHAEOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHAEOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:14:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F8DE8E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659327256; x=1690863256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TXliT1+04BhdnA/IHZYmDi1otIoDwod2FK94mtigLEU=;
  b=RA9hXhBN1y6xbWAzkpTnlsZ/0LEtyzxwMHhr/jzOxNP4kVquNpSNUgNW
   t1L1RFeR+rnONO4nc1HblxZ1+6ez4NAJ8su9Y6R//WcJFM5Rg8RTubzf/
   ywADM/2yvdZlRdyaIy6kpsUfb9xCuIIDSykkWIb4PYBmw6vqB23WIt5jz
   6eJgZZ26gthHoz7ROHg6s12SVD666EVUleFQWckt8j6JVBBFATPmChz8e
   WAJZTwaj07gCXvpbVwWVBYzhn90786mI1OKyvFqOGZ1ghF2gQ9zUBUBob
   gFFl5MJX0R9qlcdaX8VLPey6JJXMx1k4QXYrjG21QTlvwAJ0mbAnQrSDm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="268823030"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="268823030"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 21:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="630084884"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2022 21:14:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIMoo-000Em7-0L;
        Mon, 01 Aug 2022 04:14:14 +0000
Date:   Mon, 1 Aug 2022 12:13:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:x86-head64-cleanup 1/5] ld:
 drivers/firmware/efi/libstub/x86-stub.stub.o:(.bss.efistub+0x0): multiple
 definition of `image_offset';
 arch/x86/boot/compressed/head_32.o:(.data+0x20): first defined here
Message-ID: <202208011257.EX6rUyXG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git x86-head64-cleanup
head:   98468eaa18daadca5bc6a0c96b7553855730b109
commit: 58db1fb9adb44432f85043d93b0f932ef7678fb0 [1/5] x86/head_64: clean up mixed mode 32-bit entry code
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220801/202208011257.EX6rUyXG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=58db1fb9adb44432f85043d93b0f932ef7678fb0
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb x86-head64-cleanup
        git checkout 58db1fb9adb44432f85043d93b0f932ef7678fb0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld: drivers/firmware/efi/libstub/x86-stub.stub.o:(.bss.efistub+0x0): multiple definition of `image_offset'; arch/x86/boot/compressed/head_32.o:(.data+0x20): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
