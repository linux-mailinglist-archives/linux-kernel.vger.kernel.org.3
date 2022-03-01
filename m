Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4AD4C874C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiCAJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCAJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:04:11 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9FA7087E;
        Tue,  1 Mar 2022 01:03:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n14so19299128wrq.7;
        Tue, 01 Mar 2022 01:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0pKuZxEIbazMmfW3N+WzOik5yd4tjStLdtiIPiTMzQ=;
        b=S8DJqyafrnRj+h01YCl2ziBZEgQ1qwa4M5+61CyatjSKtO77MNiJZI821BO2xmmNYn
         i62bZZQSrlOTm6KQDcVAs9b7gQgZyI6mFFkhs8JJsNwkMcHU3kKjsyMocRYiPdr8ni5l
         3dJZFUTH92Zv+Yow2Q7WliJxomeZ55+v0lV/fRHkmNewcy3x1TEwEJbwareg0uJh864Y
         N6yehURW8TxkaByoHo5Ym+1Kqz0masUaC8TXhylN+tf91Nw4mMrVs3rJG/Ca7BTE0JJc
         3715Wfyb8Jw/Dso8pfj54UrEKxA1bwMhwQ8FGMNoCam5RHkHZ8Ag8FJbkOEt5vZHhJxi
         AQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0pKuZxEIbazMmfW3N+WzOik5yd4tjStLdtiIPiTMzQ=;
        b=Tz34FZnfeOIJ/upD4faABvz4GEZen/kvwiGSNpVcrDqFTKgaluLsjhha/yzWz78CKZ
         H52UCziNvKNbdbBB7gQBekH0t9oLsHgDwypmzmxhKuhS22BcjI1rplsRgQ4n2oT3KmGS
         +9fE61IrNtrFXp+9a0vHBaU3CGbtwJA98eLtxMeHo23EBXDUdJAyBL8XXlxXmFlSTqIA
         WeLaUQu7gnVzbr8JU7kagvhMclegoTPpCdvN86oJ+2san+bG03Fgqoja174bqAIT77k6
         +5oYex0g1LMnx/tsBwLEzvuSkf+ooxkdF497CdTIefeEytQaS2brLr4eMxmHMsnee+IK
         /l3w==
X-Gm-Message-State: AOAM5323GR6wu2ipZ0Q5ty+ipGJZqlqnlM1BwMDZ7jUiZSrTYhpskk1Y
        +2NWv95PDT5DUBYUO0qhfSBUuY770ao=
X-Google-Smtp-Source: ABdhPJyNR/LUVGKW1fdHspoZJ48HACeageVG4R4teuxprsu6lMp2q8wG6Y2B1quKALE+0IlF3vCvpA==
X-Received: by 2002:a05:6000:188f:b0:1eb:74ed:9223 with SMTP id a15-20020a056000188f00b001eb74ed9223mr18951534wri.222.1646125408147;
        Tue, 01 Mar 2022 01:03:28 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm1870817wmc.22.2022.03.01.01.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 01:03:27 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] powercap/dtpm: Fix spelling mistake "initialze" -> "initialize"
Date:   Tue,  1 Mar 2022 09:03:27 +0000
Message-Id: <20220301090327.515454-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
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

There is a spelling mistake in a pr_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/powercap/dtpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index ec931a06d90a..b2bcd6d1e242 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -596,7 +596,7 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 
 		ret = dtpm_subsys[i]->init();
 		if (ret)
-			pr_info("Failed to initialze '%s': %d",
+			pr_info("Failed to initialize '%s': %d",
 				dtpm_subsys[i]->name, ret);
 	}
 
-- 
2.34.1

