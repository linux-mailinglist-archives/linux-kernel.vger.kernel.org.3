Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5C4986B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbiAXR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:26:52 -0500
Received: from fwd1.porkbun.com ([52.10.174.57]:36320 "EHLO fwd1.porkbun.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244540AbiAXR0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:26:50 -0500
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jan 2022 12:26:49 EST
Received: by fwd1.porkbun.com (Postfix, from userid 497)
        id 2A9FE40DD2; Mon, 24 Jan 2022 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1643044714;
        bh=7KAy/yzUxt6v9Wuvaa/H5Tq8t/cNtIks1cGsRx+fuuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fSviqsquNIVPf1SiK/i6JStBtTqinFlTZGRDqKXSaNuY4PumxK2TDKRhTH/7Rbfa5
         Ljsh4znb9NyVE8IKoCL7oW5r6rFniM+tOInjvdqFEpS+TZaycCvKXe35M86U+QZmm1
         VQhwHNcbyFxiuLtp254Pa4sQr020Zr7iJLqYiZ5M=
X-Spam-Checker-Version: SpamAssassin 3.4.3 (2019-12-06) on
        ip-172-31-37-14.us-west-2.compute.internal
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU autolearn=unavailable
        autolearn_force=no version=3.4.3
Received: from rayyan-pc.broadband (unknown [90.242.138.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: rayyan@ansari.sh)
        by fwd1.porkbun.com (Postfix) with ESMTPSA id 8D91741C16;
        Mon, 24 Jan 2022 17:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1643044567;
        bh=7KAy/yzUxt6v9Wuvaa/H5Tq8t/cNtIks1cGsRx+fuuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b3rAaxKgfPjVVwWRVXefKeHfgBAdEDOFn0XIS7+YGTQ2UVjECT+wY3VypCUL7f5eM
         4mm4Treu/Rbsyz7xjx95NTpS14pl/q+BBmIqZHwGkVCS+51KhugFvGKvOIHXnyMVvn
         pudzPN9Szqgd2WRKlRaOBme1zXUiYgJfdg7+0OZg=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pinctrl: qcom: spmi-mpp: Add PM8226 compatible
Date:   Mon, 24 Jan 2022 17:15:37 +0000
Message-Id: <20220124171538.18088-2-rayyan@ansari.sh>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124171538.18088-1-rayyan@ansari.sh>
References: <20220124171538.18088-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8226 provides 8 MPPs.
Add a compatible to support them.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index b80723928b7e..6937157f50b3 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -961,6 +961,7 @@ static int pmic_mpp_remove(struct platform_device *pdev)
 
 static const struct of_device_id pmic_mpp_of_match[] = {
 	{ .compatible = "qcom,pm8019-mpp", .data = (void *) 6 },
+	{ .compatible = "qcom,pm8226-mpp", .data = (void *) 8 },
 	{ .compatible = "qcom,pm8841-mpp", .data = (void *) 4 },
 	{ .compatible = "qcom,pm8916-mpp", .data = (void *) 4 },
 	{ .compatible = "qcom,pm8941-mpp", .data = (void *) 8 },
-- 
2.34.1

