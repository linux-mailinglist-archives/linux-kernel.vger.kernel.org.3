Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811E14FEDF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiDMD6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiDMD6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:58:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB74E13CCE;
        Tue, 12 Apr 2022 20:56:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A3DDB5C01EB;
        Tue, 12 Apr 2022 23:56:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Apr 2022 23:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1649822176; x=1649908576; bh=fRGpBGjSVcQ6tiwpq8TxsX90l
        LVaDJpSbkukOVqXDTw=; b=L6S1WLsskO/cv/yisL4TmjWXOC31pQPCvtwkCVWCH
        2xY1/4PxmaTD/x2ZYNM2417xgPAPSBO+iU/fDqK0LXpFEV1+LrWxJM8jRiNtkRa5
        sqlihAXp3oKqIm6gcrqvq9prxf+9vSO2h12UE41MOfWbt5mAs0IJpOCVEsGz6MS9
        7hnBFv2eFhRZv/YTR5mNmIVtCZpWVwtBZFMoast3Hmljz2aMDoWdNO3O2J5h2f7B
        GS/5Kz2vOxP5gNEmFVNZ6Xn0YBrqans5hkHc/WOFLcjvKgHMQK11rZ85+h4UWU5q
        MpMykS2YbzryXxZXVkhUZpeT4aALDn4H+CYzg9mp1pSYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1649822176; x=1649908576; bh=f
        RGpBGjSVcQ6tiwpq8TxsX90lLVaDJpSbkukOVqXDTw=; b=wNIbUQ1sB2KJytUC0
        QhGpepVZPg57KFnRt/4BVqSszESDSWZ8eS2xJgfQHORgJO8vNwiVabolif38T3j9
        FpGcVAavQ1DHufGfpYM7w6Sgc/oH0FKVXd8Ts1HPGQIXu5MhTFdCiEVQDXr1x9g5
        G9EnkCh5i9lOyqwwi/H8zCG/U5LG2/Q8emq6f4+xR7Bwk18JVmru9c6JIW5xOnLo
        uJtU/gJT641x1M4nG6Lt16Htq2dzeRh/OI0xYdb9v3I/TWwSNA2gZoAWHN8ivHsi
        tJ2z9549u0QOVE8u3zxOF4t6ZLWbeDIJmcY8m+81TOx1f5fIrZ6CAK5/+HEFiXhi
        iJzPQ==
X-ME-Sender: <xms:4ElWYvfsLLVHt7b1DzSaMS9ShVOR1hk2MRGwmmei5qMwxsv_jwIKKw>
    <xme:4ElWYlPrsG6LooY_Fs3smteeKm30GnrUaO6XwPSxEwLd77k0Sl8pJnTnKe-y587k5
    gHivXvMLXUYMi-UCQ>
X-ME-Received: <xmr:4ElWYogcpfaIxKHwec1fnadco4S_jy6l1mGdax00yzD1SEkrN9TQxZeI1CmoKryp06Jq5M-syLd6SN44Y_2cQbWXfovCzYs1Z_1m2VcnlssrKzrrQzkZ-e8hqKTMB_CKkpAqBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:4ElWYg_CMt6ZLY5Fdmhcfd-9iSD8_hxO9WeYAv8EZg2WBhEkUzB_fA>
    <xmx:4ElWYrveDVrnLXmYk6R9T3wxex9ZoMRmRqS3jtwC-5tEjRvBzM77Gg>
    <xmx:4ElWYvFzTs02XINMclpQoLns6K33H2jB70XXVV83bcdw1rvCxJAoZQ>
    <xmx:4ElWYvh9mwUaaTbtuw8qRyf-SqTywapvUEYUy0y_xCWhJowdxlYTmA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 23:56:16 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: rockchip: pinenote: Enable more hardware
Date:   Tue, 12 Apr 2022 22:56:12 -0500
Message-Id: <20220413035614.31045-1-samuel@sholland.org>
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

This series adds support for some features in the PineNote that had
devicetree bindings or SoC support merged since the board was added.


Samuel Holland (2):
  arm64: dts: rockchip: pinenote: Add accelerometer
  arm64: dts: rockchip: pinenote: Add USB and TCPC

 .../boot/dts/rockchip/rk3566-pinenote.dtsi    | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

-- 
2.35.1

