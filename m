Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A155538E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353276AbiFUR3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353708AbiFUR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:29:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278E64DB;
        Tue, 21 Jun 2022 10:29:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z7so20293048edm.13;
        Tue, 21 Jun 2022 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=tQy7cTmu/gQgDJkbt44xMaYq/OxSKXjoHtKVP2MMyy0=;
        b=WMjEpeEX2LsVXx0mNTwwQBoNqATYbZ1jZSD5BpylETPUBf0IVROfQr/8H5QKghEC6d
         6feqKilgc7a93eo4BHCUWVleR9pIpLXLYZF8m+GNzpGsOIc4OPblDLTBJrP/b7bWn6hK
         4fl01DBa9ANlk6AOzKE7Rj2FO+nlvEKrTtZqSCQr9dC49+SF3rOXOgqu4yh9UCmA+CpA
         eehaR5uAWWTpnawHYHH5fagM91pkSf21n54pqtBsj/nHREIAAbAYUjIDPcsObtLkAsf8
         q9mX7Pdd5ZyIfYUXBhjj1w2RexD2dFDy9hVrQVkP42vjB08oNo0F6J2djVhpIq1i+Uyi
         qwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=tQy7cTmu/gQgDJkbt44xMaYq/OxSKXjoHtKVP2MMyy0=;
        b=FXG+OV5pt82gxr9GBWlQAHxBEEEhybjXJhKSaY9GZpc5tzoybPxvicHvYbaGFKmhjw
         72/RKdBG2tuYIwO4K8oZF3GFza92ER4uE2vmfFArUpVkdstQhTIZvF0yuN3MQq7NrNcq
         E8l54dR+qpEbXYjC07q7QDpAaP1dXCVTg++HvkizaQ8NlqvWpoRCo44Vd1LJJqpHeQ5J
         fixwqBLnvMEgdYzGbYO03PxtsSqlPxoIR3vTusuIyME3p986ChKvFZHfeJelyUI4xdfQ
         9hJVlqDoP8eVrkYl0djAR34U37XKMg0KVIuOB7Q+ekQ/u0MIX+ujKxRzcmeInIUABuD8
         9Zeg==
X-Gm-Message-State: AJIora/qTWYYEb/gnIVhRPfRCXjsXqnDiAb4e0vrqGdpnETGq0WU9kLt
        Y8jed8r3mDysE4jTqE6qzJ8=
X-Google-Smtp-Source: AGRyM1thdqSzA0MP1eOFglefQAu9FQsKqWvKlZH2bgE+/+4N6AKakfltp6Ehcp4n8/1xAjHPLKB9Fg==
X-Received: by 2002:a05:6402:201:b0:431:665f:11f1 with SMTP id t1-20020a056402020100b00431665f11f1mr37689389edv.378.1655832547575;
        Tue, 21 Jun 2022 10:29:07 -0700 (PDT)
Received: from [192.168.236.247] ([185.107.57.61])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170907784a00b00722e84c3d44sm643352ejc.118.2022.06.21.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 10:29:07 -0700 (PDT)
Date:   Tue, 21 Jun 2022 21:28:45 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
Message-Id: <XJ8UDR.9Y06T8FUTMOH2@gmail.com>
In-Reply-To: <CAA8EJprQTiU+=ajKSWbFfbHuVxjEiybTPNez66Ob+4YZ+fXW_A@mail.gmail.com>
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
        <20220621160621.24415-6-y.oudjana@protonmail.com>
        <CAA8EJprQTiU+=ajKSWbFfbHuVxjEiybTPNez66Ob+4YZ+fXW_A@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jun 21 2022 at 20:07:50 +0300, Dmitry Baryshkov 
<dmitry.baryshkov@linaro.org> wrote:
> On Tue, 21 Jun 2022 at 19:07, Yassine Oudjana 
> <yassine.oudjana@gmail.com> wrote:
>> 
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  The clocks currently listed in clocks and clock-names are the ones
>>  supplied by this clock controller, not the ones it consumes. Replace
>>  them with the only clock it consumes - the on-board oscillator (XO),
>>  and make the properties required.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>   .../bindings/clock/qcom,msm8996-apcc.yaml         | 15 
>> +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml 
>> b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>  index a20cb10636dd..c4971234fef8 100644
>>  --- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>  +++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>  @@ -26,22 +26,18 @@ properties:
>> 
>>     clocks:
>>       items:
>>  -      - description: Primary PLL clock for power cluster (little)
>>  -      - description: Primary PLL clock for perf cluster (big)
>>  -      - description: Alternate PLL clock for power cluster (little)
>>  -      - description: Alternate PLL clock for perf cluster (big)
>>  +      - description: XO source
>> 
>>     clock-names:
>>       items:
>>  -      - const: pwrcl_pll
>>  -      - const: perfcl_pll
>>  -      - const: pwrcl_alt_pll
>>  -      - const: perfcl_alt_pll
>>  +      - const: xo
>> 
>>   required:
>>     - compatible
>>     - reg
>>     - '#clock-cells'
>>  +  - clocks
>>  +  - clock-names
> 
> I think we can not list them as required, as then older DT files won't
> pass schema validation. But I'll leave this into the hands of Rob and
> Krzyshtof.

The old DT files that didn't have XO defined had a wrong
compatible string to begin with (fixed in [1]), so I don't
think it's a problem.

>>   additionalProperties: false
>> 
>>  @@ -51,4 +47,7 @@ examples:
>>           compatible = "qcom,msm8996-apcc";
>>           reg = <0x6400000 0x90000>;
>>           #clock-cells = <1>;
>>  +
>>  +        clocks = <&xo_board>;
>>  +        clock-names = "xo";
>>       };
>>  --
>>  2.36.1
>> 
> 
> 
> --
> With best wishes
> Dmitry

[1] 
https://lore.kernel.org/linux-arm-msm/20210527192958.775434-1-konrad.dybcio@somainline.org/


