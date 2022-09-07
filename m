Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92AF5B0FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIGWjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIGWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:39:43 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8248720BCD;
        Wed,  7 Sep 2022 15:39:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n202so12679733iod.6;
        Wed, 07 Sep 2022 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZVWLDRAiCpXFvvWvaJuQtquchD9nB6ZRLnRscUbvYY4=;
        b=IJVpCisouaFuMOJ8AjdLXYDTTdE+2N/137mqmBUSjkUVvChX56i/GCqmNuWAz4gRrC
         Ujew8DOf2ggfgEgROhIRAWDm9z1Z3BoHuzKB6Lst/3sfGxS5gCq4tR6QVZEy9nXRsBF/
         Ca/4BZ5HHd+fXKAjlarUQXmVEYGeZxCR8/lBNyVdBMXhv1ri5b/meA3QlP6eTVT+Nabz
         nbF9dZlfmn0VMBYXjZ9YeABKOy86XvLyUkeiqBKEIUI2eWaup/2+Wej+vVWoIKbz8ikg
         JTgsuyGT9xGmY181HKCCt1RNaCMB1HRJl2t0v24G8vAlcS7yhUEFq9rfd6vgo64Ufk3Z
         rpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZVWLDRAiCpXFvvWvaJuQtquchD9nB6ZRLnRscUbvYY4=;
        b=DromrOM2BecC9gWRO9iDGOkuPyYsYW9LQKU7OYydebJ5bnKgRmGOwJuRK8tnuYhkPF
         rmNlSfyaGxIgJeBkOGqG5neTCNtRjuf2rOSY0Yfdw4Smz4CCPnLNuWnxyRwqJZDpZ1vF
         whd3nTsd7BPlk+0Z72SjCma3VApbaVRzQIYh9ypi30K/cjBaoubM0JUBTFFm54sf3Sm5
         87QKDRrGvvwsIRjU1gqsrTtgHQeD8i1xxskUr8woB6eN6S2aehAmWs/KKzKNEmoDs4U1
         dFw9GypuPeiS3/JIiCoskeTtJu+cXfv+52qhA+wiMfAx1MTnfGz6+4grzkgqDhoJqn19
         2mew==
X-Gm-Message-State: ACgBeo1oWkOLYlqyKHMGvLdohhHo7nVVJT8eBs0QAGfmumMPooGZe4w4
        agBK+FJQVAiQS6KipvqdtyVLn5b2Qu/nRw==
X-Google-Smtp-Source: AA6agR7ybdT/ZPNhdjjw5zL9ZQ6lw3VU9S4YrvhCmgGJFFGtfpKO0VqE8wRx1knENbaUFGu+RPsTow==
X-Received: by 2002:a05:6638:1396:b0:357:148d:8705 with SMTP id w22-20020a056638139600b00357148d8705mr2519055jad.61.1662590381723;
        Wed, 07 Sep 2022 15:39:41 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4aff])
        by smtp.gmail.com with UTF8SMTPSA id x1-20020a026f01000000b00343610fb9b8sm7658091jab.129.2022.09.07.15.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 15:39:41 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in
Subject: [PATCH v2 0/3] SDM670 Global Clocks
Date:   Wed,  7 Sep 2022 18:39:24 -0400
Message-Id: <20220907223927.139858-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Changes since v1:
 - regenerate patches to fixed malformed patch
 - fix schema so that the parent clocks are specified correctly
 - remove core_bi_test_pll_se from new parent_data to match array sizes
 - reference correct frequency table for gcc_sdm670_cpuss_rbcpr_clk_src
 - set correct index for sdcc1_ice_core_clk_src

This patch series adds global clocks essential for features of the Qualcomm
Snapdragon 670 (hopefully) cleanly into the SDM845 driver without doing
runtime fixups like in Google's bonito kernel (see patch 3).

This series (mostly patch 2) affects kernels made for Snapdragon 845 and
might need some further testing on SDM845 devices. I do not have a
Snapdragon 845-based device so someone else will have to double check if
it is necessary.

 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |  60 ++-
 drivers/clk/qcom/Kconfig                           |   4 +-
 drivers/clk/qcom/gcc-sdm845.c                      | 404 ++++++++++++++++++++-
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |   2 +
 4 files changed, 453 insertions(+), 17 deletions(-)


