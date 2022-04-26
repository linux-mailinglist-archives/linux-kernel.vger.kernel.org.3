Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA2510A31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiDZUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354914AbiDZUTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:19:07 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E56E3B1;
        Tue, 26 Apr 2022 13:15:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 71E5C5C0110;
        Tue, 26 Apr 2022 16:15:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Apr 2022 16:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1651004158; x=
        1651090558; bh=c61W8AmgSSZBwemgriOb8pL9lmJR0zJYE48dHUOeG6o=; b=g
        JMFsYCsOA+ZjjpAvN4gvro8Uyr6wKoSm0bjbXqeizBvcgnrDUA6aAKQexiSDHgrT
        Zanb+jvgm33OY6qkPwiMNCZH41OuZ/W8PUVZsTX64Knl7ldhoR+EA7qjKMBvDBaJ
        r5b9HZTR9YKf0xDH51Uyi8+l18lMcEyzylEX0KS0+nlzYRPqKD5SnEkHossN3jZN
        sVwkht5BUrEFfc9Tf1l20PeOeB+fAiG2ES3VJMwUqwFjqSTYR0+O1qmXbh5hp1jR
        AjMkc8tiuTqBab8WndThn2VscAk5ytj/robFF8Ip1vDnpJDb8EdmefODWkE1n35y
        kxR0zW/TQJ/xJ0psDQo2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1651004158; x=1651090558; bh=c61W8AmgSSZBwemgriOb8pL9lmJR0zJYE48
        dHUOeG6o=; b=ijTVKyZjdgxnIbsWyhglotPgux7zhPN5Xn7Nm3JxUQneciIcuHQ
        XIu+WxApbZhFr3rdQz1g3ZqvLN0oy3HZL3xz6VYJhjyyX/WbV04H+h+sbtcT9KTQ
        nQuRoiMoy8r80Dv4K+iYmjsAdNM6M4A1IRYzLWrYz7gOccrPTO2ArzxzQvhRjN3D
        e9v3+YE7JRRMueTKhKlaQ8MSM8TdOppwud9WqC7QLCQN1+A9CukcsDUIiVtdHO/q
        4MLWU4BkMoczKNuUxhKZJ/Z2HY2g/Vw3weQ300RSUD6XtMvIxqmhbN0bRJtE0q3J
        G3mlsr7szbU/dYo2aJ+QiX4hRocv/TQMAJQ==
X-ME-Sender: <xms:_lJoYv8-BsoJm-yiXnfzNq9vm7Gl8tVYaIEUJMo8i3wCe4rp9Dm_iw>
    <xme:_lJoYrsITB79PvFXoOc_Zjn6YqFGxfkBO0hagj_koQVljONFCNCp1L_W4G9Qr5er4
    9mJVRLW5M3CKS4pubM>
X-ME-Received: <xmr:_lJoYtAR_GNV8ALvxqDxpN_dGJCDfondrEtCFkHJF0NSkx83qpxYdQ9rBoz5xcoOsGpOKb_VRsCNpaDmZ5W_BQP9wOMqYBJhRyZxqT2hnVvBdy8UWEnK98sR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:_lJoYrfh9xrNdleB6lhcn2f0XO9bKNVFJ7pYsAcWmjq3DhSsc_UhXQ>
    <xmx:_lJoYkNJTTOvjeM73VVlhNSCUMPQQ6hiGM_8vpEja9rCDz2w7VHm7A>
    <xmx:_lJoYtn_ZGydc9p5QgZqHVh7uKkIQ1aPDnXqzOU1WVwoGh7HVN0QDA>
    <xmx:_lJoYrmJirgpkNYXdyJBcbf1HQrK7-RiLqcVvoPVTVkf57DgWIYYew>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 16:15:56 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH v3 3/6] soc: apple: Always include Makefile
Date:   Tue, 26 Apr 2022 22:15:36 +0200
Message-Id: <20220426201539.12829-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220426201539.12829-1-sven@svenpeter.dev>
References: <20220426201539.12829-1-sven@svenpeter.dev>
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

We want to allow the code inside drivers/soc/apple to be compiled with
COMPILE_TEST but this will currently result in linking errors because
ARCH_APPLE is not set and make will never recurse into
drivers/soc/apple.
Let's just unconditionally recurse into apple/ since all drivers
in there are guarded by config options anyways.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
no changes since v1

 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 904eec2a7871..6ad4177595f3 100644
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

