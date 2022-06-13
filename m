Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635C5499F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbiFMR00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiFMRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:25:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E43F5D5D7;
        Mon, 13 Jun 2022 05:41:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D13166015B3;
        Mon, 13 Jun 2022 13:41:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655124081;
        bh=Dssxu5juHxniKEwBlOPdCopiQRHAuksbl/SlhCHu2R0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cj1Y7XKnAUxZ9AFEebBoxYSFqi2LXEuJRLBk7CcG9RY6lLsqhlFzV+oxNSnRAq35d
         OCOiKUkuwtSR+9XSJ6bQgiY2tR+/pCYoiPZ2BMm35mXHvziQjWV0gOEj0U9S4GhMOz
         EYidKT4SRSawFGHUZuKV15dCQfIEuYSlhQyeLmS/mnBTddIv9RX26o1Tj0LdumsVOw
         ofcXrD15RlCDQA/aerb01D36rVGPuAyr6vv5yADcS/k8QTz+HSblMJutsBpu4fTyhT
         QDBqCG3Iyw1M52WLJNimNCjmcCzyMeLKnme5b0GdVG3XihAtSttrusNmTabOCzrmOU
         tJ78YAHvoCNMw==
Message-ID: <30fcd090-0f31-5a7a-ec14-11098aac8e5c@collabora.com>
Date:   Mon, 13 Jun 2022 14:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: dsp: mediatek: Use meaningful names
 for mbox
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220609083101.24195-1-tinghan.shen@mediatek.com>
 <20220609083101.24195-2-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220609083101.24195-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/06/22 10:30, Tinghan Shen ha scritto:
> Rename mbox according to action instead of 'mbox0' and 'mbox1'.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   .../devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml        | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> index b7e68b0dfa13..6cedd6868cc5 100644
> --- a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> @@ -55,8 +55,8 @@ properties:
>   
>     mbox-names:
>       items:
> -      - const: mbox0
> -      - const: mbox1
> +      - const: rep
> +      - const: req

"reply", "request" - as said on patch [2/3]....

P.S.: Adding context for anyone else reading this patch, mt8195 devicetrees didn't
       get any dsp node yet.

>   
>     memory-region:
>       items:
> @@ -100,6 +100,6 @@ examples:
>          memory-region = <&adsp_dma_mem_reserved>,
>                          <&adsp_mem_reserved>;
>          power-domains = <&spm 6>; //MT8195_POWER_DOMAIN_ADSP
> -       mbox-names = "mbox0", "mbox1";
> +       mbox-names = "rep", "req";
>          mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
>       };


