Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E2048FD82
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiAPOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 09:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiAPOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 09:52:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE80C061574;
        Sun, 16 Jan 2022 06:52:09 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n16-20020a17090a091000b001b46196d572so4832201pjn.5;
        Sun, 16 Jan 2022 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=EEt7pLzuIu/Sp0KbJg8uVNz6qkjzbmWBhc8NGaSPNXk=;
        b=ZiOmSNivAR/JOJEok8dX9rBW+HwxtxWWQHYjWyISTAN25U7Gqs1DKO/0683u8dK1sO
         RX3OQA5YUEZkCKjgDMApCpcMKjordG5Hbsnu5ltoZoZ4DC1eI0agmkoxSmln6FIksUow
         fhwrXdD7downTBerYPpvVGurQvbTnnHzmiKbS4rvzWiWLY+w6HyeD3AXd4ppDhnErM5L
         eV6/lTfpw5nXOcbyIhMTdLR96rMB55TCSoDZ9bfXFJcd9RS+BAukS6djvfJavvXIGiLz
         dgkQxtD05dH5cqWzXkbyAt9+lXFa0CIcvH7Jy1YCowXnD+h3bE8AEzDQVW9aS1OuAgbC
         Abnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EEt7pLzuIu/Sp0KbJg8uVNz6qkjzbmWBhc8NGaSPNXk=;
        b=0/3u9Y5d7G4QF4gziA7kco+hvNs8g5NyLIejWYzGeFAjitQ33G/FE3k5syIIjGj3x7
         Bu67Oh8xnMz5Amv3EDYXYytTcFpOG2Gg019Kg2qJeoet157wGWutP/V2b+EIFU8vZhwi
         kZzWXKsqM+6ERTWzfxGdMJNSdNoTwl8FCFMAln9zJkqkqaS9YudqzmPBZbIcKSO0UPdJ
         dLgyPGt0LEP2oesKdGiCwnTIkUKjWIqxAeCKuN5wwYjLp55ICWGvXKozcDmzsVVfk04I
         +uKuHZf3v1FmO7lcrHdZ0FJkqKEevRbJgzE9PtA4xs/UY2K7zdunqon0l6m931kfKSom
         LTeA==
X-Gm-Message-State: AOAM532AsMbWjYRZfT/XphlfDOBYgW7hM5uinHr9rVkYwk1YkqXkk8kM
        L3dVykcROZpJ7svNB5CBjTk=
X-Google-Smtp-Source: ABdhPJzd3W5ByxzusgeINTsO8jEwpVtLTJ5tCr+RJtsPgAG/2WFMkAwgnjf9ZZRPCdvrTEMpreCegA==
X-Received: by 2002:a17:903:1211:b0:149:9809:77be with SMTP id l17-20020a170903121100b00149980977bemr17919184plh.133.1642344729013;
        Sun, 16 Jan 2022 06:52:09 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id j22sm11349891pfj.102.2022.01.16.06.52.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 06:52:08 -0800 (PST)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     wells.lu@sunplus.com, dvorkin@tibbo.com,
        Wells Lu <wellslutw@gmail.com>
Subject: [PATCH v6 0/2] This is a patch series for pinctrl driver of Sunplus SP7021 SoC.
Date:   Sun, 16 Jan 2022 22:52:12 +0800
Message-Id: <1642344734-27229-1-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control
applications.

Refer to:
https://sunplus.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Wells Lu (2):
  dt-bindings: pinctrl: Add dt-bindings for Sunplus SP7021
  pinctrl: Add driver for Sunplus SP7021

 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   |  374 +++++++
 MAINTAINERS                                        |   10 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/sunplus/Kconfig                    |   22 +
 drivers/pinctrl/sunplus/Makefile                   |    6 +
 drivers/pinctrl/sunplus/sppctl.c                   | 1118 ++++++++++++++++++++
 drivers/pinctrl/sunplus/sppctl.h                   |  170 +++
 drivers/pinctrl/sunplus/sppctl_sp7021.c            |  583 ++++++++++
 include/dt-bindings/pinctrl/sppctl-sp7021.h        |  179 ++++
 include/dt-bindings/pinctrl/sppctl.h               |   31 +
 11 files changed, 2495 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
 create mode 100644 drivers/pinctrl/sunplus/Kconfig
 create mode 100644 drivers/pinctrl/sunplus/Makefile
 create mode 100644 drivers/pinctrl/sunplus/sppctl.c
 create mode 100644 drivers/pinctrl/sunplus/sppctl.h
 create mode 100644 drivers/pinctrl/sunplus/sppctl_sp7021.c
 create mode 100644 include/dt-bindings/pinctrl/sppctl-sp7021.h
 create mode 100644 include/dt-bindings/pinctrl/sppctl.h

-- 
2.7.4

