Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C925928F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiHOFId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiHOFI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:08:26 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DEF140FE;
        Sun, 14 Aug 2022 22:08:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2F79232004AE;
        Mon, 15 Aug 2022 01:08:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 01:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660540103; x=1660626503; bh=29
        uAAq1TVY/O7ZEUaRe+3LcWY61wpaNsGqYURHUMEAQ=; b=Lv40otdXtr3OwindnT
        WjgvPehS8V6WPGFcblD/hR1waOQkqGMjINtWzTvfMc9n79ZAG2e8+RN0+L3rgPTj
        l/7hKUTjvkzNtdB1XFtc1eUgKTTecpVco3fZ/RYsB1P5m88BRDNxPoFuzqim+3D7
        pf0eLDvwd5x9OC3PFPOHjYVR7XLyP69P3HHEUKgxAQwXp493L7cfUqqEl21gN9qx
        zp0BT269U1qhmj/3s9Pc6HhJC0ONNyj0QvYpyGkLLuQRQt2pwslDX7KgfmSWflhK
        pKmRPqyoaO3k//oYYrXO0ZW5zMRF4NM8Wdpe+QTj9VRW3ImjFnZBlirb7zSkFM7Y
        swtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660540103; x=1660626503; bh=29uAAq1TVY/O7
        ZEUaRe+3LcWY61wpaNsGqYURHUMEAQ=; b=QE0kSkO9TDbjd71LqM6FjE1EYAG82
        eyJNBrE6n0W3mOl1qwtdGRa+GsK6dreQ0ydKJNijL8TS4mSkA+d8KCQ/Tqe9FDnU
        a1K/Bs0LMG9BbcuJDFMygPaMjk+btMra8wcQKkLLKP5lHe5GZY7TVOb9GAlvvVRr
        9YnKA/HP+BkVKXeMGlRgSPf99I0qEXXOlRN+efuuTy/+ctdx+kMEmP8U+ibxlliP
        tECM8hvYyG5l8iWonuWSWgMlsNa99Upe4oMWndA/26eAXc8qtmDyjIk4gQHN6IuV
        13+wHLL6y10Y5bUxz3EI1L9ttQGLft5g30VPBetqS44H3Taj4DLyIiqaQ==
X-ME-Sender: <xms:x9T5YiO6IUTkHwAMlkM6Bs2tZ3oszi9Tt4Sd8f7V6lCE0yC0VLKikg>
    <xme:x9T5Yg_P0Yln4UTTEQks2EjDfVIxPqHZM4nPwA7tBc9gVdbvwbXg40NQtC9JEohNI
    CftQrvyS0VzGa2PgQ>
X-ME-Received: <xmr:x9T5YpT7kAl1f7E2aoXDm1edp98oGM2g91RaFhe5Mx1mthWjkMNahjigDc4mo8sSuZIrxYgdqNInSC14XlkAaVxeU6dezAwDwQFD2SpDggWB_YuQJEBHN9tzrZTWNHauYpgB8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:x9T5YiuCFd4EIQkQDy39U45BVL4gP1qnft-kynxLRcUwUfRGSpn02w>
    <xmx:x9T5YqfSAmjtfdaXRzqr3irzB59utULy6H_i3nveU1b3FAUCq8BjYg>
    <xmx:x9T5Ym1XUFftOcEdsAsTQyPrxQlhlHS9WurXL2rE2V16j8N-IImB6w>
    <xmx:x9T5YrVcbxL3GRyZDRK4VkEphlWqSlJtrDKkOyV2xs7hm33VTSqaZQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 01:08:22 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 02/12] dt-bindings: riscv: Add T-HEAD C906 and C910 compatibles
Date:   Mon, 15 Aug 2022 00:08:05 -0500
Message-Id: <20220815050815.22340-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815050815.22340-1-samuel@sholland.org>
References: <20220815050815.22340-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C906 and C910 are RISC-V CPU cores from T-HEAD Semiconductor.
Notably, the C906 core is used in the Allwinner D1 SoC.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 873dd12f6e89..ce2161d9115a 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -38,6 +38,8 @@ properties:
               - sifive,u5
               - sifive,u7
               - canaan,k210
+              - thead,c906
+              - thead,c910
           - const: riscv
       - items:
           - enum:
-- 
2.35.1

