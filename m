Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC95220BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347169AbiEJQJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348226AbiEJQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:07:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA624DC60;
        Tue, 10 May 2022 09:00:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m20so33866594ejj.10;
        Tue, 10 May 2022 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXiJ2mpQAyNa13YBj7uo5j5cpdvbXfoTHRY/ZoleQ8I=;
        b=IZbaHguCzhrLkeqeNzdjWnw9BgNCAivwRMIbuG7i2jy/0GX0M62xw5OxR4xod6O83w
         XDaMxhGEJ+5r5BOY8+qqsHRHnf8k+6CxF7+Adp7aeD5zvCRth2QcXG1yy37DG0iKKa5b
         /NK1FrXW4vh7rnRVBqAdSgUv+f7e5ngbn61f+F1SOF+zOSZ7K0D0EhiF700lGZ0/IHoV
         uXTxCq0VoFYacqFuQgIVKhzCGURu9p6CQceBW8+FCtXTeIStXeRO5riJAlDw7j0picnW
         0+RXVXme73vy0mIPKOWFnH9c7R2tLZHEYkqHC5VtImm/QPZkI+Md101sbSsJxEtymKmG
         mfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXiJ2mpQAyNa13YBj7uo5j5cpdvbXfoTHRY/ZoleQ8I=;
        b=RJHi29S2pXGHhoCZSw/nYjD9iqEA5N8BMKQp7vW2eNdEy2uBG76QZfxrp5OUgWg/1W
         N6qWB5s02ky+WfCOqihyv/rFjrI7DFC38a01IbmiM5nClZNx6yAABdAse11R/uZU3ACX
         IL5gYLH1yIJe1rzp1TXe/aLNRKGAq8XuV5Nf1kwFzf/Natxct+yeU1B9hHgGeRcucE6j
         bnNyLf0zclsc0dCvsYtoDu63qY+8ypoFLey1RSP8TMT/sGEzZPNg6HBJ+VI0gdWtI5ra
         f1R80EDBlcB9eG+eOvm7+xk/Ux3VDvze6ek0eNPt9VuNnPaSEARAGPySKtZVrGLPvfQJ
         Xz0g==
X-Gm-Message-State: AOAM53380JEkEqTfjWat9z4DtT9Hjzvku+NthXmwn+hbe5QmgukVyguL
        ug63a83tCT4hGPwOpyXQ/mU=
X-Google-Smtp-Source: ABdhPJyIljUWSLO2j3YWHl9pOuRFnsYpaUfsJit/WEiUAAfcaL6+Cmo3n0jZf7MnwLOtbq5fTC+RCQ==
X-Received: by 2002:a17:907:6d08:b0:6f4:45ca:c410 with SMTP id sa8-20020a1709076d0800b006f445cac410mr20741792ejc.679.1652198418622;
        Tue, 10 May 2022 09:00:18 -0700 (PDT)
Received: from localhost.localdomain (89-38-99-188.hosted-by-worldstream.net. [89.38.99.188])
        by smtp.gmail.com with ESMTPSA id d2-20020a170907272200b006f3ef214e21sm6306949ejl.135.2022.05.10.09.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:00:18 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/3] MSM8996 Coherent Bus Fabric clock support
Date:   Tue, 10 May 2022 19:57:41 +0400
Message-Id: <20220510155744.812471-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
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

From: Yassine Oudjana <yassine.oudjana@gmail.com>

This series adds support for the CBF clock found on MSM8996 and sets it to
a high enough frequency to fix some devices not being able to boot with all
4 cores enabled.

(I'm picking this up and adding DT bindings following a discussion on
another series[1] since Konrad is fine with it.)

Changes since v1:
 - Update DT bindings with the CBF clock and reg.

[1] https://lore.kernel.org/linux-arm-msm/aa54cc23-e479-688c-6a3c-b9c73babd9b4@linaro.org/

Konrad Dybcio (2):
  clk: qcom: msm8996-cpu: Add CBF support
  arm64: dts: qcom: msm8996: Add support for the CBF clock

Yassine Oudjana (1):
  dt-bindings: clk: qcom: msm8996-apcc: Add CBF

 .../bindings/clock/qcom,msm8996-apcc.yaml     |  10 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   5 +-
 drivers/clk/qcom/clk-cpu-8996.c               | 162 +++++++++++++++++-
 3 files changed, 169 insertions(+), 8 deletions(-)

-- 
2.36.0

