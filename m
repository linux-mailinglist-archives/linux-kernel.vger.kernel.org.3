Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75EF52369C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbiEKPCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245520AbiEKPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:01:27 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC59124BDB;
        Wed, 11 May 2022 08:01:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id p4so2140108qtq.12;
        Wed, 11 May 2022 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehskEIe5iN8y7k3SRy7I7dQU1KrIdtzHbsW6vH/ZN2w=;
        b=p+m2+5cZMBniorHS3GIpR5fpXoDkYGG8xLXaQI5ZyZrrYVzvKJfMbWdNgfbQBW9BJm
         CWAOE/jjuSGI+LAPyHLvLjWt0tQEaOO1RNObnvOsdmBOvkXb5xVT9PZetOnv4V76kGc2
         wGImIK49xn7/XLmSs+VJ6iWiCurKjCkoN0mpiecPfvfbER99SsCfqgrREiRIrEKCtGpx
         +nqPBopag/k3Nv60vRBoHudK4tgmCOEI1lAek2gKZinwniEZiaLwlTbX3spmb8pJxoMa
         NEMbR8PK0UwFoFArz73iw4NnKeMornPM9600Fz9ksxXkA5K/dhdvwHpGNz9I2GGjYRRo
         /ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehskEIe5iN8y7k3SRy7I7dQU1KrIdtzHbsW6vH/ZN2w=;
        b=SBhakKrBinoRff9mB4qXiRrSZBwuZinTB5VZn5fbum1X1nwY1ON49ZAwatx1nrkBpn
         Pw7sIhgm50+NBZYu38cpxqMzwLgOBf8QIcYstb1octb5o7zv7i0yDHVD5fLvgd+GGDVe
         /ozaAt7EwFSDIWGjWCgy5j7hWni52V+7YYs0xtUu0KWJZgluAPd5i6Hhjafzv9qn6CFo
         bGaWk/tPpIAcdGangIu/opguZpGm/PHpSvzbQIYy+bGvOlyYVMvp1QxRj21EOBgGlQCy
         AZdD7mwfbcsiB1RC9qVngM30koyjgAPPicLcfrv/zHmKILr9sGUVVsGJlyuxv5OE2kP6
         SJIQ==
X-Gm-Message-State: AOAM531bq5bVBs/wb4lReRrZdLnt4CjPpYujXJJo3LM/uW7RYZYVeLJ2
        iotglbwfTJsKSmZFgyTRvZU=
X-Google-Smtp-Source: ABdhPJzBYLGJuTwDEA7mH2iU4A6z3+FF6sNsnM9AaKOzjq2Fi0ZGfMGf2i1hpmWPKX4Ry36ludi3BA==
X-Received: by 2002:ac8:5e0b:0:b0:2f3:c8c6:da87 with SMTP id h11-20020ac85e0b000000b002f3c8c6da87mr23035259qtx.130.1652281283131;
        Wed, 11 May 2022 08:01:23 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b0069fc6484c06sm1487134qkn.23.2022.05.11.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:01:22 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 3/6] arm64: dts: rockchip: rename Quartz64-A bluetooth gpios
Date:   Wed, 11 May 2022 11:01:14 -0400
Message-Id: <20220511150117.113070-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511150117.113070-1-pgwipeout@gmail.com>
References: <20220511150117.113070-1-pgwipeout@gmail.com>
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

The bluetooth binding for the Quartz64 Model A has incorrectly named
host-wakeup and device-wakeup gpios. Rename them to clear some dtbs_check
warnings.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index dd7f4b9b686b..ca0b92795d95 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -638,8 +638,8 @@ bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		clocks = <&rk817 1>;
 		clock-names = "lpo";
-		device-wake-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
-		host-wake-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
 		shutdown-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
-- 
2.25.1

