Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D3B489040
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiAJGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiAJGhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:37:45 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C869C06173F;
        Sun,  9 Jan 2022 22:37:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 78so1802115pfu.10;
        Sun, 09 Jan 2022 22:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=n+Xt119nclbKTZTUCo0KmGod6sDqgTVDGGiBHOo0XFg=;
        b=c0YhKUoXnxgtkAsaXd1prtJGhk6kjoFGHZGZwLw0bXrPvzZKe08lGOJpKwYFpn4kQ+
         ZaOmwl5qj0GocDwccEVca83q23bX0YRRTJVuRZvvi1Em63feCuGcTvZpYtU0Imz7HMw2
         undDiUGdwQzafIagok5KaBMsKRNSymmt1I1oF/m5HHltxeQMwWNglim5y3uQx/3SWU3Q
         fZSlDD20eMucG3A4PqfYiJlBzOLoE3SjpOsvhl2DnwmsrCxn/mg0vLVfUqGPEhNO6U/c
         nZKXlhLoWce9KSyeDJ2EOrzJGbt7MOZqeWEIv5A+Lb0E6k5uSp+0HE0EXwrdHNJ9fwMz
         jP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n+Xt119nclbKTZTUCo0KmGod6sDqgTVDGGiBHOo0XFg=;
        b=yq9W0zvl2Wj8wSRyIKVnKeiO0L9GAedm9EFAdvasGQprNqeILJUaB3NILzCkC7greQ
         N+woRRuD3J8EbtEo22o0uRlAfKVliWucjRgwhfXETibKxRP8vJKwrH/PSPaFGHbY3YSN
         PdgBZoOaCKCVDtd3HMe1fUSCTz20VXxhtFSNRYSKlkQKCzfotlK+etxhQfhh0kj+kgy3
         lQNU8WJSWoLEy8auHUSAHHsDT3GHVTVSc6yCkQ4a+f/11Xm9uRtLzSopmW2usPBuNd7M
         KhWMs7bU+1CMPHbmnmNgrYXb5t3OjDF5u4yi7/tWKpFYKQG+lV2Js0+0P6jglynTJ6yw
         yruQ==
X-Gm-Message-State: AOAM531X/67Eo9UzQAklynf5nglnhAkJXN0gNIS8wjb9o6qVxr1FFnU0
        0iFdFMV2EN/Rw6oZK03Q2ks=
X-Google-Smtp-Source: ABdhPJyeWXY0Pna+390rMULlU8igcYGwhUuiKAA8IlSA71Y5LjAioNgvvCTw+Sy3Mls90slzBGxK+Q==
X-Received: by 2002:a63:b00c:: with SMTP id h12mr8827376pgf.80.1641796664878;
        Sun, 09 Jan 2022 22:37:44 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id ne14sm1977081pjb.19.2022.01.09.22.37.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 22:37:44 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kerenl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v7 0/2] Add iop driver for Sunplus SP7021
Date:   Mon, 10 Jan 2022 14:37:52 +0800
Message-Id: <cover.1641794532.git.tonyhuang.sunplus@gmail.com>
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

 Documentation/ABI/testing/sysfs-platform-soc@B     |  28 ++
 .../devicetree/bindings/misc/sunplus-iop.yaml      |  76 ++++
 MAINTAINERS                                        |   7 +
 drivers/misc/sunplus_iop.c                         | 455 +++++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/sunplus_iop.c

-- 
2.7.4

