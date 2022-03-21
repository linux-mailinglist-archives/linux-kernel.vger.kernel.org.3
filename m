Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2997B4E21BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbiCUIKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245434AbiCUIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:10:52 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA73EF26;
        Mon, 21 Mar 2022 01:09:27 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a8so28169646ejc.8;
        Mon, 21 Mar 2022 01:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pw5lsVUz0Ir+3gmHl6bnqjzHIIxrCJviXeYssI5KaMM=;
        b=LbF/Il1YfztjHKauvdUQvIwYI+On1QW/TwQQRDZ1mDGDLm/sFHsyZndhOuHKiFJz6k
         WCNDa3+pLMDtkkYNANjCvio34lgNolyooFttZtJWJP3y5ARYQFYrQ+HTlvAhr8SZiD6m
         nkXgYTTmqemN7F64gi7L8xKiAxFwDV00m2iDovzMg4zBtahnD/x1zuBC0r6K+zB4oahT
         Pj75QgV/5YMRWF0jncbxS76QhrP5YVxozNfl1XeXQ2ABRFq1U4d4LSrGIZck3vDmJ2+T
         1ZxIg4+s6WXayeEHduy9QR+q1UAWIzB2okiIe4+/rbQ8xLAtxoIKTWOem7elB9o+60Fi
         mXtA==
X-Gm-Message-State: AOAM532EHN4kWDD99s+iVvsyE6StDxSl3iyDiFOHHFudZ0NJiZWisXSU
        83BPlFbjGEOW+SPYHyiRr1U=
X-Google-Smtp-Source: ABdhPJznDvTzj/P9jXGE/RdBvcXaMvpJdp/yAQs92uOyqYi85uJWg+JEx8PuE5KBRATae/8B/0uK7A==
X-Received: by 2002:a17:906:c114:b0:6d8:cfd4:f746 with SMTP id do20-20020a170906c11400b006d8cfd4f746mr19016139ejc.538.1647850165921;
        Mon, 21 Mar 2022 01:09:25 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm6663308ejd.11.2022.03.21.01.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:09:25 -0700 (PDT)
Message-ID: <23aef3f4-c205-88b6-73aa-5ecbd1446395@kernel.org>
Date:   Mon, 21 Mar 2022 09:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 2/2] arm64: dts: imx8mp: add ddr controller node to
 support EDAC on imx8mp
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        manish.narani@xilinx.com, michal.simek@xilinx.com,
        dinguyen@kernel.org, bp@suse.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20220321075131.17811-1-sherry.sun@nxp.com>
 <20220321075131.17811-3-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321075131.17811-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 08:51, Sherry Sun wrote:
> i.MX8MP use synopsys V3.70a ddr controller IP, so add edac support
> for i.MX8MP based on "snps,ddrc-3.80a" synopsys edac driver.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 3f8703f3ba5b..f39da2b12ddc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -902,6 +902,12 @@
>  			interrupt-parent = <&gic>;
>  		};
>  

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
