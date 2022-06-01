Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD6D539F52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349033AbiFAIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245162AbiFAIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:22:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C79F29A;
        Wed,  1 Jun 2022 01:22:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d26so1217651wrb.13;
        Wed, 01 Jun 2022 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=dad+Xnw9+BHlkOfkwEsvmsktADHpLQsOI8/Vmibic24=;
        b=c98fkegfP4WbFEarCBtHXwEwdDPMnZVn39M8+BWshFOHcUHEJwReSogoazpYM0NxBv
         FB/50t+bZUTZAHTpLPtHjUbO/+8CbvecVrEiIKekPQeohACMNOnK+533LH0I5J/tLduZ
         gAlRsxTpBkbS6eEcqLd1ngVtg/dQqC4fo+Hy4ZvT/e19LpyZVANDdXT3yLK6suXGQYqm
         7orH4/YY6aMgsvGAjQjRUMahnNmILEc4sx8wBlENpnSJIzo2XBjf4VY9x//AnA+OOTse
         dgNO9yoxi7Q8Akv5kKk2FJ8Pz8KXc8pD4zlKSN2/Y2jRREtNG+bZycMDMYHIhTNrqaug
         3qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dad+Xnw9+BHlkOfkwEsvmsktADHpLQsOI8/Vmibic24=;
        b=ixKfNmXHpNKMHJTIiGkhEhiFPzqhj8Auyh8m7i4LEHwtSZ+hxez5F+rTUf/vRJOgpp
         Akx3Izkgq9gydQT+FVkBXQ094SxkDa7yqa7RvZx0wQez6xCDAYBdZLvMa+C5zCEtJD+G
         U2Lm+tfEXciIgj714SpfhWDjxFTjkPmFBJf7i28Kae8+GAe/zYyuQ7AEWMQiPW4RB1k+
         PaeiABUdC8vUjayD6BD5UYoNhGYWrsxXngk7RfRoNvNBuVyT5336I60+ZuitHxF3JoXG
         A+mKN2gIn0qNrID386nWJCkmA5eVIwVavxH0jwyVcRFA+LAlopzhSWZbw/jgC/KuE6ad
         UR1Q==
X-Gm-Message-State: AOAM531vefXV6pgDk139nu6ucMC1Kbc7E5AFMPHmpkw7Zski1ukKftJT
        sJZrixtwVc30QCiBcdeCkwbZO6K17+Q=
X-Google-Smtp-Source: ABdhPJyOalmR16SA5iW+2FehIi2Nvq77503ZWvxSfyIlOQ33ELNRszClzg8J/YrcJNnEkVK9KVdaCQ==
X-Received: by 2002:a5d:5887:0:b0:20f:f354:981c with SMTP id n7-20020a5d5887000000b0020ff354981cmr33120018wrf.285.1654071775728;
        Wed, 01 Jun 2022 01:22:55 -0700 (PDT)
Received: from felia.fritz.box (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de. [2001:16b8:2620:c000:28af:8878:8fa7:d286])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b00210346cd0b7sm873957wru.101.2022.06.01.01.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:22:55 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for SYNOPSYS AXS10x RESET CONTROLLER DRIVER
Date:   Wed,  1 Jun 2022 10:22:39 +0200
Message-Id: <20220601082239.12009-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 820f722c05dd ("dt-bindings: reset: snps,axs10x-reset: Convert to
yaml") converts snps,axs10x-reset.txt to yaml, but misses to adjust its
reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in SYNOPSYS AXS10x RESET CONTROLLER DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Philipp, please pick this minor non-urgent clean-up patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc12a3aaad45..36eab5ae237d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19232,7 +19232,7 @@ F:	arch/arc/plat-axs10x
 SYNOPSYS AXS10x RESET CONTROLLER DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/reset/snps,axs10x-reset.txt
+F:	Documentation/devicetree/bindings/reset/snps,axs10x-reset.yaml
 F:	drivers/reset/reset-axs10x.c
 
 SYNOPSYS CREG GPIO DRIVER
-- 
2.17.1

