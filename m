Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D340B54DA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359023AbiFPGJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358986AbiFPGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:09:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF84A24940;
        Wed, 15 Jun 2022 23:09:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DED3A3200A57;
        Thu, 16 Jun 2022 02:09:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 16 Jun 2022 02:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1655359757; x=1655446157; bh=4cAGhT7P98OlSBNNXfednYGJs
        u5Tq4H2hRPhtxLXeTU=; b=UP0Wynl0Z5MpaJpingUQYshe2Gj6uP/VlSzDKUQZG
        Ia861CwPIhrASvqSGSarnhW6u43UNq6c5AghP8KSNP+MnYO0bNa4zzt24rS2Jhe6
        Ea6iKbqUAYVmqNUoqL9y0IE3o7jpipdXI15o5UK42StVjKxzjNEvA4Cd7Z5w7hef
        b+TbkRmMIrYO6GWnOq3ErK/KUFAcGmPNiSPT6KRf3WHDb7VPIvX3cOcrz+K66t9t
        B1U4UP69Nwq825bH7T2udRK8xWevjwobo7DAfq9wuYVCNPYmOUrUD8pUjfmES2MB
        TLv4qV832dlrft+Kg90UB0fV1wWruLo0vjC3fV8XD8bSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1655359757; x=1655446157; bh=4cAGhT7P98OlSBNNXfednYGJsu5Tq4H2hRP
        htxLXeTU=; b=N6sXgHMPEE6EWESxM+7VVwiOKQ1xvT+KcHo+2Tv6h7ajK5Jiw7X
        /Ejmhx5rMzyBlJnxKQHRW+YTaDtLM4cK5buBaVkwWREBJubgQmqjcDvWpB7adTxP
        XXuYNTa/L2RJFxXseNgBD9aEbwfyUtDy5U0YF8oaGVD0Xd06LgY0BSNbikhwpvzb
        4o7LN3kHRCsaO9LrJa66wg8bM2vNifglyqiQ1R4Yb9q9r65ELCMjaoN7cxYG2rV3
        ieZ6wrDMrt8KORdDT8vY3G1/0niRLd52mJ+92rYATMP5r2O2hoER32ojBzmq+F1g
        sGAmaQXAzPIqWa2Vl9zfOzIlDs6QT5+inXg==
X-ME-Sender: <xms:DMmqYgXydrGSH0EDlMNnRzdy9YC5vioaUJS89XnXUZ7d0akmilzmJA>
    <xme:DMmqYkmmpyfiJwgraA0MbnzaS4G7ZdEh3XhvRkA8EAdeCnOHSfUmpDh2V7z7E0NP4
    7p_COa2L1vc94Cjgw>
X-ME-Received: <xmr:DMmqYka7cxIzyVfbLJFrFP01MwZ2hqDpl4CkfAzszP70wYTK4nW0Oi43Y0oOng_4o9v6_gQY86M2eAZOoxL6yb2gkPr1aBB_NwXIz5Co9cP6zN1XyVdL5z4XMWbny3XEL9U4yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:DcmqYvUM83I9oWo9CCyzFE5lCvIrpBTUR01UpKtdDfn83R4pepw6Ug>
    <xmx:DcmqYqlmQPOEDcD1rCHnZ4m7L_IBRbe9tf3luiw-M5g5yzsvYZLwZg>
    <xmx:DcmqYkcoWiHuIGbSO_RXzEOnlqYs4dL-VSUW0CU0XxBK2SUoaeESXA>
    <xmx:DcmqYk4BQOoW16Ot4t4hOPmwTeVVD2Fjewy5kzCUz4cQNLHq1ARRZQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:09:16 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] AXP221/AXP223/AXP809 GPIO support
Date:   Thu, 16 Jun 2022 01:09:11 -0500
Message-Id: <20220616060915.48325-1-samuel@sholland.org>
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


Samuel Holland (4):
  dt-bindings: gpio: Add AXP221/AXP223/AXP809 compatibles
  mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
  pinctrl: axp209: Support the AXP221/AXP223/AXP809 variant
  ARM: dts: axp22x/axp809: Add GPIO controller nodes

 .../bindings/gpio/x-powers,axp209-gpio.yaml   |  7 +++++++
 arch/arm/boot/dts/axp22x.dtsi                 | 18 ++++++++++++++++++
 arch/arm/boot/dts/axp809.dtsi                 | 19 +++++++++++++++++++
 drivers/mfd/axp20x.c                          |  9 +++++++++
 drivers/pinctrl/pinctrl-axp209.c              | 14 +++++++++++---
 5 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.35.1

