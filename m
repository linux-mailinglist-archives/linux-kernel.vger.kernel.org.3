Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE295A5F22
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiH3JTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiH3JS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:18:58 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A5D83E2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:18:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z20so10695915ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=dAQKouAgPWkFgT/L79DpCLEZVs1s1eMpf1fs8oVBpVQ=;
        b=nx+b9zWTRn8VBKy2hv2AW48rKFz7yDy7ZCwY4g8fh3Dr5MIhGzmiv9vamitvGAop9j
         uR7aswDYelsTXdH4tN7LHERpElabXR2NyqVONA/Ix5r4VxMY1/mStBYGWbirrfZl1k9C
         FgqVai25gyW1uhAonEqfXSg2H0JIX4qMgEz/lE9f1nyHaNndzq1x2lYZYP/T4Ixmkp4Q
         R2HklRoNZEH+enzMmFuBv7Bg6Shc7vMH4E9lphwi0irurXMKWm0u+yuUDG6m0DiVjlXp
         W1VSnhrTul2IBpQSNu5O7H/fSlBsH/ykUdWFO8C+Hda0PJjV0YVQ8IAUB07YZYGCqex7
         Xyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dAQKouAgPWkFgT/L79DpCLEZVs1s1eMpf1fs8oVBpVQ=;
        b=2Xoc/2oFAJRnMFKM59siTtbXK718Jj42/QRqSBl0hBgswId8imu80GzyFKC6xErbuj
         lfxOxsOBLnJj7kOztecWeIHLfgwSzza1nGxlUqoK3vZnMx5lpoKiMqwilnKb5P2PLxFO
         tnRY87LEtT+x+4k1suysdW7sHYClkVXcQQcJRuHtCYekb5gD4TpX+LEuL8td4ZXme4f0
         XyYjSoaqq1CDgoRksufrxkNnHkZdCWX+x+KKj6apxXwqvRTSLqTIt2N1gwWBgtyzqyrs
         +ku3y6X4JAoVbB5FX6+HzwsWJqe66R1jFIoC4gTQdtVvy+HvE4Wc0Vg0PGx/Q20kDx2e
         TjZQ==
X-Gm-Message-State: ACgBeo08nxrwaYECovONJHJxbuIDGC/o2s0Et3yPq1/1OnKt0AReqtxs
        lDR/zmyOtFFUrh/ysqot3EYSvAtckn1aQonCbG4=
X-Google-Smtp-Source: AA6agR4UDLA9aC7NOX4uB7Mk2+pP5fmbHLtmhnkg6QTxLXxp91xsFSmr40D9xuX4dP0masF2L8Hj6A==
X-Received: by 2002:a2e:8749:0:b0:25e:4357:8ef7 with SMTP id q9-20020a2e8749000000b0025e43578ef7mr7171083ljj.319.1661851129908;
        Tue, 30 Aug 2022 02:18:49 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id f27-20020a05651c02db00b00261800f0e02sm1682559ljo.26.2022.08.30.02.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:18:49 -0700 (PDT)
Message-ID: <787d6aa5-ff85-dede-cc16-958290cd77b3@linaro.org>
Date:   Tue, 30 Aug 2022 12:18:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] dt-bindings: spi: renesas,sh-msiof: Fix
 'unevaluatedProperties' warnings
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220829220334.6379-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829220334.6379-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 01:03, Lad Prabhakar wrote:
> With 'unevaluatedProperties' support implemented, there's a number of
> warnings when running dtbs_check:
> 
> arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb: spi@e6e90000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
> 	From schema: Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> 
> The main problem is that SoC DTSI's include power-domains and resets
> property, whereas the renesas,sh-msiof.yaml has 'unevaluatedProperties:
> false'. So just add optional power-domains and resets properties.

This is not the  main problem. Main problem is that this device is in
power domain and/or uses resets, so the bindings are incomplete. Please
rephrase the commit msg.

Best regards,
Krzysztof
