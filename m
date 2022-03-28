Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D560B4E986E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbiC1NlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiC1NlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:41:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EEA31532
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30B97B81123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064E4C004DD;
        Mon, 28 Mar 2022 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648474767;
        bh=tZAwBhSWPmBHbYZTZClu4UwkkC/GovRQ4rnSaCCq9VY=;
        h=Date:From:To:Cc:Subject:From;
        b=ccyiL1KajcaI+VnHiibT11I6QJMCL4g1cim/w3vdkZKccoUdQr93Paa0C5qZsCy55
         3Xj2ydAhz3nO4isbWClcoyMsXiocSYJiLShqBFqQL9knrt0QugBaXlC4ec/7Izojc3
         wzydxV97qzvjTp2Uw48JYfZhgOsV3q5Cby5jE190=
Date:   Mon, 28 Mar 2022 15:39:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc and other driver updates for 5.18-rc1
Message-ID: <YkG6jOtPmhHehQoz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc1

for you to fetch changes up to 37fd83916da2e4cae03d350015c82a67b1b334c4:

  firmware: google: Properly state IOMEM dependency (2022-03-18 14:18:15 +0100)

----------------------------------------------------------------
Char/Misc and other driver updates for 5.18-rc1

Here is the big set of char/misc and other small driver subsystem
updates for 5.18-rc1.

Included in here are merges from driver subsystems which contain:
	- iio driver updates and new drivers
	- fsi driver updates
	- fpga driver updates
	- habanalabs driver updates and support for new hardware
	- soundwire driver updates and new drivers
	- phy driver updates and new drivers
	- coresight driver updates
	- icc driver updates

Individual changes include:
	- mei driver updates
	- interconnect driver updates
	- new PECI driver subsystem added
	- vmci driver updates
	- lots of tiny misc/char driver updates

There will be two merge conflicts with your tree, one in MAINTAINERS
which is obvious to fix up, and one in drivers/phy/freescale/Kconfig
which also should be easy to resolve.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (1):
      interconnect: imx: Add imx_icc_get_bw function to set initial avg and peak

Al Cooper (1):
      phy: usb: Add "wake on" functionality for newer Synopsis XHCI controllers

Aleksa Vučković (7):
      drivers: dio: Use <linux/io.h> instead <asm/io.h>
      drivers: dio: brace should be on the previous line
      drivers: dio: trailing whitespace
      drivers: dio: space prohibited after parenthesis
      drivers: dio: space required after that ','
      drivers: dio: code indent should use tabs
      drivers: dio: Missing a blank line after declarations

Alexander Usyskin (6):
      mei: me: disable driver on the ign firmware
      mei: me: avoid link reset on shutdown
      mei: me: fix reset policy on read error in interrupt
      mei: do not overwrite state on hw start
      mei: me: add Alder Lake N device id.
      mei: avoid iterator usage outside of list_for_each_entry

Allen-KH Cheng (2):
      dt-bindings: phy: Add compatible for Mediatek MT8186
      dt-bindings: phy: mediatek,tphy: Add compatible for MT8192

Amitay Isaacs (2):
      fsi: sbefifo: Use specified value of start of response timeout
      fsi: sbefifo: Implement FSI_SBEFIFO_READ_TIMEOUT_SECONDS ioctl

Amjad Ouled-Ameur (3):
      phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
      phy: amlogic: meson8b-usb2: Use dev_err_probe()
      phy: amlogic: meson8b-usb2: fix shared reset control use

Andre Przywara (1):
      phy: sun4i-usb: Rework HCI PHY (aka "pmu_unk1") handling

Andy Shevchenko (32):
      math.h: Introduce data types for fractional numbers
      iio: adc: rn5t618: Re-use generic struct u16_fract
      iio: adc: twl4030-madc: Re-use generic struct s16_fract
      iio: adc: qcom-vadc-common: Re-use generic struct u32_fract
      iio: dac: ad5592r: Drop leftover header inclusion
      iio: chemical: bme680: Switch from of headers to mod_devicetable.h
      iio: amplifiers: hmc425a: Make use of device properties
      iio: frequency: adf4350: Make use of device properties
      iio: humidity: dht11: Switch from of headers to mod_devicetable.h
      iio: temperature: mlx90632: Switch from of headers to mod_devicetable.h
      iio: temperature: maxim_thermocouple: Switch from of headers to mod_devicetable.h
      iio: accel: adxl355: Replace custom definitions with generic from units.h
      iio: imu: inv_mpu6050: Drop wrong use of ACPI_PTR()
      iio: imu: inv_mpu6050: Check ACPI companion directly
      iio: imu: inv_mpu6050: Make use of device properties
      iio: ssp_sensors: Make use of device properties
      iio: chemical: atlas-ezo-sensor: Make use of device properties
      iio: trigger: stm32-timer: Make use of device properties
      nvmem: core: Remove unused devm_nvmem_unregister()
      nvmem: core: Use devm_add_action_or_reset()
      nvmem: core: Check input parameter for NULL in nvmem_unregister()
      mtd: core: Drop duplicate NULL checks around nvmem_unregister()
      thunderbolt: Drop duplicate NULL checks around nvmem_unregister()
      misc: sgi-gru: Don't cast parameter in bit operations
      iio: accel: adxl345: Convert to use dev_err_probe()
      iio: accel: adxl345: Set driver_data for OF enumeration
      iio: accel: adxl345: Get rid of name parameter in adxl345_core_probe()
      iio: accel: adxl345: Make use of device properties
      iio: accel: adxl345: Extract adxl345_powerup() helper
      iio: accel: adxl345: Drop comma in terminator entries
      iio: accel: adxl345: Remove unneeded blank lines
      pps: generators: pps_gen_parport: Switch to use module_parport_driver()

Ang Tien Sung (1):
      firmware: stratix10-svc: add missing callback parameter on RSU

Anshuman Khandual (4):
      coresight: trbe: Work around the ignored system register writes
      coresight: trbe: Work around the invalid prohibited states
      coresight: trbe: Work around the trace data corruption
      coresight: Drop unused 'none' enum value for each component

Ansuel Smith (2):
      drivers: phy: qcom: ipq806x-usb: convert to BITFIELD macro
      drivers: phy: qcom: ipq806x-usb: conver latch function to pool macro

Antoniu Miclaus (12):
      MAINTAINERS: fix Analog Devices links
      MAINTAINERS: add maintainer for ADRF6780 driver
      MAINTAINERS: add maintainer for AD7293 driver
      MAINTAINERS: add maintainer for ADMV1013 driver
      MAINTAINERS: add maintainer for ADMV8818 driver
      iio: frequency: admv1014: add support for ADMV1014
      dt-bindings: iio: frequency: add admv1014 binding
      Documentation: ABI: testing: admv1014: add ABI docs
      MAINTAINERS: add maintainer for ADMV1014 driver
      dt-bindings: iio: amplifiers: add ada4250 doc
      iio: amplifiers: ada4250: add support for ADA4250
      MAINTAINERS: add maintainer for ADA4250 driver

Aswath Govindraju (2):
      mux: Add support for reading mux state from consumer DT node
      phy: cadence: Sierra: Add support for skipping configuration

Billy Tsai (1):
      iio: adc: aspeed: Add divider flag to fix incorrect voltage reading.

Bjorn Andersson (4):
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add sc8180x and sc8280xp
      phy: qcom-snps: Add sc8280xp support
      dt-bindings: phy: qcom,qmp: add sc8180x and sc8280xp ufs compatibles
      phy: qcom-qmp: add sc8280xp UFS PHY

Bryan O'Donoghue (2):
      dt-bindings: interconnect: Convert snoc-mm to a sub-node of snoc
      interconnect: qcom: msm8939: Remove snoc_mm specific regmap

Cai Huoqing (3):
      mailmap: Update email address for Cai Huoqing
      ocxl: Make use of the helper macro LIST_HEAD()
      powerpc/BSR: Make use of the helper macro LIST_HEAD()

Christian Vogel (1):
      w1/ds2490: remove spurious newlines within hexdump

Christophe JAILLET (9):
      mei: me: Use dma_set_mask_and_coherent() and simplify code
      fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API
      fsi: Aspeed: Fix a potential double free
      misc: alcor_pci: Fix an error handling path
      iio: as3935: Use devm_delayed_work_autocancel()
      VMCI: Fix the description of vmci_check_host_caps()
      VMCI: No need to clear memory after a dma_alloc_coherent() call
      VMCI: Fix some error handling paths in vmci_guest_probe_device()
      iio: adc: xilinx-ams: Use devm_delayed_work_autocancel() to simplify code

Colin Ian King (3):
      iio: adc: cpcap-adc: remove redundant assignment to variable cal_data_diff
      comedi: remove redundant assignment to variable buffer_config
      misc: sgi-gru: Fix spelling mistake "unexpect" -> "unexpected"

Corentin Labbe (2):
      hpet: fix style issue about braces and alignment
      hpet: remove unused writeq/readq function definitions

Cosmin Tanislav (5):
      iio: introduce mag_referenced
      iio: ABI: document mag_referenced
      iio: ABI: add note about configuring other attributes during buffer capture
      dt-bindings: iio: accel: add ADXL367
      iio: accel: add ADXL367 driver

Cristian Pop (2):
      dt-bindings: iio: frequency: Add ADMV4420 doc
      iio: frequency: admv4420.c: Add support for ADMV4420

Dan Carpenter (3):
      greybus: svc: fix an error handling bug in gb_svc_hello()
      iio: accel: adxl367: unlock on error in adxl367_buffer_predisable()
      habanalabs: silence an uninitialized variable warning

Dani Liberman (2):
      habanalabs: fix soft reset flow in case of failure
      habanalabs: fix race when waiting on encaps signal

David Brazdil (2):
      dt-bindings: reserved-memory: Open Profile for DICE
      misc: open-dice: Add driver to expose DICE data to userspace

David Gow (1):
      firmware: google: Properly state IOMEM dependency

David Heidelberg (1):
      dt-bindings: phy: convert Qualcomm USB HS phy to yaml

Desmond Yan (1):
      misc: bcm-vk: Remove viper from device id table

Dinh Nguyen (1):
      MAINTAINERS: add a git repo for the Stratix10 Service driver

Eddie James (2):
      fsi: occ: Improve response status checking
      fsi: Add trace events in initialization path

Eugen Hristev (1):
      dt-bindings: iio: adc: atmel,sama5d2-adc: make atmel,trigger-edge-type non-mandatory

Geert Uytterhoeven (1):
      phy: freescale: i.MX8 PHYs should depend on ARCH_MXC && ARM64

Georgi Djakov (2):
      interconnect: Add stubs for the bulk API
      Merge branch 'icc-msm8939' into icc-next

Greg Kroah-Hartman (12):
      Merge tag 'v5.17-rc2' into char-misc-next
      Merge 5.17-rc4 into char-misc-next
      Merge tag 'fsi-for-v5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi into char-misc-next
      Merge 5.17-rc6 into char-misc-next
      Revert "mfd: simple-mfd-i2c: Add Delta TN48M CPLD support"
      Merge tag 'fpga-for-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-next
      Merge tag 'misc-habanalabs-next-2022-02-28' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next
      Merge tag 'soundwire-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-next
      Merge tag 'phy-for-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next
      Merge tag 'icc-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'iio-for-5.18a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'coresight-next-v5.18-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next

Guodong Liu (2):
      dt-bindings: iio: adc: Add compatible for Mediatek MT8186
      iio: adc: mt8186: Add compatible node for mt8186

Gustavo A. R. Silva (2):
      iio: hw_consumer: Use struct_size() helper in kzalloc()
      comedi: das16: Use struct_size() helper in comedi_alloc_spriv()

Gwendal Grignou (8):
      iio:proximity:sx9310: Add frequency in read_avail
      iio:proximity:sx9310: Extract common Semtech sensor logic
      iio:proximity:sx9324: Add SX9324 support
      dt-bindings:iio:proximity: Add sx9324 binding
      iio:proximity:sx9324: Add dt_binding support
      iio:proximity:sx9360: Add sx9360 support
      dt-bindings:iio:proximity: Add sx9360 binding
      iio:proximity:sx9360: Add dt-binding support

Haibo Chen (2):
      iio: imu: st_lsm6dsx: use dev_to_iio_dev() to get iio_dev struct
      iio: accel: mma8452: use the correct logic to get mma8452_data

Hans de Goede (5):
      iio: mma8452: Fix probe failing when an i2c_device_id is used
      iio: mma8452: Add support for the "mount-matrix" device property
      phy: ti: tusb1210: Improve ulpi_read()/_write() error checking
      phy: ti: tusb1210: Drop tusb->vendor_specific2 != 0 check from tusb1210_power_on()
      phy: ti: tusb1210: Add a delay between power-on and restoring the phy-parameters

Haowen Bai (1):
      virt: fsl_hypervisor: Directly return 0 instead of using local ret variable

Iwona Winiarska (11):
      dt-bindings: Add generic bindings for PECI
      dt-bindings: Add bindings for peci-aspeed
      ARM: dts: aspeed: Add PECI controller nodes
      peci: Add core infrastructure
      peci: Add device detection
      peci: Add sysfs interface for PECI bus
      peci: Add support for PECI device drivers
      peci: Add peci-cpu driver
      hwmon: peci: Add cputemp driver
      hwmon: peci: Add dimmtemp driver
      docs: Add PECI documentation

Jae Hyun Yoo (2):
      peci: Add peci-aspeed controller driver
      docs: hwmon: Document PECI drivers

Jagath Jog J (7):
      iio: potentiometer: ds1803: Alignment to match the open parenthesis
      iio: potentiometer: ds1803: Add available functionality
      iio: potentiometer: ds1803: Add channel information in device data
      iio: potentiometer: ds1803: Change to firmware provided data
      iio: potentiometer: ds1803: Add device specific read_raw function
      iio: potentiometer: ds1803: Add support for Maxim DS3502
      dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices

James Clark (2):
      coresight: Fix TRCCONFIGR.QE sysfs interface
      coresight: no-op refactor to make INSTP0 check more idiomatic

Jan Luebbe (1):
      dt-bindings: iio: adc: microchip,mcp3201: fix interface type (I2C -> SPI)

Jeya R (5):
      misc: fastrpc: add support for FASTRPC_IOCTL_MEM_MAP/UNMAP
      misc: fastrpc: Add support to get DSP capabilities
      dt-bindings: misc: add property to support non-secure DSP
      misc: fastrpc: check before loading process to the DSP
      arm64: dts: qcom: add non-secure domain property to fastrpc nodes

Jiasheng Jiang (2):
      iio: adc: Add check for devm_request_threaded_irq
      habanalabs: Add check for pci_enable_device

Joel Stanley (2):
      fsi: scom: Fix error handling
      fsi: scom: Remove retries in indirect scoms

Johan Hovold (3):
      greybus: svc: clean up hello error path
      greybus: svc: clean up link configuration hack at hello
      firmware: sysfb: fix platform-device leak in error path

Johan Jonker (1):
      dt-bindings: soc: grf: add naneng combo phy register compatible

Jonathan Cameron (115):
      iio:chemical:atlas: Trivial white space cleanup to add space before }
      iio:light:pa12203001: Tidy up white space change to add spaces after { and before }
      iio:light:vcnl4035: Trivial whitespace cleanup to add space before }
      iio:light:us5182: White space cleanup of spacing around {} in id tables
      iio:light:ltr501: White space cleanup of spacing around {} in id tables
      iio:proximity:ping: White space cleanup of spacing around {} in id tables
      iio:proximity:rfd77402: White space cleanup of spacing around {} in id tables
      iio:proximity:srf04: White space cleanup of spacing around {} in id tables
      iio:proximity:srf08: White space cleanup of spacing around {} in id tables
      iio:frequency:admv1013: White space cleanup of spacing around {} in id tables
      iio:adc:mt6577_auxadc: Tidy up white space around {} in id tables
      iio:adc:hi8435: Tidy up white space around {} in id tables
      iio:adc:ti-adc084s021: Tidy up white space around {}
      iio:light:tsl2722: Fix inconsistent spacing before } in id table
      iio:proximity:vl53l0x: Tidy up white space around {} in id tables
      iio:accel:dmard09: Tidy up white space around {} in id table
      iio:accel:mma9551_core: Move exports into IIO_MMA9551 namespace
      iio:accel:mma7455_core: Move exports into IIO_MMA7455 namespace
      iio:accel:kxsd9: Move exports into IIO_KDSD9 namespace
      iio:accel:bma400: Move exports into IIO_BMA400 namespace
      iio:accel:adxl313: Move exports into IIO_ADXL313 namespace
      iio:accel:adxl345: Move exports into IIO_ADXL345 namespace
      iio:accel:adxl355: Move exports into IIO_ADXL355 namespace
      iio:accel:adxl372: Move exports into IIO_ADXL372 namespace
      iio:accel:bmc150: Move exports into IIO_BMC150 namespace
      iio:accel:bmi088: Move exports into IIO_BMI088 namespace
      iio:accel:fxl8962af: Move exports into IIO_FXL8962AF namespace
      iio:st-sensors: Remove duplicate MODULE_*
      iio:st-sensors: Move exports into IIO_ST_SENSORS namespace
      iio:adc:ad_sigma_delta: Move exports into IIO_AD_SIGMA_DELTA namespace
      iio:adc:ad7091r: Move exports into IIO_AD7091R namespace.
      iio:adc:ad76060: Move exports into IIO_AD7606 namespace.
      iio:common:meas-spec: Move exports into IIO_MEAS_SPEC_SENSORS
      iio:common:ssp_sensors: Move exports into IIO_SSP_SENSORS namespace
      iio:dac:ad5592r: Move exports into IIO_AD5592R namespace
      iio:dac:ad5686: Move exports into IIO_AD5686 namespace
      iio:imu:adis: Move exports into IIO_ADISLIB namespace
      iio:pressure:zpa2326: Move exports into IIO_ZPA2326 namespace
      iio:pressure:ms5611: Move exports into IIO_MS5611 namespace
      iio:pressure:mpl115: Move exports into IIO_MPL115 namespace
      iio:magnetometer:rm3100: Move exports to IIO_RM3100 namespace
      iio:magnetometer:bmc150: Move exports to IIO_BMC150_MAGN namespace
      iio:magnetometer:hmc5843: Move exports to IIO_HMC5843 namespace
      iio:light:st_uvis25: Move exports to IIO_UVIS25 namespace
      iio:chemical:bme680: Move exports to IIO_BME680 namespace
      iio:accel:da311: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:accel:da280: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:accel:dmard06: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:accel:dmard10: Switch from CONFIG_PM guards to pm_sleep_ptr() etc
      iio:accel:mc3230: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:accel:mma7660: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      iio:accel:mma9551: Switch from CONFIG_PM guards to pm_ptr() etc
      iio:accel:mma9553: Switch from CONFIG_PM guards to pm_ptr() etc
      iio:accel:stk8ba50: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      iio:adc:rockchip: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:adc:twl6030: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:adc:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:common:ssp: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:dac:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:apds9300: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:cm3232: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:isl29018: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      iio:light:isl29125: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:jsa1212: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:ltr501: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:stk3310: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:tcs3414: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:tcs3472: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:tsl2563: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:light:tsl4531: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:magn:ak8975: Switch from CONFIG_PM guards to pm_ptr() etc
      iio:magn:mag3110: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:magn:mmc35240: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:pressure:mpl3115: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:proximity:as3935: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:proximity:rfd77492: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:proximity:sx9500: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:temperature:tmp006: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:temperature:tmp007: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:accel:stk8312: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:accel:bma180: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:dac:m62332: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      iio:imu:kmx61: Switch from CONFIG_PM* guards to pm_ptr() etc
      iio:temperature:mlx90614: Switch from CONFIG_PM* guards to pm_ptr() etc
      iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() etc
      iio:adc:stm32:Switch from CONFIG_PM guards to pm_ptr()
      iio:adc:rcar: Switch from CONFIG_PM guards to pm_ptr() etc
      iio:light:bh1780: Switch from CONFIG_PM guards to pm_ptr() etc
      iio:proximity:pulsedlight: Switch from CONFIG_PM guards to pm_ptr() etc
      iio:chemical:atlas: Switch from CONFIG_PM guards to pm_ptr() etc
      iio:light:rpr0521: Switch from CONFIG_PM guards to pm_ptr() etc
      iio:adc:stm32*: Use pm[_sleep]_ptr() etc to avoid need to make pm __maybe_unused
      staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
      staging:iio:adc:ad7280a: Register define cleanup.
      staging:iio:adc:ad7280a: rename _read() to _read_reg()
      staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
      staging:iio:adc:ad7280a: Use bitfield ops to managed fields in transfers.
      staging:iio:adc:ad7280a: Switch to standard event control
      staging:iio:adc:ad7280a: Standardize extended ABI naming
      staging:iio:adc:ad7280a: Drop unused timestamp channel.
      staging:iio:adc:ad7280a: Trivial comment formatting cleanup
      staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
      staging:iio:adc:ad7280a: Cleanup includes
      staging:iio:ad7280a: Reflect optionality of irq in ABI
      staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
      staging:iio:adc:ad7280a: Use device properties to replace platform data.
      staging:iio:adc:ad7280a: Drop buggy support for early termination of AUX alert.
      dt-bindings:iio:adc:ad7280a: Add binding
      iio:adc:ad7280a: Document ABI for cell balance switches
      staging:iio:adc:ad7280a: Remove shift from cb_mask state cache.
      staging:iio:adc:ad7280a: Use more conservative delays to allow 105C operation.
      iio:adc:ad7280a: Move out of staging

Jongpil Jung (1):
      iio: sx9360: fix iio event generation

Jorgen Hansen (9):
      VMCI: dma dg: whitespace formatting change for vmci register defines
      VMCI: dma dg: add MMIO access to registers
      VMCI: dma dg: detect DMA datagram capability
      VMCI: dma dg: set OS page size
      VMCI: dma dg: register dummy IRQ handlers for DMA datagrams
      VMCI: dma dg: allocate send and receive buffers for DMA datagrams
      VMCI: dma dg: add support for DMA datagrams sends
      VMCI: dma dg: add support for DMA datagrams receive
      VMCI: Update maintainers for VMCI

Kai-Heng Feng (8):
      mmc: rtsx: Use pm_runtime_{get,put}() to handle runtime PM
      misc: rtsx: Rework runtime power management flow
      misc: rtsx: Cleanup power management ops
      misc: rtsx: Quiesce rts5249 on system suspend
      iio: pressure: dps310: Add ACPI HID table
      iio: humidity: hdc100x: Add ACPI HID table
      mmc: rtsx: Let MMC core handle runtime PM
      iio: accel: adxl345: Add ACPI HID table

Kees Cook (3):
      eeprom: at25: Replace strncpy() with strscpy()
      comedi: drivers: ni_routes: Use strcmp() instead of memcmp()
      lkdtm/fortify: Swap memcpy() for strncpy()

Knox Chiou (1):
      nvmem: qfprom: Increase fuse blow timeout to prevent write fail

Krzysztof Kozlowski (7):
      dt-bindings: phy: samsung: drop old Eynos5440 PCIe phy
      dt-bindings: phy: samsung,mipi-video-phy: convert to dtschema
      dt-bindings: phy: samsung,dp-video-phy: convert to dtschema
      dt-bindings: phy: samsung,usb2-phy: convert to dtschema
      dt-bindings: phy: samsung,exynos5250-sata-phy: convert to dtschema
      dt-bindings: phy: samsung: move SATA phy I2C to trivial devices
      dt-bindings: phy: samsung,usb3-drd-phy: convert to dtschema

Lad Prabhakar (3):
      iio: adc: rzg2l_adc: Fix typo
      dt-bindings: phy: renesas,usb2-phy: Document RZ/V2L phy bindings
      platform: goldfish: pipe: Use platform_get_irq() to get the interrupt

Lars-Peter Clausen (13):
      iio: core: Use sysfs_emit()
      iio: dmaengine-buffer: Use sysfs_emit()
      iio: ad7192: Use sysfs_emit()
      iio: ad9523: Use sysfs_emit()
      iio: as3935: Use sysfs_emit()
      iio: ina2xx-adc: sysfs_emit()
      iio: lm3533: Use sysfs_emit()
      iio: max31856: Use sysfs_emit()
      iio: max31865: Use sysfs_emit()
      iio: max9611: Use sysfs_emit()
      iio: ms_sensors: Use sysfs_emit()
      iio: scd4x: Use sysfs_emit()
      iio: sps30: Use sysfs_emit()

Leo Yan (4):
      coresight: etm4x: Add lock for reading virtual context ID comparator
      coresight: etm4x: Don't use virtual contextID for non-root PID namespace
      coresight: etm4x: Don't trace PID for non-root PID namespace
      coresight: etm3x: Don't trace PID for non-root PID namespace

Liam Beguin (15):
      iio: inkern: apply consumer scale on IIO_VAL_INT cases
      iio: inkern: apply consumer scale when no channel scale is available
      iio: inkern: make a best effort on offset calculation
      iio: afe: rescale: use s64 for temporary scale calculations
      iio: afe: rescale: reorder includes
      iio: afe: rescale: expose scale processing function
      iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
      iio: afe: rescale: add offset support
      iio: afe: rescale: fix accuracy for small fractional scales
      iio: afe: rescale: reduce risk of integer overflow
      iio: test: add basic tests for the iio-rescale driver
      iio: afe: rescale: add RTD temperature sensor support
      iio: afe: rescale: add temperature transducers
      dt-bindings: iio: afe: add bindings for temperature-sense-rtd
      dt-bindings: iio: afe: add bindings for temperature transducers

Libin Yang (1):
      soundwire: intel: fix wrong register name in intel_shim_wake

Liu Ying (1):
      phy: dphy: Correct lpx parameter and its derivatives(ta_{get,go,sure})

Luca Weiss (2):
      dt-bindings: phy: qcom,qusb2: Document msm8953 compatible
      phy: qcom-qusb2: Add compatible for MSM8953

Lucas Denefle (1):
      w1: w1_therm: fixes w1_seq for ds28ea00 sensors

Maciej W. Rozycki (1):
      parport_pc: Also enable driver for PCI systems

Manivannan Sadhasivam (7):
      bus: mhi: Move host MHI code to "host" directory
      bus: mhi: Use bitfield operations for register read and write
      bus: mhi: Use bitfield operations for handling DWORDs of ring elements
      bus: mhi: Cleanup the register definitions used in headers
      bus: mhi: host: Rename "struct mhi_tre" to "struct mhi_ring_element"
      bus: mhi: Move common MHI definitions out of host directory
      bus: mhi: Make mhi_state_str[] array static inline and move to common.h

Marcel Ziswiler (1):
      phy: freescale: pcie: cosmetic clean-up

Marijn Suijten (2):
      config: android-recommended: Don't explicitly disable CONFIG_AIO
      config: android-recommended: Disable BPF_UNPRIV_DEFAULT_OFF for netd

Markus Reichl (1):
      w1: w1_therm: Add support for Maxim MAX31850 thermoelement IF.

Miaoqian Lin (1):
      coresight: syscfg: Fix memleak on registration failure in cscfg_create_device

Michael Walle (2):
      dt-bindings: nvmem: add fsl,layerscape-sfp binding
      nvmem: add driver for Layerscape SFP (Security Fuse Processor)

Minghao Chi (1):
      drivers/android: remove redundant ret variable

Minghao Chi (CGEL ZTE) (1):
      phy/cadence: Use of_device_get_match_data()

Miquel Raynal (1):
      iio: core: Fix the kernel doc regarding the currentmode iio_dev entry

Muhammad Usama Anjum (2):
      selftests/lkdtm: Remove dead config option
      selftests/lkdtm: Add UBSAN config

Nathan Chancellor (1):
      iio: accel: adxl367: Fix handled initialization in adxl367_irq_handler()

Nicolas Ferre (1):
      dt-bindings: iio: adc: at91-sama5d2: update maintainers entry

Nikita Yushchenko (1):
      iio: st_sensors: don't always auto-enable I2C and SPI interface drivers

Nuno Sá (6):
      MAINTAINERS: add missing files to the adis lib
      adis: simplify 'adis_update_bits' macros
      iio: adis: stylistic changes
      iio: dac: add support for ltc2688
      iio: ABI: add ABI file for the LTC2688 DAC
      dt-bindings: iio: Add ltc2688 documentation

Oded Gabbay (26):
      habanalabs/gaudi: disable CGM permanently
      habanalabs: remove ASIC functions of clock gating
      habanalabs: sysfs functions should be in sysfs.c
      habanalabs: get clk is common function
      habanalabs: remove hwmgr.c
      habanalabs: move more f/w functions to firmware_if.c
      habanalabs: remove asic callback set_pll_profile()
      habanalabs: rename dev_attr_grp to dev_clk_attr_grp
      habanalabs: add vrm version to sysfs
      habanalabs: remove power9 workaround for dma support
      habanalabs: use common wrapper for MMU cache invalidation
      habanalabs: there is no kernel TDR in future ASICs
      habanalabs: don't free phys_pg_pack inside lock
      habanalabs: update to latest f/w specs
      habanalabs: expose number of user interrupts
      habanalabs: reject host map with mmu disabled
      habanalabs: fix user interrupt wait when timeout is 0
      habanalabs: fix race between wait and irq
      habanalabs: remove duplicate print
      habanalabs: fix spelling mistake
      habanalabs: rephrase error messages in PCI initialization
      habanalabs: fix use-after-free bug
      habanalabs: add missing include of vmalloc.h
      habanalabs: change function to static
      habanalabs/gaudi: handle axi errors from NIC engines
      habanalabs/gaudi: add missing handling of NIC related events

Ofir Bitton (1):
      habanalabs: remove deprecated firmware states

Ohad Sharabi (6):
      habanalabs: fix possible memory leak in MMU DR fini
      habanalabs: make some MMU functions common
      habanalabs: duplicate HOP table props to MMU props
      habanalabs: use kernel-doc for memory ioctl documentation
      habanalabs: allow user to set allocation page size
      habanalabs: make sure device mem alloc is page aligned

Oleksij Rempel (5):
      iio: adc: tsc2046: rework the trigger state machine
      iio: adc: tsc2046: add .read_raw support
      iio: adc: tsc2046: add sanity check to avoid to big allocations
      counter: add new COUNTER_EVENT_CHANGE_OF_STATE
      counter: interrupt-cnt: add counter_push_event()

Pali Rohár (5):
      phy: marvell: phy-mvebu-a3700-comphy: Remove port from driver configuration
      phy: marvell: phy-mvebu-a3700-comphy: Add native kernel implementation
      Revert "ata: ahci: mvebu: Make SATA PHY optional for Armada 3720"
      Revert "usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720"
      Revert "PCI: aardvark: Fix initialization with old Marvell's Arm Trusted Firmware"

Paul Davey (2):
      bus: mhi: Fix pm_state conversion to string
      bus: mhi: Fix MHI DMA structure endianness

Peter Rosin (2):
      mux: add missing mux_state_get
      mux: fix grammar, missing "is".

Pierre-Louis Bossart (20):
      soundwire: bus: add dev_warn() messages to track UNATTACHED devices
      soundwire: stream: remove unused parameter in sdw_stream_add_slave
      soundwire: stream: add slave runtime to list earlier
      soundwire: stream: simplify check on port range
      soundwire: stream: add alloc/config/free helpers for ports
      soundwire: stream: split port allocation and configuration loops
      soundwire: stream: split alloc and config in two functions
      soundwire: stream: add 'slave' prefix for port range checks
      soundwire: stream: group sdw_port and sdw_master/slave_port functions
      soundwire: stream: simplify sdw_alloc_master_rt()
      soundwire: stream: split sdw_alloc_master_rt() in alloc and config
      soundwire: stream: move sdw_alloc_slave_rt() before 'master' helpers
      soundwire: stream: split sdw_alloc_slave_rt() in alloc and config
      soundwire: stream: group sdw_stream_ functions
      soundwire: stream: rename and move master/slave_rt_free routines
      soundwire: stream: move list addition to sdw_slave_alloc_rt()
      soundwire: stream: separate alloc and config within sdw_stream_add_xxx()
      soundwire: stream: introduce sdw_slave_rt_find() helper
      soundwire: stream: sdw_stream_add_ functions can be called multiple times
      soundwire: stream: make enable/disable/deprepare idempotent

Pratyush Yadav (4):
      phy: cadence: Add Cadence D-PHY Rx driver
      phy: dt-bindings: Convert Cadence DPHY binding to YAML
      phy: dt-bindings: cdns,dphy: add power-domains property
      phy: dt-bindings: Add Cadence D-PHY Rx bindings

Rafael J. Wysocki (2):
      soundwire: Replace acpi_bus_get_device()
      hwtracing: coresight: Replace acpi_bus_get_device()

Rafał Miłecki (4):
      phy: phy-brcm-usb: fixup BCM4908 support
      nvmem: brcm_nvram: parse NVRAM content into NVMEM cells
      dt-bindings: nvmem: make "reg" property optional
      dt-bindings: nvmem: brcm,nvram: add basic NVMEM cells

Rajaravi Krishna Katta (1):
      habanalabs: sysfs support for fw os version

Randy Dunlap (2):
      virtio_console: eliminate anonymous module_init & module_exit
      kgdbts: fix return value of __setup handler

Richard Gong (1):
      firmware: stratix10-svc: extend SVC driver to get the firmware version

Ricky WU (1):
      misc: rtsx: rts522a rts5228 rts5261 support Runtime PM

Rob Herring (2):
      dt-bindings: iio/adc: ti,palmas-gpadc: Split interrupt fields in example
      dt-bindings: iio/adc: qcom,spmi-iadc: Fix 'reg' property in example

Robert Hancock (5):
      pps: clients: gpio: Propagate return value from pps_gpio_probe
      dt-bindings: iio: adc: zynqmp_ams: Add clock entry
      iio: adc: xilinx-ams: Fixed missing PS channels
      iio: adc: xilinx-ams: Fixed wrong sequencer register settings
      iio: adc: xilinx-ams: Fix single channel switching sequence

Robert Marko (6):
      mfd: simple-mfd-i2c: Add Delta TN48M CPLD support
      gpio: Add Delta TN48M CPLD GPIO driver
      dt-bindings: reset: Add Delta TN48M
      reset: Add Delta TN48M CPLD reset controller
      dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
      MAINTAINERS: Add Delta Networks TN48M CPLD drivers

Ronak Jain (3):
      firmware: xilinx: Add support for runtime features
      firmware: zynqmp: Add documentation for runtime feature config
      firmware: xilinx: Add sysfs support for feature config

Samuel Holland (8):
      dt-bindings: vendor-prefixes: Add silan vendor prefix
      dt-bindings: iio: st: Add Silan SC7A20 accelerometer
      iio: accel: st_accel: Add support for Silan SC7A20
      dt-bindings: nvmem: SID: Add compatible for D1
      nvmem: sunxi_sid: Add support for D1 variant
      dt-bindings: phy: Add compatible for D1 USB PHY
      phy: sun4i-usb: Remove .disc_thresh where not applicable
      phy: sun4i-usb: Add D1 variant

Samuel Thibault (2):
      speakup: Allow lower values for the flush parameter
      speakup_audptr: cleanup synth_version

Sankeerth Billakanti (3):
      dt-bindings: phy: Add eDP PHY compatible for sc7280
      phy: qcom: Add support for eDP PHY on sc7280
      phy: qcom: Program SSC only if supported by sink

Sean Anderson (2):
      doc: nvmem: Remove references to regmap
      doc: nvmem: Update example

Sebastian Andrzej Siewior (1):
      virt: acrn: Remove unsued acrn_irqfds_mutex.

Srinivas Kandagatla (7):
      nvmem: qfprom: fix kerneldoc warning
      soundwire: qcom: add runtime pm support
      dt-bindings: soundwire: qcom: document optional wake irq
      soundwire: qcom: add in-band wake up interrupt support
      soundwire: qcom: use __maybe_unused for swrm_runtime_resume()
      misc: fastrpc: separate fastrpc device from channel context
      misc: fastrpc: add secure domain support

Srinivasa Rao Mandadapu (1):
      soundwire: qcom: constify static struct qcom_swrm_data global variables

Stephan Gerhold (1):
      phy: ti: tusb1210: Add charger detection

Sudeep Holla (1):
      coresight: trbe: Move check for kernel page table isolation from EL0 to probe

Tom Rix (3):
      xilinx_hwicap: cleanup comments
      misc: rtsx: conditionally build rtsx_pm_power_saving()
      counter: add defaults to switch-statements

Tomer Tayar (10):
      habanalabs: check the return value of hl_cs_poll_fences()
      habanalabs: avoid copying pll data if pll_info_get fails
      habanalabs: add missing error check in sysfs clk_freq_mhz_show
      habanalabs: add missing error check in sysfs max_power_show
      habanalabs: prevent false heartbeat failure during soft-reset
      habanalabs: enable stop-on-error debugfs setting per ASIC
      habanalabs: use proper max_power variable for device utilization
      habanalabs: set max power on device init per ASIC
      habanalabs: avoid using an uninitialized variable
      habanalabs: add an option to delay a device reset

Ulf Hansson (1):
      mmc: rtsx: Fix build errors/warnings for unused variable

Vamsi Krishna Gattupalli (5):
      dt-bindings: misc: add fastrpc domain vmid property
      misc: fastrpc: Add support to secure memory map
      misc: fastrpc: Add helper function to get list and page
      misc: fastrpc: Add fdlist implementation
      misc: fastrpc: Add dma handle implementation

Vincent Shih (3):
      nvmem: Add driver for OCOTP in Sunplus SP7021
      dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver
      nvmem: dt-bindings: Fix the error of dt-bindings check

Vinod Koul (2):
      Merge tag 'phy-fixes-5.17' into next
      dt-bindings: Revert "dt-bindings: soc: grf: add naneng combo phy register compatible"

Vishnu Dasa (2):
      VMCI: Check exclusive_vectors when freeing interrupt 1
      VMCI: Release notification_bitmap in error path

William Breathitt Gray (3):
      counter: 104-quad-8: Add COMPILE_TEST depends
      counter: Set counter device name
      MAINTAINERS: Add Counter subsystem git tree

Xiaoke Wang (1):
      nvmem: meson-mx-efuse: replace unnecessary devm_kstrdup()

Xiaolong Huang (1):
      virt: acrn: fix a memory leak in acrn_dev_ioctl()

Yang Li (2):
      mux: Fix struct mux_state kernel-doc comment
      misc: rtsx: clean up one inconsistent indenting

Yifeng Zhao (2):
      dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
      phy: rockchip: add naneng combo phy for RK3568

Yonghua Huang (1):
      virt: acrn: obtain pa from VMA with PFNMAP flag

Yonglin Tan (1):
      bus: mhi: pci_generic: Add mru_default for Quectel EM1xx series

farah kassabri (2):
      habanalabs: Timestamps buffers registration
      habanalabs: Fix reset upon device release bug

 .mailmap                                           |    1 +
 .../ABI/stable/sysfs-driver-firmware-zynqmp        |  141 ++
 .../ABI/testing/debugfs-driver-habanalabs          |   20 +-
 Documentation/ABI/testing/sysfs-bus-iio            |   31 +
 .../ABI/testing/sysfs-bus-iio-adc-ad7280a          |   13 +
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688          |   86 ++
 .../ABI/testing/sysfs-bus-iio-frequency-admv1014   |   23 +
 Documentation/ABI/testing/sysfs-bus-iio-sx9324     |   28 +
 Documentation/ABI/testing/sysfs-bus-peci           |   16 +
 Documentation/ABI/testing/sysfs-driver-habanalabs  |   16 +-
 .../devicetree/bindings/gpio/delta,tn48m-gpio.yaml |   39 +
 .../devicetree/bindings/iio/accel/adi,adxl367.yaml |   79 +
 .../devicetree/bindings/iio/adc/adi,ad7280a.yaml   |   77 +
 .../bindings/iio/adc/atmel,sama5d2-adc.yaml        |    2 -
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |    1 +
 .../bindings/iio/adc/microchip,mcp3201.yaml        |    2 +-
 .../bindings/iio/adc/qcom,spmi-iadc.yaml           |    2 +-
 .../bindings/iio/adc/ti,palmas-gpadc.yaml          |    6 +-
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |    8 +
 .../bindings/iio/afe/temperature-sense-rtd.yaml    |  101 ++
 .../bindings/iio/afe/temperature-transducer.yaml   |  114 ++
 .../bindings/iio/amplifiers/adi,ada4250.yaml       |   50 +
 .../devicetree/bindings/iio/dac/adi,ltc2688.yaml   |  146 ++
 .../bindings/iio/frequency/adi,admv1014.yaml       |  134 ++
 .../bindings/iio/frequency/adi,admv4420.yaml       |   55 +
 .../bindings/iio/proximity/semtech,sx9324.yaml     |  161 ++
 .../bindings/iio/proximity/semtech,sx9360.yaml     |   89 ++
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    3 +
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |   33 +-
 .../devicetree/bindings/mfd/delta,tn48m-cpld.yaml  |   90 ++
 .../devicetree/bindings/misc/qcom,fastrpc.txt      |   10 +
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |    1 +
 .../devicetree/bindings/nvmem/brcm,nvram.yaml      |   25 +-
 .../bindings/nvmem/fsl,layerscape-sfp.yaml         |   38 +
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |    3 -
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       |   84 ++
 .../devicetree/bindings/peci/peci-aspeed.yaml      |   72 +
 .../devicetree/bindings/peci/peci-controller.yaml  |   33 +
 .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml |    4 +-
 .../devicetree/bindings/phy/cdns,dphy-rx.yaml      |   42 +
 .../devicetree/bindings/phy/cdns,dphy.txt          |   20 -
 .../devicetree/bindings/phy/cdns,dphy.yaml         |   56 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |    2 +
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml  |  109 ++
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |    4 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    3 +
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |    1 +
 .../devicetree/bindings/phy/qcom,usb-hs-phy.txt    |   84 --
 .../devicetree/bindings/phy/qcom,usb-hs-phy.yaml   |  108 ++
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |    3 +
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |    3 +-
 .../bindings/phy/samsung,dp-video-phy.yaml         |   41 +
 .../bindings/phy/samsung,exynos5250-sata-phy.yaml  |   64 +
 .../bindings/phy/samsung,mipi-video-phy.yaml       |  113 ++
 .../devicetree/bindings/phy/samsung,usb2-phy.yaml  |  102 ++
 .../bindings/phy/samsung,usb3-drd-phy.yaml         |  126 ++
 .../devicetree/bindings/phy/samsung-phy.txt        |  210 ---
 .../bindings/reserved-memory/google,open-dice.yaml |   46 +
 .../bindings/reset/delta,tn48m-reset.yaml          |   35 +
 .../devicetree/bindings/soundwire/qcom,sdw.txt     |   14 +-
 .../devicetree/bindings/trivial-devices.yaml       |    4 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/driver-api/driver-model/devres.rst   |    1 +
 Documentation/driver-api/nvmem.rst                 |   28 +-
 Documentation/hwmon/index.rst                      |    2 +
 Documentation/hwmon/peci-cputemp.rst               |   90 ++
 Documentation/hwmon/peci-dimmtemp.rst              |   57 +
 Documentation/index.rst                            |    1 +
 Documentation/peci/index.rst                       |   16 +
 Documentation/peci/peci.rst                        |   51 +
 MAINTAINERS                                        |  171 ++-
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   11 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   11 +
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   11 +
 arch/arm64/Kconfig                                 |    6 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |    1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |    2 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |    3 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |    3 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |    3 +
 arch/arm64/include/asm/Kbuild                      |    1 +
 arch/csky/include/asm/Kbuild                       |    1 +
 arch/riscv/include/asm/Kbuild                      |    1 +
 arch/um/include/asm/Kbuild                         |    1 +
 arch/xtensa/include/asm/Kbuild                     |    1 +
 drivers/Kconfig                                    |    3 +
 drivers/Makefile                                   |    1 +
 drivers/accessibility/speakup/speakup_audptr.c     |   24 +-
 drivers/accessibility/speakup/synth.c              |    2 +-
 drivers/android/binder_alloc.c                     |    8 +-
 drivers/ata/ahci.h                                 |    2 -
 drivers/ata/ahci_mvebu.c                           |    2 +-
 drivers/ata/libahci_platform.c                     |    2 +-
 drivers/bus/Makefile                               |    2 +-
 drivers/bus/mhi/Kconfig                            |   27 +-
 drivers/bus/mhi/Makefile                           |    8 +-
 drivers/bus/mhi/common.h                           |  304 ++++
 drivers/bus/mhi/core/internal.h                    |  722 ---------
 drivers/bus/mhi/host/Kconfig                       |   31 +
 drivers/bus/mhi/{core => host}/Makefile            |    4 +-
 drivers/bus/mhi/{core => host}/boot.c              |   17 +-
 drivers/bus/mhi/{core => host}/debugfs.c           |   40 +-
 drivers/bus/mhi/{core => host}/init.c              |  131 +-
 drivers/bus/mhi/host/internal.h                    |  382 +++++
 drivers/bus/mhi/{core => host}/main.c              |   66 +-
 drivers/bus/mhi/{ => host}/pci_generic.c           |    1 +
 drivers/bus/mhi/{core => host}/pm.c                |   36 +-
 drivers/char/bsr.c                                 |    2 +-
 drivers/char/hpet.c                                |   28 +-
 drivers/char/virtio_console.c                      |    8 +-
 drivers/char/xilinx_hwicap/fifo_icap.c             |    2 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c         |    6 +-
 drivers/comedi/drivers/das16.c                     |    4 +-
 drivers/comedi/drivers/ni_routes.c                 |    6 +-
 drivers/comedi/drivers/pcm3724.c                   |    1 -
 drivers/counter/Kconfig                            |    2 +-
 drivers/counter/counter-chrdev.c                   |    4 +
 drivers/counter/counter-core.c                     |   12 +-
 drivers/counter/interrupt-cnt.c                    |    7 +-
 drivers/dio/dio.c                                  |  140 +-
 drivers/firmware/google/Kconfig                    |    2 +-
 drivers/firmware/stratix10-svc.c                   |   11 +-
 drivers/firmware/sysfb_simplefb.c                  |   23 +-
 drivers/firmware/xilinx/zynqmp.c                   |  120 ++
 drivers/fpga/dfl-pci.c                             |   15 +-
 drivers/fsi/fsi-core.c                             |   11 +-
 drivers/fsi/fsi-master-aspeed.c                    |   19 +-
 drivers/fsi/fsi-occ.c                              |   87 +-
 drivers/fsi/fsi-sbefifo.c                          |   53 +-
 drivers/fsi/fsi-scom.c                             |   45 +-
 drivers/gpio/Kconfig                               |   12 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-tn48m.c                          |  100 ++
 drivers/greybus/svc.c                              |   16 +-
 drivers/hwmon/Kconfig                              |    2 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/peci/Kconfig                         |   31 +
 drivers/hwmon/peci/Makefile                        |    7 +
 drivers/hwmon/peci/common.h                        |   58 +
 drivers/hwmon/peci/cputemp.c                       |  592 ++++++++
 drivers/hwmon/peci/dimmtemp.c                      |  630 ++++++++
 drivers/hwtracing/coresight/coresight-core.c       |    3 -
 drivers/hwtracing/coresight/coresight-etm3x-core.c |    4 +
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   12 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   38 +-
 drivers/hwtracing/coresight/coresight-platform.c   |    8 +-
 drivers/hwtracing/coresight/coresight-syscfg.c     |    2 +-
 drivers/hwtracing/coresight/coresight-trbe.c       |  125 +-
 drivers/hwtracing/coresight/coresight-trbe.h       |    8 -
 drivers/iio/accel/Kconfig                          |   62 +-
 drivers/iio/accel/Makefile                         |    3 +
 drivers/iio/accel/adis16201.c                      |    1 +
 drivers/iio/accel/adis16209.c                      |    1 +
 drivers/iio/accel/adxl313_core.c                   |    6 +-
 drivers/iio/accel/adxl313_i2c.c                    |    1 +
 drivers/iio/accel/adxl313_spi.c                    |    1 +
 drivers/iio/accel/adxl345.h                        |    7 +-
 drivers/iio/accel/adxl345_core.c                   |   56 +-
 drivers/iio/accel/adxl345_i2c.c                    |   35 +-
 drivers/iio/accel/adxl345_spi.c                    |   35 +-
 drivers/iio/accel/adxl355_core.c                   |   11 +-
 drivers/iio/accel/adxl355_i2c.c                    |    1 +
 drivers/iio/accel/adxl355_spi.c                    |    1 +
 drivers/iio/accel/adxl367.c                        | 1588 ++++++++++++++++++++
 drivers/iio/accel/adxl367.h                        |   23 +
 drivers/iio/accel/adxl367_i2c.c                    |   90 ++
 drivers/iio/accel/adxl367_spi.c                    |  164 ++
 drivers/iio/accel/adxl372.c                        |    4 +-
 drivers/iio/accel/adxl372_i2c.c                    |    1 +
 drivers/iio/accel/adxl372_spi.c                    |    1 +
 drivers/iio/accel/bma180.c                         |    9 +-
 drivers/iio/accel/bma400_core.c                    |    6 +-
 drivers/iio/accel/bma400_i2c.c                     |    1 +
 drivers/iio/accel/bma400_spi.c                     |    1 +
 drivers/iio/accel/bmc150-accel-core.c              |    8 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |    1 +
 drivers/iio/accel/bmc150-accel-spi.c               |    1 +
 drivers/iio/accel/bmi088-accel-core.c              |    8 +-
 drivers/iio/accel/bmi088-accel-spi.c               |    1 +
 drivers/iio/accel/da280.c                          |    6 +-
 drivers/iio/accel/da311.c                          |    6 +-
 drivers/iio/accel/dmard06.c                        |   10 +-
 drivers/iio/accel/dmard09.c                        |    2 +-
 drivers/iio/accel/dmard10.c                        |    7 +-
 drivers/iio/accel/fxls8962af-core.c                |    8 +-
 drivers/iio/accel/fxls8962af-i2c.c                 |    1 +
 drivers/iio/accel/fxls8962af-spi.c                 |    1 +
 drivers/iio/accel/kxsd9-i2c.c                      |    1 +
 drivers/iio/accel/kxsd9-spi.c                      |    1 +
 drivers/iio/accel/kxsd9.c                          |    6 +-
 drivers/iio/accel/mc3230.c                         |    6 +-
 drivers/iio/accel/mma7455_core.c                   |    6 +-
 drivers/iio/accel/mma7455_i2c.c                    |    1 +
 drivers/iio/accel/mma7455_spi.c                    |    1 +
 drivers/iio/accel/mma7660.c                        |   11 +-
 drivers/iio/accel/mma8452.c                        |   54 +-
 drivers/iio/accel/mma9551.c                        |   12 +-
 drivers/iio/accel/mma9551_core.c                   |   36 +-
 drivers/iio/accel/mma9553.c                        |   12 +-
 drivers/iio/accel/ssp_accel_sensor.c               |    1 +
 drivers/iio/accel/st_accel.h                       |    2 +
 drivers/iio/accel/st_accel_buffer.c                |    5 -
 drivers/iio/accel/st_accel_core.c                  |   88 +-
 drivers/iio/accel/st_accel_i2c.c                   |    6 +
 drivers/iio/accel/st_accel_spi.c                   |    1 +
 drivers/iio/accel/stk8312.c                        |   11 +-
 drivers/iio/accel/stk8ba50.c                       |   11 +-
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ab8500-gpadc.c                     |   14 +-
 drivers/iio/adc/ad7091r-base.c                     |    4 +-
 drivers/iio/adc/ad7091r5.c                         |    1 +
 drivers/iio/adc/ad7124.c                           |    1 +
 drivers/iio/adc/ad7192.c                           |    5 +-
 drivers/iio/adc/ad7280a.c                          | 1111 ++++++++++++++
 drivers/iio/adc/ad7606.c                           |    4 +-
 drivers/iio/adc/ad7606_par.c                       |    1 +
 drivers/iio/adc/ad7606_spi.c                       |    1 +
 drivers/iio/adc/ad7780.c                           |    1 +
 drivers/iio/adc/ad7791.c                           |    1 +
 drivers/iio/adc/ad7793.c                           |    1 +
 drivers/iio/adc/ad_sigma_delta.c                   |   20 +-
 drivers/iio/adc/aspeed_adc.c                       |    4 +-
 drivers/iio/adc/at91_adc.c                         |    7 +-
 drivers/iio/adc/cpcap-adc.c                        |    2 +-
 drivers/iio/adc/exynos_adc.c                       |    9 +-
 drivers/iio/adc/hi8435.c                           |    2 +-
 drivers/iio/adc/ina2xx-adc.c                       |    2 +-
 drivers/iio/adc/max9611.c                          |    2 +-
 drivers/iio/adc/mt6577_auxadc.c                    |   16 +-
 drivers/iio/adc/palmas_gpadc.c                     |   10 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   15 +-
 drivers/iio/adc/qcom-spmi-vadc.c                   |   24 +-
 drivers/iio/adc/qcom-vadc-common.c                 |   92 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    6 +-
 drivers/iio/adc/rn5t618-adc.c                      |    7 +-
 drivers/iio/adc/rockchip_saradc.c                  |    9 +-
 drivers/iio/adc/rzg2l_adc.c                        |    4 +-
 drivers/iio/adc/stm32-adc-core.c                   |   17 +-
 drivers/iio/adc/stm32-adc.c                        |   12 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   11 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |   19 +-
 drivers/iio/adc/ti-adc084s021.c                    |    2 +-
 drivers/iio/adc/ti-tsc2046.c                       |  269 +++-
 drivers/iio/adc/twl4030-madc.c                     |    9 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   10 +-
 drivers/iio/adc/vf610_adc.c                        |    7 +-
 drivers/iio/adc/xilinx-ams.c                       |   26 +-
 drivers/iio/afe/iio-rescale.c                      |  288 +++-
 drivers/iio/amplifiers/Kconfig                     |   11 +
 drivers/iio/amplifiers/Makefile                    |    1 +
 drivers/iio/amplifiers/ada4250.c                   |  403 +++++
 drivers/iio/amplifiers/hmc425a.c                   |    6 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    2 +-
 drivers/iio/buffer/industrialio-hw-consumer.c      |    4 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |   32 +-
 drivers/iio/chemical/atlas-sensor.c                |   17 +-
 drivers/iio/chemical/bme680_core.c                 |    4 +-
 drivers/iio/chemical/bme680_i2c.c                  |    1 +
 drivers/iio/chemical/bme680_spi.c                  |    3 +-
 drivers/iio/chemical/scd4x.c                       |    2 +-
 drivers/iio/chemical/sps30.c                       |    2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   28 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c           |   40 +-
 drivers/iio/common/ssp_sensors/ssp_iio.c           |    7 +-
 drivers/iio/common/st_sensors/Kconfig              |    2 -
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |    7 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   28 +-
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |    2 +-
 drivers/iio/common/st_sensors/st_sensors_spi.c     |    2 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |    9 +-
 drivers/iio/dac/Kconfig                            |   11 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5592r-base.c                     |    5 +-
 drivers/iio/dac/ad5592r.c                          |    1 +
 drivers/iio/dac/ad5593r.c                          |    1 +
 drivers/iio/dac/ad5686-spi.c                       |    1 +
 drivers/iio/dac/ad5686.c                           |    4 +-
 drivers/iio/dac/ad5696-i2c.c                       |    1 +
 drivers/iio/dac/ltc2688.c                          | 1071 +++++++++++++
 drivers/iio/dac/m62332.c                           |   11 +-
 drivers/iio/dac/stm32-dac-core.c                   |   16 +-
 drivers/iio/dac/stm32-dac.c                        |    9 +-
 drivers/iio/dac/vf610_dac.c                        |    7 +-
 drivers/iio/frequency/Kconfig                      |   20 +
 drivers/iio/frequency/Makefile                     |    2 +
 drivers/iio/frequency/ad9523.c                     |    2 +-
 drivers/iio/frequency/adf4350.c                    |  103 +-
 drivers/iio/frequency/admv1013.c                   |    2 +-
 drivers/iio/frequency/admv1014.c                   |  823 ++++++++++
 drivers/iio/frequency/admv4420.c                   |  398 +++++
 drivers/iio/gyro/Kconfig                           |   37 +-
 drivers/iio/gyro/adis16136.c                       |    1 +
 drivers/iio/gyro/adis16260.c                       |    1 +
 drivers/iio/gyro/ssp_gyro_sensor.c                 |    1 +
 drivers/iio/gyro/st_gyro_buffer.c                  |    4 -
 drivers/iio/gyro/st_gyro_core.c                    |    5 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |    1 +
 drivers/iio/gyro/st_gyro_spi.c                     |    1 +
 drivers/iio/humidity/dht11.c                       |    3 +-
 drivers/iio/humidity/hdc100x.c                     |    7 +
 drivers/iio/humidity/htu21.c                       |    1 +
 drivers/iio/imu/adis.c                             |   67 +-
 drivers/iio/imu/adis16400.c                        |    1 +
 drivers/iio/imu/adis16460.c                        |    1 +
 drivers/iio/imu/adis16475.c                        |    1 +
 drivers/iio/imu/adis16480.c                        |    1 +
 drivers/iio/imu/adis_buffer.c                      |   10 +-
 drivers/iio/imu/adis_trigger.c                     |    5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |    5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   15 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    5 +-
 drivers/iio/imu/kmx61.c                            |   10 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    4 +-
 drivers/iio/imu/st_lsm9ds0/Kconfig                 |   28 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |    3 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |    1 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |    1 +
 drivers/iio/industrialio-buffer.c                  |    4 +-
 drivers/iio/industrialio-core.c                    |    2 +-
 drivers/iio/industrialio-event.c                   |    1 +
 drivers/iio/inkern.c                               |   40 +-
 drivers/iio/light/apds9300.c                       |   10 +-
 drivers/iio/light/bh1780.c                         |   12 +-
 drivers/iio/light/cm3232.c                         |    9 +-
 drivers/iio/light/isl29018.c                       |   10 +-
 drivers/iio/light/isl29125.c                       |    7 +-
 drivers/iio/light/jsa1212.c                        |   11 +-
 drivers/iio/light/lm3533-als.c                     |    6 +-
 drivers/iio/light/ltr501.c                         |   20 +-
 drivers/iio/light/pa12203001.c                     |    4 +-
 drivers/iio/light/rpr0521.c                        |    7 +-
 drivers/iio/light/st_uvis25_core.c                 |    4 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    1 +
 drivers/iio/light/st_uvis25_spi.c                  |    1 +
 drivers/iio/light/stk3310.c                        |   11 +-
 drivers/iio/light/tcs3414.c                        |    7 +-
 drivers/iio/light/tcs3472.c                        |    7 +-
 drivers/iio/light/tsl2563.c                        |   10 +-
 drivers/iio/light/tsl2772.c                        |    2 +-
 drivers/iio/light/tsl4531.c                        |   10 +-
 drivers/iio/light/us5182d.c                        |    6 +-
 drivers/iio/light/vcnl4035.c                       |    2 +-
 drivers/iio/magnetometer/Kconfig                   |   35 +-
 drivers/iio/magnetometer/ak8975.c                  |   12 +-
 drivers/iio/magnetometer/bmc150_magn.c             |    8 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    1 +
 drivers/iio/magnetometer/bmc150_magn_spi.c         |    1 +
 drivers/iio/magnetometer/hmc5843_core.c            |    8 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    1 +
 drivers/iio/magnetometer/hmc5843_spi.c             |    1 +
 drivers/iio/magnetometer/mag3110.c                 |   10 +-
 drivers/iio/magnetometer/mmc35240.c                |    9 +-
 drivers/iio/magnetometer/rm3100-core.c             |    8 +-
 drivers/iio/magnetometer/rm3100-i2c.c              |    1 +
 drivers/iio/magnetometer/rm3100-spi.c              |    1 +
 drivers/iio/magnetometer/st_magn_buffer.c          |    4 -
 drivers/iio/magnetometer/st_magn_core.c            |    5 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |    1 +
 drivers/iio/magnetometer/st_magn_spi.c             |    1 +
 drivers/iio/potentiometer/Kconfig                  |    6 +-
 drivers/iio/potentiometer/ds1803.c                 |  169 ++-
 drivers/iio/pressure/Kconfig                       |   35 +-
 drivers/iio/pressure/dps310.c                      |    7 +
 drivers/iio/pressure/mpl115.c                      |    2 +-
 drivers/iio/pressure/mpl115_i2c.c                  |    1 +
 drivers/iio/pressure/mpl115_spi.c                  |    1 +
 drivers/iio/pressure/mpl3115.c                     |   10 +-
 drivers/iio/pressure/ms5611_core.c                 |    4 +-
 drivers/iio/pressure/ms5611_i2c.c                  |    1 +
 drivers/iio/pressure/ms5611_spi.c                  |    1 +
 drivers/iio/pressure/ms5637.c                      |    1 +
 drivers/iio/pressure/st_pressure_buffer.c          |    5 -
 drivers/iio/pressure/st_pressure_core.c            |    5 +-
 drivers/iio/pressure/st_pressure_i2c.c             |    1 +
 drivers/iio/pressure/st_pressure_spi.c             |    1 +
 drivers/iio/pressure/zpa2326.c                     |   12 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |    1 +
 drivers/iio/pressure/zpa2326_spi.c                 |    1 +
 drivers/iio/proximity/Kconfig                      |   34 +
 drivers/iio/proximity/Makefile                     |    3 +
 drivers/iio/proximity/as3935.c                     |   26 +-
 drivers/iio/proximity/ping.c                       |    4 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    7 +-
 drivers/iio/proximity/rfd77402.c                   |    9 +-
 drivers/iio/proximity/srf04.c                      |   12 +-
 drivers/iio/proximity/srf08.c                      |    6 +-
 drivers/iio/proximity/sx9310.c                     |  741 ++-------
 drivers/iio/proximity/sx9324.c                     | 1068 +++++++++++++
 drivers/iio/proximity/sx9360.c                     |  893 +++++++++++
 drivers/iio/proximity/sx9500.c                     |    8 +-
 drivers/iio/proximity/sx_common.c                  |  572 +++++++
 drivers/iio/proximity/sx_common.h                  |  157 ++
 drivers/iio/proximity/vl53l0x-i2c.c                |    2 +-
 drivers/iio/temperature/max31856.c                 |    4 +-
 drivers/iio/temperature/max31865.c                 |    4 +-
 drivers/iio/temperature/maxim_thermocouple.c       |    5 +-
 drivers/iio/temperature/mlx90614.c                 |   12 +-
 drivers/iio/temperature/mlx90632.c                 |    2 +-
 drivers/iio/temperature/tmp006.c                   |    6 +-
 drivers/iio/temperature/tmp007.c                   |    6 +-
 drivers/iio/temperature/tsys01.c                   |    1 +
 drivers/iio/temperature/tsys02d.c                  |    1 +
 drivers/iio/test/Kconfig                           |   10 +
 drivers/iio/test/Makefile                          |    1 +
 drivers/iio/test/iio-test-rescale.c                |  710 +++++++++
 drivers/iio/trigger/Kconfig                        |    2 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |   23 +-
 drivers/interconnect/imx/imx.c                     |    9 +
 drivers/interconnect/qcom/msm8939.c                |   10 +-
 drivers/misc/Kconfig                               |   13 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/bcm-vk/bcm_vk_dev.c                   |    1 -
 drivers/misc/cardreader/alcor_pci.c                |    9 +-
 drivers/misc/cardreader/rtl8411.c                  |    2 +-
 drivers/misc/cardreader/rts5209.c                  |    2 +-
 drivers/misc/cardreader/rts5227.c                  |   47 +
 drivers/misc/cardreader/rts5228.c                  |   25 +-
 drivers/misc/cardreader/rts5229.c                  |    2 +-
 drivers/misc/cardreader/rts5249.c                  |   31 +-
 drivers/misc/cardreader/rts5261.c                  |   35 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |  228 ++-
 drivers/misc/cardreader/rtsx_pcr.h                 |    3 +
 drivers/misc/eeprom/at25.c                         |    4 +-
 drivers/misc/fastrpc.c                             |  556 ++++++-
 drivers/misc/habanalabs/common/Makefile            |    2 +-
 drivers/misc/habanalabs/common/command_buffer.c    |    4 +-
 .../misc/habanalabs/common/command_submission.c    |  265 +++-
 drivers/misc/habanalabs/common/debugfs.c           |   40 +-
 drivers/misc/habanalabs/common/device.c            |   53 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  152 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  209 ++-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |    3 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   13 +-
 drivers/misc/habanalabs/common/hwmgr.c             |  117 --
 drivers/misc/habanalabs/common/irq.c               |  127 +-
 drivers/misc/habanalabs/common/memory.c            |  360 ++++-
 drivers/misc/habanalabs/common/mmu/mmu.c           |   55 +
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |   47 +-
 drivers/misc/habanalabs/common/pci/pci.c           |    9 +-
 drivers/misc/habanalabs/common/sysfs.c             |  176 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  462 ++----
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    8 +-
 drivers/misc/habanalabs/goya/goya.c                |   45 +-
 drivers/misc/habanalabs/goya/goyaP.h               |    6 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |   67 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |    2 +
 .../misc/habanalabs/include/common/hl_boot_if.h    |    5 +
 .../habanalabs/include/gaudi/gaudi_async_events.h  |   10 +
 drivers/misc/kgdbts.c                              |    4 +-
 drivers/misc/lkdtm/fortify.c                       |    6 +-
 drivers/misc/mei/client.c                          |    1 +
 drivers/misc/mei/hw-me-regs.h                      |    2 +
 drivers/misc/mei/hw-me.c                           |   43 +-
 drivers/misc/mei/init.c                            |    5 +
 drivers/misc/mei/interrupt.c                       |   35 +-
 drivers/misc/mei/pci-me.c                          |   11 +-
 drivers/misc/ocxl/link.c                           |    2 +-
 drivers/misc/open-dice.c                           |  208 +++
 drivers/misc/sgi-gru/grukservices.c                |    2 +-
 drivers/misc/sgi-gru/grutables.h                   |    6 -
 drivers/misc/vmw_vmci/vmci_guest.c                 |  366 ++++-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   20 +-
 drivers/mtd/mtdcore.c                              |   13 +-
 drivers/mux/core.c                                 |  239 ++-
 drivers/nvmem/Kconfig                              |   24 +
 drivers/nvmem/Makefile                             |    4 +
 drivers/nvmem/brcm_nvram.c                         |   90 ++
 drivers/nvmem/core.c                               |   47 +-
 drivers/nvmem/layerscape-sfp.c                     |   89 ++
 drivers/nvmem/meson-mx-efuse.c                     |    3 +-
 drivers/nvmem/qfprom.c                             |    4 +-
 drivers/nvmem/sunplus-ocotp.c                      |  228 +++
 drivers/nvmem/sunxi_sid.c                          |    6 +
 drivers/of/platform.c                              |    1 +
 drivers/parport/Kconfig                            |    4 +-
 drivers/pci/controller/pci-aardvark.c              |    4 +-
 drivers/peci/Kconfig                               |   36 +
 drivers/peci/Makefile                              |   10 +
 drivers/peci/controller/Kconfig                    |   18 +
 drivers/peci/controller/Makefile                   |    3 +
 drivers/peci/controller/peci-aspeed.c              |  599 ++++++++
 drivers/peci/core.c                                |  236 +++
 drivers/peci/cpu.c                                 |  343 +++++
 drivers/peci/device.c                              |  252 ++++
 drivers/peci/internal.h                            |  136 ++
 drivers/peci/request.c                             |  482 ++++++
 drivers/peci/sysfs.c                               |   82 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |   41 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           |    5 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c             |    9 +-
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c  |   46 +-
 drivers/phy/broadcom/phy-brcm-usb-init.c           |   36 +
 drivers/phy/broadcom/phy-brcm-usb-init.h           |    1 +
 drivers/phy/broadcom/phy-brcm-usb.c                |   11 +-
 drivers/phy/cadence/Kconfig                        |    8 +
 drivers/phy/cadence/Makefile                       |    1 +
 drivers/phy/cadence/cdns-dphy-rx.c                 |  255 ++++
 drivers/phy/cadence/phy-cadence-salvo.c            |    7 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |   82 +-
 drivers/phy/freescale/Kconfig                      |    5 +
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |    3 +-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c       | 1350 +++++++++++++++--
 drivers/phy/phy-core-mipi-dphy.c                   |    4 +-
 drivers/phy/qualcomm/phy-qcom-edp.c                |    9 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        |   28 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |    3 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |    3 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |    5 +
 drivers/phy/rockchip/Kconfig                       |    8 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |  581 +++++++
 drivers/phy/ti/phy-tusb1210.c                      |  443 +++++-
 drivers/platform/goldfish/goldfish_pipe.c          |    8 +-
 drivers/pps/clients/pps-gpio.c                     |    2 +-
 drivers/pps/generators/pps_gen_parport.c           |   42 +-
 drivers/reset/Kconfig                              |   13 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/reset-tn48m.c                        |  128 ++
 drivers/soundwire/bus.c                            |    8 +-
 drivers/soundwire/intel.c                          |    4 +-
 drivers/soundwire/intel_init.c                     |    7 +-
 drivers/soundwire/qcom.c                           |  208 ++-
 drivers/soundwire/stream.c                         |  952 +++++++-----
 drivers/staging/iio/accel/adis16203.c              |    1 +
 drivers/staging/iio/accel/adis16240.c              |    1 +
 drivers/staging/iio/adc/Kconfig                    |   11 -
 drivers/staging/iio/adc/Makefile                   |    1 -
 drivers/staging/iio/adc/ad7280a.c                  | 1044 -------------
 drivers/staging/iio/adc/ad7280a.h                  |   37 -
 drivers/thunderbolt/nvm.c                          |    6 +-
 drivers/usb/host/xhci-mvebu.c                      |   42 -
 drivers/usb/host/xhci-mvebu.h                      |    6 -
 drivers/usb/host/xhci-plat.c                       |   20 +-
 drivers/usb/host/xhci-plat.h                       |    1 -
 drivers/virt/acrn/hsm.c                            |   20 +-
 drivers/virt/acrn/irqfd.c                          |    1 -
 drivers/virt/acrn/mm.c                             |   24 +
 drivers/virt/fsl_hypervisor.c                      |    4 +-
 drivers/w1/masters/ds2490.c                        |    8 +-
 drivers/w1/slaves/w1_therm.c                       |   78 +-
 include/dt-bindings/reset/delta,tn48m-reset.h      |   20 +
 include/linux/coresight.h                          |    5 -
 include/linux/firmware/intel/stratix10-smc.h       |   21 +-
 .../linux/firmware/intel/stratix10-svc-client.h    |    4 +
 include/linux/firmware/xlnx-zynqmp.h               |   25 +
 include/linux/iio/adc/qcom-vadc-common.h           |   15 +-
 include/linux/iio/afe/rescale.h                    |   36 +
 include/linux/iio/iio.h                            |    2 +-
 include/linux/iio/imu/adis.h                       |   60 +-
 include/linux/interconnect.h                       |   36 +-
 include/linux/math.h                               |   12 +
 include/linux/mux/consumer.h                       |   18 +
 include/linux/nvmem-provider.h                     |    8 -
 include/linux/peci-cpu.h                           |   40 +
 include/linux/peci.h                               |  112 ++
 include/linux/rtsx_pci.h                           |    5 +-
 include/linux/vmw_vmci_defs.h                      |   84 +-
 include/trace/events/fsi.h                         |   86 ++
 include/trace/events/fsi_master_aspeed.h           |   12 +
 include/uapi/linux/counter.h                       |    2 +
 include/uapi/linux/fsi.h                           |   14 +
 include/uapi/linux/iio/types.h                     |    1 +
 include/uapi/misc/fastrpc.h                        |   81 +-
 include/uapi/misc/habanalabs.h                     |  146 +-
 kernel/configs/android-recommended.config          |    2 +-
 tools/iio/iio_event_monitor.c                      |    1 +
 tools/testing/selftests/lkdtm/config               |    2 +-
 568 files changed, 26988 insertions(+), 6664 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
 create mode 100644 Documentation/ABI/testing/sysfs-bus-peci
 create mode 100644 Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.yaml
 create mode 100644 Documentation/devicetree/bindings/peci/peci-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos5250-sata-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/samsung-phy.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml
 create mode 100644 Documentation/hwmon/peci-cputemp.rst
 create mode 100644 Documentation/hwmon/peci-dimmtemp.rst
 create mode 100644 Documentation/peci/index.rst
 create mode 100644 Documentation/peci/peci.rst
 create mode 100644 drivers/bus/mhi/common.h
 delete mode 100644 drivers/bus/mhi/core/internal.h
 create mode 100644 drivers/bus/mhi/host/Kconfig
 rename drivers/bus/mhi/{core => host}/Makefile (54%)
 rename drivers/bus/mhi/{core => host}/boot.c (96%)
 rename drivers/bus/mhi/{core => host}/debugfs.c (90%)
 rename drivers/bus/mhi/{core => host}/init.c (92%)
 create mode 100644 drivers/bus/mhi/host/internal.h
 rename drivers/bus/mhi/{core => host}/main.c (97%)
 rename drivers/bus/mhi/{ => host}/pci_generic.c (99%)
 rename drivers/bus/mhi/{core => host}/pm.c (97%)
 create mode 100644 drivers/gpio/gpio-tn48m.c
 create mode 100644 drivers/hwmon/peci/Kconfig
 create mode 100644 drivers/hwmon/peci/Makefile
 create mode 100644 drivers/hwmon/peci/common.h
 create mode 100644 drivers/hwmon/peci/cputemp.c
 create mode 100644 drivers/hwmon/peci/dimmtemp.c
 create mode 100644 drivers/iio/accel/adxl367.c
 create mode 100644 drivers/iio/accel/adxl367.h
 create mode 100644 drivers/iio/accel/adxl367_i2c.c
 create mode 100644 drivers/iio/accel/adxl367_spi.c
 create mode 100644 drivers/iio/adc/ad7280a.c
 create mode 100644 drivers/iio/amplifiers/ada4250.c
 create mode 100644 drivers/iio/dac/ltc2688.c
 create mode 100644 drivers/iio/frequency/admv1014.c
 create mode 100644 drivers/iio/frequency/admv4420.c
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx9360.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 delete mode 100644 drivers/misc/habanalabs/common/hwmgr.c
 create mode 100644 drivers/misc/open-dice.c
 create mode 100644 drivers/nvmem/layerscape-sfp.c
 create mode 100644 drivers/nvmem/sunplus-ocotp.c
 create mode 100644 drivers/peci/Kconfig
 create mode 100644 drivers/peci/Makefile
 create mode 100644 drivers/peci/controller/Kconfig
 create mode 100644 drivers/peci/controller/Makefile
 create mode 100644 drivers/peci/controller/peci-aspeed.c
 create mode 100644 drivers/peci/core.c
 create mode 100644 drivers/peci/cpu.c
 create mode 100644 drivers/peci/device.c
 create mode 100644 drivers/peci/internal.h
 create mode 100644 drivers/peci/request.c
 create mode 100644 drivers/peci/sysfs.c
 create mode 100644 drivers/phy/cadence/cdns-dphy-rx.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
 create mode 100644 drivers/reset/reset-tn48m.c
 delete mode 100644 drivers/staging/iio/adc/ad7280a.c
 delete mode 100644 drivers/staging/iio/adc/ad7280a.h
 create mode 100644 include/dt-bindings/reset/delta,tn48m-reset.h
 create mode 100644 include/linux/iio/afe/rescale.h
 create mode 100644 include/linux/peci-cpu.h
 create mode 100644 include/linux/peci.h
