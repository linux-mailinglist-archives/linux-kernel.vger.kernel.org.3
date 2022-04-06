Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE44F679D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbiDFRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiDFRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:40:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A0287A36
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:49:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w4so3830102wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJRePmaoHF8y9FcZ88YD095N9pjI+K9p1C7d1voMNQA=;
        b=UFnMBRRFAUq1tdwAQKRJaM+eU87Z4OIegSIOZnkvB4DjllOHIR5VnrGYdqcX+pR1ZK
         dp3gLQR390O9+4ea1Ze/CqHSjkSnroqWL1B+k4eAapO/p9o82Elcy0deHnBT+Xh53pYG
         4RZ0yRGwAhCiii5qMrpf1hy9zws2ct/H5Z8XIGx5C5DrH+9PTeA0lFG9ji8CQjbjKdBx
         vJDc6d9MsfKeyq8ZNUkrWgk54MEkKLMEnIG/2UI1q87zK8jKM7ilkAvAioRTqaNTMaG2
         Vvc2QDm94TLnmOfxnQGOn6m6LPY2qsKnLxAnrZD/kMHD530f0qwwR54v7HvBDePEQRVn
         xcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJRePmaoHF8y9FcZ88YD095N9pjI+K9p1C7d1voMNQA=;
        b=Pdr33KZL2ApC1vIG7npECw1lodMi51OIjzRGK7vqEUaTuOpuj5YHiB7ANoESKWtadc
         7c7vAS4BNP6wgmUqhnCj1t6e8j4oqexrF9QahkyCOgkoIXOwM9XExntTXN/XweNMEH2V
         WWZ4v/OcPakbda5O/36O5rIkHLiP6y/DLiS7H29MkBMkZ6h5HcLq5UzEErBQaU09ORok
         pQ0aaFfGjpUjXjR/aMvAqAqJ04IDzguAwC7sMyiQorAnGbpNy//bViRAUVY/+q7DWAh6
         0XkU2ZQZiwMjUrNdUDCs7owfWnkHNXW7DYXrIiGY473Erij97nf0NILdWU6FD2+4l4CK
         qxLg==
X-Gm-Message-State: AOAM533V2OMVPhv5q8gdvMEIeFKM6Afh5rd0ELtOsCjnftVbcnsbMHV3
        4lE/736O5T212BvIL2J6KuJg1SD4sl8=
X-Google-Smtp-Source: ABdhPJzQm9bjq8yLnVVnEajucrpLRFaujEv+Fn79oRJYooXadcAXYaqU3o9yLXxhp4haoMeNnzBtsg==
X-Received: by 2002:adf:ce06:0:b0:206:fd5:6644 with SMTP id p6-20020adfce06000000b002060fd56644mr7434505wrn.624.1649260165196;
        Wed, 06 Apr 2022 08:49:25 -0700 (PDT)
Received: from alaa-emad ([197.57.159.73])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0038b5162260csm7577725wmq.23.2022.04.06.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:49:24 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] staging: rtl8192e: remove multiple blank lines
Date:   Wed,  6 Apr 2022 17:49:21 +0200
Message-Id: <20220406154921.15532-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Reported by checkpatch:

CHECK: Please don't use multiple blank lines

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 97afea4c3511..b0b1c839e770 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -343,7 +343,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBARsp_Reject;
 	}
 
-
 	if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst,
 		   (u8)(pBaParamSet->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
@@ -355,7 +354,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	pPendingBA = &pTS->TxPendingBARecord;
 	pAdmittedBA = &pTS->TxAdmittedBARecord;
 
-
 	if (pAdmittedBA->b_valid) {
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
 			   __func__);
@@ -374,7 +372,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		DeActivateBAEntry(ieee, pPendingBA);
 	}
 
-
 	if (*pStatusCode == ADDBA_STATUS_SUCCESS) {
 		if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 			pTS->bAddBaReqDelayed = true;
-- 
2.35.1

