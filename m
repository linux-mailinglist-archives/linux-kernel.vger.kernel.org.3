Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20C054A9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352497AbiFNGtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352374AbiFNGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:49:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D259A393E8;
        Mon, 13 Jun 2022 23:49:02 -0700 (PDT)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E61526601690;
        Tue, 14 Jun 2022 07:49:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655189341;
        bh=6JoH8pVYTDfQZg2qdKnKizfl/wjaRDGVdAibrRD+O28=;
        h=From:To:Cc:Subject:Date:From;
        b=izqkkukWVAY+3n+uXNESHk0uuXaFuw09EUGWp34ISPpwaLPzxQb8+V3DfoThHcGLB
         jxDiEWcczKQ09txi+Mvszt1qX18hrxUWnQ1jiJCqqEZ/h990OZVo4dTUMzWQJ7vtDf
         BqyRJba0enWnNqfPc97yoROnfEhqnZGQZjnLoWtxE4RQYW0Q6TKCm6PR/EgUIo9hOE
         Cl/tadwPJ6YQLKsSVtjXv09a/BEaIndNrehDPPMy/98CDp1eLSHcEsbPJjDpdPDPXJ
         9EGvItDMhxuAEYmiBY8mtAOLf6NGQi0EBdLf/DBV/JbKoEYg4oaG3gzjkivc4koPYl
         XZdr/pVKBQrIw==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 6AB894179E40; Tue, 14 Jun 2022 08:48:58 +0200 (CEST)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Akash Gajjar <akash@openedev.com>,
        Alex Bee <knaerzche@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Levin Du <djw@t-chip.com.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for Radxa ROCK Pi S
Date:   Tue, 14 Jun 2022 08:48:54 +0200
Message-Id: <20220614064858.1445817-1-sjoerd@collabora.com>
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

Changes in v2:
- Split binding documentation into its own commit

Akash Gajjar (1):
  arm64: dts: rockchip: add ROCK Pi S DTS support

Sjoerd Simons (2):
  dt-bindings: arm: rockchip: Add Radxa ROCK Pi S
  arm64: dts: rockchip: rock-pi-s add more peripherals

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 256 ++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts

-- 
2.36.1

