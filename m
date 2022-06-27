Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD31155B75C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 07:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiF0FNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 01:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiF0FNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 01:13:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6212ADC3;
        Sun, 26 Jun 2022 22:13:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C3E545C00FC;
        Mon, 27 Jun 2022 01:12:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 Jun 2022 01:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1656306779; x=1656393179; bh=dkueX+p0HF
        YN1z2kkJI5unMCYjLIq2dF7wkxiC1Hy0g=; b=XQ6P+XfnaI1AmNkhMSzJl0yEyP
        WFde2eM+YF5jN2Z2CEJ+uYF+sFJ4OLTgq3VlHjdJrExFf2QP9CZjGQuW1rkU61Av
        L18Ttp5KonJEj5ce3vUQ3xb4cIpfZXIE74kh/+brUn0AUS3iLTjBPBUC7pzds/k+
        t6Mnm3a/jSh7Q7F0qmo7lzvlVcQnFYVI0e9Oe7PGNuLGVOsxOzNHEmOnJYfZC7zJ
        Yd+tTSxYqr0dR2lay4Xi4GdYab4ghofuQUwlRMNnkSEfaodBrefb9Ap9xrP1ehyG
        kKz63rpNi1WK0W9kV6FG7Giq78hMmaqXryxvtjmmDscZPl8sk/Kz4A8j12xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656306779; x=1656393179; bh=dkueX+p0HFYN1
        z2kkJI5unMCYjLIq2dF7wkxiC1Hy0g=; b=t6SDsjptSrlFMiBuvnxyMDicrWH4T
        H2tTDzHLzKigA7+PGp3tkoEZTiBLb9wLGItuKAAyALZtI8VJyql5WBm9n3M7EYp0
        KRv3T1Wq/n8e5cJP3FzZPKvHlf0pR7rBBBt7xSxR8whQQuLKYcBZcKuNIYgpX92U
        +EpSi/mgAl7u9DfSmxMm3CyIHcxsCcEdXn2OsDIyytrXKFIf3kTFzHNIVURmB7yS
        soHAcGiv7grHn5sl19XTmiYLfOMgEj1suynJoAjnI61NtqzfKUFqV76IzY7W2gCi
        3mE/KrpChugBABaXb4SrAACcTUGD+8SVAqkdYf9bCYYA/lwImloPNV67g==
X-ME-Sender: <xms:Wjy5YtpA9epOY7jZ_4B-DR82wBgYNd4GGXnf-BMFySik5TzFf4mmYg>
    <xme:Wjy5YvqUnn-zKWPUUrTZjHD_EQtnM6H43HopfooJF_hvoKmb-t7GuMRTRTK09HjaK
    KMLFsPAT-Ui91-HbA>
X-ME-Received: <xmr:Wjy5YqNiNuohVTQy4gxOkGs_oPPNA3Ynyttx-hnxTQklps_eWsRg5K7f1JxpjsMdMU7LMVonZtL1li-f1XLyIeQZyt6ftitQbg5WSlZ5KGiwUW5iXhwlPvhLV3RuI_8LvjfTdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeggedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeefkedvudekfeehgffgteekieehhfekfeegteefgfduhfffvdehvdet
    keegfefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:Wjy5Yo7d7SIKWlSRqO19nVFNUmQh1LKTD_zoGC84hPqr1qcHGrCOmQ>
    <xmx:Wjy5Ys6tgDOtNUXgKHycW4cLryTMwwpkf4KCOcLWWfGybqEZZucDHg>
    <xmx:Wjy5Ygixv-gXz66WozkAIBWqBuzeRgc7Cn4HSOQq_Ivd7UITaVqXjQ>
    <xmx:Wzy5YorWnMzBB7hupMhVjcJv19e4QLc_36RXBJ4C6vHVhIrycYGD-Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 01:12:57 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-renesas-soc@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 0/3] irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger handling
Date:   Mon, 27 Jun 2022 00:12:54 -0500
Message-Id: <20220627051257.38543-1-samuel@sholland.org>
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

This is a follow-up to the series "[PATCH v2 0/2] Add PLIC support for
Renesas RZ/Five SoC"[1].

The change made there is also needed for the already-supported T-HEAD
C9xx PLIC. So this binding change is necessary before I can send the
Allwinner D1 devicetree.

[1]: https://lore.kernel.org/linux-riscv/20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com/T/

Changes in v1:
 - Use a flag for enabling the changes instead of a variant ID
 - Use handle_edge_irq instead of handle_fasteoi_ack_irq
 - Do not set the handler name, as RISC-V selects GENERIC_IRQ_SHOW_LEVEL

Samuel Holland (3):
  dt-bindings: interrupt-controller: Require trigger type for T-HEAD
    PLIC
  irqchip/sifive-plic: Name the chip more generically
  irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger handling

 .../sifive,plic-1.0.0.yaml                    | 31 ++++++-
 drivers/irqchip/irq-sifive-plic.c             | 91 +++++++++++++++++--
 2 files changed, 108 insertions(+), 14 deletions(-)

-- 
2.35.1

