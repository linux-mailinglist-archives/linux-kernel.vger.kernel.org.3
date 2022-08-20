Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E959AF95
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiHTSf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiHTSfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:35:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350FC40BF8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:35:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c39so9195510edf.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dWDV/5GVcx0ceVlPM2V+MXtiSomLloUDOadV6lqtfMg=;
        b=Sqt5nM8T3ZhD/gnJBrPe+fdvP1i1mkPlYQXEHybMD5R8Eh2nV2doa7vNXQnJ6KshHQ
         obbF/0DEpgkjRCRYF7G5ZQofZevepGuq7WegSnMSW3uSKR1yPFdGshWDyDoPFOAC9rBj
         j0u85vOKAydrnB9BbnWrXznRPg4bAtE2mcYqVma0W/mFbJMBI5szvUAzmbYDwP6RO5iP
         ouxHXHAhnKpnMcQLv+kHVZ2OA7fonEo22qoa5rr3rBjTrZHI9m8prnSNFE8mg/KP+I06
         cxtR6Wt7w46ENNfoQuXOEg+TbFAQSsr7eH9O4olo6/wFT4KSljEkKXusQq4Fy67X966c
         FCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dWDV/5GVcx0ceVlPM2V+MXtiSomLloUDOadV6lqtfMg=;
        b=c2rIlin3+YyWlXZKdXSqjeOjfU8cNvB5WMR+1OIa3dvk5TcUJ45BTLYs9DEl2dAfDn
         HTv41IIUl3+kbp6VnCBMkEV/eEcf6qtKOwVRgGWgqt4j+zhwFvd3CwlWGngsi/2J2R9D
         bYyb5vyLeyu6YXzqM9dRcySTszpQvWUW4cwmF413i8vosvtb7lXQtn3tPvXaPklX7d2m
         g98SZPV81IbdFVTy8TLhNfUl9VNyO5RlJgo5JP5Zhp1IGeeG1RgO6fW0A6ZnsbuBZr7b
         9iayERWHVFUxR8o5UvalOevuEuTu7sXWTP1iykFhpZ6pzIP4MCOyR7gqfHeBzAs9Z+1j
         CNBw==
X-Gm-Message-State: ACgBeo1XNCXYigNs9KRX3ZNM1DCOWGIkVBfhoLfqpOVo1xZePSTZyDDO
        PXM3tQ9MUkWZNbe6qhaiJGQ=
X-Google-Smtp-Source: AA6agR47WOrQDsBhU8K5UXP1PNxj8rbM4aHK6RvkmgDiioTQ+++5nLKZHBUp/F4brRX0Je79apJo5A==
X-Received: by 2002:a05:6402:26c2:b0:43d:d885:451a with SMTP id x2-20020a05640226c200b0043dd885451amr10224693edd.287.1661020549697;
        Sat, 20 Aug 2022 11:35:49 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.88.220])
        by smtp.gmail.com with ESMTPSA id b15-20020a1709063f8f00b007336c3f05bdsm3956796ejj.178.2022.08.20.11.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:35:49 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     namcaov@gmail.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        lkp@intel.com
Subject: [PATCH v3 2/3] staging: rtl8723bs: remove member noise_level from struct dm_odm_t
Date:   Sat, 20 Aug 2022 20:34:50 +0200
Message-Id: <5a8256d3823baaa72775da80d821749dfbda7ad4.1661020250.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <46d73e331bae2192a328f6691763f39ea6c18b08.1661020250.git.namcaov@gmail.com>
References: <cover.1661017377.git.namcaov@gmail.com>
 <46d73e331bae2192a328f6691763f39ea6c18b08.1661020250.git.namcaov@gmail.com>
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

because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 19cfc2915458..033f22b0f394 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -863,7 +863,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	u8 Adaptivity_IGI_upper;
 	u8 NHM_cnt_0;
 
-	struct odm_noise_monitor noise_level;/* ODM_MAX_CHANNEL_NUM]; */
 	/*  */
 	/* 2 Define STA info. */
 	/*  _ODM_STA_INFO */
-- 
2.25.1

