Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444884D0790
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbiCGTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245059AbiCGTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:23:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA942EFB;
        Mon,  7 Mar 2022 11:22:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w12so3702890lfr.9;
        Mon, 07 Mar 2022 11:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqtlQ1txcyLHqqfToUdyxq900GbKQ2mtT1D3YZ+YgT0=;
        b=M/nIIs32xoFhrYMfpNAyq7Q+97yyf3DJzN2EqppFvGoAaDqCF3xo0zEC94SiQdPOZM
         Nrxb81byCQVd2tZBSSYICZXQMBxa7VuQ1tKEs7aUKifBMLdtkeN2FTaUvtPBCUMyIhnO
         tzTRJBC+XooD5C+Hdif2flfudi4ZbbJUSkbEWlCuIYKpDDoIS8utmIQk55HkXmUcYHxT
         uu83G9+f0Sxk7HAnJqGoSo7dwRP8MEw0rKtcUsPX9C9BxPPujtGhtRERv7YDdWVo+gGA
         us7VEZ5ywguRcr3FnkQj+9KxMmYLS/Jlgk7PHnKYFIdg48H+PxvcVE4uZg7VAyRTBMeA
         C3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqtlQ1txcyLHqqfToUdyxq900GbKQ2mtT1D3YZ+YgT0=;
        b=Mjt6py7vp98KB77dV57umh8z67Sf3hTW4j+FFRGK1LcEO4Z8Vk60MQH6P7bQb1vAQ9
         fbJpYSBskQl+cT7iKOjySxia5l4NKEm1Yr3P+qtUtxV0P2DELkC3RaZw4pI+nMqrXpDQ
         lEXGUbMY0SjKF4fHrbJRkEdLeibbLSBqkpGwLKHwW6eoK4PZtPCgvCBShm55MUudxCrq
         1VHeKabKqO7yrEt4QLx6SRiG3Hu0z1jN6jfIYeSGTHX68H+atz+qTcB4+t1wsAXYtiUI
         kORiGbn4aE38qN821OqVyZf6iHQhiel/rcmcsDyCP1X8PFjNuRr/vqVh9cQDCuJ0dNDM
         SRcw==
X-Gm-Message-State: AOAM533covxFOBqsmzbQ1e3uBs3vNR4uPY1ulehvgDju3rILUF8OfTfM
        yohM+YXBN4KBpgzA/1t2wy+mNAvv3MXowg==
X-Google-Smtp-Source: ABdhPJzq2xiWvaEmc9oSHBEjwA7pJvnmY4GaAjuEi6AWVxYsDkeRU5QdGKDFioebOXvEOLpSIvmZwQ==
X-Received: by 2002:ac2:4825:0:b0:443:b112:e513 with SMTP id 5-20020ac24825000000b00443b112e513mr8477446lft.114.1646680931482;
        Mon, 07 Mar 2022 11:22:11 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512096c00b004437e92a5e8sm2995671lft.105.2022.03.07.11.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:22:11 -0800 (PST)
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
Subject: [PATCH v2 2/4] mailbox: qcom-apcs-ipc: Add compatible for MSM8976 SoC
Date:   Mon,  7 Mar 2022 20:17:23 +0100
Message-Id: <20220307191726.10869-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307191726.10869-1-a39.skl@gmail.com>
References: <20220307191726.10869-1-a39.skl@gmail.com>
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

