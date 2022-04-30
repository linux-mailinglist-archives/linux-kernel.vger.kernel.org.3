Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1825159F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 05:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382103AbiD3DEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 23:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378132AbiD3DDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 23:03:52 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA782ADF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 20:00:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B7E9A5C01A3;
        Fri, 29 Apr 2022 23:00:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 29 Apr 2022 23:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1651287626; x=1651374026; bh=38PyJ9IXOsmeJwIX/t9APweLF
        uKK/8sAQNU4GM49vF4=; b=Vab6SpPtfFDV9UL6GGmFaO1dP+RAzxAKK7BQcLqWR
        Cd7NggAtpIH3XV9las76MrSegnnBQin5qhFbAX6CPFU27NgxeoJRxIz1sLz8T+Nm
        uIyff5DaL3DoNTw1PH05BoB/+ksJi3ugmpmXCfXovvsYChYy891vdjIuXHJzVPPV
        ciwinWbvKRv/2IeF9pW9Xu8n0QyR7pYvMqZsNnZP4wfBDWjMyy2OCeR3o5NvbJqP
        1E1XjPYhFzx3QeC2SAgGtBj6koRL4VR5z4M+e/iWOKQAVUuzrdYog/gb5lLRVo6T
        mfhvOo4m71ffSvP6qitrQZqweMFsKiywnjEXu4ErP6O3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1651287626; x=1651374026; bh=3
        8PyJ9IXOsmeJwIX/t9APweLFuKK/8sAQNU4GM49vF4=; b=LylEPbIgUsBgdDDjB
        J7ECMakOTVFI/31K77vaBo4vMv2tJk0hoMsPOGRQDuL7N2ZB21lJSJ8/U95PP1yS
        uyNZZl8K+uCMN66bcdxrWU84+ZqziuaMCs80juCcnd2TEhD0lAxLnVzx7EMUK83R
        8XAu9UtNBjnItDPsZfu4F3eZHBgjElwjn6hXnByCyribIJKLcgQ8vMMzzpbfGtm7
        H4f9xcBKji+otyE6hoSvxNgWFfqSY9i89xINgVQW9nIdL0730zE7FMTkNlNfvmL4
        L7h7eyrLfUWknRUGdeX7FzRAM2Ms3TYKLn5GFuNr/69GjBzXi8srnfOBaMcBL/Gn
        mM2jg==
X-ME-Sender: <xms:SqZsYq1xNI7Aubz0X1IWM9ScaH_2x0zYJLmXxpsbXcrWYxIaiKE0lg>
    <xme:SqZsYtHw58PbbDoh05VYgAscFBLBbmvMxpGm3yXXeVx65z-iLroQrNjbAlfjwLgKF
    5MRAKFgSkxyA8A5HQ>
X-ME-Received: <xmr:SqZsYi6nKQL0vY757ZmtNkmSYi9t-3eB5Tn25VL48dZuWpek5YeyyonjGeB_z6eOTwfu0oTYg3tAFXCI6yh739yuWWB0THCbuKhPQNS6lJMF8pTX4dENRM8EQvI6Wn5wbnIpBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:SqZsYr3uOp_vQgOKzHLrFW4BRX16kkHhTRwkQug7amFu1LVTpVCGTQ>
    <xmx:SqZsYtE4Ffd_3nrpc7CulqxgYtBFxglBt-F3ntlmBQ1vT3rAgUvO8Q>
    <xmx:SqZsYk-Tp2Qzfw08egIX7fy6ONlN7ErgDCATAuQoPoarwfA5El11mg>
    <xmx:SqZsYmOzMOfNeNRdvlertHi7iy_yroxpe6rJeJ2T94NXoY2HDICLZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Apr 2022 23:00:25 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix irq_work when SMP is disabled
Date:   Fri, 29 Apr 2022 22:00:23 -0500
Message-Id: <20220430030025.58405-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_work is triggered via an IPI, but the IPI infrastructure is not
included in uniprocessor kernels. As a result, irq_work never runs.
Fall back to the tick-based irq_work implementation on uniprocessor
configurations.

Fixes: 298447928bb1 ("riscv: Support irq_work via self IPIs")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
This was found while bringing up cpufreq on D1. Switching cpufreq
governors was hanging on irq_work_sync().

 arch/riscv/include/asm/irq_work.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/irq_work.h b/arch/riscv/include/asm/irq_work.h
index d6c277992f76..b53891964ae0 100644
--- a/arch/riscv/include/asm/irq_work.h
+++ b/arch/riscv/include/asm/irq_work.h
@@ -4,7 +4,7 @@
 
 static inline bool arch_irq_work_has_interrupt(void)
 {
-	return true;
+	return IS_ENABLED(CONFIG_SMP);
 }
 extern void arch_irq_work_raise(void);
 #endif /* _ASM_RISCV_IRQ_WORK_H */
-- 
2.35.1

