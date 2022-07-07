Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF42156A5C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiGGOpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiGGOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:45:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA62656C;
        Thu,  7 Jul 2022 07:45:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r14so20875084wrg.1;
        Thu, 07 Jul 2022 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0vvOcF04of4eueNy3j0/G+PNUIgeaFTAvFOiC1ayUAM=;
        b=YoegBB6KD2BGYIwIFRuRldiaXMtgQZEaon/lxSPUd/NBq5ujfuIiFdwN/Kk9CF9tdK
         m+6sCUv0gqnFnqu1i4kEiFHay3+ZgSbUYH0IYJipabvCJ44Sp+uN70qHfJu5fLygqBPa
         RtMkk5Ds78rZTaUGBBpLJpWrCGF8x5kF+uXNKwMO2PWTawaAacXeEytSLMnJhtR/gxi9
         JJbw9w1+8kwfDx8c7MaYBsGSME72NkmqggVbbgq/+NLCfOjNrTAEbUMcRunSdX+kzWhN
         KBdcIAGmcDoC7+3rGU+TOcT8NGPMjoU1GQkBes2xKamQp69VvQO7yGZvMHVtH7HDFoi6
         uhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0vvOcF04of4eueNy3j0/G+PNUIgeaFTAvFOiC1ayUAM=;
        b=B+xY3EEGh4DAuSnsdUm8GU7EdXQUM+lYz89INk4KDPJCD9s8lHQunWGrnxoRyTJo45
         76drmDvfvBiG5Q9TV7+c9JYMcFzbtvc5N6zXsZA5CSbihcvv7EoP7CWd/zrCINHTJImU
         jHazvF9Jts/Qsw2qvwiHJQlrCkk/qyhMF2+So9e1BmQm/ZIBHTV3l98whUnNOSr2oTUW
         OsDp/PDWxH7oIBIPFcI0OSU5ljBntvDKOQh1QAqGXOh5PxduTIx304/mDl9aHuSWmf5J
         L8852YK+AfaTTkDcP/E3Q7IY68v0NTnVRbhzHp3WUiBMx+O+3hxasReMUtPHicQ6beuI
         z5/A==
X-Gm-Message-State: AJIora/QNgo15qnVGC4ThiOtF6pejgLHvSxuJgErpdGNx4FN6ueDkMqN
        6KSIdUI6aAuoIuM6ykQLv1+t/ryBnBPLtQ==
X-Google-Smtp-Source: AGRyM1tfcd/EN9bNHOdB0lihfDHNkoRbGPVjLa6AfF628mIVWi+vg43I+Azq7HsKQTP5OitdCjQiuA==
X-Received: by 2002:a05:6000:1ac7:b0:21d:134e:5d74 with SMTP id i7-20020a0560001ac700b0021d134e5d74mr44844340wry.78.1657205128650;
        Thu, 07 Jul 2022 07:45:28 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g3-20020a05600c140300b0039c96b97359sm29684100wmi.37.2022.07.07.07.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:45:27 -0700 (PDT)
Message-ID: <4447e5dc-8c79-7260-2d65-d86b5416d9a2@gmail.com>
Date:   Thu, 7 Jul 2022 16:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: mt7622: fix BPI-R64 WPS button
Content-Language: en-US
To:     Nick Hainke <vincent@systemli.org>,
        linux-mediatek@lists.infradead.org
Cc:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220630111746.4098-1-vincent@systemli.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220630111746.4098-1-vincent@systemli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/06/2022 13:16, Nick Hainke wrote:
> The bananapi R64 (BPI-R64) experiences wrong WPS button signals.
> In OpenWrt pushing the WPS button while powering on the device will set
> it to recovery mode. Currently, this also happens without any user
> interaction. In particular, the wrong signals appear while booting the
> device or restarting it, e.g. after doing a system upgrade. If the
> device is in recovery mode the user needs to manually power cycle or
> restart it.
> 
> The official BPI-R64 sources set the WPS button to GPIO_ACTIVE_LOW in
> the device tree. This setting seems to suppress the unwanted WPS button
> press signals. So this commit changes the button from GPIO_ACTIVE_HIGH to
> GPIO_ACTIVE_LOW.
> 
> The official BPI-R64 sources can be found on
> https://github.com/BPI-SINOVOIP/BPI-R64-openwrt
> 
> Fixes: 0b6286dd96c0 ("arm64: dts: mt7622: add bananapi BPI-R64 board")
> 
> Suggested-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> Signed-off-by: Nick Hainke <vincent@systemli.org>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> index 2b9bf8dd14ec..7538918c7a82 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -49,7 +49,7 @@ factory {
>   		wps {
>   			label = "wps";
>   			linux,code = <KEY_WPS_BUTTON>;
> -			gpios = <&pio 102 GPIO_ACTIVE_HIGH>;
> +			gpios = <&pio 102 GPIO_ACTIVE_LOW>;
>   		};
>   	};
>   
