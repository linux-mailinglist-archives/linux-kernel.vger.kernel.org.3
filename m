Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118F6476828
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhLPCe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhLPCe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:34:58 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9E7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:34:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id r34-20020a17090a43a500b001b0f0837ce8so1046647pjg.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ny74sKKlGn4y/2GVgIq/cp/05igibt9sBbFc0LAH/Jc=;
        b=W5JFHqZLf0g3m3gd7KVLeuv0Vu7JlNniLTegZQ3P0157hiuYL+B1VTqWyMFZItBT06
         1s5g0GwcHBsOcToepseoWmFVWxFyvsHZO9QY5KU0ro0Nytv4ULuD+S1K7fr04VNI9G59
         4wB3DWkbsaZL3hGwupVv7Q6t5XyNv/j++3ERooGC8/8Jwu5bIcT5D+AftwCZLAPOu14j
         cMfN4qISi6ieDvSMv6rGwx3lmm3bZSLc2im+E8fufws7UHcSfGfPt1K/aR1frRGgEpUV
         LDiyZiZpgmhMFlu00RaBXtvxEvetyP7cVtx232p0+uzUEkrcZ7xVGKmRJG5JiHalHHvi
         I69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ny74sKKlGn4y/2GVgIq/cp/05igibt9sBbFc0LAH/Jc=;
        b=77KkyYiFgGsS7m0mIIgHS2md1sWRu1Sa9wbQApR9nihr7HT5FKlKl6Z9lMrKGe8nsb
         mg1TmnFQxlacSQ5zYqslbWgF+ESLWFCnqNHwZ6M/lEwfilraB/8/OxVfLm5FxEjcK6n0
         c6ZgcVfLzXbRdYTypFAeDZgDCGoMHds/JdlQrSHTQPA1zqT2kcLU3Hp7A4XCp2GunNe1
         0Lpc4AdmCc2Kz5tAhnjoCOdGBCs/91Y+JCZWeJL+O6ZXSvrOUVNf3m5swle+xq2B9E/x
         hQxq/WYudxpAffBnYwpfqjgHmQPqibhwTYnb5E8wt/s4du3EWWWjKoNukzKZqpCl1JQ2
         2fqQ==
X-Gm-Message-State: AOAM532/A1kcVdAWWFXYcn1fyp+hOJylkiUcctFqyX30WfNdiSKShrz+
        21CEa9AroaTfrsOt7gzz+ol1idcvYUE=
X-Google-Smtp-Source: ABdhPJyIl2pbuvFUvoMHL+jsqPZGSTx/jGUV2bf24ek7mEkqYhZl1OsgC4mHPLTlssnILFd517AfuQ==
X-Received: by 2002:a17:902:b197:b0:148:a2e8:2c59 with SMTP id s23-20020a170902b19700b00148a2e82c59mr7353742plr.168.1639622097375;
        Wed, 15 Dec 2021 18:34:57 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d23sm3580932pgm.37.2021.12.15.18.34.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Dec 2021 18:34:56 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v4 0/2] Add iop driver for Sunplus SP7021
Date:   Thu, 16 Dec 2021 10:34:58 +0800
Message-Id: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop driver for Sunplus SP7021 SOC

This is a patch series for iop driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: misc: Add iop yaml file for Sunplus SP7021
  misc: Add iop driver for Sunplus SP7021

 Documentation/ABI/testing/sysfs-platform-soc@B     |  22 +
 .../devicetree/bindings/misc/sunplus-iop.yaml      |  65 +++
 MAINTAINERS                                        |   7 +
 drivers/misc/Kconfig                               |  12 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/sunplus_iop.c                         | 496 +++++++++++++++++++++
 6 files changed, 603 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/sunplus_iop.c

-- 
2.7.4

