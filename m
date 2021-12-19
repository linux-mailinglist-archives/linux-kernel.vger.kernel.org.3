Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7FC47A015
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 10:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhLSJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 04:49:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:64427 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhLSJta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 04:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639907370; x=1671443370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nqzvoct0VPFcbX8z1I39Uj/KJxU0sPs428I6uvSzPY0=;
  b=ObCNj99f/fiTJBjOJa5SRhCwDqAEAbHSiqY3VTyr6MRyShouRzCbXw2e
   g7y8qM1NL6FF24fPFkZS4Da4VHkSSgo+cb3vf68iVprjDrZ+cejGDXP9F
   nI5ehAH+J+iMXpyCr4h60wwIjd16IDYjMXkEdrReqmPBorHZyi+HZ7VZm
   uzBDZCM6zGH6atDYnOllfMHxES9iO/UI578dnvdIA95lje/AZdgfz9bzd
   UeYES4BkNB7LvCOgiuJGG6SN6s/iataGLg1kVMFCrF7WeNsukI8MyO9qb
   S4LkyLFwewcZmdCW6IJwccMtqVjCvIYQ5yrT4e3o0u1Uk/E8oz4nronvW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="227289422"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="227289422"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 01:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="683908609"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2021 01:49:28 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mysoq-0006r2-61; Sun, 19 Dec 2021 09:49:28 +0000
Date:   Sun, 19 Dec 2021 17:48:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [linux-stable-rc:queue/4.9 9948/9999] hid-zydacron.c:undefined
 reference to `usb_hid_driver'
Message-ID: <202112191734.55WlPL5M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.9
head:   3ad6fc25fc02c7d4e52e37fcf6e762c6201c5c5a
commit: 1309eb2ef1001c4cc7e07b867ad9576d2cfeab47 [9948/9999] HID: wacom: fix problems when device is not a valid USB device
config: xtensa-randconfig-r036-20211219 (https://download.01.org/0day-ci/archive/20211219/202112191734.55WlPL5M-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=1309eb2ef1001c4cc7e07b867ad9576d2cfeab47
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.9
        git checkout 1309eb2ef1001c4cc7e07b867ad9576d2cfeab47
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `zc_probe':
>> hid-zydacron.c:(.text+0x8a4f14): undefined reference to `usb_hid_driver'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
