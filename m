Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC13E4EF7BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245560AbiDAQVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353009AbiDAQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:18:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EFB208C26
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:42:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bq8so6636947ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9x06/8SBsQVp3ZTLw121dHm/6m2s5gBJzobnQZ0h8C8=;
        b=hlCYh8+vw4p84yn3f3LkA2HCsX4RGqh5cKSxqo7cAFRd/O7ord2mvC0pFqOuvBCiNJ
         Si3+t+PFuu3a3nNUWT5674mpck7U7f8M78O5so7qHpAm7QJ8VEWupmao1TjxDhfMUY1B
         l/+WA9A3Ksu0PhzsfPWwHOcjQNkTD/4o3QnJUVZJmBfb/2lLiA8DHg5ep7mMQoy8egfG
         QE9Vm59IL7CTNp65btEuaXTTtTlQvzNXtNifdOQfdjMVpt3liOp5b3mMr5npuTbscGZs
         AFeWBnc5Bg8hkUrNy8AME2VmjQdZjQzw5bATWc9aYCLiCILZqV+tK/2qto6jyr2lfKLY
         ic8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9x06/8SBsQVp3ZTLw121dHm/6m2s5gBJzobnQZ0h8C8=;
        b=ixuGPuchjLpMmBFvuuK2LYPTE5k1NpiXHEsN1W7cFdPdU15L4YO3caECZHY+y9JqnH
         poErx60IZGs3SeP3MaQEO3It0t1TmsCmjaActAuom9qJplzaFb1Ndly8kpjHgHqlYpEn
         ckUXuMQ3ub7xoBJwMbbrdeXGVSMYgXlkYli34VNG9+fkc9dR0VrHzw8tm4mT1ZP9knHT
         AVq+kXQ0kmTUrXNviCodI1CsPEPGxVGzgoKQS5rUBTd0vmurFcCUbR0PdG+DPwtT/knV
         PYgKztzJ8oEKf7PwnKJcia1wHZr50DaZ8efyutTKQr4EgoGCXTHNB07vycO27e3HvWvK
         CwCQ==
X-Gm-Message-State: AOAM531pTrDG08Be+2Lc83n2YkeUYYgSoBETUurEswgJURg7yCBny5Hu
        KZkU43Dh2Pk/+rkmrGyL6SGBf1NA2e0YjYHl
X-Google-Smtp-Source: ABdhPJz/sB5y0uahVHr+cIqAsf0swTOqTydpVFzwkJ291iSjCMeS+QjdE5QOTwzMfMzyLaii2yMHeg==
X-Received: by 2002:a17:907:6d0d:b0:6db:f0f8:654d with SMTP id sa13-20020a1709076d0d00b006dbf0f8654dmr379584ejc.304.1648827762539;
        Fri, 01 Apr 2022 08:42:42 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7c38c000000b0041939d9ccd0sm1300389edq.81.2022.04.01.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:42:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 0/2] regulator: richtek,rt4801: use existing ena_gpiod feature
Date:   Fri,  1 Apr 2022 17:42:35 +0200
Message-Id: <20220401154237.1061331-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Hi,

Not tested.

Follow up of discussion:
https://lore.kernel.org/all/2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org/#t

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  regulator: dt-bindings: richtek,rt4801: use existing ena_gpiod feature
  regulator: richtek,rt4801: use existing ena_gpiod feature

 .../regulator/richtek,rt4801-regulator.yaml   | 14 ++++++++++-
 drivers/regulator/rt4801-regulator.c          | 24 +++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.32.0

