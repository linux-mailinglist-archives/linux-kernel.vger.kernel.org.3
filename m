Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B504EC5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346206AbiC3Nl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346174AbiC3Nlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:41:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171BE1EC61;
        Wed, 30 Mar 2022 06:40:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bh17so2112454ejb.8;
        Wed, 30 Mar 2022 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ck7b8QF/9VQw0lUYxwomWRlvrWDSmZJvomns1owBa3I=;
        b=CN7r8g2tzDccy0k72Zp/OTB3aVy9lV1PiC0RRwNgByOwMNsVx4lCwHqt3pVMmdsoPx
         40wNmt+BWEZY6SiGjJwwlLub396Yt5TCL9MrzYS9KID9ObvVhWGiKR+Kze2b8jIhuKYq
         mKfVfTvyTfKnhVx/CUNRPoVJWQkMfJaT4sQoHwrhHqKXsWXrRGtncZUL195kOZDT5dhe
         A9HEBgiRs++sGrj5deCL1ixW78C+IZBiRjAkqkzoMuzgXULtZA5SZGrUMf/QRKp01YyM
         F1h2FQB3oITpHCGoD/8Yg5f7FafBBGNRR7mBbBi8UB5kgLQJaN2vo43FQhtrb0LurbcG
         LY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ck7b8QF/9VQw0lUYxwomWRlvrWDSmZJvomns1owBa3I=;
        b=AYzqPM7khZ5zB4+kdQuxlP+suvtCka5vKl3sgp5FnYL5ZSTLrRi1IVJFe8Zu4rF3/Q
         N+WiOXABMzZQltV6p8X00JsIznAzWJ9gfbUiUpIVTnyPVS7wLMGrLAKRzkwDxpd37j7n
         Vg62R1g2AXAjiM10MquNdWSQedI51Oiow0HBffwgKEi3lsziG8pl0TsU0FqcDs6KG0HV
         Ata7RVMHvvdMXfyTXp1OcnkMWWBm/Ph6ykt1B8HcONCVZPUgLQpMy2Win3wgcRud1WCV
         6cjT/ZWCarBA7umtiVxMehAItizDKh9NjBvbwfEv/LaP4UfDtEykr9cmiydFobsDHe+W
         S/cQ==
X-Gm-Message-State: AOAM533FsZJOZUVEDYxztLU19RRAxZs6aCWKTiIKWaMsgq63w4GraAyn
        HtRGLtJlh5Ldn4ipfT1umlE=
X-Google-Smtp-Source: ABdhPJxaATFwp3dpqkvLsICnSN/PNJpESkj+croJfWcHn6PDEVwtfrylAntDfL1OIe65hr6qmX/iCA==
X-Received: by 2002:a17:906:9b8f:b0:6e0:6bcb:fc59 with SMTP id dd15-20020a1709069b8f00b006e06bcbfc59mr41136157ejc.624.1648647599534;
        Wed, 30 Mar 2022 06:39:59 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe680dbfcsm8375448ejc.43.2022.03.30.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:39:59 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: rockchip: rk3036: rename pcfg_pull_default node name
Date:   Wed, 30 Mar 2022 15:39:52 +0200
Message-Id: <20220330133952.1949-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220330133952.1949-1-jbx6244@gmail.com>
References: <20220330133952.1949-1-jbx6244@gmail.com>
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

Rename pcfg_pull_default node name so that it fits the regex.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index c5aa1636a..9b0f04975 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -616,7 +616,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		pcfg_pull_default: pcfg_pull_default {
+		pcfg_pull_default: pcfg-pull-default {
 			bias-pull-pin-default;
 		};
 
-- 
2.20.1

