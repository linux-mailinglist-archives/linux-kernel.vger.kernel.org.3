Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6BD4E806E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiCZK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiCZK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3D23154;
        Sat, 26 Mar 2022 03:27:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bi12so19771619ejb.3;
        Sat, 26 Mar 2022 03:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfRX7xUCz0VHclcUMj2G1rk65qDiyF54u2Cxho1r1WM=;
        b=SONsoAOtA4moNtv+X/3zVHRVaXMg1KRgwt6swuWcVD2Qr27LFycDzSiPrH7kfDe1fD
         OdD+m4gJi8YvSiYqL276hH5LMEjZS7ZHcrvmq6rfPOEMuvwt+oBBPsssG68BfR5bvGPR
         Fz6NEj7K1JIdoPs43uF0yLEn27b1l1bqErygBUSel3YrskZOKKgKl7aQsIDlgkWIq7f2
         i18L1UiwLdYtdEpcpBHpwc6zpXioWjLY7Aeygpvo9BNmxFChpBkJrEAJRq4sksXVeSh8
         w0oBDqwJPU1rb0dpHnbaWZd7tHXBqywFiEg0Q20OWIiAgmlJ95s1/Mgt6Hplkel10/oG
         fbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfRX7xUCz0VHclcUMj2G1rk65qDiyF54u2Cxho1r1WM=;
        b=Wd0OtQz6hp6r+58/xKrLTRvu8nfU7KS3cfpUUaZ94PGrxkoaAeIbGHqA2+n5TLGlCz
         r3aDaq8DKQzMw5wxRS6Yp+n9CM7Gb+Qv8vWoUcoMJyLY73tgE6aDARG05NwuZQCjpdH0
         JVeP6wVPfXKZLD7R+9lWsnbrLmvpcCyxLb89n3Vtbsk4ErDuDH0V1I39qvCMw4essObx
         aBsMxlMmGeFwDeAsqixlYeeLjmHjKuHHxTa9CMB1byzN2zIoNGb1alZBBjMLCQjO3/Hz
         1rdF24iGPkx1xftVP/Liw94icqhDvhjgQ2WlURsvjcqwvzD7UcmyNwes8ZxvvMbAIasI
         3FkA==
X-Gm-Message-State: AOAM533NMe3hC/yVqH4R6OL1429X+8DtaHvrsQMb73OoEjFbYEhnGo4j
        D6Ud8A1ptYTES9iigHfpfE6oyPbMfpM=
X-Google-Smtp-Source: ABdhPJzqvyfol6yYH7+6ZqbdIgJabDs9fjQ/2LVQ8vNQd2m0HWx7rZbIYE5FigCYfqLSKN4IUexg3w==
X-Received: by 2002:a17:907:d28:b0:6e0:996c:7e53 with SMTP id gn40-20020a1709070d2800b006e0996c7e53mr9443800ejc.658.1648290441785;
        Sat, 26 Mar 2022 03:27:21 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090670d700b006ccfd4163f7sm3209021ejk.206.2022.03.26.03.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 03:27:21 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] arm64: dts: rockchip: rk3399: use generic pmucru  nodename
Date:   Sat, 26 Mar 2022 11:27:11 +0100
Message-Id: <20220326102712.20906-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220326102712.20906-1-jbx6244@gmail.com>
References: <20220326102712.20906-1-jbx6244@gmail.com>
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

The cru nodenames should be generic,
so fix this for the pmucru node.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 88f26d89e..01c08a2aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1413,7 +1413,7 @@
 		clock-names = "apb_pclk";
 	};
 
-	pmucru: pmu-clock-controller@ff750000 {
+	pmucru: clock-controller@ff750000 {
 		compatible = "rockchip,rk3399-pmucru";
 		reg = <0x0 0xff750000 0x0 0x1000>;
 		rockchip,grf = <&pmugrf>;
-- 
2.20.1

