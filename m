Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FC536F31
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiE2DSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 23:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiE2DSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 23:18:24 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A6E5A5A3;
        Sat, 28 May 2022 20:18:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0141532007E8;
        Sat, 28 May 2022 23:18:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 28 May 2022 23:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1653794294; x=1653880694; bh=Ny
        KxUSmKaqeyg9xhREFC8EzxSPndaULx7tx1zibykuo=; b=nXc9ARkCFE5fNObRs2
        Mrwc1HMtw42AKrpMFHx3Eh0n1CBsNAyU0K1uF9aodnAVXX4ZUnPDS8IWSNcOvow/
        cHQaVRMYHXB2PtZPBUHV/ubtz+zUarGlDIG7/sJWWzN5TqqgasXGhYNEXLtWP9mc
        wUUVnpGylF9seoF1T1Q8CqBfreAxI6S4R+QBDQ0VAcCNI/S4KoxQ595Ee5lVwqeO
        S13ReM8/lozx9zUDbVCWEhIgPVqqmVZZtY+ioy/NOSIfQwIqTeYW8C080/9MlSHe
        7tbTCInDxHlc1fvAOSSbOngueXva3Uv0cnIcmP1CWtbjtl4/yBYLKqQis+NxsDtl
        T1XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653794294; x=1653880694; bh=NyKxUSmKaqeyg9xhREFC8EzxSPndaULx7tx
        1zibykuo=; b=DGKfAUMl/kgSq7mQr9inX79EZFwlwBfH5hNXO9O6hp5YVTbSnQF
        g87AE2vXJA0kWIXthWmgxCwyF1136G4r+GIxRGy6TlPwsfup+x5YrpTgmAaLSoyz
        zCNG5L/3XzjP7lDkbeVEE0GEDhV5K8Dytwrdyf77xC/cDf6CxCU+izbMxYJ6hrbq
        9IOnqJsWMd6x8OyOiim3P1yuNQbQEKaI4njcfmX2rcr9gEVM6QzuuNZNyRCpWLw3
        SnrlVm2sM8X9qjXHVsGSC5hi4FjLauRNdPFOgl1589Em6p8sIE82lEi1xOeAoyVN
        veSnfEgmZNs/P9ArK+vvgnJWwTGVaa6lbqA==
X-ME-Sender: <xms:9eWSYpxvhajMmkwMTlmRVAXFjI5CdlXBUmyJLproRMcC9HpAUH4a0g>
    <xme:9eWSYpTJ3BYbOuM9VVmtCjqjLbRAgqs_YBMGgd2dbhWOmeA4WCJdbg1_kr5xlnFg0
    wNsCYDGBgVl0YIUaA>
X-ME-Received: <xmr:9eWSYjUk7TxqthXe96zFUmG2_VF74_TpD8k6n4DxHW6ifW3Xn_oj6d6UdCllBcO3ZH6-Le5w32RYLoEu6LRxi2RpB63W9oNlscc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvohhmucfhihht
    iihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqnecugg
    ftrfgrthhtvghrnhepfeeivdegffeftefhkeeugfdvudetfedtieejuddugfejueektddv
    vdefueetgeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepthhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:9eWSYrh0P5sqeiQFuKCgtSytXR0jOqaJ9O3lbNafQoSKFfPR0yKicA>
    <xmx:9eWSYrDGxYLL499wkTJtzUS0xKOOilpn5y2CxoTDqb5mhi66LpnFAQ>
    <xmx:9eWSYkJV3qk02QJlFfWJqH3_eyjjd6ehrBJXG-oEqz2CwFr-7oIaLg>
    <xmx:9uWSYrzFQi9vWFjCAsC1CZ1tNymc-CtaX_YclSx2TH-nh4O_ol0wpg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 May 2022 23:18:10 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <x@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH 0/2] Add support for Pine64 PinePhonePro Linux phone
Date:   Sun, 29 May 2022 13:17:03 +1000
Message-Id: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.36.0
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

This series adds initial support for Pine64 PinePhonePro.

Tom Fitzhenry (2):
  dt-bindings: arm: rockchip: Add PinePhone Pro bindings
  arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 939 ++++++++++++++++++
 3 files changed, 945 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts

-- 
2.36.0

