Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CCC56AC0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiGGTqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiGGTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:46:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6092BB18;
        Thu,  7 Jul 2022 12:46:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u12so34175562eja.8;
        Thu, 07 Jul 2022 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UB7bWLpN76PQbdxMQ5VYzrQ3FPvdWLLOGLWs9LTQXic=;
        b=IcqaBb2YZi0XPrxjT0Sw3FEEa7o2NltgcsxgfJOa6eovx2O0PvWc1ZX3/qRUViniQ2
         6UUqPzsjHacGXQ7IqSY9/Q4UoOEPxTjSyvqlwFfMmIUAsUfuUpaZFnqIuy/2E7+nPBEC
         7tD33Cpqx7bBSosH5S8/2tmKU2xJZed9UMhaQesXyi6xus+1VgjWwyj2Kky3o4eHOGWJ
         XXkTmNxHoboITxJ5b0kmnPGMsvkrO9VynKU8i+UYPnZ9qXbx9ikGzkbu7BxWghaIezjT
         6q137WQVjfxbO/GevLujXIPtjveFeYlhi9N1jU17jH9UY9+yrvLJZGRAbbS7heCLktv0
         YkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UB7bWLpN76PQbdxMQ5VYzrQ3FPvdWLLOGLWs9LTQXic=;
        b=N6I1TGK1Sjy7aT3rYCIAYZXnotaQqLy8XL7mmK48HdZrGxFiPd3n2Phd0+esauklsR
         iE9YDVwcRtezxNmR57ROPLQXiG4rvkVCEAtDhnyLsdglSKf7kMDCVcnkgo1mERrbR4q6
         VgdD32vYoY9cRTqfLSnFMTGNXB+UDVat8RuRoFo+9wKLCTnLk+no4mDs9ZuEfV0SdZsm
         Osg0iEMwNaXfDzGH1gYduiP1vjPPj+j0RkIDFQsP4pF2tZqc8r+tNhlVx8sl+e50nyKh
         ST/DghjV8JiZn+O5FmKtocBqI55Sz/fr0zBYjUjT5hBR3vKtZj7HjRi8urisyp6wjk20
         dDiQ==
X-Gm-Message-State: AJIora84ZffQjMcZv5EK1TS+5Y7XwnCW/AE2Ph++9sOEVAjxQc65boOS
        NAUk+Iycag5OC82y26qFagA=
X-Google-Smtp-Source: AGRyM1utMV2zsP5LBNoFrrsq2l4p2TqWZmG7Ipnb3c+GXRect6ryZDKwCot5L1ih/dFNuD8HUw1NPg==
X-Received: by 2002:a17:907:7ba8:b0:72b:1491:c73c with SMTP id ne40-20020a1709077ba800b0072b1491c73cmr3123832ejc.415.1657223200530;
        Thu, 07 Jul 2022 12:46:40 -0700 (PDT)
Received: from localhost (92.40.202.166.threembb.co.uk. [92.40.202.166])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906274400b00726b03f83a0sm15029570ejd.33.2022.07.07.12.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:46:40 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] ASoC: jz4740-i2s: Remove unused 'mem' resource
Date:   Thu,  7 Jul 2022 20:46:45 +0100
Message-Id: <20220707194655.312892-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
References: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
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

This isn't used and doesn't need to be in the private data struct.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index ecd8df70d39c..c4c1e89b47c1 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -93,7 +93,6 @@ struct i2s_soc_info {
 };
 
 struct jz4740_i2s {
-	struct resource *mem;
 	void __iomem *base;
 
 	struct clk *clk_aic;
-- 
2.35.1

