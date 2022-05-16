Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CD528483
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbiEPMtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiEPMsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B76393E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so28388209ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waU3K0MvAzeyP7xbzKOY8mZTWP7XaT549jbnYao59EU=;
        b=varXJRS2hmHMZzp7kWDkIfsusldauY13LgapH5uyGc30Q0jbZKAmqiWcEUqfUR8vty
         ej0YAstpLN5iJj45p4DAeGV4XHa8lO5pyy/7G6bSx9U5qRVzniHkEhMKpFJQNwaJeCiX
         K99ipccWMu6sYXuqS+P18s44tuT9xWmxRYNxmGYJNWfqiNODuBCefNDpZtMwIbcoILdN
         yxBB1LnfUOyOm06aRxey04EEWi898El0TKQGnguqbRAQBlC2tjLqjE4MB3KZodxhfbNg
         5oYiF57rbSHnMYVIhpstjwE3ThD06vI67GeZ+mnxr2Dt0YYiUv9q+aHMtivoYHCWDlEt
         Ez3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waU3K0MvAzeyP7xbzKOY8mZTWP7XaT549jbnYao59EU=;
        b=cFZhrmDMJFrf+cmDraysRsTFC/o5wx0w7ml2WgauGqx4pA3E7iQ7TCj2qSd3YexWP/
         cgNHsQt4zlkUqw/O0/k9XyierauF3xEE7sVPTOeIoKpz4Q7toDEBoEuLfZlO2HEvvjEI
         LdCOASAkSsUuSJuR4zumrZHGjy6JrFt3Vg61tdheMFDk+bg5NK6h1qDHZoK6/G88JfbR
         n+ETVWyd+OAABYSsq/IMN86zMZVbFZAM1GispDAx8Dr3j4ug/q+ldMEcUIRUWiwAVhyB
         mezK/8ZFwHGHgkozu6eDCUVTlxzGFqLuhTOaM2SWXivq+JT6ou4i3X/4V4wQJmnATWdG
         srKw==
X-Gm-Message-State: AOAM530LXF/H8FOC+gPIjVlsshS5Zg+//YZOyZpBmIIXYcMYWvtH/eOU
        1rz7tCNyFVtmLvxI4ICWGNoY5A==
X-Google-Smtp-Source: ABdhPJzULY6GbxpETrF33kCHD3VtD07gx2BP8U/S9xxQQnV+s8wlwaj6CPTsXQbuBlRuJvn3PM4UxA==
X-Received: by 2002:a17:907:6d08:b0:6f4:45ca:c410 with SMTP id sa8-20020a1709076d0800b006f445cac410mr15551799ejc.679.1652705323394;
        Mon, 16 May 2022 05:48:43 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056402330a00b0042617ba6386sm5093331eda.16.2022.05.16.05.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:48:43 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 03/10] arm64: dts: marvell: espressobin-ultra: add generic Espressobin compatible
Date:   Mon, 16 May 2022 14:48:21 +0200
Message-Id: <20220516124828.45144-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516124828.45144-1-robert.marko@sartura.hr>
References: <20220516124828.45144-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Espressobin Ultra is part of the Espressobin family and shares the basic
design, so add the generic "globalscale,espressobin" compatible to it as
well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index 070725b81be5..1b2ed63ae6a2 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -12,8 +12,8 @@
 
 / {
 	model = "Globalscale Marvell ESPRESSOBin Ultra Board";
-	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
-		     "marvell,armada3710";
+	compatible = "globalscale,espressobin-ultra", "globalscale,espressobin",
+		     "marvell,armada3720", "marvell,armada3710";
 
 	aliases {
 		/* ethernet1 is WAN port */
-- 
2.36.1

