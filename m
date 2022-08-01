Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF358628E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbiHAC0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiHAC0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:26:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B89E62F7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:26:10 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e132so8513313pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PGPoTv6GaSJYTcgwkkWLngBLJeUf2HiIpsOYTiH2aGU=;
        b=SGBayujYFMPCcUgLpNiZr2DJqiC4+TXReE+bspZvK+ulRheGN/G4r7AV5jIsRdyyI3
         K19mif/g/TiqROFkwTPk3YHXZmhU2Vn91Muk+88OC9Rgk3wKuf9XszUuXfLlHRWYDTy9
         FI/DkwIkrIoA/noXJrIGRXJBx9QZ+hH1VqTt0OHyhAYjxtm1ETAaN3aEzyBtwOecQ0Hu
         iaz9jd7WrK1xH/CxdSpkmaGmi4HKSjKtDE4XfCNwmqXjwh5covjK5aToXkrCy7v5DW5Y
         bqEPbEY2gRmK54LCj3++fF0eQ9QVEiZsQDC7EtHFb8p+zrATNqO3jodIcmySTtA5IgQe
         T47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PGPoTv6GaSJYTcgwkkWLngBLJeUf2HiIpsOYTiH2aGU=;
        b=oTgrYbBvwIz6NOLUw97RueHc5OXqJblcNcoHzR93Fjj0R9tmEzXkxttOH39fNE+tgh
         FbXqK5m85t5pmg8qY4fxmZJO9HHIMvaGNK5NsUlvbledIGHkG6/e92aPosfk4Sn4FJ9g
         XA4ZsMgba33vOVP20uOae8AruR+nTEr3vVu67RC8SS14mAVR102g2Z9OnTna/gczY6e4
         s4fehglXgoGDJmanapSiQt9tcYTbK5kjIPBwy5T+jZ8HncERIiY0Qyphvxlp8daIg6P3
         xW+95r9IZBjXJvY+Lna+IS6tUurVIuspidtoFC+Gc0Z16U7000SgOod0ZuhVmDO920v0
         2T2g==
X-Gm-Message-State: ACgBeo3tha4BlF2Kut05ipV6kcDuYUDnvFXmN+PRtTx3bCtTjLkVL/3Y
        gwEqq2m2OhyLuku0O94cdOWD8EwSiMM=
X-Google-Smtp-Source: AA6agR4BOEC0xZ6gi11S4Xf5izXQTd8uFKyCfgN3GZxsslVpi8gOnpm303h+0/wDALDLqOyNMoArPQ==
X-Received: by 2002:a62:1808:0:b0:52d:9eeb:8853 with SMTP id 8-20020a621808000000b0052d9eeb8853mr193350pfy.45.1659320769935;
        Sun, 31 Jul 2022 19:26:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y38-20020a631826000000b0040caab35e5bsm6347339pgl.89.2022.07.31.19.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:26:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm:amd:Remove the unused conditional statements
Date:   Mon,  1 Aug 2022 02:26:06 +0000
Message-Id: <20220801022606.1594526-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Conditional statements have no effect to next process.So remove it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 63861cdfb09f..84c66ce44da4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -2132,8 +2132,6 @@ static bool dcn314_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS)
-		dc->debug = debug_defaults_diags;
 	else
 		dc->debug = debug_defaults_diags;
 	// Init the vm_helper
-- 
2.25.1
