Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AF5487176
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiAGDwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiAGDwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:52:04 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB10BC061245;
        Thu,  6 Jan 2022 19:52:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l15so3916699pls.7;
        Thu, 06 Jan 2022 19:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeJKwvibLAZx+Ooa1fsa6gavzzajmlPyHtN598WeKPM=;
        b=Hw2dsIRdW3XAqMZDonhzG3UOkWSvEwQaRh5BDuD3kz0nlLlmzytNch5Uv70hH9vLKF
         zRZn+//sfL77gT8lIZy8y1SD+dfQkWW1TuWabpe43pJjGzECgAtTLuiXWFLo21yvyBQw
         HJtWrXqpW4VwYsm0u/pJKzdLkpyHnfiElFPdGIC5rVOYbzSymW5eIPboHjwHoK71mNes
         79UKKKvO2KSdB0XhcjMS12DGNCfP0/0BHyKBgj8NIrez+Anrl+Jgm0nh4nUA5MgO2s6d
         SEr81Ub2QbBkLO8xBZrt6kr3+h+dmJHBpSoex0ljjws5Zv7Bai7JiRYU8pEZhJDO14Qr
         4QTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeJKwvibLAZx+Ooa1fsa6gavzzajmlPyHtN598WeKPM=;
        b=snebyFYDEt+rTznmp/A+DaZGHNKfKxfNcuXtsKnHPjSyMPNC2iNQjeySrZqus3duc8
         CUtsmL6zS+BNYWLje/4tx5GYIsTuCvHA9jw7W2Gn75fs1ZCtipLhNtyapSAVWNeskjs0
         0J8wdcjwiSIJMqSB+iOqPNYEmGZu+RdidzGZRiPfBkPVPMnryv+cUjEhvfplGqTI8JUx
         hKphnIKsrTpcy4myx/g3fnWg+bg+YNxL5sKrV20YvTf4m+goFdasznHriwaRsOMQNlSU
         ETV8E/s8Vh/JwpX78Du1NJSCBGSehE2Bio+8VW1kDqdDMELHbIyMbrptlcqfHufI6U65
         VfJA==
X-Gm-Message-State: AOAM532vchnASvxCgFeuzdb7/P9BIgWgCOZQYSFGVq2kp8jGDQjGdVEi
        6Kg1argk+fJ+VbfckR71iTLm/dKiKVo=
X-Google-Smtp-Source: ABdhPJwIcd2PMSEJOLUZy7dQq3L2lDKlpXhRPPuicS7M3ICy4r2TdUQ/7BPbNxIQbRu0NREAVDexjQ==
X-Received: by 2002:a17:902:8305:b0:149:6295:4d4c with SMTP id bd5-20020a170902830500b0014962954d4cmr57145501plb.63.1641527523009;
        Thu, 06 Jan 2022 19:52:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j16sm4043855pfj.16.2022.01.06.19.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:52:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/5] MIPS: BCM47XX: Board updates from OpenWrt
Date:   Thu,  6 Jan 2022 19:51:36 -0800
Message-Id: <20220107035141.2325384-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch is breaking up the larger patch that OpenWrt carries at:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/bcm47xx/patches-5.10/320-MIPS-BCM47XX-Devices-database-update-for-4.x.patch;h=bde811c1956578a33cc230b80c3a2b4a20cd9aa5;hb=HEAD

into a series of patches that add support for each board individually.

Florian Fainelli (5):
  MIPS: BCM47XX: Define Linksys WRT310N V2 buttons
  MIPS: BCM47XX: Add board entry for Linksys WRT320N v1
  MIPS: BCM47XX: Add LEDs and buttons for Asus RTN-10U
  MIPS: BCM47XX: Add support for Netgear R6300 v1
  MIPS: BCM47XX: Add support for Netgear WN2500RP v1 & v2

 arch/mips/bcm47xx/board.c                     |  4 ++
 arch/mips/bcm47xx/buttons.c                   | 44 +++++++++++++++++++
 arch/mips/bcm47xx/leds.c                      | 21 +++++++++
 .../include/asm/mach-bcm47xx/bcm47xx_board.h  |  4 ++
 4 files changed, 73 insertions(+)

-- 
2.25.1

