Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A14BAE73
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiBRAa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiBRAar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B326B098;
        Thu, 17 Feb 2022 16:30:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u2so10606238wrw.1;
        Thu, 17 Feb 2022 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YNGyf2dFMI9HgNiwXOyPfOUSm3HoLabWOizqD2ml+sg=;
        b=TbHSQqWPmQSV2LAI6HyHwx3hk8ZOSxJEyRhtTYQbYK0ysVMCrTVt3mhoWtrt35zkbS
         jYhh/1ZHuHcAteUJS7OB/gYwApEWjxiaByJYVMDJGa15WisTBtuqRl5nW+gZL+Uu77Wf
         XRWfLkBGv7m5kaKjtAEMRIHL6eoK5QuNJc63AZDTV/HdW4mU0CLx8Wb+qHD3vp70OlOr
         FiEsSfT2vk+XcOir5GAFQlhhqKJEH87wN9Ogmh3nQiz4d+y+0AYzZzfOUaXhllMw/jWO
         8uBDU+tw7EQ2TR8LMmfggCYdpO3s5f/gJ+OJ/eymakkoWIw8jUqaLwBvJMhnLWQ5rdqB
         /27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YNGyf2dFMI9HgNiwXOyPfOUSm3HoLabWOizqD2ml+sg=;
        b=05t7+fwvzgw7xXhmP5O1R2CXPb9uARptxTzsqs/EGaTli0VtaNLrcJ0Aa6CHjqQBh4
         IsEMRSmQSsvcodDqvE1ElLotpOztVkXcWPlK86qJGkcHZBmSc0mboI+z6EL0eXNpml9Y
         PFo+jW86lylG44gQgLRKwFsOZ7lzw9vDsDiKO8iZTRaHvSNGpCOMmHmI4c+N2ImwN6O8
         jCTQXuouz5iucW/dzhs40qqgX2GyvZTZNaEA4dixTzQsajSlgmEURK43eMfy/43POsHV
         5gjHzIUCf1NJCGrb6BL5APFxFv0J/irWE6jSmaxU30MhG/gFqZbkH69KQD98WFxDZPnl
         V5ig==
X-Gm-Message-State: AOAM530cEVvoRGlVmU7DZzKT0J0I+6Omx/u7kcMk4TZGHKOLL2HbDRq/
        lk+0+5pRqBcnYicZ1t/QzFs=
X-Google-Smtp-Source: ABdhPJwiqCA4FFsEaIidgIAcqxF/9S7+EsZSp8EDlInro5sHKMPu/03RHeAScR4h08xXcR/+FNIzcg==
X-Received: by 2002:a5d:4242:0:b0:1e3:3130:5088 with SMTP id s2-20020a5d4242000000b001e331305088mr3986238wrr.540.1645144206238;
        Thu, 17 Feb 2022 16:30:06 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:05 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 11/18] ARM: dts: qcom: add sic non secure node for ipq8064
Date:   Fri, 18 Feb 2022 01:29:49 +0100
Message-Id: <20220218002956.6590-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

Add missing sic non secure node for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 7df1c1482220..df2702e6136d 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -563,6 +563,11 @@ saw_l2: regulator@02012000 {
 			regulator;
 		};
 
+		sic_non_secure: sic-non-secure@12100000 {
+			compatible = "syscon";
+			reg = <0x12100000 0x10000>;
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
-- 
2.34.1

