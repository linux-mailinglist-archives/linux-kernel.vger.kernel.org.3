Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B89478A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhLQLqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhLQLqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:46:04 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E998C061574;
        Fri, 17 Dec 2021 03:46:04 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i12so2043582pfd.6;
        Fri, 17 Dec 2021 03:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8ZHXgOV9TX8kkOHJmLPET1ya9Gi9y6zhvt5HHsCbUbA=;
        b=Ycoot6TeiCqcDLhdcDzDbfQvvGGQ9KkTZwBQSSR3Ycj5wIryrp49nG3xZimWDxcVWC
         P/ckS0Vpi0Id/j6b+BHDDdqJtWgN7HVeADWKcR1jYYF9IeOdy/jcT/DPiouQOZW/qPPL
         s07wE31SxcgEnabVYeqiJK/E3XcVWMqTk3WrTG1vnlU5PhN5dyMGhMd6TS+GWHZMnWi9
         odFkjmoFAJywzGo5v8hBTw8GaGcxilQHXBoZqwTy3OqYtxXHbGsjdPIaJ7eduY8uyaiW
         DW9Hhm/g5BfiEpkG2bTkAPahj6Zr62JKdmda/X3KZ96M2BF9gjyh0QU2xCqJdu1usH5g
         BNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8ZHXgOV9TX8kkOHJmLPET1ya9Gi9y6zhvt5HHsCbUbA=;
        b=dckZ0sv1Sbqz2xIEmVdWJZyGTayDbEdddobd73ZH9/iCATESUxQ8dtlN1/AKiwfoIi
         Ug3QSx2Q2iEPTZxQNoX6HOZzFjZSOye67ONM7Yk5tg20rmxENtyoS34qkH92J+1DGqSH
         3WmqMta9GtFkk5cbn9wEOLK0XRZOQjupFn72OPfwaEtPfem4xJ6uyweesTDMaVjgvQuD
         GmBNrh6t440iXnbxsmKHwEak/ResCnFKyjlBW/kktUquxsYZgmnl4FvVKWcbfD+iweYR
         ONnHtxnUjpbLCYnlOKly2D4IiTSCxBY3FKjpU67e/DBGVFVIyXKjya92RdW2Qj+Js0+d
         vNbw==
X-Gm-Message-State: AOAM5328BjpIyZQFfB3Qpg1O3ibRPR46xg8HYF1xSgSZXPZz07cW0a2/
        ecg4p1av53eTUDkz7nCxSPMEUqhOXe7vLA==
X-Google-Smtp-Source: ABdhPJxwfXe821zzld2YYMcFxRypGCq4dJNjNlMtV/aieIMnA/Q3Af/+r9ophvUsX0ayCH/hJb+3nQ==
X-Received: by 2002:a63:4913:: with SMTP id w19mr2507292pga.437.1639741563982;
        Fri, 17 Dec 2021 03:46:03 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id kb1sm1663225pjb.56.2021.12.17.03.46.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:46:03 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v1 0/2] Add PWM driver for Suplus SP7021 SoC
Date:   Fri, 17 Dec 2021 19:46:06 +0800
Message-Id: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for PWM driver for Suplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Hammer Hsieh (2):
  dt-bindings:pwm:Add bindings doc for Sunplus SoC PWM Driver
  pwm:sunplus-pwm:Add Sunplus SoC PWM Driver

 .../devicetree/bindings/pwm/pwm-sunplus.yaml       |  45 +++++
 MAINTAINERS                                        |   6 +
 drivers/pwm/Kconfig                                |  11 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sunplus.c                          | 192 +++++++++++++++++++++
 5 files changed, 255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
 create mode 100644 drivers/pwm/pwm-sunplus.c

-- 
2.7.4

