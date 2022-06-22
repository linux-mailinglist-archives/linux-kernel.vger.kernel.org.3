Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3A5549AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354977AbiFVIgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354482AbiFVIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:35:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8784E38BE3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cf14so13074061edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i4bRTG4lVkNF7ntn262LTb80cj+Ip9xH77tT8HcEEqg=;
        b=y/FpOc4YHeB4CimlgD+zcxj+AuCEspCpU8ZC6BomTZK5jkSd1XfD5GZGD0Od5o9WzG
         JC3hDYcmt1nRPRGR7lCTTKOcv1y++oVT1DWgfbN8Y9qetNXG6kYeml4JRE9jWUcFybm9
         Ge8ZFtrN6UFV32+oyP5DHnQuK4VQvkl6dW4bGpmV9ifGHB4XSBS3FGHtr7pdehkWxHXT
         MVpOzrX0MZ3n0Ql6QbhBPDb7LgH55wW3zxJaFSQoxyloiqBN1X4WMVuX5W3PBz5doFdi
         eXALsuB4WQlJYDbzrxO4KCzKBiSslPNuw871IXlOMzY5GQqIDvkTOx5BlXn7DtLxgxY4
         7cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4bRTG4lVkNF7ntn262LTb80cj+Ip9xH77tT8HcEEqg=;
        b=3iE6z9I81yCf1wj8CkOQBmNVmZqOA4hXAt5ALRBcg89QC/Vw6nbjtEjPCs1oZ2BAhJ
         jRbppt/i7KsHRrieobBqXTbHdU4tg216yvZqQ+FSZHDvNcDX/TUFCqPdQCnw0coePllS
         WGNnRCsDsxa3iN/G8wjdEuW5mufKuoTQ0QGjRqPsiiLRyGA2boequ8vh0wysHpHX4OZU
         vSVoMJslxQte90cZFLqgJmDAQWGMIegURp5n0qFD5UIvniqF3fI5g2AtuQbR3IEXoDpr
         /jTCIdkbqtSgBUD/BqROMuen1+Fs+HpG9iqp6nrZxyc55vT6AcsXDx7teOBkGVeM00VX
         5KyA==
X-Gm-Message-State: AJIora9iz472xU3YYtWJhqAdeGctb9IRmpiPtb2bgfvYScVl91owYVmz
        BpulFuUvTG7g+mzsH8/ruV6a/A==
X-Google-Smtp-Source: AGRyM1th5YFje120BVD3g9dTQuOlYu2KzHSQhj0WdB/vYKLGcfDT7C3zKJWLyTHt6rhgnIiwmDn3dg==
X-Received: by 2002:aa7:cb13:0:b0:433:4985:1b54 with SMTP id s19-20020aa7cb13000000b0043349851b54mr2751651edt.182.1655886948123;
        Wed, 22 Jun 2022 01:35:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b00722e603c39asm1979733ejc.31.2022.06.22.01.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:35:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, agross@kernel.org
Subject: Re: (subset) [PATCH 12/12] arm64: dts: qcom: msm8998-mtp: correct board compatible
Date:   Wed, 22 Jun 2022 10:35:34 +0200
Message-Id: <165588692598.15720.11468561846292254961.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220521164550.91115-12-krzysztof.kozlowski@linaro.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org> <20220521164550.91115-12-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:50 +0200, Krzysztof Kozlowski wrote:
> Add qcom,msm8998 SoC fallback to the board compatible.
> 
> 

Applied, thanks!

[12/12] arm64: dts: qcom: msm8998-mtp: correct board compatible
        https://git.kernel.org/krzk/linux/c/4fb4a39fdbc8bd0aa35de0970d26cbc6c5abf946

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
