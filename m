Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3C6536E75
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiE1UnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 16:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiE1UnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 16:43:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D28B5D663;
        Sat, 28 May 2022 13:43:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so7234789pjf.5;
        Sat, 28 May 2022 13:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OW7gvGoD7fY6wRK97c+1pat3jS831FfSUeJ8RYkt18A=;
        b=GEo2p+G+oTtaIkkANMqT9p/hMumddWCeDCsv4sO43jFcmWWv3PWMAHuNYsQqKLQ0pi
         RJOoZSWw0QP3AMv66/QCvI809/eakKVb0bMqeuAKRk8sSJ29tmq3lOdjqAYXUclotyS7
         qi0jIqorOcEmvU+lp4+LBKw2+zdAHmF/fvoGBVeKBEvMlKxq3qHVGHacblBF9HTtv0WT
         o1oroDJ0Xg9/5W9P1oObLAF886I0qpVRJWQeQTJhAkbKZ98lPU4wekFVBxuKgQc6KcsF
         +ZvAnsDImagQxmF4+e1xdTbSmR+cFZG1ZrMu4ng6YI+X6ZzVujxhkmVxGgmsfEL6fRUA
         XBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OW7gvGoD7fY6wRK97c+1pat3jS831FfSUeJ8RYkt18A=;
        b=In6xbjjdh6kdyKgDy4NkQCF6ZZOr0pbqKNW2nOdqBqzBmvd9eLLCvYaVuIXIehJ1TK
         TCtL4AIN4cXF0wEWAEDDr9jbvp4ZqM290iX2fgM+CVAYzvwYGpKUDt3+/WUFaa0n7giQ
         TlWuh0ZrSdL80mNz751ogimy4lS5Q12mLfABmh6Wh46mtVfetkBBql7nR9UTIEUweev3
         AuFQFNn7jgra8V4g7JsW9ieVTrDx5aaxecIMLUG+CxDAmVWF8D95i0cBNT0DswQWmO+6
         pdfXN54X7vtOVOtyYBti1OSB0KdRiR3yaRVQFE0Kq9dnRAbtT9A/j+VTJ0H6wtUpuPQp
         84dQ==
X-Gm-Message-State: AOAM532FkQor/u17JS2PIRZQvfNkjBveOsypPj0tw+zrrXNu9EYuvVaC
        yz4kiUkD3v2LJcPww7H1Bu6bb76P9xY=
X-Google-Smtp-Source: ABdhPJyM0TPLK9uJ+lJbx5JbJ18Gu3uh9E+eOJ6acSoZ6cLD1DdGc2LLu8MLUtiS9jlcz0Cx0gmEHA==
X-Received: by 2002:a17:902:c2d8:b0:15e:fa17:56cc with SMTP id c24-20020a170902c2d800b0015efa1756ccmr48834783pla.40.1653770591793;
        Sat, 28 May 2022 13:43:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:781a:4ab0:a93b:176b])
        by smtp.gmail.com with ESMTPSA id v4-20020a1709029a0400b0015f300ed0b7sm1453293plp.76.2022.05.28.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 13:43:11 -0700 (PDT)
Date:   Sat, 28 May 2022 13:43:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.19-rc0
Message-ID: <YpKJXdB/5h7Ee0Ys@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc0

to receive updates for the input subsystem. You will get:

- a new driver for Azoteq IQS7222A/B/C capacitive touch controller

- a new driver for Raspberry Pi Sense HAT joystick

- sun4i-lradc-keys gained support of R329 and D1 variants, plus it
  can be now used as a wakeup source

- pm8941-pwrkey can now properly handle PON GEN3 variants; the driver
  also implements software debouncing and has a workaround for missing
  key press events

- assorted driver fixes and cleanups.


Changelog:
---------

Alexander Shiyan (1):
      Input: clps711x-keypad - use syscon_regmap_lookup_by_phandle

AngeloGioacchino Del Regno (1):
      Input: mt6779-keypad - move iomem pointer to probe function

Anjelique Melendez (2):
      Input: pm8941-pwrkey - fix error message
      Input: pm8941-pwrkey - add support for PON GEN3 base addresses

Changcheng Deng (1):
      Input: remove unneeded variable in input_inhibit_device()

Charles Mirabile (1):
      Input: add Raspberry Pi Sense HAT joystick driver

Colin Ian King (1):
      Input: aiptek - remove redundant assignment to variable ret

Dan Carpenter (1):
      Input: iqs7222 - propagate some error codes correctly

David Collins (2):
      Input: pm8941-pwrkey - add software key press debouncing support
      Input: pm8941-pwrkey - simulate missed key press events

Dmitry Torokhov (1):
      Input: stmfts - do not leave device disabled in stmfts_input_open

Jeff LaBundy (3):
      dt-bindings: input: Add bindings for Azoteq IQS7222A/B/C
      Input: add support for Azoteq IQS7222A/B/C
      Input: iqs7222 - avoid dereferencing a NULL pointer

Julia Lawall (1):
      Input: cypress_ps2 - fix typo in comment

Lad Prabhakar (1):
      Input: gpio-keys - cancel delayed work only in case of GPIO

Lv Ruyi (1):
      Input: ep93xx_keypad - use devm_platform_ioremap_resource() helper

Miaoqian Lin (1):
      Input: sparcspkr - fix refcount leak in bbc_beep_probe

Ondrej Jirman (1):
      Input: sun4i-lradc-keys - add wakeup support

Samuel Holland (3):
      dt-bindings: input: sun4i-lradc-keys: Add R329 and D1 compatibles
      Input: sun4i-lradc-keys - add optional clock/reset support
      Input: sun4i-lradc-keys - add support for R329 and D1

Stephen Boyd (3):
      dt-bindings: google,cros-ec-keyb: Introduce switches only compatible
      Input: cros-ec-keyb - allow skipping keyboard registration
      dt-bindings: google,cros-ec-keyb: Fixup bad compatible match

Tetsuo Handa (1):
      Input: psmouse-smbus - avoid flush_scheduled_work() usage

Wan Jiabing (1):
      Input: bcm-keypad - remove unneeded NULL check before clk_disable_unprepare

Zongmin Zhou (1):
      Input: vmmouse - disable vmmouse before entering suspend mode

ran jianping (1):
      Input: synaptics-rmi4 - remove unnecessary flush_workqueue()

Diffstat:
--------

 .../input/allwinner,sun4i-a10-lradc-keys.yaml      |   22 +
 .../devicetree/bindings/input/azoteq,iqs7222.yaml  |  960 ++++++++
 .../bindings/input/google,cros-ec-keyb.yaml        |   36 +-
 drivers/input/input.c                              |    4 +-
 drivers/input/joystick/Kconfig                     |   11 +
 drivers/input/joystick/Makefile                    |    1 +
 drivers/input/joystick/sensehat-joystick.c         |  137 ++
 drivers/input/keyboard/bcm-keypad.c                |    3 +-
 drivers/input/keyboard/clps711x-keypad.c           |    3 +-
 drivers/input/keyboard/cros_ec_keyb.c              |   29 +-
 drivers/input/keyboard/ep93xx_keypad.c             |    7 +-
 drivers/input/keyboard/gpio_keys.c                 |    2 +-
 drivers/input/keyboard/mt6779-keypad.c             |   10 +-
 drivers/input/keyboard/sun4i-lradc-keys.c          |   63 +-
 drivers/input/misc/Kconfig                         |   10 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/iqs7222.c                       | 2446 ++++++++++++++++++++
 drivers/input/misc/pm8941-pwrkey.c                 |  127 +-
 drivers/input/misc/sparcspkr.c                     |    1 +
 drivers/input/mouse/cypress_ps2.c                  |    2 +-
 drivers/input/mouse/psmouse-smbus.c                |   11 +-
 drivers/input/mouse/vmmouse.c                      |   14 +
 drivers/input/rmi4/rmi_f54.c                       |    1 -
 drivers/input/tablet/aiptek.c                      |    3 +-
 drivers/input/touchscreen/stmfts.c                 |   16 +-
 25 files changed, 3852 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
 create mode 100644 drivers/input/joystick/sensehat-joystick.c
 create mode 100644 drivers/input/misc/iqs7222.c

Thanks.


-- 
Dmitry
