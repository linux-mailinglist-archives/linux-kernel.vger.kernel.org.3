Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217975148B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358795AbiD2MAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358762AbiD2MAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:00:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A40B4924C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:57:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i5so10448793wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zhkPJZ5t7XS30nMpTj6bbXYcVhUfzJ6aKAQ3lOWd/GY=;
        b=nGMih1E129wjT8YxcuJjbbIO6kan3qaZU3FoAzN+SXh1WnJJeUvOsIrThuW7kchSp/
         P50XSKfkRWjPwm7BX0Lt/so0I6DiTARr9NRdByEHAScgigM6aAqLbziifarR9djETsd2
         tYs5eCcPnlOuRNp1OdJ0nMXpAjPYtQ4t+Hu0Sq6hkZ+l1zp3SMdAlDN++L+RjM3bA9Mt
         qPTUih40eH+pmIVllSKcW4UHSYIHWiaRIlkjKumRV3XA5Ix+0uV+mlI7bsfjIU4Ya4Ea
         J9b4BUNHvCptkdkXmvzxQQ5TZBABXB86XRIEBkHiJ8Utye8FRgGui3zaIF23IPcZyT/M
         oY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zhkPJZ5t7XS30nMpTj6bbXYcVhUfzJ6aKAQ3lOWd/GY=;
        b=JDpBHWxbhzEeLuEZSdTzbEg7ZAcYqDWFXSEsFJUhSQ6LlrjUoKQ2oSp5Z6JPEj9le/
         7JLc+lMUnmTCDgyly5f5Vh/e3KNqACfwRusdMa8WwtKNKPVSY8A6x+cTYSTH0Syo02US
         UotA8x/jnMAYQ9wN7XXXHrol1kYPXiA6uABoz8rOoe5vANAXlBFg7ZjXCbaNeu87v2yy
         MqlOwkL6BY7sz2E7sC6Z8rXW/cGjDFQEK8I6R5+sv7qSRnyKLdRqlt/pSJ3xWvxLNUt9
         zAkLvd0iTYkGTJW8ooHHjVBBAY/7LZd03qvi/5VXGAJesGC91uKZW/d/2KGWc4qEJCfV
         Uhwg==
X-Gm-Message-State: AOAM530PkIBVZElz+caLQnHZWp0d4dzQmxsO0C1NZa9xyh3ZElNNWNp0
        tNMhpJgrVZ/pyx3W1o6JekU=
X-Google-Smtp-Source: ABdhPJxXcg/TSEnSe3oYHf/l5nfkx/75A11A8wZ2bFw/fGOPv1y0qTM6UjmtOK5SSgG/4kvRt4DycQ==
X-Received: by 2002:a05:6000:100c:b0:20a:c68a:e9a with SMTP id a12-20020a056000100c00b0020ac68a0e9amr30552315wrx.314.1651233442973;
        Fri, 29 Apr 2022 04:57:22 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00393fbabdddfsm2518618wms.36.2022.04.29.04.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 04:57:21 -0700 (PDT)
Message-ID: <91d8eb87-adf0-da62-0c7b-dbf94442f535@gmail.com>
Date:   Fri, 29 Apr 2022 13:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: mt7622: specify the number of DMA requests
Content-Language: en-US
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ryder.lee@mediatek.com, daniel@makrotopia.org
References: <20220429084225.298213-1-rsalvaterra@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220429084225.298213-1-rsalvaterra@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/04/2022 10:42, Rui Salvaterra wrote:
> The MT7622 device tree never bothered to specify the number of virtual DMA
> channels for the HSDMA controller, always falling back to the default value of
> 3. Make this value explicit, in order to avoid the following dmesg notification:
> 
> mtk_hsdma 1b007000.dma-controller: Using 3 as missing dma-requests property
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 3d6eaf6dd078..5551f004945b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -924,6 +924,7 @@ hsdma: dma-controller@1b007000 {
>   		clock-names = "hsdma";
>   		power-domains = <&scpsys MT7622_POWER_DOMAIN_ETHSYS>;
>   		#dma-cells = <1>;
> +		dma-requests = <3>;
>   	};
>   
>   	eth: ethernet@1b100000 {
