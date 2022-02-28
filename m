Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A083F4C662A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiB1JzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiB1JzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:55:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834C13F9A;
        Mon, 28 Feb 2022 01:54:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p4so5331003wmg.1;
        Mon, 28 Feb 2022 01:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U0+Au0d4zAZVX8zuHvuBcFAkWKb2I4OxQR4LPXo/i04=;
        b=lBmsKprRvQDoqaPn9bYlg31prPOjW/Yb3ltQctqmzTvtjNFxY/HTucaUpL/gguyBcQ
         h3jPqfWwKcNVgUlz8SzdEbOIeauJXC/EswUoGMXK19kIZyJRF+HDvB8D9mtwxBRoUQiB
         NrjGYCg81D1I5XotB+WKPsaI9IatCCLrWkDEoXG5pAvTFYWBqBViZy/61vXDrseYAClT
         CAQnCoTv6iTATd8xs0PGIxJfDFopwl0ijS2pFQWltmOItoAlwJPoVDUCAe2ngtOD7N52
         ogNAwFlSjiU3ZJzb6GkYEpY3GFGcKulKDqvUW+3Zek78s/X+z/AbUenEa2xDtsFTk4KH
         7bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U0+Au0d4zAZVX8zuHvuBcFAkWKb2I4OxQR4LPXo/i04=;
        b=YdCKfYTp8fGRGBIB2mVnn0943Dal1yKTIO4KQ2jBery8LbHLlCDGadakinY+DAp7g0
         c4/5qFfhajeNlI1hwu1zaw/wYtJNSUvmMMbPf5zzbiCotQ3aKRVdyWSjlxrptvKhOlaK
         caJlFO2u73/S6YDh4E/a+3PnW3Qc4aWwWcD0/jPaJ7A9yySouqaTfIENHRLeDF2ciTDR
         OFrnMPIalHeZhFxxWYr09WSyuf2XJjvdZkZaDdFlE/jtVH26gaG9s/vU2VfylhntLAqg
         uokWVLx9GfXPhnXRbHCS2de2QM2sVuqaXDOZBaHYnXJcXB3VvCyAqqxgeV3qVaoa+XMb
         vU2A==
X-Gm-Message-State: AOAM533CtQxH6WgRWXPo0gcRIIr6/iVmkpSAU6Nxr0IQeDmMCmNkdGj8
        c07VvwRrytyjA12fhZgaiB0=
X-Google-Smtp-Source: ABdhPJynDyT2YmvMVI1b9GAPVRUaqoNLjRwFrVI46TNy1tFuIgSt6Ei0JnwCeteZP+gsMvr1dfXmLg==
X-Received: by 2002:a1c:2b41:0:b0:380:e379:b8b0 with SMTP id r62-20020a1c2b41000000b00380e379b8b0mr12638344wmr.87.1646042061055;
        Mon, 28 Feb 2022 01:54:21 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b0037c4e2d3baesm13854560wma.19.2022.02.28.01.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:54:20 -0800 (PST)
Message-ID: <b189dee6-a697-6db5-e834-6a5fe6f75f8f@gmail.com>
Date:   Mon, 28 Feb 2022 10:45:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: mt8192: Add watchdog node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220207094024.22674-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220207094024.22674-1-allen-kh.cheng@mediatek.com>
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



On 07/02/2022 10:40, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Add watchdog device node to MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Applied thanks!

Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index cc3953df0153..c1d4030e7e4b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -301,6 +301,12 @@
>   			#interrupt-cells = <2>;
>   		};
>   
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8192-wdt";
> +			reg = <0 0x10007000 0 0x100>;
> +			#reset-cells = <1>;
> +		};
> +
>   		apmixedsys: syscon@1000c000 {
>   			compatible = "mediatek,mt8192-apmixedsys", "syscon";
>   			reg = <0 0x1000c000 0 0x1000>;
