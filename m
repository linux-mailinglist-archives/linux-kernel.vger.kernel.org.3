Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1D5876B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiHBFcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHBFcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:32:21 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81933D5B2;
        Mon,  1 Aug 2022 22:32:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 61127320084E;
        Tue,  2 Aug 2022 01:32:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Aug 2022 01:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659418338; x=1659504738; bh=rb
        jmZkkk6X840fiGkFSA29gDLZhKU9eVHRzenL4cBYo=; b=I8GLtdlMaokbsOUJpD
        G3yvCu0flCzmXUVObfm49uDZmlvfZFBAQPk5EYZKCinJy+nQ1ddqsegtOhJVlEHJ
        Q97ugQeI2Tf92BPrDEaBWveGf96r5NQqC5CUwSXtjD2uan6+nDMvKFNx7CuWlWcG
        Nm48j9JxcoNJj1RwgyK7cdErKEdeGOsgt1b9oQFE2PfN1iTFw51w/z48OTLdcZfc
        CRyZ56oy9i0hAhilBZq4741HLVtJMCab2kc+UWT9uY5ikz3vCW9JaRdNX3PdIJbo
        WNDCy0vWLGFsEjm/miEYNGdk/huOSSLTaB5/Tfqx55GYBXKbk7Ez13HqJmcK6eEX
        y0PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659418338; x=1659504738; bh=rbjmZkkk6X840
        fiGkFSA29gDLZhKU9eVHRzenL4cBYo=; b=jb488zcMgHsnIHyypHZPExSR9CbpZ
        qRWR/P20NT2oJIJJlYqguu+XvjjgRiZQrqcP6lqX0u7SvDnbKEb6BLcLOW5Kp1It
        izTda/WLyDyI52ylz1Rfr+/sPbbUThYWOi7EVbbbNkRA11/TiaT4P6/AFLbQM6bF
        CfguOLFOxY7Ju1olWK25S4A0C8H96tIzVmG9NJwDEB1lXOYm9oKkIrbGh8CEejHv
        4Zs1Cu4rpx+VmA0jeXx54prIQ4HkKG8pBsvr7IMH1RkbpxZ0NxrUwJ9GZJHNh2zl
        E8XObz0Z5mctRhYVtOjtGBlEOgp9Lb68dfRa2Pvfe3Mezq9bRNza8/HJg==
X-ME-Sender: <xms:4rboYjkhHY2PN6XErUzxl-_yVOpHc9xr-FqBC1D-X-04ttF0xNGzLQ>
    <xme:4rboYm13wpfDGs94lP7OhZehSK9dJCOYSxkyiWXB65QfRWREVfo8QIxGB9g5on6JQ
    7sZQKrQxo36iR0AaQ>
X-ME-Received: <xmr:4rboYpof9er03Ojanx8n6N3C7KHj_qyNzR0pt7QL4fmpGczDVeLZImLGGUabJABrpqv9dhLp7Jh2PI-uIHepxifBtCiq-PqXBp5Ruvlp8eg2VO7gMmFVIN8oRk1MA469aO1HKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:4rboYrk8njdjMFzHSkaSUaDH1roDZ6zBttuTnQhsQ0j8NlwJwo15GQ>
    <xmx:4rboYh3VvX0amDjax8AWSZOiWWM7p9CUTe2Cqt-biJMRbg9cIDwt6g>
    <xmx:4rboYqtn7jTSIQWIn41lXxj0p94-cQbyh1rugOrF2loUbdpXL6pAkw>
    <xmx:4rboYqvoZ2pay0l1xOqhkZYrUtEc4tgqErhXeawUqJ-ff09gM0Bjog>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 01:32:18 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/4] dt-bindings: sram: sunxi-sram: Add optional regulators child
Date:   Tue,  2 Aug 2022 00:32:10 -0500
Message-Id: <20220802053213.3645-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220802053213.3645-1-samuel@sholland.org>
References: <20220802053213.3645-1-samuel@sholland.org>
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

Some sunxi SoCs have in-package regulators controlled by a register in
the system control MMIO block. Allow a child node for these regulators
in addition to SRAM child nodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - New patch for v2

 .../bindings/sram/allwinner,sun4i-a10-system-control.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index 1c426c211e36..cc57836b2906 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -56,6 +56,9 @@ properties:
 
   ranges: true
 
+  regulators:
+    type: object
+
 patternProperties:
   "^sram@[a-z0-9]+":
     type: object
-- 
2.35.1

