Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB34FCDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346278AbiDLEa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346046AbiDLEaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:30:39 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B150A32992;
        Mon, 11 Apr 2022 21:28:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4D4CB3200E89;
        Tue, 12 Apr 2022 00:28:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Apr 2022 00:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649737701; x=1649824101; bh=ge
        Qfxs48cSAJkRFMna6Z0Fdczf6CgFCi9zuHYoygHMw=; b=GtpDag5RYt9P8bKYyl
        D14O6dWAhHxdj2V0jskaPMK9Ai9JT6i51/lRI78LsuuMGsS1dy22VXXZC4P2M60A
        d9s4WfMvFDhnWnuIdJn+IM3cZEHHLzgdBdQbEoX8o5whIlUlr1FVQVoxCntpA0IT
        ZPHyH961iz2sFwvyPCCQH6EeSOoEWyXTK8QnaBVYOGFFNpzn9GcZPQnCpElr1BDf
        xPj6AarVIIjoSMPBjog/cNCy4s2fLqtY+y6HdhV3eiQkb9keYkbR3QhGK+YZ/yqF
        oogn9GZ5j8QXMCwH5Y2EBw4bUMXuwpcZejAenJTgMQaDqIKOsvdRo/y62URIe+DF
        eOtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649737701; x=1649824101; bh=geQfxs48cSAJkRFMna6Z0Fdczf6CgFCi9zu
        HYoygHMw=; b=nVJV/tjO6GTR+KsYhsWfwfS4dJnGq/7VRITyb8p7kF4oCuPJvQf
        IfvswxQjna+D9HBNwMff/6cob8er9o4qGFtsYWEx+JnDaH84JIdRlz71Eg4DfDBy
        /+t1AjljnNiX2LaafeW5tUyC6xUs28H/8uftdCNZnRBMRG7vhzFedY/0sC76kSYA
        +mIrJYnLsg/bW5DIAMZG8Y3Ikre/UKv55tfOvoWjRBWJcm4BpiEPjmcpTYneJkN6
        6L7LaWzAXJRMDzrEbH/N/H4AwqfyPwN/xDVcYLR562uYJBTn5tU4mCUphbpjGT0v
        PtaU5li2S/vqo8EcKHsp7+t8XkMls4mfGfw==
X-ME-Sender: <xms:5f9UYhFLR2kC1d6Wn6Ht9vo3utn79iszlo1lNHb-uCI8VlWMX2IcSw>
    <xme:5f9UYmVYbhoRBCw9BkQiu6BUrlEpqKOFWlXZ5jZkhrjSicKu_PUSUOHgUWYu4kDJA
    w4IfmWpEPyfqpNrLg>
X-ME-Received: <xmr:5f9UYjK54m4t5WmoHsLy2rqJKSAPCmLhyU37uyXYPMsqEqWlExwiivUseZPeE9-6NWbGciTT8HxpM0KLIp02-pAbIE4aidBlm1NKZil-e6THHn-7ynLZS-FALp0UcHYmjPxgYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:5f9UYnEy50MfNtL9FfVzEZYErBJ_6cYreILV3waGVqkarQ0WZz3UBA>
    <xmx:5f9UYnXEMVsXyJ86C414DsqVXrQ6d2rQxhvlQbbNTm1p_dVlxukNnw>
    <xmx:5f9UYiNgdJ3elanGlNDDsANRm13tSRY4JOLPqm1prTdaTQ212C-Enw>
    <xmx:5f9UYgtoP3VUE06Q-munE0CZVAhVlcI3oRNypYROat4YiETKBqUdbg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 00:28:21 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 04/14] drm/sun4i: hdmi: Use more portable I/O helpers
Date:   Mon, 11 Apr 2022 23:27:56 -0500
Message-Id: <20220412042807.47519-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412042807.47519-1-samuel@sholland.org>
References: <20220412042807.47519-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

readsb/writesb are unavailable on some architectures. In preparation for
removing the Kconfig architecture dependency, switch to the equivalent
but more portable ioread/write8_rep helpers.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - New patch: I/O helper portability

 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
index b66fa27fe6ea..c7d7e9fff91c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
@@ -56,9 +56,9 @@ static int fifo_transfer(struct sun4i_hdmi *hdmi, u8 *buf, int len, bool read)
 		return -EIO;
 
 	if (read)
-		readsb(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, len);
+		ioread8_rep(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, len);
 	else
-		writesb(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, len);
+		iowrite8_rep(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, len);
 
 	/* Clear FIFO request bit by forcing a write to that bit */
 	regmap_field_force_write(hdmi->field_ddc_int_status,
-- 
2.35.1

