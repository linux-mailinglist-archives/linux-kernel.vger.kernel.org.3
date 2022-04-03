Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6654F0B5B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359513AbiDCQzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359496AbiDCQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:55:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165C3915C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:53:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g20so8420964edw.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEtYo2gnt++pvnsYGIYS9pvktdaQH4lw368nfE7WujQ=;
        b=L7Dii95LUzvQe6fRXpgyYQqIDzZQqBJT8gZKxi1wJpM0H/j2kGmRFEwlITraIGTWV+
         Xh0aBd5xYiOCPRjktdmZQG4p8JF0sr6gwD6PDPInLfj82SXHpVAMuLzwSywTtmsOm0+D
         KLYzZ3xd+yNf0Z9E9V8UdEZVZ1eJZsoWtlcqGG+fiqcimZDGpHJBVoZ9n+M0UJMNG0sy
         X9MQwQa4pb9TUeeL4WefpX0TXttroIAr727i5bY9sRQ4NaW6S7uVx3IbOX4zT47HzcmY
         lqtwuBoOr3sHAqezzkOqY3K1RxtupQ5A+nBgxERup9qGesWRrpksjK9AtImzKmJXFikf
         SqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEtYo2gnt++pvnsYGIYS9pvktdaQH4lw368nfE7WujQ=;
        b=t/EL6DI6+y0RJjxI6/KooC3YFgcbmTrsZhZnwGh5EMZ5ebUk9RvCBzEXYjBgr3XPzq
         WVuK9nsupUurW2nw8NiRHEfE1lFBmaNn+1/j3rykSj/cIAaQHqkqofsVk8iFyxmmDxGn
         qfkIIzAo8EC1SztErRYBvZnERWQwQbtCBWeLk54hwz/wsONRp1FftfjkKNJNjMNlA0LS
         ZyDxBKUJve8R5OvHs00/JYs7SkSxRjB4SIq0FCnHbYsLPT6ADFaQDG4+3X2jMzzLJxX9
         6WeXasmqk/fMsvcmIUPqrKjZs3KsL2T+5w9RFQjB3yPFbtXKRuujA1wfSlf4ASREBk3V
         oEAQ==
X-Gm-Message-State: AOAM5306QL/Fo/+0bydyoCn74nSEqr7Yur1XOxqNv4ts8b6V1JSu+djV
        GqoEVuqdju/5n+BtXVsZiAs=
X-Google-Smtp-Source: ABdhPJzHan5prHCKHnYE2SNPpmLLo+8S96+EsT/DTNhE5X6S0xSrHcuaTDxhB+Q5pD4P/aG4pjgF+A==
X-Received: by 2002:a05:6402:278f:b0:41b:79b1:39b4 with SMTP id b15-20020a056402278f00b0041b79b139b4mr16987672ede.163.1649004785422;
        Sun, 03 Apr 2022 09:53:05 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm4018138edu.11.2022.04.03.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:53:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: remove dead code
Date:   Sun,  3 Apr 2022 18:52:53 +0200
Message-Id: <20220403165255.6900-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403165255.6900-1-straube.linux@gmail.com>
References: <20220403165255.6900-1-straube.linux@gmail.com>
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

In rtw_select_and_join_from_scanned_queue() the local variable
cur_ant is set but never used. Remove this dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index b6ed5fb5b281..24ceb8028f89 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1484,11 +1484,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		rtw_free_assoc_resources(adapter, 0);
 	}
 
-	if (support_ant_div(adapter)) {
-		u8 cur_ant;
-		GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &cur_ant);
-	}
-
 	ret = rtw_joinbss_cmd(adapter, candidate);
 
 exit:
-- 
2.35.1

