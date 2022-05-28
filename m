Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9F53694C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 02:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbiE1AJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 20:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiE1AJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 20:09:49 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB79418F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 17:09:48 -0700 (PDT)
Received: from LT2ubnt.fritz.box (ip-062-143-094-109.um16.pools.vodafone-ip.de [62.143.94.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6FE243FC04;
        Sat, 28 May 2022 00:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653696586;
        bh=iv6C6fb+pb6Y/qg9+Rbp2J7/UDs4R9jxDja5tAInZvs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vfn2mRnDkLHtcQWe5nge9Kmsvfj6Dw8W3BTCGgFGW+lXLE5oC82z85GzkhJ/a5pKe
         CYV5F0NeBJAr5cfH4BlzTTJwZqkATcyF83BdwAZ7QGV145FuBuPaozgf308pTjaHRK
         bafShU/bTw/s0UuG+B1WHIJ2K56HNbq12SHxvqI+9TN4okbKvIJ1izswMCgwoslLTa
         aftF3zCQwyp2irCm+GIPmSr6tH1ZSBo4jcIfkvEazZIrqPBomVEZQzfQWg0E4efCkU
         0YNDYmFqFLPfo7Tz30oZsoBJYt5aYyy54dv1Qtrp3O0mcMYr9kja8aco+eX599uuap
         Xr1Gj6hm4+spQ==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: fix typo 'repalce'
Date:   Sat, 28 May 2022 02:09:34 +0200
Message-Id: <20220528000934.21182-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%s/repalce/replace/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/Kconfig.erratas | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index ebfcd5cc6eaf..6957b4e6c5e8 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -27,7 +27,7 @@ config ERRATA_SIFIVE_CIP_1200
 	depends on ERRATA_SIFIVE && 64BIT
 	default y
 	help
-	  This will apply the SiFive CIP-1200 errata to repalce all
+	  This will apply the SiFive CIP-1200 errata to replace all
 	  "sfence.vma addr" with "sfence.vma" to ensure that the addr
 	  has been flushed from TLB.
 
-- 
2.36.1

