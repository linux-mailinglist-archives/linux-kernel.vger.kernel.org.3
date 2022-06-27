Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6367455B794
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 07:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiF0FNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 01:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiF0FND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 01:13:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0902BFB;
        Sun, 26 Jun 2022 22:13:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CD7A5C00E5;
        Mon, 27 Jun 2022 01:13:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 27 Jun 2022 01:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656306782; x=1656393182; bh=90
        4GOKdujIzG+lXqqN6R8S+IQA88lTLYQXPZ4MZDHfo=; b=gU6c+UQZzR1bHbD0Y0
        Y1X5WqhqLKS2qzLBp6VZODkeZTrum83ll8H11JMZ3hPJdIlMIzviMLlvreyxm39G
        zmxRkOjWWX39Nov4ktAzMPh9SjtFNnLpZ9+5xrMeZ3k67mmUHUuChpCQeK/rGi51
        E1BdZKd8zhnufI/psv9K3IIDMlGkMZbKTKHxwYDodzik0xc2ZpwlTtUNVYl6tqGV
        /+1UCT+31x1SbGGI+KApCZFrFGyKegDem+YT5OvrOgI3zY9WMS1uR2UCZd4OU6q7
        cvQis7mIeu5Y7uCZisuWXc0fQAte/LdGtFhSYYKNqxt0brOkfOyiqr3ZpULTg4VI
        pWxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656306782; x=1656393182; bh=904GOKdujIzG+
        lXqqN6R8S+IQA88lTLYQXPZ4MZDHfo=; b=O74T68806yX33KKUD/DLjemFcyheQ
        WOrRA8Sit4G5xnWAJRPum7J+ml7yChGFvIurCkLTbl2QYtFrQGMdKGnzjaZzgsn4
        NTNagGAUUrvBld67vpyIHVRSsrEnoUtiOPsPeE28P7ByB7B7igOjUwL9HAmV0gzR
        qgGyK2IW4bVtRa/UfmqkowomlRWrr5a5idXa3LceRjE4zd4i/dPBtvaJ177nyvEo
        3jg5V6nrQ2DfWhdt4rHT7eNho5ONrUFfYncFk7w0564IIKULY18x1RzBRGzyM5uW
        8T5l56IQyEnasax99fyg8ENHS8GJFduf88PfSAAStZYBPfeIaY/mbU8Hg==
X-ME-Sender: <xms:Xjy5Yoltw-FXt0DH-R2kEfKVYbhK7Soo9SjNXV48VKfnOpwqTsoRCA>
    <xme:Xjy5Yn3V4MQe42mxSK-IY5w6j-aR_T5W2VprUCYNpT7SBkcutvcEuxxZgcRPvqw07
    Q_wwh5zj6mQVsAxog>
X-ME-Received: <xmr:Xjy5YmqMJQC2IP20fnFOip5aZhPYw2cukIxxtqeSt5vG935vuqdjuTXYdW0tBfsvuRXVnuDpsBRs1zf2629ETQhVNOob5e_6seFAiFWgcEuFUoxi_QeKVNiEzeCCoacVM45AMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeggedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeeuueeuheelgeeuhfeutdelieffveetieeftdfgfeeiteekudet
    leeuueeljeevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:Xjy5Yklxv27gvgfwA7WD7BRyD-VmIzUi5HMSeH5Dm5NMiE0biwH2tg>
    <xmx:Xjy5Ym2W2iCtxaqw56kDoyrTJVW5LIf_DJZiGcZRrJ3MqeAVMHdmvg>
    <xmx:Xjy5YruWmhNobyFC-dFqgSXjTkBta6LpVXVtmA6ckock1VTAs_G_Ow>
    <xmx:Xjy5YvEJSeweprKFGGyK9PS1-PTHhmPYoNKQe3jrDFSyev5p17NdCA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 01:13:01 -0400 (EDT)
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
Subject: [PATCH v1 2/3] irqchip/sifive-plic: Name the chip more generically
Date:   Mon, 27 Jun 2022 00:12:56 -0500
Message-Id: <20220627051257.38543-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220627051257.38543-1-samuel@sholland.org>
References: <20220627051257.38543-1-samuel@sholland.org>
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

The interface for SiFive's PLIC was adopted and clarified by RISC-V as
the standard PLIC interface. Now that several PLIC implementations by
different vendors share this same interface, it is somewhat misleading
to report "SiFive PLIC" to userspace, when no SiFive hardware may be
present. This is especially the case when some implementations are
subtly incompatible with the binding and behavior of the SiFive PLIC,
yet are similar enough to share a driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/irqchip/irq-sifive-plic.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bb87e4c3b88e..90515865af08 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -28,6 +28,11 @@
  * The largest number supported by devices marked as 'sifive,plic-1.0.0', is
  * 1024, of which device 0 is defined as non-existent by the RISC-V Privileged
  * Spec.
+ *
+ * The PLIC behavior and memory map is futher formalized as an official RISC-V
+ * specification:
+ *
+ *     https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc
  */
 
 #define MAX_DEVICES			1024
@@ -177,12 +182,12 @@ static void plic_irq_eoi(struct irq_data *d)
 }
 
 static struct irq_chip plic_chip = {
-	.name		= "SiFive PLIC",
-	.irq_mask	= plic_irq_mask,
-	.irq_unmask	= plic_irq_unmask,
-	.irq_eoi	= plic_irq_eoi,
+	.name			= "PLIC",
+	.irq_mask		= plic_irq_mask,
+	.irq_unmask		= plic_irq_unmask,
+	.irq_eoi		= plic_irq_eoi,
 #ifdef CONFIG_SMP
-	.irq_set_affinity = plic_set_affinity,
+	.irq_set_affinity	= plic_set_affinity,
 #endif
 };
 
-- 
2.35.1

