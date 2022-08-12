Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3873D590D02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbiHLH4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbiHLH4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:56:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403F9926F;
        Fri, 12 Aug 2022 00:56:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 945F35C00D2;
        Fri, 12 Aug 2022 03:56:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 12 Aug 2022 03:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660290965; x=1660377365; bh=Z6OqHh+7y79/rYETjyUl61z4Z
        yCh62yq8O0Dd/39St8=; b=LAJ7jEFLJ6jpTgO6Yr0XmB60/TmkLbWpmWpyemV+J
        k0uYgUy7z/RVn1/PJkCPr0Gfr3XAD8xPs1I1tDR/fZ/f1bICZzgCqZcJitF7kMzu
        Z3nbza9c+gyTykFDAuq36BdTXOfUo1vH41Ifjd1zcaD2OCSVYJMVbetFHD7y9/yy
        9RbG2aaGaskNcSXWqolLfiLLQRftCo1rHA2wHQsyg59rD5zKKiN834k9RpEBPeLR
        SP2hUL/xyuQnEy1w456WUP0iemE0CmfQWINYg9+EqyooyICtomaMiD/V3XVMhNGR
        djnt3hy8TqD8twcIsLfN4h05VxdAlorq8KTE95127NP/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660290965; x=1660377365; bh=Z6OqHh+7y79/rYETjyUl61z4ZyCh62yq8O0
        Dd/39St8=; b=oW/gMC68C5kBafcWJ8V+cEXqjCAUdIelTlEsfu2lyQqtJBF+MO3
        rtZ75tOOydlj3gm55yLkSdefda7qMh/u9W8o8HZdAWDhz+wsyDPOO9dt30Ib7rUK
        GRHJsfksN94xlpUwU/sreYzrM4oNpKu0Bzg5pD3Jz1iiEJNQBGQWp/AJTh+noVaN
        KJgM3RPAH2/WsPGudjZtsGE+SAXs1n3QuSxAxpxQ8ujn3fE/fmIZFRCQaW0meK8O
        Pu2cWdbDryJtzpz35IFQGjHVgSsM2iIoxKmoNT5J3ydT8qNXId5NJeISE82xOlAg
        s1jS/7o3e0bsNr57XhPSODpGGxxNUxxMe0A==
X-ME-Sender: <xms:lQf2YoyvVrNeWW-ly3os0o59tEoXprcH1gHsV0s7nzElwIpbHlB3Iw>
    <xme:lQf2YsSipsLAramrIqYSwB6rXPc4FIV9GXE2BXzVBS1Mg4sCYkru4TdAX00JByyRb
    lqascTSwb8up67qFA>
X-ME-Received: <xmr:lQf2YqW9P5MP6wcOKzO0nVfWNuAM1T3WYfXdIO2HQ4G7A00bVxKtu0yxbvIa0Ql88U3XiKAUNihSsT_5f0TZQ5t6a0KzwSMPaECVXL-8LG91SOoV9ETtUmWGxaNXf8jmwtTTcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:lQf2YmhphSX8mqcOUGpwf3XhCqKT4CoekJBCdIzDnR5GrzeINbbntg>
    <xmx:lQf2YqAVpW7BVJKvppaTWTvG1l98kW9pCswCnkG82Mq8BB6hpyMEzg>
    <xmx:lQf2YnKRHp4A0CG2dDeL1KPOVlcKIOpergm9VsnmEp9CDGQjxvtALg>
    <xmx:lQf2YiZEhYl3ojjs0R1MBow7bAMM1RKoM-xdBqwxqPdn89S8At7AOQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 03:56:04 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/8] phy: allwinner: phy-sun6i-mipi-dphy: Add the A100 DPHY
Date:   Fri, 12 Aug 2022 02:55:55 -0500
Message-Id: <20220812075603.59375-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the updated DPHY found in a couple of
recent Allwinner SoCs. The first three patches fix an omission in the
existing binding. The remaining patches add the new hardware variant.


Samuel Holland (8):
  dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts property
  ARM: dts: sun8i: a33: Add DPHY interrupt
  arm64: dts: allwinner: a64: Add DPHY interrupt
  dt-bindings: sun6i-a31-mipi-dphy: Add the A100 DPHY variant
  phy: allwinner: phy-sun6i-mipi-dphy: Make RX support optional
  phy: allwinner: phy-sun6i-mipi-dphy: Set enable bit last
  phy: allwinner: phy-sun6i-mipi-dphy: Add a variant power-on hook
  phy: allwinner: phy-sun6i-mipi-dphy: Add the A100 DPHY variant

 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml    |   8 +
 arch/arm/boot/dts/sun8i-a33.dtsi              |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   1 +
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c   | 235 +++++++++++++++---
 4 files changed, 214 insertions(+), 31 deletions(-)

-- 
2.35.1

