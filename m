Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CCB48CC64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbiALTvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:51:51 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33198 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346281AbiALTvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:51:13 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id EE4FBCDFCB;
        Wed, 12 Jan 2022 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016547; bh=CzTuWXLWKC94/YOkWJAWG8rJcc5rVjNqI/L0NWRssZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XkR7gmZN1CbfA0c7J/NZ6XymzC+7mrKWDyWfAP1KGQubOVA9OanpIA0Ru8QWB6mgL
         IrH+5dnDp/WOZLaBdYTlspKscNoA3hHTdrgyR4Ojb4b/Y/YlCXERePgIuvZA+w+mML
         Yb8jZplqJ0nsMYjFMLgwCro7vghIc6mPhjnxjCZE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] mfd: qcom-spmi-pmic: Add pm8953 compatible
Date:   Wed, 12 Jan 2022 20:40:53 +0100
Message-Id: <20220112194118.178026-5-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for pm8953 as found in msm8953.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
index 7a27c500ff63..a461ec2f758f 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
@@ -35,6 +35,7 @@ Required properties:
                    "qcom,pm8916",
                    "qcom,pm8941",
                    "qcom,pm8950",
+                   "qcom,pm8953",
                    "qcom,pm8994",
                    "qcom,pm8998",
                    "qcom,pma8084",
-- 
2.34.1

