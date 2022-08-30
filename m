Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9648D5A61A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiH3L3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiH3L3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:29:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC6F326E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:29:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p5so11950933lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/nNGy4pNrk5weqdE31DDFL6s//k/T1peUvPD0rftJxM=;
        b=iUujcASOOvrUR2jM0/Vt1AvH6WXWVlAhNg2AVDlHxSfrU6eGb97999iGc1jBmOYx6D
         3Tj40NZtt+PofiRFEVlKNAGlCOZcHf2BHsz4f4gqeILce5U1iAd/vB/eBheT1H1MVqPY
         mimVbAYJxGlZa2O7x6ax+o6IXVuJ1gP4JHxpqfXQrB8INDBa5xa38orZ0EQl159OLKcX
         Y02NWF4xn9e+HXWnuAnJFMFvRkgZ4Y7JXIzCe8FPwmMUPf6YIByvHf0SLFwG4Fc1fmAq
         U6aRSnPc+c559l8kSPvl6zISPHKCz/km8b9eyNgLXxveXpn3/4HLoNwGtdjJ3zM2lGs2
         sHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/nNGy4pNrk5weqdE31DDFL6s//k/T1peUvPD0rftJxM=;
        b=Dd1bEi/7Qa5DKPmcMABSKTjDgs1QK0APTomW0WksfGEdr1LB9W9iy+zFzyQWORcmG7
         z2lEpfNIsNp5N3kstFC+MiwvMfgaiu5Fl3OIaDGnPCMLYsIVs8tthM0OcolOIrqx6kHx
         NIy28xwqPNNWruWmxTrODPfOizTLw2lGCtw3omX54lU/Y97gbBnC5QAyiMue4M2YRl7N
         FJAqbxiHrGWOambqeXC5MK7x1ysaTrjzM4Qc6UjOpSVSzajronQTHIL6eA8HPWTqfWg6
         5bdLI5ADgxkuZEE9FT6a/pzAjl2UADr2E/tNrI6E9h6a9LMZiHPXKiLbDnMtVoPr5HIs
         gu/w==
X-Gm-Message-State: ACgBeo2P80Dp40Yynnwaiw6DRASFYW0JRsfn5TDDvWUfpgbMb2amW2PH
        WmBi2S+y2hG+WllBrTOVZQOj2w==
X-Google-Smtp-Source: AA6agR7m4wlYaWzSJLwe0rP4a/S5wwbDq+HQuKB+dd2hDQDj7SQcT0CGiNRWMEwo0T4mEE/Lk9Gy/g==
X-Received: by 2002:ac2:58d8:0:b0:494:6df4:9503 with SMTP id u24-20020ac258d8000000b004946df49503mr2262093lfo.448.1661858969597;
        Tue, 30 Aug 2022 04:29:29 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id u8-20020a056512094800b0048b086f4fb0sm1583852lft.109.2022.08.30.04.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 04:29:28 -0700 (PDT)
Message-ID: <47910371-6356-1040-1073-c50fc87b9d04@linaro.org>
Date:   Tue, 30 Aug 2022 14:29:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Document additional skus
 for sc7180 pazquel360
Content-Language: en-US
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220830112013.v2.1.Ic4d4e0777115011544dbc2ab07ed4d7b408c003a@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830112013.v2.1.Ic4d4e0777115011544dbc2ab07ed4d7b408c003a@changeid>
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

On 30/08/2022 14:21, Yunlong Jia wrote:
> pazquel360 is an extension project based on pazquel.
> We create 3 sku on pazquel360:
>    sku 20 for LTE with physical SIM _and_ eSIM and WiFi
>    sku 21 for WiFi only
>    sku 22 for LTE with only a physical SIM
>  Both sku20 and sku22 are LTE SKUs.
>  One has the eSIM stuffed and one doesn't.
>  There is a single shared device tree for the two.
> 
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 

It's the fourth sending of v2, of which three were sent today. I asked
you to read the document before sending. Really, please read it.

Version your patches correctly and add some time before resends.

Best regards,
Krzysztof
