Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D025C5541E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356249AbiFVExT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356976AbiFVExM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:53:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF662C8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 128so8018835pfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxvmsU5m8dUdexI+F5twWDTTNh+JWXM865vqfEysxx0=;
        b=Mq7oXFbEQcnHGEQtngIIAPELIYUoo/5Gwkd5Sphhu2G4H4b9vVYsVcRnVM9uKmBoZv
         hyPio4D9Sew8/ko03NSJiWydLl4XfJ4yhMh0Dplh27Z3IxJhg8Kf9xigGM1SCQygMTrE
         SWY0wDknwKDwUYMm4fOjil784KcmTncjqT8XMsMBwqY8EbPtlsBNfAelbLBvpwU27fK7
         cHe7V8sgV0WZGxuIWEXfy49JlS5f2AmEpFJBFEk/vIia6YPkoB/QzNJD2FFf6B8Kk8n9
         17vMbJIajX0U2wvKgyFwwHaEL3qz/u+ME+/0BxA2t1hVlHKCBq0tUWuIsJQne+m2nyHo
         DhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxvmsU5m8dUdexI+F5twWDTTNh+JWXM865vqfEysxx0=;
        b=ajJ/ZIKTOoTpYLOrokhQauhFg2ioyP/Rz1YpZjkKbaGJngBFNhPU789KWZIBO4maJ5
         jGTT5OnqU3yf5GrT1k/iIy2B6aCYbDbcOrxvk/r/zxV5016MRsQuaeOJo6O9iply4Gri
         nwVuJFet8nkPN8igYgNQiElAZSVETS4FqyX/xlSlYFbZNlKc85CuR52WySC3iSYjFZ/7
         mt0H9hw0avhTAJKsX6SZM8kjWaRzNY971Ilpxh3NB1c4KG/jrUAav8Aklt6DcZZjhQqw
         mE5DbgpM5/q4qO4iQobUuC5qbJcx4WfNKjUqcnBQjQBh/Bl2zCjz4zCst9SfKQN6JWGf
         NTpw==
X-Gm-Message-State: AJIora8oRicTl6RBRgWmyuiUqPR5iuD+YrURkdrrE5pxMXxyC9t0gtJ9
        B80kF0v+l0FYJ5DsejMoVT0=
X-Google-Smtp-Source: AGRyM1unzEkZ+0rqye8e6MIZjZeRlNhrkw9JMlqQKIVoGDonvDQ/bOvFhlSiBjcYbjQGDVLFcKun5A==
X-Received: by 2002:a63:fc01:0:b0:403:af21:9729 with SMTP id j1-20020a63fc01000000b00403af219729mr1377939pgi.54.1655873591805;
        Tue, 21 Jun 2022 21:53:11 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id h4-20020a62de04000000b0051bb61c0eacsm3938518pfg.20.2022.06.21.21.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:53:11 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: Fixed two whitespace coding style issues
Date:   Tue, 21 Jun 2022 21:52:32 -0700
Message-Id: <68cb57799d9139740f94eed9080e2d08c522e74c.1655872968.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655872968.git.marcus.yu.56@gmail.com>
References: <cover.1655872968.git.marcus.yu.56@gmail.com>
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

Replaced spaces with tabs as per checkpatch.pl

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 38b7905dc88f..d42ff210ee81 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -17,11 +17,11 @@ static u8 SNAP_ETH_TYPE_APPLETALK_AARP[2] = {0x80, 0xf3};
 
 /* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
 static u8 rtw_bridge_tunnel_header[] = {
-       0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8
+	0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8
 };
 
 static u8 rtw_rfc1042_header[] = {
-       0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
+	0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
 };
 
 void rtw_signal_stat_timer_hdl(struct timer_list *t);
-- 
2.36.1

