Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1888054DA88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359143AbiFPG0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359135AbiFPG0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:26:03 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38496546B5;
        Wed, 15 Jun 2022 23:26:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 566EE3200A40;
        Thu, 16 Jun 2022 02:26:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 Jun 2022 02:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655360759; x=1655447159; bh=bh
        uLv+Q2nSNM/p4QOnabQDlNKfFDhf2mr0itZ8fuvwo=; b=DWwCvKiU708Va+XgKd
        kuWv1eTwBzzhEfDyRjdQjdiLfMSZFnx0B3ygFTu/F1fg+mWnJ6a7q1qXQnEfQoUE
        ZXHWJbD1f08TPo081pbWRBHpp3vbv2Nn3eS6QCZvQrw3fF9B7X2DAq8HCSQti2Tk
        ibWRzG/r09PeeJhLPkgx63+p4xXaLw/iCmrcFfy5kO9BLHn5CKHoV45Oo4y2Q76L
        KEQKYASpD0OUmBK0YaXF3kxTvbizA8FrtdKrROx6ZMN74cmb4daGw29xvNpj0jHh
        zcJ3Iw3EfWYNxc3or/x/vdQkY5WljvZcYYW/PxhARKjLQA7JZh7DtL+MNS/O7Uma
        DDPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655360759; x=1655447159; bh=bhuLv+Q2nSNM/
        p4QOnabQDlNKfFDhf2mr0itZ8fuvwo=; b=Urq+w+FNFf1g5+WwlBbkpOFt5H4hr
        Ja0Q8zfzpGgCt117vjo1wWPvASYdHs8KBM0xz+ZGg+/F+qXY40NXCxL739jq5+z2
        yEgDv41ZaYnRI6Trrj/O1ROUl9M7rF1TTGA6evJPmjkxv+iRLTpvNRIXKStA8uzX
        nlYt/n7eZS34SSGCSCywwuS7jT7De+ZMtNkJsnqeyJPKPIoQZLJYFlcKUAzZxNs/
        0TuiaQyNfMM1XIXo9kkqNZQwbabxXuWjw5YpiGnGbriecN0NfK88eaROksReogV/
        6BKczhT/RyRadfpwuQ4eVw5c7pBRMvRaKXW02DXAZIggkhns+KykP+ECw==
X-ME-Sender: <xms:98yqYjwMb-C9YX14H997o8IOFEQ60ImGhb01YGEkSu6Av9ZqzwOctQ>
    <xme:98yqYrQ5jOuWcbZsvF517QooaxDnjXyMQjUqMGv_xTwXedSCn4vdSEz99d5hRbisI
    8IO5ogxzU8SiWhluA>
X-ME-Received: <xmr:98yqYtWh3Ie6pOuTtSOVb18vDDCwP17eQzvGzSyuaXgQpBgeIOXbRYPZPzqVWc1Xt8r78VCseQq3XhRosqkMeBmkdRD-vhxj314FQTdhB17PPRUipJshWedd9KaAK8R5z8cctw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:98yqYtixlT2LFqmpxTTsKUJ9v2kamxFT2MUEKZqBIvUa2yRTb_gGwQ>
    <xmx:98yqYlCN6DV7OvH2OlUhOycdT0dtvj9ZDGrfBg3Lc_4rrMiAx9gTGw>
    <xmx:98yqYmKnoAm0eVnNZCEOpHeWCJr5uKZfggaAV97rdtP0HwUHZfpmOQ>
    <xmx:98yqYtaSQHzcq7YnwC3IbA3qrnr09L3cF4tpVs46h6dzOydKBafIJQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:25:59 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 1/3] ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
Date:   Thu, 16 Jun 2022 01:25:52 -0500
Message-Id: <20220616062554.57266-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616062554.57266-1-samuel@sholland.org>
References: <20220616062554.57266-1-samuel@sholland.org>
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

From: Arnaud Ferraris <arnaud.ferraris@collabora.com>

In order to properly bias headset microphones, there should be a pull-up
resistor between pins HBIAS and MIC2P. This can be an external resistor,
but the codec also provides an internal 2.2K resistor which is enabled
by a register.

This patch adds a device-tree property to the sun50i-codec-analog driver
to take advantage of this feature.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
[Samuel: split binding and implementation patches]
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/sound/allwinner,sun50i-a64-codec-analog.yaml    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-a64-codec-analog.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-a64-codec-analog.yaml
index 3b764415c9ab..66859eb8f79a 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun50i-a64-codec-analog.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-a64-codec-analog.yaml
@@ -21,6 +21,11 @@ properties:
     description:
       Regulator for the headphone amplifier
 
+  allwinner,internal-bias-resistor:
+    description:
+      Enable the internal 2.2K bias resistor between HBIAS and MICDET pins
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.35.1

