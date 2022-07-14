Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB6D574A99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiGNK3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGNK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:28:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0181FCCD;
        Thu, 14 Jul 2022 03:28:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so853680wmb.5;
        Thu, 14 Jul 2022 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVJDeNcmLTR0pKJp80+1GOaB0lAbzqkpNjo8v/w+pkw=;
        b=eWZRkiDpsUktKdd8Flf7wZaQsYj/OyasppqN0M71slzoLAYC4ZkrqvSJB0vT9IBnU/
         KQA2YIb8R6C/xgeWqQYq81l7oKZwKrZf7cbzOJUgWPTHOeRZc24SGw2aWYPeS3UFF7qc
         VaDVuQA5l22Y0eDOeVWj90wWGeyvX0qXg2Xf0AINhwozb46ZKTxo5/5yUahYkSqR9p9Z
         NfzpPNeYtepL05B4+SXfydOZbHXIbz2/hS4kzZCgoIk/1rYogCU948/WSEqDYtyJ7onF
         tEx0YQEzTxLIO8oeuQ9JqkzETAxBlNCLusmXVXa8m3w+UdsXEtmU7HjWX6rbxbyuk1tk
         1SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVJDeNcmLTR0pKJp80+1GOaB0lAbzqkpNjo8v/w+pkw=;
        b=Q1ua6tcBJhs0AbBTAUmKss2sWJAOcBAu3FV4xTPlirTlDZN2bE7zALgoU0zzK+z2h3
         uzO2oeLLLXQmcgMRS8iZEAiKYOZEeLCH14Gg6il0Yugh+lMPa33KeGs/qD3j64kwUa1Y
         nKuSVYaejAFIsVifovBbBb8hFsvsiZrgRPb8yo0jJwQsDajIFQzq6dKIqoOqMIqFQFre
         NGvin5+yw8hylknwLMW8s5BcmGyzbhRXJ2YS4bup66Nme49Qw5sHiD7oOVQvXg75VBFL
         xsZ5qb7TT3L8njNazi7EPaPipDzHPEhX9oJQ6DSForkjVkfeTkdnpLMHT8W4gdrb9fZC
         Pvqw==
X-Gm-Message-State: AJIora9FhCkXxU3WFKcNH9b+ZTdrO5S5ii8B+IZbsPjCKRCL9uqEZZ7b
        gXdZT0Wv0211M5QmvOi/kog=
X-Google-Smtp-Source: AGRyM1viipMxqU52bWVbMBYYUeNF4PaQiBJUBTEAbrux8DrBZOZMtCgDipZpJVWPyuwRO+m0iU6QRw==
X-Received: by 2002:a05:600c:219a:b0:3a2:e4b0:4cfb with SMTP id e26-20020a05600c219a00b003a2e4b04cfbmr14612090wme.2.1657794537714;
        Thu, 14 Jul 2022 03:28:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v1-20020adfebc1000000b0021b98d73a4esm1102978wrn.114.2022.07.14.03.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:28:57 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Fix spelling mistake "teh " -> "the"
Date:   Thu, 14 Jul 2022 11:28:56 +0100
Message-Id: <20220714102856.22512-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a WARN_FUNC message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0cec74da7ffe..8a3c4c1d1958 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3675,7 +3675,7 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
 		}
 
 		if (!next) {
-			WARN_FUNC("teh end!", insn->sec, insn->offset);
+			WARN_FUNC("the end!", insn->sec, insn->offset);
 			return -1;
 		}
 		insn = next;
-- 
2.35.3

