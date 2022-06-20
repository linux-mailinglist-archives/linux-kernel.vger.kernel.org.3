Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7AA5518AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiFTMT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbiFTMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:19:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EFBDFE5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:19:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eq6so7532524edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fOxxXWDCmT4VlI0QP8zYNBrVbjnoR1cMpcur/fwkues=;
        b=hqgaT7eqL+ZGFcUrD8UyVLJHHXULrEwZJAYyFIikimThExXDF8jL04sot9bfSVvnHo
         2mfZi8G2AxNJiDmNrzvocoKFgB14UJD8flKjKbU10SaGSyXtmrWGKBfxI/I7tm5WRI4n
         FtypTbHMAOsBKQ6Lhdl0j0nCS45R5X/IM9beuaGlHDyw47KJYMxVDvNWu7K9DWJ/gZA9
         2Mr5G8Yak4svelL/JvxhLTbkpPROixstu8GeciQvm9y/1j1y4fexwzW7LNnkMCzUK3Qn
         4E04Yxma/xSzzFN0SrjYT8pjxw5YzM3nMkk1J2fPq3HPmuTkIGltfERQRqB1lLUu0fiE
         6USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fOxxXWDCmT4VlI0QP8zYNBrVbjnoR1cMpcur/fwkues=;
        b=dXboplhmA59yqs2yB9Bb8WOGtrhuJGjI2ngmuO7BLqx0IoopG2UwsjB+9c9YdvTDf8
         oRnjOcG9gdnmYbpsrdI4VIKLmSxegQq+HsSQZmS2EUAItJ9pxYqqRodzToN6qESaVVYa
         k6tra1Ku3F5/tMkVfCKoLxI/PjnMnsIqGALl6DIxK2S64HWIgobtVwy1JJTrRz7yTvvR
         65SLBQehNFFtR01eFwxkrBckIS5kWZYKVOepVEFwS/inr7gsACNPttNALLX1d3xlv5vZ
         G7XFRZLJhfybiWv4teUml/mvGdvfkkjK3p1VIYDNn55kIIunYJGC9XIilloIpU0j2yss
         v/fw==
X-Gm-Message-State: AJIora+JyxHzt1fEN6WY/7yElfH81DH1KZVMPEnda4mhO9UWHUirHBfL
        2wxxMVAmndDlhEbE6GKJQDRBJei8d/N+Nw==
X-Google-Smtp-Source: AGRyM1tsykB59CUTJb8JLSnlFjFGcmSM6049dfMsto5MK+grNMISh5jWMfyl5ZV3em9S+NMNhWvWyw==
X-Received: by 2002:a05:6402:c95:b0:435:8113:1276 with SMTP id cm21-20020a0564020c9500b0043581131276mr5743279edb.193.1655727595189;
        Mon, 20 Jun 2022 05:19:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y21-20020a056402441500b0042dcbc3f302sm10494892eda.36.2022.06.20.05.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:19:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: exynos 7885 eMMC bindings
Date:   Mon, 20 Jun 2022 14:19:43 +0200
Message-Id: <20220620121944.42942-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

Bindings for you.

Best regards,
Krzysztof


The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-exynos7885-emmc-5.20

for you to fetch changes up to e756e932a3a16418cd8bad757b028bfb337b4a51:

  dt-bindings: clock: Add indices for Exynos7885 TREX clocks (2022-06-20 13:57:20 +0200)

----------------------------------------------------------------
Samsung clock controller changes for v5.20

Add bindings for Exynos7885 eMMC used on Samsung Galaxy A8 (2018).

----------------------------------------------------------------
David Virag (2):
      dt-bindings: clock: Add bindings for Exynos7885 CMU_FSYS
      dt-bindings: clock: Add indices for Exynos7885 TREX clocks

 .../bindings/clock/samsung,exynos7885-clock.yaml   | 27 +++++++++++
 include/dt-bindings/clock/exynos7885.h             | 54 ++++++++++++++++++----
 2 files changed, 72 insertions(+), 9 deletions(-)
