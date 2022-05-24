Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A5B53323B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbiEXUOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiEXUOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:14:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E882171
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:14:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i40so24486595eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fm1tpFca2YWIuBpxTTGZclIqJvsNWlMgZzoZ+c6L03Y=;
        b=b2xojrV+9PHgmFBI5/KZgSAhUS6qJGPSbk0j023/DmgkixIJ82kiPaixoGsAceFnPU
         tmLhJG5uFbhpEQFyCoCqxi+ONAQtwawp3km4d+FSGp0XNsH2t3JltLDqkxzgxegOCVSQ
         HAIMqwagKJMLCuEMJTTrTyYdY1duBRichZylDdPbAl/4zor/WB1YEAidS22+JxNs28tU
         BryV29mbgMbFif0NNdDe6R5mLgsY0HBdGdeKreX4/f10bQyKlN6qAjTVFJxKWRY/UJMk
         7W519LPilUuaMQknyi4G0+O8RKAkVzph87M90NU7bmPhtwra+wGAubTv+ezsSoOaf4MR
         OY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fm1tpFca2YWIuBpxTTGZclIqJvsNWlMgZzoZ+c6L03Y=;
        b=Z5bP3LznJmwFHPydJL+JNky8CgB6jTobFHP9u9Y5XjiTB0pjda1OXqEHjb+X/CY5hi
         Eyl4S4QI44pG+OWn+/SB4XRzesWhxpx6++E9PRjgLkJEZE9wOL1zbiXJGQtMWe67roFc
         6dYN6V91jWhUtLjmkTHbdIGrYx6n7vRhSAvSCNHyhk4aIgQC8AlxgvX4BFmKrAuuPG5K
         IojyDtAIshA7QXPq8jvqvVhQdrCBsBoa55pzIZzyEzKDsEsK68Zf6PE/n24NR1HwDpsX
         UVnb1YxhEKN2ixmY8NHsASaou5eGbzNz9oicx07jGofO/bqrflhjv9tAeJZhp83Awe00
         bDqQ==
X-Gm-Message-State: AOAM532r0VlUHUHWmQbZxpunV/W1Ct2ZZdvF15peg2PoK9o8JmqcN0XV
        1BwtRsBUW7Fhq8ysMBTbEHf/LQ==
X-Google-Smtp-Source: ABdhPJxYconPOKdPTtXM3P9lkUnV1bFUE4Pa1l2up9yo4tsa/rU7pkuKObtyf6INae21cJZAZHhOKA==
X-Received: by 2002:a05:6402:388d:b0:42a:ba9f:f85c with SMTP id fd13-20020a056402388d00b0042aba9ff85cmr31318770edb.292.1653423245180;
        Tue, 24 May 2022 13:14:05 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090601d000b006f3ef214db3sm7555530ejj.25.2022.05.24.13.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 13:14:03 -0700 (PDT)
Message-ID: <b70a58ef-af3a-f4d9-37fe-688c600523a2@linaro.org>
Date:   Tue, 24 May 2022 22:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] dt-bindings: serial: mtk-uart: Convert txt to
 json-schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220524115019.97246-1-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220524115019.97246-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2022 13:50, AngeloGioacchino Del Regno wrote:
> Convert the mtk-uart documentation from freeform text to a json-schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
