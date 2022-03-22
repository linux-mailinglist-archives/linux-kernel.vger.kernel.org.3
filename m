Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69AD4E45B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiCVSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbiCVSHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:07:06 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B234C430;
        Tue, 22 Mar 2022 11:05:38 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id p15so37983556ejc.7;
        Tue, 22 Mar 2022 11:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xBJ03RbkQ2mzOlnG3ngY0wg3ZtIL080pq1pFXF62OoA=;
        b=XF+awp6VFKRbPpLTaRct/HixJf7pIEmRCkDYsRG+1m/YYzBffmjT4McMI4TGdK/aCm
         PUaPWmjWsrSaOk4Q5lafFqVoKEFva+zXgrdLT5vHIc+wkB9GWiFj6zlSbFx9IHJrD/jQ
         tU8VEQVpQxv29zE8gxQ4pI2Hr3LLOaqiRDeTnopRzmcCtewmMyY6rFF2dzalvNTpF1Xr
         POBTsi3nXhWBGNM66apD2frOY/Fkk8/CmgJAP/dmMNKgrtX+mFTToUbvtdy/vl5JZruv
         KHHVtw1m3y1AaWLsPCNHp8+RbimaM98T8BcE4/A2uT7mSFP0cakxhZSGDxyMIGHYblp7
         yGxA==
X-Gm-Message-State: AOAM53371HuhPUxPUKXCkrx2Lu2cKMEWMraq1m9ewkk6ul3iE5zlsc/0
        05j/S/4NGZLG1Zd3H1cYhB8=
X-Google-Smtp-Source: ABdhPJw95gsYqtTGMcuFCiiZW9xd9E4ovb6BYDBpZBwyDT/tkLLn/dlfwhpTxOwXJ2rYmpNaZ30hrA==
X-Received: by 2002:a17:906:36ce:b0:6d6:e540:ed65 with SMTP id b14-20020a17090636ce00b006d6e540ed65mr27061623ejc.330.1647972336954;
        Tue, 22 Mar 2022 11:05:36 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id z23-20020a170906435700b006b0e62bee84sm8599506ejm.115.2022.03.22.11.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:05:36 -0700 (PDT)
Message-ID: <eb1b1702-5470-3e63-b0c6-70624c5c120b@kernel.org>
Date:   Tue, 22 Mar 2022 19:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 21/26] dt-bindings: crypto: convert rockchip-crypto to
 yaml
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>, Rob Herring <robh@kernel.org>
Cc:     sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-crypto@vger.kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        herbert@gondor.apana.org.au, linux-clk@vger.kernel.org
References: <20220321200739.3572792-1-clabbe@baylibre.com>
 <20220321200739.3572792-22-clabbe@baylibre.com>
 <1647913851.207213.941032.nullmailer@robh.at.kernel.org>
 <YjmS5DE95xTuJMi7@Red>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <YjmS5DE95xTuJMi7@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 10:12, LABBE Corentin wrote:
> Le Mon, Mar 21, 2022 at 08:50:51PM -0500, Rob Herring a écrit :
>> On Mon, 21 Mar 2022 20:07:34 +0000, Corentin Labbe wrote:
>>> Convert rockchip-crypto to yaml
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>>>  .../crypto/rockchip,rk3288-crypto.yaml        | 84 +++++++++++++++++++
>>>  .../bindings/crypto/rockchip-crypto.txt       | 28 -------
>>>  2 files changed, 84 insertions(+), 28 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/1607887
>>
>>
>> cypto-controller@ff8a0000: 'reset-names' does not match any of the regexes: 'pinctrl-[0-9]+'
>> 	arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml
>> 	arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml
>> 	arch/arm/boot/dts/rk3288-firefly-beta.dt.yaml
>> 	arch/arm/boot/dts/rk3288-firefly.dt.yaml
>> 	arch/arm/boot/dts/rk3288-firefly-reload.dt.yaml
>> 	arch/arm/boot/dts/rk3288-miqi.dt.yaml
>> 	arch/arm/boot/dts/rk3288-phycore-rdk.dt.yaml
>> 	arch/arm/boot/dts/rk3288-popmetal.dt.yaml
>> 	arch/arm/boot/dts/rk3288-r89.dt.yaml
>> 	arch/arm/boot/dts/rk3288-rock2-square.dt.yaml
>> 	arch/arm/boot/dts/rk3288-rock-pi-n8.dt.yaml
>> 	arch/arm/boot/dts/rk3288-tinker.dt.yaml
>> 	arch/arm/boot/dts/rk3288-tinker-s.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-brain.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-fievel.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-jaq.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-jerry.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-mickey.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-mighty.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-minnie.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-pinky.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-speedy.dt.yaml
>> 	arch/arm/boot/dts/rk3288-veyron-tiger.dt.yaml
>> 	arch/arm/boot/dts/rk3288-vyasa.dt.yaml
>>
> 
> Hello
> 
> This should not happen since patch 20 remove it.


From all DTBS in the world? If you want to deprecate a property, add a
"deprecated: true".


Best regards,
Krzysztof
