Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B553D753
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiFDO4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiFDO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:56:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F3B2A27C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:56:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y19so21031340ejq.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bBiPYM79vONonj3TgD/MbvMpz2wrMcuYxKky6Pb/e8=;
        b=NlfzZ2gLHywxtcQmlls+yDBWS+RVJcRs8i/ai0yxYMSnhRcBt8mhodvt866BNIdXUN
         RedDiY/yhahRYAl2pTNkB5NfYoao7Q+DGNiVSKoBzJVtO9QYeoe1sQzh9vdbNgnxRbSC
         mPVdkuJyMJrhjZAnU+dQJidtN+zGcRVzwmLxdm/Dyka/Pl8CD8YP2iW+1e86jreSQbBB
         yMJK202oKCymcj+9j7ssYHoF0xfU1U73SGuyeyEj8AcYfgipwZsq+AZ18mEC2MY9+UkA
         fzoxEqPOhFA8RiDtJ58Bklk0wmIOV3/GTny3kwyQVJ+2EIYWDuozGqiiinwnN/eCQoTJ
         b0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bBiPYM79vONonj3TgD/MbvMpz2wrMcuYxKky6Pb/e8=;
        b=IGpLWwv7UPJuLNxgZGWAJMAFbNJhSg/RLHu9wmQasoHay4rD09DGXXdSR78LK/RH+7
         jfPNlvNkb4N5qNklqFHrqo5OVdF3ekTTxX0s34xT8tVQ4+G0Oba0V+ptdafiR/yvVRng
         4Cw4148NIw/YPLpTitiGlObOR6FRHAvTh/szozfBPnqHljCxSn0tf4v9ZcOG7L0UYzea
         lrFIdmEHInS38Ax0dvakGkrL9xcGIBM1G9PIzHwJXpjs28dYuWADq1zeyMYmnpLwNR1J
         uAQZlTdT99rwdxYEOGcXoKtJDDh6DtwQqoJZeesok/44n3jGvrw/wyg/vByTHgEMN+Fg
         M0Pg==
X-Gm-Message-State: AOAM532hNIcSmJWqRyaHuN0wjSkaSdWaq9MnH9u6EXM6w4JBWWrgwBb9
        htMShJq+klfaLE+qU6klqzg=
X-Google-Smtp-Source: ABdhPJzayKcAkpBW0W30KR3Umze5+ofZESlrgAl9i0lyko4jluMJch9aRkhO7yy1mvE8C+LSxUgC/w==
X-Received: by 2002:a17:906:b048:b0:6fe:be4a:3ecf with SMTP id bj8-20020a170906b04800b006febe4a3ecfmr13519729ejb.104.1654354588046;
        Sat, 04 Jun 2022 07:56:28 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id j15-20020a170906430f00b006f3ef214dc7sm4175960ejm.45.2022.06.04.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:56:27 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/3] regulator: mp5416: alphabetically sort header includes
Date:   Sat,  4 Jun 2022 16:56:22 +0200
Message-Id: <20220604145624.47326-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

