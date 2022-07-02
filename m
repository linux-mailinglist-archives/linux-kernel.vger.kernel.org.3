Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB85642A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiGBTxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiGBTwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:52:55 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5467B86E;
        Sat,  2 Jul 2022 12:52:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 536175C0152;
        Sat,  2 Jul 2022 15:52:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 02 Jul 2022 15:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656791574; x=1656877974; bh=Yv
        Glt1rTnRirLsLlAHuPoEj1EgT6NLZWDvwyEakI4Yw=; b=E3dXktjJI4YfkXGADb
        eKG5xZsEihcJ6i8ApIDeOxgD5Kz0TzxWygPax/Hhbcofhr9P+wGwePZxZuluAsnF
        lpZSBmdWOe+6ztJ+ycEWH4/7x9Zi37ntFe/eCw+bD+uI7s0h0uppSDReHNMJb+7q
        MKcSAS30iTJRHQKm8ttM8Oahcd/XRZsMCkejfn+phezurkQWUsp3q5XVBnmY0jkU
        pFXvxOmKCxhvXl5bfsoXcTeapqm+OJNHIXQqb1GPSfwTNKvDk/WKezxUaaHjNhGI
        Ia/ajslSJNKT0kMBc2EbfSp/Mhp9CwZa3BFZPL7ox3mbv4HHqmmJea/khw8Ryzfm
        CTRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656791574; x=1656877974; bh=YvGlt1rTnRirL
        sLlAHuPoEj1EgT6NLZWDvwyEakI4Yw=; b=gYHsLMtTqjrDlQz2TtxP+U5mxcI5l
        QWVff78oezSaIDDUm3rH9fGaocmw8hD+LyWtB7a0vlHyWRae2c0RespO1I46o7Co
        3R0GipqDs5/emYI1ec2A+ZEdcqZCu4jjlIOWUHFj3VRbMQ5KFnrWWLoRU1g+cgJS
        RAtURFkzWGGyhXjYKX6Mh0QaFaNE/1OTBqbj9BukeIoDUp+cQ+5NW0r43Zc6SRlz
        UiGmQ2NvSCtKCskll1TzqCgXBkPX61beDKZJ3jo6FOa0I3MTnKM2jIi3yxw7aw/1
        wVxGhu63ia7wBO65TV1f9QI93RoE5Z81KbDhkWqwhZNg3rQFoghSBiwXg==
X-ME-Sender: <xms:FqLAYkL-oEgcpV73YpN3YSezNc1m387JiEtOk7FUGWW4C7yGQd04-w>
    <xme:FqLAYkKqyXlkaBT0zIGa7RCPIe82k2LOlGlDut4jBINISUAFuu4DENurMPcZUCImN
    xVMyUk6ugtLlGJZtQ>
X-ME-Received: <xmr:FqLAYksiDTJmoLhAtkawd7IQkRteMMWkuoyhkAZPpq2vh-gezLeUCBUbE0XgfW8luk8Fyfipzl8uZaO9ra79GxMEUOhlHWO5eVcAlJ2kNzfHzxBXh_ex8ZtCotFZY4y_GE1B8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:FqLAYhZobgj03oOQKCXUpSQBgsZAruSr_LJ2hzUOgYftVr-XXjoHxg>
    <xmx:FqLAYrbZEQ0cYkf_sLYRSEU6pj5FwT5C5A51DqC_RERWZMULIMjU1w>
    <xmx:FqLAYtDS4aKW2DKHss7k8tLhxd___CzUJ7ir9dgXwFh3mZ4cVupeVQ>
    <xmx:FqLAYoRFGuykpNYcbpxL76K3ZKf2GbkdyxSfxddzWIFbUdJX1-Eisg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 15:52:53 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: usb: generic-ohci: Add Allwinner D1 compatible
Date:   Sat,  2 Jul 2022 14:52:49 -0500
Message-Id: <20220702195249.54160-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220702195249.54160-1-samuel@sholland.org>
References: <20220702195249.54160-1-samuel@sholland.org>
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

The Allwinner D1 contains USB controllers which claim to be compatible
with the OHCI specification version 1.0a.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index bb6bbd5f129d..180361b79f52 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -28,6 +28,7 @@ properties:
               - allwinner,sun8i-h3-ohci
               - allwinner,sun8i-r40-ohci
               - allwinner,sun9i-a80-ohci
+              - allwinner,sun20i-d1-ohci
               - brcm,bcm3384-ohci
               - brcm,bcm63268-ohci
               - brcm,bcm6328-ohci
-- 
2.35.1

