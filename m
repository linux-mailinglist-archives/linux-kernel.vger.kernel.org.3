Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA55A5E34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiH3IeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiH3IeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:34:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D66A4B32;
        Tue, 30 Aug 2022 01:33:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so6773635pjq.3;
        Tue, 30 Aug 2022 01:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=rYQ68S+N0aE/ZcJDffkO37mZxHGitpOMhslKbrZoeGg=;
        b=EsiLnjJOzgYCz4ExPTjVesCn6kQjwcLd/BNMbYEvVc8LGX9kjymYXfP9wFivo+BIgz
         web6oXuekBfuiSH9oxeNzNzH2XZ3uh2UQfW2l4IZCTUIJO1OZHseSkt2jWjtY2YEQKiM
         tI5NN7JyyGV0AJI1TC2OfpgG3SRW0UBsaXf5oFIo95JVVilxaKZd4XdcVVfd9ffPBPIW
         bcIGyqEIo86ErNkawq4MePBMvGS0McX4xvdWCw9tnq4XMKlFVmshRx2qNEnRyGdbTvCI
         kFFS7l3rElsle89p3rm3AikBgHzmRTUXgFwP/IxKggeNsFHboKpR9gD3VmywAEmRZwiV
         Sp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rYQ68S+N0aE/ZcJDffkO37mZxHGitpOMhslKbrZoeGg=;
        b=QmaFBwRIodrveBNb60U6YAYyFqe7IvTlIoF6BFZnhP3L7/JaAvdCdMncJy+gDxTFAU
         OIHqTkCbKf9ARIkcfhGy6eS5cX/X/KWaLgY81rzqqTFMQLVsx0F404iuMPBZn1FOD+aY
         M4XstXpI4+9l3E2mEZ620DAIzqaw/vd8FC0Bauvtj4lcs3AFt0Df9bMGGfd9bxZgW0bL
         QZqM/dsTRNz9gt1X7R5L+/AQg4bpwXHhaeXcsAPmHcVaHIhSd6cRn1pe2dhQ04Jp62ze
         C3DZ7UW4ODMHl91CzZypQMy+GXWh5ypU7nsfoMYb5/FlHZgd0Ihz4uNzlhxiKo/H02n6
         r+qQ==
X-Gm-Message-State: ACgBeo0U7ulRcz8KyNurImnjL0qMElmmV25WxGgZNCPSG0pgK4kYCPnd
        cPKTz4oNiLRArd+QvrPSyXIyON2qeTk=
X-Google-Smtp-Source: AA6agR7gt5g7PRd8/I8ogQ0EeWYi6CEsYDHvAR/qGN9DQBKpL6TSKypJxruvRWq5qFMhwrQpMxsswA==
X-Received: by 2002:a17:902:e8d1:b0:172:9bc0:bc9d with SMTP id v17-20020a170902e8d100b001729bc0bc9dmr20338295plg.20.1661848439476;
        Tue, 30 Aug 2022 01:33:59 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709027e0600b001743c51123esm4251217plm.72.2022.08.30.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:33:59 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] mmc: sdhci_am654: Remove the unneeded result variable
Date:   Tue, 30 Aug 2022 08:33:49 +0000
Message-Id: <20220830083349.276709-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value cqhci_init() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mmc/host/sdhci_am654.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index e7ced1496a07..8f1023480e12 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -554,7 +554,6 @@ static const struct cqhci_host_ops sdhci_am654_cqhci_ops = {
 static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
 {
 	struct cqhci_host *cq_host;
-	int ret;
 
 	cq_host = devm_kzalloc(mmc_dev(host->mmc), sizeof(struct cqhci_host),
 			       GFP_KERNEL);
@@ -568,9 +567,7 @@ static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
 
 	host->mmc->caps2 |= MMC_CAP2_CQE;
 
-	ret = cqhci_init(cq_host, host->mmc, 1);
-
-	return ret;
+	return cqhci_init(cq_host, host->mmc, 1);
 }
 
 static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
-- 
2.25.1
