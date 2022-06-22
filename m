Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9115541E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356977AbiFVExN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356941AbiFVExJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:53:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74F16244
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c205so8297767pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siwRRlWSHlqBGRmLfqz7WxH0j7k4YZlDP6vTKzeSc6c=;
        b=CoRfui3AvkifJVNvTBqxSBEUD1RYlSXklq1JdozIQVHQLvRrzsjtovZ6Isp0zGwCMx
         DlGkQdi7McDlD7RLEBXitXtLnQiHq99dxMG1x0Cph1euVOhRRelQlHa/6Q9a/Kn2m64R
         /bFjlHnkKZaz519snylg4U/yjnub5c9OFZNIHCtDGAxxsGD7w/dR0xN7DS0o9ClkrIVy
         yISryMCuR61H52bL+z5G/JvXswHwHkIMFh42GU24bCdBSVnwMndMfE02R87i3RHy/ufV
         qCfoNusCj/ZOTQzYFhqs8epqOED/FrCxnben1Wbe4fKCU1bQRQPHZzwFzdDvCoZ4wgqU
         P7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siwRRlWSHlqBGRmLfqz7WxH0j7k4YZlDP6vTKzeSc6c=;
        b=b+E7PJco91epqSBcM3ArD2QoUOYKYarh5lj0n4R5AafS/2dgK/ihBM4F8NR15gsifG
         l2irFIHvLsIYRKoecMFRea9kMAjnXTxtQlEE9uCyilr7V6gTIeSfwGiU/facYjpVf0+1
         gZBsk0UQoQ1igHk3qRX06PR7RENYqIRtrO5N3PsVr0IFqxkr12NKqrh6A+dn2K2pco1/
         rrQ1W7YSPIkVa/iNaukMLBuxtYqzqpI8DaRfy2tv8WG/+Di8jbnB0EARPK6nl22jmpDS
         tyzCQlXSoTKm17inF6/rtXJ8v3CUlvbyDxKcfrotwzs3a8vlo59Q3+lhC6vf++SekcvO
         nsRg==
X-Gm-Message-State: AJIora85c6gHtpq9mQgcwS1M+ykGLuiOmN6kzYpWfgrdyzE2Zq1qPrgL
        e2oskKtMjnbPWqjBQ6vKTsY=
X-Google-Smtp-Source: AGRyM1sdcPcXr3djCCbq3GGXESutAPLO30Bkk1Op95VLl9vFeB8PwZCYQFGaNzHT7jnyDX0WLathSg==
X-Received: by 2002:a63:78cb:0:b0:40c:e4e0:dfde with SMTP id t194-20020a6378cb000000b0040ce4e0dfdemr1381517pgc.87.1655873588301;
        Tue, 21 Jun 2022 21:53:08 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id gf23-20020a17090ac7d700b001ec9f9fe028sm5564482pjb.46.2022.06.21.21.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:53:07 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: Fixed a function declaration coding style issue
Date:   Tue, 21 Jun 2022 21:52:30 -0700
Message-Id: <778c21724752f2de136d82b31c9ffc2bf35ced55.1655872968.git.marcus.yu.56@gmail.com>
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

Added an identifier name for function definition argument
'struct timer_list *' as per checkpatch.pl

Note that for the same line checkpatch.pl will also complain "extern
should be avoided in .c". I am not very familiar with the codebase
so I decided not to move the declaration to a header file.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 36ea79586992..7e2f5c2f9111 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -24,7 +24,7 @@ static u8 rtw_rfc1042_header[] = {
        0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
 };
 
-void rtw_signal_stat_timer_hdl(struct timer_list *);
+void rtw_signal_stat_timer_hdl(struct timer_list *t);
 
 void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 {
-- 
2.36.1

