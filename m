Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D754960F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385978AbiFMOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385910AbiFMOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:44:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51B3B41DC;
        Mon, 13 Jun 2022 04:51:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v25so6754374eda.6;
        Mon, 13 Jun 2022 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zgX/PVEPf8nMw9zVAy2wbzfkUCGcHSawa+uHP8BTd9Q=;
        b=W0U6MAI0+IGC5YwFTD8F834ELZTvP7B5fUkYdbdyuxf0nQu4SdET6AOTpyLBIeqGI4
         gIS9CHA+sbJFRkAhQC30VY8LVz7DnVV48C508IaDcJXkUp6ai4kCIc8i5K2fZ6sB/nO+
         hcfYVV54+yUh0QOQs5dFwnoUTelOGVKVrN86EuiOaXj64jRdErGVFRbTPe+icFNxNCsL
         oyBkAf3dCzi+g/+RiGvtc58+65OH4uIJ2S3OstdxpYJx/PMsxIOEnvF/pl/fA1RmiQ4X
         TZb2Kf3qdDtosTlCPhRiFkJpb2U4ii4INFWR0pSbFBTqMTW7m+0nLByM3mnZb4lNI94f
         mDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zgX/PVEPf8nMw9zVAy2wbzfkUCGcHSawa+uHP8BTd9Q=;
        b=0KtzXGea8ir2QQ0c1uh7Ve7bNSTtE3jzV1Z2Z4N4+LAwUMLqg6dqeIeLjEFtslZtZ2
         pToj0E2Lp57SjXdMBtRouzs28pQz8BQ8QjC8zbn92K08fgGyHFwRbXdAEsO7baJTiizq
         8c30AcuhN3c7P6IjY1MDPgBR8NpozYxAFpE41DBJAlSg+fi8k057LkfdyyoHNb90oraN
         NT4axKBfe8eDJQTtKMCiT/MvvG2lY3egir/4VTsnWhiU1TisDd5egzk2Wo3leBVD1bld
         XO+CGwCfIfgHC9whgg+wKf3rmgIv+VVGn2xlRc+7qli1Oh11M0WeXAVvqG+KBUxhTwi5
         r4PQ==
X-Gm-Message-State: AOAM533MRhmHjZqi/7z9wemTPHvwTaMkz6nQQFX4u/vND+U4+5dcxkjt
        5php7zIgIKi3hIn4vTZlfiB9Hm1AckE=
X-Google-Smtp-Source: ABdhPJxeyfxnfKceAb/4rg82X1D+qsKnKPtx3yG4v5B5zF0L2yMkiRBXOD5V0dybGThWRkSMqexNCw==
X-Received: by 2002:aa7:c34d:0:b0:42d:ce57:5df2 with SMTP id j13-20020aa7c34d000000b0042dce575df2mr64383362edr.315.1655121061007;
        Mon, 13 Jun 2022 04:51:01 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906308c00b006ff0b457cdasm3734771ejv.53.2022.06.13.04.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:51:00 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/iio to IIO SUBSYSTEM AND DRIVERS
Date:   Mon, 13 Jun 2022 13:50:45 +0200
Message-Id: <20220613115045.24326-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/iio
are also the maintainers of the corresponding directory
include/dt-bindings/iio.

Add the file entry for include/dt-bindings/iio to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Jonathan, Lars-Peter, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b8aec742e6e..503b8042784e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9656,6 +9656,7 @@ F:	Documentation/ABI/testing/sysfs-bus-iio*
 F:	Documentation/devicetree/bindings/iio/
 F:	drivers/iio/
 F:	drivers/staging/iio/
+F:	include/dt-bindings/iio/
 F:	include/linux/iio/
 F:	tools/iio/
 
-- 
2.17.1

