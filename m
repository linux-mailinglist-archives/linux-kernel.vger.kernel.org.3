Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B20352376C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbiEKPgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343789AbiEKPgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:36:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA16A429
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:36:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ks9so4881695ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s9lNfI7TcwVigUjSYULy3QOAhvngUhwQle5drwFbVL8=;
        b=UDgM/7CIdwpg7TQ80bRyU4TfD8ldDTOoKUvXkBAypeBetC/ZXehem74fuUzxgv+673
         bhZsUJVYmDXQBKCv9mVxNT8DkjGrWu575i4uN/rDyEsQmfOc6vQUpk0YNPBuYIog7qSF
         2P7vnyyI3dNCAXfw6r4b/OFSIbV3X72g+t/iC2ugWlmt63dHNsvUrFCQag+pIgIRSy/6
         X36SH1wzjqfPwgFhXAZvmlXcvWdB/VD/2hcsTQ/y3/3g4kKsewQPRK5kEV+ivnAT0Has
         XPQ1xpoU6Mm7OLy5zsSHsf7Du68T8Kp4P0usibTXcfIPsjW5zgQZt1EAuku2OITtLhZQ
         Qh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s9lNfI7TcwVigUjSYULy3QOAhvngUhwQle5drwFbVL8=;
        b=kaLHIxd3zmO6sxzlTDlTmDCOiVcdEGnXX0xggO6ffQTi16IRCnJf1vMXLLrS/kmCa5
         oLXd+yKqhMjjOQ8oN4lwO/aMHa7mRBApeT+IxmuDW7hZ6Z3vtbznBX+yyu35tfeQUOZz
         U1qX7oUdxlNynFHPrnvZhQSDknrjlU0M5srdeXtDMWJAxrBD/eMlI/BgIjkgMhbTlAEZ
         Tf4ytWx+oUjNcFGX3RZFcFl0UgcBnLjkkDV7DDzmumr8FC0A7oIrXJKSdiLMW/HkoUpn
         SeiDbmH7I2eIUyxgrVH3Wz46n8kfYiyp7kKp6t16cBB2K5ryfi9UWEsq//b2tWHv0xqW
         UMrA==
X-Gm-Message-State: AOAM533HO4tBNM8gAPsFKY9KxNJM+XxloO9f4/Y26iHbSMEBXglR7oWK
        264IUS+JuNaBof90XwZn3DQpkw==
X-Google-Smtp-Source: ABdhPJzGKntoTYFAsjQgyRo8QHUf6eZ/sVXe1HlTdWu11CGW4leRLMnpi935aU7hwUOVWkAuFyelPw==
X-Received: by 2002:a17:906:dc89:b0:6f4:d3a9:6862 with SMTP id cs9-20020a170906dc8900b006f4d3a96862mr25676309ejc.571.1652283396618;
        Wed, 11 May 2022 08:36:36 -0700 (PDT)
Received: from [192.168.0.154] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x1-20020aa7d381000000b0042617ba63casm1356919edq.84.2022.05.11.08.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:36:35 -0700 (PDT)
Message-ID: <3e5ddde1-9d0c-a5e8-1828-aef1d1165a3e@linaro.org>
Date:   Wed, 11 May 2022 17:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: pmic: mt6366: add binding document
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        tinghan.shen@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220510064603.15920-1-zhiyong.tao@mediatek.com>
 <20220510064603.15920-2-zhiyong.tao@mediatek.com>
 <6614cd3783666caa529106464e7684caf16d6582.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6614cd3783666caa529106464e7684caf16d6582.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 09:56, Rex-BC Chen wrote:
>> +examples:
>> +  - |
>> +    pmic {
>> +      regulators {
>> +        mt6366_vdram1_reg: buck_vdram1 {
>> +            regulator-name = "vdram1";
>> +            regulator-min-microvolt = <500000>;
>> +            regulator-max-microvolt = <2087500>;
>> +            regulator-ramp-delay = <12500>;
>> +            regulator-enable-ramp-delay = <0>;
>> +            regulator-always-on;
>> +            regulator-allowed-modes = <0 1>;
> 
> should be two space instead of 4 space?
> mt6366_vdram1_reg: buck_vdram1 {
>   regulator-name = "vdram1";
>   ...
> };
> 
> There is the same issue for this example.

Indentation is four spaces.
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/tree/Documentation/devicetree/bindings/writing-schema.rst?h=for-next&id=7a150b0d850e37e7bdfc87459edd0ff302f67478#n111


Best regards,
Krzysztof
