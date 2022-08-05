Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DDC58B2DE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbiHEXom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbiHEXoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:44:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFA31A833;
        Fri,  5 Aug 2022 16:44:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 844DA5C0124;
        Fri,  5 Aug 2022 19:44:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 05 Aug 2022 19:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1659743075; x=1659829475; bh=2y58Lps8rGJPPf3cNfbkq8iW5KpGuxxOYPt
        10jAJuxU=; b=LjvUniO/HnuDxn8egcBot+hst5sI9uEegDfbmuxt9ncZ7aln/Dg
        xMcveYXSL0y67JH/9yTgWtaFpwatjegucGNqkZPSPjzUb3mREdi74ZwFprvdBYrW
        gAlWqZGCgYvAuPT8eMS91ObPKsg/7jTJVkvdR9oqI71Pcvg13AiPjRlykPVfqfyV
        Z3fmALVV39F5j7BppoFqGxXb4f+e+9mlYOmVoBQDLjflbp5mK9u0P/NuNHT2vV7v
        UH1So+F/r9ijXh0YmSy55BID6XNW5/oYNiqZ9gbd2p64D6WvfgRjNE2im0QxT7tS
        lOISn8alwi7L9f0tpeN0h/GBCK1XATHtgnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659743075; x=1659829475; bh=2y58Lps8rGJPP
        f3cNfbkq8iW5KpGuxxOYPt10jAJuxU=; b=CjdeuTt9rIS0/mk0igc+udF3Yv6H+
        Ayk0BhbR01BaMcUuii/4F9+3Dx/tQxsjkEyNLeld0uRj0TojX9937ESR5wR+b1dH
        R54tX2ExioCUerLvoHj8QtEBzRWNgK2jlcSBnLEND/MYvxmK/8rAl8dPkiTVJYI7
        yGRCzeuNcOyI9SovA6AOKoGO1lFqyvUUd8VBVjUM7ccoc/blWsvk+DU6nbk7J0uz
        Y7ijY4svaf7FjGPRL0AAUOo6mFdy/6YPUmJYjJhAKwLG/wOLADnGE3HRHjsCFaPs
        70etyIharGJQw+V6uqdvaDZ9FsCtwUT28+Hx8zi9ZYwDC363GwB4t0SUg==
X-ME-Sender: <xms:YqvtYnzXq4ARIMlTAwygjtOEg4HrX_XRJ9OI3YJGrlcU0SDPjGs5dQ>
    <xme:YqvtYvRDCqMDYmyTJE_22nSnKNONcpdDDQFlKkEhLtRzUaRX6FAsxmnE7yIbxpxuH
    AHZMlmjCbIeK_LPOw>
X-ME-Received: <xmr:YqvtYhV_vNheGu-90XvajB51wW3OeahVGmvXeX6Ypsi27M0A5MI0f64ypwAn9TVmFv0kHdeN0y8llyvQI-MmMQYQDB_MlgmXIW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefvddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepvfhomhcuhfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhf
    ihhtiihhvghnrhihrdhmvgdruhhkqeenucggtffrrghtthgvrhhnpedtgfetudehleejie
    eiudevhefhgfefleevvdejhfduteduheduffelfeffueehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvg
    hnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:YqvtYhhmrkToqBYwlpGGPUPNW0Oueg5DYofV54uXjDYhyVE5OkNVOw>
    <xmx:YqvtYpDMXhgMbsE-G1EPiocCjD8xstcrV5cCjgswy7RaW-Jsr3U9fA>
    <xmx:YqvtYqIVzYG0-Egz_DrV3d54S_p7-d-tqNFVEMDIUkDpSLvf-ksePQ>
    <xmx:Y6vtYhwFrIyUEqbS0f9-T2uG_O_Ws-YBrLcyon36iXJrTAURNXuqzg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 19:44:31 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     tom@tom-fitzhenry.me.uk, megi@xff.cz, martijn@brixit.nl,
        ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for the Pine64 PinePhone Pro phone
Date:   Sat,  6 Aug 2022 09:44:08 +1000
Message-Id: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

PinePhone Pro is a RK3399 based phone produced by Pine64.

Add a basic DTS for it. This is a working base that will allow myself and
others to add more nodes.

Changes since v1:
* Simplified the DT to a minimal base.
* Introduced the RK3399-T OPPs.

Samuel Dionne-Riel (1):
  arm64: dts: rockchip: Add RK3399-T opp

Tom Fitzhenry (2):
  dt-bindings: arm: rockchip: Add PinePhone Pro bindings
  arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 385 ++++++++++++++++++
 .../arm64/boot/dts/rockchip/rk3399-t-opp.dtsi | 118 ++++++
 4 files changed, 509 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi

-- 
2.37.1

