Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B09048E0D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbiAMX0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:26:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:49456 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238190AbiAMX0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642116376; x=1673652376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eXEBjcWeFOev0BWdMvRSGQJ5T+BFpPs/z69279SiIpU=;
  b=NuKDWnH37eIGe8S29v1AdLFcpswpm12UUeVTskJayv9hKwmiaaM6vmIQ
   IRIGLHz5A4CMsET3E4jzjrbR7jKHezbiw96b1vAsyGmgsoOhkoDRUkSSb
   vgD4fUFVgZIAclvXqKe5OkOu1S7/eMMSmatrgZtgRql9PPZJ8UY08ZhQd
   /RdHaZBGYX1wcoX4woIGjQ+0XIqgipRuugr94R/N9gguHLAJFcrr+Fro4
   4ulo+YuhJfEU5ASFmJ4CwH7XoK4mIT63j9nQnRboWXSIpc6SJKuSZahHF
   el+vCtWcuP1lL4LChSaWBZ4CVcP9Os6d5tKVLgf3FdKGqrcRTBndauAwk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="304865962"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="304865962"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="473429861"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2022 15:26:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n89Tu-0007lg-Fc; Thu, 13 Jan 2022 23:26:10 +0000
Date:   Fri, 14 Jan 2022 07:25:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 118/133] boot.c:undefined reference to
 `swiotlb_hint_cpus'
Message-ID: <202201140759.vUKBZKzB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: 8c696e48187c5ffa881e639e1108622debbe6741 [118/133] swiotlb: Split up single swiotlb lock
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220114/202201140759.vUKBZKzB-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/8c696e48187c5ffa881e639e1108622debbe6741
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx tdx/guest-rebased
        git checkout 8c696e48187c5ffa881e639e1108622debbe6741
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/acpi/boot.o: in function `acpi_boot_init':
>> boot.c:(.init.text+0xcbb): undefined reference to `swiotlb_hint_cpus'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
