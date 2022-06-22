Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA685541E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356988AbiFVExR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356930AbiFVExL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:53:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BED46244
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 128so8018835pfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miDHh8TIXvhG9iaGpB6jefg7h3ay42uNe8cnWKGwUNM=;
        b=H6++axkvJgfmn6n3LaeDwik2qAP91cPX6DQctcDvpgU3kkAk+jCelu+FO8wdZfLNNB
         lWha5g2gfEYAMNBiq0hhdWD1na1d8OkqCzZDpAbTYFDDZVY/G6rnJm1Y3AScVQh9Sefy
         lPVxWHIQr8NYwfAgTKHBff33VgMiO6xNmpeCSNSlhuxLO6Qgzb06148N5XO3OiTSnNhz
         uEizQwa/LOb6D9DOL4HzowJ/L9MluKz7prOYrjE9/2osMcc9dB7AxEt5UmeiuBROsT6n
         5MI30fGl5UC8/n4ypmTGfhzlcpyG22lrgjnk7WZUdTqIt0iQP0qNS+Q+1hBD9DNYmKmB
         3NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miDHh8TIXvhG9iaGpB6jefg7h3ay42uNe8cnWKGwUNM=;
        b=ee+xR9akKp9oLSPHW5q7Rp2Nzj+gKdEuSvYrWg8CCVupdlMWWp5AY1BpJTnse2IRr5
         /tdpavPbve81EPiNyYFpiQVHil++R+UKkggsoonJXVRWL8JPxgzH4bGLSKgfgdXedqxL
         wm3fwnyVJlDOFRoDscAOcsFrVKbFQr2Y1DPodFEXT6oV9Ec6ZxASZmhuJHguqqIzNxy2
         gs4YXMDSpn7LPh12DCGr6N9fpuTLioenMs+74otFtNAmTSnnArFRMWTAc3kzlwI/nNIX
         Pz4K68zBb4vnVN2mLejI2QtM/DXZNET/XZwGrKrWLqoYkQGeftjnZVPf1sK7/dTafzga
         cRRQ==
X-Gm-Message-State: AJIora9ypN6YQkHmNOfZhbfHjmu07DffOTagea2p/Y8beY9n2ajawUQw
        Brk9Cgtabu6s4RXVfFpXCQgG/d8A+SpK1A==
X-Google-Smtp-Source: AGRyM1sfWuGFQ0cMtpUQWtwL/DSxT6D90LTQzU8iTv8hKDvHwDOE5PCYCmL1jj+1hsXVdN3jKYTqyQ==
X-Received: by 2002:a05:6a00:16c7:b0:520:6ede:2539 with SMTP id l7-20020a056a0016c700b005206ede2539mr33230812pfc.46.1655873590035;
        Tue, 21 Jun 2022 21:53:10 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b00163e4410b82sm333812plx.239.2022.06.21.21.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:53:09 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: Fixed two brace coding style issues
Date:   Tue, 21 Jun 2022 21:52:31 -0700
Message-Id: <f08a494f324cf5a3b5ed73aab6b3a432cb1da67b.1655872968.git.marcus.yu.56@gmail.com>
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

Removed two pairs of unnecessary curly braces as per checkpatch.pl

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 7e2f5c2f9111..38b7905dc88f 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1365,13 +1365,12 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		a_len -= nSubframe_Length;
 		if (a_len != 0) {
 			padding_len = 4 - ((nSubframe_Length + ETH_HLEN) & (4 - 1));
-			if (padding_len == 4) {
+			if (padding_len == 4)
 				padding_len = 0;
-			}
 
-			if (a_len < padding_len) {
+			if (a_len < padding_len)
 				goto exit;
-			}
+
 			pdata += padding_len;
 			a_len -= padding_len;
 		}
-- 
2.36.1

