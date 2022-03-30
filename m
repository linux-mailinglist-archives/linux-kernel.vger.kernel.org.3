Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E24ECA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiC3RZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiC3RZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:25:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C42419A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:23:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so42914066ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lFGRlwHO8DZZibuZB12Q3q0KJ9J4i7SsANciQNupGSc=;
        b=qmDLecCd01e+sSrDveD/6uh4obbOZ4dCAVLoJPSmmzz1LZ4bMUzbjb/H0fSGt/yfjL
         1VumrCZfzucXBtjQrS8+rOivK9x2vrGvoDO28RhS6trZxm+d6NYA97D5AenMLKoq65BH
         WEDmJO4plKw1PxvDGtZ73sPL2MTfFg731CdmQ2OS53pVU0JFi50ZgSPWtmfeOo1Qs6Kr
         bTEY4kyqtimxCysSqa4IxEXp8gaoJkaxgiXLrp34xr51BM634KcH3gteMqMVOXVw8hSn
         3Ekb6b2cWVgdHN7tC7/JWmCNsnlFVBN7MuhglKRKOErbzRuTFni8GxTrQ4kBDd+hPNqe
         qSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lFGRlwHO8DZZibuZB12Q3q0KJ9J4i7SsANciQNupGSc=;
        b=nU70Rgld7dXDmuhxEA7/fnKIUXZRiwnVOKdFXn5KO6c+yKrqblehK+FtO0vp54v4yp
         GN19+/n4mU+JnEQinCuJyLMtQljGKd+GeiePgBkJ8NRjAehGzj0RBfnBFOH7H3Vhf9cQ
         iTioYJOk0V9CKo+9Mp618VKajePC1s4hi8ef5qur5EVu8G7Xa8iOjNyYh1fHnuhyXnwW
         XOdVxh9WrYfOwlNoEzZRlW6WT93vXnN+hV9ZjZdQ+W2sjGmgF5DEnQaS7YJjWEDOFDuR
         3bvJybJYP2R9vcc7Z/whNT/RNfk8HgOInoHQjZPqqxdGKLnKCkoV/HtiPs1yoX56xEsf
         VrSQ==
X-Gm-Message-State: AOAM530r78+DIqk2pARc8gVy2PTa0G3nvWV1j9G9vonZwoiH8q/xdls+
        olZVDKZkncshe9Y3oLGADPQ45Q==
X-Google-Smtp-Source: ABdhPJxCRbp7lwdnmnW1b25GlQ1PLn901nDGWQR9xhR3YvHUEp60iNCTaurivkdMULoHearFSxrG8A==
X-Received: by 2002:a17:906:58ce:b0:6da:b548:1bbb with SMTP id e14-20020a17090658ce00b006dab5481bbbmr685412ejs.14.1648661017311;
        Wed, 30 Mar 2022 10:23:37 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090670d700b006ccfd4163f7sm8117582ejk.206.2022.03.30.10.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:23:36 -0700 (PDT)
Message-ID: <e1763b04-567e-8287-83bf-4d05b0193a5b@linaro.org>
Date:   Wed, 30 Mar 2022 19:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <YkSQY5NSYcov21Ig@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YkSQY5NSYcov21Ig@google.com>
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

On 30/03/2022 19:16, Matthias Kaehlcke wrote:
> On Wed, Mar 30, 2022 at 05:09:46PM +0800, Mars Chen wrote:
> 
>> Subject: CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
> 
> No CHROMIUM tag for upstream posts.
> 
>> Initial attempt at Gelarshie device tree.
> 
> This is not very useful. If you don't want to reveal much information
> about an unreleased device you could say something generic like
> "Add device tree for Gelarshie, a trogdor variant".
> 
>> BUG=b:225756600
>> TEST=emerge-strongbad chromeos-kernel-5_4
> 
> drop these
> 
>> Signed-off-by: Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>  .../dts/qcom/sc7180-trogdor-gelarshie-r0.dts  |  15 +
>>  .../dts/qcom/sc7180-trogdor-gelarshie.dtsi    | 304 ++++++++++++++++++
>>  3 files changed, 320 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index f9e6343acd03..cf8f88b065c3 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-gelarshie-r0.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
>> new file mode 100644
>> index 000000000000..027d6d563a5f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
>> @@ -0,0 +1,15 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Google Gelarshie board device tree source
>> + *
>> + * Copyright 2022 Google LLC.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sc7180-trogdor-gelarshie.dtsi"
>> +
>> +/ {
>> +	model = "Google Gelarshie (rev0+)";
>> +	compatible = "google,gelarshie", "qcom,sc7180";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
>> new file mode 100644
>> index 000000000000..842f6cac6c27
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
>> @@ -0,0 +1,304 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Google Gelarshie board device tree source
>> + *
>> + * Copyright 2022 Google LLC.
>> + */
>> +
>> +#include "sc7180.dtsi"
>> +#include "sc7180-trogdor-mipi-camera.dtsi"
> 
> drop the mipi camera include, it is not upstream

The file should not build in such form, so probably it was not tested on
mainline kernel... :-(

Best regards,
Krzysztof
