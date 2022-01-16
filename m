Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B6948FC55
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 12:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiAPLb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 06:31:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:65151 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbiAPLb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 06:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642332717; x=1673868717;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7DfAvPtPxvzuYNgkB3IZgnRqPUprJjtECkW/DRPaWCs=;
  b=PnM8olxLVJ0+PuJtaxKuiN7+03T2MyosBbdqbCS+okqLOoDBjam2mhZY
   TIUnnPeIPgPNppZjdgDhM/zJLCFhivnu3rSipCmEmUDt2K73RfUN9p5mj
   5/bafxWcHMcyyzGOcBWU48+8cppmHYD0gQW4rQlnr4NNRjc4YYeA2lJla
   X77K5RUc4fPxSbpuW0hmF6TbR1ys4OjosOFI8Q+VEqgy9zg4JMb3eNpc8
   6vViZbu3Fx5nsHQ4i4KsYavWCj8Pq/9NErGgZ3M57bPWSfbL9vlE8HMpn
   ueUS34+mZTIxqiBpByd2hz/00BTNajTSB2ABDscmcg6KoOd8nUcrR4Fh0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="307822128"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="307822128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 03:31:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="517060914"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2022 03:31:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n93lK-000AfB-Vj; Sun, 16 Jan 2022 11:31:54 +0000
Date:   Sun, 16 Jan 2022 19:31:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Pascua <pascua.samuel.14@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: dtbs_check: arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml:
 mdss@fd900000: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
Message-ID: <202201161804.sd3UKeLn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a33f5c380c4bd3fa5278d690421b72052456d9fe
commit: 3657b677d20d4b6bda441bd568d037446bd6d880 ARM: dts: qcom: msm8974-klte: add support for display
date:   12 months ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: tcsr-mutex: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: memory@fc428000: 'device_type' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/memory.yaml
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: vadc@3100: 'die_temp', 'ref_1250v', 'ref_625mv', 'ref_buf_625mv', 'ref_gnd', 'ref_vdd' do not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: ocmem@fdd00000: 'ranges' is a required property
   	From schema: Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
   arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: adreno@fdb00000: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
>> arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: mdss@fd900000: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
>> arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: mdp@fd900000: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
>> arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: dsi@fd922800: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
>> arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml: dsi-phy@fd922a00: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
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
