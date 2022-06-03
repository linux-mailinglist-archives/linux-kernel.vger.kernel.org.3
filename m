Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECD353C7FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbiFCJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243256AbiFCJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:58:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918703AA54
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:58:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g205so6811903pfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrCml1duSQKT76fhZwLXggx5KAYOqWoNEE0qkOtf7+E=;
        b=MZE4dh/lBJt7zw7yklW/K35pqVs/44OEcXP5tDSibXFSJOAgU8uqMOjUMUWoVQVN3N
         5ymcrm4pzmreDqhNWYtz4rv7TrSX31nQbRAkLa98+JaDmf2Xcx7gtsAPQCDJBVYSv6oe
         iraPaxINTKPW8TA7/ER1Z+LbdFL+a9WkPhwzdywOLS+qls8OazKFNlIqotXf4ctIgbQD
         fqp1K0yC3SHKZGjNwdCsynfq02s7wl8MmHHDa2dTWhZPtgJ7xphNsIaoRy7sUarjGqiZ
         A3QVaYQ95T84oan3Basx6QdzaV/ydsA98HotCVyGNaiGRWAt/ZYI28sZqevz6GaShCf8
         WCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrCml1duSQKT76fhZwLXggx5KAYOqWoNEE0qkOtf7+E=;
        b=x/Yqpnj5viwiWpkMAQQHqW0UVABZ+w5yrKRdwH4FF0w1gb5Zm7IOIYaeslQXa/dJGN
         N4PRBmLUNOTyDx9I8xXYLvZ0be52U6c1TP/ImG7HLvsmjII0JGoDKLIe0kKpZuCg3i1B
         rf0bf2FF1dE4aqbiRUPyxN3YBR1jw47RKg0Cl3mUTbOFpbQ57YUlahEw/lnx3uCWhuRG
         Z8A8lhnuRXYyVrX/qnxdaBq6xhJ0AmXW0U8E3sC8Y6nUHdeSj/DCYmZxt5KjhU03mc/L
         u1zBW9bH90wcvvGvM3dSLatxMmB+zBbNRnn4/kVVZQ8pa5w4d4GvbXjJDSd4VAt0+q5q
         x6IQ==
X-Gm-Message-State: AOAM532zx20fOZbET0Z8zPhXjWW01Xqk4MALKzmlpF2A4tSgiJIfDgBV
        oK31xAVhTYaY/caI9Oej8apoMA==
X-Google-Smtp-Source: ABdhPJwkGV0eiWfSz484WwhT0gvTsXt2bgsBC8F6g4Vcr37r6orQFC/zmruojIh6hZ9/6NO8MJnJng==
X-Received: by 2002:a05:6a00:e0e:b0:50a:cb86:883c with SMTP id bq14-20020a056a000e0e00b0050acb86883cmr9648422pfb.11.1654250321086;
        Fri, 03 Jun 2022 02:58:41 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id c9-20020a631c49000000b003fc600628a7sm4842186pgm.31.2022.06.03.02.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:58:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Fix typo in comment
Date:   Fri,  3 Jun 2022 15:28:37 +0530
Message-Id: <9bf59d1cbdb62effdff0b742f6bed3e8f3e223bf.1654250311.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace rate with state.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index efacd64fb198..38a295521ff7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -854,7 +854,7 @@ static int _set_required_opp(struct device *dev, struct device *pd_dev,
 
 	ret = dev_pm_genpd_set_performance_state(pd_dev, pstate);
 	if (ret) {
-		dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
+		dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
 			dev_name(pd_dev), pstate, ret);
 	}
 
-- 
2.31.1.272.g89b43f80a514

