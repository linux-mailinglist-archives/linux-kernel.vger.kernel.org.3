Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBF51B863
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbiEEHHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiEEHGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:06:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC430424B8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:03:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v12so4770476wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfZ3ZePVs1zizifKFOCKdtP4owCke/xt9ZozThlShL8=;
        b=sUKmqDeLUlbnwYWcHGCCTwFM6OxAYGp/M3asB/xn+YqzZAmsxT2CbvEKXN73+VZ4N2
         k3SGgx+QUrO8bAmOmuFUKOfUpPYwtoEzn1nhTjYcIB2Hko6zoe++oggqb33ooONyDMhQ
         ad3UWqaSNYZ0ztIfeODcJQVubb6aGjEXHPmK3w4VHmg+UsdID2jnczga6mhfF3evBgBb
         Os9PX/fOySWg3W9CP8BQJG98QHzL4geytfoSyqfpVDF4sPcyE84lWcZK6KCMxPhN5eGL
         d4ORixgjl4umEjmaMOg5ftvZQ3mjDa57jKaMI5dNaClDcJdGADDX2jW8ZErxZqrNB31d
         1fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfZ3ZePVs1zizifKFOCKdtP4owCke/xt9ZozThlShL8=;
        b=7t2svzKzoEcgvvtQpSJeIHEAWCh8iycNimQ9w0RiJ+/xyfDifoGJN1vXvL5vJl0uyV
         bMx85xeh6dlT6wR/sLHj6Nv+W+86zVCFCg4gZSrxCSx78Vk9Gzc6yyYVHdkBPqNU6036
         /WC2ue+GYFNwbCyfElLYhYTJhh2BqHlVa9ub/KU1JXn3vKMwEb85226s5xyoF7usINjh
         Wq2ZNHGFgQdJ3X0JSjHXsNFCMi/FPm/AchEB8MJ0OUbUNnOJoDg4znqEAs2KxIN3UpI7
         aFv+uQlHS50qp0di+DDdq/U8lY+zRxMjc9NhIhT0ZGD8UhPLuxEkFQrYnP+2oMZIdpeC
         r6nQ==
X-Gm-Message-State: AOAM530wYZNQ/i8lU79+UCKXOcdN85GiQlJ2xZFZ/QVlMwp3HcrlEoAT
        GzBtcOTkUdxcKbd8zD6YGFETWA==
X-Google-Smtp-Source: ABdhPJzxqJxw5vDooWxiWTjg+cFR1uj+e7cZJwS/W4TlRcrQrIVljaF/20ohFz5pVK5+RhVQ55tcxA==
X-Received: by 2002:adf:f504:0:b0:20c:734f:d39d with SMTP id q4-20020adff504000000b0020c734fd39dmr9547097wro.717.1651734192506;
        Thu, 05 May 2022 00:03:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003942a244f47sm6233739wmk.32.2022.05.05.00.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 00:03:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: dt-bindings: samsung: exynosautov9 for v5.19
Date:   Thu,  5 May 2022 09:03:08 +0200
Message-Id: <20220505070308.29863-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Hi Sylwester,

Clock bindings for v5.19.

Best regards,
Krzysztof

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-bindings-clk-exynosautov9-5.19

for you to fetch changes up to e61492e47838f4d99a3ffcc591ba57d1d5d0896f:

  dt-bindings: clock: add Exynos Auto v9 SoC CMU bindings (2022-05-05 08:58:38 +0200)

----------------------------------------------------------------
dt-bindings for Samsung ExynosAutov9 clock controllers for v5.19

The Devicetree bindings for Samsung ExynosAutov9 clock controllers.

----------------------------------------------------------------
Chanho Park (2):
      dt-bindings: clock: add clock binding definitions for Exynos Auto v9
      dt-bindings: clock: add Exynos Auto v9 SoC CMU bindings

 .../bindings/clock/samsung,exynosautov9-clock.yaml | 219 +++++++++++++++
 include/dt-bindings/clock/samsung,exynosautov9.h   | 299 +++++++++++++++++++++
 2 files changed, 518 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
 create mode 100644 include/dt-bindings/clock/samsung,exynosautov9.h
