Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4FE4B0E21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbiBJNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:08:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiBJNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:08:06 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180641A7;
        Thu, 10 Feb 2022 05:08:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso1826660pjb.1;
        Thu, 10 Feb 2022 05:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOt73+jWS3QDyWvbhqbKIWv7cG6j1CumkbcqQm/qDyA=;
        b=XKPERMNc0jHgDVuciwfgf9Y+qdYBieZJCcA7GT4bZyZ7Z9OJJthfsARhO2Yprffulm
         qcIKyyTgK+cRxPxfbDaIg5G/YeLAEYRAyJE1jApeDXiFLYyhK7Axqb29hr92jKFNCqbd
         5eMKYD1j61AKZUxmLytHi/7JdsHgNPKZTq7ch7ZBRWj24KpElfvUI3fA59A0lVoT+Tvd
         ny4MzPWU8iLj/QJfUJQG1DL0x+PfunPC4Pw3H2UVzkAwWDggn29EZi40QNc+eM7SiViR
         JZcJuric1cqh1GCFsiz/6GD1gk1z8v+Ur4frNnC4onINfwPOFrH9W+HvEnqwTErVVwms
         PG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOt73+jWS3QDyWvbhqbKIWv7cG6j1CumkbcqQm/qDyA=;
        b=6Z1h1Zeo5qsz9CNesj6D2Rs5nqL8CrEp77W9bV/RBFjF7TTFAh4qxG4Wb7DMTZLCTB
         dsHhCZaTd7ua/ldWuoJTbpOnDxJqYHrX2jOvMwKX4LMYRUiHuPGQ36xrT556nKKQJBJH
         a6tWDKK+zo6Mshhd0ynAClCp2k58ebAZ3Uf7ozC4NJa44HnWah2reP4Mfs+7Jf5BppFo
         8DRQUvQ0AG581qbuUw9b8wN/7tWLFk48/OmdjUC55S7v+eymo+w4qGGD6pepNNT02YEG
         pJ4i5ygATHfOjC6Bn2nLzitQtEzeE9zb83597Im6aXeaA0lpIleaPY2q6eq3wPw9y5il
         O3vw==
X-Gm-Message-State: AOAM5312G5SuLO3tULHbQo+7SYyFpWFhvE5BrVldBN7W+rB5vgcBQaTL
        wg/X/vXfoNlQ0Wqo2LBsS40=
X-Google-Smtp-Source: ABdhPJwhAw6Veu9/mGuyi2Dcb4vqIUkoRMsLJvXxS5P6eL5cKb2Ru7N5Piaa0TRn8rBDmqxAgcKtvg==
X-Received: by 2002:a17:90b:1d90:: with SMTP id pf16mr2726635pjb.245.1644498487525;
        Thu, 10 Feb 2022 05:08:07 -0800 (PST)
Received: from localhost.localdomain ([2402:4000:2280:c25e:b741:a72a:453d:8a4e])
        by smtp.gmail.com with ESMTPSA id 19sm2378018pjb.42.2022.02.10.05.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 05:08:06 -0800 (PST)
From:   Husni Faiz <ahamedhusni73@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     Husni Faiz <ahamedhusni73@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/usb: Fix Coding Style Error
Date:   Thu, 10 Feb 2022 18:38:01 +0530
Message-Id: <20220210130801.377918-1-ahamedhusni73@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>


Removed trailing whitespace.

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

