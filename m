Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC648285E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 20:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiAATwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 14:52:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:55591 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232463AbiAATwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 14:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641066722; x=1672602722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ayIudOX3mr4n4CHkW2cwbJ7L3crDWN5Jnt5eSDs14iM=;
  b=fTiWeF6ppCtXKE8HzMhXe4z98sW+k7Jtws12XtOUysHV2nyNxX8wy+Kr
   9PMP/UYyx+SnV+qJp5QT4fcx0rHr8OUmsI96qNyYoI0a9OXIKdd0LMNtO
   LunZfB1GVRq0fjJ+YpkJEW4Oao8lTZGI87ktBxBNLeozEdIMBCICusJ3y
   JOLhTk/tYCC0jdVpv9ovdo+LhZx4/qmJk8SuldC+hDkKy9+aG62rYzxyO
   nDZOoBfoP4/skbUYuNotrOxgPlV7Z/duhz61aFgI79O5wz1RSLrlWDV8K
   NRuuLYIPaRqMGtECyjf4gLBWJMbwqag4sMs132/xblz5njp92oKPrTIsR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="222591980"
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="222591980"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 11:52:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="619900598"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Jan 2022 11:51:58 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3kQ2-000CmO-5m; Sat, 01 Jan 2022 19:51:58 +0000
Date:   Sun, 2 Jan 2022 03:51:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, airlied@redhat.com, airlied@linux.ie,
        daniel@ffwll.ch, jenmin_yuan@aspeedtech.com,
        kuohsiang_chou@aspeedtech.com, arc_sung@aspeedtech.com,
        tommy_huang@aspeedtech.com
Subject: Re: [PATCH] drm/ast: Create the driver for ASPEED proprietory
  Display-Port
Message-ID: <202201020329.lEcno4eh-lkp@intel.com>
References: <20211122103617.3496-1-kuohsiang_chou@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122103617.3496-1-kuohsiang_chou@aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KuoHsiang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on tegra-drm/drm/tegra/for-next v5.16-rc7]
[cannot apply to drm-intel/for-linux-next drm-tip/drm-tip drm-exynos/exynos-drm-next airlied/drm-next next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/KuoHsiang-Chou/drm-ast-Create-the-driver-for-ASPEED-proprietory-Display-Port/20211122-183830
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: i386-randconfig-c021-20211123 (https://download.01.org/0day-ci/archive/20220102/202201020329.lEcno4eh-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/ast/ast_dp.c:166:3-4: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
