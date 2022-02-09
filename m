Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC64AE95F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiBIFfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:35:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiBIFaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:30:06 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12413C03C180;
        Tue,  8 Feb 2022 21:30:10 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id o5so1009675qvm.3;
        Tue, 08 Feb 2022 21:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BaM2nun77Ox90ylhwBob4weqZHSsb78qbeuJ150+3wM=;
        b=oW0NyvBN2TbhYrgNRdS2CWDkzWBELZWKx9Mw9NFWZGaqSHOA5FoFfs2knAaMqk+Lsx
         rWxIjv9Iyqwq9jlvTY5/NQDha/Z1Su0Ia0QI5Osmsc5KCy/off+8Bx1faPgqljKPmZTD
         Qw5doEehfyG9dYn1coZm9+VkgxjR8UFz1wUNTobVI6rz67FL/WZ02T4OjfLt8Fv3x3+M
         h1XOEsxpo8V/i3WXYL3jWcMkicgJvrUWtbLB5PeNEdgKFPIvcOEO8LNR6O43/0psDnU7
         xBn01RXAkkE1fRIeigAaFaoOgFf+r13IkC2zN/w1y0oF9K8hfQCkGl/Jgd2pGYEU8PMD
         Qj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BaM2nun77Ox90ylhwBob4weqZHSsb78qbeuJ150+3wM=;
        b=w0cArU7MPtrqg6GiJYt8Z5a4aF69CmvMWq/K8olYHMvF2zxC1gXDAvQ4WiAzRRo2pX
         fRMgYDOdQMEEPPqyavuIhN2OZ435lLTPPg4vJOyXD28dOE1cBVJl2PsqB4aGSlFRvtwh
         KbHR4VnjKlM/s+07pIotxiDjSQA0j5wb3yDfxaoe6pii+qGjX5v/DLELhr10dg6a3cXS
         dwCGJfe/dC8Kmf3Hp51nTVoJBoJ1PLSwao0x+EfY21v/5V8VmuCsIIrGX+QSQIVgQOUH
         JIm2Gn1IfhmK8dtzJD3jhhCTbrTYn6/fKPjY3Ln8dEChmFUaTtEwb1n5a0TBZ74p4wdw
         23kg==
X-Gm-Message-State: AOAM532/Xr0PS12m4lB+BA1NylfZUbvwFOEBsS98pcWLQxtXHwCEwUmW
        eWmxBE+7hz0qV3ZhCjXFpdU=
X-Google-Smtp-Source: ABdhPJxaXkYuErG/Usk8Th8d1w/eNR+TDPdBcWPz5mJUFFBM0jBbIzFtfCiDT7o7l4Yyvb0ydJVyDw==
X-Received: by 2002:a05:6214:27ed:: with SMTP id jt13mr365729qvb.24.1644384606914;
        Tue, 08 Feb 2022 21:30:06 -0800 (PST)
Received: from lumia-dev.localdomain. (pool-96-225-98-253.nwrknj.fios.verizon.net. [96.225.98.253])
        by smtp.googlemail.com with ESMTPSA id s1sm8712024qkp.40.2022.02.08.21.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:30:06 -0800 (PST)
From:   Jack Matthews <jm5112356@gmail.com>
Cc:     jm5112356@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: pm8226: add node for RTC
Date:   Wed,  9 Feb 2022 05:29:28 +0000
Message-Id: <20220209052929.651881-1-jm5112356@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for PM8226's real time clock.

Signed-off-by: Jack Matthews <jm5112356@gmail.com>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 04d070d98f97..ecc38ab1dc4b 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -17,6 +17,13 @@ pwrkey@800 {
 			bias-pull-up;
 		};
 
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		smbb: charger@1000 {
 			compatible = "qcom,pm8226-charger";
 			reg = <0x1000>;
-- 
2.25.1

