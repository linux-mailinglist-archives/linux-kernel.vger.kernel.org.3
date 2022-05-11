Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079AB523252
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbiEKMAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiEKL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:59:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8019D243107;
        Wed, 11 May 2022 04:59:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z2so3582315ejj.3;
        Wed, 11 May 2022 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yo4A+rzP8xcB+ZIATNv2HRdS6sj8NLoNJ5T3COsIXbo=;
        b=noY28VYHlxHestrmTvCdpJRb5je14zV1r2LuLgZffu6i25K3VOswkAc2luMTL7kyQD
         W8GKPgw+q8dGY/6cSTP4OBz8OehujBACY/U677sC5myTROOuWYFtquZZV5y1z1Iv7gjL
         /jIePy4ebZZdRTmGsNBpnVoTnMaeHHvATXhUCX6D2XRsX6NvAduem+BMO4lYgRymxbH2
         GFMbb2euS04ZOSwqFXb7gjzJeW3K0cxCgTkpoaTJvpm6wG74iLLuOhxfrs5GhLwVfGT+
         MfzCGJtZsdo4YOSEXbzz1mQW45SWs/gsN/GIxHJza5LbMO+XHaFBIAQrgbz+ilem4mTj
         ziqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yo4A+rzP8xcB+ZIATNv2HRdS6sj8NLoNJ5T3COsIXbo=;
        b=E/FgsI/WcNbBfp6ar2OkaJZ3Vh9mkuQJ3vygZJ6VsfT0RnPhycTusZsDiqkEyB/h5f
         fhGnQMx+igsjsi2ZyiRmsTzerhzfI+KEeBc5GBNzAAcbmu1tH1bXmepwQI2eIYcRu858
         PiTNIO5I+c5CU4VxofXTT4uokxUqbkNiI61jobgeHZlm2mIDUoUlBSDxDk0EisUWZQyt
         bEgwCjxkQtA9aTrtnQqFPpx8ILeI6vqUhNcvkUEIm/njPyDTYP2L+cm/W9fcJ8U0yL2P
         V6y1A+kvo5RdOdgsvF9Tf7jAWQS3Wv38ol2YHnWzikjYQgtGKD2Q3YTF1tTzmSVI833I
         Cmyg==
X-Gm-Message-State: AOAM531ETejBCQcDa0a0fOWxDPGS6BDtkhx4EYq/Yc44u5E+CfNvHl6Z
        hKsJLhvFstPTnz2/lCEb+lM=
X-Google-Smtp-Source: ABdhPJx/XM86EArrxboH11zKOVaD+R2oMeqqs/A7FUjEu6ib5U8D1GIwOnZn1OpRvYcKXvwCI8mq3A==
X-Received: by 2002:a17:907:1c20:b0:6f4:639e:9400 with SMTP id nc32-20020a1709071c2000b006f4639e9400mr23735888ejc.485.1652270394903;
        Wed, 11 May 2022 04:59:54 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id g6-20020a50d0c6000000b0042617ba63aasm1089279edf.52.2022.05.11.04.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:59:54 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: imx6qdl-colibri: Fix capacitive touch reset polarity
Date:   Wed, 11 May 2022 13:59:07 +0200
Message-Id: <20220511115911.54960-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220511115911.54960-1-max.oss.09@gmail.com>
References: <20220511115911.54960-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

The commit feedaacdadfc ("Input: atmel_mxt_ts - fix up inverted RESET
handler") requires the reset GPIO to have GPIO_ACTIVE_LOW.

Fixes: 1524b27c94a6 ("ARM: dts: imx6dl-colibri: Move common nodes to SoM dtsi")
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- Added Fabio's 'Reviewed-by'
- Removed blank line in commit text

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index c383e0e4110c..7df270cea292 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -593,7 +593,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_atmel_conn>;
 		reg = <0x4a>;
-		reset-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;	/* SODIMM 106 */
+		reset-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;	/* SODIMM 106 */
 		status = "disabled";
 	};
 };
-- 
2.20.1

