Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284DF590EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiHLKMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbiHLKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:11:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15527A0306
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id by6so474298ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=X3Z0i+bzqyd9jkgK2caR27Vz7nwccHaSiGiUTsoE8nA=;
        b=vAw/iHE6ytIOXRXjeN67GwiSEbQA0ctQIwMNSnUafKvpOuljVrJ7vzVm/7sbrBA0Rq
         9W2cgG+jL3RBmB5NEcyu5lMUuVivS36k1XHf3AlImINw7POiSJHt+k0cjXeXMWbzjzI8
         4DbWMTdY2CckYmFjISEC/JQhcrDAU2nl5yNlK37oSg0oRL2rRaZai16iBru+0FbR+THZ
         MHA+XhzhYLsqP/KcE8q+o7RlrZWIg0wVz6878gIJjP33XJbt139OIFaens+nMgkZLaxa
         XpEwjB21sqL5KTW4ekDFDt/YmfuRamdGpkj8VUxH5NlvNTEq0vQZgMQLOYrs6CSzdkpO
         y7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=X3Z0i+bzqyd9jkgK2caR27Vz7nwccHaSiGiUTsoE8nA=;
        b=UoeXtSVa0r88S9ikb3lOseLPic5UPn5ZaEfVIeaGPJ0+OM8V8FgZRsYsqYiK/sINX+
         IUdmVpa8yDzGTDZnGBoh/MeC+RbMKwFbjhYm5u3Md/crFqgXnYtOzL4aXd3LLxYJi1M2
         fIwdiTHky/EsXPr5qnOu+pU+b/f37HV6hqbbc3GJ++dKnFtS4IhJOTWZ9L3LMSi2teMr
         zLTp4FnjbiLPNBisNfe6xwe+GvrUs5Ewxyiz5Larw21iEgqoyxLxahCUQf69fcaHyLsZ
         kq7HcHygeMxqofLxl0Q4VVlez6Z4QounHcimueEwJujdhCsd/3gZb5Yyk0DcUUWHid7s
         PcOw==
X-Gm-Message-State: ACgBeo23qcygReLbOa/8vXhN30vz94F4brn08phBFYDoNyxoDN66vC+t
        jr5WQZZSgd2h9rTqRbO3jLvvoQ==
X-Google-Smtp-Source: AA6agR6qtRCwidZpSuqbgG905ivGtqwXa5YBWgMlvaWcKMi1Z7GJ4rwJwfHHDDGohyfeQPJ4RGY2/A==
X-Received: by 2002:a2e:a7d4:0:b0:25e:cc18:caf7 with SMTP id x20-20020a2ea7d4000000b0025ecc18caf7mr874022ljp.107.1660299115508;
        Fri, 12 Aug 2022 03:11:55 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b0048a1f17916esm155162lfb.300.2022.08.12.03.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:11:54 -0700 (PDT)
Message-ID: <f596077e-81d2-211d-258d-7fa7be85d759@linaro.org>
Date:   Fri, 12 Aug 2022 13:11:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/6] dt-bindings: i2c: i2c-imx-lpi2c: add i.MX93
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, aisheng.dong@nxp.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20220812043424.4078034-1-peng.fan@oss.nxp.com>
 <20220812043424.4078034-4-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812043424.4078034-4-peng.fan@oss.nxp.com>
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

On 12/08/2022 07:34, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 LPI2C compatible string.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
