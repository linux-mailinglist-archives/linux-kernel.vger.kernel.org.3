Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90D157BC70
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiGTROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiGTROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:14:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1646EE98
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:14:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w2so21856135ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5RkpDfJmyBWfRHg2fVFR+/EdZ4rlvuqSFEKHbwoMbsM=;
        b=H+7FhV05lIhk0PGB4Z6gEALJjTiEw084oSQ2Ud8MgD/y8JOhBTo9CTroBwwYaV4KRf
         wo+T2+13vBg07aE5ZDkkmJIQREcaPEvxHTDK2GeS9txCcnfFeII3xhclMU7qdpgTtKpq
         Qv6x+YINWQAxvFegcEHp6NxYwoRPU6CirCLgAxMLhcSDQ2VkFe0yR+YwsEa4iv3KZpDf
         4S8Mu6emImwTEBRYFM5m/GSpYwNK9vR4HZsbk/6xWL0+7eMGpVBpFy+QpHoXc9ERr5CT
         +PZtNyIhcUhtAVC3NpzD3jCYEfxQ3IWW0HE8xTYTeZoSA1ssGYiIlzIpiARAdMOO2xNu
         wMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5RkpDfJmyBWfRHg2fVFR+/EdZ4rlvuqSFEKHbwoMbsM=;
        b=gDzBTS6jrGVibd13CbFBb+UMClUSLiKDUqDCM8lQi+2Fwex9BrVoWpItXttgyI+XYF
         yN1Q/o0P0xHvxObbFqG9qcapT0A/fX/vhB1TjuKZIAbNFP3CYT5RJamm1y0ZMzpHi5Mz
         V7j1iWwcsEv8A9Ng3Z8aVsBu8HbcdDiLaZZJl+zTLPRGdPDF4676mMJUkCMBtqFB29N5
         o4LZbPz1IeLq7bU5fVNu9mgIiJ6GtLTMKhTpy4/tda5AuAQ4GJLgoXjwN3G0hTog4M1o
         GpEJFOTOl/uMGn0i3+a/CIzt5EdTFWO2V9h+cnXDRgVAy7tEisDIsat8LwFEqJY/H64A
         JwXg==
X-Gm-Message-State: AJIora9g5rRXQ6SlV/PHWhMHPPKWVShxcsy+XB3/XBEDbCEZUoNs9wDT
        59rGgSEfTqNyRRJVfccCi3Ulag==
X-Google-Smtp-Source: AGRyM1slZ6hO/HAIyCG+31XwLnAM/4pQ8U2rWmJCFJJE6uLFgNQ5+vsUtnCPoRcx6jCpEMRuF7B7KQ==
X-Received: by 2002:a2e:9ed6:0:b0:25d:5cef:72c3 with SMTP id h22-20020a2e9ed6000000b0025d5cef72c3mr16423219ljk.381.1658337255308;
        Wed, 20 Jul 2022 10:14:15 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id d25-20020a19e619000000b00489c7fb668dsm3901824lfh.182.2022.07.20.10.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:14:14 -0700 (PDT)
Message-ID: <e1ec8511-d1dd-faa5-031f-50c4e55062cd@linaro.org>
Date:   Wed, 20 Jul 2022 19:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/6] dt-bindings: mediatek,mt6779-keypad: use
 unevaluatedProperties
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
 <20220720-mt8183-keypad-v1-2-ef9fc29dbff4@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720-mt8183-keypad-v1-2-ef9fc29dbff4@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 16:48, Mattijs Korpershoek wrote:
> writing-bindings.rst states:
>> - If schema includes other schema (e.g. /schemas/i2c/i2c-controller.yaml) use
>>   "unevaluatedProperties:false". In other cases, usually use
>>   "additionalProperties:false".
> 
> mt6779-keypad includes matrix-keymap.yaml so replace additionalProperties:false
> by unevaluatedProperties:false.

This is not sufficient explanation. You now allow all properties from
matrix-keymap.yaml, which might be desired or might be not (e.g. they
are not valid for this device). Please investigate it and mention the
outcome.

Best regards,
Krzysztof
