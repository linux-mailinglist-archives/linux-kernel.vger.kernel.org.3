Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C85525E44
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378746AbiEMJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358383AbiEMJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:09:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1974D16A5F5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:09:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y41so7136036pfw.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=UhwvQh9WtluvABzEKWCvpawdI9sw+xJ4pB8xu8UmCHM=;
        b=ahZDSOAXXUHUAEG1yC3XfSJqvzeJkvhql07Da/P4vca3HPDsvH8yoaAJcrIkb19Nfj
         f7ToDRN3UwiVBHK67cZYVC/QE41iyck4/cBxjuYJOXKjfSdxsIUcjyGidBGnv9ycDDtR
         OFrcEWSBN+xmUgbpG1PiTA5HZ5Xciqp2AEVruTLTcN4JIitJbxSfUWIZVBabym4R/2kQ
         leexTl0fzpynm7T5VrmH9aLeZwtxCjcQiVB7Hk0KgDSQ9Jp+dp+tcjhkeVfQiow6PyB2
         DxiSiGiZQXm7svvThPuuoGfPDvYGjaS1ORF1kkyUb/fCKSaj586wHbId8A7WPqXUdcSJ
         ODvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=UhwvQh9WtluvABzEKWCvpawdI9sw+xJ4pB8xu8UmCHM=;
        b=ab7uiUuYnpMoNU1Qj0cDjps/CAkeaNF4J35AyQ8cXHYEckzQsRW2hih8nQ/g3Vw32H
         zLyqOiUJV0UiPv2Nt+0r4Hl3DUjq7VqLrwpI0yf+J51dGePRFVSofh0n/zv6Sip/PXYy
         k/k4kCc3NJZ/o1uikV+h+cqFRykPeXTteujxNYOoVOJJ06KgmfHZIXWrx//74ZXbWhAs
         D5BoTc0OeELTQ8dBo8+Mp4pxDGZ/dqcCQy0z9V589F9ESjLU/vzzxVcLxhhWNbf1seWd
         VOzYR+KQ50RaidwyWk0KMMjnBilwq+DIHw/s/4OCt8lWQfI0ytwr+X4UntTnPMJJvv/F
         oVRA==
X-Gm-Message-State: AOAM532V8vyAPkQd6jJWLJU2iewJPDYEfHi281xkb7W8cDGZpvGQbXWF
        rQ7c1CtYS21ChFMxHnzm40DC+rYEw/SBww==
X-Google-Smtp-Source: ABdhPJw9AmUX6oiOO8GeE5/tKzoNVyh8tN2+HRg3vAflSizCKkzMz00b3asdeORgXBPEDoK5yqgquw==
X-Received: by 2002:a63:2ad0:0:b0:3c1:5f7e:fd78 with SMTP id q199-20020a632ad0000000b003c15f7efd78mr3272898pgq.56.1652432997452;
        Fri, 13 May 2022 02:09:57 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902f60b00b0015ec71f72d6sm1285022plg.253.2022.05.13.02.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 02:09:57 -0700 (PDT)
Message-ID: <eaab9f4d-06d4-3ddc-3756-69f762bd86e1@gmail.com>
Date:   Fri, 13 May 2022 18:09:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
Subject: [GIT PULL] extcon next for 5.19
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.19. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.19

for you to fetch changes up to 5dcc2afe716d69f5112ce035cb14f007461ff189:

  extcon: Modify extcon device to be created after driver data is set (2022-05-13 17:03:41 +0900)

----------------------------------------------------------------
Update extcon next for v5.19

Detailed description for this pull request:
1. update extcon core driver
- extcon_get_extcon_dev() has been almost used to get the extcon device
on booting time. If extcon provider driver is probed at late time,
the extcon consumer driver get the -EPROBE_DEFER return value.
It requires the inefficient handling code of -EPROBE_DEFER.
Instead, extcon_get_extcon_dev() will return -EPROBE_DEFER
if the required extcon device is none. It makes the extcon consumer driver
to be simplified when getting extcon device.

- Register device after dev_set_drvdata because of accessing
the sysfs attributes at timing of between drv_set_data and device_register.

- Fix some kernel-doc comments of extcon functions.

2. update extcon provider driver
- Update extcon-intel-int3496.c
: Add support for controlling vbus power via regulator and support
to the extcon-intel-int3496.c driver to bind to devices without
an ACPi companion. And fix the minor clean-up.

- Use struct_size() helper on extcon-usbc-cros-ec.c

- Remove the disable irq operation in system sleep for using vbus/id
gpio as the wakeup source on extcon-usb-gpio.c

- Add support of SM5703 device by using existing extcon-sm5502.c
and rename i2c_devic_id from sm5703 to sm5703-muic to reduce confusion
between SM5703 MFD device and extcon device.

- Add usb role class support and add queue work sync before driver release
on extcon-ptn5150.c
----------------------------------------------------------------

Bruce Chen (1):
      extcon: usb-gpio: Remove disable irq operation in system sleep

Dan Carpenter (1):
      extcon: Fix extcon_get_extcon_dev() error handling

Gustavo A. R. Silva (1):
      extcon: usbc-cros-ec: Use struct_size() helper in kzalloc()

Hans de Goede (4):
      extcon: int3496: Make the driver a bit less verbose
      extcon: int3496: Request non-exclusive access to the ID GPIO
      extcon: int3496: Add support for binding to plain platform devices
      extcon: int3496: Add support for controlling Vbus through a regulator

Li Jun (2):
      extcon: ptn5150: Add queue work sync before driver release
      extcon: ptn5150: Add usb role class support

Markuss Broks (3):
      dt-bindings: extcon: bindings for SM5703
      extcon: sm5502: Add support for SM5703
      extcon: sm5502: Clarify SM5703's i2c device ID

Yang Li (1):
      extcon: Fix some kernel-doc comments

bumwoo lee (1):
      extcon: Modify extcon device to be created after driver data is set

 .../bindings/extcon/siliconmitus,sm5502-muic.yaml  |  5 +-
 drivers/extcon/Kconfig                             |  3 +-
 drivers/extcon/extcon-axp288.c                     |  4 +-
 drivers/extcon/extcon-intel-int3496.c              | 54 ++++++++++++++++++----
 drivers/extcon/extcon-ptn5150.c                    | 36 +++++++++++++++
 drivers/extcon/extcon-sm5502.c                     |  2 +
 drivers/extcon/extcon-usb-gpio.c                   | 15 ------
 drivers/extcon/extcon-usbc-cros-ec.c               |  2 +-
 drivers/extcon/extcon.c                            | 37 +++++++++------
 drivers/power/supply/axp288_charger.c              | 17 ++++---
 drivers/power/supply/charger-manager.c             |  7 +--
 drivers/power/supply/max8997_charger.c             |  8 ++--
 drivers/usb/dwc3/drd.c                             |  9 +---
 drivers/usb/phy/phy-omap-otg.c                     |  4 +-
 drivers/usb/typec/tcpm/fusb302.c                   |  4 +-
 include/linux/extcon.h                             |  2 +-
 16 files changed, 139 insertions(+), 70 deletions(-)
