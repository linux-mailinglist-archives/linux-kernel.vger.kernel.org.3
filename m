Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39059C5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbiHVSOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbiHVSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:13:59 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BCD27B20
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:13:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x10so11395871ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=RKGa/93jv8vRuTqUkBTBsQvFVYJ8TTSkk4qvfaQoCyY=;
        b=tLdDoekyZtdbOPHPiIB1p2uZilGLo26UxY/M7NQlAUMFQqouvgUEStKMxggLWzEQtg
         iN+h+uP0W1/3x3uca+bWymLuZC0wR9zfb9gRh9CqD//IuQjxr1NctRRw7IfMYjqqOd+8
         nHcQbaARqJ58cUFJd6yMSv69A3PNaptBZK0gaKkbqeq1C/J47harz04KpTeF0nwi9DjM
         ROKfKl69mzVua3O0QxS4FhI5d24puShqGDcLF+Tqm9YUHuEDXypRsMEa9BexjxxCBYxt
         3wMBBgLgewh2bJDedY/74s1A9AA+RzDCZb5TNlarefo5QXuTZbLqsAJ6spuTxgcVR0uM
         Frvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=RKGa/93jv8vRuTqUkBTBsQvFVYJ8TTSkk4qvfaQoCyY=;
        b=uZohqlwYAqNzSLcAUmgPkQIn/yvTn/y/SGjFA53Wgp/scvbyqoh/43Tt/jnoZV/Cbn
         wwiHgKHhx2qiPHu+YSz8n33aMKPDfcrv/M9p5KuTIq6tTCbJAeINkHtJpmUiTRUkM97z
         l2opgXwi9CCmtkX7Ra1wUv1oj/8SVNfAGhvNOy0nNj/gVZF+gnx0KiKlXC8sSmVceHQu
         kP1fSq0lxHv41DkQ6VK/LMJcklxHefUxXN0wDXev1OI6rJ3tTK0ldtqAAI/JlHDyZhUN
         8IesaOTgPDPJd4ndIIy8r4LBoi5H9sOp2WgSVqRIzDg56m3dI33cjrThk6QwPGYjEPeq
         edEA==
X-Gm-Message-State: ACgBeo3EEN+5VpiCTuoPxFefiLxDeDPoEsOT5Dc1IPqvYyneju11PCCv
        aHoAl14r2EmZhJo/zDpRZXmK5A==
X-Google-Smtp-Source: AA6agR6MlGpvLg8FhkrjwsXOIigDZI1dtvyw6m4NpOgPHSGxa789MKlZIW/4bisbOaOSKt/IE7Jlaw==
X-Received: by 2002:a2e:2c1a:0:b0:261:c18b:5fd5 with SMTP id s26-20020a2e2c1a000000b00261c18b5fd5mr4304603ljs.30.1661192036518;
        Mon, 22 Aug 2022 11:13:56 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id 27-20020ac25f5b000000b00492dd8e0cb1sm899044lfz.22.2022.08.22.11.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:13:55 -0700 (PDT)
Message-ID: <5b4cedae-ea50-a964-1811-fb5c7daafa41@linaro.org>
Date:   Mon, 22 Aug 2022 21:13:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] dt-bindings: power: Add MT8365 power domains
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
References: <20220822144303.3438467-1-msp@baylibre.com>
 <20220822144303.3438467-2-msp@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822144303.3438467-2-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2022 17:43, Markus Schneider-Pargmann wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add power domains dt-bindings for MT8365.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
