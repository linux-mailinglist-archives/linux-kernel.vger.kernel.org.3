Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A64F012D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbiDBLjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiDBLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:39:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453D5D5F4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:37:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d7so7602162wrb.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnSYZsmgMzEbq+f2jszfZPGO/GYBrKMzjlQ6YrWUQls=;
        b=JXrJ5pdAyvnT2m35Qe2NYxVQNjZD/GNWeN7qhYu8k9O08zpmkdKWt2KPC4cYqkiE5D
         tykqT3vxPqH6m14IGblD+qteKLFJEEqkaGLyUzNDBldteMA/Etvz4HDTJWtTxwh6QgtS
         FCYi/jPIvVstXjEiKotOZzDmI1aoZLktzrzCiBL2zrTcPKycfJ8M7cRlCnBO+VxKA631
         vlVEWKxYfeho3oBwpuRcPfKmDNodU6G3Vz51kPkdp5xmIyUBuPXgTYDFcPyo2e253Me3
         Vj+4dbNTOh+VTAgYbApmmi2HzZYs+C26DXh+YVeSVCtXjJ3inS2707+3fo01TW3zYwBQ
         sqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnSYZsmgMzEbq+f2jszfZPGO/GYBrKMzjlQ6YrWUQls=;
        b=k/FtLWDurGZ13K9Tzyb7sRDnpMI6c00G1dfl14RmxfBOhagPlgfYh+dYjPU2z0sAFT
         5id/+mve8CJ0vGrISSe2ShTvGy6KZemqe4yixFWXrxVoEqnE5HKXt8wg1QnV1Z6Stx4r
         z2w60nxndXu2p1Npe8ShW3ntZ59pG/cSveL7/obRb3XbEWvVje/El9V9DlhrFlG6lvHG
         c5lD+0SuD51ZqqTrxkE+GMpA8D059iopw2ffuIHp3fEn93mcUmcuDycoktthnZko6Ded
         94WMrp5pF3MXmmOXpIa2Ue2P0pkU82XlQqPw7D6oELkSJu2/Wm/DVUygNdYxcmQtViK+
         P+WQ==
X-Gm-Message-State: AOAM530rdue2WdkdW8q7TA/lhdqCW8JmfuBxqpKScJ3QYpqRfgW+QSTD
        hiw+j5z3IyeRkSHRYBxh39I=
X-Google-Smtp-Source: ABdhPJwLGPMqJnCDSNX0CjZNkeF5DJSnc8T/AlGT+gWpjPBXK9f0h+QGLvPTZowCWhVEyOe1V+tfoA==
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id c10-20020adfe74a000000b001f025cb3ad5mr11057941wrn.231.1648899467165;
        Sat, 02 Apr 2022 04:37:47 -0700 (PDT)
Received: from alaa-emad ([197.57.138.121])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm4368155wrq.44.2022.04.02.04.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 04:37:46 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH 1/2] staging: wlan-ng: Fix Lines shouldn't end with '('
Date:   Sat,  2 Apr 2022 13:37:32 +0200
Message-Id: <82bb0ca2bad1bafbaca8ded6fe82b94e4761f648.1648899123.git.eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648899123.git.eng.alaamohamedsoliman.am@gmail.com>
References: <cover.1648899123.git.eng.alaamohamedsoliman.am@gmail.com>
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

Fix "CHECK: Lines should not end with a '('"
for lines 331 and 485 Reported By checkpatch

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 7951bd63816f..69d616f19cff 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -328,8 +328,7 @@ static int prism2_scan(struct wiphy *wiphy,
 		(i < request->n_channels) && i < ARRAY_SIZE(prism2_channels);
 		i++)
 		msg1.channellist.data.data[i] =
-			ieee80211_frequency_to_channel(
-				request->channels[i]->center_freq);
+			ieee80211_frequency_to_channel(request->channels[i]->center_freq);
 	msg1.channellist.data.len = request->n_channels;
 
 	msg1.maxchanneltime.data = 250;
@@ -482,8 +481,7 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 				goto exit;
 
 			/* send key to driver */
-			did = didmib_dot11smt_wepdefaultkeystable_key(
-					sme->key_idx + 1);
+			did = didmib_dot11smt_wepdefaultkeystable_key(sme->key_idx + 1);
 			result = prism2_domibset_pstr32(wlandev,
 							did, sme->key_len,
 							(u8 *)sme->key);
-- 
2.35.1

