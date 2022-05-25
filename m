Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230E1533F78
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244882AbiEYOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbiEYOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:44:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D8A88A8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so42159543ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dz8k/q3qNgJQm6RsF9qqwy1eYL+8jWltLYwZ1PVLuPA=;
        b=2asdXCydJTTYXHRkflm7Dec8iSPX+B9DWvAl1Jp5IfjsUQGS9dq+Rz+e90eS8F8UEm
         zrqgZyKqjsSUsUy2e8sn5ZU3/FJ+aQ8FoUzEtv2rL4tbWZLijZKbjr938x9ntIW0t4tS
         8OwcThbBUHYVE6m7oTxn6SuhoHgcRN17rIsK+ImMmY49VWO8JYs1zReObvpZjkYCMHp8
         qd+7XOnYEuIDSxKdGX3nxrPhZhW0hhutCgF8UJ5NBYnyrZSQKFWpcxXe4cZID032SY46
         hfAXZGYXp7LBUaWBOCZagTxuMinNcDAHY2EZxCaLTMIRrW31ZsV1EbNIWHy2/Z7AtyLR
         4OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dz8k/q3qNgJQm6RsF9qqwy1eYL+8jWltLYwZ1PVLuPA=;
        b=GrQ0DxtUkuvtyK0DpymrRlDeocTvGr9HmKTBrPbiQpXFyy73KC9Pv4FdfjvmOTwxbZ
         32UCsiRa8HuEhpoEYVr3yJGkbvTKyWcVoiqBD1Amw0f0qWIp+O9+SH5clypMYJTRcXYY
         Dz5MjVfRAvIxDTQdL6RW4q3InlvPypG0F7BIetOBB4MYuZuly2W283zCO1ppXLQR4vND
         /GNUpbRRv/7WYoIHEy2gEz43wNkqP3YhZS/wAzRsZcQun9kOhBTdT+7Tu6keWOtMei3P
         vIvBacivCRiQBvPvo21isB89d7x5aUm2mjYOb6Os9vJPQyowTrS78LKhHPVvD84EGEmg
         l6Mw==
X-Gm-Message-State: AOAM533gRaqtf92NFkIFxBVRCQmBjNIBbd8g6Ruav9iX5enmCsKZdGwD
        Z2RN/QcVUjkUzrfOXriEMlQwjg==
X-Google-Smtp-Source: ABdhPJxXuw597rAjYdlyHdKAkCnXwKqqdUPr07GkAY1bX5egmlMy5CDRSuaybdbo6B99HMWEFLuslQ==
X-Received: by 2002:a17:907:7f16:b0:6fe:dcc0:3b23 with SMTP id qf22-20020a1709077f1600b006fedcc03b23mr14793607ejc.478.1653489873200;
        Wed, 25 May 2022 07:44:33 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906550200b006f3ef214de1sm8159596ejp.71.2022.05.25.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:44:32 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] interconnect: qcom: icc-rpmh: Support child NoC device probe
Date:   Wed, 25 May 2022 16:43:57 +0200
Message-Id: <20220525144404.200390-2-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525144404.200390-1-luca.weiss@fairphone.com>
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per e39bf2972c6e ("interconnect: icc-rpm: Support child NoC device
probe") also update the rpmh interconnect driver to support probing NoCs
that are modelled as child devices of a different NoC.

As the driver doesn't yet use the 'reg' property, no change is done for
that.

Downstream DT reference:
https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tags/android-11.0.0_r0.56/qcom/lagoon-bus.dtsi

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes since v2:
* none

 drivers/interconnect/qcom/icc-rpmh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3c40076eb5fb..8acc8e67a332 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -258,6 +258,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	data->num_nodes = num_nodes;
 	platform_set_drvdata(pdev, qp);
 
+	/* Populate child NoC devices if any */
+	if (of_get_child_count(dev->of_node) > 0)
+		return of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	return 0;
 err:
 	icc_nodes_remove(provider);
-- 
2.36.1

