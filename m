Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F654BE7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378587AbiBUO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:56:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378564AbiBUO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:56:17 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A8517AAD;
        Mon, 21 Feb 2022 06:55:54 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CA415C01D2;
        Mon, 21 Feb 2022 09:55:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Feb 2022 09:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=W33SNp0pR4K0oD6ddMKKEdiqs40zlf
        kBnS8Whij6EHQ=; b=STDBM/4rJQczYtG1aRaRKTVE1Y71ArnL/zaUAKliicNNPz
        Uaat6kUFekckbBN+po74oIfigvIBiqH2rNBNkg7qq2i4ogbUaII0Q56hrVYp5Soa
        Cx8e3fAIpGzlo8UKmYgoX3qVdgxHkaYguLS76d2mnInD9Vv/hwVrbFR+1IXFjWdz
        HZ7lGP5xBbThgXMXMQc4dZvX32D/UZcpeO3YPmN4hWSBjrPFwtnY1GxxDVdPSFEF
        C6MDVWeAhcK41jZ2NG6OohmaR39lqfB60cilicD+4GI1zlvFaMu2Ef73SNW4jqip
        jYJ9jamzw3B/crI3+W2beF3ndbJ6Qd2RizXQazCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=W33SNp
        0pR4K0oD6ddMKKEdiqs40zlfkBnS8Whij6EHQ=; b=Nh573dM6Tpq4drfLuT0j7Y
        1f1Pp1wR2vDj829htrMOSI0m3RB4WZF8ptKiKpDKY+Gt+vSkLDNOfsaAEdeSMjQI
        KGUuDoaBcqzUdP/N1rlajXlg+jrOGB+h86+NY8SpdhvNqMeJBhiw+iCbj/YKEv7b
        e9qzjAKCB+XKSZT2pppjFs+uvoLjKJSUWoZN4CbCTNuOLcnR/F0gA/O7DwpKR2MP
        FhlVRclO7iZoKfZFnn2Vun2J2Qa85X6zPnDwTpXutoRMIkKWxQP/v7OpBmWHwhBu
        NewrrPaQZ7wTnmFZu3QjFMpb6PSa3Ef9psCs5y+k8dadGxLzbfVTQihdtnmksuzA
        ==
X-ME-Sender: <xms:-acTYq2Tfh73qXXZE6HroOelZqT5Wgsa3eoYkuRETBJ6aQglhyP_oA>
    <xme:-acTYtFqBCaa5xcUOD8PEgm9FB-rQ_Lc1dbkMt_DDY-a64UTKBdaUWyEP9kfEd6FW
    UOEdHjdiJQiM-PDbco>
X-ME-Received: <xmr:-acTYi6Z5dUhDT7yRWWQvBpA0wbPJejYPcZbKRxlBXUg1msNHH_6CSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:-acTYr34rLlbQ375NnhAzh1OA9-sjhdH86DH96S4B8kX5VZHVdYAeQ>
    <xmx:-acTYtF6n-ZX3VEGH47RQO4TTD8W6uJKIKLY6iPyGOq4UGwQgWdTUQ>
    <xmx:-acTYk-t0XHDiC9eBIM-YZ--xw0luCENs33KanXhHpu3YKnmMaZXow>
    <xmx:-acTYhgheucNTnp8ofz4TwzlzGiKp1X7JFa97lB6vO7mp4NT34v0nw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 09:55:52 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        tsbogend@alpha.franken.de, macro@orcam.me.uk,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [RFC PATCH 3/3] MIPS: io.h: Remove barriers before MMIO accessors for CPU without WB
Date:   Mon, 21 Feb 2022 14:55:31 +0000
Message-Id: <20220221145531.10479-4-jiaxun.yang@flygoat.com>
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

Commit 3d474da ("MIPS: Enforce strong ordering for MMIO accessors")
intruduced this barrier to ensure the correctness of IO access ordering
with following reasons:
1. DECstation systems with hardware write barrier can reorder IO writes.
2. Cavium and Loongson have errata which reorders MMIO.
3. MIPS Spec didn't enforce ordering of MMIO access.

For reason 1, the concern is still valid, so the barrier is kept when
CONFIG_CPU_HAS_WB. For reason 2, we had confirmed that Loongson doesn't
have such errata, Cavium's issue is workarounded by war_io_reorder_wmb.
For reason 3, I had got confirmation from CIP United that all cores
by MTI (MIPS Techonologies) won't do this. Given that other platform had
live without these barriers for a long peroid, removing this barrier
is unlikely to bring any problem.

SYNC based barrier is very heavy on Loongson and MTI cores as it will
issue a SYNC command on their bus and invalidate all present instrutions
in pipeline. We should generally avoid that.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 8a148277d9e6..faa38049412f 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -225,7 +225,11 @@ void iounmap(const volatile void __iomem *addr);
 #define war_io_reorder_wmb()		barrier()
 #endif
 
+#if defined(CONFIG_CPU_HAS_WB)
 #define __io_br()      mb()
+#else
+#define __io_br()      barrier()
+#endif
 
 /* prevent prefetching of coherent DMA data ahead of a dma-complete */
 #define __io_ar(v)     rmb()
-- 
2.35.1

