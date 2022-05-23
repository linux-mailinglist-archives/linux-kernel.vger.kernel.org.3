Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B245316A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiEWTpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiEWTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:45:11 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FC4E77;
        Mon, 23 May 2022 12:44:43 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id t26so27267492ybt.3;
        Mon, 23 May 2022 12:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1UFvX39NtfpENeFeSqm15Ok9Y3UgF929dIZB7DaqiWs=;
        b=ZGM9hTCbNCNbSBX6DCgPqHl4On70SBxzJk2AtGUY7mxYnc4guZPOqQx1e2SyAB2sVt
         m7zJpPNpwrUYr/TJjB4+ow3CfvekHTJKXxI8uTHno/w4qGKlIQjTeimpXmSKQxFh7otY
         W2siGCVL2whjjjnbgxMpuyccA9lTSs3JiJ49H7F1vT5+U7gRlGrj6vBJXjSRAFVnVf0i
         2vREcoutWQtAJD9YmZ0P5ScHIrD7TYIGrjZIp3p8vU7l/S2fPpecip53UsjofysTIPCx
         +vQV2QQ7PIMOht/Y4UgZF4M6Ib1eIm3asjledULIy+JIjzt+JVB2p+xTAle0n1TM9HTX
         JfDQ==
X-Gm-Message-State: AOAM533+q2dOqnypAiAOYCjnWRbWwxf34YMUg5bNKfe026i3agzxWk4n
        q5depf9ZVYB5rHy9Yu4G9UeTf8+MpdXx7ghW9lkF3yqYcs0=
X-Google-Smtp-Source: ABdhPJw+r2WDnLRkeP7kU+jwLwLscbC6WPEeP6qV6zkunGQrssqr2ZBku4w+RoY2dwg/gysjjFPg9G+uixehaLCdgsM=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr20740180ybm.153.1653335082793; Mon, 23
 May 2022 12:44:42 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 May 2022 21:44:31 +0200
Message-ID: <CAJZ5v0h803aUmDW-oHh6+DkBkSXftmrVTwD463YkHW-h+8c=kQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.19-rc1

with top-most commit bbb544f3349197d1e7f4f9b921b75e919cd45f39

 Merge branches 'thermal-int340x', 'thermal-pch' and 'thermal-misc'

on top of commit 42226c989789d8da4af1de0c31070c96726d990c

 Linux 5.18-rc7

to receive thermal control updates for 5.19-rc1.

These add a thermal library and thermal tools to wrap the netlink
interface into event-based callbacks, improve overheat condition
handling during suspend-to-idle on Intel SoCs, add some new hardware
support, fix bugs and clean up code.

Specifics:

 - Add thermal library and thermal tools to encapsulate the netlink
   into event based callbacks (Daniel Lezcano, Jiapeng Chong).

 - Improve overheat condition handling during suspend-to-idle in the
   Intel PCH thermal driver (Zhang Rui).

 - Use local ops instead of global ops in devfreq_cooling (Kant Fan).

 - Clean up _OSC handling in int340x (Davidlohr Bueso).

 - Switch hisi_termal from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
   (Hesham Almatary).

 - Add new k3 j72xx bangdap driver and the corresponding bindings
   (Keerthy).

 - Fix missing of_node_put() in the SC iMX driver at probe time
   (Miaoqian Lin).

 - Fix memory leak in __thermal_cooling_device_register() when
   device_register() fails by calling thermal_cooling_device_destroy_sysfs()
   (Yang Yingliang).

 - Add sc8180x and sc8280xp compatible string in the DT bindings and
   lMH support for QCom tsens driver (Bjorn Andersson).

 - Fix OTP Calibration Register values conforming to the documentation
   on RZ/G2L and bindings documentation for RZ/G2UL (Biju Das).

 - Fix type in kerneldoc description for __thermal_bind_params (Corentin
   Labbe).

 - Fix potential NULL dereference in sr_thermal_probe() on Broadcom
   platform (Zheng Yongjun).

 - Add change mode ops to the thermal-of sensor (Manaf Meethalavalappu
   Pallikunhi).

 - Fix non-negative value support by preventing the value to be clamp
   to zero (Stefan Wahren).

 - Add compatible string and DT bindings for MSM8960 tsens driver
   (Dmitry Baryshkov).

 - Add hwmon support for K3 driver (Massimiliano Minella).

 - Refactor and add multiple generations support for QCom ADC driver
   (Jishnu Prakash).

 - Use platform_get_irq_optional() to get the interrupt on RCar driver and
   document Document RZ/V2L bindings (Lad Prabhakar).

 - Remove NULL check after container_of() call from the Intel HFI
   thermal driver (Haowen Bai).

Thanks!


---------------

Biju Das (2):
      dt-bindings: thermal: rzg2l-thermal: Document RZ/G2UL bindings
      thermal/drivers/rz2gl: Fix OTP Calibration Register values

Bjorn Andersson (3):
      thermal/drivers/qcom/lmh: Add sc8180x compatible
      dt-bindings: thermal: lmh: Add Qualcomm sc8180x compatible
      dt-bindings: thermal: tsens: Add sc8280xp compatible

Corentin Labbe (1):
      thermal: thermal_of: fix typo on __thermal_bind_params

Daniel Lezcano (4):
      tools/lib/thermal: Add a thermal library
      tools/thermal: Add util library
      tools/thermal: Add a temperature capture tool
      tools/thermal: Add thermal daemon skeleton

Davidlohr Bueso (3):
      thermal: int340x: Clean up unnecessary acpi_buffer pointer freeing
      thermal: int340x: Consolidate freeing of acpi_buffer pointer
      thermal: int340x: Clean up _OSC context init

Dmitry Baryshkov (2):
      dt-bindings: thermal: qcom-tsens.yaml: add msm8960 compat string
      thermal/drivers/tsens: Add compat string for the qcom,msm8960

Haowen Bai (1):
      thermal: intel: hfi: remove NULL check after container_of() call

Hesham Almatary (1):
      thermal: hisi_termal: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()

Jiapeng Chong (2):
      tools/lib/thermal: remove unneeded semicolon
      tools/thermal: remove unneeded semicolon

Jishnu Prakash (4):
      dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
      iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
      thermal/drivers/qcom: Add support for multiple generations of devices
      thermal/drivers/qcom: Add support for PMIC5 Gen2 ADCTM

Kant Fan (1):
      thermal: devfreq_cooling: use local ops instead of global ops

Keerthy (2):
      dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
      thermal: k3_j72xx_bandgap: Add the bandgap driver support

Lad Prabhakar (2):
      dt-bindings: thermal: rzg2l-thermal: Document RZ/V2L bindings
      thermal/drivers/rcar_thermal: Use platform_get_irq_optional() to
get the interrupt

Manaf Meethalavalappu Pallikunhi (1):
      thermal/drivers/thermal_of: Add change_mode ops support for
thermal_of sensor

Massimiliano Minella (1):
      thermal/drivers/k3: Add hwmon support

Miaoqian Lin (1):
      thermal/drivers/imx_sc_thermal: Fix refcount leak in imx_sc_thermal_probe

Srinivas Pandruvada (1):
      thermal: int340x: Mode setting with new OS handshake

Stefan Wahren (1):
      thermal/drivers/bcm2711: Don't clamp temperature at zero

Yang Yingliang (1):
      thermal/core: Fix memory leak in __thermal_cooling_device_register()

Zhang Rui (4):
      PM: wakeup: expose pm_wakeup_pending to modules
      thermal: intel: pch: move cooling delay to suspend_noirq phase
      thermal: intel: pch: enhance overheat handling
      thermal: intel: pch: improve the cooling delay log

Zheng Yongjun (1):
      thermal/drivers/broadcom: Fix potential NULL dereference in
sr_thermal_probe

---------------

 .../devicetree/bindings/thermal/qcom-lmh.yaml      |   1 +
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 +++-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   5 +-
 .../devicetree/bindings/thermal/rzg2l-thermal.yaml |   2 +
 .../bindings/thermal/ti,j72xx-thermal.yaml         |  63 +++
 MAINTAINERS                                        |   1 +
 drivers/base/power/wakeup.c                        |   1 +
 drivers/iio/adc/qcom-vadc-common.c                 |  11 +
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/broadcom/bcm2711_thermal.c         |   5 +-
 drivers/thermal/broadcom/sr-thermal.c              |   3 +
 drivers/thermal/devfreq_cooling.c                  |  25 +-
 drivers/thermal/hisi_thermal.c                     |   6 +-
 drivers/thermal/imx_sc_thermal.c                   |   6 +-
 .../intel/int340x_thermal/int3400_thermal.c        |  72 +--
 drivers/thermal/intel/intel_hfi.c                  |   2 -
 drivers/thermal/intel/intel_pch_thermal.c          |  43 +-
 drivers/thermal/k3_bandgap.c                       |   5 +
 drivers/thermal/k3_j72xx_bandgap.c                 | 566 ++++++++++++++++++++
 drivers/thermal/qcom/lmh.c                         |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 486 +++++++++++++++--
 drivers/thermal/qcom/tsens.c                       |   3 +
 drivers/thermal/rcar_thermal.c                     |  17 +-
 drivers/thermal/rzg2l_thermal.c                    |  10 +-
 drivers/thermal/thermal_core.c                     |   1 +
 drivers/thermal/thermal_of.c                       |  14 +-
 include/linux/iio/adc/qcom-vadc-common.h           |   2 +
 include/linux/thermal.h                            |   3 +
 tools/Makefile                                     |  36 +-
 tools/lib/thermal/.gitignore                       |   2 +
 tools/lib/thermal/Build                            |   5 +
 tools/lib/thermal/Makefile                         | 165 ++++++
 tools/lib/thermal/commands.c                       | 349 +++++++++++++
 tools/lib/thermal/events.c                         | 164 ++++++
 tools/lib/thermal/include/thermal.h                | 142 +++++
 tools/lib/thermal/libthermal.map                   |  25 +
 tools/lib/thermal/libthermal.pc.template           |  12 +
 tools/lib/thermal/sampling.c                       |  75 +++
 tools/lib/thermal/thermal.c                        | 135 +++++
 tools/lib/thermal/thermal_nl.c                     | 215 ++++++++
 tools/lib/thermal/thermal_nl.h                     |  46 ++
 tools/thermal/lib/Build                            |   3 +
 tools/thermal/lib/Makefile                         | 158 ++++++
 tools/thermal/lib/libthermal_tools.pc.template     |  12 +
 tools/thermal/lib/log.c                            |  77 +++
 tools/thermal/lib/log.h                            |  31 ++
 tools/thermal/lib/mainloop.c                       | 120 +++++
 tools/thermal/lib/mainloop.h                       |  15 +
 tools/thermal/lib/thermal-tools.h                  |  10 +
 tools/thermal/lib/uptimeofday.c                    |  40 ++
 tools/thermal/lib/uptimeofday.h                    |  12 +
 tools/thermal/thermal-engine/Build                 |   1 +
 tools/thermal/thermal-engine/Makefile              |  28 +
 tools/thermal/thermal-engine/thermal-engine.c      | 341 ++++++++++++
 tools/thermal/thermometer/Build                    |   1 +
 tools/thermal/thermometer/Makefile                 |  26 +
 tools/thermal/thermometer/thermometer.8            |  92 ++++
 tools/thermal/thermometer/thermometer.c            | 572 +++++++++++++++++++++
 tools/thermal/thermometer/thermometer.conf         |   5 +
 59 files changed, 4263 insertions(+), 118 deletions(-)
