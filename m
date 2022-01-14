Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36348EBFF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbiANOte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:49:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41414 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiANOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:49:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CF8DB825F5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68BBC36AE5;
        Fri, 14 Jan 2022 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642171770;
        bh=7iNJIegMa+vIit/2828kXo4CaDPP3qsO/HFgrPYj2bg=;
        h=Date:From:To:Cc:Subject:From;
        b=Wx5PxHLJB0S/31GNObcO9CrFKP4Iq9sU6Horzmt0zsclGrddbVq0l4NyqjSheldy7
         hyMu3iyV+4Ifn9MpTtLDpjAocu48bVJbQNNV2+baJ2zttW+/HkNtIBmNpzqmKwh8oT
         wA9ldS2UwLyi8oUrsIpbbXR+5BdPpVtJySf27tgo=
Date:   Fri, 14 Jan 2022 15:49:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 5.17-rc1
Message-ID: <YeGNdoyDESoradQ+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc1

for you to fetch changes up to d47c7407b4c88cf66098eba8893bc38279f301fc:

  Merge tag 'gnss-5.17-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss into char-misc-next (2022-01-11 10:22:25 +0100)

----------------------------------------------------------------
Char/Misc and other driver changes for 5.17-rc1

Here is the large set of char, misc, and other "small" driver subsystem
changes for 5.17-rc1.

Lots of different things are in here for char/misc drivers such as:
	- habanalabs driver updates
	- mei driver updates
	- lkdtm driver updates
	- vmw_vmci driver updates
	- android binder driver updates
	- other small char/misc driver updates

Also smaller driver subsystems have also been updated, including:
	- fpga subsystem updates
	- iio subsystem updates
	- soundwire subsystem updates
	- extcon subsystem updates
	- gnss subsystem updates
	- phy subsystem updates
	- coresight subsystem updates
	- firmware subsystem updates
	- comedi subsystem updates
	- mhi subsystem updates
	- speakup subsystem updates
	- rapidio subsystem updates
	- spmi subsystem updates
	- virtual driver updates
	- counter subsystem updates

Too many individual changes to summarize, the shortlog contains the full
details.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhyuday Godhasara (6):
      firmware: xilinx: add register notifier in zynqmp firmware
      firmware: xilinx: add macros of node ids for error event
      firmware: xilinx: export the feature check of zynqmp firmware
      drivers: soc: xilinx: add xilinx event management driver
      firmware: xilinx: instantiate xilinx event manager driver
      driver: soc: xilinx: register for power events in zynqmp power driver

Ajith P V (2):
      binder: remove repeat word from comment
      binder: use proper cacheflush header file

Alexander Stein (1):
      extcon: Deduplicate code in extcon_set_state_sync()

Alexander Usyskin (3):
      mei: add POWERING_DOWN into device state print
      mei: cleanup status before client dma setup call
      mei: hbm: fix client dma reply status

Anand Ashok Dumbre (4):
      device property: Add fwnode_iomap()
      iio: adc: Add Xilinx AMS driver
      dt-bindings: iio: adc: Add Xilinx AMS binding documentation
      MAINTAINERS: Add maintainer for xilinx-ams

Andriy Tryshnivskyy (4):
      iio: core: Introduce IIO_VAL_INT_64.
      iio/scmi: Add reading "raw" attribute.
      iio: test: Add check against NULL for buffer in tests.
      iio: test: Add test for IIO_VAL_INT_64.

André Gustavo Nakagomi Lopez (1):
      iio: adc: lpc18xx_adc: Reorder clk_get_rate() function call

Andy Shevchenko (14):
      iio: buffer: Use dedicated variable in iio_buffers_alloc_sysfs_and_mask()
      misc: at25: Make driver OF independent again
      misc: at25: Don't copy garbage to the at25->chip in FRAM case
      misc: at25: Check proper value of chip length in FRAM case
      misc: at25: Use at25->chip instead of local chip everywhere in ->probe()
      misc: at25: Unshadow error codes in at25_fw_to_chip()
      misc: at25: Check new property ("address-width") first
      misc: at25: Get platform data via dev_get_platdata()
      misc: at25: Get rid of intermediate storage for AT25 chip data
      misc: at25: Switch to use BIT() instead of custom approaches
      misc: at25: Factor out at_fram_to_chip()
      misc: at25: Reorganize headers for better maintenance
      misc: at25: Replace commas by spaces in the ID tables
      misc: at25: Align comment style

Antoniu Miclaus (10):
      iio: expose shared parameter in IIO_ENUM_AVAILABLE
      iio:dac:ad7293: add support for AD7293
      dt-bindings:iio:dac: add ad7293 doc
      iio: add filter subfolder
      iio:filter:admv8818: add support for ADMV8818
      dt-bindings:iio:filter: add admv8818 doc
      iio:filter:admv8818: Add sysfs ABI documentation
      iio: frequency: admv1013: add support for ADMV1013
      dt-bindings: iio: frequency: add admv1013 doc
      Documentation:ABI:testing:admv1013: add ABI docs

Ard Biesheuvel (1):
      lkdtm: avoid printk() in recursive_loop()

Arnd Bergmann (1):
      binder: fix pointer cast warning

Aswath Govindraju (3):
      phy: phy-can-transceiver: Make devm_gpiod_get optional
      dt-bindings: ti-serdes-mux: Add defines for J721S2 SoC
      dt-bindings: mux: Document mux-states property

Ben Hutchings (1):
      firmware: Update Kconfig help text for Google firmware

Bharat Jauhari (3):
      habanalabs: handle abort scenario for user interrupt
      habanalabs: rename reset flags
      habanalabs: refactor wait-for-user-interrupt function

Bhaumik Bhatt (2):
      bus: mhi: core: Use macros for execution environment features
      bus: mhi: core: Fix reading wake_capable channel configuration

Bjorn Andersson (2):
      dt-bindings: phy: Introduce Qualcomm eDP PHY binding
      phy: qcom: Introduce new eDP PHY driver

Cai Huoqing (3):
      iio: adc: ina2xx: Make use of the helper macro kthread_run()
      iio: adc: ina2xx: Avoid double reference counting from get_task_struct/put_task_struct()
      MAINTAINERS: Update i.MX 8QXP ADC info

Christophe JAILLET (4):
      coresight: Use devm_bitmap_zalloc when applicable
      nitro_enclaves: Remove redundant 'flush_workqueue()' calls
      mei: Remove some dead code
      bus: mhi: pci_generic: Simplify code and axe the use of a deprecated API

Christophe Leroy (2):
      w1: Misuse of get_user()/put_user() reported by sparse
      lkdtm: Fix content of section containing lkdtm_rodata_do_nothing()

Chunfeng Yun (8):
      dt-bindings: nvmem: mediatek: add support bits property
      dt-bindings: nvmem: mediatek: add support for mt8195
      nvmem: mtk-efuse: support minimum one byte access stride and granularity
      dt-bindings: phy: mediatek: tphy: support software efuse load
      phy: phy-mtk-tphy: add support efuse setting
      phy: mediatek: add helpers to update bits of registers
      phy: phy-mtk-xsphy: use new io helpers to access register
      phy: phy-mtk-tphy: use new io helpers to access register

Colin Ian King (2):
      speakup: remove redundant assignment of variable i
      phy: rockchip-inno-usb2: remove redundant assignment to variable delay

Cosmin Tanislav (3):
      iio: add addac subdirectory
      dt-bindings: iio: add AD74413R
      iio: addac: add AD74413R driver

Dan Carpenter (1):
      iio: addac: ad74413r: fix off by one in ad74413r_parse_channel_config()

Dani Liberman (6):
      habanalabs: change wait for interrupt timeout to 64 bit
      habanalabs: add support for fetching historic errors
      habanalabs: fix race condition in multi CS completion
      habanalabs: add SOB information to signal submission uAPI
      habanalabs: enable access to info ioctl during hard reset
      habanalabs: keep control device alive during hard reset

David Collins (1):
      spmi: spmi-pmic-arb: fix irq_set_type race condition

David Heidelberg (1):
      dt-bindings: phy: Tegra194 P2U convert to YAML

Dmitry Baryshkov (4):
      dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY bindings
      phy: qcom-qmp: Add SM8450 PCIe0 PHY support
      dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY bindings
      phy: qcom-qmp: Add SM8450 PCIe1 PHY support

Evgeny Boger (2):
      iio:adc:axp20x: add support for NTC thermistor
      dt-bindings: iio: adc: document TS voltage in AXP PMICs

Fabrice Gasnier (1):
      phy: stm32: adopt dev_err_probe for regulators

Georgi Djakov (4):
      Merge branch 'icc-msm8996' into icc-next
      Merge branch 'icc-sc7280' into icc-next
      Merge branch 'icc-sm8450' into icc-next
      Merge branch 'icc-qcm2290' into icc-next

Greg Kroah-Hartman (17):
      Merge 5.16-rc3 into char-misc-next
      Merge v5.15-rc5 into char-misc-next
      Merge tag 'lkdtm-v5.17-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into char-misc-next
      Merge tag 'fpga-for-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-next
      Merge tag 'coresight-next-v5.17' of gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      paride: fix up build warning on mips platforms
      Merge tag 'iio-for-5.17a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'icc-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'extcon-next-for-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'misc-habanalabs-next-2021-12-27' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next
      UIO: use default_groups in kobj_type
      cxl: use default_groups in kobj_type
      Merge tag 'iio-for-5.17b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'soundwire-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-next
      Merge tag 'phy-for-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next
      Merge 5.16-rc8 into char-misc-next
      Merge tag 'gnss-5.17-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss into char-misc-next

Guo Zhengkui (1):
      phy: qcom: use struct_size instead of sizeof

Guy Zadicario (1):
      habanalabs/gaudi: fix debugfs dma channel selection

Gwendal Grignou (12):
      iio: bma220: Use scan_type when processing raw data
      iio: kxcjk-1013: Use scan_type when processing raw data
      iio: mma7455: Use scan_type when processing raw data
      iio: sca3000: Use scan_type when processing raw data
      iio: stk8312: Use scan_type when processing raw data
      iio: stk8ba50: Use scan_type when processing raw data
      iio: ad7266: Use scan_type when processing raw data
      iio: ti-adc12138: Use scan_type when processing raw data
      iio: mag3110: Use scan_type when processing raw data
      iio: ti-ads1015: Remove shift variable ads1015_read_raw
      iio: xilinx-xadc-core: Use local variable in xadc_read_raw
      iio: mpl3115: Use scan_type.shift and realbit in mpl3115_read_raw

Haibo Chen (2):
      MAINTAINERS: add imx7d/imx6sx/imx6ul/imx8qxp and vf610 adc maintainer
      dt-bindings:iio:adc: update the maintainer of vf610-adc

Heinrich Schuchardt (1):
      include/linux/byteorder/generic.h: fix index variables

Horatiu Vultur (5):
      dt-bindings: phy: Add lan966x-serdes binding
      dt-bindings: phy: Add constants for lan966x serdes
      phy: Add lan966x ethernet serdes PHY driver
      phy: lan966x: Extend lan966x to support multiple phy interfaces.
      phy: lan966x: Remove set_speed function

Ian Abbott (5):
      comedi: Move the main COMEDI headers
      comedi: ni_routing: tools: Update due to moved COMEDI headers
      comedi: Move and rename "8255.h" to <linux/comedi/comedi_8255.h>
      comedi: Move "comedi_8254.h" to <linux/comedi/comedi_8254.h>
      comedi: Move "comedi_isadma.h" to <linux/comedi/comedi_isadma.h>

James Lo (4):
      dt-bindings: spmi: remove the constraint of reg property
      dt-bindings: spmi: document binding for the Mediatek SPMI controller
      spmi: mediatek: Add support for MT6873/8192
      spmi: mediatek: Add support for MT8195

Jason Wang (3):
      coresight: core: Fix typo in a comment
      greybus: es2: fix typo in a comment
      applicom: unneed to initialise statics to 0

Jiasheng Jiang (1):
      uio: uio_dmem_genirq: Catch the Exception

Jing Yao (1):
      most: usb: replace snprintf in show functions with sysfs_emit

Johan Hovold (7):
      gnss: drop stray semicolons
      firmware: qemu_fw_cfg: fix NULL-pointer deref on duplicate entries
      firmware: qemu_fw_cfg: fix kobject leak in probe error path
      firmware: qemu_fw_cfg: fix sysfs information leak
      firmware: qemu_fw_cfg: remove sysfs entries explicitly
      gnss: add USB support
      gnss: usb: add support for Sierra Wireless XM1210

Jonathan Cameron (28):
      iio: trigger: Fix a scheduling whilst atomic issue seen on tsc2046
      iio:dac:ad5755: Switch to generic firmware properties and drop pdata
      iio:dac:ad5758: Drop unused of specific headers.
      iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
      iio:dac:lpc18xx_dac: Swap from of* to mod_devicetable.h
      iio:pot:mcp41010: Switch to generic firmware properties.
      iio:light:cm3605: Switch to generic firmware properties.
      iio:adc:max9611: Switch to generic firmware properties.
      iio:adc:mcp3911: Switch to generic firmware properties.
      iio:adc:ti-adc12138: Switch to generic firmware properties and drop of_match_ptr
      iio:adc:envelope-detector: Switch from of headers to mod_devicetable.h
      iio:adc:ti-ads124s08: Drop dependency on OF.
      iio:adc/dac:Kconfig: Update to drop OF dependencies.
      dt-bindings: iio: dac: adi,ad5755: drop unrelated included.
      iio:accel:bma180: Suppress clang W=1 warning about pointer to enum conversion.
      iio:adc:ina2xx-adc: Suppress clang W=1 warning about pointer to enum conversion.
      iio:adc:rcar: Suppress clang W=1 warning about pointer to enum conversion.
      iio:adc:ti-ads1015: Suppress clang W=1 warning about pointer to enum conversion.
      iio:amplifiers:hmc425a: Suppress clang W=1 warning about pointer to enum conversion.
      iio:dac:mcp4725: Suppress clang W=1 warning about pointer to enum conversion.
      iio:imu:inv_icm42600: Suppress clang W=1 warning about pointer to enum conversion.
      iio:imu:inv_mpu6050: Suppress clang W=1 warning about pointer to enum conversion.
      iio:magn:ak8975: Suppress clang W=1 warning about pointer to enum conversion.
      iio:dummy: Drop set but unused variable len.
      iio:accel:bmc150: Mark structure __maybe_unused as only needed with for pm ops.
      iio:accel:kxcjk-1013: Mark struct __maybe_unused to avoid warning.
      iio:addac:ad74413r: Fix uninitialized ret in a path that won't be hit.
      iio: adc: ti-adc081c: Partial revert of removal of ACPI IDs

Kai Ye (1):
      uacce: use sysfs_emit instead of sprintf

Kees Cook (4):
      char/mwave: Adjust io port register size
      iio: stmpe-adc: Use correctly sized arguments for bit field
      lkdtm: Note that lkdtm_kernel_info should be removed in the future
      bus: mhi: core: Use correctly sized arguments for bit field

Kunihiko Hayashi (8):
      dt-bindings: phy: uniphier-usb3: Add bindings for NX1 SoC
      phy: uniphier-usb3: Add compatible string for NX1 SoC
      dt-bindings: phy: uniphier-pcie: Add bindings for NX1 SoC
      phy: uniphier-pcie: Add compatible string and SoC-dependent data for NX1 SoC
      phy: uniphier-pcie: Set VCOPLL clamp mode in PHY register
      phy: uniphier-pcie: Add dual-phy support for NX1 SoC
      dt-bindings: phy: uniphier-ahci: Add bindings for Pro4 SoC
      phy: uniphier-ahci: Add support for Pro4 SoC

Lars-Peter Clausen (21):
      iio: xilinx-xadc: Make IRQ optional
      iio: st-sensors: Use dev_to_iio_dev() in sysfs callbacks
      iio: imx7d_adc: Don't pass IIO device to imx7d_adc_{enable,disable}()
      iio: ms5611: Simplify IO callback parameters
      iio: Mark iio_device_type as const
      iio: interrupt-trigger: Remove no-op trigger ops
      iio: sysfs-trigger: Remove no-op trigger ops
      iio: ad_sigma_delta: Remove no-op trigger ops
      iio: afe4403: Remove no-op trigger ops
      iio: afe4404: Remove no-op trigger ops
      iio: as3935: Remove no-op trigger ops
      iio: atlas-sensor: Remove no-op trigger ops
      iio: gp2ap020a00f: Remove no-op trigger ops
      iio: lmp91000: Remove no-op trigger ops
      iio: mma8452: Use correct type for return variable in IRQ handler
      iio: at91-sama5d2: Fix incorrect cast to platform_device
      iio: at91-sama5d2: Use dev_to_iio_dev() in sysfs callbacks
      iio: iio_device_alloc(): Remove unnecessary self drvdata
      iio: as3935: Remove unnecessary cast
      iio: in2xx-adc: Remove unnecessary cast
      iio: vz89x: Remove unnecessary cast

Loic Poulain (1):
      bus: mhi: pci_generic: Graceful shutdown on freeze

Longpeng (4):
      nitro_enclaves: Merge contiguous physical memory regions
      nitro_enclaves: Sanity check physical memory regions during merging
      nitro_enclaves: Add KUnit tests setup for the misc device functionality
      nitro_enclaves: Add KUnit tests for contiguous physical memory regions merging

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: add dts property to disable sensor-hub
      Documentation: dt: iio: st_lsm6dsx: add disable-sensor-hub property

Luca Weiss (1):
      dt-bindings: phy: qcom,qusb2: Add SM6350 compatible

Manivannan Sadhasivam (3):
      bus: mhi: core: Minor style and comment fixes
      bus: mhi: core: Fix race while handling SYS_ERR at power up
      bus: mhi: core: Add an API for auto queueing buffers for DL channel

Martin Blumenstingl (2):
      dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY bindings
      phy: amlogic: Add a new driver for the HDMI TX PHY on Meson8/8b/8m2

Maslov Dmitry (1):
      iio: light: ltr501: Added ltr303 driver support

Miaoqian Lin (3):
      phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
      phy: ti: Use IS_ERR_OR_NULL() to clean code
      phy: mediatek: Fix missing check in mtk_mipi_tx_probe

Mihail Chindris (2):
      dt-bindings: iio: dac: Add adi,ad3552r.yaml
      drivers:iio:dac: Add AD3552R driver support

Mike Leach (7):
      Documentation: coresight: Fix documentation issue
      coresight: configuration: Update API to introduce load owner concept
      coresight: configuration: Update API to permit dynamic load/unload
      coresight: syscfg: Update load API for config loadable modules
      coresight: syscfg: Example CoreSight configuration loadable module
      coresight: configfs: Allow configfs to activate configuration
      Documentation: coresight: Update coresight configuration docs

Mike Tipton (1):
      interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate

Mikko Perttunen (1):
      misc: sram: Add compatible string for Tegra234 SYSRAM

Minghao Chi (2):
      iio:adc:ti-ads8688:: remove redundant ret variable
      drivers/misc/ocxl: remove redundant rc variable

Misono Tomohiro (1):
      selftest/lkdtm: Skip stack-entropy test if lkdtm is not available

Nathan Chancellor (1):
      fpga: stratix10-soc: Do not use ret uninitialized in s10_probe()

Nikita Travkin (2):
      dt-bindings: iio: light: ltr501: Add proximity-near-level
      iio: ltr501: Export near level property for proximity sensor

Oded Gabbay (16):
      habanalabs/gaudi: recover from CPU WD event
      habanalabs: make hdev creation code more readable
      habanalabs: prevent false heartbeat message
      habanalabs: abort reset on invalid request
      habanalabs: fix soft reset accounting
      habanalabs: rename late init after reset function
      habanalabs/gaudi: return EPERM on non hard-reset
      habanalabs: free signal handle on failure
      habanalabs: remove redundant check on ctx_fini
      habanalabs: save ctx inside encaps signal
      habanalabs: fix etr asid configuration
      habanalabs: add helper to get compute context
      habanalabs: remove compute context pointer
      habanalabs: remove in_debug check in device open
      habanalabs: fix hwmon handling for legacy f/w
      habanalabs: replace some -ENOTTY with -EINVAL

Odelu Kukatla (2):
      dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
      interconnect: qcom: Add EPSS L3 support on SC7280

Ofir Bitton (18):
      habanalabs: expand clock throttling information uAPI
      habanalabs: debugfs support for larger I2C transactions
      habanalabs: handle device TPM boot error as warning
      habanalabs: fix possible deadlock in cache invl failure
      habanalabs: move device boot warnings to the correct location
      habanalabs: add more info ioctls support during reset
      habanalabs: change misleading IRQ warning during reset
      habanalabs: handle events during soft-reset
      habanalabs: return correct clock throttling period
      habanalabs: add current PI value to cpu packets
      habanalabs: sysfs support for two infineon versions
      habanalabs: expose soft reset sysfs nodes for inference ASIC
      habanalabs: modify cpu boot status error print
      habanalabs: fix endianness when reading cpld version
      habanalabs: fix comments according to kernel-doc
      habanalabs: refactor reset information variables
      habanalabs: add a lock to protect multiple reset variables
      habanalabs: support hard-reset scheduling during soft-reset

Ohad Sharabi (11):
      habanalabs: modify wait for boot fit in dynamic FW load
      habanalabs: revise and document use of boot status flags
      habanalabs: adding indication of boot fit loaded
      habanalabs: use variable poll interval for fw loading
      habanalabs: don't clear previous f/w indications
      habanalabs: skip PLL freq fetch
      habanalabs: skip read fw errors if dynamic descriptor invalid
      habanalabs: wait again for multi-CS if no CS completed
      habanalabs: clean MMU headers definitions
      habanalabs: prevent wait if CS in multi-CS list completed
      habanalabs: handle skip multi-CS if handling not done

Paul Cercueil (2):
      iio: buffer-dma: Remove unused iio_buffer_block struct
      iio: buffer-dma: Use round_down() instead of rounddown()

Peter Geis (5):
      dt-bindings: phy: phy-rockchip-inno-usb2: add rk3568 documentation
      phy: phy-rockchip-inno-usb2: support #address_cells = 2
      phy: phy-rockchip-inno-usb2: support standalone phy nodes
      phy: phy-rockchip-inno-usb2: support muxed interrupts
      phy: phy-rockchip-inno-usb2: add rk3568 support

Rafał Miłecki (2):
      phy: bcm-ns-usb2: support updated DT binding with PHY reg space
      phy: bcm-ns-usb2: improve printing ref clk errors

Rajaravi Krishna Katta (2):
      habanalabs: add dedicated message towards f/w to set power
      habanalabs: Move frequency change thread to goya_late_init

Randy Dunlap (1):
      extcon: usb-gpio: fix a non-kernel-doc comment

Rashmi A (2):
      dt-bindings: phy: intel: Add Thunder Bay eMMC PHY bindings
      phy: intel: Add Thunder Bay eMMC PHY support

Richard Zhu (3):
      dt-bindings: phy: phy-imx8-pcie: Add binding for the pad modes of imx8 pcie phy
      dt-bindings: phy: Add imx8 pcie phy driver support
      phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver

Rob Herring (1):
      dt-bindings: nvmem: Add missing 'reg' property

Russ Weight (3):
      fpga: mgr: Use standard dev_release for class driver
      fpga: bridge: Use standard dev_release for class driver
      fpga: region: Use standard dev_release for class driver

Ryuta NAKANISHI (1):
      phy: uniphier-usb3ss: fix unintended writing zeros to PHY register

Shawn Guo (6):
      interconnect: icc-rpm: Use NOC_QOS_MODE_INVALID for qos_mode check
      interconnect: icc-rpm: Define ICC device type
      interconnect: icc-rpm: Add QNOC type QoS support
      interconnect: icc-rpm: Support child NoC device probe
      dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
      interconnect: qcom: Add QCM2290 driver support

Slark Xiao (1):
      bus: mhi: pci_generic: Add new device ID support for T99W175

Srinivas Kandagatla (2):
      soundwire: qcom: remove redundant version number read
      nvmem: core: set size for sysfs bin file

Stephan Gerhold (1):
      interconnect: qcom: rpm: Prevent integer overflow in rate

Stephen Boyd (1):
      spmi: pmic-arb: Add sid and address to error messages

Swapnil Jakhade (15):
      phy: cadence: Sierra: Use of_device_get_match_data() to get driver data
      phy: cadence: Sierra: Prepare driver to add support for multilink configurations
      dt-bindings: phy: cadence-torrent: Rename SSC macros to use generic names
      dt-bindings: phy: cadence-sierra: Add binding to specify SSC mode
      phy: cadence: Sierra: Add support to get SSC type from device tree
      phy: cadence: Sierra: Rename some regmap variables to be in sync with Sierra documentation
      phy: cadence: Sierra: Add PHY PCS common register configurations
      phy: cadence: Sierra: Check cmn_ready assertion during PHY power on
      phy: cadence: Sierra: Check PIPE mode PHY status to be ready for operation
      phy: cadence: Sierra: Update single link PCIe register configuration
      phy: cadence: Sierra: Fix to get correct parent for mux clocks
      phy: cadence: Sierra: Add support for PHY multilink configurations
      phy: cadence: Sierra: Add PCIe + QSGMII PHY multilink configuration
      dt-bindings: phy: cadence-sierra: Add clock ID for derived reference clock
      phy: cadence: Sierra: Add support for derived reference clock output

Thomas Perrot (1):
      bus: mhi: pci_generic: Introduce Sierra EM919X support

Tiezhu Yang (2):
      rapidio: remove not used macro definition in rio_ids.h
      rapidio: remove not used code about RIO_VID_TUNDRA

Todd Kjos (4):
      binder: fix handling of error during copy
      binder: avoid potential data leakage when copying txn
      binder: read pre-translated fds from sender buffer
      binder: defer copies of pre-patched txn data

Tom Rix (1):
      iio: chemical: sunrise_co2: set val parameter only on success

Tomer Tayar (5):
      habanalabs: align debugfs documentation to alphabetical order
      habanalabs: add power information type to POWER_GET packet
      habanalabs: pass reset flags to reset thread
      habanalabs: add missing kernel-doc comments for hl_device fields
      habanalabs: add CPU-CP packet for engine core ASID cfg

Uladzislau Rezki (Sony) (1):
      misc: vmw_vmci: Switch to kvfree_rcu() API

Uwe Kleine-König (25):
      iio: accel: mma7660: Warn about failure to put device in stand-by in .remove()
      counter: ti-eqep: Use container_of instead of struct counter_device::priv
      counter: Use container_of instead of drvdata to track counter_device
      counter: ftm-quaddec: Drop unused platform_set_drvdata()
      counter: microchip-tcb-capture: Drop unused platform_set_drvdata()
      counter: Provide a wrapper to access device private data
      counter: 104-quad-8: Convert to counter_priv() wrapper
      counter: interrupt-cnt: Convert to counter_priv() wrapper
      counter: microchip-tcb-capture: Convert to counter_priv() wrapper
      counter: intel-qep: Convert to counter_priv() wrapper
      counter: ftm-quaddec: Convert to counter_priv() wrapper
      counter: ti-eqep: Convert to counter_priv() wrapper
      counter: stm32-lptimer-cnt: Convert to counter_priv() wrapper
      counter: stm32-timer-cnt: Convert to counter_priv() wrapper
      counter: Provide alternative counter registration functions
      counter: Update documentation for new counter registration functions
      counter: 104-quad-8: Convert to new counter registration
      counter: interrupt-cnt: Convert to new counter registration
      counter: intel-qep: Convert to new counter registration
      counter: ftm-quaddec: Convert to new counter registration
      counter: microchip-tcb-capture: Convert to new counter registration
      counter: stm32-timer-cnt: Convert to new counter registration
      counter: stm32-lptimer-cnt: Convert to new counter registration
      counter: ti-eqep: Convert to new counter registration
      counter: remove old and now unused registration API

Vinod Koul (9):
      scsi: ufs: dt-bindings: Add SM8450 compatible strings
      dt-bindings: phy: qcom,qmp: Add SM8450 UFS phy compatible
      phy: qcom-qmp: Add SM8450 UFS QMP Phy
      dt-bindings: interconnect: Add Qualcomm SM8450 DT bindings
      interconnect: qcom: Add SM8450 interconnect provider driver
      phy: freescale: pcie: explicitly add bitfield.h
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SM8450
      dt-bindings: phy: qcom,qmp: Add SM8450 USB3 PHY
      phy: qcom-qmp: Add SM8450 USB QMP PHYs

Wan Jiabing (1):
      iio: adc: stm32-adc: Fix of_node_put() issue in stm32-adc

Wei Yongjun (1):
      misc: lattice-ecp3-config: Fix task hung when firmware load failed

William Breathitt Gray (2):
      counter: 104-quad-8: Fix persistent enabled events bug
      counter: 104-quad-8: Fix use-after-free by quad8_irq_handler

Xiang wangx (1):
      iio: adc: ad7606: Fix syntax errors in comments

Xu Wang (1):
      iio: adc: rzg2l_adc: Remove unnecessary print function dev_err()

Yang Guang (2):
      phy: cadence-torrent: use swap() to make code cleaner
      w1: w1_therm: use swap() to make code cleaner

Yang Li (1):
      fpga: region: fix kernel-doc

Yanteng Si (1):
      counter: Add the necessary colons and indents to the comments of counter_compi

Yassine Oudjana (4):
      dt-bindings: interconnect: Combine SDM660 bindings into RPM schema
      interconnect: icc-rpm: Add support for bus power domain
      dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
      interconnect: qcom: Add MSM8996 interconnect provider driver

Yuri Nudelman (5):
      habanalabs: print va_range in vm node debugfs
      habanalabs: wrong VA size calculation
      habanalabs: make last_mask an MMU property
      habanalabs: add enum mmu_op_flags
      habanalabs: partly skip cache flush when in PMMU map flow

Zach DeCook (1):
      iio: event_monitor: Flush output on event

Zhaoyu Liu (1):
      scripts/tags: add space regexs to all regex_c

Zou Wei (1):
      phy: intel: Remove redundant dev_err call in thunderbay_emmc_phy_probe()

farah kassabri (3):
      habanalabs/gaudi: Fix collective wait bug
      habanalabs: add new opcodes for INFO IOCTL
      habanalabs: change wait_for_interrupt implementation

 .../ABI/testing/debugfs-driver-habanalabs          |   23 +-
 .../ABI/testing/sysfs-bus-iio-filter-admv8818      |   16 +
 .../ABI/testing/sysfs-bus-iio-frequency-admv1013   |   38 +
 .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml |    2 +-
 .../bindings/iio/adc/x-powers,axp209-adc.yaml      |    3 +
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |  227 +++
 .../bindings/iio/addac/adi,ad74413r.yaml           |  158 ++
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  217 ++
 .../devicetree/bindings/iio/dac/adi,ad5755.yaml    |    1 -
 .../devicetree/bindings/iio/dac/adi,ad7293.yaml    |   61 +
 .../bindings/iio/filter/adi,admv8818.yaml          |   66 +
 .../bindings/iio/frequency/adi,admv1013.yaml       |   91 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    7 +
 .../bindings/iio/light/liteon,ltr501.yaml          |    7 +
 .../bindings/interconnect/qcom,osm-l3.yaml         |    1 +
 .../bindings/interconnect/qcom,qcm2290.yaml        |  137 ++
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |  143 +-
 .../bindings/interconnect/qcom,rpmh.yaml           |   11 +
 .../bindings/interconnect/qcom,sdm660.yaml         |  185 --
 .../devicetree/bindings/mux/gpio-mux.yaml          |   11 +-
 .../devicetree/bindings/mux/mux-consumer.yaml      |   21 +
 .../devicetree/bindings/mux/mux-controller.yaml    |   26 +-
 .../devicetree/bindings/nvmem/brcm,nvram.yaml      |    3 +
 .../devicetree/bindings/nvmem/mtk-efuse.txt        |    2 +
 Documentation/devicetree/bindings/nvmem/rmem.yaml  |    3 +
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |    3 +
 .../bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml   |   65 +
 .../devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |   92 +
 .../bindings/phy/intel,phy-thunderbay-emmc.yaml    |   46 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   18 +
 .../bindings/phy/microchip,lan966x-serdes.yaml     |   59 +
 .../bindings/phy/phy-cadence-sierra.yaml           |    9 +
 .../bindings/phy/phy-cadence-torrent.yaml          |    4 +-
 .../bindings/phy/phy-rockchip-inno-usb2.yaml       |   44 +-
 .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |   28 -
 .../devicetree/bindings/phy/phy-tegra194-p2u.yaml  |   44 +
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   67 +
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    6 +
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |    1 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |    1 +
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |   21 +-
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  |    1 +
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |    1 +
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |    1 +
 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml           |   76 +
 Documentation/devicetree/bindings/spmi/spmi.yaml   |    3 -
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |    1 +
 Documentation/driver-api/fpga/fpga-bridge.rst      |    6 +-
 Documentation/driver-api/fpga/fpga-mgr.rst         |   38 +-
 Documentation/driver-api/fpga/fpga-region.rst      |   12 +-
 Documentation/driver-api/generic-counter.rst       |   10 +-
 Documentation/trace/coresight/coresight-config.rst |   78 +-
 MAINTAINERS                                        |   48 +-
 drivers/accessibility/speakup/speakup_acntpc.c     |    2 +-
 drivers/accessibility/speakup/speakup_dtlk.c       |    2 +-
 drivers/accessibility/speakup/speakup_keypc.c      |    2 +-
 drivers/android/binder.c                           |  437 +++-
 drivers/base/property.c                            |   16 +
 drivers/block/paride/bpck.c                        |    1 +
 drivers/bus/mhi/core/boot.c                        |    2 +-
 drivers/bus/mhi/core/init.c                        |    4 +-
 drivers/bus/mhi/core/internal.h                    |    9 +-
 drivers/bus/mhi/core/main.c                        |   24 +-
 drivers/bus/mhi/core/pm.c                          |   39 +-
 drivers/bus/mhi/pci_generic.c                      |   56 +-
 drivers/char/applicom.c                            |    4 +-
 drivers/char/mwave/3780i.h                         |    2 +-
 drivers/comedi/comedi_buf.c                        |    3 +-
 drivers/comedi/comedi_fops.c                       |    2 +-
 drivers/comedi/comedi_pci.c                        |    3 +-
 drivers/comedi/comedi_pcmcia.c                     |    3 +-
 drivers/comedi/comedi_usb.c                        |    3 +-
 drivers/comedi/drivers.c                           |    3 +-
 drivers/comedi/drivers/8255.c                      |    5 +-
 drivers/comedi/drivers/8255_pci.c                  |    6 +-
 drivers/comedi/drivers/addi_apci_1032.c            |    2 +-
 drivers/comedi/drivers/addi_apci_1500.c            |    2 +-
 drivers/comedi/drivers/addi_apci_1516.c            |    2 +-
 drivers/comedi/drivers/addi_apci_1564.c            |    2 +-
 drivers/comedi/drivers/addi_apci_16xx.c            |    3 +-
 drivers/comedi/drivers/addi_apci_2032.c            |    2 +-
 drivers/comedi/drivers/addi_apci_2200.c            |    2 +-
 drivers/comedi/drivers/addi_apci_3120.c            |    2 +-
 drivers/comedi/drivers/addi_apci_3501.c            |    2 +-
 drivers/comedi/drivers/addi_apci_3xxx.c            |    3 +-
 drivers/comedi/drivers/addi_watchdog.c             |    2 +-
 drivers/comedi/drivers/adl_pci6208.c               |    3 +-
 drivers/comedi/drivers/adl_pci7x3x.c               |    3 +-
 drivers/comedi/drivers/adl_pci8164.c               |    3 +-
 drivers/comedi/drivers/adl_pci9111.c               |    5 +-
 drivers/comedi/drivers/adl_pci9118.c               |    5 +-
 drivers/comedi/drivers/adq12b.c                    |    3 +-
 drivers/comedi/drivers/adv_pci1710.c               |    5 +-
 drivers/comedi/drivers/adv_pci1720.c               |    3 +-
 drivers/comedi/drivers/adv_pci1723.c               |    3 +-
 drivers/comedi/drivers/adv_pci1724.c               |    3 +-
 drivers/comedi/drivers/adv_pci1760.c               |    3 +-
 drivers/comedi/drivers/adv_pci_dio.c               |    8 +-
 drivers/comedi/drivers/aio_aio12_8.c               |    7 +-
 drivers/comedi/drivers/aio_iiro_16.c               |    3 +-
 drivers/comedi/drivers/amplc_dio200.c              |    2 +-
 drivers/comedi/drivers/amplc_dio200_common.c       |    7 +-
 drivers/comedi/drivers/amplc_dio200_pci.c          |    3 +-
 drivers/comedi/drivers/amplc_pc236.c               |    3 +-
 drivers/comedi/drivers/amplc_pc236_common.c        |    5 +-
 drivers/comedi/drivers/amplc_pc263.c               |    2 +-
 drivers/comedi/drivers/amplc_pci224.c              |    6 +-
 drivers/comedi/drivers/amplc_pci230.c              |    8 +-
 drivers/comedi/drivers/amplc_pci236.c              |    3 +-
 drivers/comedi/drivers/amplc_pci263.c              |    3 +-
 drivers/comedi/drivers/c6xdigio.c                  |    3 +-
 drivers/comedi/drivers/cb_das16_cs.c               |    6 +-
 drivers/comedi/drivers/cb_pcidas.c                 |    7 +-
 drivers/comedi/drivers/cb_pcidas64.c               |    5 +-
 drivers/comedi/drivers/cb_pcidda.c                 |    6 +-
 drivers/comedi/drivers/cb_pcimdas.c                |    7 +-
 drivers/comedi/drivers/cb_pcimdda.c                |    6 +-
 drivers/comedi/drivers/comedi_8254.c               |    6 +-
 drivers/comedi/drivers/comedi_8255.c               |    5 +-
 drivers/comedi/drivers/comedi_bond.c               |    6 +-
 drivers/comedi/drivers/comedi_isadma.c             |    6 +-
 drivers/comedi/drivers/comedi_parport.c            |    3 +-
 drivers/comedi/drivers/comedi_test.c               |    4 +-
 drivers/comedi/drivers/contec_pci_dio.c            |    3 +-
 drivers/comedi/drivers/dac02.c                     |    3 +-
 drivers/comedi/drivers/daqboard2000.c              |    5 +-
 drivers/comedi/drivers/das08.c                     |    7 +-
 drivers/comedi/drivers/das08_cs.c                  |    3 +-
 drivers/comedi/drivers/das08_isa.c                 |    2 +-
 drivers/comedi/drivers/das08_pci.c                 |    3 +-
 drivers/comedi/drivers/das16.c                     |   10 +-
 drivers/comedi/drivers/das16m1.c                   |    7 +-
 drivers/comedi/drivers/das1800.c                   |    8 +-
 drivers/comedi/drivers/das6402.c                   |    6 +-
 drivers/comedi/drivers/das800.c                    |    6 +-
 drivers/comedi/drivers/dmm32at.c                   |    5 +-
 drivers/comedi/drivers/dt2801.c                    |    2 +-
 drivers/comedi/drivers/dt2811.c                    |    3 +-
 drivers/comedi/drivers/dt2814.c                    |    3 +-
 drivers/comedi/drivers/dt2815.c                    |    3 +-
 drivers/comedi/drivers/dt2817.c                    |    2 +-
 drivers/comedi/drivers/dt282x.c                    |    6 +-
 drivers/comedi/drivers/dt3000.c                    |    3 +-
 drivers/comedi/drivers/dt9812.c                    |    3 +-
 drivers/comedi/drivers/dyna_pci10xx.c              |    3 +-
 drivers/comedi/drivers/fl512.c                     |    3 +-
 drivers/comedi/drivers/gsc_hpdi.c                  |    3 +-
 drivers/comedi/drivers/icp_multi.c                 |    3 +-
 drivers/comedi/drivers/ii_pci20kc.c                |    2 +-
 drivers/comedi/drivers/jr3_pci.c                   |    3 +-
 drivers/comedi/drivers/ke_counter.c                |    3 +-
 drivers/comedi/drivers/me4000.c                    |    5 +-
 drivers/comedi/drivers/me_daq.c                    |    3 +-
 drivers/comedi/drivers/mf6x4.c                     |    3 +-
 drivers/comedi/drivers/mite.c                      |    3 +-
 drivers/comedi/drivers/mpc624.c                    |    3 +-
 drivers/comedi/drivers/multiq3.c                   |    3 +-
 drivers/comedi/drivers/ni_6527.c                   |    3 +-
 drivers/comedi/drivers/ni_65xx.c                   |    3 +-
 drivers/comedi/drivers/ni_660x.c                   |    3 +-
 drivers/comedi/drivers/ni_670x.c                   |    3 +-
 drivers/comedi/drivers/ni_at_a2150.c               |    8 +-
 drivers/comedi/drivers/ni_at_ao.c                  |    6 +-
 drivers/comedi/drivers/ni_atmio.c                  |    5 +-
 drivers/comedi/drivers/ni_atmio16d.c               |    5 +-
 drivers/comedi/drivers/ni_daq_700.c                |    3 +-
 drivers/comedi/drivers/ni_daq_dio24.c              |    5 +-
 drivers/comedi/drivers/ni_labpc.c                  |    3 +-
 drivers/comedi/drivers/ni_labpc_common.c           |    7 +-
 drivers/comedi/drivers/ni_labpc_cs.c               |    3 +-
 drivers/comedi/drivers/ni_labpc_isadma.c           |    5 +-
 drivers/comedi/drivers/ni_labpc_pci.c              |    3 +-
 drivers/comedi/drivers/ni_mio_common.c             |    2 +-
 drivers/comedi/drivers/ni_mio_cs.c                 |    4 +-
 drivers/comedi/drivers/ni_pcidio.c                 |    3 +-
 drivers/comedi/drivers/ni_pcimio.c                 |    4 +-
 drivers/comedi/drivers/ni_routes.c                 |    3 +-
 drivers/comedi/drivers/ni_routes.h                 |    2 +-
 .../comedi/drivers/ni_routing/ni_route_values.h    |    2 +-
 drivers/comedi/drivers/ni_routing/tools/.gitignore |    1 +
 drivers/comedi/drivers/ni_routing/tools/Makefile   |   29 +-
 drivers/comedi/drivers/ni_tio.h                    |    2 +-
 drivers/comedi/drivers/ni_usb6501.c                |    3 +-
 drivers/comedi/drivers/pcl711.c                    |    6 +-
 drivers/comedi/drivers/pcl724.c                    |    5 +-
 drivers/comedi/drivers/pcl726.c                    |    3 +-
 drivers/comedi/drivers/pcl730.c                    |    2 +-
 drivers/comedi/drivers/pcl812.c                    |    8 +-
 drivers/comedi/drivers/pcl816.c                    |    8 +-
 drivers/comedi/drivers/pcl818.c                    |    8 +-
 drivers/comedi/drivers/pcm3724.c                   |    5 +-
 drivers/comedi/drivers/pcmad.c                     |    2 +-
 drivers/comedi/drivers/pcmda12.c                   |    2 +-
 drivers/comedi/drivers/pcmmio.c                    |    3 +-
 drivers/comedi/drivers/pcmuio.c                    |    3 +-
 drivers/comedi/drivers/quatech_daqp_cs.c           |    3 +-
 drivers/comedi/drivers/rtd520.c                    |    5 +-
 drivers/comedi/drivers/rti800.c                    |    2 +-
 drivers/comedi/drivers/rti802.c                    |    2 +-
 drivers/comedi/drivers/s526.c                      |    2 +-
 drivers/comedi/drivers/s626.c                      |    3 +-
 drivers/comedi/drivers/ssv_dnp.c                   |    2 +-
 drivers/comedi/drivers/usbdux.c                    |    3 +-
 drivers/comedi/drivers/usbduxfast.c                |    2 +-
 drivers/comedi/drivers/usbduxsigma.c               |    3 +-
 drivers/comedi/drivers/vmk80xx.c                   |    3 +-
 drivers/comedi/kcomedilib/kcomedilib_main.c        |    6 +-
 drivers/comedi/proc.c                              |    2 +-
 drivers/comedi/range.c                             |    2 +-
 drivers/counter/104-quad-8.c                       |  175 +-
 drivers/counter/counter-core.c                     |  186 +-
 drivers/counter/ftm-quaddec.c                      |   36 +-
 drivers/counter/intel-qep.c                        |   46 +-
 drivers/counter/interrupt-cnt.c                    |   38 +-
 drivers/counter/microchip-tcb-capture.c            |   44 +-
 drivers/counter/stm32-lptimer-cnt.c                |   51 +-
 drivers/counter/stm32-timer-cnt.c                  |   48 +-
 drivers/counter/ti-eqep.c                          |   52 +-
 drivers/extcon/extcon-usb-gpio.c                   |    2 +-
 drivers/extcon/extcon.c                            |   14 +-
 drivers/firmware/google/Kconfig                    |    6 +-
 drivers/firmware/qemu_fw_cfg.c                     |   21 +-
 drivers/firmware/xilinx/zynqmp.c                   |   40 +-
 drivers/fpga/altera-cvp.c                          |   12 +-
 drivers/fpga/altera-fpga2sdram.c                   |   12 +-
 drivers/fpga/altera-freeze-bridge.c                |   10 +-
 drivers/fpga/altera-hps2fpga.c                     |   12 +-
 drivers/fpga/altera-pr-ip-core.c                   |    7 +-
 drivers/fpga/altera-ps-spi.c                       |    9 +-
 drivers/fpga/dfl-fme-br.c                          |   10 +-
 drivers/fpga/dfl-fme-mgr.c                         |   22 +-
 drivers/fpga/dfl-fme-region.c                      |   17 +-
 drivers/fpga/dfl.c                                 |   12 +-
 drivers/fpga/fpga-bridge.c                         |  122 +-
 drivers/fpga/fpga-mgr.c                            |  215 +-
 drivers/fpga/fpga-region.c                         |  119 +-
 drivers/fpga/ice40-spi.c                           |    9 +-
 drivers/fpga/machxo2-spi.c                         |    9 +-
 drivers/fpga/of-fpga-region.c                      |   12 +-
 drivers/fpga/socfpga-a10.c                         |   16 +-
 drivers/fpga/socfpga.c                             |    9 +-
 drivers/fpga/stratix10-soc.c                       |   18 +-
 drivers/fpga/ts73xx-fpga.c                         |    9 +-
 drivers/fpga/versal-fpga.c                         |    9 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |   17 +-
 drivers/fpga/xilinx-spi.c                          |   11 +-
 drivers/fpga/zynq-fpga.c                           |   16 +-
 drivers/fpga/zynqmp-fpga.c                         |    9 +-
 drivers/gnss/Kconfig                               |   11 +
 drivers/gnss/Makefile                              |    3 +
 drivers/gnss/mtk.c                                 |    2 +-
 drivers/gnss/serial.c                              |    2 +-
 drivers/gnss/sirf.c                                |    2 +-
 drivers/gnss/ubx.c                                 |    2 +-
 drivers/gnss/usb.c                                 |  214 ++
 drivers/greybus/es2.c                              |    2 +-
 .../hwtracing/coresight/coresight-cfg-preload.c    |    9 +-
 drivers/hwtracing/coresight/coresight-config.h     |    9 +-
 drivers/hwtracing/coresight/coresight-core.c       |    2 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   11 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   10 +-
 .../coresight/coresight-syscfg-configfs.c          |   87 +
 .../coresight/coresight-syscfg-configfs.h          |    4 +
 drivers/hwtracing/coresight/coresight-syscfg.c     |  315 ++-
 drivers/hwtracing/coresight/coresight-syscfg.h     |   39 +-
 drivers/iio/Kconfig                                |    2 +
 drivers/iio/Makefile                               |    2 +
 drivers/iio/accel/bma180.c                         |    4 +-
 drivers/iio/accel/bma220_spi.c                     |    6 +-
 drivers/iio/accel/bmc150-accel-core.c              |    2 +-
 drivers/iio/accel/kxcjk-1013.c                     |    5 +-
 drivers/iio/accel/mma7455_core.c                   |    3 +-
 drivers/iio/accel/mma7660.c                        |    8 +-
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/accel/mma9553.c                        |    2 +-
 drivers/iio/accel/sca3000.c                        |   17 +-
 drivers/iio/accel/stk8312.c                        |    2 +-
 drivers/iio/accel/stk8ba50.c                       |    3 +-
 drivers/iio/adc/Kconfig                            |   21 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7192.c                           |    3 +-
 drivers/iio/adc/ad7266.c                           |    3 +-
 drivers/iio/adc/ad7606.h                           |    2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |    4 -
 drivers/iio/adc/at91-sama5d2_adc.c                 |   38 +-
 drivers/iio/adc/axp20x_adc.c                       |   45 +-
 drivers/iio/adc/envelope-detector.c                |    3 +-
 drivers/iio/adc/hi8435.c                           |    2 +-
 drivers/iio/adc/imx7d_adc.c                        |    5 +-
 drivers/iio/adc/ina2xx-adc.c                       |   15 +-
 drivers/iio/adc/lpc18xx_adc.c                      |    6 +-
 drivers/iio/adc/max9611.c                          |   20 +-
 drivers/iio/adc/mcp3911.c                          |    9 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    3 +-
 drivers/iio/adc/rzg2l_adc.c                        |    4 +-
 drivers/iio/adc/stm32-adc.c                        |    3 +-
 drivers/iio/adc/stmpe-adc.c                        |    5 +-
 drivers/iio/adc/ti-adc081c.c                       |   22 +-
 drivers/iio/adc/ti-adc12138.c                      |   14 +-
 drivers/iio/adc/ti-ads1015.c                       |   10 +-
 drivers/iio/adc/ti-ads124s08.c                     |    3 +-
 drivers/iio/adc/ti-ads8688.c                       |    4 +-
 drivers/iio/adc/xilinx-ams.c                       | 1451 ++++++++++++++
 drivers/iio/adc/xilinx-xadc-core.c                 |   64 +-
 drivers/iio/addac/Kconfig                          |   20 +
 drivers/iio/addac/Makefile                         |    7 +
 drivers/iio/addac/ad74413r.c                       | 1475 ++++++++++++++
 drivers/iio/amplifiers/hmc425a.c                   |    2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    2 +-
 drivers/iio/chemical/atlas-sensor.c                |    4 -
 drivers/iio/chemical/sunrise_co2.c                 |    4 +-
 drivers/iio/chemical/vz89x.c                       |    2 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |   57 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    4 +-
 drivers/iio/dac/Kconfig                            |   22 +-
 drivers/iio/dac/Makefile                           |    2 +
 drivers/iio/dac/ad3552r.c                          | 1138 +++++++++++
 drivers/iio/dac/ad5064.c                           |    4 +-
 drivers/iio/dac/ad5380.c                           |    2 +-
 drivers/iio/dac/ad5446.c                           |    2 +-
 drivers/iio/dac/ad5504.c                           |    2 +-
 drivers/iio/dac/ad5624r_spi.c                      |    2 +-
 drivers/iio/dac/ad5686.c                           |    2 +-
 drivers/iio/dac/ad5755.c                           |  152 +-
 drivers/iio/dac/ad5758.c                           |    3 +-
 drivers/iio/dac/ad5766.c                           |   13 +-
 drivers/iio/dac/ad5791.c                           |    2 +-
 drivers/iio/dac/ad7293.c                           |  934 +++++++++
 drivers/iio/dac/dpot-dac.c                         |    2 +-
 drivers/iio/dac/lpc18xx_dac.c                      |    3 +-
 drivers/iio/dac/max5821.c                          |    2 +-
 drivers/iio/dac/mcp4725.c                          |   10 +-
 drivers/iio/dac/stm32-dac.c                        |    2 +-
 drivers/iio/dac/ti-dac082s085.c                    |    2 +-
 drivers/iio/dac/ti-dac5571.c                       |    2 +-
 drivers/iio/dac/ti-dac7311.c                       |    2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |    2 -
 drivers/iio/filter/Kconfig                         |   18 +
 drivers/iio/filter/Makefile                        |    7 +
 drivers/iio/filter/admv8818.c                      |  665 ++++++
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/admv1013.c                   |  656 ++++++
 drivers/iio/health/afe4403.c                       |    5 -
 drivers/iio/health/afe4404.c                       |    5 -
 drivers/iio/iio_core.h                             |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    4 +-
 drivers/iio/industrialio-buffer.c                  |   20 +-
 drivers/iio/industrialio-core.c                    |    6 +-
 drivers/iio/industrialio-trigger.c                 |   36 +-
 drivers/iio/light/cm3605.c                         |    6 +-
 drivers/iio/light/gp2ap020a00f.c                   |    5 -
 drivers/iio/light/ltr501.c                         |   42 +-
 drivers/iio/magnetometer/ak8975.c                  |    2 +-
 drivers/iio/magnetometer/hmc5843_core.c            |    4 +-
 drivers/iio/magnetometer/mag3110.c                 |    6 +-
 drivers/iio/potentiometer/mcp41010.c               |    6 +-
 drivers/iio/potentiostat/lmp91000.c                |    4 -
 drivers/iio/pressure/mpl3115.c                     |   16 +-
 drivers/iio/pressure/ms5611.h                      |    6 +-
 drivers/iio/pressure/ms5611_core.c                 |    7 +-
 drivers/iio/pressure/ms5611_i2c.c                  |   11 +-
 drivers/iio/pressure/ms5611_spi.c                  |   17 +-
 drivers/iio/proximity/as3935.c                     |    6 +-
 drivers/iio/test/iio-test-format.c                 |  123 +-
 drivers/iio/trigger/iio-trig-interrupt.c           |    4 -
 drivers/iio/trigger/iio-trig-sysfs.c               |    4 -
 drivers/iio/trigger/stm32-timer-trigger.c          |    4 +-
 drivers/interconnect/qcom/Kconfig                  |   27 +
 drivers/interconnect/qcom/Makefile                 |    6 +
 drivers/interconnect/qcom/icc-rpm.c                |   64 +-
 drivers/interconnect/qcom/icc-rpm.h                |   15 +-
 drivers/interconnect/qcom/icc-rpmh.c               |   10 +-
 drivers/interconnect/qcom/msm8916.c                |    4 +-
 drivers/interconnect/qcom/msm8939.c                |    5 +-
 drivers/interconnect/qcom/msm8996.c                | 2110 ++++++++++++++++++++
 drivers/interconnect/qcom/msm8996.h                |  149 ++
 drivers/interconnect/qcom/osm-l3.c                 |   20 +-
 drivers/interconnect/qcom/qcm2290.c                | 1363 +++++++++++++
 drivers/interconnect/qcom/sc7280.h                 |    2 +
 drivers/interconnect/qcom/sdm660.c                 |    7 +-
 drivers/interconnect/qcom/sm8150.c                 |    1 -
 drivers/interconnect/qcom/sm8250.c                 |    1 -
 drivers/interconnect/qcom/sm8350.c                 |    1 -
 drivers/interconnect/qcom/sm8450.c                 | 1987 ++++++++++++++++++
 drivers/interconnect/qcom/sm8450.h                 |  169 ++
 drivers/misc/cxl/sysfs.c                           |    3 +-
 drivers/misc/eeprom/at25.c                         |  213 +-
 drivers/misc/habanalabs/common/command_buffer.c    |   46 +-
 .../misc/habanalabs/common/command_submission.c    |  389 +++-
 drivers/misc/habanalabs/common/context.c           |   39 +-
 drivers/misc/habanalabs/common/debugfs.c           |   97 +-
 drivers/misc/habanalabs/common/device.c            |  387 ++--
 drivers/misc/habanalabs/common/firmware_if.c       |  253 ++-
 drivers/misc/habanalabs/common/habanalabs.h        |  301 ++-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |  150 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |  195 +-
 drivers/misc/habanalabs/common/hw_queue.c          |    5 +-
 drivers/misc/habanalabs/common/hwmon.c             |  209 +-
 drivers/misc/habanalabs/common/irq.c               |   14 +-
 drivers/misc/habanalabs/common/memory.c            |   78 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |   25 +
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |   18 +-
 drivers/misc/habanalabs/common/sysfs.c             |   56 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  313 ++-
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    4 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |    4 +-
 drivers/misc/habanalabs/goya/goya.c                |  165 +-
 drivers/misc/habanalabs/goya/goyaP.h               |   14 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |    4 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |   31 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   62 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |    4 +
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |   19 +-
 .../misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   18 +-
 .../misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h   |   20 +-
 drivers/misc/lattice-ecp3-config.c                 |   12 +-
 drivers/misc/lkdtm/Makefile                        |    2 +-
 drivers/misc/lkdtm/bugs.c                          |   16 +-
 drivers/misc/lkdtm/core.c                          |    6 +-
 drivers/misc/mei/client.c                          |    4 +
 drivers/misc/mei/hbm.c                             |   20 +-
 drivers/misc/mei/hw-txe.c                          |    6 +-
 drivers/misc/mei/init.c                            |    1 +
 drivers/misc/ocxl/file.c                           |    4 +-
 drivers/misc/sram.c                                |    1 +
 drivers/misc/uacce/uacce.c                         |   12 +-
 drivers/misc/vmw_vmci/vmci_context.c               |    6 +-
 drivers/misc/vmw_vmci/vmci_event.c                 |    3 +-
 drivers/most/most_usb.c                            |    4 +-
 drivers/nvmem/core.c                               |    2 +
 drivers/nvmem/mtk-efuse.c                          |   13 +-
 drivers/phy/amlogic/Kconfig                        |   10 +
 drivers/phy/amlogic/Makefile                       |    1 +
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c           |  160 ++
 drivers/phy/broadcom/phy-bcm-ns-usb2.c             |   54 +-
 drivers/phy/cadence/phy-cadence-sierra.c           | 1312 +++++++++++-
 drivers/phy/cadence/phy-cadence-torrent.c          |    6 +-
 drivers/phy/freescale/Kconfig                      |    8 +
 drivers/phy/freescale/Makefile                     |    1 +
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |  237 +++
 drivers/phy/intel/Kconfig                          |   10 +
 drivers/phy/intel/Makefile                         |    1 +
 drivers/phy/intel/phy-intel-thunderbay-emmc.c      |  509 +++++
 drivers/phy/mediatek/phy-mtk-io.h                  |   38 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |    2 +
 drivers/phy/mediatek/phy-mtk-tphy.c                |  608 +++---
 drivers/phy/mediatek/phy-mtk-xsphy.c               |  140 +-
 drivers/phy/microchip/Kconfig                      |    8 +
 drivers/phy/microchip/Makefile                     |    1 +
 drivers/phy/microchip/lan966x_serdes.c             |  545 +++++
 drivers/phy/microchip/lan966x_serdes_regs.h        |  209 ++
 drivers/phy/phy-can-transceiver.c                  |    4 +-
 drivers/phy/qualcomm/Kconfig                       |   10 +
 drivers/phy/qualcomm/Makefile                      |    1 +
 drivers/phy/qualcomm/phy-qcom-edp.c                |  674 +++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  313 +++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  104 +
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |  260 ++-
 drivers/phy/socionext/Kconfig                      |    2 +-
 drivers/phy/socionext/phy-uniphier-ahci.c          |  201 +-
 drivers/phy/socionext/phy-uniphier-pcie.c          |   70 +-
 drivers/phy/socionext/phy-uniphier-usb3hs.c        |    4 +
 drivers/phy/socionext/phy-uniphier-usb3ss.c        |   14 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |   10 +-
 drivers/phy/tegra/xusb.c                           |    2 +-
 drivers/phy/ti/phy-omap-control.c                  |    6 +-
 drivers/rapidio/switches/Kconfig                   |   11 -
 drivers/rapidio/switches/Makefile                  |    2 -
 drivers/rapidio/switches/tsi568.c                  |  195 --
 drivers/rapidio/switches/tsi57x.c                  |  365 ----
 drivers/soc/xilinx/Kconfig                         |   10 +
 drivers/soc/xilinx/Makefile                        |    1 +
 drivers/soc/xilinx/xlnx_event_manager.c            |  600 ++++++
 drivers/soc/xilinx/zynqmp_power.c                  |   54 +-
 drivers/soundwire/qcom.c                           |    6 +-
 drivers/spmi/Kconfig                               |   11 +
 drivers/spmi/Makefile                              |    1 +
 drivers/spmi/spmi-mtk-pmif.c                       |  542 +++++
 drivers/spmi/spmi-pmic-arb.c                       |  193 +-
 drivers/uio/uio.c                                  |    8 +-
 drivers/uio/uio_dmem_genirq.c                      |    6 +-
 drivers/virt/nitro_enclaves/Kconfig                |    9 +
 drivers/virt/nitro_enclaves/ne_misc_dev.c          |  174 +-
 drivers/virt/nitro_enclaves/ne_misc_dev_test.c     |  157 ++
 drivers/virt/nitro_enclaves/ne_pci_dev.c           |    1 -
 drivers/w1/slaves/w1_ds28e04.c                     |   26 +-
 drivers/w1/slaves/w1_therm.c                       |    7 +-
 include/dt-bindings/iio/addac/adi,ad74413r.h       |   21 +
 include/dt-bindings/interconnect/qcom,msm8996.h    |  163 ++
 include/dt-bindings/interconnect/qcom,qcm2290.h    |   94 +
 include/dt-bindings/interconnect/qcom,sm8450.h     |  171 ++
 include/dt-bindings/mux/ti-serdes.h                |   22 +
 include/dt-bindings/phy/phy-cadence.h              |    9 +-
 include/dt-bindings/phy/phy-imx8-pcie.h            |   14 +
 include/dt-bindings/phy/phy-lan966x-serdes.h       |   14 +
 include/linux/byteorder/generic.h                  |    4 +-
 .../drivers => include/linux/comedi}/comedi_8254.h |    0
 .../8255.h => include/linux/comedi/comedi_8255.h   |    8 +-
 .../linux/comedi}/comedi_isadma.h                  |    0
 {drivers => include/linux}/comedi/comedi_pci.h     |    3 +-
 {drivers => include/linux}/comedi/comedi_pcmcia.h  |    3 +-
 {drivers => include/linux}/comedi/comedi_usb.h     |    3 +-
 {drivers => include/linux}/comedi/comedidev.h      |    3 +-
 {drivers => include/linux}/comedi/comedilib.h      |    0
 include/linux/counter.h                            |   55 +-
 include/linux/firmware/xlnx-event-manager.h        |   36 +
 include/linux/firmware/xlnx-zynqmp.h               |   33 +-
 include/linux/fpga/fpga-bridge.h                   |   30 +-
 include/linux/fpga/fpga-mgr.h                      |   62 +-
 include/linux/fpga/fpga-region.h                   |   36 +-
 include/linux/iio/buffer-dma.h                     |    5 -
 include/linux/iio/iio.h                            |    5 +-
 include/linux/iio/trigger.h                        |    2 +
 include/linux/iio/types.h                          |    1 +
 include/linux/mhi.h                                |   21 +-
 include/linux/platform_data/ad5755.h               |  102 -
 include/linux/property.h                           |    2 +
 include/linux/rio_ids.h                            |   13 -
 {drivers/comedi => include/uapi/linux}/comedi.h    |    2 +-
 include/uapi/misc/habanalabs.h                     |  166 +-
 net/qrtr/mhi.c                                     |    2 +-
 samples/Kconfig                                    |    9 +
 samples/Makefile                                   |    1 +
 samples/coresight/Makefile                         |    4 +
 samples/coresight/coresight-cfg-sample.c           |   73 +
 scripts/tags.sh                                    |  126 +-
 tools/iio/iio_event_monitor.c                      |    1 +
 tools/testing/selftests/lkdtm/stack-entropy.sh     |   16 +-
 533 files changed, 26917 insertions(+), 4557 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
 create mode 100644 drivers/gnss/usb.c
 create mode 100644 drivers/iio/adc/xilinx-ams.c
 create mode 100644 drivers/iio/addac/Kconfig
 create mode 100644 drivers/iio/addac/Makefile
 create mode 100644 drivers/iio/addac/ad74413r.c
 create mode 100644 drivers/iio/dac/ad3552r.c
 create mode 100644 drivers/iio/dac/ad7293.c
 create mode 100644 drivers/iio/filter/Kconfig
 create mode 100644 drivers/iio/filter/Makefile
 create mode 100644 drivers/iio/filter/admv8818.c
 create mode 100644 drivers/iio/frequency/admv1013.c
 create mode 100644 drivers/interconnect/qcom/msm8996.c
 create mode 100644 drivers/interconnect/qcom/msm8996.h
 create mode 100644 drivers/interconnect/qcom/qcm2290.c
 create mode 100644 drivers/interconnect/qcom/sm8450.c
 create mode 100644 drivers/interconnect/qcom/sm8450.h
 create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8m-pcie.c
 create mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-io.h
 create mode 100644 drivers/phy/microchip/lan966x_serdes.c
 create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-edp.c
 delete mode 100644 drivers/rapidio/switches/tsi568.c
 delete mode 100644 drivers/rapidio/switches/tsi57x.c
 create mode 100644 drivers/soc/xilinx/xlnx_event_manager.c
 create mode 100644 drivers/spmi/spmi-mtk-pmif.c
 create mode 100644 drivers/virt/nitro_enclaves/ne_misc_dev_test.c
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h
 create mode 100644 include/dt-bindings/phy/phy-imx8-pcie.h
 create mode 100644 include/dt-bindings/phy/phy-lan966x-serdes.h
 rename {drivers/comedi/drivers => include/linux/comedi}/comedi_8254.h (100%)
 rename drivers/comedi/drivers/8255.h => include/linux/comedi/comedi_8255.h (90%)
 rename {drivers/comedi/drivers => include/linux/comedi}/comedi_isadma.h (100%)
 rename {drivers => include/linux}/comedi/comedi_pci.h (98%)
 rename {drivers => include/linux}/comedi/comedi_pcmcia.h (97%)
 rename {drivers => include/linux}/comedi/comedi_usb.h (97%)
 rename {drivers => include/linux}/comedi/comedidev.h (99%)
 rename {drivers => include/linux}/comedi/comedilib.h (100%)
 create mode 100644 include/linux/firmware/xlnx-event-manager.h
 delete mode 100644 include/linux/platform_data/ad5755.h
 rename {drivers/comedi => include/uapi/linux}/comedi.h (99%)
 create mode 100644 samples/coresight/Makefile
 create mode 100644 samples/coresight/coresight-cfg-sample.c
