Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB215B2635
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiIHSut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIHSur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:50:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A0EB869;
        Thu,  8 Sep 2022 11:50:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u22so18756256plq.12;
        Thu, 08 Sep 2022 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ww0ekzasU09lAMoy3JxdtzROyoI253SLR5Bo2xJU5E4=;
        b=Q/Hke5nLpcs16jf8LBaIP5ShEjGQG9BHfLUjXuJd5HcsGXg6z6us464wketBEM4xkR
         iaaNMtmt98aRN/0s9z+KFmOpVyi1KfBEPZO3ZT+MF6ZH1G64onlvIDdsBtY0z/elfGwG
         qF4Bj6GUcIFfIPRQUzB1WkuBoW6ImugyvviKE8XDHxDBzfieF9mXzhgxcJNC/vzj+ZCx
         gbJTrgW4ad0Okle32qOOgx73QTiGOhc3dk9W+G/09ryAPxb1gOsJRihmRXPolqVVuJrk
         rCCWKIRbGuJJ/olcahLlhSD1k4Xziu5AwEvgrkyABUt/HBsxONCqAQh4WCX5vC7V/9U7
         7LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ww0ekzasU09lAMoy3JxdtzROyoI253SLR5Bo2xJU5E4=;
        b=ZjWvBgU4xOATw18FesHPaaBp/XzxwELdKUqIeaATdmmv3dQmfJFgH4YmNGNs+e0wDp
         FLbh0Run4znpjVfQu8q3yaTOEDdesQchbdc3zbwF2BrsWaARanUZ7lSc3vIsGE+qnE3v
         F3EiAh+LcJx4hyiH5yW08VosyCDKoZv3l4lRttpCMQ2HPC+cuw7grHuOI1zIuUzGUI/7
         STx4CZAwYCTmIF8cFdbqw8YOviEynRUsQGO93BhxJX36e71t8WNhkvYoUAfms9VWIvgY
         6U3HX85szu3VUj5i5R+Mnm6UKQpJy4GERx6MBCp+MltAXmMXlj3TXfIw+vPvS62WLKyr
         rkAQ==
X-Gm-Message-State: ACgBeo2XDqrtOgD1Aaxe823M/QDGVFJPGPvNnRlZfeDJ8ThDo3wzI3FU
        4SJofYP03ZRVlsKHZqdZj0VhQ6QockjUWngi
X-Google-Smtp-Source: AA6agR5UykrVNqh8zF4Y2mL1HJTj7x8gybd8YczcF0tSht5WOzX5kjlbqgLFlP0jSJJgrT4yM52Gow==
X-Received: by 2002:a17:903:54a:b0:174:ec04:53ea with SMTP id jo10-20020a170903054a00b00174ec0453eamr10012332plb.3.1662663045545;
        Thu, 08 Sep 2022 11:50:45 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:ce83:3779:42da:b5f7:bc9e])
        by smtp.googlemail.com with ESMTPSA id 21-20020a170902c11500b001714c36a6e7sm8746030pli.284.2022.09.08.11.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:50:44 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     bjorn.andersson@linaro.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] remoteproc: qcom: qcom_wcnss: Add support for pronto-v3
Date:   Fri,  9 Sep 2022 00:19:22 +0530
Message-Id: <20220908184925.2714098-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Pronto-v3 is similar to pronto-v2. It requires two power domains, and it
requires the xo clock. It is used on the MSM8953 platform.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/remoteproc/qcom_wcnss.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 68f37296b151..ff18bfae5eb6 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -141,6 +141,18 @@ static const struct wcnss_data pronto_v2_data = {
 	.num_vregs = 1,
 };
 
+static const struct wcnss_data pronto_v3_data = {
+	.pmu_offset = 0x1004,
+	.spare_offset = 0x1088,
+
+	.pd_names = { "mx", "cx" },
+	.vregs = (struct wcnss_vreg_info[]) {
+		{ "vddpx", 1800000, 1800000, 0 },
+	},
+	.num_pd_vregs = 2,
+	.num_vregs = 1,
+};
+
 static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
@@ -675,6 +687,7 @@ static const struct of_device_id wcnss_of_match[] = {
 	{ .compatible = "qcom,riva-pil", &riva_data },
 	{ .compatible = "qcom,pronto-v1-pil", &pronto_v1_data },
 	{ .compatible = "qcom,pronto-v2-pil", &pronto_v2_data },
+	{ .compatible = "qcom,pronto-v3-pil", &pronto_v3_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, wcnss_of_match);
-- 
2.37.2

