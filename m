Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689214E3AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiCVIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiCVIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:45:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05F229CA8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:43:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso1933913pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZxrxvLmhhEpAfBV6uhz1YKPOjB2lLxvj2bDyOyEBloU=;
        b=fHN0nGy6JZwVZZACiD3BMloqyF9i7AL6wUEjck1epp3PbRIMOMyCca+surdzGsIkD9
         MdHLNrWhGdMj/uoPcxX7fqguuH/8GPjq0dmJmWQdCP858Hpk7PaxSV0VVVo9z+ffvte3
         KyjkZdh+DhvkPUz7BcnBHwFRIGClky5OG2UyjXNl5ot+rLa4MIBnyHl3ATnN6yTyT3kF
         GiOYAKu4w43PR3pbHR45BrL/J2zELloW08wlmmGCoQSdmsDWKt94aIM690W8IR9n+N71
         ka6grEBkP83YGu/qVybRHR7vIZqgq/++XQPrh68bTXJ9a5rVsN9YAQCR52o/32P0loAN
         PkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZxrxvLmhhEpAfBV6uhz1YKPOjB2lLxvj2bDyOyEBloU=;
        b=R+VyjjaErTzcu+m9AdOehC0M1N/z9Paqx+CpL+MDhRVgqW9csVqJD5R1+2Wz8xalB1
         da+zDkqDJiyJGDrgsI0Bqqu93kLj4ElVDi+4CC6VtBvXEaC/SDeLt836ubuPhR8Sbhzs
         AZwTlYIu34av++pIqv3scyBCGEdcQLP7kMulOvSnhtG6Sai9x5pmi5w7pkYek8JKodtY
         CL9B7dQprGBQiSQlnwPx/amdAMnWSjJ3nqDb3VGr71V0kNpmTzxxRPLaz+/REAXx4xM0
         0ju1Pj/Iahky7rRarX2Uh0KxhaYvi3PrC4b7N57+LmrNtivZFycOVwIHhAe7lGQgX/S8
         ImeQ==
X-Gm-Message-State: AOAM533yY/U7AhxhovVQj/gsVBKa6n+Ogj+iLISKjrIpZO586ss0gpma
        Gb6Zg91iYkIidB+oVSX64NM=
X-Google-Smtp-Source: ABdhPJwlpFZfcxZl1zBc7WLYS8WdYv68M00ubMwztbD/5H5eWT2/Ju1ejMIUUgnCP94/g2n4VT2cXw==
X-Received: by 2002:a17:902:cecb:b0:154:6f46:a5d6 with SMTP id d11-20020a170902cecb00b001546f46a5d6mr5994007plg.92.1647938639111;
        Tue, 22 Mar 2022 01:43:59 -0700 (PDT)
Received: from ubuntu-vm.jnpr.net ([116.197.184.10])
        by smtp.gmail.com with ESMTPSA id rj14-20020a17090b3e8e00b001bf50a8b468sm2091658pjb.51.2022.03.22.01.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 01:43:58 -0700 (PDT)
From:   Sathish Kumar <skumark1902@gmail.com>
To:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Sathish Kumar <skumark1902@gmail.com>
Subject: [PATCH] staging: vt6656: Fix multiple blank lines warning
Date:   Tue, 22 Mar 2022 14:13:34 +0530
Message-Id: <20220322084334.4077-1-skumark1902@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warnings like:
CHECK: Please don't use multiple blank lines
+
+

Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
---
 drivers/staging/vt6656/channel.c | 1 -
 drivers/staging/vt6656/rf.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/vt6656/channel.c b/drivers/staging/vt6656/channel.c
index aca003031995..413e2fc4a50d 100644
--- a/drivers/staging/vt6656/channel.c
+++ b/drivers/staging/vt6656/channel.c
@@ -55,7 +55,6 @@ static struct ieee80211_channel vnt_channels_2ghz[] = {
 	{ .center_freq = 2484, .hw_value = 14 }
 };
 
-
 static struct ieee80211_supported_band vnt_supported_2ghz_band = {
 	.channels = vnt_channels_2ghz,
 	.n_channels = ARRAY_SIZE(vnt_channels_2ghz),
diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index acbbf8acdf1b..464602c74727 100644
--- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -82,7 +82,6 @@ static u8 al2230_channel_table1[CB_MAX_CHANNEL_24G][3] = {
 	{0x06, 0x66, 0x61}
 };
 
-
 static u8 vt3226_init_table[CB_VT3226_INIT_SEQ][3] = {
 	{0x03, 0xff, 0x80},
 	{0x02, 0x82, 0xa1},
-- 
2.17.1

