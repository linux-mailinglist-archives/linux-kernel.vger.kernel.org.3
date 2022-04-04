Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF34F14FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346443AbiDDMi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbiDDMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:38:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4DF275C0;
        Mon,  4 Apr 2022 05:37:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2DBFA1F44659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649075818;
        bh=XbLfwMKXJkz6MxHKBidnhRWo+AyuXXqSQNzQrjCWxQE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OxtjPaso8uKDX+NcM3s+he+mbywxsV8V4QNBBSrU+y0eaQF07rfRdtzEoBBwUHQR/
         hwcrdSDvcZZxLicA5/ywh+baAjGkhoIJqS7fbG1ZEqB9OH5V0jSBzP5oLWjFPWRacP
         bQ3sQY8eitB+hP7BgRvCkl8WNWhCC4dMm7xHBWmsqVpqHY4Er4+o2gxI5i1HcXZ8Hi
         umO5qQrXWtvbQmroc6dV7rJDNvnS6IZR6vbmXdJ1G7wDlMehCiBFX0IDERiI9Vg/+j
         UU+5ndHU7p6yDhvqXyNScGyKiJnVfVHnWyQ1ofWJvx8IN9EyJUgSraMuVjpvUmR7iW
         5AHqsGzY8IICA==
Message-ID: <329bed03-770d-106c-29b4-eb1d6037bf65@collabora.com>
Date:   Mon, 4 Apr 2022 14:36:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] arm64: dts: mt8192: Add mmc device nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220401053052.2160-1-allen-kh.cheng@mediatek.com>
 <20220401053052.2160-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220401053052.2160-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/04/22 07:30, Allen-KH Cheng ha scritto:
> Add mmc nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 33 ++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index a6da7b04b9d4..23eb92057cb9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -989,6 +989,39 @@
>   			compatible = "mediatek,mt8192-msdc";
>   			reg = <0 0x11f60000 0 0x1000>;
>   			#clock-cells = <1>;
> +			status = "disabled";
> +		};
> +

Hello!
Please explain the reason (in the commit message) why you're disabling the
mediatek,mt8192-msdc node, which was enabled before this change.

Also, introducing the mtk-sd controller at the same address as the mt8192-msdc
clock controller will produce a warning...

Thanks,
Angelo
