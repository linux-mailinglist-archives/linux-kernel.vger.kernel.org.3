Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E38D52A9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351839AbiEQSE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351793AbiEQSDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:03:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BD450B0C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y199so891197pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=3k1XYZP0dzVDxZkY62+h79ANhAsv+k7jVaYxybWAuMc=;
        b=CHC6Fd6VRIUxVC58PeX8M9k4R0VONb89oLq074LAsU3Eu2mhN88zfczxI7Klpdnv9H
         TJASDBICJctHkLolJdjbRJJIqrB/C8oAYJZd4UD7cvQNZaUHrL8riDjwrcJfyZYtYtD5
         4eXleD/vxrx8Ea3HRhtIiYVcs9DxKt7uClbC5CG7hl4aPpLURlBykQr6XlnXoiBzPrzh
         4qOxJWRXWQ7As4KcgEkvYYKtL/KnENh5mqhpWlAfW3IS/4s5Y+ljQwV76GBHSWCfMD1A
         5mJkf3OxSsMn5Uc7yfOmnMtBcifqhMfSIOnzIRg/cEXam5D+jA2iByF8szNs1CbwkQ09
         tPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=3k1XYZP0dzVDxZkY62+h79ANhAsv+k7jVaYxybWAuMc=;
        b=Hl25Nnh5/mqyyFXc/JaUz4ToEEXbsOjH63ZOtayyEOloXx6gtuVDH6zIBORe4qHeRN
         ngq1YojBCcpkaFOHeYovCsV5FsgS8wwdH22n0CX3CmgqWo+nnBhX6Dm3og7V8C3A2Z+A
         Ybd69V9KohKRaQowRC7tkXT/qkpp+/jFHavUDBpIGliYJj9uT+M1X6YKRtufjKDsGVv/
         xp1bPWT1f9riyj67qj0SB7hPPG9XUm02Avhpb4598TO8JCZzVnmmHa3wAjixtMkLq8zy
         RRaUwN9CMlH/GSeUEzwQZoNvxz9Yn4DFbI4NpWfUxahhbGGjX5NXiboCtJRmd4nkL7HJ
         jk+g==
X-Gm-Message-State: AOAM5307wiZu/f79i2MAWCxEgfyRXr+o5o513kYy/dJ22v6nL5j8dlJ+
        sjlJVGTWzrLXVppQP1xu9e0=
X-Google-Smtp-Source: ABdhPJzqHAT7j6hbbCbTvFnerANQRwJKz1H7/mcoQIti5s5aKToCURZZQcvTmS5l3S3JkjCULtgN+g==
X-Received: by 2002:a63:d244:0:b0:3f2:5897:99c7 with SMTP id t4-20020a63d244000000b003f2589799c7mr12008070pgi.533.1652810628813;
        Tue, 17 May 2022 11:03:48 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id f1-20020aa79d81000000b0050dc76281b9sm19316pfq.147.2022.05.17.11.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 11:03:48 -0700 (PDT)
Message-ID: <3aa73483-19d6-fc25-a3c6-03343582b542@gmail.com>
Date:   Wed, 18 May 2022 03:03:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [GIT PULL] extcon next for 5.19
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
References: <eaab9f4d-06d4-3ddc-3756-69f762bd86e1@gmail.com>
In-Reply-To: <eaab9f4d-06d4-3ddc-3756-69f762bd86e1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

Gently ping. Could you please pull this request?

Best Regards,
Chanwoo Choi

On 22. 5. 13. 18:09, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.19. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:
> 
>   Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.19
> 
> for you to fetch changes up to 5dcc2afe716d69f5112ce035cb14f007461ff189:
> 
>   extcon: Modify extcon device to be created after driver data is set (2022-05-13 17:03:41 +0900)
> 
> ----------------------------------------------------------------
> Update extcon next for v5.19
> 
> Detailed description for this pull request:
> 1. update extcon core driver
> - extcon_get_extcon_dev() has been almost used to get the extcon device
> on booting time. If extcon provider driver is probed at late time,
> the extcon consumer driver get the -EPROBE_DEFER return value.
> It requires the inefficient handling code of -EPROBE_DEFER.
> Instead, extcon_get_extcon_dev() will return -EPROBE_DEFER
> if the required extcon device is none. It makes the extcon consumer driver
> to be simplified when getting extcon device.
> 
> - Register device after dev_set_drvdata because of accessing
> the sysfs attributes at timing of between drv_set_data and device_register.
> 
> - Fix some kernel-doc comments of extcon functions.
> 
> 2. update extcon provider driver
> - Update extcon-intel-int3496.c
> : Add support for controlling vbus power via regulator and support
> to the extcon-intel-int3496.c driver to bind to devices without
> an ACPi companion. And fix the minor clean-up.
> 
> - Use struct_size() helper on extcon-usbc-cros-ec.c
> 
> - Remove the disable irq operation in system sleep for using vbus/id
> gpio as the wakeup source on extcon-usb-gpio.c
> 
> - Add support of SM5703 device by using existing extcon-sm5502.c
> and rename i2c_devic_id from sm5703 to sm5703-muic to reduce confusion
> between SM5703 MFD device and extcon device.
> 
> - Add usb role class support and add queue work sync before driver release
> on extcon-ptn5150.c
> ----------------------------------------------------------------
> 
> Bruce Chen (1):
>       extcon: usb-gpio: Remove disable irq operation in system sleep
> 
> Dan Carpenter (1):
>       extcon: Fix extcon_get_extcon_dev() error handling
> 
> Gustavo A. R. Silva (1):
>       extcon: usbc-cros-ec: Use struct_size() helper in kzalloc()
> 
> Hans de Goede (4):
>       extcon: int3496: Make the driver a bit less verbose
>       extcon: int3496: Request non-exclusive access to the ID GPIO
>       extcon: int3496: Add support for binding to plain platform devices
>       extcon: int3496: Add support for controlling Vbus through a regulator
> 
> Li Jun (2):
>       extcon: ptn5150: Add queue work sync before driver release
>       extcon: ptn5150: Add usb role class support
> 
> Markuss Broks (3):
>       dt-bindings: extcon: bindings for SM5703
>       extcon: sm5502: Add support for SM5703
>       extcon: sm5502: Clarify SM5703's i2c device ID
> 
> Yang Li (1):
>       extcon: Fix some kernel-doc comments
> 
> bumwoo lee (1):
>       extcon: Modify extcon device to be created after driver data is set
> 
>  .../bindings/extcon/siliconmitus,sm5502-muic.yaml  |  5 +-
>  drivers/extcon/Kconfig                             |  3 +-
>  drivers/extcon/extcon-axp288.c                     |  4 +-
>  drivers/extcon/extcon-intel-int3496.c              | 54 ++++++++++++++++++----
>  drivers/extcon/extcon-ptn5150.c                    | 36 +++++++++++++++
>  drivers/extcon/extcon-sm5502.c                     |  2 +
>  drivers/extcon/extcon-usb-gpio.c                   | 15 ------
>  drivers/extcon/extcon-usbc-cros-ec.c               |  2 +-
>  drivers/extcon/extcon.c                            | 37 +++++++++------
>  drivers/power/supply/axp288_charger.c              | 17 ++++---
>  drivers/power/supply/charger-manager.c             |  7 +--
>  drivers/power/supply/max8997_charger.c             |  8 ++--
>  drivers/usb/dwc3/drd.c                             |  9 +---
>  drivers/usb/phy/phy-omap-otg.c                     |  4 +-
>  drivers/usb/typec/tcpm/fusb302.c                   |  4 +-
>  include/linux/extcon.h                             |  2 +-
>  16 files changed, 139 insertions(+), 70 deletions(-)


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
