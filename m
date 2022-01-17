Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B26490963
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiAQNVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiAQNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:21:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AAAC061574;
        Mon, 17 Jan 2022 05:21:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 89B7A1F439D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642425698;
        bh=CaYg+p9O0uAGbG4kMt1HbrD2S8z16L4o0uwZIImjC/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnrIjYhsktlNV9VWQB6Vu9aXtuIPF8B3cBwyYVAMia4ACvZ9PskaiUCyN+16WejaR
         sxslWLJoi/paPh7eiTaExz70GTt7EuAcOW05dRGmGVmkFrPYgBVeR5y3PR+DNjDzgH
         CHDuv7UVJW3cPjOvps4oAKdwHuezLaaFj9opnKeioCjGsrLzE1pEwARlpza8BnCjU0
         5DCJeg8rtmhdfHg3Yf6mlH4oDrG0aeNRV6S9vuIuJAv9+j3RnmkeobDpz117oIPe2E
         4WM7i3m8Y5nPQ5OKjsjgLosu2F5b6/kwafELT8qENcH2h7uDDHsl5O3q7b1D8VKUnY
         sAOWcpFA9veHQ==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@gmail.com,
        tiwai@suse.com, tony@atomide.com
Subject: [PATCH v2 2/5] dt-bindings: tlv320aic31xx: Define PLL clock inputs
Date:   Mon, 17 Jan 2022 10:21:06 -0300
Message-Id: <20220117132109.283365-3-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
References: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add constants for the different PLL clock inputs in tlv320aic31xx.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 include/dt-bindings/sound/tlv320aic31xx.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/sound/tlv320aic31xx.h b/include/dt-bindings/sound/tlv320aic31xx.h
index 3a845fbba992..4a80238ab250 100644
--- a/include/dt-bindings/sound/tlv320aic31xx.h
+++ b/include/dt-bindings/sound/tlv320aic31xx.h
@@ -6,4 +6,9 @@
 #define MICBIAS_2_5V		2
 #define MICBIAS_AVDDV		3
 
+#define PLL_CLKIN_MCLK		0x00
+#define PLL_CLKIN_BCLK		0x01
+#define PLL_CLKIN_GPIO1		0x02
+#define PLL_CLKIN_DIN		0x03
+
 #endif /* __DT_TLV320AIC31XX_H */
-- 
2.34.1

