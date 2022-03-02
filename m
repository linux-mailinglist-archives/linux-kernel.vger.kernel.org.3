Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367204CA7B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiCBOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:15:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AC0A88AC;
        Wed,  2 Mar 2022 06:14:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DB7F41F44672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646230493;
        bh=qicDU8a/aQVHGR0OpxT7GfZuyLBKrh3Al3E4YeEHPCE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T2p8R/VWCXLp4Dv4iLMWAy3MUHP0IEHakz4Cjt9R78gLbThc41i6lpjfFEr58iMRX
         Be/s4JcpcxtFzA8rPsm7mzE5GVromwEzO2Sbxj2WLFw6w4T8Kz/u8Q16ni87D2lLKV
         gMXMoD0hVqUeG3YJjJfmWEG/s4FMlN0ybHe2jyWUXzwK09UYtqIp9NcNtGF408IE1s
         jRYe8iqLdkjC+1j6KejSqMjAc0pyiVTzhudzBZp7/w1lp0BEk/qLNI3XtTVxgr5n0w
         ikOctsoFKKV4euH2B3em0DHCat6NN15MLK1xJ1k68slXvjZLTc5rmu8RhRA7UGhVk2
         lZ4w7Yu3zTalA==
Message-ID: <b5d3d996-9c4c-b245-ad59-4fb2218dac1f@collabora.com>
Date:   Wed, 2 Mar 2022 15:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3,6/6] dt-bindings: pwm: Add compatible for MediaTek
 MT8186
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com, allen-kh.cheng@mediatek.com,
        rex-bc.chen@mediatek.com
References: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
 <1646199106-26879-7-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1646199106-26879-7-git-send-email-xinlei.lee@mediatek.com>
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

Il 02/03/22 06:31, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8186 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>   Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index 3a5d1cfed94d..053805846cfe 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -21,6 +21,9 @@ properties:
>             - mediatek,mt6595-disp-pwm
>             - mediatek,mt8173-disp-pwm
>             - mediatek,mt8183-disp-pwm
> +      - items:
> +          - const: mediatek,mt8186-disp-pwm
> +          - const: mediatek,mt8183-disp-pwm
>         - items:
>             - const: mediatek,mt8192-disp-pwm
>             - const: mediatek,mt8183-disp-pwm
> 


Hello Xinlei,

even though repeating these items may not give you errors, this is not really
the best way to do this.
I've done something similar here:
https://lore.kernel.org/linux-arm-kernel/20220217095242.13761-1-angelogioacchino.delregno@collabora.com/

So, for the compatibles needing mediatek,mt8183-disp-pwm it should be looking
similar to this:

- items:
     - enum:
         - mediatek,mt8186-disp-pwm
         - mediatek,mt8192-disp-pwm
         - mediatek,mt8195-disp-pwm
     - const: mediatek,mt8183-disp-pwm

Regards,
Angelo
