Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F1B53D75D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiFDO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbiFDO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:58:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EFA2D1ED;
        Sat,  4 Jun 2022 07:58:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v19so13499294edd.4;
        Sat, 04 Jun 2022 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bBiPYM79vONonj3TgD/MbvMpz2wrMcuYxKky6Pb/e8=;
        b=dP/iprQcoAS9P5VtPU5/h4v7JhGRUmGTGXxlXpkn6kq1mMJShyxzICSdDccFNBswQO
         7oBbXEtP798VF+h2aEtV5VBsCPYO9jN9rO5b3iiy27Im6yuPPQyxbBNeDVYr2280oJz3
         cpsNrY0F0Y/3AeeJCdk+hDpx0IoChlC1RQL0seXvMd9R12tBUxCgs8lPhECR0JaubCzy
         UbClFUl21sTk47sQIUgkZEDju1Slyxx/3zNIjoAt7wfmQg/VAcsOOUhsz3aaxk82g00K
         XwNadWXaP7wLM5LrfvvW/VMN38gjTHCodBcyDPre7/jrV2EPXClrwD6qJRybN4Tfec/T
         UMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bBiPYM79vONonj3TgD/MbvMpz2wrMcuYxKky6Pb/e8=;
        b=vzJNc07pZohQMHk4m2QhlMAJZdst/TtoMPgYEY8pI353sMrql/drPx800QEyMVnw+L
         kCpL6oekg5CHooYgRbgCLDE2L32YE2taX0s6wzwtb+2jhLTTSVYCYBACXtco2tPsopfE
         +Sp8yDD4j/k7izYCmeWk3YSfQjcWZ+mTIyHsK+5ErAIgdPhsRJJx7rb7VAk6VOMpuar2
         M5WTFeh3gCpcxGFFwohzbSO1D9yWfQ+N1AnBdvOyXMsG7TSKPu2/zrk2za8Horwov8LR
         GC3uWzU/fiyJh5QMak8RXXRTuRi9BALks/9J9ClolwMs7EsYATLgOidDM3W6jAeQ/fvl
         5vIw==
X-Gm-Message-State: AOAM532z7VMTLCTVouQaDXZneBq4K+CpFl5CVeegHIvjmb6vX+0SFzzZ
        kVUyYyDLomEGXiaSLGLDv4g=
X-Google-Smtp-Source: ABdhPJxvasiBP8wpSoLb5m0rAUBGemsdUDoHf3vP6BHMs+Qr+5k4WFnoymA7lgodBeeFTYyuLcpDng==
X-Received: by 2002:aa7:cd52:0:b0:42d:d656:a49f with SMTP id v18-20020aa7cd52000000b0042dd656a49fmr16978509edw.383.1654354699723;
        Sat, 04 Jun 2022 07:58:19 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm4139322ejb.16.2022.06.04.07.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:58:19 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 2/4] regulator: mp5416: alphabetically sort header includes
Date:   Sat,  4 Jun 2022 16:58:14 +0200
Message-Id: <20220604145816.47576-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220604145816.47576-1-robimarko@gmail.com>
References: <20220604145816.47576-1-robimarko@gmail.com>
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

Sort the header include list alphabetically.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/mp5416.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 39cebec0edb6..d8245080df03 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -6,14 +6,14 @@
 //
 // Author: Saravanan Sekar <sravanhome@gmail.com>
 
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
-#include <linux/i2c.h>
 
 #define MP5416_REG_CTL0			0x00
 #define MP5416_REG_CTL1			0x01
-- 
2.36.1

