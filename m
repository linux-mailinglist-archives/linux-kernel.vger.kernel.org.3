Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80B56525F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiGDKas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiGDKaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:30:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6AE65A7;
        Mon,  4 Jul 2022 03:30:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BBF1C6601638;
        Mon,  4 Jul 2022 11:30:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656930642;
        bh=rJUpYok85LF+d4r9kSHGVbYT9gpDpxf7ez0bJa0iUh4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MykPXsy3hmQ0Tz7tMuYaP/gOo2hMg00XcoeJg0/e6U+GPjf1TbXWAMx1gBKM1h17B
         yNqw1MH4Mx3506V1Kree1XRVaR0UsALhVkUlHilNTvQod0XRho3tIjPgk9qOJJKITK
         uyXSyXJZIiUr/0upV6kgqoOE2TiNbPN9MyNSVWOCwQGR9VptmBBDBLtm92UiajsAlq
         QMof1O++d0KcxDdNBTsD+VRxyZ6dTrrm6/X2JYymLKGZAqLOJOiukPRIk6myjz/mf2
         PgtaQZeiAtXoFIHJOROznwd9U7BCEWpl+VAKWK6PWYAq188/Y0LjQKmfVSB7js9/p2
         e5vH6GIjDydqQ==
Message-ID: <e01fad71-0d7b-e0a8-7ee5-5a64792ed579@collabora.com>
Date:   Mon, 4 Jul 2022 12:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 04/16] arm64: dts: mt8195: Disable watchdog external
 reset signal
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
        Fengquan Chen <fengquan.chen@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-5-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220704100028.19932-5-tinghan.shen@mediatek.com>
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
> Disable external output reset signal in first round of watchdog reset
> to reserve wdt reset reason for debugging watchdog issue.

If my understanding of the commit decription is right, then we can clarify
that with something like: "[...] for debugging eventual watchdog issues".

Otherwise, if this implies that disable-extrst is needed to avoid losing
the reset reason stored in the WDT, you could say something like:

"Disable external output reset signal in the first round of watchdog reset
to avoid losing the reset reason stored in the watchdog registers"

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 066c14989708..436687ba826f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -327,6 +327,7 @@
>   		watchdog: watchdog@10007000 {
>   			compatible = "mediatek,mt8195-wdt",
>   				     "mediatek,mt6589-wdt";
> +			mediatek,disable-extrst;
>   			reg = <0 0x10007000 0 0x100>;
>   		};
>   


