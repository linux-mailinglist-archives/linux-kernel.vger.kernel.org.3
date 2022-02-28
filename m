Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53934C6CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiB1Moe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiB1Mod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:44:33 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6434846B1F;
        Mon, 28 Feb 2022 04:43:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id bd1so10581584plb.13;
        Mon, 28 Feb 2022 04:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnFsM8IpNjKcaqxOnVlKHRTrCgn6GK/en/A/KCipAmY=;
        b=XjmZB7tbh8KzPMjDzNG5navFiQ0CQofW0187RFubC1Zra4jPyg2ZkjtzspXvPGNa9S
         ICiPFlDRRSYfEsoAv/uV0zFCZPS8T/+SYqSkSpbpCsayeQ9Bt3O4+663YkyGjtX15ch7
         NyUaSxHFPgGvtHOjdHSFvTudKE+UhEvtsr6bUvcJXZrdboitnJk/vDHHrkA4WM6VglN4
         67lbrb13yIH/HoUYk2DARcjdztEJRi/hZKqRx84BLPHun0xh/eOLi3XwtqacXvkgtTwT
         dO+Fdmuq4E2gYfXhKYqm0ds7D+7+YPTRdA8QOH2TNItz9YU/ILdo3t7NJanlwi/CfAKG
         LQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnFsM8IpNjKcaqxOnVlKHRTrCgn6GK/en/A/KCipAmY=;
        b=tkIVDogBm1BaNkfrDD7o46n0LkXuHHllmp/VQD/nNu+kWTSs41EUQGmmdNxTLPQ0gM
         lSd186cd44wJOBm6HGlUXMboHjuwudK+Tj479ztt2tOQLI65wRCFNwoAzLwL0wqRYE1a
         ftBRroU8LOoorVwrA+anu0iNiNA+hWhF1Bq9K01o7rAgKtBbxyNYpiS58QKRb9tp81NE
         hLkeVq7xZymub5ltgICKCsEgeb2WJfkFPzTBegf1Qm/hYTVMIAtfIqFSjRMy4kQmRop+
         JWekhx7/QV0BH/lYDgIrnbShZsRH7WmyKqyZC33qqnI+jjn9svzleZ1K6hODfAxxSxIj
         F5oQ==
X-Gm-Message-State: AOAM5303yirb9JbTb7QxUUeM97wfOjv219b+jHKVDJg9IZJyNVSIUOWs
        XZiDWtX6b4Max9fjimEbjuc=
X-Google-Smtp-Source: ABdhPJzdeMjVo+TFg+cjmC4ATgICfkJCTpifmYxu3bDqHQ8PvvsHqwwME9OLPcgzJEXra+fuVzJFhA==
X-Received: by 2002:a17:90a:9708:b0:1bc:7e5c:e012 with SMTP id x8-20020a17090a970800b001bc7e5ce012mr16452448pjo.168.1646052233877;
        Mon, 28 Feb 2022 04:43:53 -0800 (PST)
Received: from localhost.localdomain ([122.161.51.77])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b004e1bf2f5818sm14129214pfj.87.2022.02.28.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:43:53 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] dt-bindings: spi: Update clocks property for ARM pl022
Date:   Mon, 28 Feb 2022 18:13:43 +0530
Message-Id: <20220228124345.99474-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
References: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
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

Add missing minItems property to clocks in ARM pl022 bindings.

This also helps in resolving below dtc warnings:
arch/arm64/boot/dts/amd/amd-overdrive.dt.yaml: spi@e1020000: clocks: [[4]] is too short
    From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml
arch/arm64/boot/dts/amd/amd-overdrive.dt.yaml: spi@e1020000: clock-names: ['apb_pclk'] is too short
    From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 6d633728fc2b..7d36e15db5b3 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -34,6 +34,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 1
     maxItems: 2
 
   clock-names:
-- 
2.25.1

