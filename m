Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A864ACB47
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiBGV2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiBGV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:28:41 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ABFC06173B;
        Mon,  7 Feb 2022 13:28:40 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z7so21631461ljj.4;
        Mon, 07 Feb 2022 13:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Q860UzoNHkSGhBZidlGaembMRpSoaI1XHsnLyyfySA=;
        b=jWT4d9q22RfH9KCQBCVoHIkB+iO7/l1Ixwv52jJo1TDAfuFi5myUVttmXYgIybzCcv
         lAHf1wS1uwZ7mq+IRgfshmFAoXqMcqbFD2Gf7/HFb4n+SzP1Y7GJrbZIbPpTmalHUlVp
         6SZJUtq9A4YNgI102WkbKDl/xgg3yqYvAcNMzY3Wgjxh1BBjbShXhARTC7PtWXLH/OWg
         Y66VIjZeWHp/RM5r8Kq37MwYAYlmE33VUXkOQMC15JInyJRkbB/4xWu+cgbGtc5vskQJ
         9+MODhIiv6ytWkIREYVk1ojK/fQ3thUGM8LZ+2NnZRsydo7H3TDw1ceN/MQtJGPMNrxw
         NLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Q860UzoNHkSGhBZidlGaembMRpSoaI1XHsnLyyfySA=;
        b=hrVgY7Udy8hoRWYR2rwWT0U9W3yDAU+KcJVvInnHpxTIWl3YH4UJkpAN1IroDDeTwi
         H4/UwjMXh1Bt0UqYsuZ/P2JLHfk16vyDVtKhlFK5SL6nDDtfYpmObKdtvjBUGoW+wP4q
         sl8ZsP9UWyoOZx+lJDmtV1cnP45uVyw8xzZiqv33Z41bGr+F77HqTFUj7MzeAes1y8a8
         UowzMqtoBp2W4rdIvoPyO9gozCsNPDJasasJNwL1Krtc1attEzx/YFUcECz04NLTt4gn
         djQ6uLPtXWkCxVDkz5kJ+Y55aAyvqGkvywaF6FX54WJ9ncIT1HV6Xgk4qXVtLG5psNJC
         EpFA==
X-Gm-Message-State: AOAM532oPJvch9dUl2DgFic9CzsDOnNOw+Y64s7P8h1Lt0vY1XVYQbkr
        tk3u8XTB+oZvra+pTWGxP/8=
X-Google-Smtp-Source: ABdhPJzDwoO/29ZGl0rzfp7+eU+WsDkVllLXZ66A7j2pxLL7tAoHfQfbkMTocE7texewvZL0u3cmtw==
X-Received: by 2002:a2e:a4a9:: with SMTP id g9mr885708ljm.289.1644269319308;
        Mon, 07 Feb 2022 13:28:39 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id i3sm1650867lfj.144.2022.02.07.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:28:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Robert Eckelmann <longnoserob@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] ARM: tegra: tf700t: Rename DSI node
Date:   Tue,  8 Feb 2022 00:28:25 +0300
Message-Id: <20220207212826.10307-4-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207212826.10307-1-digetx@gmail.com>
References: <20220207212826.10307-1-digetx@gmail.com>
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

Rename DSI bridge node to match the requirement of the DSI DT schema.
This silences DTB-check warning about the incorrect name.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-asus-tf700t.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-tf700t.dts b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
index 18a9bfa5e97b..1a331dec3cfe 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf700t.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
@@ -742,7 +742,7 @@ i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			dsi-bridge@7 {
+			dsi@7 {
 				compatible = "toshiba,tc358768";
 				reg = <0x7>;
 
-- 
2.34.1

