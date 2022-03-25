Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3DE4E748B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358639AbiCYN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358413AbiCYN4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:56:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0622D0802;
        Fri, 25 Mar 2022 06:55:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8F99E1F462D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648216515;
        bh=cqBWFRODBQioJaru9o4N5RpABHoeodsNoNfLh0sHduc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S0abQe6xeVDmFRXZ3pzo7HAitzO23HAj9Vl0jicSCiBqMmrcNoc1MVRLrrEbXs3sH
         MenwgpmO2A0QUdiwBEfs5fT92dU9nXNmAckNiUiLJf5WxLFSH+gswHbZuoKVu8UGAv
         nT+xghOMz1XgbmpcfNQ8cSJJsdgIXhEU+PBh1dUPYYj7jpRMHZ/nnWyUO9PVx6JgLo
         fr+gPdBFIwkIaMHN27yWpPNwWtMSwLrICzj5ezHUpdaLuSfu/UDWV4iqO8y32JJPYl
         GGidz1UCD0Uq592UPYc6sNIJcPqVXymnnO1Pn8TnrdDu12jTjKS7xFvt240ihK8MIU
         f7O017ZrmbS5Q==
Message-ID: <a57af792-1eef-297c-176e-194757f3acc1@collabora.com>
Date:   Fri, 25 Mar 2022 14:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 19/22] arm64: dts: mt8192: Add the mmsys reset bit to
 reset the dsi0
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-20-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318144534.17996-20-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/03/22 15:45, Allen-KH Cheng ha scritto:
> Reset the DSI hardware is needed to prevent different settings between
> the bootloader and the kernel.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Note: since there were some mtk-mmsys.c updates in the meanwhile, this patch
requires [1] to be merged in order to work correctly.

Aside from that:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


[1]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220323091932.10648-1-angelogioacchino.delregno@collabora.com/

> ---
>   include/dt-bindings/reset/mt8192-resets.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
> index be9a7ca245b9..764ca9910fa9 100644
> --- a/include/dt-bindings/reset/mt8192-resets.h
> +++ b/include/dt-bindings/reset/mt8192-resets.h
> @@ -27,4 +27,7 @@
>   
>   #define MT8192_TOPRGU_SW_RST_NUM				23
>   
> +/* MMSYS resets */
> +#define MT8192_MMSYS_SW0_RST_B_DISP_DSI0			15
> +
>   #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */


