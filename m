Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5865888F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiHCI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiHCI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:58:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE282251E;
        Wed,  3 Aug 2022 01:58:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ss3so30199431ejc.11;
        Wed, 03 Aug 2022 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FMuEkX1cuR0fLJAj2NpiHvom9cpz7zgbO733+2J3n5M=;
        b=SGxUTOZjt0kkWQ0YjILDWUI/iQqjmr3lP5rGPGLbXvgH4MKcyRQxOsgrMBGXjzgiQs
         MZczp4aP+enl8+HSdrOxgT7hZVQWujXQtUTtxkt8jVyvzBjleWLu7intoXYVYAys7SQD
         GbBhJGsZtpfj0L4OlcdxSRh+N6KkhQb55I82p2H1sBrneUOEc3dybg5/vKjbA94+iqs9
         G+C22iqkWncYAEguobYF1jfeN945IpC/2DsxfI0TFp/BRIS7cnoezkIuGrBETHv6glSn
         0K8YF5IW5wL9waVGwWi/y3mdabmKLB0MewSpccRL2paQoR/LQ7iMZG0DaJUU5MuCi71A
         +G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FMuEkX1cuR0fLJAj2NpiHvom9cpz7zgbO733+2J3n5M=;
        b=KIkJ+UhW0DgUNQe+jiYiqN0lvDWXM0yAodhVB/58HsvBurrYVFwK/ZSSyl9L6ef79g
         cSue8CaS942qEdumAP3s4wJH4vPzpz1Ugkg5q3oy+3kISM9ZTMXpz6YFM2UbYRgq4hnn
         xFUhkyKmlkmoWPF7n36tHZQmvatvlOZazKJoHFPNhHRnr4YWC1ohzzK3mO4rs4DvLVv9
         A2mSrLuUbokupDSlhfblqgeLhvmeSfjBgWqRZf7SpWmY+JAzoBfVg0lCQnY5+KRjMni8
         KxwM/gDsVCB5t9qO3PELuGR9A+Q7ktxExmjgkB/98/qxDgmHPdV7NhEetB/zfgTgcukj
         PZNQ==
X-Gm-Message-State: AJIora/IRu0XMT7nAmi1bxFOyoWsvR3pV/Rb/EY/l0cT+LtPsb0f+H3j
        s8B5eOnH8TvCS6b4wM6IgtKS0wYaRbV7tE0J
X-Google-Smtp-Source: AGRyM1umGkFw1eJ89UsPMftjXKOKWWCI95hu2K2npgGE7MmsfMTI1ig5d5ii1qqw/Bj3tqnGkBYShQ==
X-Received: by 2002:a17:906:8cb0:b0:72f:6ce7:3a1 with SMTP id qr48-20020a1709068cb000b0072f6ce703a1mr18951830ejc.322.1659517108472;
        Wed, 03 Aug 2022 01:58:28 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090631cc00b0073086d1afe3sm3105293ejf.86.2022.08.03.01.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 01:58:27 -0700 (PDT)
Message-ID: <f44fc6d2-9d3b-2c37-15dd-d002dc09b7b0@gmail.com>
Date:   Wed, 3 Aug 2022 11:58:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 00/13] PM6125 regulator support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
 <89469b0d-e6aa-4d60-c93c-a99256f65445@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <89469b0d-e6aa-4d60-c93c-a99256f65445@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Iskren Chernev (13):
>>    dt-bindings: regulator: qcom_spmi: Improve formatting of if-then
>>      blocks
>>    dt-bindings: regulator: qcom_spmi: Document PM6125 PMIC
>>    dt-bindings: regulator: qcom_smd: Sort compatibles alphabetically
>>    dt-bindings: regulator: qcom_smd: Document PM6125 PMIC
>>    regulator: qcom_spmi: Add support for new regulator types
>>    regulator: qcom_spmi: Add support for HFSMPS regulator type
>>    regulator: qcom_spmi: Sort pmics alphabetically (part 1)
>>    regulator: qcom_spmi: Sort pmics alphabetically (part 2)
>>    regulator: qcom_spmi: Add PM6125 PMIC support
>>    regulator: qcom_smd: Sort pmics alphabetically (part 1)
>>    regulator: qcom_smd: Sort pmics alphabetically (part 2)
>>    regulator: qcom_smd: Sort pmics alphabetically (part 3)
>
> What is the reason for these part1/2 and part1/2/3 splits? I think you can collapse them into two respective patches, one sorting of spmi, another one sorting the smd regulators

The reason is that if I do collapse them the diff looks much more
complicated and it's not obvious that the sections are in-fact only moved.
I'm not sure how these are reviewed, but casually reading the patch will
not instill confidence.
