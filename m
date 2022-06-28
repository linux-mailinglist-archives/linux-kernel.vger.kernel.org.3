Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3B55CE48
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344231AbiF1JXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344153AbiF1JXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:23:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D730413FA7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s1so16718464wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czfPpDJHs7J+piUiFRqpKaLtdiOGZv8sTnfz/AiCY3E=;
        b=bNlyXdNJMiDMSiGy4FDB/w5B0HJlkKjZEKHkPjtLIpJgbFeSniqTHKu5zE+Agd/XOT
         sKSJNfC5yOvBJqhUm5pU8NENJOBPcvLq8fXPEpEa1W6STe5s5YXmUhsbBirORTOEwjk7
         x9Ni8rwYBey+RkxvvtM44mZBb4Czrm9XHkGkypflD1/YMazjCGB2vVj3FcdIo74McBSF
         pEi4SKMTfRbuBf972fNv4bcna+Qmgsi2r2EC3skUh0Y5RrE+L2P4QxJB44zVkB3Nw8cA
         nv9PzMbJyVGymxbNCsJRcVHP0tPRrqafVC+d6reWFrDed8oLx0rbJTFqhOi4t0mAIDoT
         UNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czfPpDJHs7J+piUiFRqpKaLtdiOGZv8sTnfz/AiCY3E=;
        b=il6SprdgNLNbiYdXvrPYeVmBsmQi4ghCVyI8dx37/wJNusLGrfZIYJJUUwI8lvoclL
         EDl2vCH2WLgiNqdDYOC1/C6pYwLNq+2tat4vI07FJobZywypL3sAFHIguiflDiV7pfep
         IG9sMGEaD5PHlsSI7ZYcfxv3Uz84trFHU3zKZyKFxYz7KG5lDrzBnP7criIVW/fDABN7
         1PFj6F4rlcagS3OWThF31PtCMPBDrOlknbjQcn2Rm/x05d1p1sUJc1Tr1SpRMd+cV/Tm
         MQmzFthi2Bks5eNVFmLGNe+xxk7NknpiKqPalpU3INW2L+F4K980yPaGJ60XpiSG9iUu
         0KfQ==
X-Gm-Message-State: AJIora9Ufjze7yxCzr+b8SIhjJFB9oYD1Uu6qekXGdJgyyGpjRHFTJEy
        fNg9AqxbogoX5ZoB7cVh6GcITQ==
X-Google-Smtp-Source: AGRyM1tskEhayAStBRqLvIw37j7NKJYmUXe1595je1HJUJxMNs+fIvjanpQr6b3jJXdGXjKiKszGNg==
X-Received: by 2002:a05:6000:2a5:b0:21d:2204:134a with SMTP id l5-20020a05600002a500b0021d2204134amr369727wry.67.1656408189470;
        Tue, 28 Jun 2022 02:23:09 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c230500b0039c8a22554bsm16235025wmo.27.2022.06.28.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:23:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [GIT PULL] dt-bindings: qcom for v5.20, version 2
Date:   Tue, 28 Jun 2022 11:22:53 +0200
Message-Id: <20220628092253.21905-1-krzysztof.kozlowski@linaro.org>
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

Hi Rob and Bjorn,

On top of my previous pull few days ago:
https://lore.kernel.org/all/20220623145837.456817-1-krzysztof.kozlowski@linaro.org/

Difference is only one new patch - the cpufreq bindings fix.


Message from previous pull:

I am fixing/improving quite a lot of Qualcomm bindings and I produced several
separate patchsets. They wait on mailing list for quite a long time, in some
cases two months, so I decided to grab all them and send in one organized pull.

All patches here got Rob's ack.

This also brings compatibles for Qualcomm boards, therefore it might be
desirable to merge everything through Bjorn's tree, however at this point I
want to just get it merged as fast as possible, because I am really afraid they
will miss the v5.20 cycle.  Therefore the pull is towards Rob, but maybe
First-comes-first-served is also good approach.

Best regards,
Krzysztof

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-bindings-qcom-5.20-2

for you to fetch changes up to 062529700fdb843eee921961eb3cbc6a51419491:

  dt-bindings: cpufreq: qcom-cpufreq-nvmem: fix board compatible in example (2022-06-28 10:28:50 +0200)

----------------------------------------------------------------
Devicetree bindings for Qualcomm for v5.20

Cleanup, fixes and additions of missing pieces for Qualcomm bindings.
These are address dtbs_check warnings and do not bring new hardware
(new compatibles are added for existing boards/hardware).

----------------------------------------------------------------
Krzysztof Kozlowski (25):
      dt-bindings: soc: qcom,rpmh-rsc: simplify qcom,tcs-config
      spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
      dt-bindings: soc: qcom: aoss: document qcom,sm8450-aoss-qmp
      dt-bindings: soc: qcom: qcom,smd-rpm: add power-controller
      dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630 compatibles
      dt-bindings: leds: qcom-wled: fix number of addresses
      dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3 compatibles
      dt-bindings: arm: qcom: fix Longcheer L8150 compatibles
      dt-bindings: arm: qcom: fix MSM8916 MTP compatibles
      dt-bindings: arm: qcom: fix MSM8994 boards compatibles
      dt-bindings: arm: qcom: add missing MSM8916 board compatibles
      dt-bindings: arm: qcom: add missing MSM8994 board compatibles
      dt-bindings: arm: qcom: add missing SM8150 board compatibles
      dt-bindings: arm: qcom: add missing SM8250 board compatibles
      dt-bindings: arm: qcom: add missing SM8350 board compatibles
      dt-bindings: vendor-prefixes: add Shift GmbH
      dt-bindings: arm: qcom: add missing MSM8998 board compatibles
      dt-bindings: arm: qcom: add missing MSM8992 board compatibles
      dt-bindings: arm: qcom: add missing QCS404 board compatibles
      dt-bindings: arm: qcom: add missing SDM630 board compatibles
      dt-bindings: arm: qcom: add missing SDM636 board compatibles
      dt-bindings: arm: qcom: add missing SDM845 board compatibles
      dt-bindings: arm: qcom: add missing SM6125 board compatibles
      dt-bindings: arm: qcom: add missing SM6350 board compatibles
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: fix board compatible in example

 Documentation/devicetree/bindings/arm/qcom.yaml    | 108 +++++++++++++++++++--
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       |   4 +-
 .../bindings/leds/backlight/qcom-wled.yaml         |   9 +-
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |   2 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |   1 +
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |  33 +++----
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   3 +
 .../bindings/spi/qcom,spi-geni-qcom.yaml           |   5 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 9 files changed, 135 insertions(+), 32 deletions(-)
