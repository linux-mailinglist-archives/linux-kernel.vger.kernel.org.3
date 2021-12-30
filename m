Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FD481C33
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbhL3Mvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbhL3Mvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:51:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A48C061574;
        Thu, 30 Dec 2021 04:51:40 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m1so21332918pfk.8;
        Thu, 30 Dec 2021 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lUH/gYFaNfrUlNG8flTJJtPh6Xug3m2D1z2siiVT51g=;
        b=Lc33tKWxf/h6VKKOQBzMmLXw+i3h1+nVNpxRBUgoMqrrBFcwkE5piC84WchTVN2k8H
         ebuJZK5M0ulHTV61xNdO5EV3qxpCTFun0EEa8FN5u+cE48EAyY7t1s013S5QMQ8x74mv
         J8W67RCLP8GSVgURnX+H9M7HUWVeMlwc1GYQlqapC8VmJu7PXmNl9KHqzUHrfUshJsap
         5fq+I3tc1+u6c7jc1O7nxvzDfgnRlSzzsrm94OFQVlxtQI2SFQi2YXjGd2uesm5EojEC
         SkWyTBtBYqDoY+LLaWjkjreWnHPnMHo3UFgJKtlQaK++N+ohrp6Tqy0Sb5gWh3bb5zg6
         FKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUH/gYFaNfrUlNG8flTJJtPh6Xug3m2D1z2siiVT51g=;
        b=Wm4JV63us9HtJKkPTl14EojAJcIfZv0+LxyvO1XhxchTHrQLE5VFT/7gg1S/2C5fbC
         2+RJNqEo0TN8MXr0++ZXf+SdmCcriB1sB5UVJ8217OEOv9S1Tb3JN0/e08DfSt25mVt4
         Xk8BVXsOFRJ32JybhGCqTXSOoE7QbU/2Uwb0+nsVWowMVPdu+52GaSFAuRtJme2Bvv1t
         xy2Ei4ms717bul6ZP/schTrT6S4dqmtfN4PUcpZCZK0N9Po6me+jeKt9IYDbgpp9l0jI
         7ldWj4N0R0+RvBT6V/suMwovDpkBV9bZ3IOE1CkCE83SiIWObdIRjRc5jyVoPMCBbzJ+
         3Pnw==
X-Gm-Message-State: AOAM533h5O9KN16dRA9Q9ANAz6IU0NU6cj9wKovgO9NRc5v7dWqnwFm4
        Ws9EdLytniwTN9K4on3VceBFCiACqNI=
X-Google-Smtp-Source: ABdhPJxzVOG5gMxCk0Hi3KD9Zk5P61pss+dvf95G/g+R8alNUab50Nr5Ptyf54fWZ55PyGm9x271WA==
X-Received: by 2002:a62:5485:0:b0:4ba:9ed6:f7e0 with SMTP id i127-20020a625485000000b004ba9ed6f7e0mr31748449pfb.30.1640868700490;
        Thu, 30 Dec 2021 04:51:40 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id e12sm19217864pjs.35.2021.12.30.04.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Dec 2021 04:51:40 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v6 0/2] Add iop driver for Sunplus SP7021
Date:   Thu, 30 Dec 2021 20:51:43 +0800
Message-Id: <cover.1640836400.git.tonyhuang.sunplus@gmail.com>
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

 Documentation/ABI/testing/sysfs-platform-soc@B     |  25 ++
 .../devicetree/bindings/misc/sunplus-iop.yaml      |  76 ++++
 MAINTAINERS                                        |   7 +
 drivers/misc/Kconfig                               |  12 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/sunplus_iop.c                         | 476 +++++++++++++++++++++
 6 files changed, 597 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/sunplus_iop.c

-- 
2.7.4

