Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221E74CE605
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiCEQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiCEQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:52:59 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD13B03D;
        Sat,  5 Mar 2022 08:52:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b11so19288962lfb.12;
        Sat, 05 Mar 2022 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxGEx/UmR4KZJ60ASWh+xU+S5NM4aOeVXtrO2lALPmM=;
        b=iADxoUa26ngqfpURoXcgE0AmdMZfM9zKb90jIZZaqFOV8BkVXx0G9lw0QOOJ1lSHrT
         vzb3PtOiRPmTUtwlyrEfa7BvMWtmd1uElOW+16ojotr9zWK/ZELMjt00p4zVCyv5Xg4S
         ydNsILj0zOHrs/rDtkpnyKK7HQB0zWO+Sm2qqSGYk9s6X9VH7fXY1KuXNmPIA8Ur39gl
         uaHFHF1G9C0Vn88OWz3W8BahFrtpfCmI7xmUTZEXKGxHZ9vEP39Jp8jxdUGM0w7M+1lM
         l8IdiHD97HBb3cooFM2jJbumOoq+30DtO/WbtBrI6frk9lL6SzwrMAoObcAeTErpou9i
         Or1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxGEx/UmR4KZJ60ASWh+xU+S5NM4aOeVXtrO2lALPmM=;
        b=y5eJQtgEnHsi13ljKAKEraTyLe5kyulw0+9sR3pTPrktCV7Rkgdwl95XljetxD/KFs
         +BgJh+f3/aktv7hjVcZavs7IClrrQ2bJNUxv/3Oz524W3B9zYRIr3hIP/6hcqOjgejbO
         CTX648ShMu9HNQIelI3zO1DVlaYPSuXRwGa+GXevBlZU6KWbq7raiaytgcOLbnzst6mN
         /MmYaIHzdq+zx1JDkY8/J90Y1oZ4O2KStJPWFAWjFr0UGuOKUnxD48g0u8EBTQ2R+7dP
         lRWSOgSx6dDQZ2DeY95GHFP67Y3AITfuTfkcuyHUnSHej5Lse8nCOTPlR4LGMDWKE25O
         P70Q==
X-Gm-Message-State: AOAM533aWoZ+B/Ljciv3Lu97kuqlpU66Ml9SiijLWnJUDcr9cZIdGsw4
        2dJCSK6yjPz2afhnqDov+EXZk6h0/lel87MU
X-Google-Smtp-Source: ABdhPJwRhGssIjRq4Dp5iXc86HaDTuXU3UrmI/ewMKgJSrHGGg+whFXyi7HLOv3RqQB6irVUFpvs8w==
X-Received: by 2002:a05:6512:3194:b0:445:bde8:9fca with SMTP id i20-20020a056512319400b00445bde89fcamr2745174lfe.534.1646499122666;
        Sat, 05 Mar 2022 08:52:02 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b00443c3f383c5sm1751287lfu.231.2022.03.05.08.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:52:02 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] *** Add SCM and mailbox support on MSM8976  ***
Date:   Sat,  5 Mar 2022 17:49:01 +0100
Message-Id: <20220305164906.16853-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patch series adds support for SCM and mailbox as found on the QCOM
MSM8976 platform.


Adam Skladowski (4):
  dt-bindings: mailbox: Add compatible for the MSM8976
  mailbox: qcom-apcs-ipc: Add compatible for MSM8976 SoC
  dt-bindings: firmware: qcom-scm: Document msm8976 bindings
  firmware: qcom_scm: Add compatible for MSM8976 SoC

 Documentation/devicetree/bindings/firmware/qcom,scm.txt       | 3 ++-
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    | 1 +
 drivers/firmware/qcom_scm.c                                   | 4 ++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                       | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1

