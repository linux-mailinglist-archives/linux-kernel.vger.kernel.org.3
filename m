Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EAE4E2E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351461AbiCUQxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351448AbiCUQxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:53:30 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF352174BA8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:52:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2781B3201DDB;
        Mon, 21 Mar 2022 12:52:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Mar 2022 12:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=Bi1/K+ioRkAobi
        uxJd52yJR2Pj8oZxB/CV+UGWW2RrE=; b=Ow/vF7bGd5mVcJpF0oAf+PfH97F+z1
        QwRM+o61GqMDteHOun8EzV80CcuuHXOuIj6ogQx4Aunri+CA52KRQW2SutwJ6Yos
        5y8q4xBkfuCvREhw1ydrTQ4OxhmW0KYUms8gX8U27V0ALlR39zfLJtMsuXd8jWF5
        IMmFwwOJeZ9a8YbLrOJ5l1CWkVidp5TEh6Fwy2tEH1CCWuD90ai9qyetl8qJSo3j
        ZRQKTWQaDaUVwiUTZg6gnWESaYuijdqW02RHACEVvQRNfhW69Jj4bk7Hf7WJrD9X
        IRJS6v558WbLL2eE2Y6d3esR8z/Uz648QB0ll6oW5VNFupcQifJ0Zmqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Bi1/K+
        ioRkAobiuxJd52yJR2Pj8oZxB/CV+UGWW2RrE=; b=ZnfrVXH5KtTHqfz39jXMpW
        lMWw6tWSctYFWbvrJo2h2FaN35zoQ0ndoNqmJkdojyPQScwX48WLxNl1ZLBGgafs
        qpXVvWxrfd5rSUBmtxgQ/4Fij2E38I0lVbGZniwMv1WrxbeaukKuqRPzMhWUkwP2
        Apk67LVkZXAJazuXavMaZ+w27ntL+5bRcEb0ENS9z1nVr0Q48NUDlTnIQENqIi75
        hrESvgT1euHD18oUII9iauolhBG0XyP42ZwcmDh3bCUjhQGJT2kHl90NPhdZDUoi
        xxYI6cnzURDZio4+dD1FHaK+CfexEAk7gzcFU+67hOc+hnPF0YEbV2qPhcusv2AA
        ==
X-ME-Sender: <xms:M604YrdDegBaXgclkFsTltha5asPtsbrP2CC4EzUyJ9NsRm3-uF4pQ>
    <xme:M604YhNbj3NIDngnTm0_JPcVSB4r3xAnkNzFENFarKMEKIHsyPDBKblz8EE1lyN95
    h-4SiV1B6Enfp5sBRE>
X-ME-Received: <xmr:M604YkgxwWbnap9TlOo_3W0J3mKF--s1Iqq3E2aZlVhaz77rrh_HMy0HHSbaVVbsmlE2cMjVFnvdOTAxA47FAEW68kkoGkMa8JuqcDtOihXjTsBy62rVren85j5wdos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegoteeftdduqddtudculdduhedm
    necujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnh
    curfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthht
    vghrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfe
    ejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhv
    vghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:M604Ys8XzHWaWlV5bJt2gw4JoBmI4xTXR9vSmMCPy1SG-7gu3H2qwg>
    <xmx:M604YnvhYTa5J6oPgVrnQQPzXUHf7g6iPrc8e73NsTXiDqcdmzLSLQ>
    <xmx:M604YrEfjCAGFGW6AYEJWnOrujaDFemEiaTXeK0A6gayJfFi846pwA>
    <xmx:M604YgFVpWzUrJOBkbCjJXq_RaKkOtneGBCSnDeMj1vB2flUdhxvpQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:52:01 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 3/9] soc: apple: Always include Makefile
Date:   Mon, 21 Mar 2022 17:50:43 +0100
Message-Id: <20220321165049.35985-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220321165049.35985-1-sven@svenpeter.dev>
References: <20220321165049.35985-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to allow the code inside drivers/soc/apple to be compiled with
COMPILE_TEST but this will currently result in linking errors because
ARCH_APPLE is not set and make will never recurse into
drivers/soc/apple.
Let's just unconditionally recurse into apple/ since all drivers
in there are guarded by config options anyways.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index adb30c2d4fea..608f8ce8b600 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
-obj-$(CONFIG_ARCH_APPLE)	+= apple/
+obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
-- 
2.25.1

