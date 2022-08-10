Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3EF58F450
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiHJWXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiHJWXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:23:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852F38D3CC;
        Wed, 10 Aug 2022 15:23:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x23so15456539pll.7;
        Wed, 10 Aug 2022 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=JQqekzl1vEkZlcNOD3yssSzMeWzthaUCawc53RF6fao=;
        b=QjJAgm/ZM369m8wZEBgNZF82SV97DWvZOlD82vsJ6lK44zJlyAyzGDu4HcQGqndv0q
         dCE6J0RmHA9mCtFs8U1HdBvfrqISb2UK78oxgrAyriRQ3MELbF+IaSZhU2UCG+nJC2w0
         pf20UuzSBkT76jiPJtN/4x56tmhqD1oLyUhCd4twPOI5qJTDDGab5v9xJxI4jefa2d3r
         RRyRFIgH8jlVXcvsG1OW0Tae2aUitIYEF0M6OAGmvjR/Z7RQa8bAn4fB97ckHJQ6Midv
         Vryb62ALcdMrTWJuQEYHh0ClM4WGXKF5LEm5MQWBNqqjeEHis50ztuikf5Bmyhw7hWVd
         orYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=JQqekzl1vEkZlcNOD3yssSzMeWzthaUCawc53RF6fao=;
        b=md/NPxUJ2D/pciYdENi7I2UEfSkkUsNoZO6YJWuUR3JQVsGnG+NQCOYQZykPAi2+67
         jHuGFaAzgYBHGW5VFlQChmrT+PFXYVKP9yq2KlaUAqOHfHRYc+rmxKG3oAaI4WnI5Boy
         U9qka4sdVe7oB6+VhlAusuObSfoR69b8XSQeCAChfW/64tpcZrGkHG5fvC2m0TGYUeb1
         I1ezoRug4UnWsNNC8r8WaPrAq1LEpy3baxau5Wx+l5je+Pmryb3I0AIOOfvgNPTmo2Ch
         iSE0Yeva6gwEiSmJpXyKR2wC7e7heTWtPMz1n/f5ieCPYGAPiSC/0WMsSmb5YcsJjYqH
         hw9A==
X-Gm-Message-State: ACgBeo3rZpuBkdWXttNiKT5wJlXPG+pDQE9Ed20i+tsiXafvBB9R6uMn
        Gsel4GRgIjiSSl+9jKsIYVWlCjsHVq8=
X-Google-Smtp-Source: AA6agR69sMXwMA5wf2NcYLdtAH1Cukvj4/dfYeY089n7y6V6ANrqCTfgwPXV4zRJyJ1M6bqutP8llw==
X-Received: by 2002:a17:902:ce04:b0:16c:e142:5dd7 with SMTP id k4-20020a170902ce0400b0016ce1425dd7mr30336311plg.173.1660170179734;
        Wed, 10 Aug 2022 15:22:59 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a3c8:d6b9:a5c2:1eca])
        by smtp.gmail.com with ESMTPSA id i190-20020a626dc7000000b0052f80d1a573sm2501538pfc.120.2022.08.10.15.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 15:22:58 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:22:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.20-rc0
Message-ID: <YvQvwNqu5sxr36Th@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.20-rc0

to receive updates for the input subsystem. You will get:

- changes to input core to properly queue synthetic events (such as
  autorepeat) and to release multitouch contacts when an input device is
  inhibited or suspended
- reworked quirk handling in i8042 driver that consolidates multiple
  DMI tables into one and adds several quirks for TUXEDO line of
  laptops
- update to mt6779 keypad to better reflect organization of the hardware 
- changes to mtk-pmic-keys driver preparing it to handle more variants
- facelift of adp5588-keys driver
- improvements to iqs7222 driver
- adjustments to various DT binding documents for input devices
- other assorted driver fixes.

Changelog:
---------

Andy Shevchenko (1):
      Input: goodix - switch use of acpi_gpio_get_*_resource() APIs

Angela Czubak (1):
      Input: deactivate MT slots when inhibiting or suspending devices

AngeloGioacchino Del Regno (2):
      Input: mtk-pmic-keys - transfer per-key bit in mtk_pmic_keys_regs
      Input: mtk-pmic-keys - move long press debounce mask to mtk_pmic_regs

Dario Binacchi (6):
      dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz
      Input: edt-ft5x06 - get/set M12 report rate by sysfs
      Input: edt-ft5x06 - set report rate by dts property
      Input: edt-ft5x06 - show model name by sysfs
      Input: edt-ft5x06 - show firmware version by sysfs
      Input: edt-ft5x06 - show crc and header errors by sysfs

Dmitry Torokhov (9):
      Input: cros_ec_keyb - switch to using generic device properties
      Input: adp5588-keys - drop CONFIG_PM guards
      Input: adp5588-keys - switch to using threaded interrupt
      Input: adp5588-keys - switch to using managed resources
      Input: adp5588-keys - do not explicitly set device as wakeup source
      Input: mtk-pmic-keys - allow compiling with COMPILE_TEST
      Input: mtk-pmic-keys - use single update when configuring long press behavior
      Input: properly queue synthetic events
      Input: adc-joystick - fix ordering in adc_joystick_probe()

Furquan Shaikh (1):
      Input: cros_ec_keyb - handle x86 detachable/convertible Chromebooks

Hans de Goede (1):
      Input: i8042 - add dritek quirk for Acer Aspire One AO532

Jeff LaBundy (10):
      Input: iqs7222 - correct slider event disable logic
      Input: iqs7222 - fortify slider event reporting
      Input: iqs7222 - protect volatile registers
      Input: iqs7222 - acknowledge reset before writing registers
      Input: iqs7222 - handle reset during ATI
      Input: iqs7222 - remove support for RF filter
      dt-bindings: input: iqs7222: Remove support for RF filter
      dt-bindings: input: iqs7222: Correct bottom speed step size
      dt-bindings: input: iqs7222: Extend slider-mapped GPIO to IQS7222C
      dt-bindings: input: iqs7222: Use central 'linux,code' definition

Jiang Jian (2):
      Input: gpio_mouse - fix typos in comments
      Input: cyapa_gen6 - aligned "*" each line

Krzysztof Kozlowski (5):
      dt-bindings: input: use generic node names
      dt-bindings: input: gpio-keys: enforce node names to match all properties
      dt-bindings: input: gpio-keys: reference input.yaml and document properties
      dt-bindings: input: gpio-keys: accept also interrupt-extended
      dt-bindings: input: ariel-pwrbutton: use spi-peripheral-props.yaml

Linus Walleij (1):
      Input: zinitix - rename defines ZINITIX_*

Mattijs Korpershoek (2):
      Input: mt6779-keypad - match hardware matrix organization
      Input: mt6779-keypad - implement row/column selection

Miaoqian Lin (1):
      Input: exc3000 - fix return value check of wait_for_completion_timeout

Minghao Chi (1):
      Input: omap4-keypad - switch to using pm_runtime_resume_and_get()

Rob Herring (5):
      dt-bindings: input: Increase maximum keycode value to 0x2ff
      dt-bindings: input: Centralize 'linux,code' definition
      dt-bindings: input: Use common 'linux,keycodes' definition
      dt-bindings: input: Centralize 'linux,input-type' definition
      dt-bindings: input: Convert adc-keys to DT schema

Werner Sembach (5):
      Input: i8042 - move __initconst to fix code styling warning
      Input: i8042 - merge quirk tables
      Input: i8042 - add debug output for quirks
      Input: i8042 - add TUXEDO devices to i8042 quirk tables
      Input: i8042 - add additional TUXEDO devices to i8042 quirk tables

Yang Li (1):
      Input: sensehat-joystick - remove unnecessary error message

Diffstat:
--------

 .../devicetree/bindings/input/adc-joystick.yaml    |    2 +-
 .../devicetree/bindings/input/adc-keys.txt         |   67 -
 .../devicetree/bindings/input/adc-keys.yaml        |  103 ++
 .../input/allwinner,sun4i-a10-lradc-keys.yaml      |    5 +-
 .../devicetree/bindings/input/ariel-pwrbutton.yaml |    1 +
 .../devicetree/bindings/input/azoteq,iqs7222.yaml  |   41 +-
 .../bindings/input/fsl,mpr121-touchkey.yaml        |    4 +-
 .../devicetree/bindings/input/gpio-keys.yaml       |  167 ++-
 Documentation/devicetree/bindings/input/input.yaml |   24 +-
 .../devicetree/bindings/input/iqs269a.yaml         |   17 +-
 .../devicetree/bindings/input/iqs626a.yaml         |   13 +-
 .../devicetree/bindings/input/iqs62x-keys.yaml     |    9 +-
 .../devicetree/bindings/input/max77650-onkey.yaml  |    8 +-
 .../bindings/input/microchip,cap11xx.yaml          |    2 +-
 .../bindings/input/touchscreen/edt-ft5x06.yaml     |    8 +
 drivers/input/input-core-private.h                 |   16 +
 drivers/input/input-mt.c                           |   48 +-
 drivers/input/input.c                              |  149 +--
 drivers/input/joystick/adc-joystick.c              |   15 +-
 drivers/input/joystick/sensehat-joystick.c         |    4 +-
 drivers/input/keyboard/Kconfig                     |    2 +-
 drivers/input/keyboard/adp5588-keys.c              |  206 ++--
 drivers/input/keyboard/cros_ec_keyb.c              |   89 +-
 drivers/input/keyboard/mt6779-keypad.c             |   18 +-
 drivers/input/keyboard/mtk-pmic-keys.c             |   98 +-
 drivers/input/keyboard/omap4-keypad.c              |   26 +-
 drivers/input/misc/iqs7222.c                       |  178 ++-
 drivers/input/mouse/cyapa_gen6.c                   |    2 +-
 drivers/input/mouse/gpio_mouse.c                   |    2 +-
 drivers/input/serio/i8042-x86ia64io.h              | 1282 ++++++++++++--------
 drivers/input/touchscreen/edt-ft5x06.c             |   96 +-
 drivers/input/touchscreen/exc3000.c                |    7 +-
 drivers/input/touchscreen/goodix.c                 |   22 +-
 drivers/input/touchscreen/zinitix.c                |  112 +-
 34 files changed, 1709 insertions(+), 1134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.yaml
 create mode 100644 drivers/input/input-core-private.h

Thanks.


-- 
Dmitry
