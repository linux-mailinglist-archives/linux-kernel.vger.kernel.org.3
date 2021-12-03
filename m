Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5696C4672DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350066AbhLCHtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbhLCHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:49:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3A1C06173E;
        Thu,  2 Dec 2021 23:46:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x7so1748371pjn.0;
        Thu, 02 Dec 2021 23:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7nKduMD08DV3fy0vmQGh/TOzyzmJ2gsI6kDvzqSp2iA=;
        b=TP9iu2yeFGO+kst+ogIzPGGU1/Pdu5AMwdvWQo4MZgUhuWB2+VqiciKaOr3y8l68so
         Uh3umrLhjSbRbSKlJhSuzjIY/mpdbVouoVId5SB5+pb/vwiwzwygD/B88BXO8UqBHfCb
         HSr3wfddsslCXq0HyI3QikotvHBW5wjm9aWIwu+kosyoWJ604LE7Qw06Zb295ui94vta
         FKUm0PYnIUBCuy1ZqATn8xdPmwLad/E7LK4FJFE/ly971UPnl80vPrgpsDLKkBvJ1VVB
         fOsu2brEg8H5939KxHxlbVjJFcca1U7R7oSfC3TeFizwesGwtd7G6oR9L4HyGiKUpPHa
         oKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7nKduMD08DV3fy0vmQGh/TOzyzmJ2gsI6kDvzqSp2iA=;
        b=Gz89/Bro7y0VsfZYSkYqLVlvzV2sRycp9vMOKPDvKDqnx7A4BWaoo399DUmMugaXg0
         pD9JjCIXhwtA6a3c0QTKHkO0D0siZv4+58/n0q6JJUbZFAe26zQ2Ak4MvjPXl+mry6E1
         wTl7SUWYuvB9fRzjQNFHRzZLNn8dgNNAWVv7Og2JhOMHb6w7mkm5b502OHqnRtC3KpcP
         gQAdmD+tQSOTw1MDJkUCgyz7qJvBWY8vTcDSXGKVDtxiE86ORyIVPFgDCboAqnbuYH9i
         w5UHY6Hnk1xRhdQqyFwyPsncGss+W5feSJ2K0qZNO4sumszFEwoBNEj4MNculX2A9HVG
         hncQ==
X-Gm-Message-State: AOAM533A64JUS0N8hJLC2Dig23qF9Abk2LEvRnJD7XUDChEgb5dAr+dY
        sI4RV2bISPzgM6sMV9M4LE8=
X-Google-Smtp-Source: ABdhPJw+W03//fpB8WeAB5/yq52NF8W0wqIF6xjbNyf2KqkzAgTqtwnBbH1cLuICIRZ5vYKY15wN9Q==
X-Received: by 2002:a17:902:a40e:b0:143:ca72:be9d with SMTP id p14-20020a170902a40e00b00143ca72be9dmr21057994plq.67.1638517577344;
        Thu, 02 Dec 2021 23:46:17 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d19sm2162364pfv.199.2021.12.02.23.46.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 23:46:16 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
X-Google-Original-From: Vincent Shih <vincent.sunplus@gamil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gamil.com>
Subject: [PATCH v3 0/2] Add driver for RTC in Sunplus SP7021 Soc
Date:   Fri,  3 Dec 2021 15:46:17 +0800
Message-Id: <1638517579-10316-1-git-send-email-vincent.sunplus@gamil.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for otp driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  rtc: Add driver for RTC in Sunplus SP7021
  dt-bindings: rtc: Add Sunplus RTC json-schema

 .../bindings/rtc/sunplus,sp7021-rtc.yaml           |  56 ++++
 MAINTAINERS                                        |   7 +
 drivers/rtc/Kconfig                                |  13 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-sunplus.c                          | 362 +++++++++++++++++++++
 5 files changed, 439 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
 create mode 100644 drivers/rtc/rtc-sunplus.c

-- 
2.7.4

