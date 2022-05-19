Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2752D0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiESKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiESKpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:45:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C324AEE35
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:45:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f4so8334345lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=mYcXsfhT+AWUsUG41abZgvqHMXzuMRH/6/waE2xX3Ug=;
        b=HGKzoA0FGVdS4LErY0Xa1o+skIRp4jJbQ8ooFHqEURyRmD2qNmewGtU8wV3/A8wwLn
         t/m8GIwrPRHcV1D46Uc5bJqcKNpiMxjd1xmCVmizoWQ78Uwmjggvz8QsSnwPYCLYt1eX
         1UGCxXcjUIgPf6hHbenioXuMlG8PrqkZ/bfUxyvuol+uK6jm2xKdB6V3GyWEhIukKG3f
         wQHGatzMiOpaR5rmG+o/fXN4Ap6A5zVkWa7CFHXZiJtIEVmqckm3ob9ZjqD3gfz4yKO0
         y70UXT9iZgkhBVvfT4OtUOV2LHB67RIUY7TJav+9a0G1ymkGJo2hp5gLqvv/c5tl2NDX
         7UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=mYcXsfhT+AWUsUG41abZgvqHMXzuMRH/6/waE2xX3Ug=;
        b=IqECMwl7El1fw3UNwx0nMbNfVakNEiSUh4Fc0yScu/YzkiQj99IMd2OsTnLtcCdvYl
         50ofCj/uWYC8BcsTo3QcL3p3VfLJjCNvAnZriL9ATIiENyNMbKvtGoLMELnrgRe3O8Dw
         Hf3nysz270jxMniym2ZCx//lSE6VzkS/KJc89mV15ilbTlamEOM5kKtE1u+O8yDtGL2x
         P3z3g/+g0ERrCEfatw/KwVCOwVDZqN8cuoobUnLtUzv1JurGoWVEXhljIKQY1sI1Oc7j
         kL2wPsB2Xmib+V053RyLbXfFeIItTRg+MHvNCehj/71nU/R/Uc6feloPlX7VF9wzTlc2
         WczQ==
X-Gm-Message-State: AOAM531OtreqpQAQzVrbqlUYsYbmUmwksEIk+Y8yTUzvLfIJ3OA82qIE
        7SvNFpL7O+wl3g7xmjKdJIxGtxAnA+XAp1vj
X-Google-Smtp-Source: ABdhPJxsYy+DhzF1QvPxKOKFystj2KixVC7Oa9RgJP+p93TYomFH2x9d4lceThaFcIhGBLtEL78XZA==
X-Received: by 2002:a05:6512:3f0c:b0:477:8ecb:47fc with SMTP id y12-20020a0565123f0c00b004778ecb47fcmr2860080lfa.653.1652957099839;
        Thu, 19 May 2022 03:44:59 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v27-20020a2e2f1b000000b0024f3d1daeb5sm527735ljv.61.2022.05.19.03.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 03:44:59 -0700 (PDT)
Message-ID: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
Date:   Thu, 19 May 2022 12:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Removal of qcom,board-id and qcom,msm-id
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

There was an old effort of removal of qcom,board-id and qcom,msm-id
properties from Qualcomm SoC-based boards like [1].

First approach was to document them, which (obviously) was not well
received [2] [3] [4].

The solution from Stephen was to encode these in the board compatible,
so bootloader can extract that information. That seemed to receive
positive comments, at least from Rob. [5]

It was 2015... ~7 years later we are still things doing the same way,
still with undocumented properties: qcom,board-id and qcom,msm-id.


I would like to revive that topic, but before I start doing something
pointless - any guidance on last patch from Stephen [5]? Was it ok? Some
early NAKs?


[1]
https://elixir.bootlin.com/linux/v5.18-rc7/source/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts#L14

[2] https://lore.kernel.org/all/7229476.C4So9noUlf@wuerfel/
[3]
https://lore.kernel.org/all/1450371534-10923-20-git-send-email-mtitinger+renesas@baylibre.com/
[4] https://lore.kernel.org/all/20151119153640.GC893@linaro.org/
[5]
https://lore.kernel.org/all/1448062280-15406-1-git-send-email-sboyd@codeaurora.org/

Best regards,
Krzysztof
