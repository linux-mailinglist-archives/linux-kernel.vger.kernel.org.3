Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D656429D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiGBTw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:52:54 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0523BF61;
        Sat,  2 Jul 2022 12:52:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C1AC5C013F;
        Sat,  2 Jul 2022 15:52:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 02 Jul 2022 15:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656791571; x=1656877971; bh=O8zr6Ut53pXgri28RQNnVr7KB
        XQK2o9i+KBa+QeAQqw=; b=lEA/gbnvzdCuko010G+69STc1CEIPGeH+m2Ybdhsn
        oYmcDl5MMgw8XXLSR74tBUvr2TKSpHYXpMVXCq+QN1UAMod1lUIv1BHjT1rWUFXD
        FOBWfFIKD6M7osRvF4MLGenVn+gThvT1t03KVNeZ2wp8XiisdVtYDEJNKS0vrJ5c
        WF1HxlUoRKS+93eE3JsjI4530L/Yj8k3FGU2J03MOtuN+HuZlAeC5bp9xpHZn2Gv
        Pg9WLe6f852xY0e/ej/mR8qfZfmWq5CdP1RchFOK8vvVxtaGOnyH5g4VTbHTIxMF
        bwZpupXbg85Y1TKP6eUfIVteFwQ+UhcT0Y7ooa7rstehg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656791571; x=1656877971; bh=O8zr6Ut53pXgri28RQNnVr7KBXQK2o9i+KB
        a+QeAQqw=; b=CdIH03UOQzAPjb2Cn+kFWBLoF9ohTbWiAbfvPulOcd0n4SrdhyC
        sfXnLn+FhFgQQMx8CZKRHYad83D30httbNtqh0LXxBUYrwONGCVIOTce2iVOItwM
        9mp81/bHjWjZSTHK8If6V1a9vy5MFvPcn2nxBUituISe5qbFW88maUcSXvw5UYnX
        7pchSHGYBNt9SqgOmFZSvH4L1XV9ro5isI8QXPs/TZTZIJowV1cRGIv0s3T8fvJW
        On/VpWLNDaPlOJrsYIQjxqLfmQCCorN/sHjvB+4Wquw7HcEaNpV3U20vLOzpk6pF
        DtHC5MNwzrii27m/+tedPd3MrBcHpGA2bzQ==
X-ME-Sender: <xms:E6LAYnfe248R6ZEz0DwRyLkTmewGen-UW0dzPMd4vuXJr79vO-vFbA>
    <xme:E6LAYtO-JlqHSG6O3N4rYyXEjJN-WZ_tie8Dw59toUoDzFHJsHq8icgMdXeVTXN3E
    9Ly-zkMEksDxxlAzQ>
X-ME-Received: <xmr:E6LAYggq1Q1xubKhMvofGmkVEDwnvEyA5KWz4Si5NOfutXRRuAicLE8vmHgWhTITazogawww5XhzEWCGivDm_uMdX7CWY-hlsrMm7NhHmYJQNrKYMDw8oFDbGRh_BEiIFA8_DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:E6LAYo-ByVtrU1HPdwAsXUBP42zis6SL5JKgLB6MSpGnXxaC6AKQBw>
    <xmx:E6LAYjtoSs1b3QnjVH7YaM1g750vz2feUYbhRorD14U0sjRGiLso3w>
    <xmx:E6LAYnH_nQNRitzEGQdibG2NHtyyHaVLLtR-m8SUR3p3k7izPgXs5A>
    <xmx:E6LAYkl_15_jgobRtDDO0mSqo_i5q87gTRDY9VualHtSadRZX9YX2Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 15:52:50 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: usb: Document Allwinner D1 compatibles
Date:   Sat,  2 Jul 2022 14:52:46 -0500
Message-Id: <20220702195249.54160-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

These patches document the compatible strings for the USB controllers in
the Allwinner D1 SoC, which require no special driver support.


Samuel Holland (3):
  dt-bindings: usb: sunxi-musb: Add Allwinner D1 compatible
  dt-bindings: usb: generic-ehci: Add Allwinner D1 compatible
  dt-bindings: usb: generic-ohci: Add Allwinner D1 compatible

 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
 Documentation/devicetree/bindings/usb/generic-ehci.yaml          | 1 +
 Documentation/devicetree/bindings/usb/generic-ohci.yaml          | 1 +
 3 files changed, 3 insertions(+)

-- 
2.35.1

