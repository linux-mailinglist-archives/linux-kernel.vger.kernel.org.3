Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E407534FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347384AbiEZMyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243565AbiEZMyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:54:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574DEC5E7D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:54:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id wh22so2852862ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jEnJvB+XBclLjbaDlwzX4FK9+HMU9DqoCc5eaysM7ns=;
        b=xgAZK4q4/M/LFSxErbc+IB4AwVljcgSb+Dnm5HujosWBdM0afMeiebe/uzAh5EzIKB
         WMIoPx2mMZe15h7gVTQhYflFgfplC8sid+bgzttXwSOk3kPRbuv813wSkgt76qA6ZkRR
         NNKxXlVcE8E+lbyxKbpxwIpb2/wcFQkrIuBpyX7brrXPTGehz5GYDDGNtVuHvjHgZESx
         UwdrmfRG8fZJbCbqMM1RuH6VUe6/6ZfSVA0pFxwOubYUeJ9JLvIOMG97ZEtkV9o4aSJp
         0L+nqK8AyvbmuBtD837aAOvK0F1LTSOXZZa1uhlQSYWyZGPN7z9T/ruRBqSNSfPmESLt
         dnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jEnJvB+XBclLjbaDlwzX4FK9+HMU9DqoCc5eaysM7ns=;
        b=xp4cBcTQL4zMQJGJOPajy8SwlozU5eK/15I6bZOvIMGJo6KKW/aV6irZaThcfDd6Sj
         b/UC0LGqC7UnQBy3uHowNG/JKYxDEKjaHnELHpxjKvnrFJXpL54zuv9hTjeFbTuYmFzX
         wjl/LSwPGnNzy3N5auWnfCHIDDI1ux2Fap3fnPMxlYXKh+KOC1VPzBBywf/NvwlGiOlD
         /tgcmbrzE7xyqHyqXcZAEEQ9QY8N4VkLAukg7MflY4SnuDAVnF7EToq5HF0kilVlXtrX
         mlk6i8bpPYhvBYE1XhiEm2Ynp5CoMqeCcskZ/sdLjZ1HXXP0QsFlVLIsOV1OcvCegzlw
         r92g==
X-Gm-Message-State: AOAM533vssPhaUQ9yrYNjlLnMCimUNjRy/DfsYP84UjhWyAnYCraKtuV
        Wb5QeaGtm5zcMslmXgyAcoG81A==
X-Google-Smtp-Source: ABdhPJy+7kaeGlQ2oSWlPHTQXrJGC/gmps6S8B6/CnegdLxtDvX2TuIvU0+rBlV1aa32+NPxZvtuOw==
X-Received: by 2002:a17:907:7f14:b0:6ff:2013:3e98 with SMTP id qf20-20020a1709077f1400b006ff20133e98mr3546761ejc.73.1653569643971;
        Thu, 26 May 2022 05:54:03 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906354400b006fe98c7c7a9sm497527eja.85.2022.05.26.05.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:54:03 -0700 (PDT)
Message-ID: <66591c84-ee8d-7152-f0c5-5e4a07f632fb@linaro.org>
Date:   Thu, 26 May 2022 14:54:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: mtk-gce: Convert txt to
 json-schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, jassisinghbrar@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220524151512.247435-1-angelogioacchino.delregno@collabora.com>
 <20220524151512.247435-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220524151512.247435-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2022 17:15, AngeloGioacchino Del Regno wrote:
> Convert the mtk-gce documentation from freeform text format to a
> json-schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mailbox/mediatek,gce-mbox.yaml   | 124 ++++++++++++++++++
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |  82 ------------
>  2 files changed, 124 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
