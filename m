Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6D559A630
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350824AbiHSTRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349506AbiHSTRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:17:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BEC112330
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BD42B82886
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8006C433B5;
        Fri, 19 Aug 2022 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660936622;
        bh=RoXrwfU/s5vurCwlxvo8Vd+Lw1JXCW4diLyk4VZ6JDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/yIDSq5tz/8o9kUNSGR2WjXk99zL+giUdFlfKqysPvpQHpMEpSV4s+340Igg9BCU
         Pyn24U/6pa4/MiLG4JKW5a0SVYG+x10i+8RBJLh27uC5b9BNjYC/VOrTjItYfycV5I
         sQS+TZbnbNe8WB2OQBesyRZjgho1h3+ZzVa6QBu+qHLqYP+MA6Yhq3aPgdxNADh8HV
         3GijZPFm7+cDyjbdBSzbJ4QNll2FugdmTyiS22WvplaPh4nZlj5p1o7neZl/6XAilY
         QKtIETbODj6FHDXQolqp8v/R0qX6aGiRJMr78uDjn9l11cHqu7bLQUxqxcGR3wncI6
         yO2X6nIqOhlag==
Received: by pali.im (Postfix)
        id C66E82980; Fri, 19 Aug 2022 21:16:58 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sinan Akman <sinan@writeme.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
Date:   Fri, 19 Aug 2022 21:15:52 +0200
Message-Id: <20220819191557.28116-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819191557.28116-1-pali@kernel.org>
References: <20220819191557.28116-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function mpc85xx_ds_pic_init() is not used out of the mpc85xx_ds.c file.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index f8d2c97f39bd..9a6d637ef54a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -54,7 +54,7 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
 }
 #endif	/* CONFIG_PPC_I8259 */
 
-void __init mpc85xx_ds_pic_init(void)
+static void __init mpc85xx_ds_pic_init(void)
 {
 	struct mpic *mpic;
 #ifdef CONFIG_PPC_I8259
-- 
2.20.1

