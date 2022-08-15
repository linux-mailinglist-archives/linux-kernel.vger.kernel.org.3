Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC335928EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiHOFIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiHOFIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:08:36 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667715805;
        Sun, 14 Aug 2022 22:08:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 73D4932000F9;
        Mon, 15 Aug 2022 01:08:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Aug 2022 01:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660540111; x=1660626511; bh=eu
        QGQZqUZ1Z9aQSwujo85+L3ZO2tADUJRBsoaKtZF1w=; b=qR0hQKzb0PR//2+stD
        1HJyWHUGkhKTZKCuSKgr/TO3DAU2rMctB9FjwGvkrVzQteDxUHXNhnsfkmmpQLWf
        Na1m/l/bsbL/XoVDDox33jInqJLSjVC142t9LQKBuxzMnuxsK2X6NuPJjuGTNqvX
        kV9Qhm+EN09KluXO7BgU69tcYORY56rOz72/IAXbnfzQI5UIpro3mHLg0gJJxWn3
        I4UIAeZ3Z8UcyQ9M/40amOkqk3jCNJqg9vUMlV1yF7uGxJm4E0k3CLfxh6fjhQnI
        iqFsysTlyIVymrz36UhsIeYvwHWth30nsTLuuNWcGFhn/Na49zUAl3WoOa39JVt1
        KBrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660540111; x=1660626511; bh=euQGQZqUZ1Z9a
        QSwujo85+L3ZO2tADUJRBsoaKtZF1w=; b=FqzCJQiYXY1+ObeUDE8O0xSg2XruU
        nfF9wCtuf78lSZIOLVaAnoCNeBLXCXuZZq2dS4mnpKZf+5G6lZUxSFB/0EKPimIU
        UTeGQu3fAmxldKh3hm5Leag14lfqF57OLX+V3+LYSMvBCctDSjhol6SPDsngakBu
        duSzzih6I/UIaum+rOxgomDkUqXn0BV7hphBvKw8jUvYW+I8AlfSQg6UGJ/APHI/
        Mk6oRBbgjcbIVVd3rloNErPsLec4DUF5W7b2PJCfllmIzUjDafevXX9cRSs1aF+g
        v7PvrMuYubR+fNuWY5o5gVlfoWSQu4kh9SpV740tUDOngdZLUbnrmxG1w==
X-ME-Sender: <xms:z9T5Ylf8VK9tm_ESQbkoM4790_VzfOvkDfK-sqtq6telt3GnMfAYSw>
    <xme:z9T5YjO3D1zhRpctwS_v3AGpLPucVlQGbhJueWL3EOA1jqHKaNyo8aPphvYC_UROZ
    Da6QKf3irsf3j50Fw>
X-ME-Received: <xmr:z9T5YugqrWVscwI6PGmTSPKIZllgAw5xOY-3biMo5-2jEeo4-QnggloQXCTbkbrufQ8M6I59WaY2Ox0oahl06_nOUmy0d6naECU__HFbe-2QwLKZlAEIm2zBeHlJRRqcoT8ZFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:z9T5Yu8gC-IwUZyRurVUzNsTTg7_XQRVlmCKSsDPlrUffMOEVzhq3g>
    <xmx:z9T5YhuE6xi2S5Lb0cymdLy82hBumyjlFivDbR0B2UNA56E_ULxUVQ>
    <xmx:z9T5YtEdwuiRjx9olShMUzYph4LPyLwEB39UcY-m99_es66WJPp3gQ>
    <xmx:z9T5YilTd7ftAY0kp20E2Z1PlKbYTEdu1eRQ4p773VEt0H9C0XkedQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 01:08:31 -0400 (EDT)
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
Subject: [PATCH 05/12] riscv: Add the Allwinner SoC family Kconfig option
Date:   Mon, 15 Aug 2022 00:08:08 -0500
Message-Id: <20220815050815.22340-6-samuel@sholland.org>
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

Allwinner manufactures the sunxi family of application processors. This
includes the "sun8i" series of ARMv7 SoCs, the "sun50i" series of ARMv8
SoCs, and now the "sun20i" series of 64-bit RISC-V SoCs.

The first SoC in the sun20i series is D1, containing a single T-HEAD
C906 core. D1s is a low-pin-count variant of D1 with co-packaged DRAM.

Most peripherals are shared across the entire chip family. In fact, the
ARMv7 T113 SoC is pin-compatible and almost entirely register-compatible
with the D1s.

This means many existing device drivers can be reused. To facilitate
this reuse, name the symbol ARCH_SUNXI, since that is what the existing
drivers have as their dependency.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/Kconfig.socs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..1caacbfac1a5 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,5 +1,14 @@
 menu "SoC selection"
 
+config ARCH_SUNXI
+	bool "Allwinner sun20i SoCs"
+	select ERRATA_THEAD if MMU && !XIP_KERNEL
+	select SIFIVE_PLIC
+	select SUN4I_TIMER
+	help
+	  This enables support for Allwinner sun20i platform hardware,
+	  including boards based on the D1 and D1s SoCs.
+
 config SOC_MICROCHIP_POLARFIRE
 	bool "Microchip PolarFire SoCs"
 	select MCHP_CLK_MPFS
-- 
2.35.1

