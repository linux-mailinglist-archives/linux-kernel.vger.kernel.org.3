Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75185431F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiFHNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiFHNxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:53:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B8A290B31
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:53:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y19so41620355ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8PRvjGp7UM9Up4FPr/47yKpqJbueu9nLy8SWPr8RszU=;
        b=oeYK2TKyzTiHgPb0Dxk0KGifXeFTRCAUSuakM69XasAGQPYPgc12KOWBmpYN2gDoke
         LTqyvBarNMvXqzOY9EPoKbLU5GzS4PpqcFVuJ6WAHheXl92bmY8CjAD7rL8QQ+NeMARJ
         CSC2VO1DrTmtqqB++NgkBd2ji3C0k7WM9WFn8ImnO4DbPu7MprpDZ5zdBE1Q6p4Npkv3
         RKvDGo3L5mMUqVPDd1Kf4QdwYwsaCJhR0VW/ZzRn78owqIDsNpg3iU0RbHodXLqvihDu
         fL5+uZNhees0fnqMHrV9UZezIboKwEQvJMtgxo+Czqzjp/MWvZowXF3q+jOVH6a//A8n
         7B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8PRvjGp7UM9Up4FPr/47yKpqJbueu9nLy8SWPr8RszU=;
        b=Xzou4f9bwh6xm1YeGH3He8F7wcwiLkU9CKPB/tgkzqzplXgjsNkJpo4pEuAxSnBnkf
         PHI5bs0gITMpC5AM/v9T3/hoggZC4nxllz9HtaGnmug+VocOtsUj/6uYgJTgtMhUiIVM
         DpOroDwzmRZeL6uc2B2Q13CTxD5qeeYRHCFatSGtieIkb5Y3O4yD8OTNpsaau50x5AMp
         muoiMsPIh+XOEcrHusWfy9+GEIch6RFl34jdge0KrV0Xf3DjwRg180zPJWjX54Ge+ZDe
         k8tHWJEFqbI9jPee2mWAL09muGTi+vaTS7w4g3YM6fGUdMpC23Gu6WsPmgkZdmleq+95
         Ac7Q==
X-Gm-Message-State: AOAM533u+MOvvf7Zor6mU3KmGMO3swhyCgOAOb+2XD3RhBNDJBWHtSOE
        by5mZh09YMZ7aQ3OrlMze+Rc9w==
X-Google-Smtp-Source: ABdhPJx+WIlX+erT9aZp6OAxsFgDVMszu6osL+HV/P+oQlmpJonKqTmPCso5aR/gBNmm3QuJ8eDpMQ==
X-Received: by 2002:a17:906:586:b0:70d:9052:fdf0 with SMTP id 6-20020a170906058600b0070d9052fdf0mr26345021ejn.633.1654696398125;
        Wed, 08 Jun 2022 06:53:18 -0700 (PDT)
Received: from [192.168.0.193] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906198800b00711d5bc20d5sm3492785ejd.221.2022.06.08.06.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 06:53:17 -0700 (PDT)
Message-ID: <4efa8494-53e0-90a8-6fc3-75b0bc0adaed@linaro.org>
Date:   Wed, 8 Jun 2022 15:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom,spmi-temp-alarm: convert
 to dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
References: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
 <1654695907.406371.1272093.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654695907.406371.1272093.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 15:45, Rob Herring wrote:
> On Wed, 08 Jun 2022 13:27:01 +0200, Krzysztof Kozlowski wrote:
>> Convert the Qualcomm QPNP PMIC Temperature Alarm to DT Schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../thermal/qcom,spmi-temp-alarm.yaml         | 85 +++++++++++++++++++
>>  .../bindings/thermal/qcom-spmi-temp-alarm.txt | 51 -----------
>>  2 files changed, 85 insertions(+), 51 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> temp-alarm@2400: '#thermal-sensor-cells' is a required property

I should have ordered the patches differently. This is fixed in second
patch.

Best regards,
Krzysztof
