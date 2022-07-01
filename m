Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F230B563AFF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiGAUYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiGAUYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:24:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005312FFF6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 13:24:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 375EA5C00BF;
        Fri,  1 Jul 2022 16:24:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 01 Jul 2022 16:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656707082; x=1656793482; bh=HboBnnGwsEoiC8NAxh0dVnMqp
        uKutI8lGKz3TQGSFLI=; b=k9ksBvakLlYMVAjErf3dl4XypI6LLGNfO+LN5yt9y
        tqvPzD3XhqyJm7gB59iVNu95lowvRR3QxyeRZ5i2u7qfb//4n+ZDxhff17o4veMb
        Z5ui+e3MwOBeWSoNL7tK7Snuah0gpM+23RPWdecVhAhyCM0f33QXfuKwnNEgsvTf
        VSjDEKhfBqcnOus7rlJyKq4ZfkjOt3D1Z1tYO7focxnV8LI6aB5mm2eG2q4NhVFp
        aOYokSHUjlQQal6Wg4dpKFtorrh5CXmbHMbS6OR1Xida2jkgp5IlrBTAolljtozI
        1+IDzN42WA1uzw5L8NjH9Y7+uKoGZS/bMSKizuj/kKmUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656707082; x=1656793482; bh=HboBnnGwsEoiC8NAxh0dVnMqpuKutI8lGKz
        3TQGSFLI=; b=giPdzMO1rdvb8yk7Sz0sHDxYAacy57sAV2/zFoeIyHLp2G4QO/g
        hU+ogTKLgPsrZEAWd53wRqF8ULqVYraypu6SdbTWrMzvUG3xtKXlXJymsVi4I1/b
        2ITehHsfRg54ybYB0YBiTSFYw5PIzB1QXULvpuZLivfDHYhysIZPY/cKoEtQNRaP
        q3JPEg2t3Nb8UCRGdJtOhwj1J4/xQWQllTCHggDr1nhS2h/7Xdgrl3BZPHYbfumg
        /qRx5JETwvhK0HLiLvwLc4k9r8vF/yov0GDDmH9IPlVXrezajS4hvtDqC65F8yhT
        Cd4vK4BIMki0gupVf6p6F+a+kVliCjMNohg==
X-ME-Sender: <xms:Cli_Yted2qOUB6WQiSzN5eNIK0rcP_8wkKzMpajvIWubsuknKGN15g>
    <xme:Cli_YrN6Dmrg5tZlzIfDpz4-vy-ZiD1TRIemNZDhnDfCcGjCsW5EyG1jwNfwomLZH
    NTF6BGQJgjwnXCx6A>
X-ME-Received: <xmr:Cli_Ymhoy3gIEfYv5Vm6El2llbdINK4rCbIE_z2WFZctFco1TBg19s8qft76CMTdfMbfTrJeQ_WsJqTiT9k_YakFpkDirsmtL39wp18NdeoKf3UocOAjbMDPcaI_dFFhSH2_LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheel
    vddvfffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:Cli_Ym9QLOPQg12WaXzINQIGzBQnmMDhLASx2PzzwLno2HCuND8nWg>
    <xmx:Cli_Ypu9uS4EKYyUmJ3yP6fIKiB7vbh-elvuxk7rTtNJgYz-gBCdKg>
    <xmx:Cli_YlGZOXtK7oO7_X0x8NY051ljM6xXQxSnUgs7KG9wWjkt4UOrqA>
    <xmx:Cli_YtgmlyBb51ZZCZbL7NBbp7MDbMV2DmyJBjHxfXg0eHpPYeS0Nw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 16:24:41 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/2] irqchip: RISC-V PLIC cleanup and optimization
Date:   Fri,  1 Jul 2022 15:24:38 -0500
Message-Id: <20220701202440.59059-1-samuel@sholland.org>
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

This series removes the spinlocks and cpumask operations from the PLIC
driver's hot path. As far as I know, using the priority to mask
interrupts is an intended usage and will work on all existing
implementations. See [1] for more discussion.

This series depends on my other series[2] making the IRQ affinity mask
behavior more consistent between uniprocessor and SMP configurations.
(The Allwinner D1 is a uniprocessor SoC containing a PLIC.)

A further optimization is to take advantage of the fact that multiple
IRQs can be claimed at once. This allows removing the mask operations
for oneshot IRQs -- i.e. the combination of IRQCHIP_ONESHOT_SAFE and
IRQCHIP_EOI_THREADED, which is not currently supported. I will send
this as a separate series, since it makes more invasive changes to the
generic IRQ code.

[1]: https://lore.kernel.org/lkml/2b063917-17c8-0add-fadf-5aa42532fbbf@sholland.org/
[2]: https://lore.kernel.org/lkml/20220701200056.46555-1-samuel@sholland.org/

Changes in v3:
 - Rebased on top of irqchip-next
 - Split affinity series and PLIC series

Samuel Holland (2):
  irqchip/sifive-plic: Make better use of the effective affinity mask
  irqchip/sifive-plic: Separate the enable and mask operations

 drivers/irqchip/Kconfig           |  1 +
 drivers/irqchip/irq-sifive-plic.c | 64 ++++++++++++++++---------------
 2 files changed, 35 insertions(+), 30 deletions(-)

-- 
2.35.1

