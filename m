Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4DD48F68E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 12:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiAOLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 06:38:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:38736 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbiAOLiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 06:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642246735; x=1673782735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=te+XRPXVnAnQWjr3MolpY7FohWy56C/DDD/eJ2yxMuw=;
  b=b725CqhCoWyJXI+cf5xvkQRG6+mTVqXQaAkamqGKPixRHljbJVb+2glS
   rrInrXFTBF9F73skYQnyOmM3E4KAqyPWVYHeIBp5sbH08ytTzvw0BZSo8
   dY0UrKkjU/0T0P7J8AJw2yHOyeYdPfB6za6YjsYLGdSu+01lk9Upf/fsC
   zVZO/Udl9wc0lWixHIH0/M9gi1oOlDVxV4coDlq9JgPCLQqb5mTIjMcsu
   fVkeTfw8QJMmqZ+WwTjyrHVdLdcJnKumqVksZvgcrE+z4Mnd5kK6MVKWV
   F5cKdTJTr75qKrhRjUS4Rdgn4WdMzi3sa7ARDOgRlclhOZa/pHf7OyRY6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="225090109"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="225090109"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 03:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="476079796"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jan 2022 03:38:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8hOW-0009i5-PE; Sat, 15 Jan 2022 11:38:52 +0000
Date:   Sat, 15 Jan 2022 19:38:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Pascua <pascua.samuel.14@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: dtbs_check: arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml:
 adreno@fdb00000: status:0: 'ok' is not one of ['okay', 'disabled',
 'reserved']
Message-ID: <202201151818.rxqhq9l8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   871bfa02d08d9c0ed981c50082b7afd367d3700b
commit: 4389eeac4867d0fd906cdaf17bf84d4a8681f59c ARM: dts: qcom: msm8974-klte: add support for GPU
date:   12 months ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: tcsr-mutex: 'reg' is a required property
   	From schema: Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: tcsr-mutex: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: memory@fc428000: 'device_type' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/memory.yaml
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: vadc@3100: 'die_temp', 'ref_1250v', 'ref_625mv', 'ref_buf_625mv', 'ref_gnd', 'ref_vdd' do not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: ocmem@fdd00000: 'ranges' is a required property
   	From schema: Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
>> arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: adreno@fdb00000: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
   schemas/input/input.yaml: ignoring, error in schema: properties: power-off-time-sec
   Traceback (most recent call last):
     File "/usr/local/bin/dt-validate", line 170, in <module>
       sg.check_trees(filename, testtree)
     File "/usr/local/bin/dt-validate", line 119, in check_trees
       self.check_subtree(dt, subtree, False, "/", "/", filename)
     File "/usr/local/bin/dt-validate", line 110, in check_subtree
       self.check_subtree(tree, value, disabled, name, fullname + name, filename)
     File "/usr/local/bin/dt-validate", line 110, in check_subtree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
