Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3F95684C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiGFKIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiGFKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:07:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEC72559A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:07:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a5so6624307wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VXqaWJ8WoOSc1SxcWkI6kncF/qz5EI0vW+2YRGLKoo=;
        b=vHsCWz9N3GSv6V4dEMOLoqUeRwkijaP75hVjxOxp6MkYrSlBL43TRRC1z+TBAQ39Ue
         BSWbXiHKMb/RfaJCrzKQL4GPo/NCFHpNfdP5x7QA4EpKeEGfMc8GjParMhLXxCuz1PTt
         XbBKSN62B4QiZ/I8yZTurnxqN1n7umzdN6vvNZXIeX76qS/06izMsvpBmxz3HWBVRP7A
         cbU6jYz9iCf9yfRBbYQby+0ukB2XPFvXIZnRjBUfAgnYmvle7ZUTX6CflY/gNZBX0o7f
         kU9eWQoz8ZeNbKLQQDgS1i84SVDcQozPZ1fsKpQ6BY5Ba1E1uftr+XWwJVxgPP2a1b5Y
         aq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VXqaWJ8WoOSc1SxcWkI6kncF/qz5EI0vW+2YRGLKoo=;
        b=w8SfqfLQ2IId19x3i1PyhvwIF7DWn2VXUlfzVVx76GS++25DDzuGjAz1iuodmOzlgR
         lb+qP6kwS9eckDexNfasjOBJiPBk721gmsrCMvt8tlfAeUU67o4X68EjOmUPkwEo2LV6
         UbApNGcQ8ynK7QSohiTnC3JVcrzzR9rmAbjc7hdsuegzJt5ukAWuhCrzUgJ5K5jv2tUq
         XnjqYkzeXI4dxks5kuguLl4X5L6ivIL3BBpFpiDLN/iWWCaHm/vGFyD4PkK9IMqIo151
         DJOMHnaJaBUelrLWpk6FLMDKxDoOaRBZBqMYay7K3HdZr+RmlaO8zOuTwEJubVAAOQxV
         NwWQ==
X-Gm-Message-State: AJIora/c182/BuXgHK/PiU8cpKIr21MkhjVAcVZIY9NGU0BheYRxziVO
        ILvXLHXrwH1rcBkQix9ukCzvZQ==
X-Google-Smtp-Source: AGRyM1tpx3F5OSglEmlGdgOAtS4Hu68rjCbgZV08SaZ7ZZkQSPUs9qXS8WUCI/bgXkFkZ/M4XdVhtA==
X-Received: by 2002:a05:6000:911:b0:21d:2100:b97b with SMTP id bz17-20020a056000091100b0021d2100b97bmr37096472wrb.649.1657102050849;
        Wed, 06 Jul 2022 03:07:30 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm24678143wms.18.2022.07.06.03.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:07:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/7] MAINTAINERS: rectify file pattern in MICROCHIP OTPC DRIVER
Date:   Wed,  6 Jul 2022 11:06:23 +0100
Message-Id: <20220706100627.6534-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
References: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Commit 6b291610dd57 ("nvmem: microchip-otpc: add support") adds the
Microchip otpc driver and a corresponding MAINTAINERS section, but slips
in a slightly wrong file pattern.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Rectify this file pattern in MICROCHIP OTPC DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e51eeb0ee0ed..62a02b67db25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13106,7 +13106,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 F:	drivers/nvmem/microchip-otpc.c
-F:	dt-bindings/nvmem/microchip,sama7g5-otpc.h
+F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 
 MICROCHIP PWM DRIVER
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
-- 
2.25.1

