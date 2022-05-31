Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63942538ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbiEaEvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243938AbiEaEvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:51:02 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D35954BC;
        Mon, 30 May 2022 21:50:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3D477320096B;
        Tue, 31 May 2022 00:50:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 31 May 2022 00:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1653972652; x=1654059052; bh=eU
        7cue2LcpAeKkQtOhXjHuUv8SLcEPjT+d5wqr9dkU4=; b=rZikR53jzXP1uKcTwO
        L28CY6lw/KGQSdqxtztJ5Ql+1TJcLH1zU5fFAojdQFdZL9Pd6k3sUFffgvBbrsbR
        i4Ub94v1MiomBfQyQVm8hAcJw1z1bq28+H+NeetG1caE5aEczSQ/hNoXqHUxOPa+
        D0TDWG3IX06N1dtI0pezACBqtYzLwbeyJgstvUBYEGRFQ+c3Q5GqQRSdZoqV16NG
        8f1Q+j6AezmLcnwq+cfiy4pi5RqRToMNgxt+dEA1tKvXnzqoEMPagAMYUHPdXms/
        VcWHBoUvYayFyFBO8PTF4RauUIs+Co5zQinTJdkJJ46sBpavjRSQtdUGa1B/AYnb
        fgWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653972652; x=1654059052; bh=eU7cue2LcpAeK
        kQtOhXjHuUv8SLcEPjT+d5wqr9dkU4=; b=SjiyAnNae2bJcw+LgxUfK1sQu0UAT
        sMFHJdHZmrPvA16x1dMExFo0YP2Mwu4BXc34m9COiKNE2VEON+6CJNfBMD8yPfoK
        tU3yd/SgQmM3l2BQBV5f8mS9JBPgaTTTozOZHlYOYdJbfIg2Pc0CVBih7UyJSqII
        3Jhb/5aH9XYe4b2W3zYAWwBCY7VnDKDm+UIkHZJ4K7oY/LY8eZW6RB0y5oDpUab+
        qHP2De7aB81weF87AM5xGAPitQYYbeTDqFoQ/sfVq2gbHPq3ChxlFUfWSG27dpFR
        vwSDbMZRNqYpFbmPhdE2eMadmM9UEa+TBgEZw2oa6mBCpamkxCUbvRV/Q==
X-ME-Sender: <xms:rJ6VYq9bEdrssHnetAqeorshHdpkEnZFeKdqVzAlBTWIFxGFK6HMLg>
    <xme:rJ6VYqtfDQGfXHElCeQ33P_So-MRCKeBXMIKhkq7JPo3ybHL65Iz8iKmoNzcUcS4c
    osUNk9-eYffpGSC5Q>
X-ME-Received: <xmr:rJ6VYgC2qelAXLsQhx5oYo1eZDVeIlI42SbezXPEOxpeTdNVfdBUn_H0625pgmxQR6rR-Zk7IMfh9L0f6QolnqJlZCnSa6BMG9aHmoaiAq4AvJADVY3Z0w2xGPg1mQKVV9jDJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:rJ6VYifqqQNPgoXrXgMeOCwaZbJiW5EV5TG3qJpxFY2M8HMWPivfyA>
    <xmx:rJ6VYvOA7yH833ecqkTPN8zyge6FqxR9X2gGvjx_lkXb0qFg523f5Q>
    <xmx:rJ6VYsnVvrtiZHSAvULPAagARpAxHrqd1CdAP5GtNHW4ABRpaS7i6A>
    <xmx:rJ6VYowpYhgKmUaXguW2sy4zXzj0S7jQmnGB2D-A_4hyFC3PqXtS2g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 00:50:51 -0400 (EDT)
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
Subject: [PATCH 3/3] dt-bindings: arm: Remove obsolete CPU enable methods
Date:   Mon, 30 May 2022 23:50:38 -0500
Message-Id: <20220531045038.42230-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531045038.42230-1-samuel@sholland.org>
References: <20220531045038.42230-1-samuel@sholland.org>
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

U-Boot has provided PSCI on Allwinner A31 and A23/A33 since May 2015,
commit 014414f53695 ("ARM: sunxi: Enable PSCI for sun8i"). Since we can
assume PSCI is available on these platforms, they no longer need custom
CPU enable methods.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/arm/cpus.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index ed04650291a8..94527187a85a 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -195,8 +195,6 @@ properties:
       # On ARM 32-bit systems this property is optional
       - enum:
           - actions,s500-smp
-          - allwinner,sun6i-a31
-          - allwinner,sun8i-a23
           - allwinner,sun9i-a80-smp
           - allwinner,sun8i-a83t-smp
           - amlogic,meson8-smp
-- 
2.35.1

