Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD40588E45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiHCOJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbiHCOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B4F248D0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE3F4615D2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD268C433C1;
        Wed,  3 Aug 2022 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659535778;
        bh=WlAkTRdw8QZsxwLa7pmeb2mAMO+G2Cc6e+XgcEB7/d0=;
        h=Date:From:To:Cc:Subject:From;
        b=TXJ4vrm0bn86kXyQFdgSdqWvSB5k5LK+MyVmoo05+Mx6iu0+QLNlYSqe5QImglFWB
         17KucYHebzpM16XK4xh6gFcLzTMvhtiID4c3g5+HIZh1O4lsP+cPX53kOIE4t/oG3g
         mk/e6wjMoq2PoThNiBdMgYfRZt6IaWbFW7k/0QqQ=
Date:   Wed, 3 Aug 2022 16:09:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 6.0-rc1
Message-ID: <YuqBnlRPjwdAJhAo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.0-rc1

for you to fetch changes up to b5276c924497705ca927ad85a763c37f2de98349:

  drivers: lkdtm: fix clang -Wformat warning (2022-07-28 16:20:36 +0200)

----------------------------------------------------------------
Char / Misc driver changes for 6.0-rc1

Here is the large set of char and misc and other driver subsystem
changes for 6.0-rc1.

Highlights include:
	- large set of IIO driver updates, additions, and cleanups
	- new habanalabs device support added (loads of register maps
	  much like GPUs have)
	- soundwire driver updates
	- phy driver updates
	- slimbus driver updates
	- tiny virt driver fixes and updates
	- misc driver fixes and updates
	- interconnect driver updates
	- hwtracing driver updates
	- fpga driver updates
	- extcon driver updates
	- firmware driver updates
	- counter driver update
	- mhi driver fixes and updates
	- binder driver fixes and updates
	- speakup driver fixes

Full details are in the long shortlog contents.

All of these have been in linux-next for a while without any reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: phy: mxs-usb-phy: Add i.MX8DXL compatible string

Aidan MacDonald (2):
      extcon: sm5502: Drop useless mask_invert flag on irqchip
      extcon: rt8973a: Drop useless mask_invert flag on irqchip

Akira Yokosawa (1):
      iio: proximity: sx9324: add empty line in front of bullet list

Alexander Shishkin (4):
      intel_th: msu: Fix vmalloced buffers
      intel_th: pci: Add Meteor Lake-P support
      intel_th: pci: Add Raptor Lake-S PCH support
      intel_th: pci: Add Raptor Lake-S CPU support

Alexander Stein (1):
      dt-bindings: iio: adc: Add imx6ul & imx6sx compatibles

Alexandru Tachici (5):
      dt-bindings: iio: accel: ADIS16240: update maintainers
      dt-bindings: iio: adc: AD9467: update maintainers
      dt-bindings: iio: adc: axi-adc: update maintainers
      dt-bindings: iio: dac: AD5770R: update maintainers
      dt-bindings: iio: imu: adis16480: update maintainers

Alim Akhtar (3):
      dt-bindings: phy: Add FSD UFS PHY bindings
      phy: samsung-ufs: move cdr offset to drvdata
      phy: samsung-ufs: add support for FSD ufs phy driver

Allen-KH Cheng (1):
      dt-bindings: nvmem: mediatek: efuse: add support for mt8186

Andy Shevchenko (25):
      iio: trigger: stm32-lptimer-trigger: Make use of device properties
      iio: proximity: srf04: Make use of device properties
      iio: imu: st_lsm6dsx: Switch from of headers to mod_devicetable.h
      iio: adc: sd_adc_modulator: Drop dependency on OF
      iio: adc: envelope-detector: Drop dependency on OF
      iio: adc: lpc18xx_adc: Switch from of headers to mod_devicetable.h
      iio: dac: ad5592r: Get rid of OF specifics
      iio: adc: vf610_adc: Make use of device properties
      iio: adc: nau7802: Convert driver to use ->probe_new()
      iio: adc: nau7802: Make use of device properties
      iio: adc: intel_mrfld_adc: explicitly add proper header files
      iio: adc: sc27xx_adc: Re-use generic struct u32_fract
      iio: adc: meson_saradc: Don't attach managed resource to IIO device object
      iio: adc: meson_saradc: Align messages to be with physical device prefix
      iio: adc: meson_saradc: Convert to use dev_err_probe()
      iio: adc: meson_saradc: Use devm_clk_get_optional()
      iio: adc: meson_saradc: Use temporary variable for struct device
      iio: adc: meson_saradc: Use regmap_read_poll_timeout() for busy wait
      iio: accel: mma7660: Drop wrong use of ACPI_PTR()
      iio: dac: stm32-dac: Replace open coded str_enable_disable()
      phy: ti: tusb1210: Don't check for write errors when powering on
      iio: adc: xilinx-xadc: Make use of device properties
      iio: adc: xilinx-xadc: Drop duplicate NULL check in xadc_parse_dt()
      iio: proximity: sx_common: Don't use IIO device for properties
      iio: proximity: sx_common: Allow IIO core to take care of firmware node

Ang Tien Sung (4):
      firmware: stratix10-svc: Add support for FCS
      firmware: stratix10-svc: add FCS polling command
      firmware: stratix10-svc: add new FCS commands
      firmware: stratix10-svc: To support a command ATF Get Version

AngeloGioacchino Del Regno (1):
      nvmem: mtk-efuse: Simplify with devm_platform_get_and_ioremap_resource()

Bagas Sanjaya (1):
      Documentation: coresight: Escape coresight bindings file wildcard

Benjamin Dotan (1):
      habanalabs/gaudi2: add gaudi2 profiler module

Biju Das (2):
      dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
      iio: adc: rzg2l_adc: Remove unnecessary channel check from rzg2l_adc_read_label()

Bjorn Andersson (1):
      bus: mhi: host: pci_generic: Add another Foxconn T99W175

Bo Liu (1):
      bus: mhi: ep: Check dev_set_name() return value

Borislav Petkov (1):
      misc: Mark MICROCODE_MINOR unused

Bryan O'Donoghue (1):
      interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth

Caleb Connolly (5):
      spmi: add a helper to look up an SPMI device from a device node
      mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
      mfd: qcom-spmi-pmic: read fab id on supported PMICs
      dt-bindings: iio: adc: document qcom-spmi-rradc
      iio: adc: qcom-spmi-rradc: introduce round robin adc

Carlos Llamas (2):
      MAINTAINERS: update Android driver maintainers
      binder: fix redefinition of seq_file attributes

Chanho Park (8):
      dt-bindings: phy: samsung,ufs-phy: make pmu-syscon as phandle-array
      phy: samsung: ufs: rename cfg to cfgs for clarification
      phy: samsung: ufs: constify samsung_ufs_phy_cfg
      phy: samsung: ufs: remove drvdata from struct samsung_ufs_phy
      phy: samsung: ufs: support secondary ufs phy
      phy: samsung: exynosautov9-ufs: correct TSRV register configurations
      phy: samsung-ufs: convert phy clk usage to clk_bulk API
      phy: samsung-ufs: ufs: change phy on/off control

Christoph Hellwig (1):
      remove CONFIG_ANDROID

Christophe JAILLET (6):
      misc: rtsx: Fix an error handling path in rtsx_pci_probe()
      sgi-xp: Use the bitmap API to allocate bitmaps
      intel_th: Fix a resource leak in an error handling path
      habanalabs: Use the bitmap API to allocate bitmaps
      cxl: Use the bitmap API to allocate bitmaps
      cxl: Fix a memory leak in an error handling path

Chunfeng Yun (3):
      dt-bindings: nvmem: convert mtk-efuse.txt to YAML schema
      dt-bindings: nvmem: mediatek: efuse: add support mt8183
      dt-bindings: phy: mediatek: tphy: add compatible for mt8188

Claudiu Beznea (2):
      dt-bindings: microchip-otpc: document Microchip OTPC
      nvmem: microchip-otpc: add support

Colin Ian King (4):
      lkdtm: cfi: use NULL for a null pointer rather than zero
      fpga: fpga-mgr: Fix spelling mistake "bitsream" -> "bitstream"
      iio: adc: qcom-spmi-rradc: Fix spelling mistake "coherrency" -> "coherency"
      extcon: Remove extraneous space before a debug message

Cosmin Tanislav (2):
      iio: accel: adxl367: do not update FIFO watermark on scan mode update
      iio: addac: ad74413r: for_each_set_bit_from -> for_each_set_bit

Dafna Hirschfeld (8):
      habanalabs: add terminating NULL to attrs arrays
      habanalabs: move memory_scrub_val to hdev struct
      habanalabs: don't do memory scrubbing when unmapping
      habanalabs: don't send addr and size to scrub_device_mem cb
      habanalabs/gaudi: use memory_scrub_val from debugfs
      habanalabs: move call to scrub_device_mem after ctx_fini
      habanalabs: set default value for memory_scrub
      habanalabs/gaudi: replace hl_poll_timeout with while loop

Dan Carpenter (3):
      habanalabs: fix double unlock on error in map_device_va()
      eeprom: idt_89hpesx: uninitialized data in idt_dbgfs_csr_write()
      iio: adc: max1027: unlock on error path in max1027_read_single_value()

Dan Rapaport (1):
      habanalabs: align ioctl uapi structures to 64-bit

Dani Liberman (1):
      habanalabs: avoid unnecessary error print

David Collins (1):
      spmi: trace: fix stack-out-of-bound access in SPMI tracing functions

Dinh Nguyen (1):
      firmware: stratix10-svc: fix kernel-doc warning

Dmitry Baryshkov (60):
      phy: qcom-qmp: create copies of QMP PHY driver
      phy: qcom-qmp-pcie: drop all non-PCIe compatibles support
      phy: qcom-qmp-pcie-msm8996: drop all compatibles except msm8996-pcie-phy
      phy: qcom-qmp-ufs: drop all non-UFS compatibles support
      phy: qcom-qmp-usb: drop all non-USB compatibles support
      phy: qcom-qmp-combo: drop all non-combo compatibles support
      phy: qcom-qmp-combo: change symbol prefix to qcom_qmp_phy_combo
      phy: qcom-qmp-pcie: change symbol prefix to qcom_qmp_phy_pcie
      phy: qcom-qmp-pcie: change symbol prefix to qcom_qmp_phy_pcie_msm8996
      phy: qcom-qmp-ufs: change symbol prefix to qcom_qmp_phy_ufs
      phy: qcom-qmp-usb: change symbol prefix to qcom_qmp_phy_usb
      phy: qcom-qmp: switch to new split QMP PHY driver
      phy: qcom-qmp: drop old QMP PHY driver source
      phy: qcom-qmp-combo: drop support for PCIe,UFS PHY types
      phy: qcom-qmp-pcie: drop support for non-PCIe PHY types
      phy: qcom-qmp-pcie-msm8996: drop support for non-PCIe PHY types
      phy: qcom-qmp-ufs: drop support for non-UFS PHY types
      phy: qcom-qmp-usb: drop support for non-USB PHY types
      phy: qcom-qmp-combo: cleanup the driver
      phy: qcom-qmp-pcie: cleanup the driver
      phy: qcom-qmp-pcie-msm8996: cleanup the driver
      phy: qcom-qmp-ufs: cleanup the driver
      phy: qcom-qmp-usb: cleanup the driver
      phy: qcom-qmp-pcie: drop multi-PHY support
      phy: qcom-qmp-ufs: drop multi-PHY support
      phy: qcom-qmp-usb: drop multi-PHY support
      phy: qcom-qmp-combo: use bulk reset_control API
      phy: qcom-qmp-pcie: use bulk reset_control API
      phy: qcom-qmp-pcie-msm8996: use bulk reset_control API
      phy: qcom-qmp-usb: use bulk reset_control API
      phy: qcom-qmp: fix msm8996 PCIe PHY support
      phy: qcom-qmp: fix PCIe PHY support
      phy: qcom-qmp: fix the QSERDES_V5_COM_CMN_MODE register
      phy: qcom-qmp-ufs: remove spurious register write in the msm8996 table
      phy: qcom-qmp-combo,usb: add support for separate PCS_USB region
      phy: qcom-qmp-pcie: split pcs_misc region for ipq6018 pcie gen3
      phy: qcom-qmp: drop special QMP V2 PCIE gen3 defines
      phy: qcom-qmp: rename QMP V2 PCS registers
      phy: qcom-qmp: use QPHY_V4_PCS for ipq6018/ipq8074 PCIe gen3
      phy: qcom-qmp: move QSERDES registers to separate header
      phy: qcom-qmp: move QSERDES V3 registers to separate headers
      phy: qcom-qmp: move QSERDES V4 registers to separate headers
      phy: qcom-qmp: move QSERDES V5 registers to separate headers
      phy: qcom-qmp: move QSERDES PLL registers to separate header
      phy: qcom-qmp: move PCS V2 registers to separate header
      phy: qcom-qmp: move PCS V3 registers to separate headers
      phy: qcom-qmp: move PCS V4 registers to separate headers
      phy: qcom-qmp: move PCS V5 registers to separate headers
      phy: qcom-qmp: move PCIE QHP registers to separate header
      phy: qcom-qmp: split allegedly 4.20 and 5.20 TX/RX registers
      phy: qcom-qmp: split allegedly 4.20 and 5.20 PCS registers
      phy: qcom-qmp: split PCS_UFS V3 symbols to separate header
      phy: qcom-qmp: qserdes-com: add missing registers
      phy: qcom-qmp: qserdes-com-v3: add missing registers
      phy: qcom-qmp: qserdes-com-v4: add missing registers
      phy: qcom-qmp: qserdes-com-v5: add missing registers
      phy: qcom-qmp: pcs-v3: add missing registers
      phy: qcom-qmp: pcs-pcie-v4: add missing registers
      phy: qcom-qmp-usb: replace FLL layout writes for msm8996
      phy: qcom-qmp-usb: define QPHY_V2_PCS_PLL_LOCK_CHK_DLY_TIME register

Dmitry Rokosov (2):
      iio: trigger: warn about non-registered iio trigger getting attempt
      iio: trigger: move trig->owner init to trigger allocate() stage

Douglas Anderson (1):
      dt-bindings: phy: List supplies for qcom,edp-phy

Fabien Parent (2):
      dt-bindings: phy: mediatek,dsi-phy: Add MT8365 SoC bindings
      dt-bindings: phy: mediatek,tphy: add MT8365 SoC bindings

Fabrice Gasnier (1):
      phy: stm32: fix error return in stm32_usbphyc_phy_init

Fawzi Khaber (1):
      iio: fix iio_format_avail_range() printing for none IIO_VAL_INT

Geert Uytterhoeven (1):
      dt-bindings: phy: renesas: usb3-phy: Spelling s/funcional/functional/

Georgi Djakov (3):
      Merge branch 'icc-sm6350' into icc-next
      Merge branch 'icc-imx8mp' into icc-next
      Merge branch 'icc-rpm' into icc-next

Greg Kroah-Hartman (13):
      Merge tag 'fpga-for-5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge 5.19-rc4 into char-misc-next
      Merge 5.19-rc6 into char-misc-next
      Merge tag 'mhi-for-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'fpga-late-for-5.20-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'coresight-next-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'misc-habanalabs-next-2022-07-12' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next
      Merge tag 'iio-for-5.20a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'soundwire-5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-next
      Merge tag 'icc-5.20-rc1-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'extcon-next-for-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'phy-for-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next
      Merge tag 'iio-for-5.20b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next

Gwendal Grignou (12):
      iio: ABI: Add a new location label
      iio: common: cros_ec_sensors: Add label attribute
      iio: sx9324: Fix register field spelling
      dt-bindings: iio: sx9324: Add precharge resistor setting
      iio: sx9324: Add precharge internal resistance setting
      dt-bindings: iio: sx9324: Add internal compensation resistor setting
      iio: sx9324: Add Setting for internal compensation resistor
      dt-bindings: iio: sx9324: Add input analog gain
      iio: sx9324: Add Setting for internal analog gain
      dt-bindings: iio: sx9360: Add precharge resistor setting
      iio: sx9360: Add pre-charge resistor setting
      iio: cros: Register FIFO callback after sensor is registered

Hui.Liu (1):
      dt-bindings: iio: adc: Add compatible for MT8188

Ivan Bornyakov (5):
      fpga: fpga-mgr: support bitstream offset in image buffer
      docs: fpga: mgr: document parse_header() callback
      fpga: microchip-spi: add Microchip MPF FPGA manager
      dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
      MAINTAINERS: add Microchip PolarFire FPGA drivers entry

Jagath Jog J (8):
      iio: accel: bma400: Fix the scale min and max macro values
      iio: accel: bma400: Reordering of header files
      iio: accel: bma400: conversion to device-managed function
      iio: accel: bma400: Add triggered buffer support
      iio: accel: bma400: Add separate channel for step counter
      iio: accel: bma400: Add step change event
      iio: accel: bma400: Add activity recognition support
      iio: accel: bma400: Add support for activity and inactivity events

James Clark (4):
      coresight: Add config flag to enable branch broadcast
      Documentation: coresight: Turn numbered subsections into real subsections
      Documentation: coresight: Link config options to existing documentation
      Documentation: coresight: Expand branch broadcast documentation

Jean-Philippe Brucker (1):
      uacce: Handle parent device removal or parent driver module rmmod

Jiang Jian (9):
      misc: sgi-gru: grukservices: drop unexpected word "the" in the comments
      apm-emulation: drop unexpected word "the" in the comments
      sgi-xp: xpc_uv: drop unexpected word "the" in the comments
      cxl: drop unexpected word "the" in the comments
      iio: dac: ad5380: align '*' each line and drop unneeded blank line
      phy: dphy: drop unexpected word "the" in the comments
      phy: phy-brcm-usb: drop unexpected word "the" in the comments
      extcon: Drop unexpected word "the" in the comments
      iio: magnetometer: hmc5843: Remove duplicate 'the'

Jianjun Wang (2):
      dt-bindings: phy: mediatek: Add YAML schema for PCIe PHY
      phy: mediatek: Add PCIe PHY driver

Jiapeng Chong (2):
      habanalabs: Fix kernel-doc
      habanalabs: Fix kernel-doc

Jiasheng Jiang (1):
      intel_th: msu-sink: Potential dereference of null pointer

Joe Simmons-Talbott (4):
      iio: Use octal permissions and DEVICE_ATTR_{RO,RW}.
      iio: Don't use bare "unsigned"
      iio: Use parens with sizeof
      iio: Be consistent with allocation result tests.

Johan Hovold (6):
      phy: qcom-qmp-pcie: drop obsolete pipe clock type check
      phy: qcom-qmp-pcie-msm8996: drop obsolete pipe clock type check
      phy: qcom-qmp-usb: clean up pipe clock handling
      phy: qcom-qmp: clean up v4 and v5 define order
      phy: qcom-qmp: clean up define alignment
      phy: qcom-qmp: clean up hex defines

Jonathan Cameron (145):
      iio: core: drop iio_get_time_res()
      iio: adc: adi-axi: Move exported symbols into IIO_ADI_AXI namespace.
      iio: gyro: mpu3050: Drop unused symbol exports.
      iio: gyro: mpu3050: Use pm_ptr() and DEFINE_RUNTIME_DEV_PM_OPS()
      iio: core: Fix IIO_ALIGN and rename as it was not sufficiently large
      iio: accel: adxl313: Fix alignment for DMA safety
      iio: accel: adxl355: Fix alignment for DMA safety
      iio: accel: adxl367: Fix alignment for DMA safety
      iio: accel: bma220: Fix alignment for DMA safety
      iio: accel: bmi088: Fix alignment for DMA safety
      iio: accel: sca3000: Fix alignment for DMA safety
      iio: accel: sca3300: Fix alignment for DMA safety
      iio: adc: ad7266: Fix alignment for DMA safety
      iio: adc: ad7280a: Fix alignment for DMA safety
      iio: adc: ad7292: Fix alignment for DMA safety
      iio: adc: ad7298: Fix alignment for DMA safety
      iio: adc: ad7476: Fix alignment for DMA safety
      iio: adc: ad7606: Fix alignment for DMA safety
      iio: adc: ad7766: Fix alignment for DMA safety
      iio: adc: ad7768-1: Fix alignment for DMA safety
      iio: adc: ad7887: Fix alignment for DMA safety
      iio: adc: ad7923: Fix alignment for DMA safety
      iio: adc: ad7949: Fix alignment for DMA safety
      iio: adc: hi8435: Fix alignment for DMA safety
      iio: adc: ltc2496: Fix alignment for DMA safety
      iio: adc: ltc2497: Fix alignment for DMA safety
      iio: adc: max1027: Fix alignment for DMA safety
      iio: adc: max11100: Fix alignment for DMA safety
      iio: adc: max1118: Fix alignment for DMA safety
      iio: adc: max1241: Fix alignment for DMA safety
      iio: adc: mcp320x: Fix alignment for DMA safety
      iio: adc: ti-adc0832: Fix alignment for DMA safety
      iio: adc: ti-adc084s021: Fix alignment for DMA safety
      iio: adc: ti-adc108s102: Fix alignment for DMA safety
      iio: adc: ti-adc12138: Fix alignment for DMA safety
      iio: adc: ti-adc128s052: Fix alignment for DMA safety
      iio: adc: ti-adc161s626: Fix alignment for DMA safety
      iio: adc: ti-ads124s08: Fix alignment for DMA safety
      iio: adc: ti-ads131e08: Fix alignment for DMA safety
      iio: adc: ti-ads7950: Fix alignment for DMA safety
      iio: adc: ti-ads8344: Fix alignment for DMA safety
      iio: adc: ti-ads8688: Fix alignment for DMA safety
      iio: adc: ti-tlc4541: Fix alignment for DMA safety
      iio: addac: ad74413r: Fix alignment for DMA safety
      iio: amplifiers: ad8366: Fix alignment for DMA safety
      iio: common: ssp: Fix alignment for DMA safety
      iio: dac: ad5064: Fix alignment for DMA safety
      iio: dac: ad5360: Fix alignment for DMA safety
      iio: dac: ad5421: Fix alignment for DMA safety
      iio: dac: ad5449: Fix alignment for DMA safety
      iio: dac: ad5504: Fix alignment for DMA safety
      iio: dac: ad5592r: Fix alignment for DMA safety
      iio: dac: ad5686: Fix alignment for DMA safety
      iio: dac: ad5755: Fix alignment for DMA safety
      iio: dac: ad5761: Fix alignment for DMA safety
      iio: dac: ad5764: Fix alignment for DMA safety
      iio: dac: ad5766: Fix alignment for DMA safety
      iio: dac: ad5770r: Fix alignment for DMA safety
      iio: dac: ad5791: Fix alignment for DMA saftey
      iio: dac: ad7293: Fix alignment for DMA safety
      iio: dac: ad7303: Fix alignment for DMA safety
      iio: dac: ad8801: Fix alignment for DMA safety
      iio: dac: ltc2688: Fix alignment for DMA safety
      iio: dac: mcp4922: Fix alignment for DMA safety
      iio: dac: ti-dac082s085: Fix alignment for DMA safety
      iio: dac: ti-dac5571: Fix alignment for DMA safety
      iio: dac: ti-dac7311: Fix alignment for DMA safety
      iio: dac: ti-dac7612: Fix alignment for DMA safety
      iio: frequency: ad9523: Fix alignment for DMA safety
      iio: frequency: adf4350: Fix alignment for DMA safety
      iio: frequency: adf4371: Fix alignment for DMA safety
      iio: frequency: admv1013: Fix alignment for DMA safety
      iio: frequency: admv1014: Fix alignment for DMA safety
      iio: frequency: admv4420: Fix alignment for DMA safety
      iio: frequency: adrf6780: Fix alignment for DMA safety
      iio: gyro: adis16080: Fix alignment for DMA safety
      iio: gyro: adis16130: Fix alignment for DMA safety
      iio: gyro: adxrs450: Fix alignment for DMA safety
      iio: gyro: fxas210002c: Fix alignment for DMA safety
      iio: imu: fxos8700: Fix alignment for DMA safety
      iio: imu: inv_icm42600: Fix alignment for DMA safety
      iio: imu: inv_icm42600: Fix alignment for DMA safety in buffer code.
      iio: imu: mpu6050: Fix alignment for DMA safety
      iio: potentiometer: ad5110: Fix alignment for DMA safety
      iio: potentiometer: ad5272: Fix alignment for DMA safety
      iio: potentiometer: max5481: Fix alignment for DMA safety
      iio: potentiometer: mcp41010: Fix alignment for DMA safety
      iio: potentiometer: mcp4131: Fix alignment for DMA safety
      iio: pressure: dlhl60d: Drop unnecessary alignment forcing.
      iio: proximity: as3935: Fix alignment for DMA safety
      iio: proximity: vcnl3020: Drop unnecessary alignment requirement for i2c device
      iio: resolver: ad2s1200: Fix alignment for DMA safety
      iio: resolver: ad2s90: Fix alignment for DMA safety
      iio: temp: ltc2983: Fix alignment for DMA safety
      iio: temp: max31865: Fix alignment for DMA safety
      iio: temp: maxim_thermocouple: Fix alignment for DMA safety
      iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() etc
      iio: humidity: hts221: Use EXPORT_SIMPLE_DEV_PM_OPS() to allow compiler to remove dead code.
      iio: humidity: hts221: Move symbol exports into IIO_HTS221 namespace
      iio: imu: lsm6dsx: Use new pm_sleep_ptr() and EXPORT_SIMPLE_DEV_PM_OPS()
      iio: imu: lsm6dsx: Move exported symbols to the IIO_LSM6DSX namespace
      Merge branch 'immutable-qcom-spmi-rradc' into togreg
      iio: imu: bmi160: Move exported symbols to IIO_BMI160 namespace
      iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace
      iio: chemical: sps30: Move symbol exports into IIO_SPS30 namespace
      iio: ABI: temperature: Unify documentation for thermocouple fault detection.
      iio: ABI: max31865: Drop in_filter_notch_centre_frequency as in main docs.
      iio: ABI: stm32-timer-trigger: Fuse unusual ABI into main doc.
      iio: adc: ti-ads124s08: Drop unused parameter to ads124s_read()
      iio: accel: bma220: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: ad799x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: at91-sam5d2: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: imx7d_adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: meson_saradc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: mt6577_auxadc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: stmpe-adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: ti-am335x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: xilinx-ams: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: chemical: scd4x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: ds4424: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: ltc1660: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: max517: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: max5821: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: mcp4725: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: gyro: itg3200: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: health: afe4403: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: health: afe4404: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: al3010: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: al3320a: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: as73211: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: bh1750: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: cm3605: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: proximity: cros_ec_mkbp: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: temperature: ltc2983: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: us5182: Switch from CONFIG_PM guards to pm_ptr() etc
      iio: adc: imx8qxp: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
      iio: light: gp2ap002: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
      iio: light: isl29028: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
      iio: light: tsl2583: Use DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
      iio: light: tsl2591: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
      iio: light: vcnl4000: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
      iio: light: vcnl4035: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
      iio: light: veml6030: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
      iio: magnetometer: ak8974: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
      iio: magn: yas530: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros

Julia Lawall (3):
      iio: proximity: ping: fix typo in comment
      iio: chemical: bme680: fix typo in comment
      slimbus: messaging: fix typos in comments

Justin Stitt (3):
      eeprom: idt_89hpesx: fix clang -Wformat warnings
      mei: me: fix clang -Wformat warning
      drivers: lkdtm: fix clang -Wformat warning

Kah Jing Lee (2):
      firmware: stratix10-rsu: extend RSU driver to get DCMF status
      firmware: stratix10-svc: extend svc to support RSU feature

Kai-Heng Feng (1):
      iio: light: cm32181: Add PM support

Kalesh Singh (1):
      pm/sleep: Add PM_USERSPACE_AUTOSLEEP Kconfig

Koby Elbaz (2):
      habanalabs/gaudi: fix incorrect MME offset calculation
      habanalabs/gaudi: fix warning: var might be used uninitialized

Kory Maincent (2):
      iio: dac: mcp4922: add support to mcp4921
      dt-bindings: iio: dac: mcp4922: expand for mcp4921 support

Kuogee Hsieh (3):
      phy: qcom-edp: add regulator_set_load to edp phy
      phy: qcom-qmp: add regulator_set_load to dp phy
      drm/msm/dp: delete vdda regulator related functions from eDP/DP controller

LI Qingwu (12):
      iio: accel: bmi088: Modified the scale calculate
      iio: accel: bmi088: Make it possible to config scales
      iio: accel: bmi088: modified the device name
      iio: accel: bmi088: Add support for bmi085 accel
      iio: accel: bmi088: Add support for bmi090l accel
      dt-bindings: iio: accel: Add bmi085 and bmi090l bindings
      dt-bindings: iio: accel: sca3300: Document murata,scl3300
      iio: accel: sca3300: add define for temp channel for reuse.
      iio: accel: sca3300: modified to support multi chips
      iio: accel: sca3300: Add support for SCL3300
      iio: accel: sca3300: Add inclination channels
      iio: accel: sca3300: Extend the trigger buffer from 16 to 32 bytes

Lars-Peter Clausen (2):
      phy: cadence: Sierra: Remove unused `regmap` field from state struct
      phy: cadence-torrent: Remove unused `regmap` field from state struct

Leo Yan (6):
      interconnect: qcom: msm8939: Use icc_sync_state
      dt-bindings: interconnect: Update property for icc-rpm path tag
      interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
      interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
      interconnect: qcom: icc-rpm: Support multiple buckets
      interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values

Li Li (1):
      Binder: add TF_UPDATE_TXN to replace outdated txn

Li Zhengyu (1):
      iio: srf08: Remove redundant if statement

Liam Beguin (5):
      iio: test: rescale: add MODULE_* information
      iio: test: format: add MODULE_* information
      iio: test: format: follow CONFIG_ naming convention
      iio: afe: rescale: export symbols used during testing
      iio: test: rework Kconfig to support modules

Liu Ying (3):
      dt-bindings: vendor-prefixes: Add prefix for Mixel, Inc.
      dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS PHY binding
      phy: freescale: Add i.MX8qm Mixel LVDS PHY support

Luca Weiss (5):
      proximity: vl53l0x: Make VDD regulator actually optional
      interconnect: qcom: icc-rpmh: Support child NoC device probe
      dt-bindings: interconnect: qcom: Split out rpmh-common bindings
      dt-bindings: interconnect: Add Qualcomm SM6350 NoC support
      interconnect: qcom: Add SM6350 driver support

Lukas Bulwahn (3):
      MAINTAINERS: add include/dt-bindings/phy to GENERIC PHY FRAMEWORK
      MAINTAINERS: add include/dt-bindings/iio to IIO SUBSYSTEM AND DRIVERS
      MAINTAINERS: rectify file pattern in MICROCHIP OTPC DRIVER

Marco Pagani (1):
      fpga: altera-pr-ip: fix unsigned comparison with less than zero

Marcus Folkesson (3):
      iio: adc: ti-tsc2046: do not explicity set INDIO_BUFFER_TRIGGERED mode
      iio: adc: ad778-1: do not explicity set INDIO_BUFFER_TRIGGERED mode
      iio: magnetometer: rm3100: do not explicity set INDIO_BUFFER_TRIGGERED mode

Marek Vasut (1):
      dt-bindings: iio/accel: Fix adi,adxl345/6 example I2C address

Markus Schneider-Pargmann (1):
      phy: phy-mtk-dp: Add driver for DP phy

Markuss Broks (4):
      dt-bindings: proximity: vl53l0x: Document optional supply and GPIO properties
      proximity: vl53l0x: Prefer pre-initialized interrupt flags
      proximity: vl53l0x: Handle the VDD regulator
      proximity: vl53l0x: Handle the reset GPIO

Michael Wu (1):
      extcon: Add EXTCON_DISP_CVBS and EXTCON_DISP_EDP

Mike Leach (2):
      coresight: configfs: Fix unload of configurations on module exit
      coresight: syscfg: Update load and unload operations

Moti Haimovski (1):
      habanalabs: add gaudi2 MMU support

Neil Armstrong (2):
      dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
      phy: amlogic: Add G12A Analog MIPI D-PHY driver

Nick Desaulniers (1):
      coresight: etm4x: avoid build failure with unrolled loops

Nuno Sá (19):
      iio: adc: ad7606: explicitly add proper header files
      iio: adc: ad7606_par: explicitly add proper header files
      iio: adc: berlin2-adc: explicitly add proper header files
      iio: adc: imx7d_adc: explicitly add proper header files
      iio: adc: imx8qxp-adc: explicitly add proper header files
      iio: adc: ingenic-adc: explicitly add proper header files
      iio: adc: mp2629_adc: explicitly add proper header files
      iio: adc: mt6360-adc: explicitly add proper header files
      iio: adc: npcm_adc: explicitly add proper header files
      iio: adc: rzg2l_adc: explicitly add proper header files
      iio: common: cros_ec_lid_angle: explicitly add proper header files
      iio: common: cros_ec_sensors: explicitly add proper header files
      iio: dac: stm32-dac: explicitly add proper header files
      iio: dac: vf610_dac: explicitly add proper header files
      iio: humidity: hts221_buffer: explicitly add proper header files
      iio: light: cros_ec_light_prox: explicitly add proper header files
      iio: pressure: cros_ec_baro: explicitly add proper header files
      iio: trigger: stm32-lptimer-trigger: explicitly add proper header files
      iio: core: drop of.h from iio.h

Oded Gabbay (32):
      habanalabs/gaudi: fix comment to reflect current code
      habanalabs: remove unused get_dma_desc_list_size
      habanalabs: check fence pointer before use
      habanalabs: print pointer with correct modifier
      habanalabs: use kvcalloc when possible
      habanalabs: fix comment style
      habanalabs/goya: move dma direction enum to uapi file
      habanalabs/gaudi: fix function name in comment
      habanalabs/gaudi: use correct type in assignment
      habanalabs/gaudi: mask constant value before cast
      habanalabs/gaudi: remove unused enum
      habanalabs/gaudi: enable error interrupt on ARB WDT
      habanalabs: use %pa to print pci bar size
      habanalabs/gaudi2: add asic registers header files
      uapi: habanalabs: add gaudi2 defines
      habanalabs: add gaudi2 asic-specific code
      habanalabs: add unsupported functions
      habanalabs: initialize new asic properties
      habanalabs: remove obsolete device variables used for testing
      habanalabs: add gaudi2 wait-for-CS support
      habanalabs: enable gaudi2 code in driver
      habanalabs: allow detection of unsupported f/w packets
      habanalabs/gaudi2: remove unused variable
      habanalabs/gaudi2: SM mask can only be 8-bit
      habanalabs: don't declare tmp twice in same function
      habanalabs: make sure variable is set before used
      habanalabs/gaudi2: remove unused defines
      habanalabs: initialize variable explicitly
      habanalabs: fix update of is_in_soft_reset
      habanalabs: add status of reset after device release
      habanalabs: rename soft reset to compute reset
      habanalabs: move h/w dirty message to debug

Ofir Bitton (10):
      habanalabs/gaudi: fix shift out of bounds
      habanalabs: print if firmware is secured during load
      habanalabs: remove redundant argument in access_dev_mem APIs
      habanalabs: add generic security module
      habanalabs/gaudi2: add gaudi2 security module
      habanalabs/gaudi2: reset device upon critical ECC event
      habanalabs: naming refactor of user interrupt flow
      habanalabs: add support for common decoder interrupts
      habanalabs: do not set max power on a secured device
      habanalabs: expose only valid debugfs nodes

Ohad Sharabi (6):
      habanalabs: refactor dma asic-specific functions
      habanalabs: page size can only be a power of 2
      habanalabs: communicate supported page sizes to user
      habanalabs: wait for preboot ready after hard reset
      habanalabs/gaudi2: use DIV_ROUND_UP_SECTOR_T instead of roundup
      habanalabs: fixes to the poll-timeout macros

Olivier Moysan (2):
      iio: adc: stm32-adc: make safe adc disable
      iio: adc: stm32-adc: disable adc before calibration

Pascal Terjan (1):
      vboxguest: Do not use devm for irq

Paul Cercueil (2):
      iio: imu: st_lsm6dsx: Limit requested watermark value to hwfifo size
      iio: at91-sama5d2: Limit requested watermark value to hwfifo size

Peng Fan (9):
      dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
      dt-bindings: interconnect: add fsl,imx8mp.h
      interconnect: add device managed bulk API
      interconnect: imx: fix max_node_id
      interconnect: imx: set src node
      interconnect: imx: introduce imx_icc_provider
      interconnect: imx: configure NoC mode/prioriry/ext_control
      interconnect: imx: Add platform driver for imx8mp
      PM / devfreq: imx: Register i.MX8MP interconnect device

Peter Geis (2):
      phy: rockchip-inno-usb2: Prevent incorrect error on probe
      phy: rockchip-inno-usb2: Sync initial otg state

Peter Rosin (2):
      dt-bindings: iio: ti-dac5571: Add ti,dac121c081
      iio: dac: ti-dac5571: add support for ti,dac121c081

Pierre-Louis Bossart (4):
      soundwire: bus_type: fix remove and shutdown support
      soundwire: revisit driver bind/unbind and callbacks
      soundwire: peripheral: remove useless ops pointer
      soundwire: intel: use pm_runtime_resume() on component probe

Qiang Yu (1):
      bus: mhi: host: Move IRQ allocation to controller registration phase

Rahul T R (3):
      phy: dt-bindings: cdns,dphy: Add compatible for dphy on j721e
      phy: cdns-dphy: Add band config for dphy tx
      phy: cdns-dphy: Add support for DPHY TX on J721e

Rob Herring (3):
      dt-bindings: arm: Rename Coresight filenames to match compatible
      dt-bindings: arm: Convert CoreSight bindings to DT schema
      dt-bindings: arm: Convert CoreSight CPU debug to DT schema

Robert Marko (3):
      phy: qcom-qmp-pcie: make pipe clock rate configurable
      dt-bindings: phy: qcom,qmp: add IPQ8074 PCIe Gen3 PHY binding
      phy: qcom-qmp-pcie: add IPQ8074 PCIe Gen3 QMP PHY support

Roger Quadros (1):
      phy: ti: phy-j721e-wiz: use OF data for device specific data

Russ Weight (5):
      mfd: intel-m10-bmc: Rename n3000bmc-secure driver
      fpga: m10bmc-sec: create max10 bmc secure update
      fpga: m10bmc-sec: expose max10 flash update count
      fpga: m10bmc-sec: expose max10 canceled keys in sysfs
      fpga: m10bmc-sec: add max10 secure update functions

Sagiv Ozeri (1):
      habanalabs: save f/w preboot minor version

Samuel Holland (1):
      phy: rockchip-inno-usb2: Ignore OTG IRQs in host mode

Samuel Thibault (1):
      speakup: Generate speakupmap.h automatically

Sebastian Andrzej Siewior (1):
      iio: adc: stm32-adc: Use generic_handle_domain_irq()

Sebastian Ene (2):
      dt-bindings: vcpu_stall_detector: Add qemu,vcpu-stall-detector compatible
      misc: Add a mechanism to detect stalls on guest vCPUs

Slark Xiao (1):
      bus: mhi: host: pci_generic: Add Cinterion MV31-W with new baseline

Srinivas Kandagatla (1):
      soundwire: qcom: Check device status before reading devid

Srinivasa Rao Mandadapu (3):
      soundwire: qcom: Add support for controlling audio CGCR from HLOS
      soundwire: qcom: Add flag for software clock gating check
      soundwire: qcom: Enable software clock gating requirement flag

Stephen Boyd (2):
      dt-bindings: iio: sx9324: Add CS idle/sleep mode
      iio: sx9324: Add setting for CS idle mode

Suzuki K Poulose (1):
      coresight: Clear the connection field properly

Tal Cohen (8):
      habanalabs/gaudi: move tpc assert raise into internal func
      habanalabs: change the write flag name of error info structs
      habanalabs/gaudi: collect undefined opcode error info
      habanalabs: expose undefined opcode status via info ioctl
      habanalabs/gaudi: invoke device reset from one code block
      habanalabs/gaudi: send device reset notification
      habanalabs: send an event notification when CS timeout occurs
      habanalabs/gaudi: notify user process on device unavailable

Tetsuo Handa (2):
      iio: light: tsl2563: Replace flush_scheduled_work() with cancel_delayed_work_sync().
      iio:light:tsl2563: Replace cancel_delayed_work() with cancel_delayed_work_sync().

Thomas Bogendoerfer (1):
      char: remove VR41XX related char driver

Thorsten Scherer (1):
      iio: adc: ad7949: Fix error message

Tomer Maimon (2):
      dt-bindings: iio: adc: npcm: Add npcm845 compatible string
      iio: adc: npcm: Add NPCM8XX support

Tomer Tayar (8):
      habanalabs: fix race between hl_get_compute_ctx() and hl_ctx_put()
      habanalabs: remove dead code from free_device_memory()
      habanalabs: add a value field to hl_fw_send_pci_access_msg()
      habanalabs/gaudi2: configure virtual MSI-X doorbell interface
      habanalabs/gaudi2: replace defines for reserved sob/mob with enums
      habanalabs/gaudi2: modify CS completion CQ to use virtual MSI-X doorbell
      habanalabs/gaudi2: modify decoder to use virtual MSI-X doorbell
      habanalabs/gaudi2: map virtual MSI-X doorbell memory for user

Uwe Kleine-König (20):
      iio:accel:mc3230: Remove duplicated error reporting in .remove()
      iio:accel:stk8312: Remove duplicated error reporting in .remove()
      iio:accel:stk8ba50: Remove duplicated error reporting in .remove()
      iio:light:bh1780: Remove duplicated error reporting in .remove()
      iio:light:isl29028: Remove duplicated error reporting in .remove()
      iio:light:jsa1212: Remove duplicated error reporting in .remove()
      iio:light:opt3001: Remove duplicated error reporting in .remove()
      iio:light:stk3310: Remove duplicated error reporting in .remove()
      iio:light:tsl2583: Remove duplicated error reporting in .remove()
      iio: health: afe4404: Remove duplicated error reporting in .remove()
      iio:adc:ina2xx: Improve error reporting for problems during .remove()
      iio:adc:ti-ads1015: Improve error reporting for problems during .remove()
      iio:chemical:atlas: Improve error reporting for problems during .remove()
      iio:chemical:ccs811: Improve error reporting for problems during .remove()
      iio:light:pa12203001: Improve error reporting for problems during .remove()
      iio:light:us5182d: Improve error reporting for problems during .remove()
      iio:light:vcnl4000: Improve error reporting for problems during .remove()
      iio:light:vcnl4035: Improve error reporting for problems during .remove()
      iio:magnetometer:mbc150: Make bmc150_magn_remove() return void
      extcon: fsa9480: Drop no-op remove function

Vidya Sagar (2):
      dt-bindings: PHY: P2U: Add support for Tegra234 P2U block
      phy: tegra: Add PCIe PIPE2UPHY support for Tegra234

Vinod Koul (1):
      phy: qcom-qmp-usb: statify qmp_phy_vreg_l

Vipin Sharma (1):
      scripts/tags.sh: Include tools directory in tags generation

William Breathitt Gray (8):
      iio: adc: stx104: Utilize iomap interface
      iio: dac: cio-dac: Utilize iomap interface
      MAINTAINERS: Update info for William Breathitt Gray
      counter: 104-quad-8: Utilize iomap interface
      counter: 104-quad-8: Implement and utilize register structures
      MAINTAINERS: Update 104-QUAD-8 driver maintainers list
      iio: adc: stx104: Implement and utilize register structures
      iio: dac: cio-dac: Cleanup indexing for DAC writes

Xiang wangx (2):
      iio: accel: sca3000: Fix syntax errors in comments
      iio: gyro: bmg160: Fix typo in comment

Xie Yongji (1):
      Docs/ABI/testing: Add VDUSE sysfs interface ABI document

Yang Yingliang (2):
      phy: phy-mtk-dp: change mtk_dp_phy_driver to static
      virt: acrn: using for_each_set_bit to simplify the code

Yonglin Tan (1):
      bus: mhi: host: pci_generic: Add support for Quectel EM120 FCCL modem

Yuri Nudelman (3):
      habanalabs: keep a record of completed CS outcomes
      habanalabs: fix NULL dereference on cs timeout
      habanalabs/gaudi: fix a race condition causing DMAR error

Zhang Jiaming (2):
      misc: rtsx_pcr: Fix a typo
      bus: mvebu-mbus: Fix spelling mistake

Zheyu Ma (1):
      iio: light: isl29028: Fix the warning in isl29028_remove()

farah kassabri (1):
      habanalabs: add validity check for cq counter offset

keliu (4):
      fpga: Directly use ida_alloc()/free()
      iio: Directly use ida_alloc()/free()
      drivers: slimbus: Directly use ida_alloc()/free()
      drivers: mcb: directly use ida_alloc()/free()

ran shalit (1):
      habanalabs: add critical indication in sram ecc

 .../ABI/testing/debugfs-driver-habanalabs          |    38 +-
 Documentation/ABI/testing/sysfs-bus-iio            |     8 +
 Documentation/ABI/testing/sysfs-bus-iio-sx9324     |     1 +
 .../ABI/testing/sysfs-bus-iio-temperature-max31856 |    31 -
 .../ABI/testing/sysfs-bus-iio-temperature-max31865 |    20 -
 .../ABI/testing/sysfs-bus-iio-thermocouple         |    18 +
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |     8 -
 Documentation/ABI/testing/sysfs-class-vduse        |    33 +
 .../testing/sysfs-driver-intel-m10-bmc-sec-update  |    61 +
 .../bindings/arm/arm,coresight-catu.yaml           |   101 +
 .../bindings/arm/arm,coresight-cpu-debug.yaml      |    81 +
 .../{coresight-cti.yaml => arm,coresight-cti.yaml} |     5 +-
 .../bindings/arm/arm,coresight-dynamic-funnel.yaml |   126 +
 .../arm/arm,coresight-dynamic-replicator.yaml      |   126 +
 .../bindings/arm/arm,coresight-etb10.yaml          |    92 +
 .../devicetree/bindings/arm/arm,coresight-etm.yaml |   156 +
 .../bindings/arm/arm,coresight-static-funnel.yaml  |    90 +
 .../arm/arm,coresight-static-replicator.yaml       |    91 +
 .../devicetree/bindings/arm/arm,coresight-stm.yaml |   101 +
 .../devicetree/bindings/arm/arm,coresight-tmc.yaml |   131 +
 .../bindings/arm/arm,coresight-tpiu.yaml           |    91 +
 ...{ete.yaml => arm,embedded-trace-extension.yaml} |     3 +-
 .../{trbe.yaml => arm,trace-buffer-extension.yaml} |     2 +-
 .../bindings/arm/coresight-cpu-debug.txt           |    49 -
 .../devicetree/bindings/arm/coresight.txt          |   402 -
 .../bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml  |    44 +
 .../bindings/iio/accel/adi,adis16240.yaml          |     2 +-
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |     2 +-
 .../bindings/iio/accel/bosch,bmi088.yaml           |     2 +
 .../bindings/iio/accel/murata,sca3300.yaml         |     1 +
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |     1 -
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |     1 -
 .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml |     9 +-
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |     1 +
 .../bindings/iio/adc/nuvoton,npcm750-adc.yaml      |     7 +-
 .../bindings/iio/adc/qcom,spmi-rradc.yaml          |    51 +
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |    28 +-
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |     2 +-
 .../bindings/iio/dac/microchip,mcp4922.yaml        |     1 +
 .../devicetree/bindings/iio/dac/ti,dac5571.yaml    |     1 +
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml |     2 +-
 .../bindings/iio/proximity/semtech,sx9324.yaml     |    39 +
 .../bindings/iio/proximity/semtech,sx9360.yaml     |     9 +
 .../bindings/iio/proximity/st,vl53l0x.yaml         |     5 +
 .../bindings/interconnect/fsl,imx8m-noc.yaml       |     6 +-
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |     6 +-
 .../bindings/interconnect/qcom,rpmh-common.yaml    |    43 +
 .../bindings/interconnect/qcom,rpmh.yaml           |    22 +-
 .../bindings/interconnect/qcom,sm6350-rpmh.yaml    |    82 +
 .../bindings/misc/qemu,vcpu-stall-detector.yaml    |    51 +
 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |    89 +
 .../bindings/nvmem/microchip,sama7g5-otpc.yaml     |    50 +
 .../devicetree/bindings/nvmem/mtk-efuse.txt        |    43 -
 .../phy/amlogic,g12a-mipi-dphy-analog.yaml         |    35 +
 .../devicetree/bindings/phy/cdns,dphy.yaml         |     5 +-
 .../bindings/phy/fsl,imx8qm-lvds-phy.yaml          |    61 +
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |     4 +
 .../devicetree/bindings/phy/mediatek,pcie-phy.yaml |    75 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |     2 +
 .../devicetree/bindings/phy/mxs-usb-phy.txt        |     1 +
 .../devicetree/bindings/phy/phy-tegra194-p2u.yaml  |    17 +-
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |     6 +
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |     2 +
 .../devicetree/bindings/phy/renesas,usb3-phy.yaml  |     2 +-
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |    15 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |     2 +
 Documentation/driver-api/fpga/fpga-mgr.rst         |    27 +-
 .../trace/coresight/coresight-etm4x-reference.rst  |    17 +-
 Documentation/trace/coresight/coresight.rst        |    58 +-
 MAINTAINERS                                        |    66 +-
 drivers/Makefile                                   |     2 +-
 drivers/accessibility/speakup/.gitignore           |     4 +
 drivers/accessibility/speakup/Makefile             |    28 +
 drivers/accessibility/speakup/genmap.c             |   162 +
 drivers/accessibility/speakup/makemapdata.c        |   125 +
 drivers/accessibility/speakup/speakupmap.h         |    66 -
 drivers/accessibility/speakup/utils.h              |   102 +
 drivers/android/Kconfig                            |     9 -
 drivers/android/binder.c                           |   199 +-
 drivers/android/binder_internal.h                  |    46 +-
 drivers/android/binder_trace.h                     |     4 +
 drivers/android/binderfs.c                         |    47 +-
 drivers/bus/mhi/ep/main.c                          |    11 +-
 drivers/bus/mhi/host/init.c                        |    17 +-
 drivers/bus/mhi/host/pci_generic.c                 |     8 +
 drivers/bus/mhi/host/pm.c                          |    19 +-
 drivers/bus/mvebu-mbus.c                           |     6 +-
 drivers/char/Kconfig                               |     5 -
 drivers/char/Makefile                              |     1 -
 drivers/char/apm-emulation.c                       |     2 +-
 drivers/char/random.c                              |     4 +-
 drivers/char/tb0219.c                              |   359 -
 drivers/counter/104-quad-8.c                       |   203 +-
 drivers/devfreq/imx-bus.c                          |     1 +
 drivers/extcon/extcon-fsa9480.c                    |     6 -
 drivers/extcon/extcon-palmas.c                     |     2 +-
 drivers/extcon/extcon-rt8973a.c                    |     1 -
 drivers/extcon/extcon-sm5502.c                     |     2 -
 drivers/extcon/extcon.c                            |    12 +-
 drivers/firmware/stratix10-rsu.c                   |   129 +-
 drivers/firmware/stratix10-svc.c                   |   201 +-
 drivers/fpga/Kconfig                               |    20 +
 drivers/fpga/Makefile                              |     4 +
 drivers/fpga/altera-pr-ip-core.c                   |     2 +-
 drivers/fpga/dfl.c                                 |     4 +-
 drivers/fpga/fpga-bridge.c                         |     6 +-
 drivers/fpga/fpga-mgr.c                            |   229 +-
 drivers/fpga/fpga-region.c                         |     6 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            |   625 +
 drivers/fpga/microchip-spi.c                       |   398 +
 drivers/gpu/drm/msm/dp/dp_parser.c                 |    14 -
 drivers/gpu/drm/msm/dp/dp_parser.h                 |     8 -
 drivers/gpu/drm/msm/dp/dp_power.c                  |    95 +-
 drivers/hwtracing/coresight/coresight-config.h     |     2 +
 drivers/hwtracing/coresight/coresight-core.c       |     1 +
 drivers/hwtracing/coresight/coresight-etm-perf.c   |     2 +
 drivers/hwtracing/coresight/coresight-etm4x-core.c |    14 +
 drivers/hwtracing/coresight/coresight-etm4x.h      |     3 +-
 drivers/hwtracing/coresight/coresight-syscfg.c     |   295 +-
 drivers/hwtracing/coresight/coresight-syscfg.h     |    13 +
 drivers/hwtracing/intel_th/msu-sink.c              |     3 +
 drivers/hwtracing/intel_th/msu.c                   |    14 +-
 drivers/hwtracing/intel_th/pci.c                   |    25 +-
 drivers/iio/accel/Kconfig                          |     2 +
 drivers/iio/accel/adxl313_core.c                   |     2 +-
 drivers/iio/accel/adxl355_core.c                   |     2 +-
 drivers/iio/accel/adxl367.c                        |    48 +-
 drivers/iio/accel/adxl367_spi.c                    |     8 +-
 drivers/iio/accel/bma220_spi.c                     |    10 +-
 drivers/iio/accel/bma400.h                         |    50 +-
 drivers/iio/accel/bma400_core.c                    |   710 +-
 drivers/iio/accel/bma400_i2c.c                     |    10 +-
 drivers/iio/accel/bma400_spi.c                     |     8 +-
 drivers/iio/accel/bmi088-accel-core.c              |    99 +-
 drivers/iio/accel/bmi088-accel-spi.c               |    17 +-
 drivers/iio/accel/bmi088-accel.h                   |     9 +-
 drivers/iio/accel/cros_ec_accel_legacy.c           |     6 +-
 drivers/iio/accel/kxsd9-i2c.c                      |     2 +-
 drivers/iio/accel/kxsd9-spi.c                      |     2 +-
 drivers/iio/accel/kxsd9.c                          |    11 +-
 drivers/iio/accel/mc3230.c                         |     4 +-
 drivers/iio/accel/mma7660.c                        |     6 +-
 drivers/iio/accel/sca3000.c                        |     6 +-
 drivers/iio/accel/sca3300.c                        |   353 +-
 drivers/iio/accel/stk8312.c                        |     4 +-
 drivers/iio/accel/stk8ba50.c                       |     4 +-
 drivers/iio/adc/Kconfig                            |    17 +-
 drivers/iio/adc/Makefile                           |     1 +
 drivers/iio/adc/ad7266.c                           |     4 +-
 drivers/iio/adc/ad7280a.c                          |     2 +-
 drivers/iio/adc/ad7292.c                           |     2 +-
 drivers/iio/adc/ad7298.c                           |     2 +-
 drivers/iio/adc/ad7476.c                           |     5 +-
 drivers/iio/adc/ad7606.c                           |     1 +
 drivers/iio/adc/ad7606.h                           |     4 +-
 drivers/iio/adc/ad7606_par.c                       |     1 +
 drivers/iio/adc/ad7766.c                           |     5 +-
 drivers/iio/adc/ad7768-1.c                         |     6 +-
 drivers/iio/adc/ad7887.c                           |     5 +-
 drivers/iio/adc/ad7923.c                           |     4 +-
 drivers/iio/adc/ad7949.c                           |     4 +-
 drivers/iio/adc/ad799x.c                           |     8 +-
 drivers/iio/adc/ad9467.c                           |     1 +
 drivers/iio/adc/adi-axi-adc.c                      |    11 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    11 +-
 drivers/iio/adc/berlin2-adc.c                      |     2 +
 drivers/iio/adc/hi8435.c                           |     2 +-
 drivers/iio/adc/imx7d_adc.c                        |     6 +-
 drivers/iio/adc/imx8qxp-adc.c                      |    14 +-
 drivers/iio/adc/ina2xx-adc.c                       |    10 +-
 drivers/iio/adc/ingenic-adc.c                      |     2 +
 drivers/iio/adc/intel_mrfld_adc.c                  |     1 +
 drivers/iio/adc/lpc18xx_adc.c                      |     3 +-
 drivers/iio/adc/ltc2496.c                          |     4 +-
 drivers/iio/adc/ltc2497.c                          |     4 +-
 drivers/iio/adc/max1027.c                          |     8 +-
 drivers/iio/adc/max11100.c                         |     4 +-
 drivers/iio/adc/max1118.c                          |     2 +-
 drivers/iio/adc/max1241.c                          |     2 +-
 drivers/iio/adc/mcp320x.c                          |     2 +-
 drivers/iio/adc/meson_saradc.c                     |   187 +-
 drivers/iio/adc/mp2629_adc.c                       |     1 +
 drivers/iio/adc/mt6360-adc.c                       |     1 +
 drivers/iio/adc/mt6577_auxadc.c                    |    12 +-
 drivers/iio/adc/nau7802.c                          |    16 +-
 drivers/iio/adc/npcm_adc.c                         |    37 +-
 drivers/iio/adc/qcom-spmi-rradc.c                  |  1022 +
 drivers/iio/adc/rzg2l_adc.c                        |     4 +-
 drivers/iio/adc/sc27xx_adc.c                       |    15 +-
 drivers/iio/adc/stm32-adc-core.c                   |     2 +-
 drivers/iio/adc/stm32-adc.c                        |     6 +
 drivers/iio/adc/stmpe-adc.c                        |     6 +-
 drivers/iio/adc/stx104.c                           |    86 +-
 drivers/iio/adc/ti-adc0832.c                       |     2 +-
 drivers/iio/adc/ti-adc084s021.c                    |     4 +-
 drivers/iio/adc/ti-adc108s102.c                    |     4 +-
 drivers/iio/adc/ti-adc12138.c                      |     2 +-
 drivers/iio/adc/ti-adc128s052.c                    |     2 +-
 drivers/iio/adc/ti-adc161s626.c                    |     2 +-
 drivers/iio/adc/ti-ads1015.c                       |     8 +-
 drivers/iio/adc/ti-ads124s08.c                     |     8 +-
 drivers/iio/adc/ti-ads131e08.c                     |     2 +-
 drivers/iio/adc/ti-ads7950.c                       |     4 +-
 drivers/iio/adc/ti-ads8344.c                       |     2 +-
 drivers/iio/adc/ti-ads8688.c                       |     2 +-
 drivers/iio/adc/ti-tlc4541.c                       |     4 +-
 drivers/iio/adc/ti-tsc2046.c                       |     2 +-
 drivers/iio/adc/ti_am335x_adc.c                    |     8 +-
 drivers/iio/adc/vf610_adc.c                        |    15 +-
 drivers/iio/adc/xilinx-ams.c                       |     8 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    69 +-
 drivers/iio/addac/ad74413r.c                       |    12 +-
 drivers/iio/afe/iio-rescale.c                      |     2 +
 drivers/iio/amplifiers/ad8366.c                    |     4 +-
 drivers/iio/chemical/atlas-sensor.c                |     8 +-
 drivers/iio/chemical/bme680_core.c                 |     2 +-
 drivers/iio/chemical/ccs811.c                      |    10 +-
 drivers/iio/chemical/scd4x.c                       |     8 +-
 drivers/iio/chemical/sps30.c                       |     2 +-
 drivers/iio/chemical/sps30_i2c.c                   |     1 +
 drivers/iio/chemical/sps30_serial.c                |     1 +
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |     5 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |     7 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |    88 +-
 drivers/iio/common/ssp_sensors/ssp.h               |     3 +-
 drivers/iio/dac/Kconfig                            |     2 +-
 drivers/iio/dac/ad5064.c                           |     4 +-
 drivers/iio/dac/ad5360.c                           |     4 +-
 drivers/iio/dac/ad5380.c                           |     4 +-
 drivers/iio/dac/ad5421.c                           |     4 +-
 drivers/iio/dac/ad5449.c                           |     4 +-
 drivers/iio/dac/ad5504.c                           |     2 +-
 drivers/iio/dac/ad5592r-base.c                     |     2 +-
 drivers/iio/dac/ad5592r-base.h                     |     4 +-
 drivers/iio/dac/ad5686.h                           |     6 +-
 drivers/iio/dac/ad5755.c                           |     4 +-
 drivers/iio/dac/ad5761.c                           |     4 +-
 drivers/iio/dac/ad5764.c                           |     4 +-
 drivers/iio/dac/ad5766.c                           |     2 +-
 drivers/iio/dac/ad5770r.c                          |     2 +-
 drivers/iio/dac/ad5791.c                           |     2 +-
 drivers/iio/dac/ad7293.c                           |     2 +-
 drivers/iio/dac/ad7303.c                           |     4 +-
 drivers/iio/dac/ad8801.c                           |     2 +-
 drivers/iio/dac/cio-dac.c                          |    20 +-
 drivers/iio/dac/ds4424.c                           |     8 +-
 drivers/iio/dac/ltc1660.c                          |     9 +-
 drivers/iio/dac/ltc2688.c                          |     4 +-
 drivers/iio/dac/max517.c                           |     8 +-
 drivers/iio/dac/max5821.c                          |     9 +-
 drivers/iio/dac/mcp4725.c                          |     9 +-
 drivers/iio/dac/mcp4922.c                          |    13 +-
 drivers/iio/dac/stm32-dac.c                        |     6 +-
 drivers/iio/dac/ti-dac082s085.c                    |     2 +-
 drivers/iio/dac/ti-dac5571.c                       |     5 +-
 drivers/iio/dac/ti-dac7311.c                       |     2 +-
 drivers/iio/dac/ti-dac7612.c                       |     4 +-
 drivers/iio/dac/vf610_dac.c                        |     1 +
 drivers/iio/frequency/ad9523.c                     |     6 +-
 drivers/iio/frequency/adf4350.c                    |     6 +-
 drivers/iio/frequency/adf4371.c                    |     2 +-
 drivers/iio/frequency/admv1013.c                   |     2 +-
 drivers/iio/frequency/admv1014.c                   |     2 +-
 drivers/iio/frequency/admv4420.c                   |     2 +-
 drivers/iio/frequency/adrf6780.c                   |     2 +-
 drivers/iio/gyro/adis16080.c                       |     2 +-
 drivers/iio/gyro/adis16130.c                       |     2 +-
 drivers/iio/gyro/adxrs450.c                        |     2 +-
 drivers/iio/gyro/bmg160_core.c                     |     2 +-
 drivers/iio/gyro/fxas21002c_core.c                 |     6 +-
 drivers/iio/gyro/itg3200_core.c                    |     9 +-
 drivers/iio/gyro/mpu3050-core.c                    |    14 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |     2 +-
 drivers/iio/health/afe4403.c                       |     9 +-
 drivers/iio/health/afe4404.c                       |    13 +-
 drivers/iio/humidity/hts221_buffer.c               |     1 +
 drivers/iio/humidity/hts221_core.c                 |    12 +-
 drivers/iio/humidity/hts221_i2c.c                  |     3 +-
 drivers/iio/humidity/hts221_spi.c                  |     3 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |     6 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |     1 +
 drivers/iio/imu/bmi160/bmi160_spi.c                |     1 +
 drivers/iio/imu/fxos8700_core.c                    |     2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |     2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |     2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |     2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    16 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |     3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c        |     5 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |     3 +-
 drivers/iio/industrialio-buffer.c                  |    66 +-
 drivers/iio/industrialio-core.c                    |    88 +-
 drivers/iio/industrialio-sw-device.c               |     2 +-
 drivers/iio/industrialio-sw-trigger.c              |     2 +-
 drivers/iio/industrialio-trigger.c                 |    89 +-
 drivers/iio/light/al3010.c                         |     8 +-
 drivers/iio/light/al3320a.c                        |     9 +-
 drivers/iio/light/as73211.c                        |     9 +-
 drivers/iio/light/bh1750.c                         |     6 +-
 drivers/iio/light/bh1780.c                         |     7 +-
 drivers/iio/light/cm32181.c                        |    22 +
 drivers/iio/light/cm3605.c                         |    13 +-
 drivers/iio/light/cros_ec_light_prox.c             |     9 +-
 drivers/iio/light/gp2ap002.c                       |    14 +-
 drivers/iio/light/isl29028.c                       |    19 +-
 drivers/iio/light/jsa1212.c                        |     4 +-
 drivers/iio/light/opt3001.c                        |     3 +-
 drivers/iio/light/pa12203001.c                     |     8 +-
 drivers/iio/light/stk3310.c                        |     4 +-
 drivers/iio/light/tsl2563.c                        |     7 +-
 drivers/iio/light/tsl2583.c                        |    17 +-
 drivers/iio/light/tsl2591.c                        |    12 +-
 drivers/iio/light/us5182d.c                        |    16 +-
 drivers/iio/light/vcnl4000.c                       |    22 +-
 drivers/iio/light/vcnl4035.c                       |    24 +-
 drivers/iio/light/veml6030.c                       |    14 +-
 drivers/iio/magnetometer/ak8974.c                  |    14 +-
 drivers/iio/magnetometer/bmc150_magn.c             |     3 +-
 drivers/iio/magnetometer/bmc150_magn.h             |     2 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |     4 +-
 drivers/iio/magnetometer/hmc5843_core.c            |     2 +-
 drivers/iio/magnetometer/rm3100-core.c             |     2 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    14 +-
 drivers/iio/potentiometer/ad5110.c                 |     4 +-
 drivers/iio/potentiometer/ad5272.c                 |     2 +-
 drivers/iio/potentiometer/max5481.c                |     2 +-
 drivers/iio/potentiometer/mcp41010.c               |     2 +-
 drivers/iio/potentiometer/mcp4131.c                |     2 +-
 drivers/iio/pressure/bmp280-core.c                 |     2 +-
 drivers/iio/pressure/bmp280-i2c.c                  |     1 +
 drivers/iio/pressure/bmp280-regmap.c               |     4 +-
 drivers/iio/pressure/bmp280-spi.c                  |     1 +
 drivers/iio/pressure/cros_ec_baro.c                |     9 +-
 drivers/iio/pressure/dlhl60d.c                     |     2 +-
 drivers/iio/proximity/as3935.c                     |     2 +-
 drivers/iio/proximity/cros_ec_mkbp_proximity.c     |     8 +-
 drivers/iio/proximity/ping.c                       |     2 +-
 drivers/iio/proximity/srf04.c                      |    11 +-
 drivers/iio/proximity/srf08.c                      |     2 +-
 drivers/iio/proximity/sx9324.c                     |    76 +-
 drivers/iio/proximity/sx9360.c                     |    15 +-
 drivers/iio/proximity/sx_common.c                  |    10 +-
 drivers/iio/proximity/vcnl3020.c                   |     4 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |    55 +-
 drivers/iio/resolver/ad2s1200.c                    |     2 +-
 drivers/iio/resolver/ad2s90.c                      |     2 +-
 drivers/iio/temperature/ltc2983.c                  |    13 +-
 drivers/iio/temperature/max31865.c                 |     2 +-
 drivers/iio/temperature/maxim_thermocouple.c       |     2 +-
 drivers/iio/test/Kconfig                           |    26 +-
 drivers/iio/test/Makefile                          |     2 +-
 drivers/iio/test/iio-test-format.c                 |     4 +
 drivers/iio/test/iio-test-rescale.c                |     5 +
 drivers/iio/trigger/stm32-lptimer-trigger.c        |     4 +-
 drivers/interconnect/bulk.c                        |    42 +
 drivers/interconnect/imx/Kconfig                   |     4 +
 drivers/interconnect/imx/Makefile                  |     2 +
 drivers/interconnect/imx/imx.c                     |    84 +-
 drivers/interconnect/imx/imx.h                     |    49 +-
 drivers/interconnect/imx/imx8mm.c                  |     2 +-
 drivers/interconnect/imx/imx8mn.c                  |     2 +-
 drivers/interconnect/imx/imx8mp.c                  |   259 +
 drivers/interconnect/imx/imx8mq.c                  |     2 +-
 drivers/interconnect/qcom/Kconfig                  |     9 +
 drivers/interconnect/qcom/Makefile                 |     5 +
 drivers/interconnect/qcom/icc-common.c             |    34 +
 drivers/interconnect/qcom/icc-common.h             |    13 +
 drivers/interconnect/qcom/icc-rpm.c                |   168 +-
 drivers/interconnect/qcom/icc-rpm.h                |     6 +
 drivers/interconnect/qcom/icc-rpmh.c               |    30 +-
 drivers/interconnect/qcom/icc-rpmh.h               |     1 -
 drivers/interconnect/qcom/msm8939.c                |     1 +
 drivers/interconnect/qcom/sm6350.c                 |   493 +
 drivers/interconnect/qcom/sm6350.h                 |   139 +
 drivers/interconnect/qcom/sm8450.c                 |     1 +
 drivers/mcb/mcb-core.c                             |     4 +-
 drivers/mfd/intel-m10-bmc.c                        |     2 +-
 drivers/mfd/qcom-spmi-pmic.c                       |   272 +-
 drivers/misc/Kconfig                               |    13 +
 drivers/misc/Makefile                              |     1 +
 drivers/misc/cardreader/rtsx_pcr.c                 |     8 +-
 drivers/misc/cxl/context.c                         |     2 +-
 drivers/misc/cxl/cxl.h                             |     2 +-
 drivers/misc/cxl/guest.c                           |     2 +-
 drivers/misc/cxl/irq.c                             |     4 +-
 drivers/misc/cxl/of.c                              |     5 +-
 drivers/misc/eeprom/idt_89hpesx.c                  |    14 +-
 drivers/misc/habanalabs/Makefile                   |     3 +
 drivers/misc/habanalabs/common/Makefile            |     3 +-
 drivers/misc/habanalabs/common/asid.c              |     5 +-
 drivers/misc/habanalabs/common/command_buffer.c    |    12 +-
 .../misc/habanalabs/common/command_submission.c    |   296 +-
 drivers/misc/habanalabs/common/context.c           |    73 +-
 drivers/misc/habanalabs/common/debugfs.c           |   221 +-
 drivers/misc/habanalabs/common/decoder.c           |   133 +
 drivers/misc/habanalabs/common/device.c            |   242 +-
 drivers/misc/habanalabs/common/firmware_if.c       |   211 +-
 drivers/misc/habanalabs/common/habanalabs.h        |   756 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |    82 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |    54 +-
 drivers/misc/habanalabs/common/hw_queue.c          |    45 +-
 drivers/misc/habanalabs/common/irq.c               |   160 +-
 drivers/misc/habanalabs/common/memory.c            |   115 +-
 drivers/misc/habanalabs/common/memory_mgr.c        |     2 +-
 drivers/misc/habanalabs/common/mmu/Makefile        |     3 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |   496 +-
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |     9 +-
 drivers/misc/habanalabs/common/mmu/mmu_v2_hr.c     |   399 +
 drivers/misc/habanalabs/common/pci/pci.c           |    40 +-
 drivers/misc/habanalabs/common/security.c          |   600 +
 drivers/misc/habanalabs/common/sysfs.c             |    10 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |   681 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |     2 +-
 drivers/misc/habanalabs/gaudi2/Makefile            |     4 +
 drivers/misc/habanalabs/gaudi2/gaudi2.c            |  9986 ++++
 drivers/misc/habanalabs/gaudi2/gaudi2P.h           |   566 +
 drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c  |  2720 ++
 .../misc/habanalabs/gaudi2/gaudi2_coresight_regs.h |  1063 +
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h      |   141 +
 drivers/misc/habanalabs/gaudi2/gaudi2_security.c   |  3849 ++
 drivers/misc/habanalabs/goya/goya.c                |   160 +-
 drivers/misc/habanalabs/goya/goyaP.h               |     6 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |     2 +
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   297 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |     7 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |     1 +
 .../include/gaudi2/arc/gaudi2_arc_common_packets.h |   213 +
 .../gaudi2/asic_reg/arc_farm_arc0_acp_eng_regs.h   |   567 +
 .../gaudi2/asic_reg/arc_farm_arc0_aux_masks.h      |   819 +
 .../gaudi2/asic_reg/arc_farm_arc0_aux_regs.h       |   591 +
 .../asic_reg/arc_farm_arc0_dup_eng_axuser_regs.h   |    61 +
 .../gaudi2/asic_reg/arc_farm_arc0_dup_eng_regs.h   |   575 +
 .../asic_reg/arc_farm_kdma_ctx_axuser_masks.h      |   135 +
 .../asic_reg/arc_farm_kdma_ctx_axuser_regs.h       |    61 +
 .../gaudi2/asic_reg/arc_farm_kdma_ctx_masks.h      |   221 +
 .../gaudi2/asic_reg/arc_farm_kdma_ctx_regs.h       |    95 +
 .../gaudi2/asic_reg/arc_farm_kdma_kdma_cgm_regs.h  |    29 +
 .../include/gaudi2/asic_reg/arc_farm_kdma_masks.h  |   415 +
 .../include/gaudi2/asic_reg/arc_farm_kdma_regs.h   |   157 +
 .../include/gaudi2/asic_reg/cpu_if_regs.h          |   777 +
 .../gaudi2/asic_reg/dcore0_dec0_cmd_masks.h        |   229 +
 .../include/gaudi2/asic_reg/dcore0_dec0_cmd_regs.h |    85 +
 .../asic_reg/dcore0_edma0_core_ctx_axuser_regs.h   |    61 +
 .../gaudi2/asic_reg/dcore0_edma0_core_ctx_regs.h   |    95 +
 .../gaudi2/asic_reg/dcore0_edma0_core_masks.h      |   415 +
 .../gaudi2/asic_reg/dcore0_edma0_core_regs.h       |   157 +
 .../gaudi2/asic_reg/dcore0_edma0_qm_arc_aux_regs.h |   591 +
 .../dcore0_edma0_qm_axuser_nonsecured_regs.h       |    61 +
 .../gaudi2/asic_reg/dcore0_edma0_qm_cgm_regs.h     |    29 +
 .../gaudi2/asic_reg/dcore0_edma0_qm_masks.h        |  1165 +
 .../include/gaudi2/asic_reg/dcore0_edma0_qm_regs.h |  1057 +
 .../asic_reg/dcore0_edma1_core_ctx_axuser_regs.h   |    61 +
 .../dcore0_edma1_qm_axuser_nonsecured_regs.h       |    61 +
 .../gaudi2/asic_reg/dcore0_hmmu0_mmu_masks.h       |   294 +
 .../gaudi2/asic_reg/dcore0_hmmu0_mmu_regs.h        |   237 +
 .../gaudi2/asic_reg/dcore0_hmmu0_stlb_masks.h      |   348 +
 .../gaudi2/asic_reg/dcore0_hmmu0_stlb_regs.h       |   141 +
 .../include/gaudi2/asic_reg/dcore0_mme_acc_regs.h  |    73 +
 ...dcore0_mme_ctrl_lo_arch_agu_cout0_master_regs.h |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_cout0_slave_regs.h |    33 +
 ...dcore0_mme_ctrl_lo_arch_agu_cout1_master_regs.h |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_cout1_slave_regs.h |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in0_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in0_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in1_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in1_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in2_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in2_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in3_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in3_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in4_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in4_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_base_addr_regs.h       |    39 +
 .../dcore0_mme_ctrl_lo_arch_non_tensor_end_regs.h  |    73 +
 ...dcore0_mme_ctrl_lo_arch_non_tensor_start_regs.h |    35 +
 .../dcore0_mme_ctrl_lo_arch_tensor_a_regs.h        |    67 +
 .../dcore0_mme_ctrl_lo_arch_tensor_b_regs.h        |    67 +
 .../dcore0_mme_ctrl_lo_arch_tensor_cout_regs.h     |    67 +
 .../gaudi2/asic_reg/dcore0_mme_ctrl_lo_masks.h     |   468 +
 .../asic_reg/dcore0_mme_ctrl_lo_mme_axuser_regs.h  |    61 +
 .../gaudi2/asic_reg/dcore0_mme_ctrl_lo_regs.h      |   163 +
 .../asic_reg/dcore0_mme_qm_arc_acp_eng_regs.h      |   567 +
 .../gaudi2/asic_reg/dcore0_mme_qm_arc_aux_regs.h   |   591 +
 .../dcore0_mme_qm_arc_dup_eng_axuser_regs.h        |    61 +
 .../asic_reg/dcore0_mme_qm_arc_dup_eng_regs.h      |   575 +
 .../dcore0_mme_qm_axuser_nonsecured_regs.h         |    61 +
 .../asic_reg/dcore0_mme_qm_axuser_secured_regs.h   |    61 +
 .../gaudi2/asic_reg/dcore0_mme_qm_cgm_regs.h       |    29 +
 .../include/gaudi2/asic_reg/dcore0_mme_qm_regs.h   |  1057 +
 .../gaudi2/asic_reg/dcore0_mme_sbte0_masks.h       |   107 +
 .../dcore0_mme_sbte0_mstr_if_axuser_regs.h         |    61 +
 .../asic_reg/dcore0_mme_wb0_mstr_if_axuser_regs.h  |    61 +
 .../gaudi2/asic_reg/dcore0_rtr0_ctrl_regs.h        |   291 +
 .../dcore0_rtr0_mstr_if_rr_prvt_hbw_regs.h         |   213 +
 .../dcore0_rtr0_mstr_if_rr_prvt_lbw_regs.h         |   189 +
 .../dcore0_rtr0_mstr_if_rr_shrd_hbw_regs.h         |   213 +
 .../dcore0_rtr0_mstr_if_rr_shrd_lbw_regs.h         |   189 +
 .../gaudi2/asic_reg/dcore0_sync_mngr_glbl_masks.h  |   135 +
 .../gaudi2/asic_reg/dcore0_sync_mngr_glbl_regs.h   |  1203 +
 .../dcore0_sync_mngr_mstr_if_axuser_masks.h        |   135 +
 .../dcore0_sync_mngr_mstr_if_axuser_regs.h         |    61 +
 .../gaudi2/asic_reg/dcore0_sync_mngr_objs_masks.h  |    87 +
 .../gaudi2/asic_reg/dcore0_sync_mngr_objs_regs.h   | 43543 ++++++++++++++++++
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_axuser_regs.h  |    61 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_kernel_regs.h  |   129 +
 .../dcore0_tpc0_cfg_kernel_tensor_0_regs.h         |    63 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_masks.h        |   509 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_qm_regs.h      |   129 +
 .../asic_reg/dcore0_tpc0_cfg_qm_sync_object_regs.h |    27 +
 .../asic_reg/dcore0_tpc0_cfg_qm_tensor_0_regs.h    |    63 +
 .../include/gaudi2/asic_reg/dcore0_tpc0_cfg_regs.h |   229 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_special_regs.h |   185 +
 .../asic_reg/dcore0_tpc0_eml_busmon_0_regs.h       |   163 +
 .../gaudi2/asic_reg/dcore0_tpc0_eml_etf_regs.h     |   113 +
 .../gaudi2/asic_reg/dcore0_tpc0_eml_funnel_regs.h  |    75 +
 .../gaudi2/asic_reg/dcore0_tpc0_eml_spmu_regs.h    |   151 +
 .../gaudi2/asic_reg/dcore0_tpc0_eml_stm_regs.h     |   131 +
 .../gaudi2/asic_reg/dcore0_tpc0_qm_arc_aux_regs.h  |   591 +
 .../dcore0_tpc0_qm_axuser_nonsecured_regs.h        |    61 +
 .../gaudi2/asic_reg/dcore0_tpc0_qm_cgm_regs.h      |    29 +
 .../include/gaudi2/asic_reg/dcore0_tpc0_qm_regs.h  |  1057 +
 .../dcore0_vdec0_brdg_ctrl_axuser_dec_regs.h       |    61 +
 ...dcore0_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h |    61 +
 .../dcore0_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h  |    61 +
 .../dcore0_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h  |    61 +
 .../dcore0_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h  |    61 +
 .../gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_masks.h |   581 +
 .../gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_regs.h  |   245 +
 .../asic_reg/dcore0_vdec0_ctrl_special_regs.h      |   185 +
 .../gaudi2/asic_reg/dcore1_mme_ctrl_lo_regs.h      |   163 +
 .../gaudi2/asic_reg/dcore3_mme_ctrl_lo_regs.h      |   163 +
 .../gaudi2/asic_reg/gaudi2_blocks_linux_driver.h   | 45067 +++++++++++++++++++
 .../include/gaudi2/asic_reg/gaudi2_regs.h          |   550 +
 .../include/gaudi2/asic_reg/nic0_qm0_cgm_regs.h    |    29 +
 .../include/gaudi2/asic_reg/nic0_qm0_regs.h        |  1057 +
 .../gaudi2/asic_reg/nic0_qm_arc_aux0_regs.h        |   591 +
 .../include/gaudi2/asic_reg/nic0_qpc0_regs.h       |   905 +
 .../nic0_umr0_0_completion_queue_ci_1_regs.h       |    27 +
 .../asic_reg/nic0_umr0_0_unsecure_doorbell0_regs.h |    31 +
 .../include/gaudi2/asic_reg/pcie_aux_regs.h        |   293 +
 .../include/gaudi2/asic_reg/pcie_dbi_regs.h        |   422 +
 .../include/gaudi2/asic_reg/pcie_dec0_cmd_masks.h  |   229 +
 .../include/gaudi2/asic_reg/pcie_dec0_cmd_regs.h   |    85 +
 .../pcie_vdec0_brdg_ctrl_axuser_dec_regs.h         |    61 +
 .../pcie_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h  |    61 +
 .../pcie_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h    |    61 +
 .../pcie_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h    |    61 +
 .../pcie_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h    |    61 +
 .../gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_masks.h   |   580 +
 .../gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_regs.h    |   245 +
 .../gaudi2/asic_reg/pcie_vdec0_ctrl_special_regs.h |   185 +
 .../include/gaudi2/asic_reg/pcie_wrap_regs.h       |   601 +
 .../gaudi2/asic_reg/pdma0_core_ctx_axuser_regs.h   |    61 +
 .../include/gaudi2/asic_reg/pdma0_core_ctx_regs.h  |    95 +
 .../include/gaudi2/asic_reg/pdma0_core_masks.h     |   415 +
 .../include/gaudi2/asic_reg/pdma0_core_regs.h      |   157 +
 .../gaudi2/asic_reg/pdma0_core_special_masks.h     |   135 +
 .../gaudi2/asic_reg/pdma0_qm_arc_aux_regs.h        |   591 +
 .../asic_reg/pdma0_qm_axuser_nonsecured_regs.h     |    61 +
 .../gaudi2/asic_reg/pdma0_qm_axuser_secured_regs.h |    61 +
 .../include/gaudi2/asic_reg/pdma0_qm_cgm_regs.h    |    29 +
 .../include/gaudi2/asic_reg/pdma0_qm_masks.h       |  1165 +
 .../include/gaudi2/asic_reg/pdma0_qm_regs.h        |  1057 +
 .../gaudi2/asic_reg/pdma1_core_ctx_axuser_regs.h   |    61 +
 .../asic_reg/pdma1_qm_axuser_nonsecured_regs.h     |    61 +
 .../include/gaudi2/asic_reg/pmmu_hbw_stlb_masks.h  |   334 +
 .../include/gaudi2/asic_reg/pmmu_hbw_stlb_regs.h   |   141 +
 .../include/gaudi2/asic_reg/pmmu_pif_regs.h        |   135 +
 .../include/gaudi2/asic_reg/psoc_etr_masks.h       |   311 +
 .../include/gaudi2/asic_reg/psoc_etr_regs.h        |   115 +
 .../gaudi2/asic_reg/psoc_global_conf_masks.h       |  1406 +
 .../gaudi2/asic_reg/psoc_global_conf_regs.h        |  1337 +
 .../gaudi2/asic_reg/psoc_reset_conf_masks.h        |  2321 +
 .../include/gaudi2/asic_reg/psoc_reset_conf_regs.h |   989 +
 .../include/gaudi2/asic_reg/psoc_timestamp_regs.h  |    57 +
 .../include/gaudi2/asic_reg/rot0_desc_regs.h       |   155 +
 .../include/gaudi2/asic_reg/rot0_masks.h           |   313 +
 .../include/gaudi2/asic_reg/rot0_qm_arc_aux_regs.h |   591 +
 .../asic_reg/rot0_qm_axuser_nonsecured_regs.h      |    61 +
 .../include/gaudi2/asic_reg/rot0_qm_cgm_regs.h     |    29 +
 .../include/gaudi2/asic_reg/rot0_qm_regs.h         |  1057 +
 .../habanalabs/include/gaudi2/asic_reg/rot0_regs.h |   111 +
 .../include/gaudi2/asic_reg/xbar_edge_0_regs.h     |   199 +
 .../include/gaudi2/asic_reg/xbar_mid_0_regs.h      |   199 +
 drivers/misc/habanalabs/include/gaudi2/gaudi2.h    |   123 +
 .../include/gaudi2/gaudi2_async_events.h           |   963 +
 .../include/gaudi2/gaudi2_async_ids_map_extended.h |  2668 ++
 .../include/gaudi2/gaudi2_async_virt_events.h      |    57 +
 .../habanalabs/include/gaudi2/gaudi2_coresight.h   |   984 +
 .../misc/habanalabs/include/gaudi2/gaudi2_fw_if.h  |    99 +
 .../habanalabs/include/gaudi2/gaudi2_packets.h     |   197 +
 .../habanalabs/include/gaudi2/gaudi2_reg_map.h     |    59 +
 .../misc/habanalabs/include/goya/goya_packets.h    |    12 -
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |    14 +-
 .../misc/habanalabs/include/hw_ip/mmu/mmu_v2_0.h   |    51 +
 drivers/misc/lkdtm/bugs.c                          |     2 +-
 drivers/misc/lkdtm/cfi.c                           |     2 +-
 drivers/misc/mei/hw-me.c                           |     2 +-
 drivers/misc/sgi-gru/grukservices.c                |     2 +-
 drivers/misc/sgi-xp/xpc_uv.c                       |     2 +-
 drivers/misc/sgi-xp/xpnet.c                        |    13 +-
 drivers/misc/uacce/uacce.c                         |   133 +-
 drivers/misc/vcpu_stall_detector.c                 |   223 +
 drivers/net/wireguard/device.c                     |     3 +-
 drivers/nvmem/Kconfig                              |     7 +
 drivers/nvmem/Makefile                             |     2 +
 drivers/nvmem/microchip-otpc.c                     |   288 +
 drivers/nvmem/mtk-efuse.c                          |     3 +-
 drivers/phy/amlogic/Kconfig                        |    12 +
 drivers/phy/amlogic/Makefile                       |     1 +
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c      |     2 +-
 .../phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c  |   171 +
 drivers/phy/broadcom/phy-brcm-usb-init.c           |     2 +-
 drivers/phy/cadence/cdns-dphy.c                    |   101 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |     1 -
 drivers/phy/cadence/phy-cadence-torrent.c          |     1 -
 drivers/phy/freescale/Kconfig                      |     9 +
 drivers/phy/freescale/Makefile                     |     1 +
 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c    |   450 +
 drivers/phy/mediatek/Kconfig                       |    19 +
 drivers/phy/mediatek/Makefile                      |     2 +
 drivers/phy/mediatek/phy-mtk-dp.c                  |   202 +
 drivers/phy/mediatek/phy-mtk-pcie.c                |   267 +
 drivers/phy/qualcomm/Makefile                      |     8 +-
 drivers/phy/qualcomm/phy-qcom-edp.c                |    12 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  2621 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   |  1054 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-qhp.h       |   123 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  2556 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v3.h    |    17 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4.h    |    72 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h |    17 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h    |    16 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |    17 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v3.h     |    18 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v4.h     |    31 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h     |    27 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v4.h     |    34 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v5.h     |    36 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v2.h         |    46 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v3.h         |   145 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v4.h         |   135 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v4_20.h      |    15 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h         |    17 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v3.h |   111 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v4.h |   123 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v5.h |   124 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com.h    |   140 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h    |    66 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v3.h    |    68 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h    |   233 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4_20.h |    43 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5.h    |   231 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h |    60 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx.h   |   205 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |  1383 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |  2765 ++
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  6350 ---
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  1242 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    12 +-
 drivers/phy/samsung/Makefile                       |     1 +
 drivers/phy/samsung/phy-exynos7-ufs.c              |    12 +-
 drivers/phy/samsung/phy-exynosautov9-ufs.c         |    29 +-
 drivers/phy/samsung/phy-fsd-ufs.c                  |    63 +
 drivers/phy/samsung/phy-samsung-ufs.c              |   138 +-
 drivers/phy/samsung/phy-samsung-ufs.h              |    34 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |     4 +-
 drivers/phy/tegra/phy-tegra194-p2u.c               |    48 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |    75 +-
 drivers/phy/ti/phy-tusb1210.c                      |     5 +-
 drivers/slimbus/core.c                             |     6 +-
 drivers/slimbus/messaging.c                        |     4 +-
 drivers/soundwire/bus.c                            |    75 +-
 drivers/soundwire/bus_type.c                       |    38 +-
 drivers/soundwire/intel.c                          |    18 +
 drivers/soundwire/qcom.c                           |    32 +-
 drivers/soundwire/slave.c                          |     3 +-
 drivers/soundwire/stream.c                         |    53 +-
 drivers/spmi/spmi.c                                |    17 +
 drivers/virt/acrn/ioreq.c                          |     6 +-
 drivers/virt/vboxguest/vboxguest_linux.c           |     9 +-
 include/dt-bindings/interconnect/fsl,imx8mp.h      |    59 +
 include/dt-bindings/interconnect/qcom,sm6350.h     |   148 +
 include/dt-bindings/nvmem/microchip,sama7g5-otpc.h |    12 +
 include/linux/coresight-pmu.h                      |     2 +
 include/linux/extcon.h                             |     2 +
 include/linux/firmware/intel/stratix10-smc.h       |   175 +
 .../linux/firmware/intel/stratix10-svc-client.h    |    53 +-
 include/linux/fpga/fpga-mgr.h                      |    24 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |     9 +-
 include/linux/iio/iio.h                            |    23 +-
 include/linux/iio/trigger.h                        |    26 +-
 include/linux/interconnect.h                       |     7 +
 include/linux/miscdevice.h                         |     2 +-
 include/linux/soundwire/sdw.h                      |     8 +-
 include/linux/spmi.h                               |     3 +
 include/linux/uacce.h                              |     6 +-
 include/soc/qcom/qcom-spmi-pmic.h                  |    61 +
 include/trace/events/spmi.h                        |    12 +-
 include/uapi/linux/android/binder.h                |     1 +
 include/uapi/misc/habanalabs.h                     |   541 +-
 kernel/configs/android-base.config                 |     1 -
 kernel/power/Kconfig                               |    20 +
 kernel/rcu/Kconfig.debug                           |     3 +-
 scripts/tags.sh                                    |     9 +-
 .../testing/selftests/filesystems/binderfs/config  |     1 -
 tools/testing/selftests/sync/config                |     1 -
 707 files changed, 184505 insertions(+), 11890 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-thermocouple
 create mode 100644 Documentation/ABI/testing/sysfs-class-vduse
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
 rename Documentation/devicetree/bindings/arm/{coresight-cti.yaml => arm,coresight-cti.yaml} (98%)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
 rename Documentation/devicetree/bindings/arm/{ete.yaml => arm,embedded-trace-extension.yaml} (95%)
 rename Documentation/devicetree/bindings/arm/{trbe.yaml => arm,trace-buffer-extension.yaml} (94%)
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
 create mode 100644 drivers/accessibility/speakup/.gitignore
 create mode 100644 drivers/accessibility/speakup/genmap.c
 create mode 100644 drivers/accessibility/speakup/makemapdata.c
 delete mode 100644 drivers/accessibility/speakup/speakupmap.h
 create mode 100644 drivers/accessibility/speakup/utils.h
 delete mode 100644 drivers/char/tb0219.c
 create mode 100644 drivers/fpga/intel-m10-bmc-sec-update.c
 create mode 100644 drivers/fpga/microchip-spi.c
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 drivers/interconnect/imx/imx8mp.c
 create mode 100644 drivers/interconnect/qcom/icc-common.c
 create mode 100644 drivers/interconnect/qcom/icc-common.h
 create mode 100644 drivers/interconnect/qcom/sm6350.c
 create mode 100644 drivers/interconnect/qcom/sm6350.h
 create mode 100644 drivers/misc/habanalabs/common/decoder.c
 create mode 100644 drivers/misc/habanalabs/common/mmu/mmu_v2_hr.c
 create mode 100644 drivers/misc/habanalabs/common/security.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/Makefile
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2P.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_coresight_regs.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_security.c
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/arc/gaudi2_arc_common_packets.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_acp_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_aux_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_dup_eng_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_dup_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_axuser_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_kdma_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/cpu_if_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_dec0_cmd_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_dec0_cmd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_ctx_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma1_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma1_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_mmu_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_mmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_stlb_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_acc_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout0_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout0_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout1_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout1_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in0_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in0_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in1_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in1_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in2_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in2_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in3_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in3_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in4_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in4_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_base_addr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_non_tensor_end_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_non_tensor_start_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_tensor_a_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_tensor_b_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_tensor_cout_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_mme_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_acp_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_dup_eng_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_dup_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_axuser_secured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_sbte0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_sbte0_mstr_if_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_wb0_mstr_if_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_prvt_hbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_prvt_lbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_shrd_hbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_shrd_lbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_glbl_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_glbl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_mstr_if_axuser_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_mstr_if_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_objs_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_objs_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_kernel_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_kernel_tensor_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_qm_sync_object_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_qm_tensor_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_special_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_busmon_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_etf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_funnel_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_spmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_stm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_dec_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_ctrl_special_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore1_mme_ctrl_lo_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore3_mme_ctrl_lo_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_blocks_linux_driver.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qm0_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qm_arc_aux0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qpc0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_umr0_0_completion_queue_ci_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_umr0_0_unsecure_doorbell0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_dbi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_dec0_cmd_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_dec0_cmd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_dec_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_ctrl_special_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_wrap_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_ctx_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_special_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_axuser_secured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma1_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma1_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pmmu_hbw_stlb_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pmmu_hbw_stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pmmu_pif_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_etr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_etr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_global_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_global_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_reset_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_reset_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_timestamp_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_desc_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/xbar_edge_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/xbar_mid_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_virt_events.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_coresight.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_packets.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_reg_map.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v2_0.h
 create mode 100644 drivers/misc/vcpu_stall_detector.c
 create mode 100644 drivers/nvmem/microchip-otpc.c
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-dp.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-combo.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcie-qhp.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v2.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v4_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb.c
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-qmp.c
 create mode 100644 drivers/phy/samsung/phy-fsd-ufs.c
 create mode 100644 include/dt-bindings/interconnect/fsl,imx8mp.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h
 create mode 100644 include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
