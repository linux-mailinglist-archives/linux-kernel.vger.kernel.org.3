Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348F551DE2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444118AbiEFRMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbiEFRM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:12:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46E6E8C3;
        Fri,  6 May 2022 10:08:45 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h85so8701787iof.12;
        Fri, 06 May 2022 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BYupm1fE8e479PQqvbP6JfaW9IoyOSVpmHjXNCz1xM=;
        b=pp30FWcsN5AUYue2OlS9dAfNypwm9/c4JCNGtYcC985Y3JDbuEw6AqGT55wvMSW0tl
         tjCMmi3x4G9EzyyC39/M+h/kshkYvUkU7TOUVrIpzPT/VMLaIHREUETsXmVlm8Dt7ZDt
         pStMHlJGJ0xNdLMpEFS9VBESzIXXCj/Zu/fLmJ1LmmKi9eeAlIUYb2yQ84HjJ4/0MSMM
         0iaRV7LP1jHyhlDWMRHTbZ6sxw7mtiMFGDDe/cmNF/IoV2gvoQJzJBliowI6LZ1H7fg1
         F6Aq4YW4vogmi+D6swLjeeK2/6sNhjJMApyVeZ//Y2xAvfe7u2YfvfJ8d+Azm1YPBlEr
         166A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BYupm1fE8e479PQqvbP6JfaW9IoyOSVpmHjXNCz1xM=;
        b=Y3cPDrt0m5I6Y/r8kI0DtAzaHuZr6OmaY9Ln7mwq+YsKhpkIqiUqU8KF4Y3UF2DrEo
         DBGWvUZeRDCRKGRWOsKAMC+bsGN7mUkQwqZmFhWamKD9Kl0piQO1I/m9lPpKoSxLo2Mc
         401EnYB/Tplp+qhBBuVE+1Eps6qLpsqUst3jTTGDICEFu4hISVBQtxMz8B/BaaRALrcq
         3xqZfx7xmiYGYcnYjOPxgEDafOrAxlzAvKOsqhqfcr7g1Pvwlt2gpoNPJ6RHmCzeZak9
         W/wGAqYrOnQGBlnKNKDq1IINESqDehnu5OaY0vIVyYjgVwLevw2aZho1o7XJ6Z3PY0Q2
         MVbQ==
X-Gm-Message-State: AOAM531C7HLVnJ/SGVB+XswkwBXsBpKlejYbtt5daVltloVDNxTCPsDy
        LeIJHPA3yL9+BF2WaMKSeag=
X-Google-Smtp-Source: ABdhPJzbRin7aDk57ndx8K89asLVIoY1tL51ODzHletDEr8ARiTjshYJhUUnkcxaHFd+vUshjECRMw==
X-Received: by 2002:a02:950c:0:b0:323:918d:a98f with SMTP id y12-20020a02950c000000b00323918da98fmr1825018jah.190.1651856924671;
        Fri, 06 May 2022 10:08:44 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id w12-20020a92ad0c000000b002cdfeead6basm1285075ilh.63.2022.05.06.10.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 10:08:44 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH] cpufreq: fix typo when cpufreq device remove
Date:   Sat,  7 May 2022 01:08:32 +0800
Message-Id: <20220506170832.33386-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

This should check cpufreq_driver->exit pointer before call this function

Fixes: 91a12e91dc39 ("cpufreq: Allow light-weight tear down and bring up of
CPUs")

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 43dfaa8124e2..0f59c8ec2b39 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1661,7 +1661,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 
 	if (cpumask_empty(policy->real_cpus)) {
 		/* We did light-weight exit earlier, do full tear down now */
-		if (cpufreq_driver->offline)
+		if (cpufreq_driver->exit)
 			cpufreq_driver->exit(policy);
 
 		cpufreq_policy_free(policy);
-- 
2.24.3 (Apple Git-128)

