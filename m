Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56662539C51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349583AbiFAEpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349551AbiFAEpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:45:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736549E9E8;
        Tue, 31 May 2022 21:45:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r129so285405wmr.3;
        Tue, 31 May 2022 21:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=UxpRbsB4fW9Es2lqL888yJ7QXf4l6YrZ20jfoXVDxLw=;
        b=q4b8Tjk8UpQ2TXQp9YxJBSMKTh3uotCktHoVhjGzV/CodlyiLmqmQ1pGuw00XOiq3K
         4FpmUFoWVmEtOuQkfqcWxzRaeT8ZTzXsa9WPZ5G9iyc4ySa6oUrfRxRkl0aohhcgrbzQ
         kgZi4ft8/ZEeGo9b4I9p6n7MXFrlPwMBoBDK3N3PlCJnj00MfpGPg5jBj0LgglYvIJnd
         DJ6+pbP1ELdopkCtifkoXaJvl5gYwrbyCeidF9mJ3kdN/wQ2hgNFRPv9YDJMwKu4QHrA
         LGUD2mSGjcQBr43d7E3nQzGvt4CO20TJm2K+GNj+DPE8DWbEe16LG5WYvEmCOykU7aul
         VqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UxpRbsB4fW9Es2lqL888yJ7QXf4l6YrZ20jfoXVDxLw=;
        b=4SlTKumCDjnSgt5M9qHPEvsCjeO1OWixtr1yJSE3WwnooycUhOF+cYUgqmW6E9PUDC
         RuirEf3/nKjXWd8jIGumFHpBdtK50hNi3T6BbVWAFE2NDqEjibI5GpFSmFGhCR3NOPyM
         iC417+BSRBBb5tliL/iFY59RvF22noBA01R//dXcILkTVoZ2/XNGTHJQbxjye61SlUkM
         RLQsFO2xawFyIjztt9AYG4OdDefYTdozaaSlz7dOLufZcyxNeEK3QrPuRxx23eQQliMM
         eSdSk9NHRhWBvbcHlZ246Tiooe4vttKxsgg7KBpIl/h01cSghEdsjR65BFRux3EF+OM1
         ketQ==
X-Gm-Message-State: AOAM533TTQ9kKdBttGNjIuw8AeHTml7O4k+uOiPPG+mbB25FQyjh3uyO
        qL3QcDKlIAHyCw+7Bc3OIr0=
X-Google-Smtp-Source: ABdhPJzpHyayVSJDL7wlT5GxcWKpvoD+twBMaZRJ+1JROIQ2naE3mChhbKYDbvR++VsJb9EI8hi6fA==
X-Received: by 2002:a05:600c:3d8e:b0:397:73e3:8c83 with SMTP id bi14-20020a05600c3d8e00b0039773e38c83mr26213646wmb.29.1654058699805;
        Tue, 31 May 2022 21:44:59 -0700 (PDT)
Received: from felia.fritz.box (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de. [2001:16b8:2620:c000:28af:8878:8fa7:d286])
        by smtp.gmail.com with ESMTPSA id a5-20020adffac5000000b0021023877ac5sm390427wrs.107.2022.05.31.21.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 21:44:59 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] media: MAINTAINERS: rectify entry for DONGWOON DW9807 LENS VOICE COIL DRIVER
Date:   Wed,  1 Jun 2022 06:44:45 +0200
Message-Id: <20220601044445.11943-1-lukas.bulwahn@gmail.com>
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

Commit a1f4626b282d ("media: dt-bindings: Convert Dongwoon dw9807-vcm
bindings to json-schema") converts dongwoon,dw9807-vcm.txt to yaml, but
misses to adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in DONGWOON DW9807 LENS VOICE COIL DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mauro, please pick this minor non-urgent clean-up patch for media-next.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0f5895feb6b..88fdf39e6bb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6078,7 +6078,7 @@ M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/dongwoon,dw9807-vcm.txt
+F:	Documentation/devicetree/bindings/media/i2c/dongwoon,dw9807-vcm.yaml
 F:	drivers/media/i2c/dw9807-vcm.c
 
 DOUBLETALK DRIVER
-- 
2.17.1

