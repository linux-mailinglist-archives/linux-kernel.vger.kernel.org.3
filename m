Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD54EE71F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 06:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbiDAEZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 00:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiDAEZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 00:25:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8B1A8443;
        Thu, 31 Mar 2022 21:23:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m18so1455773plx.3;
        Thu, 31 Mar 2022 21:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=m+t6tz7gR24Bdf6PZaHlcoK+piVMTZrTtc48GD21Jpk=;
        b=AMRr3I270ev4ymAfgVirzl6FQ4T+X5mX3SSgALXAHrgX/PYeB17g/QjgVq4WFAMnkv
         07QY6GbwEljnOKGVdw1hB/2DyAQe0/+8XoqOXu6nfAnofRBLVJjgD7RukD+u0Mr8fgOS
         +spKlZynLRk66LaXWWVUzZ7PxOE6zKbVq2B0Y9L4+Yzeb5zQDuLmw+dyiksHWg0Cu5cT
         OJhEyOLLK8RALJheaJ3RIckECg4BRQCxNmoHQNB8d1ETWczWrEUiny4OUNUClacTcRzo
         a/q+vwwM9nL0KcTjlTyWTBt3OhcakafmhN4fBSrZcz/UIHg85z79PS0WeHiWlTxhRHio
         oJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=m+t6tz7gR24Bdf6PZaHlcoK+piVMTZrTtc48GD21Jpk=;
        b=1QUhaGUm/s5Y69K2pJV7ew26qBXHQacTcLR+AOke5tqnfrxyrM8EALJRkLj98QZaVx
         KNTjpVIYfsB5HuOGsndo0lgu4ywnOmaFwk7GrI09D0KbxEKve/1SasL+yNxq0PaMn43+
         QufuMhFWFkDUKIZQNmzd4paN39Zodw1eTVeNgHh9L8xEHSkFQXoEtqM7UdTSLFMrL50p
         Ev/9fNlWxu/6vvLMKJnpQ45kAFcy1wQtw7IozzT+nNTorftRyIL0dCfAf9WH91cj0kj6
         inXXgTr1J6pE7GTzLmLJSEU+2IYTFew6kdTzL8Yy0fpm8cyRMr+YEFS1rXtN7IpFP8yU
         riSQ==
X-Gm-Message-State: AOAM5308qnW0jTau02hw/OMdXkE1saVCsVzjXfHs10NLBJNRwPb0l+IM
        /7NvdfSd/26nbSjLiJZTqRs=
X-Google-Smtp-Source: ABdhPJxVjmOQ+kpxQnUwbp7mbogR6E1fVLKS6he/B/pczVg0MdQjfpxif7wTV9Dqa0eHDkT7rKnlOg==
X-Received: by 2002:a17:902:f690:b0:154:2ceb:f18a with SMTP id l16-20020a170902f69000b001542cebf18amr8641905plg.4.1648786990736;
        Thu, 31 Mar 2022 21:23:10 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:861c:fce2:7032:ab10])
        by smtp.gmail.com with ESMTPSA id q18-20020aa78432000000b004fb0a5aa2c7sm1102958pfn.183.2022.03.31.21.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 21:23:09 -0700 (PDT)
Date:   Thu, 31 Mar 2022 21:23:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.18-rc0
Message-ID: <YkZ+K2Gtt75y1/O+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a revert of a patch resetting extra buttons on touchpads claiming to
  be buttonpads as this caused regression on certain Dell devices
- a new driver for Mediatek MT6779 keypad
- a new driver for Imagis touchscreen
- rework of Google/Chrome OS "Vivaldi" keyboard handling
- assorted driver fixes.

Changelog:
---------

Christophe JAILLET (1):
      Input: da9063 - use devm_delayed_work_autocancel()

Colin Ian King (1):
      Input: adi - remove redundant variable z

Danilo Krummrich (5):
      Input: ps2-gpio - refactor struct ps2_gpio_data
      Input: ps2-gpio - use ktime for IRQ timekeeping
      Input: ps2-gpio - remove tx timeout from ps2_gpio_irq_tx()
      Input: ps2-gpio - don't send rx data before the stop bit
      Input: ps2-gpio - enforce GPIOs flag open drain

Dmitry Torokhov (1):
      HID: google: switch to devm when registering keyboard backlight LED

Hans de Goede (4):
      Input: set EV_ABS in dev->evbit even if input_alloc_absinfo() fails
      Input: add input_copy_abs() function
      Input: goodix - use input_copy_abs() helper
      Input: goodix - fix race on driver unbind

Jeff LaBundy (2):
      Input: iqs5xx - use local input_dev pointer
      Input: add bounds checking to input_set_capability()

José Expósito (1):
      Revert "Input: clear BTN_RIGHT/MIDDLE on buttonpads"

Lv Ruyi (CGEL ZTE) (1):
      Input: mt6779-keypad - fix signedness bug

Marcos Alano (1):
      Input: xbox - correct the name for Xbox Series S|X controller

Markuss Broks (2):
      dt-bindings: input/touchscreen: bindings for Imagis
      Input: add Imagis touchscreen driver

Matthew Haughton (1):
      Input: synaptics - enable InterTouch on ThinkPad T14/P14s Gen 1 AMD

Mattijs Korpershoek (3):
      Input: mtk-pmic-keys - use get_irq_byname() instead of index
      dt-bindings: input: mtk-pmic-keys: add MT6358 binding definition
      Input: mtk-pmic-keys - add support for MT6358

Stephen Boyd (3):
      Input: extract ChromeOS vivaldi physmap show function
      HID: google: extract Vivaldi hid feature mapping for use in hid-hammer
      HID: google: Add support for vivaldi to hid-hammer

Yunus Bas (1):
      Input: tsc200x - add axis inversion and swapping support

Zheng Yongjun (1):
      Input: stmfts - fix reference leak in stmfts_input_open

Zhengqiao Xia (1):
      HID: google: modify HID device groups of eel

fengping.yu (2):
      dt-bindings: input: Add bindings for Mediatek matrix keypad
      Input: mt6779-keypad - add MediaTek keypad driver

Diffstat:
--------

 .../bindings/input/mediatek,mt6779-keypad.yaml     |  77 +++++
 .../devicetree/bindings/input/mtk-pmic-keys.txt    |   5 +-
 .../input/touchscreen/imagis,ist3038c.yaml         |  74 +++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   6 +
 drivers/hid/Kconfig                                |  11 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/hid-google-hammer.c                    |  51 ++-
 drivers/hid/hid-vivaldi-common.c                   | 140 ++++++++
 drivers/hid/hid-vivaldi-common.h                   |  16 +
 drivers/hid/hid-vivaldi.c                          | 121 +------
 drivers/input/Kconfig                              |   7 +
 drivers/input/Makefile                             |   1 +
 drivers/input/input.c                              |  70 +++-
 drivers/input/joystick/adi.c                       |   4 +-
 drivers/input/joystick/xpad.c                      |   2 +-
 drivers/input/keyboard/Kconfig                     |  14 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/atkbd.c                     |  27 +-
 drivers/input/keyboard/cros_ec_keyb.c              |  43 +--
 drivers/input/keyboard/mt6779-keypad.c             | 221 +++++++++++++
 drivers/input/keyboard/mtk-pmic-keys.c             |  55 ++-
 drivers/input/misc/da9063_onkey.c                  |  13 +-
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/serio/ps2-gpio.c                     | 195 +++++++----
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/goodix.c                 |  61 ++--
 drivers/input/touchscreen/goodix.h                 |   1 +
 drivers/input/touchscreen/imagis.c                 | 367 +++++++++++++++++++++
 drivers/input/touchscreen/iqs5xx.c                 |  16 +-
 drivers/input/touchscreen/stmfts.c                 |   8 +-
 drivers/input/touchscreen/tsc200x-core.c           |   7 +-
 drivers/input/vivaldi-fmap.c                       |  39 +++
 include/linux/input.h                              |   2 +
 include/linux/input/vivaldi-fmap.h                 |  27 ++
 36 files changed, 1364 insertions(+), 333 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
 create mode 100644 drivers/hid/hid-vivaldi-common.c
 create mode 100644 drivers/hid/hid-vivaldi-common.h
 create mode 100644 drivers/input/keyboard/mt6779-keypad.c
 create mode 100644 drivers/input/touchscreen/imagis.c
 create mode 100644 drivers/input/vivaldi-fmap.c
 create mode 100644 include/linux/input/vivaldi-fmap.h

Thanks.


-- 
Dmitry
