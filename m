Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465084BE450
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378568AbiBUO4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:56:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378499AbiBUO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:56:15 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15217AAD;
        Mon, 21 Feb 2022 06:55:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 92E875C0211;
        Mon, 21 Feb 2022 09:55:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 21 Feb 2022 09:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=CGhvsw+LhTgD6aZuUFtqqU1Kc3kIvE
        iqCXe0yRe6810=; b=e4gBrijTOZhpcNy+jnhFPC0M3cR5xv/xVK+BSjrnefBwqq
        SFusBz1p7/d22M8zErvkzVUZuhZL/Kn4aVsObOPAckG9arsvxG9OH9fxJkDGJ/mh
        Aae4VRiKLfJgF7GgqDbFtk6CiHUCUnLx3wwquqWWUgl77vxYj1b8TncUXHXPLXEe
        twShpKTlddijxWNBNPlRiBo3sU76wKQIrUh3WombyMvL1YnrmtQ7bgAldd5dH/Mt
        GuIjzBIDrHX9GFjvGXwnt9VIU7vn9aBBh1rXvXUxs5dLEmTeHqwN76fiDiq7KQ+c
        fALbazbPEhzJ229TsG19hQ14L9ekm2CX/ThSwwCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CGhvsw
        +LhTgD6aZuUFtqqU1Kc3kIvEiqCXe0yRe6810=; b=C1toCK7qAAJFyiRrFibt9+
        57z9FhqcL4Xvbg/sQ7+RAz/Ed895TTNAh3ZAEhu0bylS4xyNpTB0hf+1VLi4XNzk
        Wn2cq2QB1sNAY+VbegcQ2F3VfusZ7f9O00Dbtng61dNk/9xAu9X9KIU1twshDgWT
        u61YULPepO6EGCl9jHJkt+T1w35l14Gys4Jvel4sQRa1mBXK1ssQaB4tDDmrv+MQ
        w1Uhb5qygqANjNTX0N635wNgK/8lIwRpZRqNX6vLcBIJsCDPvwGXORwQ48jnnEnF
        Q6Wk8gMmzTItyY5+BYEwrc6jYM9LOOHUaB10RDe2kRPz6i6n9RZSVaDDp2LeD4pA
        ==
X-ME-Sender: <xms:9qcTYs1ofl8S525l3PpMOd4s2dfF_I90I8as3nCupLQi39-jd871JQ>
    <xme:9qcTYnHp7OW-UGWq0A1uGcO0EtdtF1uPU_8IMGoz_Yf3Jl9kMw8XoGreGRF7twwLz
    m2CDBhhH9vwZri-eyc>
X-ME-Received: <xmr:9qcTYk5DJ-m6QT4CVf9jY1uT7j6JQtG5zLbn7f-mq33NRa5SZHZvV4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:9qcTYl0o-4D-kxV25yTc00-7JdMMvua5925zookTqjXreBNIZhQnkg>
    <xmx:9qcTYvGBM6mO8NUbhLUPbod5oQBC2vpN59UX5wtoptPrEL5WZtP3AQ>
    <xmx:9qcTYu91v5oDr4KFG3eo1oIyTyeLQFqX__fRrXCpiReatdjaf_8oxw>
    <xmx:9qcTYjixRSj-jgvxYM2XthMnytd9_zArbnC3RDxckkSFBly0Ni55pg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 09:55:49 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        tsbogend@alpha.franken.de, macro@orcam.me.uk,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [RFC PATCH 1/3] MIPS: Loongson64: Clearify IO barriers
Date:   Mon, 21 Feb 2022 14:55:29 +0000
Message-Id: <20220221145531.10479-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221145531.10479-1-jiaxun.yang@flygoat.com>
References: <20220221145531.10479-1-jiaxun.yang@flygoat.com>
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

Remove CPU_HAS_WB from Kconfig as all Loongson64 processors
don't have R3000 style write buffer. This is likely to be
a legacy of Loongson 2E's Bonito64.

Remove Loongson64 from war_io_reorder_wmb. Loongson64
never reorders uncached memory access as per user manual
of GS464, LS3A2000 and LS3A3000. It was intruduced due
to a misunderstanding of Store Fill Buffer.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig          | 1 -
 arch/mips/include/asm/io.h | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 058446f01487..6d2e97342723 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -487,7 +487,6 @@ config MACH_LOONGSON64
 	select BOARD_SCACHE
 	select CSRC_R4K
 	select CEVT_R4K
-	select CPU_HAS_WB
 	select FORCE_PCI
 	select ISA
 	select I8259
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 6f5c86d2bab4..065e1ab6401a 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -219,7 +219,7 @@ void iounmap(const volatile void __iomem *addr);
 #define ioremap_wc(offset, size)					\
 	ioremap_prot((offset), (size), boot_cpu_data.writecombine)
 
-#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_CPU_LOONGSON64)
+#if defined(CONFIG_CPU_CAVIUM_OCTEON)
 #define war_io_reorder_wmb()		wmb()
 #else
 #define war_io_reorder_wmb()		barrier()
-- 
2.35.1

