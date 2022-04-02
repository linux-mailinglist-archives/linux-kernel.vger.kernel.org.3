Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3354F0448
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354064AbiDBO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356922AbiDBO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:56:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7C14DFE3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:54:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so11462736ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aEIBC1GQYG6ijVh1cs6MgxygYsFjf5D+o3BDcAwed1w=;
        b=fK7dYpXSAmfp++dOrOjSwwgcGioBHc9fdWDTOqW2XfzK0MWWNTg2CJjED/AKxpil5w
         PK5rkRWUwI0rq2A75PMMjDZ5XdyAmvjiWXZjU/3At9DDHq63ids721mQTBsme5t9GP9N
         8MbSHuM0/H3LisI3vami7E6KZyTngZESULBzJVilF4jDcGj2R2iZnV0aupw/QJeMy7sq
         qOX1J+QRFoochHMrOIP7XtqikdVhrNJ0TUTD/1xsDJV9YlweaJ7KF43HcqiS/9/CPuzB
         px6L5xlob9c7lFY6aGhM61Tu2+MUo7aUbBVSC5Vo1kjInGBCo8QT6UE1W6jFZsyzA3d+
         r+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aEIBC1GQYG6ijVh1cs6MgxygYsFjf5D+o3BDcAwed1w=;
        b=LlHk37hVRdGVhLMUnnRzTy5l0yi4oCLho+G6NOVovcNycdXu7lESoIh1r7o+TU80p4
         wcub4TY7DvrXl+cEdqkJYuFHp1Tol4DvqZru9g2aeQAjYBDLRUsnJjWfQVAvypS6C+gt
         3+j1ck+1VGUVxVzw6xgPYHCpGpBFJhdFeRKsV3qJC1eOEM4MeBeTNul41bJogrT7N64s
         tQh8yXrD5p2jejHjkNQwUPJt3vNIo5ifrGsDuBlOkYdYOtqRLMPjDb80HG0/7nPXPrh8
         1Z8XGm2FqZlcuHFK4cUoCzwKhk9cr3346dn0yeVfvNWAfA0VsFbIc8HvuP+5ZkdEEdGT
         fG/g==
X-Gm-Message-State: AOAM532pJ0R7dy9vnyCSCpNd7FZ1+P3dmzMen0NqNcOjfoz6GNaiodZa
        +Qk3M84KrOwZidFsISt83Ze6ow3zICl/iF86
X-Google-Smtp-Source: ABdhPJxiLi2YcERcQnKzC72c/xfDbvVF2UNZKN62Kk4fjKbrJNpjV9egpTPWqHnbkbDT2ujFImYLwQ==
X-Received: by 2002:a17:906:1603:b0:6ce:362:c938 with SMTP id m3-20020a170906160300b006ce0362c938mr4148843ejd.253.1648911275414;
        Sat, 02 Apr 2022 07:54:35 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f1-20020a056402194100b00416b174987asm2554089edz.35.2022.04.02.07.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 07:54:34 -0700 (PDT)
Message-ID: <23d363ab-1b95-4995-ac65-7a3a2d442982@linaro.org>
Date:   Sat, 2 Apr 2022 16:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 08/10] dt-bindings: soc: qcom,smd: convert to dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
 <20220401201035.189106-9-krzysztof.kozlowski@linaro.org>
 <1648907211.831405.903501.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648907211.831405.903501.nullmailer@robh.at.kernel.org>
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

On 02/04/2022 15:46, Rob Herring wrote:
> On Fri, 01 Apr 2022 22:10:33 +0200, Krzysztof Kozlowski wrote:
>> Convert the Qualcomm Shared Memory Driver bindings to DT Schema.
>>
>> Changes against original bindings: enforce only specific names of child
>> nodes, instead of any names.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../regulator/qcom,smd-rpm-regulator.yaml     |   2 +-
>>  .../bindings/remoteproc/qcom,q6v5.txt         |   2 +-
>>  .../bindings/remoteproc/qcom,wcnss-pil.txt    |   2 +-
>>  .../bindings/soc/qcom/qcom,smd-rpm.yaml       |   4 +-
>>  .../devicetree/bindings/soc/qcom/qcom,smd.txt |  98 -------------
>>  .../bindings/soc/qcom/qcom,smd.yaml           | 137 ++++++++++++++++++
>>  6 files changed, 142 insertions(+), 103 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smd.example.dt.yaml: rpm-requests: 'clock-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
> Documentation/devicetree/bindings/soc/qcom/qcom,smd.example.dt.yaml:0:0: /example-0/shared-memory/rpm/rpm-requests/clock-controller: failed to match any schema with compatible: ['qcom,rpmcc-msm8974', 'qcom,rpmcc']
> Documentation/devicetree/bindings/soc/qcom/qcom,smd.example.dt.yaml:0:0: /example-0/shared-memory/rpm/rpm-requests/clock-controller: failed to match any schema with compatible: ['qcom,rpmcc-msm8974', 'qcom,rpmcc']

These are being fixed by patch 9-10, so their order could be reversed to
avoid the warnings.


Best regards,
Krzysztof
