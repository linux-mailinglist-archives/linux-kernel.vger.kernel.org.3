Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3026751FA69
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiEIKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiEIKuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:50:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0C18B31
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:44:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p18so15752094edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 03:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M2N9dAOBTm5M6ZFIRAQY9u+xLQ0LwoCVpAUO7hGxwek=;
        b=Pk61C9v83GjAFziN/8+zsxk25G08lVx7cudhCioDNnXyrKIV1KL4djTZVp1DChfx5p
         FcWhQhBnsOAoooH2GOHBO8y+b5gmnYM8odQNXrQhYNxHTYOQi+WHI88u0Du0Fs77HD5A
         HbqcS7wB3CVVilddsZh45uc1iu1GSP6fDMRjYfoK0Mp9G6/Cw1qpGJP23+cUTOUBSMuN
         EVU+x8T8/cT/LL02P0M9oWcT8go75notJSjcBirQkdAt8Jegk1EbMEzBnBdiExmn+RuY
         WwEBLj5ehki+d0K/MTG8ep6LT9iuLqfT8LcjJGXlEaWzS5zi3GnytzfmpMn5jup/xEcI
         Xp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M2N9dAOBTm5M6ZFIRAQY9u+xLQ0LwoCVpAUO7hGxwek=;
        b=QKXO9t9ySqsEQpiUJJ4SOzJ9uwrSjRNWhiNeYMktaphHu2MHLPRdwZni0XJQb4n7yE
         yP1SqiAOU0edqNDm37Ei9bIrqfyUQgb3IR0qBbiA0xoRuVcnT4cK58BLyfhR8bkEVpOy
         eCK/aNfvwTST7aAFTOtdH1aFkokJVwHsiXr6lff1zgd8aJE8z1U6DkIAedxsSNJdlO0U
         XyrdPtgcg6RVMVRQjUrrv4gj8FW7VAeanKCvLJ9spA53jh/lgW8kYbcY1H9MwNUNrAhW
         zl8/jR5djDJYaLnuMPOXngOKHxyIwGAv0EkqvoSW4L6Z427CeowsoHXcbNmF4s/ItnVu
         ZsBQ==
X-Gm-Message-State: AOAM533EBLqaxEVQPZ/an9yQdtQMgPbMV/7a7gBrXIcJ45/sbfQYDEHn
        0UfqVU7k26S2GpQRU6hhjdN4JfMFeslZbmdl
X-Google-Smtp-Source: ABdhPJzzU6EC/aUpRD8D0fRRVVTzWv0vos1RTFGbs9TdRMKFyYlif1jkB+mJxvflJy3XSnfkDqFDeA==
X-Received: by 2002:a05:6402:2397:b0:426:4967:8574 with SMTP id j23-20020a056402239700b0042649678574mr15621823eda.197.1652093085832;
        Mon, 09 May 2022 03:44:45 -0700 (PDT)
Received: from [192.168.0.243] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e15-20020a50e44f000000b0042617ba63c7sm6152351edm.81.2022.05.09.03.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:44:45 -0700 (PDT)
Message-ID: <98505974-afad-9639-d4f2-814097b0523b@linaro.org>
Date:   Mon, 9 May 2022 12:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/3] dt-bindings: mediatek: add ethdr definition for
 mt8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
 <20220509044302.27878-4-rex-bc.chen@mediatek.com>
 <46bc32df-e4e8-ac47-426d-8056714f0d5c@linaro.org>
 <5462209c5afb0a638ed777ec1829bb2717c8d76e.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5462209c5afb0a638ed777ec1829bb2717c8d76e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 10:54, Rex-BC Chen wrote:
>>> +    soc {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        disp_ethdr@1c114000 {
>>
>> No underscores in node name. Generic node names, so display-
>> controller?
>>
> 
> OK, we will change the node name to ethdr like in dts
> like this:
> ethdr0: ethdr@1c114000 {
> ...
> }

Is "ethdr" a generic name? Is it an abbreviation of "EnergyTrace™ High
Dynamic Range"? If yes, it also looks specific to Texas Instruments...

Best regards,
Krzysztof
