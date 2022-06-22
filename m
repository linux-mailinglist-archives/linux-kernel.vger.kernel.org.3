Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4632C554688
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbiFVIZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiFVIZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:25:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7CB36E0A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:25:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ge10so1036415ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sk7O8lq07lQl5L3t5X6FFNtNHOKCXJGWanHL8zfryQY=;
        b=nE57QXyZ+uLvpFZbraeiA4sJT4OtDPcsAI9qW642P2/Wp2wlW8hLV7FQYC9+735+WE
         OPB12XTPs9yLe4YlYPwW7/Y4dekJEBEjurThbDv2JB9TQSuQXZWKnnw6lssIjLUFtOAL
         xOg8rBREGSf9rrBEL0V4GyXq0/y47BY4bd1SxzWiKJoyWFD/w5bePBAVhtyynitzDPYH
         qc33wXGoTqj2kiiYK/wGnoJTPE4OqU4tBZWxTmWHVheHo2lozE5KVWSQso4sHfRhNndm
         +11zb92S8W5/WfktCsyEUeJH6mwwaSoH11H7WmvViAiHrkXYEMZPJNXsprEw7rYB47pd
         x2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sk7O8lq07lQl5L3t5X6FFNtNHOKCXJGWanHL8zfryQY=;
        b=H1zOGkiop9OiBCyK0+hMv/S4GmcIYShb2XnNxxid2eWaD1H5a8xRTQDw2XlCVDhY3s
         Tg7TgPK6+NCpwmLBL+z/i40NM+QIC5gHauth0UIN+r7RRNaUrSVE+C1aDSr+s48QE4j1
         UAQ9RW0jiyWVCXFepC1qtQpBVHp4q2ZQGQuERiGXw3cbldT6us0JeX6lI7SPT+IFs8qy
         BeremuV1+nPJhEqq9BuemFdQXcQMOhU2WyIRjFp+E43UF0BroanL0I8CU0DhrsqCB0wP
         U4ngOAotPuaHGG0hedOGUqV5W5WE85krfMZWGYCbayUK9+BJPNOY+OvMUv6WR7V9d375
         5cNg==
X-Gm-Message-State: AJIora/+7C+l0zaWLfmKmR5ZKelkgKCv1nIJ9gEWYmj3zTvMIFb0ni9V
        lXv2KDQ914ig2HMVhYt5wRIMtPdLm5l1Ig==
X-Google-Smtp-Source: AGRyM1u3EImERlNbTceP1iq3dl3z6SkR6Z0617AtkvGI/qiz1PIqSTKt0YthoOabCGYpE6GlFM8hXA==
X-Received: by 2002:a17:906:209:b0:712:12d8:b52b with SMTP id 9-20020a170906020900b0071212d8b52bmr2000410ejd.394.1655886321475;
        Wed, 22 Jun 2022 01:25:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090609c200b006fef0c7072esm8917082eje.144.2022.06.22.01.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:25:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     robh+dt@kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: vendor-prefixes: add Shift GmbH
Date:   Wed, 22 Jun 2022 10:25:18 +0200
Message-Id: <165588573167.12753.11773180092884098160.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:39 +0200, Krzysztof Kozlowski wrote:
> Add prefix for SHIFT GmbH, phone manufacturer
> (https://www.shiftphones.com/en/).
> 
> 

Applied, thanks!

[01/12] dt-bindings: vendor-prefixes: add Shift GmbH
        https://git.kernel.org/krzk/linux-dt/c/de0f2f0d6f35a583aaade4c290d9e8c3e03970b3
[02/12] dt-bindings: arm: qcom: add missing MSM8998 board compatibles
        https://git.kernel.org/krzk/linux-dt/c/a47214e3fde968d4b251b5de8eb16c32f2b0262e
[03/12] dt-bindings: arm: qcom: add missing MSM8992 board compatibles
        https://git.kernel.org/krzk/linux-dt/c/581704606d4ec5b8e6749b7abc200795e845a0a2
[04/12] dt-bindings: arm: qcom: add missing QCS404 board compatibles
        https://git.kernel.org/krzk/linux-dt/c/1ceefa2a55ce7d9e4b8901b22e981f8965f9c4e3
[05/12] dt-bindings: arm: qcom: add missing SDM630 board compatibles
        https://git.kernel.org/krzk/linux-dt/c/4fc3efba32057a76155449a2713ff242109a65a0
[06/12] dt-bindings: arm: qcom: add missing SDM636 board compatibles
        https://git.kernel.org/krzk/linux-dt/c/7e86c41be0bebd01e2f0c87cd5b00c5746ab4089
[07/12] dt-bindings: arm: qcom: add missing SDM845 board compatibles
        https://git.kernel.org/krzk/linux-dt/c/1facf9135a1b846c7f4e8db044b425b81a7bffff
[08/12] dt-bindings: arm: qcom: add missing SM6125 board compatibles
        https://git.kernel.org/krzk/linux-dt/c/103a90f68bf1f30b46de5c08c19c9f8e97530024
[09/12] dt-bindings: arm: qcom: add missing SM6350 board compatibles
        https://git.kernel.org/krzk/linux-dt/c/f9702486c77ba74f65859098e3d8e4bdb2e8a745

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
