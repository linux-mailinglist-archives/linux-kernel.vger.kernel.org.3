Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8C50FFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351210AbiDZN4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351202AbiDZN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:56:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1237F15CF52
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso1581311wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7C9NN9G3/VfFHK1hDC66w+I6RP44XESXFga9fGsvyQ=;
        b=tvheqM8129dHvRZRBu7eeqqeRCM5zcWIoyp0MYoLVisR2OMbV/2v283zxjT66rouye
         5avtcvaH1yVKGh15dLNfmXNusMYxJ7mg1wJP9YPUjf/JBKol92NH0gKtznk9VC7U0EHQ
         ZUpIsqQ87rA04mqnsXj8oO+DUAZUDlBBS+5C3dE7K5ecyOVx1gztKy9lZnCuTQ+3Ycrr
         +mWdc13Bo1NsQmPmH26x6IYKM9ttZJNOfWy6g2/rl1nwE7flvbB37anBZuwswHt/9ILT
         XRrcN27MzUu8wcjBCBiEEwA5B6dmJiRDEO+L+x0rvKESJVNUzyDSTjS3XG9eQ1Ut+i50
         2kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7C9NN9G3/VfFHK1hDC66w+I6RP44XESXFga9fGsvyQ=;
        b=gnm2j3sUGirZMVAgR32sYMio0bfprDigaFTSyIIJMv8kIS1tuOuiF7S1dohHd6XVAG
         Xp1XEdQGR+pVw1UQpURbotelNy7320ktoHkeTChhUjB0MxZV+7xj0PDSi2PkLAZEKMGl
         X84AgqvBtUNfBWMXLlNzK9P8XErlraKk+a/GQTBd1CHBmOTqqYm/IT5J/lmdLjNINHih
         hsyyGUU5Umv3C7evClHgwSuMRwDBoOmRSYkgK+/9ftX3OjeGZMqfbTVBXP/+Y79fl1z4
         I74PUVmQQh/DxpcB8hjEQHoiNP6geUShl/mRo2BdrtAfrRPD4n612+9QPKKMRcKhv6aj
         MdPg==
X-Gm-Message-State: AOAM531Uz2yxAFLmOdfGMgasB+lfkNCPBbxvyqUoztIyaN+ePHoOnxrj
        v+M6byuhlvo+2gslG2JdiGCG5w==
X-Google-Smtp-Source: ABdhPJw0ZGVy+y/bwlTwEjpHrS4+Dbi7BbtJsqhdkSs7+FHhkoD0AQ/BVfojKRZ5IKflw2xirTOtSg==
X-Received: by 2002:a7b:c84f:0:b0:393:e729:e670 with SMTP id c15-20020a7bc84f000000b00393e729e670mr13275808wml.153.1650981209590;
        Tue, 26 Apr 2022 06:53:29 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b00393ebe201a6sm5504775wms.44.2022.04.26.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:53:29 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] mfd: add missing defines necessary for mtk-pmic-keys support
Date:   Tue, 26 Apr 2022 15:53:07 +0200
Message-Id: <20220426135313.245466-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426135313.245466-1-fparent@baylibre.com>
References: <20220426135313.245466-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 missing MT6359 registers that are needed to implement
the keyboard driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: no changes

 include/linux/mfd/mt6359/registers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mfd/mt6359/registers.h b/include/linux/mfd/mt6359/registers.h
index 2135c9695918..2a4394a27b1c 100644
--- a/include/linux/mfd/mt6359/registers.h
+++ b/include/linux/mfd/mt6359/registers.h
@@ -8,6 +8,8 @@
 
 /* PMIC Registers */
 #define MT6359_SWCID                         0xa
+#define MT6359_TOPSTATUS                     0x2a
+#define MT6359_TOP_RST_MISC                  0x14c
 #define MT6359_MISC_TOP_INT_CON0             0x188
 #define MT6359_MISC_TOP_INT_STATUS0          0x194
 #define MT6359_TOP_INT_STATUS0               0x19e
-- 
2.36.0

