Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E7154DADD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359224AbiFPGkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiFPGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:40:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E56D57990
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:40:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5C2FC3200B2B;
        Thu, 16 Jun 2022 02:40:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Jun 2022 02:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1655361630; x=1655448030; bh=I3+WW+WTxkXv9D9vagP68cXql
        xN9z4tmvOo4x3EDbH0=; b=O1RCcPJjZT7ndI8g/Pz8BnPlPj9kQp3GqZhIhmHKN
        3B5Z7xvwib3yJrAMJaBFOPVbJUVUW38Xqdc9TIcOF+B+CMkxbcip5gVmUB8PmJqp
        xYxQZrs/8gMrPJEcuXckFQZvZdaeMQecZACa4p4iYKIdzQRBtMjmjuHWdQP5OznC
        zUNmXoXiRzIXGyct13BXxWTzYnQ80M+DEi4dE4yNmP5KeR5PNZ6VeRGdpDFH6IvH
        NlVNs6B1p4SYxA+nFiqboNoCEcV4Xr2zjlUqA7mJsz+lJ05RO6x2Cw66Mxuv6e91
        3f2e584qWo7yEl7kD1uHZ5osdxh8rrn7/aqqzqimHs2ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1655361630; x=1655448030; bh=I3+WW+WTxkXv9D9vagP68cXqlxN9z4tmvOo
        4x3EDbH0=; b=SsS2fyODkMlyFPIWWPiQ2CC/AnPvK4lZzQfxkNRGis33Aynul2x
        sghQgBJ7biuq7YfhyeWcJC5DK/eLh/Cnkd1/pzTVxNFzLR/FlX0872lawS9CThrq
        LO3AJR2P0FxLBlq3kXlq2qjdpPVLo0vAh+ihUXLa53fTnZfi4BoshDaTR5ZAIZ/G
        vYkIs377BXW/pvRgh18wLlAhAufLdtIZVtAyqo2OrELaMI4pfKVDYG1Wf0V/EeNZ
        xSaB8naA5e+PbD/43CR4ZOSdBBtvi7ym+LfC9i3VAvnaPk9UbtyNHfn9XGe0FH+s
        S1xJ+89dLsdOU/bW4XfMOxVZlz3w95hGoDg==
X-ME-Sender: <xms:XdCqYmrCFEBlzPS_09Bst0BpVbI9PyTff9IgXmtoYfKZaMqLHCEIOA>
    <xme:XdCqYkofMF3RmPAC07u83rCNlxXbrnmONFvjXSaAs5zaXI5s_e_RSc4PrIsYRSbBl
    mNrulrMhLC8TG21NQ>
X-ME-Received: <xmr:XdCqYrMmMuUCaSZzVm6bX8Gjew2rA0VG9kX6maXCC0UWkxcbGHMHEKE6BoTjeu-lWyZXIkfT0Qvb5bR_XATKYkfS6_-I-2Wl3ndLQQV6pw-dIjORwJ3MYaTrTmXGjplVbcbXKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheel
    vddvfffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:XdCqYl64BtETPX3amg1iZdgCvaRjRKatOzzuSKwxojrWPxFtQ99hOA>
    <xmx:XdCqYl64bMBoOKPrYjjeYVzvy7CLvQHYY23g57qeoRI6KD9rvAItuA>
    <xmx:XdCqYliQfZctl_BFzb6xyTFmSNUtj40sET-eDP25ijoJVEu4EFwPhw>
    <xmx:XtCqYtzSmjSWJ1iLqouxb0CNBcgnovObarxbGFpimKQURj1lOIqFCw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:40:29 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Guo Ren <guoren@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/6] genirq/irqchip: RISC-V PLIC cleanup and optimization
Date:   Thu, 16 Jun 2022 01:40:22 -0500
Message-Id: <20220616064028.57933-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

This series removes the splinlocks and cpumask operations from the PLIC
driver's hot path. To do that, it first makes the IRQ affinity mask
behavior more consistent between uniprocessor and SMP configurations.
(The Allwinner D1 is a uniprocessor SoC containing a PLIC.)

As far as I know, using the priority to mask interrupts is an intended
usage and will work on all existing implementations. See [1] for more
discussion.

A further optimization is to take advantage of the fact that multiple
IRQs can be claimed at once. This allows removing the mask operations
for oneshot IRQs -- i.e. the combination of IRQCHIP_ONESHOT_SAFE and
IRQCHIP_EOI_THREADED, which is not currently supported. I will send
this as a separate series, since it makes more invasive changes to the
generic IRQ code.

[1]: https://lore.kernel.org/lkml/2b063917-17c8-0add-fadf-5aa42532fbbf@sholland.org/

Changes in v2:
 - New patch to prevent GENERIC_IRQ_IPI from being selected on !SMP

Samuel Holland (6):
  genirq: GENERIC_IRQ_EFFECTIVE_AFF_MASK depends on SMP
  genirq: GENERIC_IRQ_IPI depends on SMP
  genirq: Refactor accessors to use irq_data_get_affinity_mask
  genirq: Provide an IRQ affinity mask in non-SMP configs
  irqchip/sifive-plic: Make better use of the effective affinity mask
  irqchip/sifive-plic: Separate the enable and mask operations

 arch/arm/mach-hisi/Kconfig        |  2 +-
 drivers/irqchip/Kconfig           | 19 +++++-----
 drivers/irqchip/irq-sifive-plic.c | 61 ++++++++++++++++---------------
 include/linux/irq.h               | 20 ++++++----
 kernel/irq/Kconfig                |  2 +
 5 files changed, 57 insertions(+), 47 deletions(-)

-- 
2.35.1

