Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A13561711
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiF3KCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiF3KCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:02:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4BC43EDE;
        Thu, 30 Jun 2022 03:02:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 17EE65C02FC;
        Thu, 30 Jun 2022 06:02:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 30 Jun 2022 06:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1656583364; x=1656669764; bh=TAIcAgNNAp
        8QIpHYtRSOz7CgB2mDvAl/qh8TqyK3DN8=; b=kAh6BD1/2JQxR0GOot/3t8mSpi
        vycaf/hQi7/JQ4dG4h4VMpo17DAf8hfCNrN1inbvsJ7YxLvtAh12DTTQ4biXxQmS
        cQO9j5i0GRD1WVJbznGceotDIOfy40F2kbY3ou9mynkfUWYMQbHmrBHyGFry/fBZ
        Kd31DppBoaPDw9Hp0Y5CZRFvAmxlsJcvFKFtnAF+rWBKReDoTZfSBIfWiE+a4K0l
        c1eRcACljbAavkOfLoNpHaZPx0cs78wUWOBse/HuHge4rRC/Kok23I6xSY9x5IAZ
        YwUltXKxvO3mDWDQRwq1wY4Axiw9MGL7dJ99VoWLTZGNeeH/DS+Lfst0KLQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656583364; x=1656669764; bh=TAIcAgNNAp8QI
        pHYtRSOz7CgB2mDvAl/qh8TqyK3DN8=; b=DY8j6Sphwo6tsraAxL0XaL+iqKHvo
        SECDDRp1VCzTl/FX6UcQJtjXfNR+4we5qVwkcrfntQpzcuDTcJ69Ndpa8n2PA+2r
        x8Ny1TYPZvMyjH+oCTxOyKSBbUfzGp/JShj2ZH02VHERWvvorzxRqvYz17L/s2aq
        GTQge0JbZ9duyX7u3grnE+9SzxBGvny5VnL/mBUKVsi4CFM35g4oSbjXIm+sAZFb
        shQCKsyCcqHx2349tLpSzLQ/u52klDz6ga/ULao6UkpKF3V7QVwpgkOrxAfxZLGX
        LGh/DA2WJKEdZz/WoSGY+aM39DWO0eQPOyVneWuXgNfZLr+5ZQXc0vJmg==
X-ME-Sender: <xms:w3S9YkZxbMdgdMdH7ND4D-gjocW3k7dZLXI5f19oDYa9L7ZuhBTBzg>
    <xme:w3S9YvY6b7-Z3c7dO9bDRQduPp3XVdAj3eAdHstSNLASoRudMCT7nLwIg--YiSfiU
    dyy1B9-ChOXl-ByrQ>
X-ME-Received: <xmr:w3S9Yu92fReuoFg6kXGhyaWcbP7v3V5g-RgMKatddj-QYpJhcuDwWB_ud-nvAK6-JIY7wRI4-A1_1zEifXERD24AVf79EQLXzk1t_LRhNJet-1ukzo2Ym-6LRq6uVFK6cbK6jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeefkedvudekfeehgffgteekieehhfekfeegteefgfduhfffvdehvdet
    keegfefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:w3S9YurJfeQX2H8_wCkg5sdfNMLGcHSD09xum9Shj7UYN-msPa0haw>
    <xmx:w3S9Yvr48pi_BoW0cksUsZsuWPwu_fheEygwvQu43DvFBDF0S5BFew>
    <xmx:w3S9YsQ6gz4R6bl5pOwfWUjfEMmQEsn4wAsgLVwMoc6W0Vqb0LKBXA>
    <xmx:xHS9YvbemzsULfjHqmtTw3WTUNcwSByu2lDc_D36bJ44S0UF9pLXnA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 06:02:42 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/4] Add PLIC support for Renesas RZ/Five SoC / Fix T-HEAD PLIC edge flow
Date:   Thu, 30 Jun 2022 05:02:37 -0500
Message-Id: <20220630100241.35233-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patch series adds PLIC support for Renesas RZ/Five SoC.

Since the T-HEAD C900 PLIC has the same behavior, it also applies the
fix for that variant.

This series is an update of v2 of the RZ/Five series[0], and replaces
the separate T-HEAD series[1].

[0]: https://lore.kernel.org/linux-riscv/20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1]: https://lore.kernel.org/linux-riscv/20220627051257.38543-1-samuel@sholland.org/

Changes in v3:
 - Add a more detailed explanation for why #interrupt-cells differs
 - Add andestech,nceplic100 as a fallback compatible
 - Separate the conditional part of the binding into two blocks (one for
   the PLIC implementation and the other for the SoC integration)
 - Use a quirk bit for selecting the flow instead of a variant ID
 - Use the andestech,nceplic100 compatible to select the new behavior
 - Use handle_edge_irq instead of handle_fasteoi_ack_irq so .irq_ack
   always gets called
 - Do not set the handler name, as RISC-V selects GENERIC_IRQ_SHOW_LEVEL
 - Use the same name for plic_edge_chip as plic_chip

Changes in v2:
 - Fixed review comments pointed by Marc and Krzysztof.

Changes in v1:
 - Fixed review comments pointed by Rob and Geert.
 - Changed implementation for EDGE interrupt handling on Renesas RZ/Five
   SoC.

Lad Prabhakar (2):
  dt-bindings: interrupt-controller: sifive,plic: Document Renesas
    RZ/Five SoC
  irqchip/sifive-plic: Add support for Renesas RZ/Five SoC

Samuel Holland (2):
  dt-bindings: interrupt-controller: Require trigger type for T-HEAD
    PLIC
  irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger handling

 .../sifive,plic-1.0.0.yaml                    | 65 +++++++++++++--
 drivers/irqchip/irq-sifive-plic.c             | 80 +++++++++++++++++--
 2 files changed, 135 insertions(+), 10 deletions(-)

-- 
2.35.1

