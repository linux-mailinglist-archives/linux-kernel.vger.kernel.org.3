Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4B569733
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiGGBKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiGGBKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321822E688;
        Wed,  6 Jul 2022 18:10:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g1so13654267edb.12;
        Wed, 06 Jul 2022 18:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exIUvdcMrz3EXTtvq/kRKUvZQY9WcfsGq3uCE1DFdFg=;
        b=SFAZ/sIXGWJxL9MgyYy7eFvqKm1je7Fa0XPwrVzjIHAbgULCjY6xXHngj1seGeYxm/
         mWax23StT1P7b/wUJehpSvdzFTN8+qR9KcfV+s7Wnxb6KELmaID9hdz4fcEJqsQtt4zN
         Je5HBSM4VeXWhJT8mGWiwA9LxjG48dlns8V8ciIW80KAgVragEqQ0okygxaKNTlsySXI
         tRl8/5y25J9Iw/2nr2qMkF8u9QEQ1wB0yvt9ioOSJVNriB355cBZdrS5Bv/8n8KhO+EB
         19yXqfKnquewkO0TQOv9WPYLg7GSvV0T2jxkTE7/ofIpRRotH9Ty9drUHy3dpDxcZUpR
         NFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exIUvdcMrz3EXTtvq/kRKUvZQY9WcfsGq3uCE1DFdFg=;
        b=yXduTDD1lzgD+fBMMJcG9gA5MYoFlAKBwO9zUHe6CvL/M8MrUe3q4Rxa2E1+h8ts2S
         pj3AhxgsKDZuWqqhi2O7OPZ7apJGo7nnr+OpoqXyZ7IQLrG8RSKoP+Y7htq/7WQgRJXD
         yLWhGQfxRVOJpEwbV/Yk+kEZHAIMtB2EEPdn+5MQVETJKMy89xvZebrbZ7hTRppyQSWH
         +9iRESMIsY33TwP6POGvHGiKFoFWCG35EIzWY0V2s3WrWi6joZCXtNDdwwVPK954hzvG
         Jjjc3gZr1k54JeI9eyXnRy0+rVA4ORlHrPJASnyr0W1pE4XlHDoD1aW46II3ncTuLU8R
         kTBA==
X-Gm-Message-State: AJIora/CsC92Q0IWhQ+kPbflQwAnmYoDxzBOuAlgwTh4PPYrmZWWBOFP
        1Xb4VlIgL31M5ggXaFKE6qA=
X-Google-Smtp-Source: AGRyM1vHcuVGZKILveCwTRG0HehlPnnwRiTwEYhhA00rcl4FyqM2OQtgL7VRvtJIHi81gaGW+4p+6w==
X-Received: by 2002:a05:6402:4011:b0:43a:84de:26b1 with SMTP id d17-20020a056402401100b0043a84de26b1mr10117391eda.402.1657156212739;
        Wed, 06 Jul 2022 18:10:12 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:12 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v2 8/8] ARM: dts: qcom: add speedbin efuse nvmem binding
Date:   Thu,  7 Jul 2022 03:09:42 +0200
Message-Id: <20220707010943.20857-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707010943.20857-1-ansuelsmth@gmail.com>
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
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

Add speedbin efuse nvmem binding needed for the opp table for the CPU
freqs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 69cf664851c6..71572028bc36 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -854,6 +854,9 @@ qfprom: qfprom@700000 {
 			reg = <0x00700000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			speedbin_efuse: speedbin@c0 {
+				reg = <0xc0 0x4>;
+			};
 			tsens_calib: calib@400 {
 				reg = <0x400 0xb>;
 			};
-- 
2.36.1

