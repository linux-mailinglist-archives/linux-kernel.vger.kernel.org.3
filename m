Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E85862F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiHADF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbiHADFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:05:35 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE026471;
        Sun, 31 Jul 2022 20:05:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 81D5232007D7;
        Sun, 31 Jul 2022 23:05:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 31 Jul 2022 23:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659323131; x=1659409531; bh=h3
        4Ry2Qbm+JLSCIksskiScGwT/NymQyvjDKTXtJKZns=; b=YiywAwXiZXmSrasDvP
        dZrZpGxisYNG+ohJ3JzQbBGMGlDu5syc5x2UlBNH2hrrLZ0z8zUDJRrNOb6gFHQY
        9P694EqS1/30Oq4Lbv+svTzebq2UBa6tHt+BrGJNFJXj1wiE33A3JIiENuxCvqGm
        T6+koEFAdysIaXcOBC7b0x6tylAaN5LEF58VUtMlnTnaf+SiKO3PkLGlnUVO+ZTe
        UsYuFMH6tJlL8kVjl+dhf0nqlf9ymxkVCAsZgIarqYm5/1xyCxKt73F/ridl2L0M
        u1fHdLMrGFaiknWtUh2tAUQF8FarvsZiziYWV9ydfrI2P3ZtYfJ9mtWsa26EoLO6
        5Z8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659323131; x=1659409531; bh=h34Ry2Qbm+JLS
        CIksskiScGwT/NymQyvjDKTXtJKZns=; b=Jx7fvcr2/I3/hALlklGMX87ed38aC
        N9o5PHjS13LbfNXvkYhVMnNN7LY16vqBtKsRAfFeAp329yZgvx0OZDnFxDWh3NE7
        va6gJZ+R3dFHam/WwUkKv+oZgWz8Vp8E8mdB9/EejFnis8T2ZDpy+NDRooWYXrnP
        NS9pqiPNeidcUaPxkKEWP6+UCXLYdjKlr55RjhDSmbgZ0GRpuGuBKkkf1JhYU56r
        I/uwNFQpQ4dVafnUltw1cVAzs98bQ+J0katfFNDjWCumvqkcRxAPZD05SyhNzke/
        pWMQOScWJBPzY5A9LiMGALZSdVVrLCgFgv/O3wjVQQeYU062xkUI1mpmA==
X-ME-Sender: <xms:-kLnYlIHN3q7zEcrfBaL-Vw7l3GHt0DeryfFPGNlM9B8Oq-hzAt_Yw>
    <xme:-kLnYhLmj53XHc9JMEtNjMqStEifSmHtsOioGVINQM6zC7BPS6gJxUucz2MQtmQMX
    8Rhdv6jQSHXH3TILA>
X-ME-Received: <xmr:-kLnYtt58QotwdDNQGoN4Xs0s9ORH-ta9qg5WrNoYJZ_Oquc6_8Ly053D87TZZnFE5Ow84DLfyd2DFeRbBHYI4j7DKHBbr6s5i91kwOqU9-Bqq9iO1dmgGyPKEZBwcOLjS5HtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:-kLnYmYQEyFUZmMDY9NSd7o5zm_WrFl7rhK7Q8de0Ka-HryOt570iQ>
    <xmx:-kLnYsZjJQRp6oTenb8lh5zy56Mmr1mK49En-KDavyrfkZYAMWUgig>
    <xmx:-kLnYqD7_YpCiZRwRHEvZMytHXk2D4RatuePGIkZCjwZvyCSZi6Y5Q>
    <xmx:-0LnYmA2ionEInLI46JBXv5bjU-fuDsSmV6E6kGgtTYc5BGj3GmcMA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:05:30 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 6/9] soc: sunxi: sram: Return void from the release function
Date:   Sun, 31 Jul 2022 22:05:06 -0500
Message-Id: <20220801030509.21966-7-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801030509.21966-1-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org>
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

There is no point in returning an error here, as the caller can do
nothing about it. In fact, all callers already ignore the return value.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/sunxi_sram.c       | 8 +++-----
 include/linux/soc/sunxi/sunxi_sram.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 09754cd1d57d..9622fd45f5e5 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -261,25 +261,23 @@ int sunxi_sram_claim(struct device *dev)
 }
 EXPORT_SYMBOL(sunxi_sram_claim);
 
-int sunxi_sram_release(struct device *dev)
+void sunxi_sram_release(struct device *dev)
 {
 	const struct sunxi_sram_data *sram_data;
 	struct sunxi_sram_desc *sram_desc;
 
 	if (!dev || !dev->of_node)
-		return -EINVAL;
+		return;
 
 	sram_data = sunxi_sram_of_parse(dev->of_node, NULL);
 	if (IS_ERR(sram_data))
-		return -EINVAL;
+		return;
 
 	sram_desc = to_sram_desc(sram_data);
 
 	spin_lock(&sram_lock);
 	sram_desc->claimed = false;
 	spin_unlock(&sram_lock);
-
-	return 0;
 }
 EXPORT_SYMBOL(sunxi_sram_release);
 
diff --git a/include/linux/soc/sunxi/sunxi_sram.h b/include/linux/soc/sunxi/sunxi_sram.h
index c5f663bba9c2..60e274d1b821 100644
--- a/include/linux/soc/sunxi/sunxi_sram.h
+++ b/include/linux/soc/sunxi/sunxi_sram.h
@@ -14,6 +14,6 @@
 #define _SUNXI_SRAM_H_
 
 int sunxi_sram_claim(struct device *dev);
-int sunxi_sram_release(struct device *dev);
+void sunxi_sram_release(struct device *dev);
 
 #endif /* _SUNXI_SRAM_H_ */
-- 
2.35.1

