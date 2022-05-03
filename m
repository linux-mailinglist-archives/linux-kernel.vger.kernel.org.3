Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B54518708
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiECOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiECOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:47:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D6D39145
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:44:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g23so20094401edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aY4s82XwSrqXdVrj1Gg/ZPd4J9t1Ccsavp0PTdRcSPw=;
        b=etVEBmTj3fnk5cOi9G+OhkVYOhQUkUlnSMAJFU4KyxOD0KIU41vOb98UqDOZuQ3E9E
         oZC8hEg0hnEhxDxjjvDrcwQqS5/ZFuwz1ewdeRmHJpG20jN5D4MZJsAKGR+hnsFenmjj
         MVRJD6cfM+TF0oCgDJhEXCbVmTqTnQNALopxxnQt1fD+1ieXzBeLiMsPcW38cf8T/alh
         Q8jsNkwqVL+20us+HSrr0+LuUTftNoNMoXcByfYbqGOXgcNe25Q83B8Fa+YYNQmcJ8Cr
         Y5qPow+KWvn4Y6D+NXrRRoFCa+djW6rMcybwXjP11sNwEUhM80xeqJAkEXgZd5/SzJyf
         rqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aY4s82XwSrqXdVrj1Gg/ZPd4J9t1Ccsavp0PTdRcSPw=;
        b=CWvw4dMRImyuvqlavtf4BIXe0s8iOOj9sm3fZs+lEzQfTJWzkqKlttrdRgPwvtOTK+
         TCoS7UHbu8PghSXlvqW+0x6W4a/xENB4cy/kCPbHkCzw3mewpBejjbuxFKV9TPvrROND
         ThpgCgl3bVBnKoSznf92k0Bzz2Tb6et4NHcg4+HuXpLTwzkSiaQUtB4C8AgeoFwJCh5U
         Lle6uiG/KbOxigb/3VTczBnspj74oZ6yfQIdJkdyCIjP0kEtX0BDT3k3cKXCYaA0HILR
         b8EsdCdHqv9OOzXe5kl5COM83Jc6jQMLMHRGpbXC1QQcD12b4IFZGH0Yqpmm+sIt9QVN
         gULA==
X-Gm-Message-State: AOAM531LnmHqOAq1WumP6YNOi5rx7Ukj1yrFHxAUZULeDEFB/k3P/O/m
        2rvVv3OH8I5wmksTWvctoUkgnQ==
X-Google-Smtp-Source: ABdhPJxpfh0y/LqVlOfJQR1BB3AT0qQiNxhOj7CgucuGZhv207wHkqq8MYHox38zzpF8jJTWjtV2mQ==
X-Received: by 2002:aa7:d9d6:0:b0:425:dafc:2fc6 with SMTP id v22-20020aa7d9d6000000b00425dafc2fc6mr17994605eds.340.1651589059417;
        Tue, 03 May 2022 07:44:19 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv26-20020a1709072bda00b006f3a8b81ff7sm4682592ejc.3.2022.05.03.07.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 07:44:17 -0700 (PDT)
Message-ID: <d91eaef9-562b-27ff-9164-518b0666d7a5@linaro.org>
Date:   Tue, 3 May 2022 16:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add MediaTek Helio X10 MT6795
 power domains
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
 <20220503141441.125852-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503141441.125852-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 16:14, AngeloGioacchino Del Regno wrote:
> Add power domains dt-bindings for MediaTek Helio X10 (MT6795).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../power/mediatek,power-controller.yaml         |  2 ++
>  include/dt-bindings/power/mt6795-power.h         | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt6795-power.h

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
