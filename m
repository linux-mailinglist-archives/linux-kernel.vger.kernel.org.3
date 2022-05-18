Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0E52B70D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiERJbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiERJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:30:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A97A5F9C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:30:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id i23so1811192ljb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pEuG856eNrPsEk24LF5334+ERuSyEbx0udXSOjyyo+A=;
        b=jadEy/jwRZ8a/utyj7rT19tioRyAuF1iVtBo/+XjTN2yD0RdlZHtiF3DGgFlKWMtKJ
         D90u8Ym3Wpyw4sshRoIAE2UtdzchOB3LXtGiEVO1HwGcumHK6c9eSdg4F9Xm2RlCaV92
         mzmV0YqOt8ZXetvXzlxy+epqZSBQ7T+ii1rfgcSO1IqCPUFKRkYtg69bkrCzmQqoKVcO
         xa+4V9hL6OH9jqmAqTMvOqaHizpC/VnOoEk4QxCzgfHRvpOH6f7CgsyO4aoXLvazbR6J
         Jq5z4Yn9Lrsv+J9jQHQtcVbPhmGQSHddCbQ1cYtgeT4KWnXg1SoMaDGmZpeNkv97/83j
         vtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pEuG856eNrPsEk24LF5334+ERuSyEbx0udXSOjyyo+A=;
        b=HOLwRmcpGVM3XU5x8lJLTt/vASnmA2ILOjMrh5twz1DqvHc3+a+yaBl3MeIE/TxDTR
         1AX8EeoCTWax++U2y3nyoVvat5f2VIPTc4Gq1jLAle/dWvsFTtmKkG9fs5DIhwSYkcRX
         LNrjcKDJH5TnHrjzDjdSNuLoJ/A5guJ15Gsdb8Ogf7ItN5vyb+D1W/Kk5As9PUqvu1lu
         cRJ7XyJxBAGWJXP+2uL5JXEq7RvfCDR+C4nEv42DPUMqYPGmcLt3EsYqp1SYFrLmpS/6
         8mH6r9OfDHP5+en3GqeDYygcP1fr0EZeALGrU0uvh9Gep3f/4h4/aG67KvzP5bp8vzRp
         PUmw==
X-Gm-Message-State: AOAM5309LqX9d6VGj59KeMvRwrX09k+2/8z/BLHDBGLme0/zQERcPT19
        IhChhRg3E99sOfCnUeS3xgdoJw==
X-Google-Smtp-Source: ABdhPJyosrAxGczRVd6cfbCathJEWKApPLYPS9ky7y9dpYiREXQPMjHhIba3HPS92kh/mgUeLQdcqg==
X-Received: by 2002:a05:651c:893:b0:249:4023:3818 with SMTP id d19-20020a05651c089300b0024940233818mr17392024ljq.44.1652866241430;
        Wed, 18 May 2022 02:30:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651204cd00b00473f03f22a3sm154234lfq.58.2022.05.18.02.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 02:30:40 -0700 (PDT)
Message-ID: <74b97963-3937-66fd-18e2-29278a99d706@linaro.org>
Date:   Wed, 18 May 2022 11:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/6] dt-bindings: arm: mt8186: Set #clock-cells as
 required property
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sboyd@kernel.org, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
 <20220517101514.21639-3-angelogioacchino.delregno@collabora.com>
 <1cec6a09-9d80-99e7-ccc4-c918c6be7dbb@linaro.org>
 <5100b851-6787-fed8-a40f-7e6e64a123d8@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5100b851-6787-fed8-a40f-7e6e64a123d8@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 11:24, AngeloGioacchino Del Regno wrote:
> Il 17/05/22 16:34, Krzysztof Kozlowski ha scritto:
>> On 17/05/2022 12:15, AngeloGioacchino Del Regno wrote:
>>> This is a clock-controller binding, so it needs #clock-cells, or
>>> it would be of no use: add that to the list of required properties.
>>>
>>> Fixes: f113a51aa2cf ("dt-bindings: ARM: MediaTek: Add new document bindings of MT8186 clock")
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   .../devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml  | 1 +
>>
>> If these are clock controllers and new bindings, why they were added to
>> "arm" directory? arm is only for top-level stuff, not for devices.
>>
>> In the future please put your bindings in respective subsystem matching
>> the hardware. Fallback is soc directory, not arm.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
> 
> Hello Krzysztof,
> 
> I agree with you about these bindings belonging to the clock directory.
> Should I add a patch to this series that moves all of the mtxxxx-clock
> and mtxxxx-sys-clock yaml files to the clock directory?

They should not be added there, but no need to shuffle things around...


Best regards,
Krzysztof
