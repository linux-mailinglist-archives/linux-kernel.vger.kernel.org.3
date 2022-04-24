Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A419050D40D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiDXRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDXRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:42:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4A15CE92
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 10:39:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EF9375C0195;
        Sun, 24 Apr 2022 13:39:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 24 Apr 2022 13:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1650821993; x=1650908393; bh=Q0fUmUpjk4ehqpKV88l8lG4g2
        rimPdp92Zdhdby1yW4=; b=OM3WFx/ewbae8l4vvMBR5e8scIiEXmBxc+KVStoeg
        DnvG4pcfR98whawG9yjdx9N6Hp0hvKO9KqIQjXGIdAZkbLaSYOPguqJiyZokOBb8
        ehqilgugAbz//ndHt82lOf1mCmXgvywDmqeDcrfy5fWnjLWWeyZSBoaN6h0vooTv
        hnKqbnTbzEALhqN8eteNXPFuMq4URhRJRv6PwbUHRfh2HthuN7JvsXTH3RA/M/9+
        2fayKpQ/radeJLaQtlw9GTCv946mUolvi6nqc+e0cfNCZNZq1wXvQQWHgCdleXiv
        ll+0r1rOvNqV6sZCANDo3M9s+K6l+snXFBG1n1ABfWqXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650821993; x=1650908393; bh=Q
        0fUmUpjk4ehqpKV88l8lG4g2rimPdp92Zdhdby1yW4=; b=KSHXLk4dO5MlF12Bs
        mZG0zdiMxeR1LsktTdF5Imu66EapGffyF9U3feFOL84J+y68JRtNhEWGjIEA2x6z
        DT/0ttrRhIvgBgznJJDvenX0+GAjtuTwDpMB87ZBdppibEWxXim7hkp99eu97UVz
        qbb9L2H/45ldFxZHEi91gQyg92aMSKiqsFbl13SwdToVblLpXU4gSpOzGSq9I75g
        2O8BjA1QwXlyV9gjErwYZSmlAdVehiEP6stey6BigmJD1lmKQB5RPWUaPcmy7lYX
        gdrcwIfisOWbz9U/QrDD+8k6Ac+m7S21Ual4EA8X4v1NvYUBF+Q+LqEfJj1IHOSw
        XAN7g==
X-ME-Sender: <xms:aYtlYlvdZw1X3u2hn4yQhhhk4ScV-tSOAFgjzkzvC4qhC6B7NR9Qcw>
    <xme:aYtlYucd80ehnAhsyB2uwuvq-M3p5n5LAAJnk8t9DT82aOC_4PLVrLawBVMueZioM
    Yjm-fdZuNaruWpb5w>
X-ME-Received: <xmr:aYtlYoydteku-Mu4Rbv8VUhIsR079UjTRo70elw0s78MZIRPTHFgMC6IIwlN83t7ZM2IKRCwaoE-fUOSPN1CHt3pdzorY0brVgl7y3j47ZvTMsjY5GwLuWHlh5FXbS_gh2vJ_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:aYtlYsNI05f252_LVUXM317n4k3HnCDUqjIILoDpnEBkdG_Sbvzy5w>
    <xmx:aYtlYl_xXOJ58XgvY4nhomk_VQPiVb0z9u6NwXVZZXJmNIKPZTj2vA>
    <xmx:aYtlYsW76EjvBZbE6G0C3paZpmlRGmK-3d6-TZKL4pGs5MJ9-z2ehQ>
    <xmx:aYtlYuPvC0pKqnoFI6R3usONzZWt5c8rqLKTJLz-9Biz8wp_VSBUpA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 13:39:53 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        kernel test robot <lkp@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] irqchip/sun6i-r: Use NULL for chip_data
Date:   Sun, 24 Apr 2022 12:39:51 -0500
Message-Id: <20220424173952.36591-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains about using an integer as a NULL pointer.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/irqchip/irq-sun6i-r.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index 4cd3e533740b..a01e44049415 100644
--- a/drivers/irqchip/irq-sun6i-r.c
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -249,11 +249,13 @@ static int sun6i_r_intc_domain_alloc(struct irq_domain *domain,
 	for (i = 0; i < nr_irqs; ++i, ++hwirq, ++virq) {
 		if (hwirq == nmi_hwirq) {
 			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-						      &sun6i_r_intc_nmi_chip, 0);
+						      &sun6i_r_intc_nmi_chip,
+						      NULL);
 			irq_set_handler(virq, handle_fasteoi_ack_irq);
 		} else {
 			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-						      &sun6i_r_intc_wakeup_chip, 0);
+						      &sun6i_r_intc_wakeup_chip,
+						      NULL);
 		}
 	}
 
-- 
2.35.1

