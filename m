Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC68B563DFF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 05:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiGBDZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 23:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGBDZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 23:25:24 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA6037A18
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 20:25:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AC6CF5C049B;
        Fri,  1 Jul 2022 23:25:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 01 Jul 2022 23:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656732322; x=1656818722; bh=aSJJxlyL6XPezKf/zOjOwtmW7
        W1A/fXy5V9azTBip78=; b=cN/SSYcV/5hqqtMqm4pWnzGRa7abNf0GnsBq+rIRb
        ENT9Oly2PJmSVcPD/NQspc2jAcWrLQb/KKaMfNjUEnao0F1kJ+Zb1jXWyZQ8kgp1
        naZnLX+gXicGr5jP1IxjKQk23SogMTweHuAeAOGvxQXk4NM06suNfP3vOYUKOdCU
        whYsH+qUl5XGFgob0j8QP/HB+sWjpVtSG5wiJ7wUPkSM3Xr2N4eN9SkAFH0bq5iz
        F/n1TYpdq+G5B0EXu2cbRrGaRSGeXkDTZNahF7pWr8IBS1qJPBdIO6cjMr3tv++H
        UQHrBcXnPcvuDcipGYd2c+t/zYli3vt4IP109E+wN8ymg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656732322; x=1656818722; bh=aSJJxlyL6XPezKf/zOjOwtmW7W1A/fXy5V9
        azTBip78=; b=w1U+5Mq0yvoiDzaaZzfaZ2BcmEijSDHf0NorVPJo5bBJFDXhBKP
        QXn9zn12tEVFHJF1TGPvXFnFeiqUZ3Vlj9Q/d1o0bow/tHmB9gVAZZygiVpV/e7c
        wjOtVXGCPFEcNNcNWaAR8tTXOsCWCs4JVxemBkVB2umKJvjW6Lp1VZ3HmQj6E1WK
        9CQGgYPYr6tC/YBhLdG172NTuG+2CZEhzx8k3hmTFpyw4EknkJr4/CckJs5akXM5
        3P5R4hvTJPIvVEY1xW8fBuWI3c3fES2TPPT6diJhJDTO2X2vmLGLTAnrhx76csDh
        3ZPwddfbapS5E/bJRQc3RsKSKwvBW2QIgWQ==
X-ME-Sender: <xms:obq_YgmYpRU3UOZz_s3N5UHp7iAWOO5UQ_Rq49rHHjLM1HVjjjwcvw>
    <xme:obq_Yv3tWzyd9z5jFrR74UpTk3fuqq8XjdCc3UFqxkNbMJOBC_zCg3MGgxwYPpH4C
    y1ngUkUuEOOIQ0n2g>
X-ME-Received: <xmr:obq_Yur6kQ3oBMCbtnL-g6wqjEfLi9BektDFtaqQE3ce-6VdOGsUb3OGXogq6B1zd1u7lLSP2v6HmskrwD1z51j9FdfX6_tjgWVwGFUbOBe7ATQJabyF_yk8ZCDH3zcznaXJHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:obq_Ysl9MW-mo6O0co6-GAag6eypq89Vrv8H8_3_mh6u9qV83WBuQw>
    <xmx:obq_Yu3opE5JxqZwr9yOTJNCY4nWF2gxMjl63EQGWWPLLqC5cHTAcA>
    <xmx:obq_Yju33mYV52d55oQgmBBmDUt9vkYt-d5zUuVwTeRJ4Xf6iON2Ag>
    <xmx:orq_YhSWASDhleyq2Em7r1cKIuUl_HcKnw3-iay3afIr1Kpy297PCw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 23:25:21 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] soc: sunxi: mbus: Only build the driver on ARM/ARM64
Date:   Fri,  1 Jul 2022 22:25:20 -0500
Message-Id: <20220702032520.22129-1-samuel@sholland.org>
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

This driver exists as a workaround for old devicetrees which are missing
interconnects properties, so it is only useful for those specific
platforms, which all happen to be ARM or ARM64.

This solves the issue that the driver fails to build on RISC-V, where
PHYS_OFFSET is not defined.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
index 1fef0e711056..8aecbc9b1976 100644
--- a/drivers/soc/sunxi/Kconfig
+++ b/drivers/soc/sunxi/Kconfig
@@ -6,6 +6,7 @@
 config SUNXI_MBUS
 	bool
 	default ARCH_SUNXI
+	depends on ARM || ARM64
 	help
 	  Say y to enable the fixups needed to support the Allwinner
 	  MBUS DMA quirks.
-- 
2.35.1

