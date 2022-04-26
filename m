Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3650F108
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbiDZGef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbiDZGeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:34:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E5713F4D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:31:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k27so5861880edk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o60Xdt5/lIQwm3L1GGhGdikwdOr9Y2T0obDjUUJBvKM=;
        b=J5JP8COoziPIOC17a1AheYKEJ74nJMdOvTMVfjYEI62ywlbIffHES6TQyJ5BFbsjaK
         tY9ZyUKyb9v4HGphUo/lSTdBB3cioJKtkzd6i+n7lg4Zn1uTju1dAIwnS3f2Q+qzDS6d
         cB8OUjlNse0gs68Usif4169gsBrvcoKvNWM8ShCNQC9l8ns943iDaQO1cp3erX75a8q5
         ME5XfexVA2CzmiLdNs8XgcRIwqWsxTAHjM98eosxAtu5ovZ/VcuaouLPy5I2Ey+//Ok9
         jebbYJa9e/jOJ4HAf1lBwWUvCRN7R4R2a3BaaOlV82IOVI6z/tVhzK2TuFQyOtcY/jFQ
         KRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o60Xdt5/lIQwm3L1GGhGdikwdOr9Y2T0obDjUUJBvKM=;
        b=x6+xY2pka5hWmwag/JlcKyDYR21xK0dOTJA+jw4Y90tgpDT0mE07F+yGSnXACe1u7Q
         uIvT3kp0LDEY9USPGOMx9mjxTG++x71JPFPg7LBXBD1Cv2Ny3GGmD5W60j3P/2x73qsr
         0+EjXkvP9DBBM80HlZNEGk1AOumr7Tn/znVFksf86UwPtm4al4WvhK4KwHs46yPx+bZl
         D50Qrc9wMOAekZK7sIkQzdGs90R0GqRZGFOpWxfO1Kvfw1u4k78uICZURRuqLu6vIVIU
         wf8GC8Zpl6CdUEJI/OWj5QgB+o3Uxq0baEdGJs6ocgXrcqkjZA+HiYyBC2dzS9arDN8i
         g9UQ==
X-Gm-Message-State: AOAM532+aMIlm4hcTNl3WrdyDxymL10r9zbS+Xjkk9y8Yhf9iNbCuSxZ
        QOYZheXuasHQT/89NbeVqUtyqA==
X-Google-Smtp-Source: ABdhPJwxSeWO8cf9PYw5+0di2Y79/EaTY+pCk5EE82cxph/Dq3q5Z8dUFxTXDfTKxIZkq+xt1jrpKA==
X-Received: by 2002:a50:cd8c:0:b0:41c:bb5a:1c7b with SMTP id p12-20020a50cd8c000000b0041cbb5a1c7bmr22624009edi.351.1650954675180;
        Mon, 25 Apr 2022 23:31:15 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lb18-20020a170907785200b006efe7bb40b0sm4347749ejc.74.2022.04.25.23.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 23:31:14 -0700 (PDT)
Message-ID: <0169c4ac-fdce-29b7-553a-14dc7df532d1@linaro.org>
Date:   Tue, 26 Apr 2022 08:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/1] dt-bindings: nvmem: mediatek: Convert mtk-efuse
 binding to YAML
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lala Lin <lala.lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220425084800.2021-1-allen-kh.cheng@mediatek.com>
 <20220425084800.2021-2-allen-kh.cheng@mediatek.com>
 <e64bdca8-7b18-b450-830c-ca07946a73fb@linaro.org>
 <9d65b713e3ffdd34dcca532c4c97fa98b124bde4.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9d65b713e3ffdd34dcca532c4c97fa98b124bde4.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 08:23, allen-kh.cheng wrote:
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - enum:
>>> +          - mediatek,mt8173-efuse
>>> +          - mediatek,efuse
>>
>> Still no changes...
>>
> 
> I just want to confirm again.
> 
> "Generic compatibles should not be used standalone"
> 
> It seems we should remove mediatek,efuse and keep "mediatek,mt8173-
> efuse"in binding. have I got that right?

You should comment for which chipsets this compatible is and add a
deprecated:true. In such case it cannot be part of enum but separate
item in this oneOf.


Best regards,
Krzysztof
