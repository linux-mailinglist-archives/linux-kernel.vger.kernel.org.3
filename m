Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5951600D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379672AbiD3TP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbiD3TPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:15:02 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5851E4E;
        Sat, 30 Apr 2022 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OnyaH6aiSjflPWDqKBt8CN2r/CmssKtB6XZg6V2PZUg=;
  b=IaCiDV4yuWZ8ZRWu7b0a3rdNh3QS1g1Mzz18nNlOizDdE6EOFFwaRuIM
   yCkuL66AsaaJI6Zx84gUirmnLUyjo68o3jMfnAZ+pOJ5s+UFrbVa+BVYA
   mdv+sHQ3FYgr5wzHYXD3KFmTJ22CGFgvhFo4TY4kUcAu2GCaC538R49v7
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,188,1647298800"; 
   d="scan'208";a="34084620"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:11:33 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel-janitors@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] m68k/math-emu: fix typos in comments
Date:   Sat, 30 Apr 2022 21:11:21 +0200
Message-Id: <20220430191122.8667-7-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/m68k/math-emu/fp_arith.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/math-emu/fp_arith.c b/arch/m68k/math-emu/fp_arith.c
index d9033238d097..f4a06492cd7a 100644
--- a/arch/m68k/math-emu/fp_arith.c
+++ b/arch/m68k/math-emu/fp_arith.c
@@ -243,7 +243,7 @@ fp_fdiv(struct fp_ext *dest, struct fp_ext *src)
 		/* infinity / infinity = NaN (quiet, as always) */
 		if (IS_INF(src))
 			fp_set_nan(dest);
-		/* infinity / anything else = infinity (with approprate sign) */
+		/* infinity / anything else = infinity (with appropriate sign) */
 		return dest;
 	}
 	if (IS_INF(src)) {

