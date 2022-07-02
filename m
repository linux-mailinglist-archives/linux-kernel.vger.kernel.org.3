Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC52556429F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiGBTw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiGBTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:52:54 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F88DB86E;
        Sat,  2 Jul 2022 12:52:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DF5A5C014B;
        Sat,  2 Jul 2022 15:52:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 02 Jul 2022 15:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656791572; x=1656877972; bh=Dj
        FZlHp72O7IBzp3RmRVMVRvDgHVGbv7Zp7dfDmVDwo=; b=bEtQMZjXuZ4nLFynQ1
        RIRJY7eE7PGlpl+jW30w8ce1aEPJyf/CQgkFF5WNKSw0JakyvhRyaeJgYz0SlJ7d
        VlIYtpJVs8DYm0/IaefvDF4UdOFsy1sLWC121G8PxBGiFsmyJFMsQJHCL+hbqDYj
        AnpqhEHR9fhkudVT8dhHSUqR/VCgRsj3JLF0iYxJgRze4uqEKCpKUry8AsaaDfX8
        c2QPPsur+xTdSk5AQ30tu5V/oLnXW43UOVG9SwHkBfk9VZGVwvrdDzWKB8AsQtgO
        CQdR56+hqSPHBrRvg4XUba66EuvwcoGkbJyDmkCecQ5a/ozpcUAlw0GM6w+A/bym
        3fPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656791572; x=1656877972; bh=DjFZlHp72O7IB
        zp3RmRVMVRvDgHVGbv7Zp7dfDmVDwo=; b=Oyoca94XpH0eNxRGkDO1zASlbxsj7
        4cE4Ym8zLzdo4KKaZl2ln9U4ExaBcLmv6OAlvOw6KmhPLP0gcj3ZG3sOD7uds/eh
        sbNSkE+O9AVLK4kogwPikU8fO1OgtuUErn4hJ2tZN5Ck8rwpRulZtQsH5auiTXHj
        mW75XyQC74ezj8BD5/5Z2dP0FGkRqVG75WoScEmBHNfnh9sYl6qZ6T24d+BthLSe
        VDaOY89pt4bYGDHo4xwTynfeVEVSrhPLyht8dcz+8whU7HDCLqy8G9PdWGHHFPUW
        a+dm0pJo5cqzWsC7kgutNIl49cDOUOhrQ0O1/HeUS2kbFUbSZ6GIv0ahg==
X-ME-Sender: <xms:FKLAYtQRjt_PWX9_hyHSpRehU8IvOm2f0iH-EcIg4OLNJ9aqvuuBNg>
    <xme:FKLAYmwr6GKF2BIEUlBRX-h_xrPZ6YVmYUDaafEr-tm9lE1xn5dYx725eXwpxB6iu
    iND_3YXkLDkn1IxSw>
X-ME-Received: <xmr:FKLAYi3dzVr5n9S3LZeaWOSEdHAOoJz5phOJ8hQMprY9oj_ENStilmSSqop7pmdi4WV5TAVoF-hAXDlYvvUtEKYus-Qnzt_rFlw0qRShdBA7MkTS1CE6Yy-DGGEY1lzc4XnIYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:FKLAYlAGvc4_BrVlWKmgUD0vcS7rv73MWl9j5kq3vSV1QAO1uAjrBw>
    <xmx:FKLAYmhUK0hJywg7MK-2iEn3ZRlz8JYFUiYFBg70a9Z3MucZvCjywg>
    <xmx:FKLAYpr8DimtaG1-AQNM6x1Ide-opdToNavD0MjSHy_vHPt38X8E3Q>
    <xmx:FKLAYrbQL3mNiuUHclGNw_bzjT0E_UexqSHuPkHpTTgWYZZqOxoJMA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 15:52:51 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: usb: sunxi-musb: Add Allwinner D1 compatible
Date:   Sat,  2 Jul 2022 14:52:47 -0500
Message-Id: <20220702195249.54160-2-samuel@sholland.org>
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

The MUSB controller in the Allwinner D1 has 10 endpoints, making it
compatible with the A33 variant of the hardware.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
index 933fa356d2ce..e5dbf4169bc9 100644
--- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
@@ -20,6 +20,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun8i-a83t-musb
+              - allwinner,sun20i-d1-musb
               - allwinner,sun50i-h6-musb
           - const: allwinner,sun8i-a33-musb
       - items:
-- 
2.35.1

