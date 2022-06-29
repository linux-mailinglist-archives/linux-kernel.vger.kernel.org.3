Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB255FF00
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiF2Lqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2Lqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:46:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491A3F88A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:46:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pk21so32082811ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y26EqFL9g5dJmCSYo/uiI7QjtNL6pCpbp9EtOx0DV2k=;
        b=Xs0iqTshoHumfeIOWL/pDmURrLeeZH6zhilSdxZPMQdL1VsBFaBZ2wS2NtClKado9J
         IJajaGH+wiNLsgGnkXvQwQ0Q1DQ46NgL+wJj3hRda9LnjJ8WFE9/UKVAL6Z+F/RkLwKT
         95cJIPkbww0uqMXiEs67n2yHsbvHTG0Gw6KqqZ3mLdCPjoBT4sijYCR7gLfQxGBkc2Co
         oYpTxnKiBv/RueGhSE4FGYytFwr8hUKxGIxmvBnReaURlfYKdO8ZxR8l/rA7P4KbIP4j
         UPB/E1T1cZP2VCttYrc1aDfknofasecBmLnRkD9k8RmFHHt5qjMz/g/a4mps+oMmzoTF
         sAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y26EqFL9g5dJmCSYo/uiI7QjtNL6pCpbp9EtOx0DV2k=;
        b=pyei8YwB6zNLuemt1kPp2yz4ef198GUU52HCyrfhdcNCsXIxrvRpkyR5E8m8OWW/H3
         xqj0ieZxJz3Hqf/TobbSLWJ9y3RtIL5hW30dxk1iMeECnsLs1UOhO/DUGyVdBkZbumQX
         mQ/CKMK2euHNqAttAWf9CM+l5Vks/Ul3ceSicCbHEdqgn1YzMh4OZy9xbaKacqJfutgL
         KK8qAY2sSjvFXzToX1kADFS57c45nq7HbwWNM9WtuSN7hgVAz/gCuJNtaJaYj+0U4+u/
         78GHzeiHu/6FEwCdDgvhYtttImC7DEasJIHio5zPinwI7KDbpJUAmgiavs1CreDoztmq
         71GA==
X-Gm-Message-State: AJIora/uJvPlNHt12KwBm9bAD8x3HewsGsPsmd6OaKJaXo5wAy2SiMz5
        tvgG153k2k8ls0ZrylmCAedoPA==
X-Google-Smtp-Source: AGRyM1uh2G3mI6ImWNz8iu33UFfTR01pMKRnSNrsb6NJV3DDngQMz4Q29Cs61ZqPiJ7yXvPUhJQicQ==
X-Received: by 2002:a17:906:6545:b0:722:7c99:1ad7 with SMTP id u5-20020a170906654500b007227c991ad7mr2906545ejn.325.1656503205568;
        Wed, 29 Jun 2022 04:46:45 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cq12-20020a056402220c00b004356b8ad003sm11028134edb.60.2022.06.29.04.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:46:45 -0700 (PDT)
Message-ID: <bd98faab-a94b-17ad-fbaf-aafe5b882bdd@linaro.org>
Date:   Wed, 29 Jun 2022 13:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: mt8195: Add resets for PCIE
 controllers
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wenst@chromium.org, chun-jie.chen@mediatek.com,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220629105205.173471-1-angelogioacchino.delregno@collabora.com>
 <20220629105205.173471-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629105205.173471-2-angelogioacchino.delregno@collabora.com>
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

On 29/06/2022 12:52, AngeloGioacchino Del Regno wrote:
> Add the reset index for PCIe P0 and P1 (PCIe0, PCIe1) on MT8195.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  include/dt-bindings/reset/mt8195-resets.h | 2 ++
>  1 file changed, 2 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
