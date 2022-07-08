Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B956B47F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiGHI1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiGHI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:27:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC22814B2;
        Fri,  8 Jul 2022 01:27:15 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z3so7211631ilz.5;
        Fri, 08 Jul 2022 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Bgxu/xLyyKqfoS5wPukZ0Iv8tWIgajlD3uz/Xf77/w4=;
        b=o/XgkzJQCfZK0pGFN2Km8fOBNvJRpwLH60EDC76vYr7wNIhoj1JTnffNMGCZUC2oMc
         owNNwAknfKOVCNL8wRVnZWXs78qP0xOg7u7BW/+YXxE0B6gsaJENw15zhwqFKBKPG5vE
         KdIVSbdFhhcaQclB8PdJuwp6VkqQ0K3rEsdaOKhVjZEAufdG5acAHQthmTpQ4pSvfUMR
         e+z2n2c0o3YycYgexQHqoLasJBOJZhyiiS3i8aBI804bLF9k7CBtvvdfz3Cc7KN3YpSa
         tVLfGAee31+S95ltfxtgaItoSMQVpsQ55/7CobQF0PILrlHcvXZ2VSVGCgaAdP16Gqd0
         nHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bgxu/xLyyKqfoS5wPukZ0Iv8tWIgajlD3uz/Xf77/w4=;
        b=yi30RT866SH8xD5XfWMg72li2YkhfBiSE4xFwFoZxqtXmLq0dcRNeji8qvyN0atx87
         1JLyPzalpQu3NtD7Xd0Y1BGL1yRgyYV32jSYnLexkDOHceKLAZiPLn/vlrP5FQUUAn/d
         www0iJnZTGMqBr9inT5DAuP5zPsupeHzap0PjdzqJ7Xp+5sV4n+wf+hsEqxbfoIV5mes
         jqfH4QCGnkFYXiMA1NHxQGtLfTkdbssgt63iJm75n0AqbICe7uOikL5r+bViIuw14MVZ
         9UCShLrmlZl0YV6hOziLu61efae5W9HvBY8jip6ePzACl5YRYsCtL0b1zA99hjCxOCoR
         8PJg==
X-Gm-Message-State: AJIora+Eoyn6/OO7GO4sM7c0cAcAMX40xfd82M2US3wFiUmgODKnlKOA
        rM1EACBalVrF8/RIj/CGxCc=
X-Google-Smtp-Source: AGRyM1vnsWrtnJRk0jGv6Ng9Tvb3M1qrO1dRsqt8Fp6uiudca8vyk74yUZblERyEFd0mFY7nwZs3kg==
X-Received: by 2002:a05:6e02:1284:b0:2dc:d3b:ccf6 with SMTP id y4-20020a056e02128400b002dc0d3bccf6mr1391671ilq.91.1657268834670;
        Fri, 08 Jul 2022 01:27:14 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s13-20020a02cf2d000000b0032e7d0a79basm17938432jar.158.2022.07.08.01.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 01:27:13 -0700 (PDT)
Message-ID: <b741704d-e8b0-25b9-6111-cb4fedfd18c7@gmail.com>
Date:   Fri, 8 Jul 2022 10:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] MediaTek Helio X10 MT6795 - power domains
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/05/2022 16:14, AngeloGioacchino Del Regno wrote:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series introduces support for the MTCMOS power domains found on
> the Helio X10.
> 
> Tested on a Sony Xperia M5 (codename "Holly") smartphone.
> 

Whole series applied, thanks!

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
