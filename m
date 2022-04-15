Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF290502BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354448AbiDOOYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354437AbiDOOXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:23:40 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978378CD8E;
        Fri, 15 Apr 2022 07:21:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 09DEF5C01D8;
        Fri, 15 Apr 2022 10:21:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Apr 2022 10:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1650032471; x=
        1650118871; bh=1VDxVEy1kf3mSXO0HR8jVsRvxpFr08W0EkuoslbOHVU=; b=M
        6abm+zltKQ0YorUThv8lH1O419V/kqP5nmB67hqjXjVr1SUGOxu3IAhi0Xi1JgbT
        qwkNT1WaOBNCkcDuFBsuSDE0Vd9vB5dKPIeUhKsCespkgcKxrYpBXErTWtZ17Y60
        wkfwR4K6/tt833+1TUV8/ZgEnNHqoLVQ9LnjHxgUwsk32VHFavWkYAzokPrNcZWP
        f84jpxDUwtql/uWeSTNFf76RRKLyE2Dz0M5+zdi1irDx2qLDDIWK07FEBR8VzRxF
        7z8ewdytwepoh0q0PLWZMA89lpIMfRUTmvn9xINyWgTiuQU/AHE4t6Z6qwbq5YNB
        zPb5k0KbeT/HfPUFbLL5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650032471; x=1650118871; bh=1VDxVEy1kf3mSXO0HR8jVsRvxpFr08W0Eku
        oslbOHVU=; b=y5goGdZ/DjTKQHrJHOyFUXIKyW07u5viLjCg0AXbTZrsoYPQmDc
        wVHgZ68dMiGRvT3E/7kXoXkErkke5VWgoxzCLb7DYeeesEbhK/HeQ+50p+ostJm5
        XjhEaTrNYnKmNgA2S7QUukS9YgB28v98fdy0GdyynMgImi6r8vnis/uSYyWDk5v9
        E7AcNtS4Vvam9gEPTvuWmSorE3HU8rrvL3aoBZ398qMSP8KVbR7vZZqD22Ty1gEu
        UvmqvNjE06ZCBjS505ZkCU7fspop5g4T/VjlMV3u0LNuELseX3IMgIu6d36GQ6/K
        8AHf+IPohwX0OJ7fvB43GmUh8PeBAcrO+yw==
X-ME-Sender: <xms:Vn9ZYoDRSPHr0lUy3dmKn6BTxYQy0XtaEZE02B-J_9oDMMZgIOMmFw>
    <xme:Vn9ZYqhPMJL1xUfR2LN535-rDellpbBsXtsDMo1pmJQpzfLF-TUGtQJTTbthIAAaE
    Ayo3TGDISFOjf01Viw>
X-ME-Received: <xmr:Vn9ZYrkyY7xizYzxdInWNZL4g-3DZn2HcfUHZxj61NPkewjgbhUkX-46SolpZVtgBgwxNaxoe_IYS5e80-mlDcT_sSbdbUAZ_ONWr2L83R9Df-_VnY-d5uZQAeXYiIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Vn9ZYuw6Psv4JDREC1z9hNo10aQOVHO8WCIlvIUd-8hbORd3qlwdnw>
    <xmx:Vn9ZYtTiQqi8SaiXvFu3v-0mTCxn-8n96CMob32UpBX2iEVqTG2mag>
    <xmx:Vn9ZYpaomzD3TSl_HvWXR-dqJc4d6eb9eXyiXwv1VPYENervTYxBLw>
    <xmx:V39ZYjCAQ8vBwNnqtSqvRugltdpd_MT2SCllHi3QjvEznjFkn1NZNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Apr 2022 10:21:08 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/6] soc: apple: Always include Makefile
Date:   Fri, 15 Apr 2022 16:20:52 +0200
Message-Id: <20220415142055.30873-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220415142055.30873-1-sven@svenpeter.dev>
References: <20220415142055.30873-1-sven@svenpeter.dev>
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

