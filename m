Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999CC4B3DB5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiBMVXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:23:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiBMVXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:23:34 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6C53B42;
        Sun, 13 Feb 2022 13:23:27 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k25so33666830ejp.5;
        Sun, 13 Feb 2022 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvhJZMzLl9R1cbQyJKyCNmNT8QYkI+65YzzrmqgCMvQ=;
        b=q2W07K1lo0yPQWOYa/c0lwF85Ts+X8XribnXEVcCj59yyRYhqJPkv1t51ihgVoIb7M
         8AQF8IUatJoywxau80eJPSDbc1sqSSmPXRjIQB2+p+6KcAs/d2SJS1t63I8HNXcGIJGK
         fEU6x1mp/pWQ0CLFYGtoYZL5tcRSw5+r4q8NVrNAmhV3DQ17WKBKEXQK/mYJpmwH6R0o
         q8rTIw+N0p9oFwm3/kTjmX6I5XsBaZflAP7EP6/FIpoR5fzHPw5pyJieIBzbOEznkZR9
         0OWwTXl3z+fA2+wqjAVvMg8krY8jNqCYCWPPSbxYzzIXque+QTJ579ZtZAq65wg1Jxps
         nYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvhJZMzLl9R1cbQyJKyCNmNT8QYkI+65YzzrmqgCMvQ=;
        b=CF4csCH+GgVZrw1aE9iuhj4i7EjDc8uyi8dcxpQ0k6ThuxVXvYTMYdqabkZidvjpcX
         6/IoOgFX2rTeokRSYW+/RcTAW4ObH0vVpZvayPt/zXPX35CnqOFslFWt+VViWRZLxDOb
         Lgr3vhM1sd7puqyeIHnckbq8ylSDu71KVS2CI+W+3OtOC8RT02Df6AgVJkI95Hbyaq2t
         BIUeUQbK0pcLrVIMn2PAHuQO9dSgOZOdfz4wcHAcmAzVzBOuZdHuwtw6OfXw0ghtKmiD
         IpRZLhNpHtRWWhVNXA8avj7B1+6h/dgJtVIaE0gHDvOoz4TFqlsCUryu8zTjjH6IQHhI
         nJkg==
X-Gm-Message-State: AOAM530wkV8UmO4CbrUKbXcMHoXHrLk2SGUhqVkbB6cg2By2OT3dlr2G
        B/uKOijVlxRdnI8hKqAOFpc=
X-Google-Smtp-Source: ABdhPJwD+CiqmVWUoFdkHToaw0lBCqux0TIv2DCecS4O7HKPsY1yCTb4oB6fdLzzpfgtToAKFxp++Q==
X-Received: by 2002:a17:907:7b99:: with SMTP id ne25mr9316792ejc.161.1644787405769;
        Sun, 13 Feb 2022 13:23:25 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w17sm13239279edd.18.2022.02.13.13.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 13:23:25 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rk3288: remove status from crypto node
Date:   Sun, 13 Feb 2022 22:23:19 +0100
Message-Id: <20220213212319.8448-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A node that is not disabled is standard already "okay",
so remove status from rk3288 crypto node.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index aaaa61875..85d56c63e 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -980,7 +980,6 @@
 		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
 		resets = <&cru SRST_CRYPTO>;
 		reset-names = "crypto-rst";
-		status = "okay";
 	};
 
 	iep_mmu: iommu@ff900800 {
-- 
2.20.1

