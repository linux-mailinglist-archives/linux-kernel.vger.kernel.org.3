Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E215548A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbiFVIZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiFVIZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:25:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A96A381B6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:25:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e40so10252446eda.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyiCv0jbPI1NnnL9L5/rMkqsXbBv9EQwKuNk4iGgbQ0=;
        b=jntD7kSxAvBZfX63kQbzony9Ywa8WhwRK96+gcbUlg1brzExSGLYr440kRaxmdtXKs
         gg3ynhv15IHpXjSPbmbqyHdN0145+fLmTyHEIRyvXI4vU/tWvQ6s//thx27vPRkVYHbn
         X+h/Xy3wjQMO+Bvf104DNWV5d1beiqt9BmOywsouwFYc+Y7hHCRp8hYHwfQu3NMeNkm0
         wJhXvwZ3mrqE6pUFawMeptmPNifUEDE2MA4O7zePmk5KcXMC9p+xUQKyUXdWJt+qJPKb
         iypUYePgjVMn4Ds0xkPYbeuoYTKQMDy7w/5Qga3GMohel/azE79kHsHmTeb0OtoZ8i2x
         Q1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyiCv0jbPI1NnnL9L5/rMkqsXbBv9EQwKuNk4iGgbQ0=;
        b=n3slHODAHxmb5cHXAPntZnGHxiJLcMz60Fntjirfbx/9qL177QWrN5WGUX+LnEElVv
         cJ+IqPBjKp90I3ZmdIkFSuhFwNMzVEomX59Zbm5j2ckxhZcX5UWRrkjBj/xkilS5RNAv
         FnQ1M3xkSmJw80W7AuKPqjXUQeBitwhl216t/BpIWQl2mXJ4nQcWwaJBGYCYNezsGSdk
         3lkh2WN4usalN5aU+AIPwvesbZkb2Q/GQcdwKJY9B9E8FpDmb0ecoHgRlSOH43jA/ERA
         Qt+7DxkRN8mDc78j9QAnzQFqM1x8+Tn4xTUgUCkWJfVOIVzWZCOJ6HCMz8TulL/CKARU
         8fDA==
X-Gm-Message-State: AJIora9AuBebDRvEGQ4btVQ63bh6y+nvopi4FRY3LTqk0LT0uHr06lyD
        cAmnSYV//fqDnjGJT6jMswh3rFtf80+kZQ==
X-Google-Smtp-Source: AGRyM1uFcO76eoND1JAKmpNzqCG8L/aK26bKB/9APdpQjUvElCrBy2p68KKUci0qeUowyRaHzQaS2Q==
X-Received: by 2002:a05:6402:3807:b0:435:20fb:318d with SMTP id es7-20020a056402380700b0043520fb318dmr2753453edb.272.1655886322716;
        Wed, 22 Jun 2022 01:25:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090609c200b006fef0c7072esm8917082eje.144.2022.06.22.01.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:25:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     sboyd@codeaurora.org, robh+dt@kernel.org, agross@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stephan@gerhold.net
Cc:     robh@kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3 compatibles
Date:   Wed, 22 Jun 2022 10:25:19 +0200
Message-Id: <165588573167.12753.16527581340731852548.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Fri, 20 May 2022 14:32:44 +0200, Krzysztof Kozlowski wrote:
> The MSM8916 Alcatel OneTouch Idol 3 does not use MTP fallbacks in
> compatibles:
> 
>   msm8916-alcatel-idol347.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['alcatel,idol347', 'qcom,msm8916'] is too short
> 
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3 compatibles
      https://git.kernel.org/krzk/linux-dt/c/5c7b9a89c60ce728f61ecd8f2ae043deceb1fe66
[2/9] dt-bindings: arm: qcom: fix Longcheer L8150 compatibles
      https://git.kernel.org/krzk/linux-dt/c/0c8195fca687db26cd00df27c9df1830bddf72b0
[3/9] dt-bindings: arm: qcom: fix MSM8916 MTP compatibles
      https://git.kernel.org/krzk/linux-dt/c/4de2601759e545625413284051e32124df3cbad4
[4/9] dt-bindings: arm: qcom: fix MSM8994 boards compatibles
      https://git.kernel.org/krzk/linux-dt/c/317e5467957b1f69df2235f247ffdabbc85dd01b
[5/9] dt-bindings: arm: qcom: add missing MSM8916 board compatibles
      https://git.kernel.org/krzk/linux-dt/c/496bb1347265130412739e752db77349e35e2ec2
[6/9] dt-bindings: arm: qcom: add missing MSM8994 board compatibles
      https://git.kernel.org/krzk/linux-dt/c/215ad5a02e6c60fef7460c6936bf9996989f4969
[7/9] dt-bindings: arm: qcom: add missing SM8150 board compatibles
      https://git.kernel.org/krzk/linux-dt/c/4c74aef40300efb7e3cb7fcae62969ac63d349bc
[8/9] dt-bindings: arm: qcom: add missing SM8250 board compatibles
      https://git.kernel.org/krzk/linux-dt/c/197b6d70cf9e166e93450c155ceac6cc63ee908b
[9/9] dt-bindings: arm: qcom: add missing SM8350 board compatibles
      https://git.kernel.org/krzk/linux-dt/c/33a34cefdfaab7410cb5e280ae8e4318e3d79e8a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
