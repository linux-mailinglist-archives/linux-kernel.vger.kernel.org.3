Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0752D49F2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiA1FMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:12:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:36081 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbiA1FL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643346717; x=1674882717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zyjJj3AW8MXDIb8IgNyGcgSoz747da3StOX16uzql5w=;
  b=kEfkXAa0MbQNjNfB8k7UkG+Gf31I6Zi3hGyj0NBytGgkNo6hYnKZ8cfY
   vgzeEp+BkRXBfIqRkJvMgbuiozDjExOVBxnK8wt8RLgvtyEHIc2Go1w6G
   bcRxmTaqO96Jl9dsOYkLGVgcwku5dowZM9Xz/xslnVWfclVfL6NjjhzzR
   n+sES9DUc+vlVMToufgOPk8o4pOLiBZ6GJ25oMj21Chjqa5uEqpPbS9Gh
   yKLW6C/Iv6dlnqFyGwsGXbxckiJQxWG80evA7RzsySGAqgxvOFN8+k2Fq
   rniYqO+wG5ztucR8DJnsympx4ZAqnRTefDpYECiB1Dd6ocTi7gNih/HCt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="246822203"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="246822203"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 21:11:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="478160727"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2022 21:11:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDJYA-000NVO-CW; Fri, 28 Jan 2022 05:11:54 +0000
Date:   Fri, 28 Jan 2022 13:11:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>, hch@lst.de, jgg@nvidia.com,
        jani.nikula@linux.intel.com
Cc:     kbuild-all@lists.01.org, Zhi Wang <zhi.wang.linux@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Terrence Xu <terrence.xu@intel.com>,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH 1/3] i915/gvt: Introduce the mmio_table.c to
 support VFIO new mdev API
Message-ID: <202201281209.mnHCKgPp-lkp@intel.com>
References: <20220127120508.11330-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127120508.11330-1-zhi.a.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm-tip/drm-tip]
[also build test WARNING on next-20220127]
[cannot apply to drm-intel/for-linux-next hch-configfs/for-next v5.17-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhi-Wang/i915-gvt-Introduce-the-mmio_table-c-to-support-VFIO-new-mdev-API/20220127-200727
base:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220128/202201281209.mnHCKgPp-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/533f92651a7a56481a053f1e04dc5a5ec024ffb9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhi-Wang/i915-gvt-Introduce-the-mmio_table-c-to-support-VFIO-new-mdev-API/20220127-200727
        git checkout 533f92651a7a56481a053f1e04dc5a5ec024ffb9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/i915/gvt/handlers.c:45:6: sparse: sparse: symbol 'intel_gvt_match_device' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
