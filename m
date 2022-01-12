Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8251448CC84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357490AbiALTwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:52:47 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33208 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350127AbiALTvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:51:39 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 14:51:16 EST
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BCFC2CDFE2;
        Wed, 12 Jan 2022 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016551; bh=uHZ8FRuZVwHxIA1x9cXwgwRQGE+bY7VbBrE0ut+WwBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gYSLf3FDfifqrL08W6o3GhwP6rzZSTWaGWmogO3iofldiRr2Zkshti029glhRFhnb
         B249aiGmPVASN1HLYNkDWNxv9QsaCwLJMgILDapO7RXS1yIJgyIK8CYlDwBTlHLWKp
         3jIWI4H5gdezmLM7ZDa8hstB9XawHS706+owrM+s=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] dt-bindings: pinctrl: qcom: msm8953: allow gpio-reserved-ranges
Date:   Wed, 12 Jan 2022 20:40:57 +0100
Message-Id: <20220112194118.178026-9-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the gpio-reserved-ranges property to be used in dts.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
index abe9f4c9b1e3..11a215bba64b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
@@ -34,6 +34,8 @@ properties:
 
   gpio-controller: true
 
+  gpio-reserved-ranges: true
+
   '#gpio-cells':
     description: Specifying the pin number and flags, as defined in
       include/dt-bindings/gpio/gpio.h
-- 
2.34.1

