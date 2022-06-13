Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17B45483AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbiFMJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiFMJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:22:37 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D9013D67
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:22:33 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 25D9Kgx8000823;
        Mon, 13 Jun 2022 18:20:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 25D9Kgx8000823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655112044;
        bh=geZktAm+s7Yy19cRfK3Fa5IfT7B/Uq8q4gOcEHOo8Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNrbi+i2RZvCHfXkLID7CANqJ0V+E5DyR04ZodAvDTdqBbf0l/dHDVkK/8QnbzdAL
         iv0+AcaU93RhU/Ud/jYNKdy/5H7tTTAArZk7ib7f0VuahuthxsfH/DEUtAQp8UtRMG
         t+obGikq+j/sSQLDU1ce9chr415/9mvGGGwizVfIAH0cav2l6pI1H6ZSRxDcyIHoc/
         SGnyXci+kGWtHOYU9X/1paPVQnE99/8JGJ/cmXuLBJOsjG2mrHlMRvPI1RMqXGYThs
         eTS84bqPucHC+DviBfzXirCw6hsRffa7c5gkkWSoL2AMbfk/89LKCC1QYb8uBAKeZL
         b4z5JcK6c4Hpw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Keir Fraser <keirf@google.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: arm64: nvhe: add intermediates to 'targets' instead of extra-y
Date:   Mon, 13 Jun 2022 18:20:26 +0900
Message-Id: <20220613092026.1705630-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613092026.1705630-1-masahiroy@kernel.org>
References: <20220613092026.1705630-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are generated on demand. Adding them to 'targets' is enough.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/kvm/hyp/nvhe/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 3c6d3a18171c..a2b0d043dddf 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -28,7 +28,7 @@ hyp-obj-y += $(lib-objs)
 
 hyp-obj := $(patsubst %.o,%.nvhe.o,$(hyp-obj-y))
 obj-y := kvm_nvhe.o
-extra-y := $(hyp-obj) kvm_nvhe.tmp.o kvm_nvhe.rel.o hyp.lds hyp-reloc.S hyp-reloc.o
+targets += $(hyp-obj) kvm_nvhe.tmp.o kvm_nvhe.rel.o hyp.lds hyp-reloc.S hyp-reloc.o
 
 # 1) Compile all source files to `.nvhe.o` object files. The file extension
 #    avoids file name clashes for files shared with VHE.
-- 
2.32.0

