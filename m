Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFFD52761A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 08:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiEOGll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 02:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiEOGlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 02:41:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C2205FC;
        Sat, 14 May 2022 23:41:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d17so11681187plg.0;
        Sat, 14 May 2022 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=za5/t/5KkYioKJmzQzgENeUXLSS16uofilAGGJlszx0=;
        b=JIiqOt/a5TLUxVNH3f+ZwfWJO8Czg82ArCJvX9a1BU9r/jw8PHKg18U3FcmQ61vvIy
         atBIHlFwZhJ5A+mz7JxPRD+zHsuVtT20GmhFUyETDgSl7ldVMBYe0Ov5gnMpmJ4d84Y4
         gIT7ON6YRGgd8rAMhUWCYhYJFVb01/FZPb2DivWo/oh0yKxDUd6ZuEuqNCdkmLuLk3Tg
         pTDqwxGg6qclpKFtJ5qE4SpEymtuVl5K+fmMHHlSNkQxO8h65OCLJqkUxcBJVOeCFtAs
         HjnFte50TqNU8zmsI2NNaxNrIe5jdApvdl2A+gwq0BnK4LhW8vax/JmUnoKCalRGUesh
         Mk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=za5/t/5KkYioKJmzQzgENeUXLSS16uofilAGGJlszx0=;
        b=oaLQeqG7nrIcVhZ/66qYoNeNs064TdlHxWRjQ5+INN4rrg4/up4k/ufTpc2WlLUhvf
         rhRZdiwTTsZ1UXUfoifIYgjzZ7Cy1BUyfKANAdFQr2zQdSPWmmIQEVFctot+H0Y9w8fC
         7YNT7WT//ctbreDpP1BLuNNksqa+/L4CvtXTkH7mJNpUPYkfPToInqF++k3PvR2zaaGZ
         u6hB6B5FpYx53iM20h7KQ95IrUT2yuO6dWhhCJXkQC3BK5oh6hzYKa8j0xgzogw3VYMH
         w6OgBcZHgIuwm6Blgp6CLeJx0QdO16JqMnD7svbDXOsdoLRaVv9l9Jo+1qWDdXTgsjYH
         PrxQ==
X-Gm-Message-State: AOAM531wP16ZP6uVnmKh0rx50evWScl+EKJhL0mlV9ut8WWziy3VQbze
        60kkYJ/U9GDj8+OdZMsTw9Q=
X-Google-Smtp-Source: ABdhPJzsicDTzI+l/ZT8QLsaVDoMbxnsSTLq4wrbKMKpwEb8IsE84lbV283DB9Ckmk7g8xHwj1suDA==
X-Received: by 2002:a17:902:c404:b0:15e:9aa2:3abc with SMTP id k4-20020a170902c40400b0015e9aa23abcmr12164063plk.172.1652596894372;
        Sat, 14 May 2022 23:41:34 -0700 (PDT)
Received: from alarm.. ([103.51.72.28])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902d5d800b0015e8d4eb2e3sm4568687plh.301.2022.05.14.23.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 23:41:34 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv2 0/6] Exynos Thermal code inprovement
Date:   Sun, 15 May 2022 06:41:17 +0000
Message-Id: <20220515064126.1424-1-linux.amoon@gmail.com>
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

Hi All 

This patch series is bit of rework on my previous
patch series [0], where I failed to justify the code changes.

With this new series I have tried to improve the commit subject
and commit message.

Added new patchs are added to improve the PM suspend/resume and 
added runtime power management support to exynos tmu driver.
  
[0] https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#m77e57120d230d57f34c29e1422d7fc5f5587ac30

Best Regards
-Anand

Anand Moon (6):
  thermal: exynos: Enable core tmu hardware clk flag on exynos platform
  thermal: exynos: Reorder the gpu clock initialization for exynos5420
    SoC
  thermal: exynos: Check before clk_disable_unprepare() not needed
  thermal: exynos: fixed the efuse min/max value for exynos5422
  thermal: exynos: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
  thermal: exynos: Add runtime power management for tmu

 drivers/thermal/samsung/exynos_tmu.c | 107 ++++++++++++++++-----------
 1 file changed, 62 insertions(+), 45 deletions(-)


base-commit: ec7f49619d8ee13e108740c82f942cd401b989e9
-- 
2.36.1

