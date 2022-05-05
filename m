Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7851B9A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346486AbiEEIMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiEEIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:12:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3273337C;
        Thu,  5 May 2022 01:08:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E73021F44D6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651738103;
        bh=Sx0JTutas4/a5URHaHdUEVftBTpjpG3kAugSQyvFlOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LQP40dxFDRXce8lfztccxf30KUdLwEI7Biw7WJFTVQgsdDbNckjKld2YhLoBNGUFK
         6oiSh0nR9Xfnfbzk/jr6ze4TO3H0+DqXEUSKRQPakdjJeaG4ckhTKy9NBwbOVYL7Rz
         75B5Sarx4ocMBfhtUMYwULroMzHxA1GU5xiW71rPLvmdS8+Nb3IVHiMdvyuR1N54lA
         8CKd8fB/xfvNwcgZqG6z1VjuSIdQFmHsVfj3TRNZlUY4/F4ra07cYNlwfAXCukg8J5
         X4Obi7f66sRUcI/xgAb4Y3SaJM2Yu8CnQ9wkG3c5C6d0oOM60j5N3/znbWeNql2KFQ
         K5ftZZVV6WFrw==
Message-ID: <4826c824-40ce-5726-ed95-5be069233ca7@collabora.com>
Date:   Thu, 5 May 2022 10:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220429203039.2207848-1-nfraprado@collabora.com>
 <20220429203039.2207848-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220429203039.2207848-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/04/22 22:30, Nícolas F. R. A. Prado ha scritto:
> The Mediatek AFE PCM controller for MT8192 allows sharing of an I2S bus
> between two busses. Add a pattern for these properties in the
> dt-binding.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>   Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> index 7a25bc9b8060..5b03c8dbf318 100644
> --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> @@ -54,6 +54,11 @@ properties:
>         - const: aud_infra_clk
>         - const: aud_infra_26m_clk
>   
> +patternProperties:
> +  "^i2s[0-35-9]-share$":
> +    description: Name of the I2S bus that is shared with this bus
> +    pattern: "^I2S[0-35-9]$"
> +
>   required:
>     - compatible
>     - interrupts
> 

The only other way of doing this would be to complicate this in the driver
so that we can do something like

"i2s-share = <0 2>";  instead of  i2s0-share = "I2S2";

...and I don't think that this would be any more straightforward than the
provided way.

There's an improvement that we can do to that pattern description though,
which would be explaining that declaring 'i2s0-share = "I2S2"' means that
I2S2's data pin will be used as DATA-OUT, while i2s0 is DATA-IN.

Another thing that comes to mind here is that this is a MediaTek specific
property and *not* a generic one, which means that both the driver and
this binding should be fixed to get a "mediatek," prefix, so, this property
should - in reality - be "mediatek,i2s[0-35-9]-share" instead.

I think that everyone agrees about that, but let's see what the others say.

Cheers,
Angelo
