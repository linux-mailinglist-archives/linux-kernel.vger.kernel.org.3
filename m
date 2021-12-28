Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6A480D55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhL1VRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:17:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:30739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhL1VR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640726248; x=1672262248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kow9FGm/Pl0JbZ8Tse+3zfcjTwFgeAuVwtdnDZCds2Q=;
  b=lqsX/GssNfMJ6GxjiuSve4X3F7KdmAkHKpedyHkLxSEgc5NBgIT5ygbd
   P6dVBxOEzLmeZ9NmudDjBT1RyFC2hDZQafaQ4VO0LfMAYqxCcvFEuVFiJ
   wFsq9aVzoCfhMTd3A5vroaQw7JdpFkHNqnaYWfd70l8oe8hrnAAv/LzMH
   7MLQTrZMQpR9EnATfTrZWHH6nfsL9PFNQj+WQRiTrGHVuyR/2mMR7rJgL
   Aiz0QEFi82c3XiEzlQv97hIIUGi8JWMjMZK9G7Xwm0vTGicp4tG7/Ivd7
   jds6NSnti44HPWf8mTjACIacT+veX/0GNZ6UnRRkx1QZdybkYUtROKEBE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241375851"
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="241375851"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 13:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="510286699"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Dec 2021 13:17:26 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2JqY-00083p-80; Tue, 28 Dec 2021 21:17:26 +0000
Date:   Wed, 29 Dec 2021 05:17:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:wip/sm8350-next-20211215 37/44]
 drivers/gpu/drm/i915/display/intel_dp.c:4796:85: error: expected ')'
Message-ID: <202112290511.XYGimJZZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sm8350-next-20211215
head:   12c44709c1bb0b1aba90680327bcdcf9b93a8d2f
commit: 1da0d241cb3c3d9deab1fe98a96d3dfab53fb268 [37/44] drm: Add hpd state to drm_connector_oob_hotplug_event()
config: i386-randconfig-a016-20211228 (https://download.01.org/0day-ci/archive/20211229/202112290511.XYGimJZZ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/1da0d241cb3c3d9deab1fe98a96d3dfab53fb268
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sm8350-next-20211215
        git checkout 1da0d241cb3c3d9deab1fe98a96d3dfab53fb268
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_dp.c:4796:85: error: expected ')'
   static void intel_dp_oob_hotplug_event(struct drm_connector *connector, unsigned in num_lanes)
                                                                                       ^
   drivers/gpu/drm/i915/display/intel_dp.c:4796:39: note: to match this '('
   static void intel_dp_oob_hotplug_event(struct drm_connector *connector, unsigned in num_lanes)
                                         ^
   1 error generated.


vim +4796 drivers/gpu/drm/i915/display/intel_dp.c

  4795	
> 4796	static void intel_dp_oob_hotplug_event(struct drm_connector *connector, unsigned in num_lanes)
  4797	{
  4798		struct intel_encoder *encoder = intel_attached_encoder(to_intel_connector(connector));
  4799		struct drm_i915_private *i915 = to_i915(connector->dev);
  4800	
  4801		spin_lock_irq(&i915->irq_lock);
  4802		i915->hotplug.event_bits |= BIT(encoder->hpd_pin);
  4803		spin_unlock_irq(&i915->irq_lock);
  4804		queue_delayed_work(system_wq, &i915->hotplug.hotplug_work, 0);
  4805	}
  4806	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
