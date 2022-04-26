Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428BD510A33
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354820AbiDZUTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354895AbiDZUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:19:01 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C865F2637;
        Tue, 26 Apr 2022 13:15:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 310595C0043;
        Tue, 26 Apr 2022 16:15:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 26 Apr 2022 16:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1651004150; x=1651090550; bh=UvoCEZV2iN
        YmrEf0Gl3v1FkuJK/y6NUl/vMG5P+QSfE=; b=ET0RQP18f8/Tic5fZOJ13JJKpg
        1Cyoa9sdGbqgBmEA373pkCuMcwasDMwa9k1V5b042Sy5XtJND9bIMr/7ZmUWfZUy
        s4mtzxDGf7ar7SYpOcs0e8tyBL9WTw04dYzi8ocIFd6nTFxAUBh1u2DzZ26MLU5T
        v6gpyru/w/rlBrGC9fAbFhkTWsDyRKWaTWDJy2CZy7QfnsfvtEINf/OEDOaGkAmF
        5ktOcUMOW+kzDC6YKQOOar5seiShNk+qHdjgUTpwSAI9qCcJII1yjlHDWiQebPys
        V1L1bMY2a7T04Gsr7pauKZRYJiq7ysQjGzq/U5skqV3DTtaFtWxIvyyVdOlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1651004150; x=1651090550; bh=U
        voCEZV2iNYmrEf0Gl3v1FkuJK/y6NUl/vMG5P+QSfE=; b=Gcfcf0Bbr7NmvtmK7
        k8+TH0maJKfpxxqb3VJRkByIrcgMwhmdXnhMrtcnCmHflaiI9x7+sVahvUldWBoa
        V98UoNXgqa5Cq2oVAwWEtOtJBOV5/o8LQGCGH1vPwuRGAxRotUqz3wzQfE/O87eB
        vZ3akF3AmI7Pro3GqfH3VmHjogDedB7VAQXb+306lo4m3x4RXtgstPt1OfdmfdmR
        wjTHeyB3Mr18IUB99BhHYcC09S1TWmiYRjAUxHc+diCcYyAA12TYIAWIP38VJ/1h
        qXKksR2P4vMtFNFoc/7wnu3xANo196KCaA0eBDBt7BLRgPH+R2e6+hoHRJYigeJ+
        BPEyQ==
X-ME-Sender: <xms:9VJoYtrRpW4lYNgU6LzBAmvN79qHNsns6vXMhla5hOesXhF9YZOGXQ>
    <xme:9VJoYvpREuD_WsTg0VyQsdFTWPnSgK9w1r-x1trEo1wNGE6stiYFG0Ot3KaGrC9Sc
    bz-1iXj99aLrybLlI0>
X-ME-Received: <xmr:9VJoYqPbSzP2D2JRPEVP4IRwzS3us41auUhWQPLJj4xF9Rhyz8sF69APGXQlMxvbeOvCmcoL8ScX46FFuOCxeekeX3VaeTB8RFC8ChYvA4lqJBN_cC51ZQ1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegoteeftdduqddtudculdduhedm
    necujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnuc
    frvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgv
    rhhnpefggeduffduleefueegtdejueegheeuffduveevgeevkedthfeuheeuueefleehve
    enucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:9VJoYo5iyBfFydfXf-oO8QrlGYl5XR__7CLLpCF6pJPiO5Fdy2cdHw>
    <xmx:9VJoYs5OCWRZ8-yDD8-Dj5u0r8ODQang3_DkLrF0MfmAbaJaYOWyDg>
    <xmx:9VJoYgg-kr9bFl2wFinFz-7-SJcvjzpi2-YexdWB0w6Fr0BKofXAkA>
    <xmx:9lJoYrTBWFznWQFHILKcD2RA-Uin9bPbXxXq_PDvDAXnL1PIdpALRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 16:15:47 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
Date:   Tue, 26 Apr 2022 22:15:33 +0200
Message-Id: <20220426201539.12829-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series includes everything[*] required to get NVMe up and running on
Apple's M1, M1 Pro and M1 Max SoCs.

v1: https://lore.kernel.org/linux-nvme/20220321165049.35985-1-sven@svenpeter.dev/T/
v2: https://lore.kernel.org/linux-nvme/20220415142055.30873-1-sven@svenpeter.dev/T/

Thanks everyone for the reviews of v2 again! There are just some minor
changes since v2 listed in the individual commits again.

Thanks,

Sven

[*] The only missing part in this series are the device tree updates
    but since these will go through arm-soc anyway I haven't included
    them here but will instead submit them once this series is in a shape
    where it can be merged.

Sven Peter (6):
  dt-bindings: iommu: Add Apple SART DMA address filter
  dt-bindings: nvme: Add Apple ANS NVMe
  soc: apple: Always include Makefile
  soc: apple: Add SART driver
  soc: apple: Add RTKit IPC library
  nvme-apple: Add initial Apple SoC NVMe driver

 .../devicetree/bindings/iommu/apple,sart.yaml |   52 +
 .../bindings/nvme/apple,nvme-ans.yaml         |  111 ++
 MAINTAINERS                                   |    4 +
 drivers/nvme/host/Kconfig                     |   13 +
 drivers/nvme/host/Makefile                    |    3 +
 drivers/nvme/host/apple.c                     | 1598 +++++++++++++++++
 drivers/soc/Makefile                          |    2 +-
 drivers/soc/apple/Kconfig                     |   24 +
 drivers/soc/apple/Makefile                    |    6 +
 drivers/soc/apple/rtkit-crashlog.c            |  154 ++
 drivers/soc/apple/rtkit-internal.h            |   62 +
 drivers/soc/apple/rtkit.c                     |  958 ++++++++++
 drivers/soc/apple/sart.c                      |  328 ++++
 include/linux/soc/apple/rtkit.h               |  159 ++
 include/linux/soc/apple/sart.h                |   57 +
 15 files changed, 3530 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,sart.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 create mode 100644 drivers/nvme/host/apple.c
 create mode 100644 drivers/soc/apple/rtkit-crashlog.c
 create mode 100644 drivers/soc/apple/rtkit-internal.h
 create mode 100644 drivers/soc/apple/rtkit.c
 create mode 100644 drivers/soc/apple/sart.c
 create mode 100644 include/linux/soc/apple/rtkit.h
 create mode 100644 include/linux/soc/apple/sart.h

-- 
2.25.1

