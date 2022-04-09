Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF634FA741
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiDILYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiDILYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:24:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277802D7D4E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:22:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z99so4122745ede.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SCzhSNrRKCbd86faPRBvydP9I/4Y5+ZcmnKGbLOwqnU=;
        b=SbHHDzkpPWBPK4SYIDaXZNqmINDPEaL4pMtS2hyUR3KSZDKbNKVkxBdo4dMwCyC9Eo
         +LhWHqYQQBceMIfx8AN6cTGvFxl9+IhaV7FJxjtUytQErS/VFJD7SxIsPMBUPRdWZs4f
         EQuG+SKycajp513DqcWuMACUJEly4CdcpOjbdwvgCX39P4PnRhTfXWhtaP+KMZSgywXN
         Ef3vD3sK9i9Fk/HNovdHHNm2xuwqWQtHyKESj03J7oK06ymwrWt/04kW+VaBgQzry4QI
         Mh7YDMWezjejgKnm7v5hbNJFlPqllbmaN/1DQ2F18fu6hsFaI6ogj8YuETl/hHihLBy+
         hjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SCzhSNrRKCbd86faPRBvydP9I/4Y5+ZcmnKGbLOwqnU=;
        b=jVeaFVjABSxqzzb/v6R/RJuqHNdS2tfPONOxBqwPU3E4YPcGO5drbqez8vq2nj7twh
         abZH0GLQuFotV1mWYOa6fpmaYDnkXU3dvkV3IIYE5Em3sLJ7zZdeXJKHnSI6if+mLcTV
         Oo+IfrnVPcfdZT/bIHwkPbzv0IfzJO7suuUfsthsuf0Vxa+Z5vmzU3iGQwohRW9lYw2e
         hq/19F5NivrXGkcRRcD9+qHmsyafsurV7+Xof7RYHnbeDpN5cZOBgKjdrNEY7adkV0So
         MhIN1e7oOYdJiEtyVW4Q+mDismsc3zitDKCG5956ewhGTMcoqx93nizOyyOG2b7rjhuh
         +q4A==
X-Gm-Message-State: AOAM532pbXKGvTpTPyvfQD9DeVXENqhjHFSN1GIld9RKlv5HOfYLs+Xc
        W31wDpu39/cmlmygRQoRndz3QQ==
X-Google-Smtp-Source: ABdhPJztf0+IY1Rrex6cuag/BKeZ7Y38Cwi4QevqXNN+vcWJkKbuG+ASGC9A7rMPEyiwrRVC+wIVrg==
X-Received: by 2002:aa7:c58f:0:b0:41c:d8c6:b6a5 with SMTP id g15-20020aa7c58f000000b0041cd8c6b6a5mr23956580edq.181.1649503350737;
        Sat, 09 Apr 2022 04:22:30 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b006da6436819dsm9607341eje.173.2022.04.09.04.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 04:22:30 -0700 (PDT)
Message-ID: <623248f1-7ce2-7ff1-22d4-c56e0983c9bf@linaro.org>
Date:   Sat, 9 Apr 2022 13:22:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 18/18] MIPS: DTS: CI20: fix bluetooth as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <32a2afa1a8f1f675a199d1aa9b4469bed2391069.1649443080.git.hns@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <32a2afa1a8f1f675a199d1aa9b4469bed2391069.1649443080.git.hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 20:38, H. Nikolaus Schaller wrote:
> arch/mips/boot/dts/ingenic/ci20.dtb: bluetooth: vcc-supply does not match any of the regexes: pinctrl-[0-9]+
> 	From schema: Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index dc587b4b36009..8a120f9374331 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -207,7 +207,7 @@ &uart2 {
>  	bluetooth {
>  		compatible = "brcm,bcm4330-bt";
>  		reset-gpios = <&gpf 8 GPIO_ACTIVE_HIGH>;
> -		vcc-supply = <&wlan0_power>;
> +		vbat-supply = <&wlan0_power>;

Could be also vddio...


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
