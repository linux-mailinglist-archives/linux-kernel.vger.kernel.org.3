Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9A44D0796
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbiCGTXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiCGTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:23:14 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883646579C;
        Mon,  7 Mar 2022 11:22:17 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z26so13784678lji.8;
        Mon, 07 Mar 2022 11:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCLp1U16xs02tluzmhE3Ivorry4CiooG9a0A5sM8k0Q=;
        b=dshBjD6Jy5UVNJiUV8rotuD0nugDrt6o8bam8sD0BfrOZ3KbE2n1Eb1dim1LEqmuZY
         RkjA0Xi1YuArAhka/6aqLJIP1UKkqANHF/ZFzz821Wd3B9xrd7dAobW2TthgrV/+bD3W
         POhUc/SgEBhBGaTJdEYbhsdw6NDHSrCoXF4r4q86JhTKvQ6NNSEKQdbHIac0YphtT3qI
         a4uH73iumCv1OA3hd/iVSOCYvfMjLPDApN4dAMAdwH0S4BqTfZ92L7LNT3W74jmkcz/V
         g2c1B6vpuCG39FgEpttbH6LjgEAlgritfdTIH+k/bk7e9PBmyXvP+gX9ao5JCHcbGcjf
         Qg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCLp1U16xs02tluzmhE3Ivorry4CiooG9a0A5sM8k0Q=;
        b=WPsjp1MZ1V1ceP9MgCsGz7z/n9z8hQT5firlB8LTZp1jVoFJFZ33OLYlAclNt8jxxG
         PFErIYh3NVC1O4fkPug8cscJr84R9k6+MlLP3HlaEq4AHsbC1yNCE4A63GWidAAJAR51
         4Bu4xnQcfI0+Sh10LyS0iyNpSqQM9vNobRbYy1JHGUd7KeIYeugGBfdyYRanjxthKWNi
         DmwVZmGMyMdgikEtx6OPPQinMxzjmYJyxsSWoyoIi2pZwoNoaJcRxxhvCE4dcvdMzkej
         TNMyfpPJ2+82lZCG0VcCYNEA9xXtRLzb+/zdJlKRmdT1NwE9s5h7kwvvwBiwI3gU+DZA
         yVLg==
X-Gm-Message-State: AOAM5306RAOPutwwLVi5nBRdcfsZCtyBY3ywHmzUG5PYvfgxJI+HZXgG
        0+EP3vn4YQJxKLiOBLrU9SlqD/x59idPVg==
X-Google-Smtp-Source: ABdhPJyBhgst0hVqdSgXerPO6zY4iMbKfUr5zwvj7uJlpEpF0w/iNswoXCId2i7Z2lYDLAMv4mlxfA==
X-Received: by 2002:a2e:8708:0:b0:246:12b7:e67d with SMTP id m8-20020a2e8708000000b0024612b7e67dmr8377010lji.24.1646680935032;
        Mon, 07 Mar 2022 11:22:15 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512096c00b004437e92a5e8sm2995671lft.105.2022.03.07.11.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:22:14 -0800 (PST)
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
Subject: [PATCH v2 4/4] firmware: qcom_scm: Add compatible for MSM8976 SoC
Date:   Mon,  7 Mar 2022 20:17:25 +0100
Message-Id: <20220307191726.10869-5-a39.skl@gmail.com>
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

Add compatible for SCM on MSM8976.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/firmware/qcom_scm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 491bbf70c94a2..3163660fa8e29 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1379,6 +1379,10 @@ static const struct of_device_id qcom_scm_dt_match[] = {
 							     SCM_HAS_IFACE_CLK |
 							     SCM_HAS_BUS_CLK)
 	},
+	{ .compatible = "qcom,scm-msm8976", .data = (void *)(SCM_HAS_CORE_CLK |
+							     SCM_HAS_IFACE_CLK |
+							     SCM_HAS_BUS_CLK)
+	},
 	{ .compatible = "qcom,scm-msm8994" },
 	{ .compatible = "qcom,scm-msm8996" },
 	{ .compatible = "qcom,scm" },
-- 
2.25.1

