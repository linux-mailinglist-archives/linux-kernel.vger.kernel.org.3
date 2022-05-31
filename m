Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9713538AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbiEaEur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiEaEup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:50:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437CD941A2;
        Mon, 30 May 2022 21:50:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1915C3200063;
        Tue, 31 May 2022 00:50:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 31 May 2022 00:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1653972641; x=1654059041; bh=0eU2OH/PMLLPNDGUWzR53cTyf
        MsGV3WQ2yKPJrBQB4U=; b=gUUOKk85li+LqgICYf+hYHEAiVWAh5pkJE4n2v7FE
        KZhn7f3WPg7jKqgrVokXU0R87AbW3QXfCZg1Rt9Fageg80KpEA8KzKXv2ssjO6VZ
        qJsUdb3+UE95XiNU69by3WxO42RvQxZL87nwqJHopnxSL1FAeTGH050TUqHMJfaZ
        0a7rwB8d8FonDc+Cs/ixP41QuFWjjaSWX5jzM9gxXI/At2JEoYtl53WzJhft0guE
        By4pvZrpdoFDQm0qq8kh4RtIYaD4PigPoxO+KFgJXNWU23KIqPe1P8oJbrDByr7A
        k3LpMi7peOEop86aWNq0OL6uu87cWodaJEnBL4seEUThg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653972641; x=1654059041; bh=0eU2OH/PMLLPNDGUWzR53cTyfMsGV3WQ2yK
        PJrBQB4U=; b=KOoXXd99d2A0G+AHWkkNESkPODakLOBVyqD7FCBF2UMVIdXfL45
        0ugEBJON//8UBpTEsbx7GjWt+JnoWR3w62xTjmrECrGu/8YSQro5XCzEpTS5pNdA
        1hvs8au1zW6/ZSE6ltt+MMSZdrOHl75J85ZzJYcX1krI7V2wQHYOHdSy2HKQOzQU
        3bpxsI4I9P9Ev80p9iqY68TN+CJgDe4jYRLMyVYPiI5sVmv4Sf7wrvj3GEHbvql1
        +kQjiIHAMX8Bmn7Ow93sT/qkw9ZeeSk6FnFjGIjD4me0GjA3G4bWAWNE+mvZF1KJ
        1Kx107FPg/dos1QZuaj+q6jYPNGYJLRI1Mw==
X-ME-Sender: <xms:oJ6VYrUXNESM5lbu_QJfh6vNJhDK9ygWgKnbVgUZJZyGncc8R6Q-6g>
    <xme:oJ6VYjnSTPBIPg1zYDfbcYHlS3IiEITVUskmME-KK9nX7d_TC_bwcJbvLZrl-fKXn
    3ZgrzuGEbexkLgE_g>
X-ME-Received: <xmr:oJ6VYnYQgYe9f25SG3sJl6EpkPmsE2PL5q-ZNykspvFTAVJ9WWne51KNUhrn6w6lSS64ln70UmZhLEqIgqxxijVYHf7JUU34WpbruZ7DF8UHSXqdL38-ClutjKaxO2cjy47ATg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:oJ6VYmVyaWylZd2qlvmw68EqTRSACPtQoiZo6TrcAtIWgycRajcy3w>
    <xmx:oJ6VYlk3DC18Vo6oDuAUUQSnnbQw6I13-Xo6GOUL2IoXbjH7EJnWKQ>
    <xmx:oJ6VYjcj4NwfhWa735jdl-hm75m2vrFZikFTHOswTB175A5PlNB4eA>
    <xmx:oZ6VYgq3JwQqO9WXy1nEXAP-gBhPSi4CI1wTbjTPRdZBNzFOtsvbww>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 00:50:39 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 0/3] ARM: sunxi: Remove A31 and A23/A33 platform SMP code
Date:   Mon, 30 May 2022 23:50:35 -0500
Message-Id: <20220531045038.42230-1-samuel@sholland.org>
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

This series is preparation for converting the PRCM MFD and legacy clock
drivers to a CCU clock driver. The platform SMP code references the PRCM
node to map its MMIO space, which will break when the PRCM node is
removed/replaced.

Since PSCI has been available for 7+ years, instead of trying to deal
with the migration, I think it's safe to just delete this code.


Samuel Holland (3):
  ARM: sunxi: Remove A31 and A23/A33 platform SMP code
  ARM: dts: sunxi: Remove obsolete CPU enable methods
  dt-bindings: arm: Remove obsolete CPU enable methods

 .../devicetree/bindings/arm/cpus.yaml         |   2 -
 arch/arm/boot/dts/sun6i-a31.dtsi              |   1 -
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          |   1 -
 arch/arm/mach-sunxi/Makefile                  |   1 -
 arch/arm/mach-sunxi/platsmp.c                 | 194 ------------------
 5 files changed, 199 deletions(-)
 delete mode 100644 arch/arm/mach-sunxi/platsmp.c

-- 
2.35.1

