Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCEE4E54F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245073AbiCWPQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiCWPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:16:09 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C6D19297;
        Wed, 23 Mar 2022 08:14:40 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id x34so2213122ede.8;
        Wed, 23 Mar 2022 08:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ZSMkVY3ypFF5CUFzotg9EkiWatCvXqueR6ZkIkw+X6c=;
        b=Xnkg564l0dyix48+DbGa3gUE/Npv3nKCb5nmzx05JDW8Dv/V/KOknAEyqwwp3F5UrW
         efmO1QzK/MbadBhmUSFkK4dSWOBgqHQqUJNtuoxiElvkni7MfcjLwR0fDmvPULALOwWD
         oAmiT0i6Jc0uElIJIX2ut8EO86zCFx8qPmwN103ES2iRKJ7ajS2026M3g4WO9/xPh4hk
         6c79jdZcZdZg27lhEJl9gXuxiKid1To1fI/VCKMomGOURv7p3IsbDTddZ/KaxQmJa9z7
         8+sguFQaxXkAzCbtcrwtiaydpvdaZDelgmP54x+yNmREyjIkfOCkpoK2zcg5fd6vx+pH
         vWVQ==
X-Gm-Message-State: AOAM531PEo1KC3QI/z3XAA500K8vqtPGsxx3z8U/Aq3MoAJVZnsTSin8
        RClG6mTLRCKAutotD2Ayt30Y2tcb9taThQ==
X-Google-Smtp-Source: ABdhPJwSCzjn/zmol5l+DlwUkqngqhKuSGBlzfoEpsLaFQqrxSqpHvxHkAHYs21prB7jw2tZ3/SxRg==
X-Received: by 2002:a05:6402:40c9:b0:419:4b81:162e with SMTP id z9-20020a05640240c900b004194b81162emr674996edb.380.1648048478725;
        Wed, 23 Mar 2022 08:14:38 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id p23-20020a170906605700b006ccebe7f75dsm51859ejj.123.2022.03.23.08.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 08:14:37 -0700 (PDT)
Message-ID: <4ebe2bb9-4f92-2dff-6737-d057e5950b24@kernel.org>
Date:   Wed, 23 Mar 2022 16:14:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/7] ARM: dts: s5pv210: Adjust I2S entries to match spec
Content-Language: en-US
To:     Jonathan Bakker <xc-racer2@live.ca>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <CY4PR04MB056784D54ADDBB4F57F82D4ACB189@CY4PR04MB0567.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB056784D54ADDBB4F57F82D4ACB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 16:03, Jonathan Bakker wrote:
> Based on the device tree spec, clocks should be ordered tx/rx.
> Re-order from rx/tx to avoid warnings when running make dtbs_check
> 
> Additionally, the number of #sound-dai-cells should be 1, not 0
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi |  2 +-
>  arch/arm/boot/dts/s5pv210.dtsi       | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
> index 70ff56daf4cb..503b5a50ef1a 100644
> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -644,7 +644,7 @@
>  };
>  
>  &i2s0 {
> -	dmas = <&pdma0 9>, <&pdma0 10>, <&pdma0 11>;
> +	dmas = <&pdma0 10>, <&pdma0 9>, <&pdma0 11>;
>  	status = "okay";

Except that fix that's the same commit as here:
https://lore.kernel.org/all/20200907161141.31034-26-krzk@kernel.org/
so just extend it.

sound-dai-cells should go to a separate commit. But are you sure they
are correct? The Fascinate 4G seems to be using them as cells=0.


Best regards,
Krzysztof
