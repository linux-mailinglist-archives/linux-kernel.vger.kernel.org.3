Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25B959E498
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbiHWNnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbiHWNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:42:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECA81F7E25
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:47:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bt10so6122400lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=RN/LOwAs0mnCfns8ZqSzFQO5l9T587JWTtmjgOoDJU0=;
        b=Py0wMtQJoUAEqHG39bdO2l0BFyd5gIb/rukM60FnZ1hchbdZcz/+uZHBv+PwZYsYHD
         KPwGaoEP4kJMY7TN5kh0S2PbU/GtEAZFI6/GWecCyniqreT6ulMrcaAexk8rNouQW+pC
         r2mpDu584TwrHqn6lCYfsCPZwrvgPTkIImrUO6nDjdM3TUwkrCUnEZ4JeI+Y7RDYZR4L
         9/nnSDO1kK59WzFrgxbHwSPItaD3vOteBcPpxjbHQlyhLUNEWJGEX904OANzDvl/GJx3
         XZgFnoOeWES7ce7ypMcQRWjqXoYyvB83wxa1ANQHzbjoC8isWgnJ+MVhgQkN8od+6iNh
         LUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=RN/LOwAs0mnCfns8ZqSzFQO5l9T587JWTtmjgOoDJU0=;
        b=ygn46ksjUUGf/N/ZhG1STEAJc2G8WtnBCv7B5ljmm4Cp8TkEsb8dpOyzBC3OvmLFcC
         AVw8/dY9gnojCYcaqAi0eWtHDcRfAGuwFetd6jb3cG3/oVkTfg26BshjTCMO6T61REsR
         pCpgv3r9gY/v8AInWpqj4frDWVAX0sza6+Znx4N/I0hN99JynSA46IV6UuwySF6c/Jcz
         fnvreUGa3QkneVlLS7+wf1qD6EAT6HBUMgXf22nBOK6g6ZYm07qjE6P0zyljhsjH2jCl
         FPHjGJs0RbJEKmGLayE20vt75sp1vOVJczr858f8Xr+jPVxu3VTfgvEY4wgtBi9mjztZ
         tfFw==
X-Gm-Message-State: ACgBeo3fmOKU8pywWbZ1+OQ9zUofxEJ5hdwSGkOO+vLGzVuk8iT9O/I1
        sghG11eCKXlQ49bh7b/Ks60TkA==
X-Google-Smtp-Source: AA6agR7X5sSiNq/i+Hdcr45vvYQkfwChkiEwFRHa/+jS1NGRNkHqhXgoDdJQhIB3VWwSaYKrwvZ2Ew==
X-Received: by 2002:a05:6512:22d5:b0:492:cf78:59b7 with SMTP id g21-20020a05651222d500b00492cf7859b7mr5862437lfu.504.1661251564314;
        Tue, 23 Aug 2022 03:46:04 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id t14-20020a2e8e6e000000b00261af4754bbsm2299173ljk.41.2022.08.23.03.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:46:03 -0700 (PDT)
Message-ID: <019d8f8a-cff1-4539-dc9f-8a0073b6ab32@linaro.org>
Date:   Tue, 23 Aug 2022 13:46:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 3/6] dt-bindings: net: dsa: mediatek,mt7530: update
 examples
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sander Vanheule <sander@svanheule.net>,
        =?UTF-8?Q?Ren=c3=a9_van_Dorst?= <opensource@vdorst.com>,
        Daniel Golle <daniel@makrotopia.org>, erkin.bozoglu@xeront.com,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220820080758.9829-1-arinc.unal@arinc9.com>
 <20220820080758.9829-4-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220820080758.9829-4-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2022 11:07, Arınç ÜNAL wrote:
> Update the examples on the binding.
> 
> - Add examples which include a wide variation of configurations.
> - Make example comments YAML comment instead of DT binding comment.
> - Add interrupt controller to the examples. Include header file for
> interrupt.
> - Change reset line for MT7621 examples.
> - Pretty formatting for the examples.
> - Change switch reg to 0.
> - Change port labels to fit the example, change port 4 label to wan.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../bindings/net/dsa/mediatek,mt7530.yaml     | 402 +++++++++++++++---
>  1 file changed, 347 insertions(+), 55 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
