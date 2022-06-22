Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39117554E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiFVPAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiFVPAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:00:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D983DDE6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:00:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t5so2334802eje.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4WRbj1QERW/av8psTVhlz4CLgb5wsd2uJJdprSn+O1g=;
        b=ywoEjbfFbhivBAwWa/R/EzH9PY9yDMp4YbZJueOVLsv555+LQ2EHk8LXaq1KYJRZTz
         aWNsy9DW6jJ+1/Qk9ChphBFLTnupm2CBWGrrUN/+aqNkvYvjWgSb2QKJ83C8fPNHerPc
         os8s58x1zsuP1PToF56fprTaU7Nzs1hS9prG5PgoLLwMTPOjH8kQKb/BG6WA1FESzyoe
         YlFj3/jGBKyWV4mIWsHb+4E8JogrKy/H4wZvFGLhYtB+jaiDRpZ5N7eg71ZI/7daIoi7
         PvCbv5b643Q//fIaNJpVJkMEDKVO06G9g6D+8PUvjKhEOEty4cEe17VG8+9r+nU6tuM2
         BTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4WRbj1QERW/av8psTVhlz4CLgb5wsd2uJJdprSn+O1g=;
        b=TqlE52E/5y+eZuHUnAjWdln0lh9jhqNbcTCEF0r8+pChV1gMK/RJM83IzLRydI/unn
         gV3WdpOo1yQaXLWRcQqb9Xl75JzlFzPhxvsl5uRH/ccI12EG19B3qGy3eZHlDsFQJZrk
         +p0VoRifA81SczosQDkXO+hAGqovYvIkbSJbwLHV330iVKUGm8eOWFeVvdE2nrY84q6C
         1R2kNn99O+m2gE/ldTWP2af3vx83ScW21fVYBZvRfTypb228qxLxitkQ/ohpvMJuJidr
         WkY2Ux/FAKNCTOiuHz+aMUzK6MqhVdrFg5Myp/a5CxZdbmdZyFTcbvAu8Qag6I/BkwKK
         rLmQ==
X-Gm-Message-State: AJIora9RQwrD8SN52QklZp3mXo4TguyfM6LvMfn35Z2454DGVo4MCkOe
        gRSyFuJItUETeK68pifvlg4yYw==
X-Google-Smtp-Source: AGRyM1u3mPVv9tLPHuraiJXYGakA8OSJV1otrdE7dZHmWgQ8rMN06jOfUwrVjHL4Mk4I8uCfoPlhXw==
X-Received: by 2002:a17:906:2252:b0:711:d2e6:9e7e with SMTP id 18-20020a170906225200b00711d2e69e7emr3797696ejr.161.1655909999464;
        Wed, 22 Jun 2022 07:59:59 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lb13-20020a170907784d00b006fa84a0af2asm9696187ejc.16.2022.06.22.07.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:59:59 -0700 (PDT)
Message-ID: <d7da5034-a2a5-71d1-5898-4a110d495638@linaro.org>
Date:   Wed, 22 Jun 2022 16:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/6] dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
 <20220621160621.24415-6-y.oudjana@protonmail.com>
 <CAA8EJprQTiU+=ajKSWbFfbHuVxjEiybTPNez66Ob+4YZ+fXW_A@mail.gmail.com>
 <XJ8UDR.9Y06T8FUTMOH2@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <XJ8UDR.9Y06T8FUTMOH2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 19:28, Yassine Oudjana wrote:
> 
> On Tue, Jun 21 2022 at 20:07:50 +0300, Dmitry Baryshkov 
> <dmitry.baryshkov@linaro.org> wrote:
>> On Tue, 21 Jun 2022 at 19:07, Yassine Oudjana 
>> <yassine.oudjana@gmail.com> wrote:
>>>
>>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>>  The clocks currently listed in clocks and clock-names are the ones
>>>  supplied by this clock controller, not the ones it consumes. Replace
>>>  them with the only clock it consumes - the on-board oscillator (XO),
>>>  and make the properties required.
>>>
>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>  ---
>>>   .../bindings/clock/qcom,msm8996-apcc.yaml         | 15 
>>> +++++++--------
>>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>>  diff --git 
>>> a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml 
>>> b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>>  index a20cb10636dd..c4971234fef8 100644
>>>  --- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>>  +++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>>  @@ -26,22 +26,18 @@ properties:
>>>
>>>     clocks:
>>>       items:
>>>  -      - description: Primary PLL clock for power cluster (little)
>>>  -      - description: Primary PLL clock for perf cluster (big)
>>>  -      - description: Alternate PLL clock for power cluster (little)
>>>  -      - description: Alternate PLL clock for perf cluster (big)
>>>  +      - description: XO source
>>>
>>>     clock-names:
>>>       items:
>>>  -      - const: pwrcl_pll
>>>  -      - const: perfcl_pll
>>>  -      - const: pwrcl_alt_pll
>>>  -      - const: perfcl_alt_pll
>>>  +      - const: xo
>>>
>>>   required:
>>>     - compatible
>>>     - reg
>>>     - '#clock-cells'
>>>  +  - clocks
>>>  +  - clock-names
>>
>> I think we can not list them as required, as then older DT files won't
>> pass schema validation. But I'll leave this into the hands of Rob and
>> Krzyshtof.
> 
> The old DT files that didn't have XO defined had a wrong
> compatible string to begin with (fixed in [1]), so I don't
> think it's a problem.
> 

Reasonable.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
