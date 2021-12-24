Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3A47ED44
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352014AbhLXIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbhLXIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:35:51 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA1C061401;
        Fri, 24 Dec 2021 00:35:51 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b22so7291827pfb.5;
        Fri, 24 Dec 2021 00:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Q0s6vEhYPni3ZRuwTfnqiKwhOJM/FgaKAskJfPLhSWg=;
        b=Dw9x/Ui0F8lnEovPS8AcmC3aJ1LySSdQmQT/d8HUmfSJEDM++cOH+Z9kew59CsDowo
         NIHsB7neu+4snH5kOSLkWB22w0AOZYJa3Q6VerS5GhHmCmsnj3Cm3TY1ZYlqJeIrLwd7
         pB1k8IfXpU0tLNzG7E6+Y+I4C9jalYXV0jc24JfrWGyTde2um8NctxHSSVnll6KAvnVI
         DMBHmZfgMx0ScUTHIb3Jssng+fG8PAIvXF2llc53ugTg7XLYtXmALVYIaKFhxI2qkwd7
         3fRIaFLDX58PpNleJN2eVYdPy+1gLhRsRiJ9Di/E3dHZA1MAkulU4NKWaaTz9WsW+dti
         Ymkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q0s6vEhYPni3ZRuwTfnqiKwhOJM/FgaKAskJfPLhSWg=;
        b=jsSZ6oK1jmcroPfUsam6iXkOI3hOqzBmy2FRa2mcOpkXXN3Q5/DX4aw9Ftmu4s63Bv
         H92C62EBVPqejJG+ExMb2RQ2GLYq8iy47i03rLyGEJtJ4b3PlGLncQJZuhXeuEdN+1Mh
         Jxi1HsAS4PRrLOET0QDRc5uf2LDzkgfdSBLZRi6wmQTy2Df552VKF6eFtTW2eyjfKIKZ
         N7rb8ZsS92g7M9iYf/mNM1IuAso3if/TyXXwv2ZOYs5ub3Osy5EJ86L6gGwdSf1ojvrd
         pARq5+T/h7kUnphGzvKqAXmarE0eaAlGqTI0mfvs85o4fR9p4reEtK1VOcSSRcVD6Mar
         uEsA==
X-Gm-Message-State: AOAM5323COnwvzCM0VZ3g653MO5kX+7b+0Yqu50YFF8fKfg6I4yNniBF
        Vi8m0EERUpu70l9Slt/OxO0=
X-Google-Smtp-Source: ABdhPJy6+ZdJfAEaUfT9Vv6p+f0te/8gWVwHfEAYCx/cXn4WYbjeQXQKOW9gjvfCbhLgNsGNSxemdA==
X-Received: by 2002:a63:565d:: with SMTP id g29mr5246540pgm.245.1640334950933;
        Fri, 24 Dec 2021 00:35:50 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 190sm7916293pfe.190.2021.12.24.00.35.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Dec 2021 00:35:50 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v5 0/2] Add iop driver for Sunplus SP7021
Date:   Fri, 24 Dec 2021 16:35:54 +0800
Message-Id: <cover.1640332430.git.tonyhuang.sunplus@gmail.com>
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

 Documentation/ABI/testing/sysfs-platform-soc@B     |  18 +
 .../devicetree/bindings/misc/sunplus-iop.yaml      |  72 +++
 MAINTAINERS                                        |   7 +
 drivers/misc/Kconfig                               |  12 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/sunplus_iop.c                         | 481 +++++++++++++++++++++
 6 files changed, 591 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/sunplus_iop.c

-- 
2.7.4

