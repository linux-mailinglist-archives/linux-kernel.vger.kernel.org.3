Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18B04BB999
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiBRM4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:56:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiBRM4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA212B5B8C;
        Fri, 18 Feb 2022 04:55:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D34331F4241F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188950;
        bh=AlyTnLmhORNwZ1RUlUCeby9qHWIa7NQ/vAwxJ0QHz5E=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=BqAzjeSe61Vw4kn+wAhUjkIctXCWmc8zNa78w/6pWVOlSRg57PZuC9PiQE1/uruD6
         mPVgkUN2rRpWhRjdmaSC+Z6XAw8pVw1opgV2HQXeInyRaqu78MWDxOjxZufaeWbByC
         8nJGw0blViFg0UBl7yYBPmVkkXEIZ35Evil+zFfNhzYnzTUYVx7QigxHleTMj5wHzw
         JQ29Gg0rUqUUa6VzokLYdri93J+kPsdij1Jkt2OJ4nDCRuaTV85fBDVCyYd6ip3eRi
         x4ibXuz84X5rAVZMsnn8e9BT14tGmwcV6qOoqvYoaw7niW+tTdxQMBqRyy3hwn+XBF
         R45cBzMKFEhcA==
Message-ID: <6bcad8b0-7836-77f0-5040-e76b20c04a4e@collabora.com>
Date:   Fri, 18 Feb 2022 13:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 11/23] arm64: dts: mt8192: Correct nor_flash status of
 mt8192
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-12-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-12-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
> Correct nor_flash status of mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

The commit message should be:
arm64: dts: mt8192: Fix nor_flash status disable typo

...and it should also have a Fixes: tag.

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 4533c794effc..f51fd0f6c356 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -936,7 +936,7 @@
>   			assigned-clock-parents = <&clk26m>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			status = "disable";
> +			status = "disabled";
>   		};
>   
>   		i2c3: i2c@11cb0000 {
