Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5780481C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbhL3NSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhL3NSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:18:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E96C061574;
        Thu, 30 Dec 2021 05:18:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q16so50427207wrg.7;
        Thu, 30 Dec 2021 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=vuRsc8wW9XJ+M5W8oEGctVZv5dxejvx5UO2xVo0fpo8=;
        b=odamaGhRaS2vZVQzGEGWPjhZergHYpE+vRdUAh/AyNJOFPAGghZCOYPny/IuuShyai
         PTgQzgmlUrTSS92K9efVBozlqpMU4dK+iO+VC1u/bG0A/5QEZUuUgq/ZdH60YBuPbXBH
         uljVMlp9iko78CgWOfs3AroAiebtnBbmtr4ZPOMpAxI+EJjPMzvQFDQw1uWdudbuyp+j
         IBXvKVPDta63EeDOCpDF+OWDwtym1B3+0fVflo6WcBU41nLWWtWVJUOp87SphLB0gNQk
         WKkI+NkauH1i62MUisfc7xan/U3TgyA+SaAYtfM1BMc2GargiEIquO+dZMDaQLiG5OO8
         mE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=vuRsc8wW9XJ+M5W8oEGctVZv5dxejvx5UO2xVo0fpo8=;
        b=cZhUuLPt4cJzu+LgTW/Nt52X3ZmEWbfHcJCFv5ydZzr2uYVtazya9+tLEbnBNl3nDd
         AR6/fRp2LEa/xyiiqQHzLCZL3ej8F/XH5boYyHpUtM1vyvFyNwiDQa3gFTdNNSP1hXCk
         1hJWpTCukmKVSJDk/cgoK37u3fyfK1wOjnonuoSWkB/mG7FmsFNngZSD1iZjbFWVYQaL
         BxJ1CYl37ymLEOHRylR7WopJ27U7F9irVzlmVZ0qlXYCDyrvXtNbxRVqrDRYugmpvkmY
         +K6WOT9US5RRqMD7+hU+ataA1dpK4Z/z0FKN/1JBS9EpsKjIZY116TF5yGN3PTpKp0i7
         rj3w==
X-Gm-Message-State: AOAM531bcDFVQoXRlBxEUDm3CnC6w71QmZdeLq8EjNup5WU64f5ez5NP
        6qyRKhiu9TuKUlafkoKYKuY=
X-Google-Smtp-Source: ABdhPJyvTHcr9eexUZO4ohoV+9DtcbakodobY0TzhO4u1LOmOZsK0+qvtXUoI5lBycGiP0hh2zTrZQ==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr25116995wrv.694.1640870283425;
        Thu, 30 Dec 2021 05:18:03 -0800 (PST)
Received: from [192.168.1.145] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id p18sm4086785wms.16.2021.12.30.05.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 05:18:02 -0800 (PST)
Message-ID: <abd9332b-dace-f75a-33f5-be88fe516784@gmail.com>
Date:   Thu, 30 Dec 2021 14:18:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210428065440.3704-1-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v16 0/7] soc: mediatek: SVS: introduce MTK SVS
In-Reply-To: <20210428065440.3704-1-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2021 08:54, Roger Lu wrote:
> 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
> 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
> After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
> 3. SVS dts refers to reset controller [4] to help reset SVS HW.
> 
> #mt8183 SVS related patches
> [1] https://patchwork.kernel.org/patch/11193513/

Already mainline, please either refer to the commit, to make it clear it's 
maineline or drop it.

> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/20201013102358.22588-2-michael.kao@mediatek.com/

Same here.

> [3] https://patchwork.kernel.org/project/linux-mediatek/patch/20200306041345.259332-3-drinkcat@chromium.org/

Same here,

> 
> #mt8192 SVS related patches
> [1] https://patchwork.kernel.org/patch/11193513/

Same here, it's actually the same link as [1].

> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/20201223074944.2061-1-michael.kao@mediatek.com/
> [3] https://lore.kernel.org/patchwork/patch/1360551/
> [4] https://patchwork.kernel.org/project/linux-mediatek/patch/20200817030324.5690-5-crystal.guo@mediatek.com/

There are many dependencies for that. Some patches need resubmit, others seem to 
be stale. I'd advise to concentrate on mt8183 for now and add support for mt8192 
once dependencies have settled.

Regards,
Matthias

> 
> changes since v15:
> - Put (*set_freqs_pct) and (*get_vops) in struct svs_bank because they are part of svs bank's operation
> - Add define "SVSB_INIT02_RM_DVTFIXED" and "SVSB_MON_VOLT_IGNORE" to make control clearly.
> - Remove unnecessary parenthesis
> 
> Roger Lu (7):
>    [v16,1/7] dt-bindings: soc: mediatek: add mtk svs dt-bindings
>    [v16,2/7] arm64: dts: mt8183: add svs device information
>    [v16,3/7] soc: mediatek: SVS: introduce MTK SVS engine
>    [v16,4/7] soc: mediatek: SVS: add debug commands
>    [v16,5/7] dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
>    [v16,6/7] arm64: dts: mt8192: add svs device information
>    [v16,7/7] soc: mediatek: SVS: add mt8192 SVS GPU driver
> 
>   .../bindings/soc/mediatek/mtk-svs.yaml        |   92 +
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   18 +
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   34 +
>   drivers/soc/mediatek/Kconfig                  |   10 +
>   drivers/soc/mediatek/Makefile                 |    1 +
>   drivers/soc/mediatek/mtk-svs.c                | 2524 +++++++++++++++++
>   6 files changed, 2679 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
>   create mode 100644 drivers/soc/mediatek/mtk-svs.c
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
