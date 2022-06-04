Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6453D6D0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 14:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbiFDMlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 08:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbiFDMlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 08:41:06 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879E31536;
        Sat,  4 Jun 2022 05:41:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7BA6132003AC;
        Sat,  4 Jun 2022 08:41:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 04 Jun 2022 08:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1654346464; x=1654432864; bh=Y8
        5O8Dk7VWQXXoJvprtQ8Dh0VDIc6G4b2piXzVambvs=; b=QsI1Pc5GL0ftpGmkVM
        4cS9+b1ukcVX5MX7Jw7pL29q/OOiJ3z41W9nxz6+Pu/yUCbbP0KqtMpTXSpoDSHw
        Qc6SGVEctoGDGdQ5493R9q6GV2LS3/uKv6NKUYMV2zuDSLp+oVeV9NaThNARsEnA
        c75eXmyYat1viqX7nukAL66Hjm8D0/ncwmE/lMZEpYOSfRTrKx40NzCfkFUBsMQa
        xxEYMRslEwcTQ4qPlB2HtrOOkUJlV6chebdkoGdToj8yjB2DdDO/5Z+1j/oFgdpH
        ax2lnYVKUJg+7WFf92QUTgndBotS9/tgP6onjvYHWXyZWBJuiNSUzvw1W58irngr
        YIbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1654346464; x=1654432864; bh=Y85O8Dk7VWQXX
        oJvprtQ8Dh0VDIc6G4b2piXzVambvs=; b=mrXA7BVV28fhRcI3UqKMl2/FKYrDw
        LXmD5R8KfzOORUWGEH9xPeHMdJTBYTPPS0YJqAZrw1Ur5alOs7ehGgfIdN+c/KPw
        W4Nss5nJ9b1ZE0uCp+MQ7+WjAJ8hPwqVpOEoI4BpjuaSxdaqPSETUznGIXdJpLfK
        Ay8Hu7YvJkeCTJ/DGOZreUUwUI4nf3e0Ky6CO2SPqI4ccpNH+butX+jS7mUzXEfZ
        UAvHgMiUhsIerfwKlKswhzZJIlL179TUPMFBo9a34VHVxBrqQ0MiMP11hbLkAFB7
        BSkWRIIRcZndMSvMglbIxkSoXYtGC7/sruuDXUBQdeS5gcEF7xS7guNyg==
X-ME-Sender: <xms:31KbYupkotXKY0oJS32FIqcNzw7_FlS3iz5usu_8QyWTlQqny3GdtA>
    <xme:31KbYspPfRg3Pwv3lonnmAibyWiNteRWHh9BWQovhMoRGSdKY9k6cHCV-kT9jAafh
    _BrY0AO7YTY7tqcYkA>
X-ME-Received: <xmr:31KbYjPNorQf39HEau-bZ4TYm1FwwsQ2ZtUgdxiatf7SL_wIhdxrvwrhwEx22nRAy0cPv-FxPZ2u-LD4--Zp9n5x5x05veD5k6SLOpJAvxD3milCW50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleekgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvuedvvd
    egkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:31KbYt6clNdOGMDrbXIumu3GRxrWvAPFUoXeE62M76D0DGgCCyDk9g>
    <xmx:31KbYt4CIqx7sZWbzfymZseDnJwCO5qreY7zAjX7kZtPx0IzmmSZIA>
    <xmx:31KbYthInYJlfjNkh32EdpZH3viQhgEE5KS4tFteplI6ofOoeuokhg>
    <xmx:4FKbYg0mDb0X_V5XO_rxnMqAUnZJyvo4VJ02bSi3HUO5YYwtFYt5CQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jun 2022 08:41:01 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, maz@kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-5.19 2/2] loongarch: Mask out higher bits for get_csr_cpuid
Date:   Sat,  4 Jun 2022 13:40:52 +0100
Message-Id: <20220604124052.1550-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604124052.1550-1-jiaxun.yang@flygoat.com>
References: <20220604124052.1550-1-jiaxun.yang@flygoat.com>
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

Only low 9 bits of CPUID CSR represents coreid, higher bits
are marked as reserved. In case Loongson may define higher
bits in future, just mask them out for get_csr_cpuid.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/include/asm/loongarch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 3ba4f7e87cd2..7f3933f747f9 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1200,7 +1200,7 @@ static inline u64 drdtime(void)
 
 static inline unsigned int get_csr_cpuid(void)
 {
-	return csr_read32(LOONGARCH_CSR_CPUID);
+	return csr_read32(LOONGARCH_CSR_CPUID) & CSR_CPUID_COREID;
 }
 
 static inline void csr_any_send(unsigned int addr, unsigned int data,
-- 
2.25.1

