Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6302D5578DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiFWLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiFWLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A254BFD8;
        Thu, 23 Jun 2022 04:41:01 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 89so29524766qvc.0;
        Thu, 23 Jun 2022 04:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TlJ623kYIiixyRnFbBdpB74xXITtoo13lP9Gz51M6CE=;
        b=c+PafEx9t9or6IfkcJ7ZyOzOPZu0N2lNy3eu3Vi3fLws1er+KEGfr/mIoPraDmO47z
         iyFNxaRg6V9NIC1Z1o3BBzCKEoeMbScCGBgezPU/9TSdCE5prlGV/Uy7f9XkQAnIF3S/
         ySGWI9WUHUp9ygOhgSv/AF9IZ3UdmPnWqFgxKC4sak5OwUs6Yx9xbc9MNk2eWye1PJXj
         XNTDW47isAtgapdHC1nfG6e8/nrWll8tN4qweRG87E3X3UtxPgg2ZlR3VpB7rqGgZ4Yv
         daVJ4ZAk4D/ym7MXc6syIkE7d2lczgbIalaOF6zshj8qiWJaM2BOzbNzWZd16AOeCWcV
         rFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TlJ623kYIiixyRnFbBdpB74xXITtoo13lP9Gz51M6CE=;
        b=hxFkuUGsPOJ/KbtG5kUIzA4lFLt9vwfC1QPWh3/CyAyvYjsLOHGk5fshyUHMIVEhgj
         MhoLb2V5wm9M0SZdkZGyoTRt4pnqLc7Y/9Rjo537nKpgXmNRCMAwD5zID4l/uB6SoQba
         TdX1fGwVBW0jeyH8OLxxJJpIMgaCSTOsXZRKFFwCwDSh98YnRy2hexmIrZFz+Lc9uYIs
         BU4z9oKKCO12a9k03aiAgzpW1r5GSrCZvjftq19GWr4rhFXviQsWqK7yI6wuOdPycjbZ
         PnaVDKe8uEEj0Hc6H/SaJB+W3S0eqMeuEDGgCsS9XaSVULgM2i/DtH2w+4Wfa3wbCKye
         fiuQ==
X-Gm-Message-State: AJIora+Xq/+opNJofm8jdev2Fu+wvokK/Pte5tqEL10RyABoEsGXtwXP
        u40sNa8C+2RSaH13+z7WWCR8ovr3sdU8LA==
X-Google-Smtp-Source: AGRyM1uCkbgyLd8bqmpVHgGUaWaGnEUvW6hQtdnjAjEevjJfcue5FX4j6Cp+pGXxH2vQJjft88KJ0Q==
X-Received: by 2002:ad4:5de4:0:b0:470:466b:15c4 with SMTP id jn4-20020ad45de4000000b00470466b15c4mr15080285qvb.34.1655984460197;
        Thu, 23 Jun 2022 04:41:00 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i10-20020ac85c0a000000b00304e1709b1esm18283516qti.43.2022.06.23.04.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 04:40:59 -0700 (PDT)
Message-ID: <11da278b-f7ce-d668-2c8a-46d7a9c71eb9@gmail.com>
Date:   Thu, 23 Jun 2022 13:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/5] Allow getting regulator on MFG for multiple SoCs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
References: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
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



On 23/06/2022 12:09, AngeloGioacchino Del Regno wrote:
> This is one of the steps to enable DVFS with the Panfrost driver:
> since Panfrost is already enabling the (required) MFG power domains
> and since the mtk-pm-domains driver is already responsible for
> actually enabling the SRAM PDN, it makes sense to make sure that
> the VSRAM supply is ON when trying to reset/enable the SRAM.
> 
> For this reason, the MTK_SCPD_DOMAIN_SUPPLY flag was added to one
> more MFG domain, ensuring that the SRAM is actually powered and
> also not relying on the bootloader leaving this supply on; on the
> other hand, this is also making possible to avoid setting a
> sram-supply on the GPU node, making devfreq happy about having
> only one supply and finally allowing DVFS to happen.
> 
> If no domain-supply is declared in devicetree, mtk-pm-domains driver
> probe will anyway keep going, so this is not breaking old devicetrees.
> 
> No side effects either when this supply is declared for both a MFG
> domain and Panfrost together.
> 
> This series has no dependencies.
> 
> AngeloGioacchino Del Regno (5):
>    soc: mediatek: mt8192-pm-domains: Allow probing vreg supply on MFG0/1
>    soc: mediatek: mt8183-pm-domains: Allow probing vreg supply on
>      MFG_ASYNC
>    soc: mediatek: mt8195-pm-domains: Allow probing vreg supply on MFG1
>    soc: mediatek: mt8186-pm-domains: Allow probing vreg supply on MFG1

I think we can squash the 4 patches into one. Other then that series looks good.

Matthias

>    arm64: dts: mediatek: mt8183-kukui: Assign sram supply to mfg_async pd
> 
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 2 +-
>   drivers/soc/mediatek/mt8183-pm-domains.h       | 1 +
>   drivers/soc/mediatek/mt8186-pm-domains.h       | 2 +-
>   drivers/soc/mediatek/mt8192-pm-domains.h       | 2 ++
>   drivers/soc/mediatek/mt8195-pm-domains.h       | 2 +-
>   6 files changed, 10 insertions(+), 3 deletions(-)
> 
