Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E079A47FA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 05:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhL0EMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 23:12:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:65434 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235156AbhL0EMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 23:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640578333; x=1672114333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GlcD9Zjp1E+9n0H6NzNbutTs+RGmfE5poRkHAv054+Q=;
  b=ZHs+oMVKlY4jlpxer/B2KHUj3CxfxM9nV9mzuz+rYiSym6wgmTVLNsFK
   mcYHmv/Qk3q7tqp3Q0mwjcj2aE3OnjDyMwlDvmA86dKRzv9pyGNLobXUK
   wXdzRkYHau+tbEZOUv2Sw+a89hSkDxj7+WvLaW0WzIIiFPbFftmEzn7Jh
   LHW03Xkf+v1GKEULnutZxUvBt4AtrLN+5D0/WRfVpV6IEeffGnTjiOhY6
   G9ejo0gV4NY2Wlzu3ZYVqQn9hRSVQ1HZnQ6iqm66kN2EOr5NEGz/s/WYG
   IPWH1l9pHmX62dKGbmTCaUxEppdt513+/AMNxjW7PbFBevNq+yBGmc7KD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="241375310"
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="241375310"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 20:12:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="553652913"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Dec 2021 20:12:09 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1hMm-00061b-Sg; Mon, 27 Dec 2021 04:12:08 +0000
Date:   Mon, 27 Dec 2021 12:11:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc100x: Add ACPI HID table
Message-ID: <202112271213.Z6jyi5YK-lkp@intel.com>
References: <20211224145903.368999-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224145903.368999-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kai-Heng-Feng/iio-humidity-hdc100x-Add-ACPI-HID-table/20211224-230046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: mips-randconfig-c004-20211227 (https://download.01.org/0day-ci/archive/20211227/202112271213.Z6jyi5YK-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 511726c64d3b6cca66f7c54d457d586aa3129f67)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/59648fe59d706ab2b9e719418c490d505ee5cc93
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kai-Heng-Feng/iio-humidity-hdc100x-Add-ACPI-HID-table/20211224-230046
        git checkout 59648fe59d706ab2b9e719418c490d505ee5cc93
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/iio/humidity/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/humidity/hdc100x.c:420:36: warning: unused variable 'hdc100x_acpi_match' [-Wunused-const-variable]
   static const struct acpi_device_id hdc100x_acpi_match[] = {
                                      ^
   1 warning generated.


vim +/hdc100x_acpi_match +420 drivers/iio/humidity/hdc100x.c

   419	
 > 420	static const struct acpi_device_id hdc100x_acpi_match[] = {
   421		{"HDC1010"},
   422		{ },
   423	};
   424	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
