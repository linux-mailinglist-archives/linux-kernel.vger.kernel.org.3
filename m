Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25C527BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbiEPCIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiEPCIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:08:46 -0400
Received: from localhost.localdomain (unknown [219.141.250.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2664F1CFD8
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:08:43 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTPS id 24G24jaF004315
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:04:45 +0800
Received: (from root@localhost)
        by localhost.localdomain (8.15.2/8.15.2/Submit) id 24G24gCw004314;
        Mon, 16 May 2022 10:04:42 +0800
Date:   Mon, 16 May 2022 10:04:42 +0800
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, Kernel@nfschina.com
Subject: [PATCH] scripts:modify output format
Message-ID: <20220516020442.GA4277@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_PBL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts:modify output format

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
---
 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8caabddf817c..ba50993785ec 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -498,7 +498,7 @@ static void write_src(void)
 
 	output_label("kallsyms_token_index");
 	for (i = 0; i < 256; i++)
-		printf("\t.short\t%d\n", best_idx[i]);
+		printf("\t.short\t%u\n", best_idx[i]);
 	printf("\n");
 }
 
-- 
2.18.2

