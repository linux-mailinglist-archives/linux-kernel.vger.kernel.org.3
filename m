Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF91C4B9324
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiBPVZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:25:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBPVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:25:54 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7802A2AE735;
        Wed, 16 Feb 2022 13:25:41 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AD1D7C3E9E;
        Wed, 16 Feb 2022 21:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645046740; bh=JtmwpTprC73ttBElA3tFFcqilSdl2g7GxXlwp6KsW2g=;
        h=From:To:Cc:Subject:Date;
        b=ejc42Lgb05S5HUymkH1/57uvNctp5xfilOiS8Kja1n9ogP0cNvmux2ILc4Ollm2gw
         YS9r+Cu8GRjUIpCf4Doty717oKtOVgrNjmomJFGnEvv06GGd+EbFBSKm5Skb5OJuzR
         0MWJnDP/mu/cLpyQjo0luSsGR6Z4u2JCqk/a2ZSE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 0/5] Wifi & Bluetooth on LG G Watch R
Date:   Wed, 16 Feb 2022 22:24:27 +0100
Message-Id: <20220216212433.1373903-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the BCM43430A0 chip providing Bluetooth & Wifi on the
LG G Watch R.

Luca Weiss (5):
  dt-bindings: bluetooth: broadcom: add BCM43430A0
  Bluetooth: hci_bcm: add BCM43430A0
  ARM: dts: qcom: msm8226: Add pinctrl for sdhci nodes
  ARM: dts: qcom: apq8026-lg-lenok: Add Wifi
  ARM: dts: qcom: apq8026-lg-lenok: Add Bluetooth

 .../bindings/net/broadcom-bluetooth.yaml      |  1 +
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts   | 98 ++++++++++++++++---
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 57 +++++++++++
 drivers/bluetooth/hci_bcm.c                   |  1 +
 4 files changed, 144 insertions(+), 13 deletions(-)

-- 
2.35.1

