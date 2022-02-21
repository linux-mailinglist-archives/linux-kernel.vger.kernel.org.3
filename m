Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6334BE8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378578AbiBUO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:56:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378549AbiBUO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:56:15 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A743320F4A;
        Mon, 21 Feb 2022 06:55:52 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E83C15C0070;
        Mon, 21 Feb 2022 09:55:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Feb 2022 09:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=gzFf99qWVEJAvowt98L5HAVVoHw9Oh
        Hz4nNsoMnI/oU=; b=aOdz//ubr9AE2TpwwVLpL9yKeKAHz7ro1nWiU5HU5bQBdM
        V6mvqJDLhQXePYukX6XF8K1/2MMBpUSdnFfjKE2UMtrVEyDq8TDD7p9/7CVX6N9p
        Q2OuI6UWDnwb9cZ7g4WSQhP9C+E2mGc6EK5ZUUQWP8VsuNCEiJQei67NerXZ1UgC
        pIfRJNIVtesJAxrWJqUGv+tsbCak3vnHdih4pXmYRvBYNCPqkwhWBkYYOZtu5fA4
        pp1HmYsL1DfYvJLJGNPLWZ+Me35gfrzrc1hnzizVwh8aNjkH9Y80B6YL3BWiKkPV
        uCtqJua/YRie/6w8iLNZ5+NLZfGMx/qduSBE3ccA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gzFf99
        qWVEJAvowt98L5HAVVoHw9OhHz4nNsoMnI/oU=; b=aTIKPYkZtIvnNPgBVcJkam
        pwzAzDTJEn0pJauR3q1cjZWYNxn+kxyfHrxjt713Px3uHpDDZdfk6Qq3jwQvG4mu
        oNw/GJxB6OyxrtTLRH/1AK+cSt+MFUC6fiR4nMl7tDsq7FcG+agHdvYpdloAS8rZ
        6+6BAnJuErFmxtFUpl+zfQWMEHtGaJF4slUuG2zmAoVW38wgYqcLfF8XzxGl1fWM
        tQGZQvewN9DtFJOpj77NvaQCm9J3BRe0OFwndbv7HJeUJRiZy5IzLgzu7veUvBHS
        tkEm2PyOMKldV3BoilDsFvPWR570koCxA7XcSigiSnidVWiP0Iv7KqlCoMz2zKmg
        ==
X-ME-Sender: <xms:96cTYoBKHvoJ4BLupCsE9o4XjmIiscQX0OnRZupVNAOIxtuUY5vcLA>
    <xme:96cTYqjUyquWBvEnl__KY7Y_Wxswxbync5P14LIJJn7_WQy-gyNYugnhEzx5RTWQS
    ns_3cSuW3gRZDl170E>
X-ME-Received: <xmr:96cTYrnTqxIVaEY0qmSdju0pObbqiq3IEd53QV0D9MXQu2vruUElaGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:96cTYuzH0DRw28JHgMVlvpsIDLTh_02Yr9nmsx3_6_o4Azrsiuk0aQ>
    <xmx:96cTYtTrVkKzOcVHQ4QIMpNC989lj1Cb-UJ65Anvda2YEMEKipTXVA>
    <xmx:96cTYpZ9ORd0ILCujv1N_awvs5cbRtU5k6eqccPybYNYt5dpdoQcdg>
    <xmx:96cTYrNFZM-XyndH7xObK6M7N9ZyThETWh9kzHn7Fkubiq5peeo2QA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 09:55:50 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        tsbogend@alpha.franken.de, macro@orcam.me.uk,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [RFC PATCH 2/3] MIPS: io.h use barrier terminology from asm-generic
Date:   Mon, 21 Feb 2022 14:55:30 +0000
Message-Id: <20220221145531.10479-3-jiaxun.yang@flygoat.com>
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

So we can share understanding of those barriers with other archs
and hopefully one day we will be able to switch asm-generic.

As mmiowb_set_pending is unimplemented on MIPS, __io_aw currently
does nothing, but it need to be implemented later.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/io.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 065e1ab6401a..8a148277d9e6 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -225,6 +225,17 @@ void iounmap(const volatile void __iomem *addr);
 #define war_io_reorder_wmb()		barrier()
 #endif
 
+#define __io_br()      mb()
+
+/* prevent prefetching of coherent DMA data ahead of a dma-complete */
+#define __io_ar(v)     rmb()
+
+/* flush writes to coherent DMA data before possibly triggering a DMA read */
+#define __io_bw()      wmb()
+
+/* serialize device access against a spin_unlock, usually handled there. */
+#define __io_aw()      do { } while (0)
+
 #define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, barrier, relax, irq)	\
 									\
 static inline void pfx##write##bwlq(type val,				\
@@ -234,7 +245,7 @@ static inline void pfx##write##bwlq(type val,				\
 	type __val;							\
 									\
 	if (barrier)							\
-		iobarrier_rw();						\
+		__io_bw();						\
 	else								\
 		war_io_reorder_wmb();					\
 									\
@@ -265,6 +276,7 @@ static inline void pfx##write##bwlq(type val,				\
 			local_irq_restore(__flags);			\
 	} else								\
 		BUG();							\
+	__io_aw();							\
 }									\
 									\
 static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
@@ -275,7 +287,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
 									\
 	if (barrier)							\
-		iobarrier_rw();						\
+		__io_br();						\
 									\
 	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long)) \
 		__val = *__mem;						\
@@ -300,9 +312,8 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 		BUG();							\
 	}								\
 									\
-	/* prevent prefetching of coherent DMA data prematurely */	\
 	if (!relax)							\
-		rmb();							\
+		io_ar(__val);						\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-- 
2.35.1

