Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657E44C8119
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiCACkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiCACke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:40:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B268C277;
        Mon, 28 Feb 2022 18:39:54 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id u16so12833167pfg.12;
        Mon, 28 Feb 2022 18:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kcdez1q8y9q7LrbJOwiNYeT3i0fDms8O4Aua7+c9gp0=;
        b=iO5J6ZS8Goc3nT1f+CVQJHfvR7JpdoDWPwUnFTS7t2EL1QeMvs38g8HtkrRdrRKLAn
         /H2bWfEXZDdld5cYX20oTsuXMzEq+mPb8Nhpo3olqxmnzDHVLCARiPZRltbMNILPza/A
         phRIHj+cKMk1xOSJhysZHtJ6QWhKGYqsYPo7bwfUqilY7OZ3UzbDZ/0Cp+8iI+sxHI4F
         4W4EvLhFXXTJZGo/xD3kIpHYYHbTJ/1okXa5xyqr0BtMxeOlFUGs5crHgRuQLi+tK3xg
         VUHrfp/ECk/ADgONdcH/90FfkplUwMdYy8PKBA9efUR4SkEo9MiqUC2NA8G0AneJT4r4
         ySSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kcdez1q8y9q7LrbJOwiNYeT3i0fDms8O4Aua7+c9gp0=;
        b=iU+gHy8VnIpW1gCHp6l5eyaBwjYUxCo/bXtmxfCB5rJ/3Pcx+TDSpdiaJeTPzFOdhG
         uPlOeTThBKYrH+s8EHhSxSnlyGDqifKx7WxYvKS6RnozcHOpVZVmFLX2mKN5rczhiDwH
         oTOr52Q22etbjwuF8zSmytKL+17qSACreAh1IMOFSMUUZGP8wexRBYVe2mRD2mEhJk/X
         aDbu1S2dTQ8nzljVJ/X8WyNZGlRAYrB6hCDLGCTyFYdJOQO7b1s8HQEQZfAmA9vE1OXW
         QLSafwKx1dNdQpKTm8oZFs92JncS5WdrQN10/FBxFiLh81p+QqoZff8qhyeUKki3EM1W
         /sTQ==
X-Gm-Message-State: AOAM530CH7S7XW6UCDtXkV8HVCnUIeRi4Usal/6NQqMKCqTGio9SOrms
        i65VDAjDlvqb1ngAKykTW64=
X-Google-Smtp-Source: ABdhPJwSGvmoASy2vDfJkotJkQu13QOqReCFlvagBwZgJqAFPS/ix2lUlTJA+sBvWsCZNO84qOV8lg==
X-Received: by 2002:a63:641:0:b0:374:47f2:3cd7 with SMTP id 62-20020a630641000000b0037447f23cd7mr20174277pgg.24.1646102394284;
        Mon, 28 Feb 2022 18:39:54 -0800 (PST)
Received: from meizu.meizu.com ([137.59.103.163])
        by smtp.gmail.com with ESMTPSA id y8-20020a056a00180800b004e156f7191esm14328376pfa.213.2022.02.28.18.39.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 18:39:53 -0800 (PST)
From:   Haowen Bai <baihaowen88@gmail.com>
X-Google-Original-From: Haowen Bai <baihaowen@meizu.com>
To:     bristot@kernel.org, rostedt@goodmis.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haowen Bai <baihaowen@meizu.com>,
        Haowen Bai <baihaowen88@gmail.com>
Subject: [PATCH] rtla/osnoise: remove unneeded semicolon
Date:   Tue,  1 Mar 2022 10:39:49 +0800
Message-Id: <1646102389-21268-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:
  tools/tracing/rtla/src/osnoise_hist.c:776:2-3: Unneeded semicolon

Signed-off-by: Haowen Bai <baihaowen88@gmail.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 52c053c..f128f20 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -773,7 +773,7 @@ int osnoise_hist_main(int argc, char *argv[])
 
 		if (!tracefs_trace_is_on(trace->inst))
 			break;
-	};
+	}
 
 	osnoise_read_trace_hist(tool);
 
-- 
2.7.4

