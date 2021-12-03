Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF93466E83
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbhLCAkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:11 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58085 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347470AbhLCAkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 191FA5C0374;
        Thu,  2 Dec 2021 19:36:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 19:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=LWuOptzqmX7Zq
        +YOEmJRZuWvEnys6dHgiGQ9i1QcT2I=; b=bzIdUaKr3lVe5XRuQTA3crkupzXrM
        RFda8PF3EAzwnibDFcLS2JX2GsMM1lEPjMBUDZHQjwTacQYIs/YEl65bHnwoCQpo
        +fnvIsS7IrbMAlZLS6q/f14FFjFLkokdLTUiyD9IYJQqEOcLLHSvDUbGbRRSG9BA
        3QOVZ6GLXtbADZubSNTc9Cc5XC3s5OAWYdnQwtUsKj5F7Pe7GMeWhwTKTXjekMpQ
        DJd32CePj7mh8c8HOXrw+siWY5txXSuWj+aSrtjrKVHpaQ2IMHkTZxM7Ehy1n5iK
        oRTiuKltpoPqgCQSvR/iwX61fzyaRR71u0IH7E0IAsOtdbg4RQ2FCGdUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LWuOptzqmX7Zq+YOEmJRZuWvEnys6dHgiGQ9i1QcT2I=; b=KLx4C2S9
        J0jTOlOwmkf6Y4uVJg9dmqQl1LiQdT4cmvimnx1Ut+aKKRPBjQeX+vF6OhBnfR5r
        /zzaF4YO8OWjW+ITYuJNdSew1bmX0weONDz131tjoymlYyk+6/0PEEu3IfI84+y7
        o5ySaFeSHjq2HzDnxWCRANbDMYiFNdVJinTx5OzVvKL2tbF32Q30z6J50QhDnKtK
        9TCdooj7Hg57oK6BQ+DiqE8d4vony4eCb00INChat+3e/tgykUN06/Ekd9+mFreD
        YXSqiXuuuovh9NAA/dUBsxpVgljGMnefv3b36GnjSh5w52Fr6NhXGoHfrWNB1c+n
        utag61+GFlcd1Q==
X-ME-Sender: <xms:nWapYYSYY6jAteB-7e7qvs3aHTV3KakbW9nirP0px-tIOMX-cMuUAA>
    <xme:nWapYVykFIdn92-TmzI9Lrz4s1t9JYxiICcV5Edsjv-kmJQ-s4XDMemzsAUL7yogN
    jTDGRFrra_yiWWKcoo>
X-ME-Received: <xmr:nWapYV37pFMb_2q5ZNRL4G9QRofQRGfFc6xT5T4AnmnmirA-pVpZfOzaEp6fY2w7dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:nWapYcAAtHsbUbLdBomB3KbHT-Ezt_xFx2ujgOB2iRXTZaOu7scrdQ>
    <xmx:nWapYRiWlNHKjjC1LxRIidhVJ-lPYr9gI56HiK39U_bLxw1wxSEBcQ>
    <xmx:nWapYYoUJGp2clzmw6pkUCthalo3VBzPTgwP5wlEDLlrGqXqmUe-rg>
    <xmx:nmapYSV1rYTvVKBeU_c7COO8XE8rWLSJS6oy6j-i67UrIMIT2Q_mpw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:44 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 01/10] x86/fpu: Remove duplicated declaration of __fpu_state_size_dynamic
Date:   Fri,  3 Dec 2021 00:36:27 +0000
Message-Id: <20211203003636.11417-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow it presented twice in arch/x86/include/asm/fpu/xstate.h.

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/include/asm/fpu/xstate.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index cd3dd170e23a..fb83534e92f6 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -111,10 +111,6 @@ void xrstors(struct xregs_state *xsave, u64 mask);
 
 int xfd_enable_feature(u64 xfd_err);
 
-#ifdef CONFIG_X86_64
-DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
-#endif
-
 #ifdef CONFIG_X86_64
 DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
 
-- 
2.30.2

