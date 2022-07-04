Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F55F565271
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiGDKdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiGDKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:33:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515555F80;
        Mon,  4 Jul 2022 03:33:29 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D6E1660198A;
        Mon,  4 Jul 2022 11:33:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656930807;
        bh=I6gNnNJ8NBeXTrc04WgTIwAxpwHfOlZ6YbGYUe7r+Cs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rtt8qO/doUejrNnhHwGmINTEgS/5BBt2XaRGCqfDMLekT3eRdV1gDdqRKcSU9Uywu
         BWDd1dlY/ptPHAPKhgj04EhO5HveCi5wDKKzYZh3zNJR2W8/xglREy/tLUjEpNH21G
         K8zfRG9P/edWVraOOoU1UWRDGPX/qBRa57zgv7Dhdrd7mSlMCa+HVIPvP5wFX7twYD
         GNpzF6s6ZlzlG9sEm5a9mTIRJoh+tZGoL2VjUo35ylUgzTrCliw1FVbAMkx8IOSn4E
         HKALylVGamheS79f+zaHA+ISuP4UIjQoORPnGhcfInHHH9t1atweIP/1qDQSYCJ2pO
         8bTI6xjPZZ9nA==
Message-ID: <6a2e41ad-1722-1d93-33ff-4aec370856c4@collabora.com>
Date:   Mon, 4 Jul 2022 12:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 05/16] arm64: dts: mt8195: Disable I2C0 node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Tzung-Bi Shih <tzungbi@chromium.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-6-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220704100028.19932-6-tinghan.shen@mediatek.com>
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

Il 04/07/22 12:00, Tinghan Shen ha scritto:
> From: Tzung-Bi Shih <tzungbi@chromium.org>
> 
> The I2C0 node doesn't need to be enabled in dtsi.
> 

"The I2C0 node should not be enabled globally, as usage is board dependant:
disable it in dtsi."

after which...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Signed-off-by: Tzung-Bi Shih <tzungbi@chromium.org>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 436687ba826f..8032b839dfe8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -829,7 +829,7 @@
>   			clock-names = "main", "dma";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			status = "okay";
> +			status = "disabled";
>   		};
>   
>   		i2c1: i2c@11e01000 {
