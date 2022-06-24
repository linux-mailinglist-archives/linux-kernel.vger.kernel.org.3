Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC955A031
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiFXSAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFXSAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:00:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29554B411
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:00:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o10so4564204edi.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vntvT1EFiEzAEBGG+P45Ozydw6Gmi9zo/BJZoNn0nqM=;
        b=nmlzUYrxV1auNu9X3Exh/og9NchcUL3bMBLQXY9/L3/2N7WPmfC/kwyJEs8GaIKtQ2
         n4UzIzcjKjm+5ywq4+WUEfAXegHQ58H2sGjZDAwH6T4lswkVsQoCLY+NV67IOwsfKcNO
         J72w9QptU7Q57vloXmZxRjNJtil/1R66du2Or3HPKa4Ucgy0HpGfA3hYtqKKIpYWfTLx
         XYgptjvTGIO+MUsvTGHgVFktuesaOxg5fO93CeRzSAoWYhPjUbJqgnA34jxs5Jyl3k6N
         PnxrcyWNmh1VQ4Ys1CyFWn36MhRh46LioIzL0id1808uK5731zn1IYv+a6OclrJd6I0M
         UYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vntvT1EFiEzAEBGG+P45Ozydw6Gmi9zo/BJZoNn0nqM=;
        b=5en9DsuAdDaUOYt1SEW1WM4MlkJNkEdg4JDyQBuW8zNnAaEcD8iSVW/2Raxq5QFsl9
         Ze7JIjGpAnnhG2aNi1oHA4Nq8A3Re2i1wuMKz/OMr+Jr4ohpEXuWZbvp7kei/sxs9AET
         /GSVFlmvc+AHJ/HmSJszeQ/BCmfCKM5oI3SjVTbnCZVxgkB5/B6+y0pclN3meUB98OJu
         GMpWuuNoMvcW0S7oAnRG6T5h2kPQ4vXw1Knzm23C1U+SSuU5rTNSVN0dNAbwdiW5T8QE
         wro4MxuXNit9yz0y8Gb0FaxoL0c9Loa12Vf4T7JVf1sSI4cgMsjW392IymY1i3C07pgd
         CxMQ==
X-Gm-Message-State: AJIora9dWarRY7UjP9ZxueNuf9I86496L1gJnxeebLBMCe+RPhaORjB4
        cZkPRbOwFVpC4dA7CF2rPtSj0g==
X-Google-Smtp-Source: AGRyM1tDDQY0OLBSTdH3fSFT8Df9ltKldqvwwl0mdMPOHV4h1Cajj/JEAyLzIqtbEBB29k/5sSa5QQ==
X-Received: by 2002:a05:6402:2753:b0:431:9c8b:5635 with SMTP id z19-20020a056402275300b004319c8b5635mr409203edd.152.1656093640210;
        Fri, 24 Jun 2022 11:00:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p22-20020a170906839600b00711d5bc20d5sm1420681ejx.221.2022.06.24.11.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:00:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 0/3] dt-bindings: arm: qcom: qcom,board-id and qcom,msm-id
Date:   Fri, 24 Jun 2022 20:00:33 +0200
Message-Id: <20220624180036.102510-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

Changes since v4
================
1. Change the qcom,board-id oneOf (oneOf at higher level) so newer dtschema is happy.

Changes since v3
================
1. Patch #1: Define all SoC IDs, based on Qualcomm socid driver (Konrad). Keep
   Dmitry Rb tag, even though it is quite a change.
2. New patch #2: use bindings in the socid driver.  The patch fails on checkpatch:
   "Macros with complex values should be enclosed in parentheses"
   but that's expected considering the macro contents.

Changes since v2
================
1. Adjust description of new fields after review (Dmitry).
2. Change name of msm8996 define (Dmitry).
3. Add Rb tags.

Changes since v1
================
1. Make the qcom,board-id and qcom,msm-id properties deprecated and limited to
   certain SoCs (Rob).
2. Extend the qcom,board-id schema to match OnePlus variant - four elements -
   and drop DTS patches splitting four into two touples (Stephan).

Description
===========
The discussion [1] brought several arguments for keeping the qcom,board-id and
qcom,msm-id properties.  Keeping means we should document them, so the DT
schema checks pass.

I revived old patch [2] with several changes and improvements.  The commit msg
hopefully collects feedback from the discussion.

Best regards,
Krzysztof

[1] https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
[2] https://lore.kernel.org/all/1425503602-24916-1-git-send-email-galak@codeaurora.org/

Krzysztof Kozlowski (3):
  dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
  soc: qcom: socinfo: create soc_id table from bindings
  arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tuples

 .../devicetree/bindings/arm/qcom.yaml         | 120 ++++++++
 .../boot/dts/qcom/msm8992-xiaomi-libra.dts    |   2 +-
 drivers/soc/qcom/socinfo.c                    | 259 +++++++++---------
 include/dt-bindings/arm/qcom,ids.h            | 146 ++++++++++
 4 files changed, 400 insertions(+), 127 deletions(-)
 create mode 100644 include/dt-bindings/arm/qcom,ids.h

-- 
2.34.1

