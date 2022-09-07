Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397075B04E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIGNNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiIGNM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:12:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E147E314;
        Wed,  7 Sep 2022 06:12:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t14so13045987wrx.8;
        Wed, 07 Sep 2022 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XhHHfhBS4JEZS5T4Cqsky8UODYiFkR3zFwNbdfWOgRM=;
        b=cNPthfE851d7tnORcRK51E1iI5AqPMQEo0UIapDJ1GUAaS8Z4ZppZZ7rLg5TOY1tuS
         ZQK4JcssPZtZ+Kdff2MXU4oAn9W8OdKmOU47c4ciwwvc8VP5azQaVUJAe1PXJ4JAeNVJ
         NpWGMfDVf9SkB5y1Jf7d3M50H+FHDReUXNXtfON70iPH30Jr0e525XQLwBypbmfGG9kB
         DcCNrQwNETpxUHoco8WOnCDHLrYOt5wx2EdQUnsyo9+QtJbnCV5yED/uhhNjO0+/fHz8
         cfgTeIlHOoCh9mMrKmIIkNc6du8op7r5JLownxHSaCuG26MzZ76XmnF4rXSsJlPTGjPh
         c39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XhHHfhBS4JEZS5T4Cqsky8UODYiFkR3zFwNbdfWOgRM=;
        b=AALWwaLBh/kYJ2zt2atQ6EYKBaXmK/B3z6IvOhNA/Bmbx15EuP5oDr3KkKEcB5wKE2
         CzMiTDZhvIXx1/LEjCQpmTYIOA7yqtTqTTuBhOPjuRKWsk8OU2sGvNeUTzL9BBMJkJAQ
         UcHdyb6+p8C3+6hcIF5iozConXJut5piE5CnCPV60M0FKjWXHxr4PMQZKfjpX7et1VjL
         h7MbXmQdukHoLQ5LUHFGhqBChD5UuGwfM/qYOHwwB6ubAJP0SKoa80mmyBQa5Nz9j+PX
         gfx1l5VUR52QCVCAt0LISWh3jpKM/azJaPe5O9eywjAPcHk/EdI9j/a5j/xBH9MvSFyM
         /0HA==
X-Gm-Message-State: ACgBeo1IbkYFp6lSmVoaAKz0rLldZpwi4U+jQue0dEHxADwZakaSh+pQ
        E5nGty56JDzvChKmAEKpHq6mbMt66vU=
X-Google-Smtp-Source: AA6agR4RcR+HDYfOlSTd0KPvM/Pn5D6JH1gw1MsiVX4ajkgr5c2JDjkO5ziK3Y8MEQ6KyTtY0oTSDQ==
X-Received: by 2002:adf:dbc4:0:b0:225:333d:8404 with SMTP id e4-20020adfdbc4000000b00225333d8404mr2215948wrj.671.1662556371220;
        Wed, 07 Sep 2022 06:12:51 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id d11-20020adffd8b000000b00228df23bd51sm3975325wrr.82.2022.09.07.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:12:50 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] ARM: dts: mstar: Add pwm device node to infinity2m
Date:   Wed,  7 Sep 2022 15:12:41 +0200
Message-Id: <20220907131241.31941-6-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907131241.31941-1-romain.perier@gmail.com>
References: <20220907131241.31941-1-romain.perier@gmail.com>
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

This adds definition of the pwm device node, infinity2m has its own
hardware variant, so use the one for ssd20xd.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index 1b485efd7156..70561e512483 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -32,6 +32,14 @@ cpu1: cpu@1 {
 };
 
 &riu {
+	pwm: pwm@3400 {
+		compatible = "mstar,ssd20xd-pwm";
+		reg = <0x3400 0x400>;
+		#pwm-cells = <2>;
+		clocks = <&xtal_div2>;
+		status = "disabled";
+	};
+
 	smpctrl: smpctrl@204000 {
 		reg = <0x204000 0x200>;
 		status = "disabled";
-- 
2.35.1

