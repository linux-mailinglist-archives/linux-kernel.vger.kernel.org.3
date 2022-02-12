Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151C44B3519
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 14:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiBLNFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 08:05:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiBLNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 08:04:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B926543;
        Sat, 12 Feb 2022 05:04:53 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y7so6823539plp.2;
        Sat, 12 Feb 2022 05:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Htr9RxdeLjFIZPTJ97Vma8YsNeZOTaEf0nGAdLmzKEw=;
        b=W+jHBfgysMFj725GDWlUkGdkV3URmuShiEPFeTQbRPYgrnqewta1eqjml4p8lhUPL4
         s4nOqTeKNlYRK/J78WwEEh8p2/3j9fMw4y1riBK8lHcoFkevS1CWDwBEHP/GPXhShm57
         Pcwl33LxHq0jBAhsQR/4DGOfBVuuwCZSy1jRla73BDZoeCg/ntCS5zANNfzlTcqQnVy/
         o63CoE4srgTZHzAdYplS8KpAUSZc2ufiRbF25DNy+WUMv9nA8ioYyPqGr78/dD+9ccqr
         U8YhyAsW5jll8krGl1n4On61g53dwh9Aehv/vKBxXI96AfUmTA9wTE8dYzYU1wU2TncT
         kKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Htr9RxdeLjFIZPTJ97Vma8YsNeZOTaEf0nGAdLmzKEw=;
        b=1fLmVvugmCC96GrzGF6+JmCJoouTzSqq68rUtOTh5E0enEuSc4+VjZTU/++cZuj8TL
         HYBz+Lx+7MAuyqjCnfFSeCHfXbfJvGQYWnWfhNbAGUaAOvW46oQM06sDmJ0Nh1RN/zhK
         QkIGqxq4iSzuZhPuAVJ5Qb0LPffYceHvqQiRkVRQM+DQA/K6DdOvt3m5pr12HAVicUNG
         D9eDiFc6IQdI7lEiVZH3mulNd2MIJ2oZ5QUvcPEgyflbP/rltGZW7sKP/qebELG+ln0C
         MlhyimZDNUIR9YfkPHZzeiVAgc8DkUYhAFL+K7ukKx5j+c1iDIi8iHADAa37gHisUCoS
         hShg==
X-Gm-Message-State: AOAM531sLcFmP8vJuou9u+XJ/PYg+tRFL+fbc4qy2TOtP3igqNXybAFQ
        e7qKZnf1LUbhcSm8LEmRWBs=
X-Google-Smtp-Source: ABdhPJyDib6YwgUQVwXX2lSBrfldvstQ60Nk6SZeBTDTIhe0B1qTUW/BbE7Gu4/XhdZRFdw6l/1DrQ==
X-Received: by 2002:a17:902:8205:: with SMTP id x5mr5830233pln.40.1644671092630;
        Sat, 12 Feb 2022 05:04:52 -0800 (PST)
Received: from localhost.localdomain ([2402:4000:2380:2a17:a7f8:71f:713f:850b])
        by smtp.gmail.com with ESMTPSA id me18sm5584106pjb.39.2022.02.12.05.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 05:04:52 -0800 (PST)
From:   Husni Faiz <ahamedhusni73@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     Husni Faiz <ahamedhusni73@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: Fix Trailing Whitespace Coding Style Error
Date:   Sat, 12 Feb 2022 18:34:45 +0530
Message-Id: <20220212130445.503294-1-ahamedhusni73@gmail.com>
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

Removed Trailing whitespace.

Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
---
V2 -> V3: describe what has changed between the V1 and V2 patch.
V1 -> V2: Added descriptive commit message.

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

