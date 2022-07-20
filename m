Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798957B8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiGTOt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbiGTOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:49:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA451A3A;
        Wed, 20 Jul 2022 07:49:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d16so26444911wrv.10;
        Wed, 20 Jul 2022 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4I6UGeFEkXlgrVRY5xqOMReP5vtYTX3IPS6DCfP5Wm0=;
        b=VVWRB0wGYlNsUtg4p1B8eLYg4sm0YI6oz44md611lRBy1OMvzzhk5nyhWQ634GjD3d
         8wb1dNQ0NENgd8g0HwordOKrBgDyuahPegItx3bYTjw5dVsddcHbfdWTl14Pm4kTpW2L
         bwVOgku5pQfJmrkSTLNJqQagQf2Vz50EIORU7qzbfgIB46h4LmcxK9q6wpdWE/SXqA80
         nCJ0ibP38PamrHXoc0QEgfBnFfyphqn7uCsyCtKdelykgGBQDYpweeGSrUTRvz7ueH/c
         2MNz4Fy0rESoaTa6ty0irVvF6uPF8CtnJsNvMd7Z33i1K1bSAFAAKqELwCnfVqEeMkDt
         u3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4I6UGeFEkXlgrVRY5xqOMReP5vtYTX3IPS6DCfP5Wm0=;
        b=Yq4jk/RR095I66pWeGoW7tJSpsrk4S8tkbFhKCzmImsIl4H+8NTSSY34HQjo3x/27f
         Z1hBq06iMhbk0t2q9Gj4FM2g0Ozy7GADlIzD8rOtrGDJbb3F0Z2VXvlzrHMBRceZwihH
         GibDxW6zGqHTzwbZROwAHnf9KcuL979kvKpvm0y0P84wWRW+oXGiAefY9QVIIk4hpY3v
         lE9U9wEhvldVZRn2wbInMVxoW3QZMrdMFEaknK1bTJDY750j4CwG5MS6aCAinEMUOVwG
         +ALwS9gJQOojvycNMd4kxyip/coQh35/Azuvf1sqoICZ+g9fchvB23TBDwPVWxTszPnE
         F7dg==
X-Gm-Message-State: AJIora8c4TweND6SYPm/6YGNNYMX4kXKxJGMggri3IAAnK9Ek8rthR5s
        F5AS+yoPq4XZtqCQOEQ0VTI=
X-Google-Smtp-Source: AGRyM1uxA0vAoOO3DxL7mUqYJD7JvPh957H84Ju9Sj/3ppHLAtfCS67+3bV9HouPx/uKchBISOJ1YA==
X-Received: by 2002:a05:6000:1091:b0:21e:3d13:283d with SMTP id y17-20020a056000109100b0021e3d13283dmr6541589wrw.376.1658328570279;
        Wed, 20 Jul 2022 07:49:30 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b0021e40f9f47csm3987821wri.5.2022.07.20.07.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 07:49:29 -0700 (PDT)
Message-ID: <02ccc8a9-083b-9076-bbf1-5882b9bc04bc@gmail.com>
Date:   Wed, 20 Jul 2022 16:49:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: mediatek: mt8195-infra_ao: Set pwrmcu clocks as
 critical
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Cc:     sboyd@kernel.org, wenst@chromium.org, chun-jie.chen@mediatek.com,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220719093316.37253-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220719093316.37253-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/2022 11:33, AngeloGioacchino Del Regno wrote:
> The pwrmcu is responsible for power management and idle states in SSPM:
> on older SoCs this was managed in Linux drivers like sspm/mcupm/eemgpu
> but, at least on MT8195, this functionality was transferred to the ATF
> firmware.
> For this reason, turning off the pwrmcu related clocks from the kernel
> will lead to unability to resume the platform after suspend and other
> currently unknown PM related side-effects.
> 
> Set the PWRMCU and PWRMCU_BUS_H clocks as critical to prevent the
> kernel from turning them off, fixing the aforementioned issue.
> 
> Fixes: e2edf59dec0b ("clk: mediatek: Add MT8195 infrastructure clock support")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/clk/mediatek/clk-mt8195-infra_ao.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
> index ce7ac16a2f42..75b54ec9c46c 100644
> --- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
> +++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
> @@ -55,8 +55,12 @@ static const struct mtk_gate_regs infra_ao4_cg_regs = {
>   #define GATE_INFRA_AO1(_id, _name, _parent, _shift)	\
>   	GATE_INFRA_AO1_FLAGS(_id, _name, _parent, _shift, 0)
>   
> +#define GATE_INFRA_AO2_FLAGS(_id, _name, _parent, _shift, _flag)	\
> +	GATE_MTK_FLAGS(_id, _name, _parent, &infra_ao2_cg_regs, _shift,	\
> +		       &mtk_clk_gate_ops_setclr, _flag)
> +
>   #define GATE_INFRA_AO2(_id, _name, _parent, _shift)			\
> -	GATE_MTK(_id, _name, _parent, &infra_ao2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +	GATE_INFRA_AO2_FLAGS(_id, _name, _parent, _shift, 0)
>   
>   #define GATE_INFRA_AO3_FLAGS(_id, _name, _parent, _shift, _flag)		\
>   	GATE_MTK_FLAGS(_id, _name, _parent, &infra_ao3_cg_regs, _shift,	\
> @@ -136,8 +140,11 @@ static const struct mtk_gate infra_ao_clks[] = {
>   	GATE_INFRA_AO2(CLK_INFRA_AO_UNIPRO_SYS, "infra_ao_unipro_sys", "top_ufs", 11),
>   	GATE_INFRA_AO2(CLK_INFRA_AO_UNIPRO_TICK, "infra_ao_unipro_tick", "top_ufs_tick1us", 12),
>   	GATE_INFRA_AO2(CLK_INFRA_AO_UFS_MP_SAP_B, "infra_ao_ufs_mp_sap_b", "top_ufs_mp_sap_cfg", 13),
> -	GATE_INFRA_AO2(CLK_INFRA_AO_PWRMCU, "infra_ao_pwrmcu", "top_pwrmcu", 15),
> -	GATE_INFRA_AO2(CLK_INFRA_AO_PWRMCU_BUS_H, "infra_ao_pwrmcu_bus_h", "top_axi", 17),
> +	/* pwrmcu is used by ATF for platform PM: clocks must never be disabled by the kernel */
> +	GATE_INFRA_AO2_FLAGS(CLK_INFRA_AO_PWRMCU, "infra_ao_pwrmcu", "top_pwrmcu", 15,
> +			     CLK_IS_CRITICAL),
> +	GATE_INFRA_AO2_FLAGS(CLK_INFRA_AO_PWRMCU_BUS_H, "infra_ao_pwrmcu_bus_h", "top_axi", 17,
> +			     CLK_IS_CRITICAL),
>   	GATE_INFRA_AO2(CLK_INFRA_AO_APDMA_B, "infra_ao_apdma_b", "top_axi", 18),
>   	GATE_INFRA_AO2(CLK_INFRA_AO_SPI4, "infra_ao_spi4", "top_spi", 25),
>   	GATE_INFRA_AO2(CLK_INFRA_AO_SPI5, "infra_ao_spi5", "top_spi", 26),
