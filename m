Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AE94B161C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbiBJTS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:18:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbiBJTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:18:52 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7CCB4A;
        Thu, 10 Feb 2022 11:18:52 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i6so10080477pfc.9;
        Thu, 10 Feb 2022 11:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxzPyMJ66vbBrew9YuPd6UOgw7GnBdmrpYAbtJ9g4ZY=;
        b=QZvL+A+WYsqkbPCTHyUg8ZW20yVi1jDTY5PbDE5aLcXPIlgmeEtMKm1aNzS4x3gqg6
         9dIYX5PEd2iSvbQmz/ZQQ5NFWWdCEmuS2tDVIx1+n0vCB131hEmncK5i0p0C9dbzI0l6
         AB4iC29qZWf5tbjkbw4hRCQfHjKBbOwNTAXHM3pH7WXZEPZiZcuchyh3cNobW2w+t/Kr
         d6lLcsEKUzJ64AFkzRGAk5oRSCjUrswvLEZrkSqkKjMMUtXkx65VAJJHzY0GMRWJFvYG
         pORwG/aLZeUGyYtH0Lr7lUpPLQ3ISHg+DQJ+j8AwKjlSmaz6rf3QrKfFynXA69zLf6K5
         f/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxzPyMJ66vbBrew9YuPd6UOgw7GnBdmrpYAbtJ9g4ZY=;
        b=gjkNYShLgMeJYUlDCMKQgOgw4HYY1BrNmsx6vtrUmaQ67B1Ng/QAGFZHFXklofn01o
         JnrfA3JFGrUgW1lRS4pU8GJ668EOlMS1oH/Ra94x2cu6eGqxwxDHqoZz4WtRjpzfVVeZ
         3ALeTb9D9O7if3NjpZl0LYhTApcGURGH42/xDy2cKnKaK8dF9eyJk4mP+0hbzGoidtEi
         fzd5Ees+uF4h2gcmgXgavYFzuWpr8QGwq0Gw54+gCKll1lDFH/ANpJftJqLgoKWFkvkG
         uyzEcppQO3OlMgGhvWIFPswsyN13zFuCMVA0M4K4HqHklf3ReU/NXarVcoqBXbn4ZWnO
         A+ow==
X-Gm-Message-State: AOAM533pgcn2ucFIqj/IHlTAkN1BTGPkri5DYI8oHfmJ/WhViOKgG/Ht
        aLRKkDedP81VgJP4zGOiPcM=
X-Google-Smtp-Source: ABdhPJynZGJpT0fQkqS8fS6r2oN32TIgDEq4U6uLqrBIpy1WXEMYU6WR6YAfAZzqoAGUXG2t5k1JSQ==
X-Received: by 2002:a05:6a00:24c3:: with SMTP id d3mr8969398pfv.81.1644520731913;
        Thu, 10 Feb 2022 11:18:51 -0800 (PST)
Received: from localhost.localdomain ([2402:4000:2280:c25e:b741:a72a:453d:8a4e])
        by smtp.gmail.com with ESMTPSA id f3sm25316003pfe.67.2022.02.10.11.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:18:51 -0800 (PST)
From:   Husni Faiz <ahamedhusni73@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     Husni Faiz <ahamedhusni73@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: Fix Trailing Whitespace Coding Style Error
Date:   Fri, 11 Feb 2022 00:48:38 +0530
Message-Id: <20220210191838.398373-1-ahamedhusni73@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210130801.377918-1-ahamedhusni73@gmail.com>
References: <20220210130801.377918-1-ahamedhusni73@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed Trailing whitespace.

Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
---
 drivers/usb/musb/musb_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 9ff7d891b4b7..cf25a2b7e3bb 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -563,7 +563,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, u8 epnum)
 	ep->rx_reinit = 0;
 }
 
-static void musb_tx_dma_set_mode_mentor(struct musb_hw_ep *hw_ep, 
+static void musb_tx_dma_set_mode_mentor(struct musb_hw_ep *hw_ep,
 					struct musb_qh *qh,
 					u32 *length, u8 *mode)
 {
-- 
2.25.1

