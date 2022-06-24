Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F6559662
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiFXJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiFXJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:23:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BF52BC3;
        Fri, 24 Jun 2022 02:23:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B5AC66017FA;
        Fri, 24 Jun 2022 10:22:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656062579;
        bh=9Soc6n0CqFUw5ZJ1qMew3TiS4i4OwU3mvCqAavwe5wg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nZIokHZdtJm1ECwVKvDQBwV3vTQoam56MCQ88jG9j5oK+852SDX86EZmXOFd0MyFM
         aoOE3XTvgjpadKYCkxndt1Fas9058NPUY8vNw3kHZOMiuHXGccY9f2ZTQYYdAx6r/T
         J2JMHnSOU6z96e42d6BHK+l0SK/zlsDiktujVK2C7O8qom6vUZasdBNbl8FOK+aFgo
         L5WtM+UGHO1v54ID07R6DN4hoVSg32VC1bt5mOYZAWIqvgbBYEwJH4FDvU40sPK0hv
         bJSDok7cdWaGlT0XXmEJLpP2aydZ2bBXIn50iJrGg3WO8N9ivD+y65P+hB+7uvKfoO
         c90owLut6DaDw==
Message-ID: <26ff5b3e-00f6-783e-04ec-b4fcd600175e@collabora.com>
Date:   Fri, 24 Jun 2022 11:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/2] MediaTek Helio X10 MT6795 - power domains
Content-Language: en-US
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        matthias.bgg@gmail.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, mbrugger@suse.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 16:14, AngeloGioacchino Del Regno ha scritto:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series introduces support for the MTCMOS power domains found on
> the Helio X10.
> 
> Tested on a Sony Xperia M5 (codename "Holly") smartphone.
> 
> Changes in v2:
>   - Changed license header for mt6795-power.h binding as per
>     Krzysztof's review.
> 
> AngeloGioacchino Del Regno (2):
>    dt-bindings: power: Add MediaTek Helio X10 MT6795 power domains
>    soc: mediatek: pm-domains: Add support for Helio X10 MT6795
> 
>   .../power/mediatek,power-controller.yaml      |   2 +
>   drivers/soc/mediatek/mt6795-pm-domains.h      | 112 ++++++++++++++++++
>   drivers/soc/mediatek/mtk-pm-domains.c         |   5 +
>   include/dt-bindings/power/mt6795-power.h      |  16 +++
>   4 files changed, 135 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mt6795-pm-domains.h
>   create mode 100644 include/dt-bindings/power/mt6795-power.h
> 


Gentle ping for this series...

I've verified it still applies cleanly on next-20220624.. can we please
get it merged in?

Thanks,
Angelo
