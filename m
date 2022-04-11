Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170BD4FC6B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiDKV1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiDKV1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:27:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1962FFEA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:25:18 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a11so17652332qtb.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=sEEO1a9gpg66HFf13zmhoKxUPpsxt/WYjEBH7Mta+38=;
        b=fUqMBkoKzef3RisQA1sUZojBghR4Vv1ytVm3k7JG8Xk1pRApJTqIcviBhfUKzadIwH
         SSvyJ3u4de/OQ96L15TYxpf5ictDfgiLTTXmvsiamW1eVgISuP/C4Ypwu/yJB3v3GXz1
         hlh3LonXPcIBsg9oVjvgcmUTYqOMMIrC1xGw2KOhYxGjIXq92mwktFtxSms2Rfwrah8D
         vWPsNxxYN+d104ogLLvOMh7IowdB/qKPsrNOlGQbP/Hwct4dHgLvowJfg6hM5elnPNMY
         N0iddWazs/3sQNSNRSme9eByZh25T1oWOfLAGuaBAP8Uxzytux0nHpe6E2ChV/AAI/+G
         jDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=sEEO1a9gpg66HFf13zmhoKxUPpsxt/WYjEBH7Mta+38=;
        b=5HL0h/UkGMpSEv/v5NlRygwDmi4KGm5AYRQJ4a+86rg4WuQFle23sOOKkFEcjQFMmS
         rYp/PQd+P36Y6H19ylCXe2ls2KNHRkRZgY6LpPWwqyd5SBvlJaZnHVMDlduO4SDGoqvE
         rXbbPzeUc2d/Y6CLasYHx6UjIvdlFTlS5N9kt++2Rrlxy20ovUkhazZBe+kcLsqOK7IO
         Mamz3stPDhmjAR9B6+VSl6J9OOAt46GfTYsJF/1O4uu2eT8TnZdtLZn4VxjLMhehuSJE
         NQ5Fg5IalV8ikYXaXcw1ub6l7vpww4Bh7ECbwrOLn4f/h6BRlnvJ93ZjrCn6pxEz493H
         s+iw==
X-Gm-Message-State: AOAM531o6S0gz06qPf9BPy1PwGgeMUOWFhD3W7+XBUgXXYeMqHkm6xXK
        9m4O7ZAPAie9K1tCOZ2tza/L+EX3WnQ3PCiR
X-Google-Smtp-Source: ABdhPJxoaAOAT3J6wBlu9H4yGWw6bUYYlgQ+wLghgi86o+hmgv6kpZAYytWEwUVB+aUW18LO9op+ng==
X-Received: by 2002:ac8:7f01:0:b0:2e1:e86f:fd59 with SMTP id f1-20020ac87f01000000b002e1e86ffd59mr1083297qtk.448.1649712317458;
        Mon, 11 Apr 2022 14:25:17 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id o66-20020a375a45000000b0069be238e5e3sm6853883qkb.48.2022.04.11.14.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:25:16 -0700 (PDT)
Date:   Mon, 11 Apr 2022 17:25:12 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Jaehee Park <jhpark1013@gmail.com>
Subject: [PATCH 1/2] staging: greybus: correct typo in comment 'Atleast' to
 'At least'
Message-ID: <20220411212512.GA2797956@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling typo.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index bbf3ba744fc4..45afa208d004 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -445,7 +445,7 @@ static int __maybe_unused arche_apb_ctrl_suspend(struct device *dev)
 static int __maybe_unused arche_apb_ctrl_resume(struct device *dev)
 {
 	/*
-	 * Atleast for ES2 we have to meet the delay requirement between
+	 * At least for ES2 we have to meet the delay requirement between
 	 * unipro switch and AP bridge init, depending on whether bridge is in
 	 * OFF state or standby state.
 	 *
-- 
2.25.1

