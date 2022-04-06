Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF514F5CC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiDFLoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiDFLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:43:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2E83EF036;
        Wed,  6 Apr 2022 01:30:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g15-20020a17090adb0f00b001caa9a230c7so5093973pjv.5;
        Wed, 06 Apr 2022 01:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IG1tkBL/llWliJGxLdIJUi+tn1T0VL64oyH/UZUw89c=;
        b=SuqWhpwWFVJORPBYictUdK1YVpb62bflKnyxPmSDylk4t4mpsacQXP0e0bg/5JTKEC
         n/6nEYPEhb2+pvcdD6DgkxeqBPq1SdPAKkwd1xphOBd30FQvRZDm2RbCGYJf3db8BXSf
         UBMyMBB++GIO9kKUpNxoHV/EqC3AocBa/CmtomvOL6DLydOBTgYprp8bpA0iILXom5qY
         n1BQOAhvx5LqLHhtC7FOgdda3kzHsG672YGhjXKNxdORJms8ac4dxf/2e4LGsSua+MTU
         bWEGtOBIqhN86wohnIFNLwy7wYEpYDQFQF860pwQkezrTTYsjPuxUthP5Oe5mldDiR20
         BcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IG1tkBL/llWliJGxLdIJUi+tn1T0VL64oyH/UZUw89c=;
        b=m+bWw1lMPyDbM8iMH/K5Snp3VEjypF9vSYrhY/mEbKPgienyHdriAOa6Gb4XBsawbU
         SDF77tQlfOgEXIQSMKET9Ail53jJhobkxbBKWi9QxZhCt9QwZyex885PfmAoNY17SAvD
         Kt0uP7hGxXD+Qbm9Pu2aSWUukiH8MkYd+ApIYHRN/seJO4e8xE83lsCngf+yQNZUADZN
         YwvVIvJKt79ngQ1WzF6EsScSfQD/lXus743LAWin+SD+ijGBcuFuiHJ7me9DV2Bui+Ac
         nuBnOv8sgpiyqD1myztEchNNPgnmHDsNHKT4JKyQd9QHXrhlD9e2RtRYYPcTMzyQpl1d
         waaw==
X-Gm-Message-State: AOAM530TvNc/CNWOWPa0DEL/JFfIPJNbmfkvttEQKT/v2WTct1R6GHsh
        p/TshBiU+7cNCboU8esWOSU=
X-Google-Smtp-Source: ABdhPJzwpB0jmLPHgl0m4pBgOkxvpvOMrOed5iwoQGGrTg/E7fJwZG3bBoGNUAptXhObL+JcKmqcJQ==
X-Received: by 2002:a17:903:40c7:b0:156:8b56:5fa1 with SMTP id t7-20020a17090340c700b001568b565fa1mr7484133pld.108.1649233802239;
        Wed, 06 Apr 2022 01:30:02 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id r8-20020a17090a0ac800b001c9e35d3a3asm4904977pje.24.2022.04.06.01.29.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:30:01 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        krzysztof.kozlowski@linaro.org
Cc:     wells.lu@sunplus.com, lh.Kuo@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v6 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Wed,  6 Apr 2022 16:29:47 +0800
Message-Id: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for mmc driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
  mmc: Add mmc driver for Sunplus SP7021

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |   62 +
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus-mmc.c                     | 1200 ++++++++++++++++++++
 5 files changed, 1279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

-- 
2.7.4

