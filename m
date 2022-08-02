Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7501D5876B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiHBFcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiHBFcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:32:21 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982671E3C2;
        Mon,  1 Aug 2022 22:32:20 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8B42832002FB;
        Tue,  2 Aug 2022 01:32:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 02 Aug 2022 01:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1659418336; x=1659504736; bh=Ge7j60aibO5Z3y1t3igfL1XiH
        vVASWRdGw8tdLd4ALc=; b=DqN9XOld1FRNUaNogihvjIjp+3hRdExCCEr20meH/
        y7xjWi2mTic18LDU6jJ+rO3hx1t9RxJkAjK9aRQvIYeTlT66yKaiZPoCnbBH1bI0
        4syLc+ds5zNTBSc2b6VjO3ohqD2/g6ZG2+kzuF/R2hdh+Z4JpXlIh9BPhSM7muwt
        Vh/N1H9xYI9QtRTLu00JwzPbJ6bqCmKtKTlbPb+dsoZA0V5flhwkV5gy+4DQ9WSU
        XIDcJEgyZyG/sKFxLbc83cw4nbCYiNnhT88gFu5dmEilNpW65iE1zEiLG85d+h8f
        PyfdNd5MUtQPHErnUbE2tWrtZNsYH+q/xtiPEq0y7FKHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659418336; x=1659504736; bh=Ge7j60aibO5Z3y1t3igfL1XiHvVASWRdGw8
        tdLd4ALc=; b=CWo9eJtmJMI7y7XwTQWQvRbspJcOEdc63kMzDpevPy7yUT0Ituo
        cKWrTlu25+72m7F/59cmbsGZYvFYufYuNTZFh07oWvIyNerRv3w/GCp8iBQo0JEk
        eKX142ikBnyhlHJgzmU+MpB1o1mFrNIs6iKsRHXYdPLdDRHvxRBxRbttFqAZ8DBb
        zaFEAZcLCvq8FqtFTUO94HEExPw3zp3Y9KCWnDrqwJjED2/ZOa65t06z207QUPcv
        zoSjuohrRd4BjCHJ3STA3RFQuturO4DpPJnjouTRhhmIDhgSP51x8yBZSg+zUSM5
        F192WXpctQd2hP4WCO0KLFdgOh7CudUuM/w==
X-ME-Sender: <xms:37boYqapY6ExKOM3vGG7b2TaI-iUYrf4FrbuDqwLxehLWH_bfFxiBQ>
    <xme:37boYtZ72OL6DoLY4o2cbp5C2ZJeyIPgRoXIjxOqa5AbjliqqCEWPWu-eZmONrHbY
    qpMeEoW_nGIi5-7xw>
X-ME-Received: <xmr:37boYk9WF8r6zC-oh8vniP6ju-n96FJUfWoRMpzoWivgOIVU35445lNQ-9R6Q6f3D9NJ4-qrekfbxGaUZslpqokUdew5cHqwloAhIvla7qmG1vpCTTGlP2eI7JAEJBCtcCTErA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:37boYsolMlsbb02QTwRZwJhlZANqwj-RHUqWAqDdotGBvx359aRRdA>
    <xmx:37boYlpXySBpSEI9AoRsP937PTncnjLh2KTrT5gHbDz8Hsjedxqm_g>
    <xmx:37boYqSpE-6gfrEx8p6xMRRkJz1cQdA12IXS72zoxWps7V-8lE-b5A>
    <xmx:4LboYih0_MpCEIFzzEaLlpp9FxBQJ8l3u6PS7RaiHBn7kaelqcuaVQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 01:32:15 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/4] regulator: Add support for Allwinner D1 LDOs
Date:   Tue,  2 Aug 2022 00:32:09 -0500
Message-Id: <20220802053213.3645-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds bindings and a driver for the two pairs of LDOs
inside the Allwinner D1 SoC.

A preparatory binding and driver change is required for the SRAM
controller, so the regulators device can be its child node.

Changes in v2:
 - Remove syscon property from bindings
 - Update binding examples to fix warnings and provide context
 - Use decimal numbers for .n_voltages instead of field widths
 - Get the regmap from the parent device instead of a property/phandle

Samuel Holland (4):
  dt-bindings: sram: sunxi-sram: Add optional regulators child
  soc: sunxi: sram: Only iterate over SRAM children
  regulator: dt-bindings: Add Allwinner D1 LDOs
  regulator: sun20i: Add support for Allwinner D1 LDOs

 .../allwinner,sun20i-d1-analog-ldos.yaml      |  65 +++++
 .../allwinner,sun20i-d1-system-ldos.yaml      |  57 +++++
 .../allwinner,sun4i-a10-system-control.yaml   |   3 +
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sun20i-regulator.c          | 232 ++++++++++++++++++
 drivers/soc/sunxi/sunxi_sram.c                |   3 +
 7 files changed, 369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
 create mode 100644 drivers/regulator/sun20i-regulator.c

-- 
2.35.1

