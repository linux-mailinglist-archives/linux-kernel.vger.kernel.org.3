Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470665A762C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiHaGE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHaGEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:04:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A29BBA6F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:04:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z6so18482156lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Dl8bj8J2OYumn/gfks6Y/TXqxWAUsjyKN5CBMLkq33M=;
        b=s+ld3BSW73VpjKfO2WLJyo8QMXPvYevRcq4PsaT3k2Z77qKdk8xKWjJckUUaWfvzr4
         YWyksAxTftPrsW0ppk7H7HitM7QBkNbDsEe2lUr+1cxY0DIUgs1AZjooirLpXWNVTIFe
         Oy9N2ufiwiT31+pU/7i2ANgmlzvXMLwrfmDJQoiEn4KgNO/wFYvu0BozmqYQelW3kvN6
         iMGYIV3a7efaPBH1DniQf9yKlOy7z72aD7wlQ/YWJ1LW9PR2JrdFT4QNQHCki8J/HXBb
         StVeaV3xBeut8XNSL/uttxlhjAlNWyfMYZBMtKmZg2uLKvzTsrKOgTHO5CYB/GgCVYyq
         ceNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Dl8bj8J2OYumn/gfks6Y/TXqxWAUsjyKN5CBMLkq33M=;
        b=oBdl7i1FZpJeHzQav6MDN+twQZrf4BamsgzUy1ohRFVMaOtxltu4Sj2DKPC0gg/d++
         kE1ICo9HUFj0lj11bmFS/kaKuImpnTo8/5g/eApjJSJNJieqKKkfxj+QHpMkBC+QGDa0
         iFfa+s/n67w+DcI0abLBFMmKF/Adhcdt3cO5Hj2Dw9W3nnvAt7ebuOWiHC2VEOZPX0wQ
         8jfUpLpC6axPe4nM/GrA1gTGRgBHT1frhJwdetI8CjUEyG8OEW4MAZ9EsixhfN2rcpKh
         kvEyk4AAgWynejqG7QhqjSoiCPcaHOsApUm9z+nd+OEXBdpkfrcQfZAa7UrLTQHM0e/M
         y+5g==
X-Gm-Message-State: ACgBeo1gyZXklflMscgk5sCg5U588YO/ipOyF5boYkznqyL1Y/w4M4fo
        zu02wJ79g9sLfc9OWfXYyO3WVg==
X-Google-Smtp-Source: AA6agR4VDbEUmpQN/YYGQlYkrQzhU4Vr7ZnZNVwK+T0wj2HQ8et1E4vjPcFJasdVKjtvPACwyeVfzA==
X-Received: by 2002:a05:6512:1395:b0:48d:81b:4955 with SMTP id p21-20020a056512139500b0048d081b4955mr8308222lfa.307.1661925860150;
        Tue, 30 Aug 2022 23:04:20 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id k4-20020ac257c4000000b0049483572143sm300975lfo.283.2022.08.30.23.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 23:04:19 -0700 (PDT)
Message-ID: <22eb5611-84e2-23e9-f70b-48bef351133f@linaro.org>
Date:   Wed, 31 Aug 2022 09:04:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/3] arm64: dts: Modify gamma compatible for mt8195
Content-Language: en-US
To:     "zheng-yan.chen" <zheng-yan.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220830063929.13390-1-zheng-yan.chen@mediatek.com>
 <20220830063929.13390-4-zheng-yan.chen@mediatek.com>
 <a209aea3-bf23-4670-91d0-e7f41ac57833@collabora.com>
 <bf2b277e-8b02-6a44-e463-6b7c4a697ce7@linaro.org>
 <b61776761eb0ab9a0b1dcf29d908e4bfd789d2ac.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b61776761eb0ab9a0b1dcf29d908e4bfd789d2ac.camel@mediatek.com>
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

On 31/08/2022 05:29, zheng-yan.chen wrote:
> On Tue, 2022-08-30 at 12:14 +0300, Krzysztof Kozlowski wrote:
>> On 30/08/2022 10:49, AngeloGioacchino Del Regno wrote:
>>> Il 30/08/22 08:39, zheng-yan.chen ha scritto:
>>>> Modify gamma compatible for mt8195.
>>>>
>>>> Fixes: 16590e634f1d ("arm64: dts: mt8195: Add display node for
>>>> vdosys0")
>>>> Signed-off-by: zheng-yan.chen <zheng-yan.chen@mediatek.com>
>>>
>>> Reviewed-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>
>> Please also perform review on the commit msg and backport status.
>>
>> Best regards,
>> Krzysztof
> Hello Krzysztof, 
> Thanks for the review,
> I will fix it at the next version.

This was to AngeloGioacchino...

Best regards,
Krzysztof
