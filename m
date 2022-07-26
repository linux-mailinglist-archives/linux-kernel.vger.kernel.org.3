Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D1258113B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbiGZKea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbiGZKeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:34:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC3D2C661
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k12so1811112wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVpUn1ya8DZAmfEkPodqRgTC7Rp5n0FnEcoh5sI/x9E=;
        b=598pyo7Pho0sXAWSrhHI/4pPNNR42w1FdwJKoS11KfZ8OGo1qnHif44ryBqVmJYqI/
         JExhDmtPEQjbR0QpepvVfSVrQwsMKTn3VjGGn8rc1wF5bAU7xgd/sdmSbDl0oE3Oz//5
         MTWOZhosTtqYpOyDPAz8NyDNNFtnTK9aZ0bxICn2BPhOfyD2+R073sTL6qydQuDG06Eb
         yjgkSkRh3kuf06kojrmmGN/ejF1s/JkOKyVPpoTeEza1zNtJSYVWThFc1Pln7nP0pjgV
         NiMC1EyeoA5SDe6E4lZLBfFvQ28Tu2h4XVfKAE0vcz2k1Ds5lHwEScoQwIh2dPcSXSCg
         0lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVpUn1ya8DZAmfEkPodqRgTC7Rp5n0FnEcoh5sI/x9E=;
        b=NKkZrVjQvYrbiowaAaPFgNLdTZRFR7yI++mki20/MIdXap8L6wKQVd3tgvH3IMczGy
         j4ZPQObYAywWiqMzk/MxKT5vmYGe+UrW5BEtDeaI0xK07nqtAwJDrOBsLygBRWKu02Z9
         fwnYvVdnKxdJbmoQhPzbMxOtzoNrdxyxLR0T9ohJY9UCbxVd1UIkkagm50yMFrbso9os
         I4IBTahQSlZvjePKErX2qHy+PO7m/Ed6GsFS3AtXjfYpDHVxrbxK8KnkEBjtTRnH71NP
         +ks/TG9vxzIekkID+mOiYUKQsbfzvRX/aqVZlhhM9kcU+QyzUoo6iRI6qH2dr79j2Zl6
         RY1A==
X-Gm-Message-State: AJIora/oLaq1SM6h+z+gZ0IFMKo8QHEA3cyBT/iXiWW4CYCR4FAhjSCZ
        r0UCU8SXLuPR71xq2IzERXVlPw==
X-Google-Smtp-Source: AGRyM1uO7T50XsgowPKwutHFpPO1yqrdBIf0BIORNhJdo+xEZAG3b7hTHiB8/txL1HC5YOjr1eK+kQ==
X-Received: by 2002:a05:6000:144d:b0:21d:8109:701d with SMTP id v13-20020a056000144d00b0021d8109701dmr9986486wrx.443.1658831654383;
        Tue, 26 Jul 2022 03:34:14 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-4641-6f91-91b7-326a-5d27-a1c3.rev.sfr.net. [2a02:8440:4641:6f91:91b7:326a:5d27:a1c3])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b003a2e42ae9a4sm20617121wmb.14.2022.07.26.03.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:34:13 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 03/11] DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button
Date:   Tue, 26 Jul 2022 12:33:47 +0200
Message-Id: <20220726103355.17684-4-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726103355.17684-1-jneanne@baylibre.com>
References: <20220726103355.17684-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

This board uses the pin as a power-button, enable it.

Needed for driver testing but official board support pending.
TI commitment is required before board upstream kick-off.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 7a84223406f5..d789fb7c2162 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -348,8 +348,7 @@
 		pinctrl-0 = <&pmic_irq_pins_default>;
 		interrupt-parent = <&gic500>;
 		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
+		power-button;
 
 		buck1-supply = <&vcc_3v3_sys>;
 		buck2-supply = <&vcc_3v3_sys>;
-- 
2.17.1

