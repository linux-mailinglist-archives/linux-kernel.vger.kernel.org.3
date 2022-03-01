Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497514C8328
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 06:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiCAF3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 00:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiCAF3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:29:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B119BF4A;
        Mon, 28 Feb 2022 21:28:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so1244744pja.1;
        Mon, 28 Feb 2022 21:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pn1tfjYkJNrV8BaC/6t9OQGuulP0oHKwpTwdoLFHZdc=;
        b=T+8WxOpx8tvW5hHEuXEHptjwyZrmqfl0+LqwHcdfFm77bH2r1yec/tKDb5sSNnrwD6
         uz0L9j/xu2O9kxlznO1xkE3t1QOCq8ks1vfAvHG2WAxypHXH+PcH+pmqTWc0vs6BwzDq
         t+fDogWSCHvQtfA4UMheWvBp/Cs/oL4kbf6K+GoBXbTv2InpVdHZTPNmzoquDcfQ0Il1
         G7EwSvqgguwV5tU7/V7YTotqSjpxJEaxWCQ6ncSaCi87UUSfQoK+sVGav/P6uALYkCFy
         U12zuhdzJQjxoMbW8i0qetolxAMMeosR6fMT8akZBJXZwWOJW61oYIQKakJF4azVfqV2
         pjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pn1tfjYkJNrV8BaC/6t9OQGuulP0oHKwpTwdoLFHZdc=;
        b=o6ppgZvVvSngKj7uUetYmXXm0wAeovbzwpAE/Wjc20BCvfyH1hS+jZsg88pvzqcMrL
         +M/Ig08eqLuSRZLpXL8pVYSuuWFBrf10paCLn7OvhjjhcWRxcwV/OAiKChvRIardxJ0/
         S7EtmOMMufdjPomsy+JDno5jCONCgwmCqpErt0DSYfGenHUE6+m2f9TCiW4u3meXhoai
         I6s/FOkpiBMKLNmsVGqc8j3wWVUp3eenaSJR7pn/7zmzYY5aqZopehEv2+wXrP6LWBHP
         ndn9Sbiihaum30e9DI4dmLs1XjWnpIdSkD/QIB6LKwHs+qtvYdiUhKRUoNtKznkxFKWi
         6p1w==
X-Gm-Message-State: AOAM531PfKwDMwm7l5P4sFJzQzKP4XF0Py5nJPSFxLGbvNE0eFY7wkPH
        PXBnjngFWdPuUIFICWp9zjg=
X-Google-Smtp-Source: ABdhPJzRZEMg6Bn+rUGn0eTgmRVgTUx/xyUhU97BynOPP99rufaNnQST21lLwoBvfwxlOv1h5oEbbA==
X-Received: by 2002:a17:90b:d86:b0:1bc:a78a:8b76 with SMTP id bg6-20020a17090b0d8600b001bca78a8b76mr20347885pjb.129.1646112538826;
        Mon, 28 Feb 2022 21:28:58 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9005:88cd:3423:e74e:cf1d:8494])
        by smtp.gmail.com with ESMTPSA id q8-20020a056a00088800b004bca31c8e56sm16417131pfj.115.2022.02.28.21.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 21:28:58 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] power: supply: ab8500: Remove unused variable
Date:   Tue,  1 Mar 2022 10:58:50 +0530
Message-Id: <20220301052850.5382-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot reported below warning ->
drivers/power/supply/ab8500_chargalg.c:790:13: warning:
variable 'delta_i_ua' set but not used [-Wunused-but-set-variable]

Remove unused variable delta_i_ua.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/power/supply/ab8500_chargalg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index b5a3096e78a1..f73d29c09caf 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -793,13 +793,10 @@ static void init_maxim_chg_curr(struct ab8500_chargalg *di)
  */
 static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 {
-	int delta_i_ua;
 
 	if (!di->bm->maxi->ena_maxi)
 		return MAXIM_RET_NOACTION;
 
-	delta_i_ua = di->ccm.original_iset_ua - di->batt_data.inst_curr_ua;
-
 	if (di->events.vbus_collapsed) {
 		dev_dbg(di->dev, "Charger voltage has collapsed %d\n",
 				di->ccm.wait_cnt);
-- 
2.25.1

