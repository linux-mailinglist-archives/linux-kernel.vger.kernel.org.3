Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807B8504F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiDRLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiDRLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:49:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E05167C0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:46:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u18so17186330eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+cw4FNIPaljad3e8DVkQCepUmXxjBo/m/1jzgFfcs8U=;
        b=EMcu0tCDeljFb7yHhoncmFDGX2SNBoNZN7shP4Vbct870LIS3zdaHeLX47ou4Q+5D9
         dZYybx1/z7lfr+84/yT46CL0XbfDr0nSxKz6+vCHyIkyZCrn6zfEgtJ+x98m1m8v0PTG
         2TgpWiJex5byMDJ6mi53I5qkeuPWAQnBT4PxO7Rohb8x3nlcVJL08dz+kXpL++Nl4RBv
         5fPp0twwX/XxBTU1wbXFwyCQGxfxf6PaqWgB2ChGMpLe2o42PTgXTrqS3Vvcip0zbOXm
         uGRIKClvBlJGV52N3TULTQfRzrTbSqgGgXPF5rg9GTw1NVnQ8BU2teLRbn2vOPdR6fsQ
         Z9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+cw4FNIPaljad3e8DVkQCepUmXxjBo/m/1jzgFfcs8U=;
        b=V1iGQbXPmVe7s0L0yZ84ybeK5fmQLiFivimJ2AY6IG/wEmjAOfssxUxZXJtRFWikj7
         kwAfKcbOdH3CeMiKJy1hzuNrZFINfuTiLG/VFQD1jkxOpO59eNUF5Mn1sPuE2t6PUoGl
         cjcqvYIzuLRIMZFuc/lS2LjJCgcIT6alW6BRZ9u8UFjp2tm5/cb1Z1Z1w7ZQeE0hfTCn
         iPbmpGAev8xx3mGvAiiDBx7lhPhd+zvvgclRAfxBHNZqP6UNv5tytRmTN3BCSp/J/mzQ
         0g6A1wxBzDrpUITW1dF0VKiLOw4YpoU5fVSG5Nj1/ypPFeekRGXCFUNyeSyGyxxF96fm
         TMZw==
X-Gm-Message-State: AOAM5317RjB9HrZTiKQA8KvRfWdaqCBpZEQsW/ZrfZHs0ydAEZ5qAx+V
        ku933+NqnYGLMp9SeNSvlXK7/Q==
X-Google-Smtp-Source: ABdhPJywPDma12a05kBaxZILSMPLyMoVhakudsXTChLuj+deflBnxYq4hwWmM8t0rSpj543MZo2mCQ==
X-Received: by 2002:a05:6402:2056:b0:41d:70c3:2904 with SMTP id bc22-20020a056402205600b0041d70c32904mr11725923edb.397.1650282406266;
        Mon, 18 Apr 2022 04:46:46 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402154200b0042323822e15sm4345412edx.74.2022.04.18.04.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 04:46:45 -0700 (PDT)
Message-ID: <df46a147-c4c7-c0bc-e195-d47344413b29@linaro.org>
Date:   Mon, 18 Apr 2022 13:46:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8195: add UFS HCI node
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220415165939.1861470-1-fparent@baylibre.com>
 <20220415165939.1861470-2-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220415165939.1861470-2-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2022 18:59, Fabien Parent wrote:
> Add the node for the UFS HCI controller for the MediaTek MT8195 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index b57e620c2c72..2255e19cc3b2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -619,6 +619,30 @@ mmc2: mmc@11250000 {
>  			status = "disabled";
>  		};
>  
> +		ufshci: ufshci@11270000 {

Generic node name, so just "ufs".


Best regards,
Krzysztof
