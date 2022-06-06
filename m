Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60EA53E247
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiFFIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiFFIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:33:49 -0400
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 01:33:47 PDT
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0479EFD372;
        Mon,  6 Jun 2022 01:33:46 -0700 (PDT)
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E38EC6602048;
        Mon,  6 Jun 2022 09:26:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654503992;
        bh=OpqSiLRbiQXWwWFspItgtW+FJ7vOxddMc4NNBEhlLKk=;
        h=From:To:Cc:Subject:Date:From;
        b=FReCM5JG/Ym/gkPXMQG7+WKfJBXbkpPRNlSmQst7nZL4vcU/Zo2quJ3SS4It1LIJX
         ZNk1Ds98Y9carv9X3A/ANw62wYxh/VS6i2m9nyuyyXDaXOICFSHIAtsAJ2pkbIAZ66
         Swu9VUA100igoLlCcy2Korw3d0znXk/TaInQ8WWfGd6kQqpvyp7CdHy/7QKFGZSK2h
         Vpi18Ob45re0tapRkdx64jNjB0y8aB1g4aGDWPxEzdy4Lpav0f+RAXeiRq76qp+FQW
         lROCSx+N2WU6/sczgnNx0MS4tLREBosHnHQev/IT46ZM4kHGAdVUA5RSvi2q730fom
         DGCQRwM+ob40A==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 86303404D08B; Mon,  6 Jun 2022 10:26:29 +0200 (CEST)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Akash Gajjar <akash@openedev.com>,
        Alex Bee <knaerzche@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Levin Du <djw@t-chip.com.cn>, Liang Chen <cl@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for Radxa ROCK Pi S
Date:   Mon,  6 Jun 2022 10:26:26 +0200
Message-Id: <20220606082629.79682-1-sjoerd@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This adds a device-tree for the Radxa Rock Pi S; The first patch was
originally submitted a few years back but seems to have stalled. I've
adjusted it to sort the device nodes and drop duplication of dtsi
properties. The second patch adds support for a bunch of additional
peripherals.


Akash Gajjar (1):
  arm64: dts: rockchip: add ROCK Pi S DTS support

Sjoerd Simons (1):
  arm64: dts: rockchip: rock-pi-s add more peripherals

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 256 ++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts

-- 
2.36.1

