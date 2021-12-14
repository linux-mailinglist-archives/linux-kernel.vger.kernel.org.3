Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1784740E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhLNKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhLNKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:53:45 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBBBC061574;
        Tue, 14 Dec 2021 02:53:45 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id l18so12328295pgj.9;
        Tue, 14 Dec 2021 02:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=s32Q5IxQslkiM+08lVnILc8RgiNSWpcCVbn4fLntZlo=;
        b=VczYifIIXTXrO2Mj9p4p9xjhD7B4LTnR3XCyA2IlkXG/RIAcL6rE6kGg+tpt0KRtQp
         MIeqPQFcM41Zaf1s5UvC6S9EuAH01Q0jJr2bUvvOmpT6/mGrPUdtqekpwZ0tlGEEzmB0
         H7dBwbt44svRkgsx3zJnGQa6Ldeb4S/rzZs+BznWsWPuzxXywPKUwgOoj/l68N67R/qn
         Rwb2uel63ldvI06zvpv+LHffBPCRvcqZLQJo6I6MEOQ5wZ6z/iOwJKrhXut45tVN3cP5
         CzzH9jmfCtFWy+WKhTOhFVCY0WsNSiC6vqizts1A7K+m3sroGtJptA0D4kGMvlZuI5i2
         s5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s32Q5IxQslkiM+08lVnILc8RgiNSWpcCVbn4fLntZlo=;
        b=R18QpiZR0RJaueInz7u/KZjqeZeEPMdAf3wv70QNme2XPHgUL8Gx2ULR9jz9sX6RPM
         QFWg371+v9yialFZ8lBTLPLlyRoIT8s+t4+gzTHV8vwzTryVlVXVgIpTLAJyXoL6YYl7
         M4WawyQ9AppEdC2THNosrd6fyULY0gzmKWx3HlgDA2W5SQ7IiAaUg7/ueEO042jaTNz9
         b9dpSNUKCuo7wrDn+AXYSzQBswLinOTYQucZbPWLJJaDPQxlMZyhYDB1qVZ/pDJBVy3D
         LPdC002FELe3Bcv8tiaHs35OBAAWNj0/nCKZOQoCHRM0ztV41Q5/fM7Hwm4SSwYXldfm
         0Ziw==
X-Gm-Message-State: AOAM531S916N80zWHsVkbhbbvdwpbeaHLJmz0Mb+k2WhMxAiF/rVUDp9
        B/2n5S0E4O6pxHXsaBmYqWQ=
X-Google-Smtp-Source: ABdhPJyq9SkW6BEPLk09UF9FveUWuMs/rwg1ox02zqj1R7qTnQMBuNYlSIVAPfwYcGyGXWSedbVDZw==
X-Received: by 2002:a63:f706:: with SMTP id x6mr3205694pgh.69.1639479225077;
        Tue, 14 Dec 2021 02:53:45 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id mm22sm2109303pjb.28.2021.12.14.02.53.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Dec 2021 02:53:44 -0800 (PST)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     wells.lu@sunplus.com, dvorkin@tibbo.com,
        Wells Lu <wellslutw@gmail.com>
Subject: [PATCH v4 0/2] This is a patch series for pinctrl driver of Sunplus SP7021 SoC.
Date:   Tue, 14 Dec 2021 18:53:07 +0800
Message-Id: <1639479189-6693-1-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control
applications.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Wells Lu (2):
  dt-bindings: pinctrl: Add dt-bindings for Sunplus SP7021
  pinctrl: Add driver for Sunplus SP7021

 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   |  375 ++++++
 MAINTAINERS                                        |   10 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/sunplus/Kconfig                    |   21 +
 drivers/pinctrl/sunplus/Makefile                   |    5 +
 drivers/pinctrl/sunplus/sppctl.c                   | 1192 ++++++++++++++++++++
 drivers/pinctrl/sunplus/sppctl.h                   |  167 +++
 drivers/pinctrl/sunplus/sppctl_sp7021.c            |  536 +++++++++
 include/dt-bindings/pinctrl/sppctl-sp7021.h        |  173 +++
 include/dt-bindings/pinctrl/sppctl.h               |   40 +
 11 files changed, 2521 insertions(+)
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

