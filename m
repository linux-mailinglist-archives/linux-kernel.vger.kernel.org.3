Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5398D5529D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbiFUDmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFUDm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:42:28 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A31B631E;
        Mon, 20 Jun 2022 20:42:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A908E3200413;
        Mon, 20 Jun 2022 23:42:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 20 Jun 2022 23:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1655782946; x=1655869346; bh=QwqtA8TFvXUjbrq3ygXKnCrNk
        cCC77IXwnuhLmCowy0=; b=nnU5PF/LTt2rpo70idg0NCv+QGLNFDHLvx8Z6gKH8
        06IfWlgAvnz26c4YGgICHLjDOv1XMwSm1lgRpeeYYles0aW3tiOozFcHfPU7zWe2
        ZzoFb3Jbpe2ZkXRRwR7xNQX8h3iGFXXRXc6q5imByolxX1iXl4wyYNp6rRSA8w/E
        sT2OyANrfpbcIutR1w89crua+sO2ObNxiJxXYDNmfVe7trBu/AbKMfQ+7fA+oHZn
        EizYZdDBBJBkK8oFsa59gXAq4kKLf0PrTCyjHCF2cMztBYSMA+HrGR8vsSZvn6aW
        z0EazYV5gch8HYui4UcTR6YVe45EZMgbmvapWkp/qoy5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1655782946; x=1655869346; bh=QwqtA8TFvXUjbrq3ygXKnCrNkcCC77IXwnu
        hLmCowy0=; b=s1XUMhvKgDhqF0AigFoDEr8SokwDvLrN0XNfZeS3FVB+4uOSdxf
        xp2ZZfY3//iDM0t7hU5kotyDZStTWdG2nNP/L9yHsp6EDe313gqvqUlJnyMif/dx
        NKcC5pucGaMmeNOJPBr4nFWQXLNRMq7ZzOVTqFzLzBz0O2gtL5kFC3JDPh6vV/s3
        FbU386LhKeoNjnjrRFP+SZCiVz8zZr4gN0Mrw/Aa0WIxPvFzcllkIbNbOR1bOOVk
        HkgsoUjkCdb/xvIEeGzbEobOA31/v2fOZZ7KIRk+C3WQSb0W4poneT3qifRxD77B
        PnDKqbL4wTDdYuqvevKHvyzwofxBXmODcJQ==
X-ME-Sender: <xms:IT6xYvRiPxDvuVUb3RRJpVozZ8vQFJ_yUXgazg98YJEUpcdMz3j-OA>
    <xme:IT6xYgx2yvbb0yLGmB1s75g5mKFMlUK-HLfQPu8m61XCrFtSn7JstSsnFOXH9H5IQ
    0zyEA11E9WWq2DczA>
X-ME-Received: <xmr:IT6xYk1jsyzc994vm26uUHqrsQZ3gra5WAbTJgdlOx0z425vgh0FJHM2HMv7sXCEGAe18jb47aTHOlG3Gy-hEqf7kTPrce0D6yPF-5Z427oz_D4KpIrtgeTFoEc1RLMFrZlFEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Ij6xYvDhd8mUdN4HhgpvCcKCcQPRnppB_CzpmsBNp7Q5SalIG2KHJg>
    <xmx:Ij6xYoiXjCIK_rOPa1md4-Io_bqxaL28LrmIzHtY76L_3UgLFJM97g>
    <xmx:Ij6xYjpRRyiuYV1-7WbaunhJpKv39QC43aAXsC79manVmKvIV1lhZQ>
    <xmx:Ij6xYhW55dZ-MKS6TxGanl4uQnQh7NfKoy60oDaCQ5OAtdWB3papIw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:42:25 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] AXP221/AXP223/AXP809 GPIO support
Date:   Mon, 20 Jun 2022 22:42:20 -0500
Message-Id: <20220621034224.38995-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series hooks up the GPIO controller found in some older X-Powers
PMICs. The main motivation is converting the U-Boot driver over to use
devicetree, but Linux might as well gain support for the hardware too.

Changes in v2:
 - Combine multiple "const"s in the binding into an "enum"

Samuel Holland (4):
  dt-bindings: gpio: Add AXP221/AXP223/AXP809 compatibles
  mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
  pinctrl: axp209: Support the AXP221/AXP223/AXP809 variant
  ARM: dts: axp22x/axp809: Add GPIO controller nodes

 .../bindings/gpio/x-powers,axp209-gpio.yaml   |  6 ++++++
 arch/arm/boot/dts/axp22x.dtsi                 | 18 ++++++++++++++++++
 arch/arm/boot/dts/axp809.dtsi                 | 19 +++++++++++++++++++
 drivers/mfd/axp20x.c                          |  9 +++++++++
 drivers/pinctrl/pinctrl-axp209.c              | 14 +++++++++++---
 5 files changed, 63 insertions(+), 3 deletions(-)

-- 
2.35.1

