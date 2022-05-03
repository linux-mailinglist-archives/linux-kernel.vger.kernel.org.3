Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38C151844A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiECMar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiECMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:30:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2F73878F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:27:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dk23so33116245ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3v4789HnPrfyXLlbi4TVrwsRga5l4AtBHsLanAodRHg=;
        b=tOyrcEqYRqwaatbWkdvtYKd4xy6bH1Z+GOzXIo+D5G+HJjDP+TfVdYblY3sEMayIy7
         xLZEGk7z2ekyGYFLKjX42MH2El3J73RzKd7iPBYfjrJcsRlkJImmwNwMqaXk4E3Fsj1L
         8XfvZeoQ65NL1Ju6JOlIxX2P2fF9BoG4iIo4sH1JSUzBAIUYjBXEGmzazDNhFXZu0fXr
         7+XNSdPIdkzyiklnKlm47RWsIJIyvSywc8+ojhDYRJY6ZuYOp36gbejaqYlAHRClXGgf
         4tLefzK5LxSerPrMwRN3PHqfwyymPdkVZdBJMDiLQ/hdabTPGF81c2gWHvYjapxlcbzg
         2iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3v4789HnPrfyXLlbi4TVrwsRga5l4AtBHsLanAodRHg=;
        b=jBIjQw9C4IXn57g5AfoIAvVavsfkWOtQ7M3mmjKzOYILbQ67M12yRyYfJxAj8+oTaO
         9mssqCdzwbbtW5lMIHwXFXp24a7EU7o4g6bwAcrDDoDM03dqX7vrG0lLUBxPp6WkY4ff
         2Y044R4ouiA+uYy+v2H6aWnVe0P4D9TueOQBZUkVTAVaJgDvTicAkvUm7bYo1eZ6SUUl
         Sk2sY/2g8NbR+2BgqN1Yc/bJS4X4QOjpg3hg7NgtOVxW8mz27iyzWPqHwUmyTNlDfG+1
         gWPNlQG9weZI4wHEjhdRBacvjwUleDB9wBEj2NoXkqXoHY/xXZUNkkOXsHE4YfNI8Y5D
         SOFQ==
X-Gm-Message-State: AOAM5337LF8f8TM+8GY06a3U9Gx6sXGWpY05QRtHk2Ji3IfOYDPv1k88
        puszqVE3gdhNPkE33H/LAAJ0HQ==
X-Google-Smtp-Source: ABdhPJz1R4QiNsUY3ftHoYu9rTkjTJu3dFEsS0UonNJRNjbK/2iYu1E8Jz/5btp8OLo7mKGT9jFoNg==
X-Received: by 2002:a17:907:9705:b0:6f0:2b25:784e with SMTP id jg5-20020a170907970500b006f02b25784emr15455246ejc.76.1651580823976;
        Tue, 03 May 2022 05:27:03 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hx8-20020a170906846800b006f3ef214dd0sm4515214ejc.54.2022.05.03.05.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:27:02 -0700 (PDT)
Message-ID: <1699e161-ca41-3a01-6cf2-11e7d5dd2152@linaro.org>
Date:   Tue, 3 May 2022 14:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 13/16] dt-bindings: reset: mediatek: Add infra_ao reset
 index for MT8192/MT8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
 <20220503093856.22250-14-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503093856.22250-14-rex-bc.chen@mediatek.com>
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

On 03/05/2022 11:38, Rex-BC Chen wrote:
> To support reset of infra_ao, add the index of infra_ao reset of
> thermal/svs/pcei for MT8192 and thermal/svs for MT8195.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
