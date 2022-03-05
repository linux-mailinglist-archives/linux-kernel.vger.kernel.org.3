Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195DA4CE609
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiCEQxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiCEQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:53:01 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F43B29C;
        Sat,  5 Mar 2022 08:52:10 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id l12so14833715ljh.12;
        Sat, 05 Mar 2022 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rb1jkGqn3lqkO3YdEDUTTI8tdGFfrGu1bTvf//nCloM=;
        b=bS1cx8Fusb3z1ZkXUixhTvZpBIQyFSPIBzg901//38HXYJec8yqJPG2DKfgmWn6vMt
         JstfwOj53ftcHwrRYN5nzzj9Wl7w9jF+uwOKHY34b41TgSaurnVUdf8K72jZCHVO6By9
         oXeRRJ+cRztoVNx9MJstnkGdkREiBoK/0RShlAg4P6w5f9mu1CuA1R6sv44ItCoJ8qj7
         ClCY7fQGBj7AgW8bOOuK22zayrqZiVDVu5svQYHhK02SNM/VocLX2QOXoDs4GANGAdGU
         ieAkHMtKZC8uZLTh4wKSWsn7tw8NTDjbZJ7njNAH3EZrlRJjF738QRobmmLUHNVaWr92
         pvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rb1jkGqn3lqkO3YdEDUTTI8tdGFfrGu1bTvf//nCloM=;
        b=IDbLooDAO6JvkUWJbw3wBkBzOxs/7ZZAH0WFtiMUTCXYtEQy6oSFlns0TFrszpPNnt
         RGWKI2ZlfUvL9UJWURAlSafdCkhS9PSyP6xapK8Upk8PQ+fblJORpuAPKtKoWWXi57sT
         py1GPOzoV7WQ8aNjTGplk+tftmqsyMGK951+FGi5Xtv6R8UDI3Vv+SkySF5Avh5WM+ig
         ZO6hJ7gSdiHkjZfy66gaafZElo+JxuexbB+nvHb/0O4uRcWk0ABfKJJNJdoDTBbu5Mqb
         XgGszMAln5CRMhzGYtVgGT/SWRvZoKb33eCN/Xdihiwe4+AuT72G2kY948lZyzHl8SO9
         2xDg==
X-Gm-Message-State: AOAM532o1gr+Lbp0zBShKjKg9atHdoB02QYemXXfOxN36O6tvsom8NVJ
        FNM+igj0goQowZrU39faRtvjDXdGZ7PfwQC0
X-Google-Smtp-Source: ABdhPJzkHQYPa1CdDUOmt4XerTbVNJQxUGyUGE/Z3kiOmFEwpelLmdWtPRVZR7fGB9waCYiLwQ2eqQ==
X-Received: by 2002:a05:651c:2102:b0:244:c93d:178b with SMTP id a2-20020a05651c210200b00244c93d178bmr2500806ljq.123.1646499126188;
        Sat, 05 Mar 2022 08:52:06 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b00443c3f383c5sm1751287lfu.231.2022.03.05.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:52:05 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mailbox: qcom-apcs-ipc: Add compatible for MSM8976 SoC
Date:   Sat,  5 Mar 2022 17:49:03 +0100
Message-Id: <20220305164906.16853-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305164906.16853-1-a39.skl@gmail.com>
References: <20220305164906.16853-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

MSM8976 APCS block is similar to one found in MSM8994.
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 9325d2abc745b..80a54d81412e3 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -146,6 +146,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
+	{ .compatible = "qcom,msm8976-apcs-kpss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,msm8994-apcs-kpss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = &msm8996_apcs_data },
 	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = &msm8994_apcs_data },
-- 
2.25.1

