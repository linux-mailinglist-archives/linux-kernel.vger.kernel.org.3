Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550D0530372
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 16:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiEVON1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbiEVONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 10:13:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69562983A
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 07:13:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x143so11545934pfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qIz0i4A79i5mD7uv4Namb4R+lL/P7P0cLluFArzY2Q=;
        b=arrxEhYv5DZySCf6yIg4kTYeAeeShqHsVlTz6RJGXOfywNFJJAgbopWpELZR6f8KCw
         cDg1dnyTvUidD39UbRulRng9U9dJZP6YFemhCx4VcZuesV9YqWw0ygerrZay/5oYla4C
         0xpRkJVQ4sGsuEiylPkgSVd7OM7ct2FjSEOg83vUonbfxqZOzb1jlqiRZRRlYt4JW7Cg
         wT8qFknu3opMmynPnA4GRIT6STlC6B3MSf8HRDuJhJm/jf96Qcn3PhRxjpDLp8Lfz1j8
         e9ObLCW3K/0QX1PcO2h2xXmCF2R4kdrVxCJh7/XhtJNmxBFgCU3m+s5sBK3ZR0fbJsVU
         E+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qIz0i4A79i5mD7uv4Namb4R+lL/P7P0cLluFArzY2Q=;
        b=uaZrSJzSmcHUGRdDW4J5db/dILAc0etd+0IIxhUvF4ewdJOWoWpGCmGEcjpYrsOwQs
         hxPmuuxQlnps0kcj7HWiyFPf5VPfoxalAwXeeLnzDL2awp4fQQXEhQL2gpoYiR7szm8N
         sdzrQ22ToQ4b+GRLgGSoBytBupXuDhd2uFlolcaJEuyh/X3cZl3eQS9RiL2pO0TOBwBo
         NfMXscTjFA0aKfTRe5ch39A6QwJBH+GJDujUUBo2BvUYJFI2Z/LbLXW9gXFtnNmCqo0z
         In5G0MLy3K4meYR+ir4czuZVN3ztpntX+8By3fYheTuZqxR/i8ZDtI+/kUcH3Yi8bFRq
         m2zw==
X-Gm-Message-State: AOAM533ibkWNNCjMh3XRauV0bDbGtwlhOY4CM8VIJvBtEWF+xRVlmsIb
        rz9pVv8ExoEjUWdjrp6u3lbQx1XYV4pH8LFm
X-Google-Smtp-Source: ABdhPJyB7ZzFOrKX+y5GE03Qa++pDMOJg6D8Xic35KDQfk1ONygOxjJoNi507Bgdi8d/kmKEr+KWug==
X-Received: by 2002:a05:6a00:170a:b0:50d:3e40:9e0 with SMTP id h10-20020a056a00170a00b0050d3e4009e0mr19192794pfc.48.1653228802354;
        Sun, 22 May 2022 07:13:22 -0700 (PDT)
Received: from localhost.localdomain ([223.212.58.71])
        by smtp.gmail.com with ESMTPSA id 1-20020a621701000000b0051887f53cf7sm2660798pfx.154.2022.05.22.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 07:13:21 -0700 (PDT)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Changbin Du <changbin.du@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] scripts/kallsyms: update usage message of the kallsyms program
Date:   Sun, 22 May 2022 22:12:40 +0800
Message-Id: <20220522141240.761351-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kallsyms program supports --absolute-percpu option but does not display
it in the usage message, fix it.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8caabddf817c..a2f4b8d7580f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -70,7 +70,7 @@ static unsigned char best_table_len[256];
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
 			"[--base-relative] < in.map > out.S\n");
 	exit(1);
 }
-- 
2.36.1

