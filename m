Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52C25925D1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiHNRhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiHNRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:37:09 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C5718E16;
        Sun, 14 Aug 2022 10:37:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1BD7332005D8;
        Sun, 14 Aug 2022 13:37:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 14 Aug 2022 13:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660498626; x=1660585026; bh=xi
        U7IRPMNLk0arJJTv9Kxlo5S5AdCZsEw7U2Eez5uBU=; b=fPJXclQTgKq7RuTwZ+
        ZN2TwZq0Dc4k7H/TvWc9qvNGG7A5ITQRqllbKuS3y7tU4a0osROFVikhNz+B0mFU
        KgC9dyj7bzSsSAbPooNg0dk9fQM0sl/X+jMdxt1pUSsRCcwlQRmqjJz3CrCpvbEk
        aq4Aru56AJuZbOYAJpKlucFYjF69cYEjNQ547/VPKH6PHpbZht+kSLploYeR21aQ
        DmWPJ6sslNYsYOkXYdBFmJQFQ0ghVEOo1qKrmsfpK5cQKdeR7/RfY3+KsRLUdTyU
        lGKBFr+LlWmVL23wAZo0eD6wzCrfnXNG9Lpp8UjyO1wgzggwVHnMG9ZP1Zm6x8pU
        mz2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660498626; x=1660585026; bh=xiU7IRPMNLk0a
        rJJTv9Kxlo5S5AdCZsEw7U2Eez5uBU=; b=d0B8NR3yqwnyW62q+k1VhKT9o2Bxn
        ISbGocfab5k5XqCDFhaQWGYuNCJBP0Iz6seafQBwsblxs79DPy83inuz/rnaxqYM
        9LcLZknUOeht1IThYC1vx5eUr2v1MNJUQbqpZVi03bAZd4mVPDVGjomQqHdkzhR0
        8LhE5NofIN8qHN5lui4y67a+fZiEW5VL1PG0SI0ePG0Zy1o4bfl0rlxrPakQHKo+
        wo3PeT9HkisIwYWatn5zBgA+zo9Nv1I8d6+RFbVCIucnf26812/mrjgsEoo2jNAk
        1ggBwApEjO/5Lcle+54l2Z+H4BFoPwNkYy3FUryqVoY4mEF/R+MxI2RIg==
X-ME-Sender: <xms:wjL5Ys6TTNlBp7Q4q5rWUekGHVfTtoDovFjF-Xu-9SWInVNWuLJizw>
    <xme:wjL5Yt4eRIAxdk5Cxj8PbHNdv4uX45Y_xs7yz_toYqZCaDXrzclm4-7zpwjNjvQF9
    gDraqeCK74fAV1j7A>
X-ME-Received: <xmr:wjL5YrfwxMAH4b97ncfug5N42u-LJG1TKD6u0GcjcRbmqyi5cN1MbW_ygXTyBxRkOXDz5tC0ypr9R1Ieu15wPZuMJ0PgFbc8n6FZ06t7frdgHN5XMRukuHLDtTYRPH6JYJMZ6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehtddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:wjL5YhJUtuMb815D5sc4EgWRtvXaO3EoCzntvdgGdf9HzYUG_GcVpA>
    <xmx:wjL5YgK8BR27k27xtlBaCPfuEuDN7tO6JoQ1-z1ISPFFEqpNPrK8iA>
    <xmx:wjL5Yix1GRHTymeD6rmRkk29_GdL-OiB5vO2YdALWe-rG_Jcs9MZwg>
    <xmx:wjL5YlWdMDOLmmZZiJwLS_bVNqWn1EZIhTP1tzoKmiublS3pqiAm2w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 13:37:05 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 3/4] dt-bindings: nvmem: Allow bit offsets greater than a byte
Date:   Sun, 14 Aug 2022 12:36:54 -0500
Message-Id: <20220814173656.11856-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814173656.11856-1-samuel@sholland.org>
References: <20220814173656.11856-1-samuel@sholland.org>
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

Some NVMEM devices contain cells which do not start at a multiple of the
device's stride. However, the "reg" property of a cell must be aligned
to its provider device's stride.

These cells can be represented in the DT using the "bits" property if
that property allows offsets up to the full stride. 63 is chosen
assuming that NVMEM devices will not have strides larger than 8 bytes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 3bb349c634cb..4f440ab6a13c 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -53,7 +53,7 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32-array
         items:
           - minimum: 0
-            maximum: 7
+            maximum: 63
             description:
               Offset in bit within the address range specified by reg.
           - minimum: 1
-- 
2.35.1

