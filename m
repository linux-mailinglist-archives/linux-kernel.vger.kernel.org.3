Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F15142CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354872AbiD2HEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354849AbiD2HEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:04:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BE8B822D;
        Fri, 29 Apr 2022 00:01:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b12so6387964plg.4;
        Fri, 29 Apr 2022 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=pdWoFntDmNAHiZiZCTeweiYZFMR7Piu/j2Z6JLXwGIo=;
        b=XMp1maNaXEMUzDVgoJXO5QV1/Y9cuqyrVs5g1scvVf/4lItiPZhGIE2WoegQ2TBEn+
         rh17aJdmIpxrIiAv7E61hpXe/5byYW4N759aAH8F+Uz3PlQLFJlz0sinLZ8mTxZXFUhW
         rpT4vunau3AI2zXerYrnav87JSq6FVYGPtAzeqH4iK/eIOBibY98utzJIJSe68DIUMno
         Uzbo9492bwFZGDNe81zZJ28dLZCNZSIADY0GWxSR2NvsJNSC4RHAQhQXy2ZeFTr5fEz7
         TGo1m/FtaoRaVa2PJckAUDbWAFXoY7AvPAPwwopDl7O28aUsyBQG1yP3fd4/yfzyljoW
         ZHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pdWoFntDmNAHiZiZCTeweiYZFMR7Piu/j2Z6JLXwGIo=;
        b=O2RxudCPsf3vQegfhGtSYFX8HJrk1SdIMsFsQ/YTQQRC1B9A8kjBgbZ439fil+b+bK
         x3pdIKdpFajudFhcgs3qL3tvvQBn37bHFN43wv/Fl6KnE+zWwZnzPZmvUIgG/IcyT76k
         GGNbp9/S1nDbhab8s1XLOV1l8Jt9Kx0H8WMetoZJEXfSwMLwNBnmbrSCkokMjXcEwinI
         00lkXsT986S/RR5Kz/KC/ngm1Gt2XkcT+p/TIaJVUoA9lmaLjsx3fifwVgW155TI+rIk
         roEKSYod9YFxobN2fKOcASB5+byXbX/39qjtixObRLan9u7FqUt6nb2dH2l53umok+rs
         le6A==
X-Gm-Message-State: AOAM533DqD4en00ogqwmuFkixnuX2ed57hZbmsPXqyV/hEKBE4p/0/gi
        24Evq0wD2Kj3FyrjFy9s6XQ=
X-Google-Smtp-Source: ABdhPJzSQNNalj5Kwle6Zs5nq6sHji8rfSG7vF8HuA8c7RxvTqs9azRIClEYnYwIfM9f7uyoZGexAg==
X-Received: by 2002:a17:902:da85:b0:15d:3a9a:aad1 with SMTP id j5-20020a170902da8500b0015d3a9aaad1mr15976961plx.113.1651215695438;
        Fri, 29 Apr 2022 00:01:35 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id iy19-20020a17090b16d300b001cd4989fee6sm13148106pjb.50.2022.04.29.00.01.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Apr 2022 00:01:34 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v2 0/2] Add USB2.0 phy driver for Sunplus SP7021
Date:   Fri, 29 Apr 2022 15:00:54 +0800
Message-Id: <1651215656-19024-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for USB2.0 phy driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Coretex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  phy: usb: Add USB2.0 phy driver for Sunplus SP7021
  dt-bindings: phy: Add bindings doc for Sunplus USB2 PHY driver

 .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      |  73 +++++
 MAINTAINERS                                        |   9 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/sunplus/Kconfig                        |  13 +
 drivers/phy/sunplus/Makefile                       |   2 +
 drivers/phy/sunplus/phy-sunplus-usb2.c             | 296 +++++++++++++++++++++
 7 files changed, 395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
 create mode 100644 drivers/phy/sunplus/Kconfig
 create mode 100644 drivers/phy/sunplus/Makefile
 create mode 100644 drivers/phy/sunplus/phy-sunplus-usb2.c

-- 
2.7.4

