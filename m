Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65941466E85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbhLCAkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:15 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41901 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347683AbhLCAkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D26645C0208;
        Thu,  2 Dec 2021 19:36:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 02 Dec 2021 19:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=IfgSjFH6He7k2
        nBoG7N/PKbhl+9zvPfpyMluOd2Tnu0=; b=QVOFpzTCYAPtjlA0xUT04i6xw1cN5
        bowuLp5nblxt1G4I+V0LV7RO8/rCnO9vVbeQ21vOET9iULSkuUKn8GNeVzdtOm3P
        cEnp6tLghGyyAuVnIpIy/1w8DCR2+0zPkuyQcTMrnAu9e9ug1ELDwhUrq105aMIs
        C8HcsOTu8S44O1zG/6ZN8Icc2CJ+JLCy5UVtan7xqmVcropAgBtG9xqp/3KvWyoF
        oSNixqqFjZmKe+kZ+3C8djxObUYgS23/GMvUdS2YRq0fC7fX9JM6NLZA721EsOaa
        UszVES0Eiudj9TY+mbXb38zsZemM3DjpzobDjJj89f/lgZW0HN+14558Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=IfgSjFH6He7k2nBoG7N/PKbhl+9zvPfpyMluOd2Tnu0=; b=Wj05004l
        jw5hHVBb7j05juaGVKG9zKWauvPvFNkBLyFJ/o+hcgWVKZ3iBykpDjMjEBuYCyQc
        fb4aFsvnWzHPAnmQaRNRlCs/EFBlq7PwEcx+eU/HzKPkr+XcAuBJRRaV2IRe45fT
        K/lexndEOSQfi8scR3MYVj8AyCHs0HhJCHbFuLokAflWzajdwWL/IselJUADVtfw
        Euj8iRsc1ZbtV8YVnxT7a1mFwaHDaZECufEUeyvIuJJPTUTuAwZZw5TKmawy1tOe
        Df0yR4I2ILOw+NcDbiwQZv91Pz4YdOvdxvo1fZrcssyfaaiJISRkjV4egW/zYANS
        bbg0dKmIvu4+bw==
X-ME-Sender: <xms:oWapYUE86qiX6Srclg02aYJHjzfAmX_y_H5X6GJzbSI0EfVrGJGVdw>
    <xme:oWapYdUpwI_3EUnEV86KLv5AWJ0u98-AiWN2-1DS9wwYb_LTydBwVxdAAk9AmN_b3
    lius7CFLIIcWWCJ1r0>
X-ME-Received: <xmr:oWapYeKFIxj1NJk61FTuxa3Wr2KxFhQk1G-nd0A9RN2OTBV1Vylyy-Wzr8kbGvkaKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:oWapYWF5pN67UqkMJ_TaKbD0MzezH2zzDcAZbb1fUYF7Yzj-yo-ouA>
    <xmx:oWapYaWYxNA-WaQ_DgmPkExYVQjmCOrvSgMhPC5TQ7HL2aOzYNL07Q>
    <xmx:oWapYZPY29PKA7KYUEZpCmKvpoXXlv6L9SFWZBrFSZxvtuI-R9Z57A>
    <xmx:oWapYeqqJwox9zt9vzVaFY2UWPQ35q_YA7heBDdxRRxTI9Y8lKjY3Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:47 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 03/10] x86/fpu: Calculate xsave state addr on fly
Date:   Fri,  3 Dec 2021 00:36:29 +0000
Message-Id: <20211203003636.11417-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are going to have xsave buffer with different xcomp_bv,
the compact layout of those buffers can be different.

Calculate state address on fly instead of cache them on boot.

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/kernel/fpu/xstate.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 353c661f8027..06f6214e9dd7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1006,12 +1006,32 @@ void fpu__resume_cpu(void)
  */
 static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
+	int i;
+	unsigned int offset;
+
 	if (!xfeature_enabled(xfeature_nr)) {
 		WARN_ON_FPU(1);
 		return NULL;
 	}
 
-	return (void *)xsave + xstate_comp_offsets[xfeature_nr];
+	/* Hanlde legacy states and standard format ext states */
+	if (xfeature_nr < FIRST_EXTENDED_XFEATURE ||
+		!(xsave->header.xcomp_bv & XCOMP_BV_COMPACTED_FORMAT))
+		return (void *)xsave + xstate_offsets[xfeature_nr];
+
+	/* Calculate compact ext state offsets */
+	offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	for_each_extended_xfeature(i, xsave->header.xcomp_bv) {
+		if (xfeature_is_aligned(i))
+			offset = ALIGN(offset, 64);
+
+		if (i == xfeature_nr)
+			return (void *)xsave + offset;
+
+		offset += xstate_sizes[i];
+	}
+
+	return NULL;
 }
 /*
  * Given the xsave area and a state inside, this function returns the
-- 
2.30.2

