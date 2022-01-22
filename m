Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519A0496DEC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiAVUQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:16:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:30345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbiAVUQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642882564; x=1674418564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FJwdhUf4koV20jz1RkeRdU0AmoAFgCOsMxcuvfIYlHg=;
  b=jKbms40tf1Ol+x4g/DAd8qf2gJVJQgvTA9JDDDUPghTMpffEgr6f8oop
   v7RCQFfgi+OrFn3xpMvEIvPqXz0ueKs0U5V38b/UavtIvEbF72ov71MsP
   3MZ+g4YE2584jsJ0TTDXWINkDKRcVnhk7/votB+C8dodBTmIzF0nqBduW
   1Mbq+Epjn1rUrOBM+kfBI8cKVtGne+21oKnnmMFOVw39o/dBqsnU8YN2o
   9BkroCjcr5FLdXqJf9sj4fzXK4VALR1wIrYRhpwYDBIVh3d61FxYk346X
   HPc3G5s/HBeuKzuQVrHbkP72ZgMOCSU03QMhGWtoQiuQY2Doo7L5r75FY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10235"; a="332201041"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="332201041"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 12:16:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="673255707"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2022 12:16:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBMnq-000Gj2-5P; Sat, 22 Jan 2022 20:16:02 +0000
Date:   Sun, 23 Jan 2022 04:15:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: dtbs_check: arch/arm/boot/dts/stm32f429-disco.dt.yaml:
 ethernet@40028000: Unevaluated properties are not allowed ('interrupts',
 'interrupt-names', 'snps,pbl', 'snps,mixed-burst' were unexpected)
Message-ID: <202201230035.EqlzrBVq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
commit: 8650381f33fba33e162db2266ce74f1b87a2f71c dt-bindings: net: Add missing properties used in examples
date:   13 days ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /timer@e000e010: failed to match any schema with compatible: ['arm,armv7m-systick']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/i2c@40005c00/stmpe811@41: failed to match any schema with compatible: ['st,stmpe811']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/i2c@40005c00/stmpe811@41/stmpe_touchscreen: failed to match any schema with compatible: ['st,stmpe-ts']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml: l3gd20@0: 'spi-max-frequency' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/iio/st,st-sensors.yaml
   arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible: ['st,sf-tc240t-9370-t'] is too short
   	From schema: Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/crc@40023000: failed to match any schema with compatible: ['st,stm32f4-crc']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/rcc@40023800: failed to match any schema with compatible: ['st,stm32f42xx-rcc', 'st,stm32-rcc']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/rcc@40023800: failed to match any schema with compatible: ['st,stm32f42xx-rcc', 'st,stm32-rcc']
>> arch/arm/boot/dts/stm32f429-disco.dt.yaml: ethernet@40028000: Unevaluated properties are not allowed ('interrupts', 'interrupt-names', 'snps,pbl', 'snps,mixed-burst' were unexpected)
   	From schema: Documentation/devicetree/bindings/net/stm32-dwmac.yaml
--
   arch/arm/boot/dts/stm32f469-disco.dt.yaml:0:0: /interrupt-controller@e000e100: failed to match any schema with compatible: ['arm,armv7m-nvic']
   arch/arm/boot/dts/stm32f469-disco.dt.yaml:0:0: /timer@e000e010: failed to match any schema with compatible: ['arm,armv7m-systick']
   arch/arm/boot/dts/stm32f469-disco.dt.yaml: display-controller@40016800: port:endpoint@0: 'reg' is a required property
   	From schema: Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
   arch/arm/boot/dts/stm32f469-disco.dt.yaml:0:0: /soc/crc@40023000: failed to match any schema with compatible: ['st,stm32f4-crc']
   arch/arm/boot/dts/stm32f469-disco.dt.yaml:0:0: /soc/rcc@40023800: failed to match any schema with compatible: ['st,stm32f469-rcc', 'st,stm32f42xx-rcc', 'st,stm32-rcc']
   arch/arm/boot/dts/stm32f469-disco.dt.yaml:0:0: /soc/rcc@40023800: failed to match any schema with compatible: ['st,stm32f469-rcc', 'st,stm32f42xx-rcc', 'st,stm32-rcc']
   arch/arm/boot/dts/stm32f469-disco.dt.yaml:0:0: /soc/rcc@40023800: failed to match any schema with compatible: ['st,stm32f469-rcc', 'st,stm32f42xx-rcc', 'st,stm32-rcc']
>> arch/arm/boot/dts/stm32f469-disco.dt.yaml: ethernet@40028000: Unevaluated properties are not allowed ('interrupts', 'interrupt-names', 'snps,pbl', 'snps,mixed-burst' were unexpected)
   	From schema: Documentation/devicetree/bindings/net/stm32-dwmac.yaml
--
>> arch/arm/boot/dts/stm32mp157a-iot-box.dt.yaml: ethernet@5800a000: Unevaluated properties are not allowed ('interrupts-extended', 'interrupt-names', 'snps,mixed-burst', 'snps,pbl', 'snps,en-tx-lpi-clockgating', 'snps,axi-config', 'snps,tso', 'stmmac-axi-config' were unexpected)
   	From schema: Documentation/devicetree/bindings/net/stm32-dwmac.yaml
   arch/arm/boot/dts/stm32mp157a-iot-box.dt.yaml: led: led2:linux,default-trigger:0: 'mmc0' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/stm32mp157a-iot-box.dt.yaml: led: led3:linux,default-trigger:0: 'mmc1' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/stm32mp157a-iot-box.dt.yaml: led: led4:linux,default-trigger:0: 'none' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
--
>> arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dt.yaml: ethernet@5800a000: Unevaluated properties are not allowed ('interrupts-extended', 'interrupt-names', 'snps,mixed-burst', 'snps,pbl', 'snps,en-tx-lpi-clockgating', 'snps,axi-config', 'snps,tso', 'stmmac-axi-config' were unexpected)
   	From schema: Documentation/devicetree/bindings/net/stm32-dwmac.yaml
--
>> arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dt.yaml: ethernet@5800a000: Unevaluated properties are not allowed ('interrupts-extended', 'interrupt-names', 'snps,mixed-burst', 'snps,pbl', 'snps,en-tx-lpi-clockgating', 'snps,axi-config', 'snps,tso', 'stmmac-axi-config' were unexpected)
   	From schema: Documentation/devicetree/bindings/net/stm32-dwmac.yaml
--
>> arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dt.yaml: ethernet@5800a000: Unevaluated properties are not allowed ('interrupts-extended', 'interrupt-names', 'snps,mixed-burst', 'snps,pbl', 'snps,en-tx-lpi-clockgating', 'snps,axi-config', 'snps,tso', 'stmmac-axi-config' were unexpected)
   	From schema: Documentation/devicetree/bindings/net/stm32-dwmac.yaml
--
>> arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dt.yaml: ethernet@5800a000: Unevaluated properties are not allowed ('interrupts-extended', 'interrupt-names', 'snps,mixed-burst', 'snps,pbl', 'snps,en-tx-lpi-clockgating', 'snps,axi-config', 'snps,tso', 'stmmac-axi-config' were unexpected)
   	From schema: Documentation/devicetree/bindings/net/stm32-dwmac.yaml
--
>> arch/arm/boot/dts/stm32mp157a-stinger96.dt.yaml: ethernet@5800a000: Unevaluated properties are not allowed ('interrupts-extended', 'interrupt-names', 'snps,mixed-burst', 'snps,pbl', 'snps,en-tx-lpi-clockgating', 'snps,axi-config', 'snps,tso', 'stmmac-axi-config' were unexpected)
   	From schema: Documentation/devicetree/bindings/net/stm32-dwmac.yaml
   arch/arm/boot/dts/stm32mp157a-stinger96.dt.yaml: led: led2:linux,default-trigger:0: 'mmc0' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/stm32mp157a-stinger96.dt.yaml: led: led3:linux,default-trigger:0: 'mmc1' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/stm32mp157a-stinger96.dt.yaml: led: led4:linux,default-trigger:0: 'none' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
--
>> arch/arm/boot/dts/stm32mp157c-ed1.dt.yaml: ethernet@5800a000: Unevaluated properties are not allowed ('interrupts-extended', 'interrupt-names', 'snps,mixed-burst', 'snps,pbl', 'snps,en-tx-lpi-clockgating', 'snps,axi-config', 'snps,tso', 'stmmac-axi-config' were unexpected)
   	From schema: Documentation/devicetree/bindings/net/stm32-dwmac.yaml
   arch/arm/boot/dts/stm32mp157c-ed1.dt.yaml: stpmic@33: regulators: 'vref_ddr-supply' does not match any of the regexes: '^(buck[1-4]|ldo[1-6]|boost|pwr_sw[1-2])-supply$', '^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$', '^buck[1-4]$', '^ldo[1-2,5-6]$', '^pwr_sw[1-2]$', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
   arch/arm/boot/dts/stm32mp157c-ed1.dt.yaml: gpu@59000000: 'contiguous-area' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/gpu/vivante,gc.yaml

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
