Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75854E27A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbiCUNft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347910AbiCUNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:35:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83DE3C4AC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:33:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z92so16905668ede.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DsNby0a3KqzAfOnj6mSyZetKsm2cbFk7h9HIg7MUGdQ=;
        b=mVyqs6hGGEUzEFy32H/xYVc8XbIFlcX8m1ZC85sLopiDTeC1gHZcaYWZ1t9zaF9xhJ
         EYsabs6hRni0eEKMdAghJhsH5U/tcQt0EiS5EP4KZ3mRazXyLtVGD12H72iJ7mYDRQbN
         ORKFueJmChRJ5gjIlmvlPOvD4pVJq+PanCARu1rT8lQ00x+5dK3bfhHgP/vkmiURe5HT
         DOA0f9njkv3mDnFZUcDzZFW7Wl0UMIduQZmfJkKsip8jeIdDg5sq2WRbbvITTvKO+bIq
         AFN60dplhhuEVHC7vWPgmddrusV9fLlJEVQJETly7aK5vwYDy8tuXeSV18QY1Fc6qrrT
         VTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DsNby0a3KqzAfOnj6mSyZetKsm2cbFk7h9HIg7MUGdQ=;
        b=jK+pvjKxm/BnFmkaRfc+B44MN68/ZhundQ53ptQUHfAkNMq49wU5dS5M2ZOdlsEHPd
         DXT+yCog7s+1NTsbPpt6pIJkV16YJ36aLPlQEBOq9aFVB84CXutohlxgUbWit4tLUHK/
         G3tcWERzukYwAyeACtPyiudscESjGLcIPROQDPsKFGtAL57zEk8tMYjmZB331WRXA3zp
         aaNZiosY35pWlHJYddnIjU7YZsUGLIk9jaVbeVHVc9szRO/Su/FmjFityRKjkZ4m0Lw0
         TsNsReSTGEE8I35jR/4ywpYOYmqFRUQgn0HMdFDWis+d3ELHe/z5hcBC0xIwsEuWLNHC
         zX9Q==
X-Gm-Message-State: AOAM533tgKz8NaZcxwR4Co737eS3YFWL8MHl8hMIu4IIIaiFQi387sYf
        xY4vMOVBh03mFtAnaQP7R9jaDQ==
X-Google-Smtp-Source: ABdhPJwbmbOxiUJERj4MHNXeag+kdgbSCHJBfY82vjDCL38uvezqoHUBcVMRYz+Bz08iOVCcqVzlsg==
X-Received: by 2002:a05:6402:51c7:b0:419:2bd7:efa4 with SMTP id r7-20020a05640251c700b004192bd7efa4mr8919920edd.135.1647869632531;
        Mon, 21 Mar 2022 06:33:52 -0700 (PDT)
Received: from otso.arnhem.chello.nl (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm6862154ejd.133.2022.03.21.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:33:52 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] phy: qcom-qmp: Add SM6350 UFS PHY support
Date:   Mon, 21 Mar 2022 14:33:15 +0100
Message-Id: <20220321133318.99406-4-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321133318.99406-1-luca.weiss@fairphone.com>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
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

The SM6350 UFS PHY is compatible with the one from SDM845. Add a
compatible for that.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- nothing

 drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index b144ae1f729a..1628275265b5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -6007,6 +6007,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm6115-qmp-ufs-phy",
 		.data = &sm6115_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm6350-qmp-ufs-phy",
+		.data = &sdm845_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sm8150-qmp-ufs-phy",
 		.data = &sm8150_ufsphy_cfg,
-- 
2.35.1

