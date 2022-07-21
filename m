Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0355657D1AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiGUQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGUQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:38:47 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0D7B1D7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:38:45 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w2so2476148ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YGG2EmCH3bS3wBtE1nLRsaoqlR5mpBzOgXAIcspF1i4=;
        b=VrqwtoLDp0th6beh70O/VpIJb44Tn48oNwIpyGGfXQ82zAA51Bxkl2wSrzc54xQE/D
         /eJ2dHRsI8MZGQ4pjQvVF1t8TKVtXGTYATm7677RjYbG48zJ3bxXTxpMV2cV9TW7w6Hh
         cP7/w/VN3A/+5KoeQlod+kp0COrm9v0d6WlE/5Qy00TnKDFxsWNmx6ODhZyxJ6dhRhAM
         Y5yy18e0BH/qdPfyxUgjkkcmyHyJTUF8q3LLiXQhN0w5N8cujj/SpkvrmEsQn7FUBMAi
         fbHef/necwPLVOccw2clWPTxl9GZAT0WTerLlXjHRvP87YULrMVYQXyW2YtROS9ppB9u
         0KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YGG2EmCH3bS3wBtE1nLRsaoqlR5mpBzOgXAIcspF1i4=;
        b=VdpmHKiKXxPLKoKLNSBOXqfSWWXbo9PjGuWhA4km0whIf3F73lor7ecwL3+TXtqpqc
         SerZ1dOS+rIKAkXOVJfEkNPBj2BkGT5rHxhq+O8tSEOa1e6afJsNznp6q6eFZMzHDjkU
         2EeISCaw/LBA0mmwjmK0opfKMMFumkXXdG2hZUt03Dkgc1MrhGak76bWoBOSlEIbYwmg
         xNuDBQnHIfvWz3oBGWzV+fTib7cb4LTgB3BAqMy3ACPeq43153R+thFnQFJDX5fYVnHg
         uQ72rZ+46zivKRaV1amzRsVTW6dYHTqzplfvXvwfXe1JNWjx1MbUnoE38vOnz0zrN1e5
         0LPg==
X-Gm-Message-State: AJIora+dMwCHSSCwKJakppOKxptMLRBRQnTxOl74Ea9G8+REcaIbCsx2
        ICVgz5FlREPgxj1tzHUG2gkHog==
X-Google-Smtp-Source: AGRyM1sjYIxbnzkQfm9NykntHg4tQ/OMvY4AkQJhXhbKqdP/B68eLxAg+9nBCXyPn7z1aachpSTFmA==
X-Received: by 2002:a2e:8745:0:b0:25d:eba0:9e2e with SMTP id q5-20020a2e8745000000b0025deba09e2emr247240ljj.384.1658421523172;
        Thu, 21 Jul 2022 09:38:43 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id o6-20020a056512230600b00478fc420ea6sm400437lfu.244.2022.07.21.09.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:38:42 -0700 (PDT)
Message-ID: <3c781dd6-865f-e59b-17dd-c583e79ef152@linaro.org>
Date:   Thu, 21 Jul 2022 18:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 0/7] MediaTek Helio X10 MT6795 - Clock drivers
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220629110254.184213-1-angelogioacchino.delregno@collabora.com>
 <45ff2e82-caeb-9575-ce73-1bd43c37c0c5@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <45ff2e82-caeb-9575-ce73-1bd43c37c0c5@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 10:53, AngeloGioacchino Del Regno wrote:
> Il 29/06/22 13:02, AngeloGioacchino Del Regno ha scritto:
>> In an effort to give some love to the apparently forgotten MT6795 SoC,
>> I am upstreaming more components that are necessary to support platforms
>> powered by this one apart from a simple boot to serial console.
>>
>> This (very big) series introduces system clock, multimedia clock drivers
>> (including resets) for this SoC.
>>
>> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
>>
>> This series depends on, and can be merged on top of:
>> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=640122
>> [2]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849
>>
> 
> Gentle ping for this series...
> ...I've got a lot of commits to send that depend on this one...
> 
> P.S.: The dependencies in [1] and [2] are already upstream.
> 

You sent this message to Rob (not to others) and you did not mention
whom are you pinging. Rob provided all necessary tags for you.

If you want to ping someone, put proper names in "To" but best - mention
by name.

Best regards,
Krzysztof
