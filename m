Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B5E4F62F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiDFPKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiDFPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:10:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA57728CA93;
        Wed,  6 Apr 2022 05:08:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 318E01F454CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649245528;
        bh=Fewgg+W6G1clWAEhEVkkn/lbkFWCF9MXpHqn8lun8+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W0PyamTsuvA78l+/qDMNGB6+50vsfBr9RtR3NmgbT0TpB0CLcmKhN3U7kOED1i6j5
         4+luSQam5SOsryOX1O7J4La7JDlAFG0pBGud0XvHsMv6oaLx4ZOBHwj9YTmpfpjY7k
         t2OWz3k2yeyD2DPbW/THzfBJ6dKVKPCHFDfOVyL55k5fBwgB+mCtCmsW6oxi3ZSCb0
         E2xnpJh2X1rqd4mYjf+kP1TFxVs0WxfPxionk63hhXfPvYetGY4acG5czvaTsgJpBb
         /cZL7/mTkLhfHPFTUQOPWijqhkXc2FF/YNXd2TdT8gRcM/9QU9jvCxKkyqNV8kh+NH
         lYINv/Sd3khPQ==
Message-ID: <a263e572-35ec-9671-50e3-dbc71b55b6cd@collabora.com>
Date:   Wed, 6 Apr 2022 13:45:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173: Add gce-client-reg handle
 to disp-mutex
Content-Language: en-US
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski@canonical.com, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220228110329.245366-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220228110329.245366-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/02/22 12:03, AngeloGioacchino Del Regno ha scritto:
> Add a gce client reg handle to the disp mutex to enable MT8173
> platforms to use MediaTek's CMDQ for extra performance.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 291db4fcbb25..9eaea1156e25 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -1278,6 +1278,7 @@ mutex: mutex@14020000 {
>   			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
>   			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
>   			clocks = <&mmsys CLK_MM_MUTEX_32K>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1402XXXX 0 0x1000>;
>   			mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
>                                                 <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
>   		};

Hello, this is a friendly ping to avoid forgetting about this patch.

As a note, this was successfully tested on MT8173 Acer Chromebook R13 (Elm).

Cheers,
Angelo
