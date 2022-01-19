Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC71493558
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351992AbiASHVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:21:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:35756 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351985AbiASHVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642576890; x=1674112890;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kJI9Cz6/F6ON79POOLvlAmBXzL3XS78Eb3XfCUrvKes=;
  b=Wgm072mi/xEYS7j9JUKw0Fumtodzd1gEEg2LJHeZini6SmdSCSmsph5U
   xXRALRCAkLIiWnNV5re1FokAKTMLnfRceXwdYm98bRQ2kiDUer4qRjW9J
   2mkdfpAiWX65GpLSJHxa+5E+0BZDgmlYqhrYMCFEtTH8uymqZutWA3Dd+
   g5PpBtn1U2evliKrvdguIevIFp18ld30m71i4pEBH1Kw6MuwYFVDdSWNT
   cDGXx4oV+EHni5BAVzLkqkFn3tpkrWtRCaC/DBm3GX6Xr7wmEyzGAjY/N
   ggV28HSzuzDAXUbB6dWI1WBUVT2OAtdE12ec6/eXFzESvkxmBzsJ5XrzM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244799532"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="244799532"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 23:21:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="492938379"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2022 23:21:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA5HV-000DMZ-2O; Wed, 19 Jan 2022 07:21:21 +0000
Date:   Wed, 19 Jan 2022 15:20:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>
Subject: dtbs_check: arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml:
 mdio-mux@18003000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
Message-ID: <202201191541.pGVbjSCX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   112450df61b7373529b0fe4c122ad13b89d80a8a
commit: ad31ce56c434bbd792f3ee79160cedaf20f7f238 dt-bindings: net: mdio: Allow any child node name
date:   9 days ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: usb@22000: port@1: 'compatible' is a required property
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: usb@22000: port@2: 'compatible' is a required property
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: usb@23000: port@1: 'compatible' is a required property
   	From schema: Documentation/devicetree/bindings/usb/generic-xhci.yaml
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: usb@23000: Unevaluated properties are not allowed ('#usb-cells', 'phys', 'phy-names', '#address-cells', '#size-cells', 'port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/usb/generic-xhci.yaml
>> arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: mdio-mux@18003000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: mdio@200: switch@0:reset-names:0: 'phy' was expected
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: switch@0: 'resets' is a dependency of 'reset-names'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/reset/reset.yaml
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: cru@100: $nodename:0: 'cru@100' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml:0:0: /spi@18029200/flash@0/partitions: failed to match any schema with compatible: ['brcm,bcm947xx-cfe-partitions']
   arch/arm/boot/dts/bcm47094-linksys-panamera.dt.yaml: leds: 'bluebar1', 'bluebar2', 'bluebar3', 'bluebar4', 'bluebar5', 'bluebar6', 'bluebar7', 'bluebar8', 'power', 'usb2', 'usb3', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
--
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958522er.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958522er.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958522er.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958522er.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958522er.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
>> arch/arm/boot/dts/bcm958522er.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958522er.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958522er.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958522er.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958522er.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[20]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[20]]} is not of type 'null'
--
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958525er.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958525er.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958525er.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958525er.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958525er.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
>> arch/arm/boot/dts/bcm958525er.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958525er.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958525er.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958525er.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958525er.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[20]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[20]]} is not of type 'null'
--
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958525xmc.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958525xmc.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958525xmc.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958525xmc.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958525xmc.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
>> arch/arm/boot/dts/bcm958525xmc.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958525xmc.dt.yaml:0:0: /axi@18000000/i2c@38000/rtc@68: failed to match any schema with compatible: ['st,m41t81']
   arch/arm/boot/dts/bcm958525xmc.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958525xmc.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958525xmc.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958525xmc.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[20]]} is not of type 'boolean'
   	True was expected
--
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958622hr.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958622hr.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958622hr.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958622hr.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958622hr.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
>> arch/arm/boot/dts/bcm958622hr.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958622hr.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958622hr.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958622hr.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958622hr.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'null'
--
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958623hr.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958623hr.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958623hr.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958623hr.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958623hr.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
>> arch/arm/boot/dts/bcm958623hr.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958623hr.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958623hr.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958623hr.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958623hr.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'null'
--
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml: pwm@31000: #pwm-cells:0:0: 3 was expected
   	From schema: Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
>> arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'null'
--
   	'spi_lr_session_aborted' was expected
   	'spi_lr_impatient' was expected
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml: pwm@31000: #pwm-cells:0:0: 3 was expected
   	From schema: Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
>> arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'null'
--
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml: pwm@31000: #pwm-cells:0:0: 3 was expected
   	From schema: Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
>> arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'null'
--
   	'spi_lr_session_aborted' was expected
   	'spi_lr_impatient' was expected
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml: pwm@31000: #pwm-cells:0:0: 3 was expected
   	From schema: Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
>> arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'null'
--
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: pwm@31000: #pwm-cells:0:0: 3 was expected
   	From schema: Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
>> arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
>> arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: mdio-mux@3f1c0: mdio-mii@2000:reg:0:0: 8192 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: phy@0: '#phy-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/phy/phy-provider.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: phy@1: '#phy-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/phy/phy-provider.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: phy@2: '#phy-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/phy/phy-provider.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: phy@3: '#phy-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/phy/phy-provider.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml: phy@4: '#phy-cells' is a required property
--
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: pwm@31000: #pwm-cells:0:0: 3 was expected
   	From schema: Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
>> arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
>> arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: mdio-mux@3f1c0: mdio-mii@2000:reg:0:0: 8192 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: phy@0: '#phy-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/phy/phy-provider.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: phy@1: '#phy-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/phy/phy-provider.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: phy@2: '#phy-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/phy/phy-provider.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: phy@3: '#phy-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/phy/phy-provider.yaml
   arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml: phy@4: '#phy-cells' is a required property
--
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958625hr.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958625hr.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958625hr.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958625hr.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625hr.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
>> arch/arm/boot/dts/bcm958625hr.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625hr.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958625hr.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625hr.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625hr.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[22]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[22]]} is not of type 'null'
--
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm988312hr.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm988312hr.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm988312hr.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm988312hr.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm988312hr.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
>> arch/arm/boot/dts/bcm988312hr.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm988312hr.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm988312hr.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm988312hr.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm988312hr.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[21]]} is not of type 'null'
--
   	'spi_lr_session_done' was expected
   	'spi_lr_overread' was expected
   	From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   arch/arm/boot/dts/bcm958625k.dt.yaml: usb@2a000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm958625k.dt.yaml: usb@2b000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm958625k.dt.yaml:0:0: /axi@18000000/crypto@2f000: failed to match any schema with compatible: ['brcm,spum-nsp-crypto']
   arch/arm/boot/dts/bcm958625k.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
   arch/arm/boot/dts/bcm958625k.dt.yaml:0:0: /axi@18000000/gpio@30000: failed to match any schema with compatible: ['brcm,iproc-nsp-gpio', 'brcm,iproc-gpio']
>> arch/arm/boot/dts/bcm958625k.dt.yaml: mdio-mux@32000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/bcm958625k.dt.yaml:0:0: /axi@18000000/pinctrl@3f1c0: failed to match any schema with compatible: ['brcm,nsp-pinmux']
   arch/arm/boot/dts/bcm958625k.dt.yaml: ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625k.dt.yaml: ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
   	From schema: Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
   arch/arm/boot/dts/bcm958625k.dt.yaml: pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[23]]} is not of type 'boolean'
   	True was expected
   	{'compatible': ['brcm,iproc-msi'], 'msi-controller': True, 'interrupt-parent': [[1]], 'interrupts': [[0, 127, 4], [0, 128, 4], [0, 129, 4], [0, 130, 4]], 'brcm,pcie-msi-inten': True, 'phandle': [[23]]} is not of type 'null'
--
   arch/arm/boot/dts/ls1021a-qds.dt.yaml: memory-controller@1080000: 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
   arch/arm/boot/dts/ls1021a-qds.dt.yaml:0:0: /soc/msi-controller@1570e00: failed to match any schema with compatible: ['fsl,ls1021a-msi']
   arch/arm/boot/dts/ls1021a-qds.dt.yaml:0:0: /soc/msi-controller@1570e08: failed to match any schema with compatible: ['fsl,ls1021a-msi']
   arch/arm/boot/dts/ls1021a-qds.dt.yaml: ifc@1530000: $nodename:0: 'ifc@1530000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/ls1021a-qds.dt.yaml: ifc@1530000: 'board-control@3,0', 'nand@2,0', 'nor@0,0' do not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/ls1021a-qds.dt.yaml:0:0: /soc/ifc@1530000: failed to match any schema with compatible: ['fsl,ifc', 'simple-bus']
   arch/arm/boot/dts/ls1021a-qds.dt.yaml:0:0: /soc/ifc@1530000/nand@2,0: failed to match any schema with compatible: ['fsl,ifc-nand']
>> arch/arm/boot/dts/ls1021a-qds.dt.yaml: mdio-mux-emi1: mdio@20:reg:0:0: 32 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/ls1021a-qds.dt.yaml: mdio-mux-emi1: mdio@40:reg:0:0: 64 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/ls1021a-qds.dt.yaml: mdio-mux-emi1: mdio@60:reg:0:0: 96 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/ls1021a-qds.dt.yaml: mdio-mux-emi1: mdio@80:reg:0:0: 128 is greater than the maximum of 31
   	From schema: Documentation/devicetree/bindings/net/mdio.yaml
   arch/arm/boot/dts/ls1021a-qds.dt.yaml: mdio-mux-emi1: compatible: ['mdio-mux-mmioreg'] is too short
   	From schema: Documentation/devicetree/bindings/net/mdio-mux-mmioreg.yaml
   arch/arm/boot/dts/ls1021a-qds.dt.yaml:0:0: /soc/dcfg@1ee0000: failed to match any schema with compatible: ['fsl,ls1021a-dcfg', 'syscon']

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
