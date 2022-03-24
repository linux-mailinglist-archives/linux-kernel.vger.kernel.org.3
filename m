Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEDD4E5D43
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346844AbiCXCkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCXCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:40:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D092B3C722
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:39:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b8so3518653pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lLmU9eaNbQZtuAnKmKQfSZbES2JI+sc9+LEMrBqU4oU=;
        b=dnVbf83bqgCMp5cYxA71grdC1mbKtFSVFvEj+qoYy6rhknJ4YfdZNDk7jhGPnziFVN
         FUQlh1n+Ey9VUcqr304xQkZ4p+aAsR8YYceECVxQvDI3XpWNTHKkxN85CY4XWBWetREa
         v6DOVnDwfFYkqNd8UlACDQJ9Q4WJ8AUaq8VGoQPpfD4lPdjMllnDS/ppUA7hBQG4SJPX
         Yc4TTr2Pb3zrQdWzhEmJPJtCMDi/oAU23S0qX1VWoAQZACK8LSETLXFPf0pkRKcoP5Ip
         9Y39LBqKNMa6oHUITZMLdtae8wjuXW8f7useNMMYPwx86U2CirMQhvdD/xsLwC7z5d4O
         0WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lLmU9eaNbQZtuAnKmKQfSZbES2JI+sc9+LEMrBqU4oU=;
        b=C4KHpDzCWvd6gsf8YXJscO2QGTBBuXI6pSZVrXLAI+yvPbBRI4FTF71Yp5wswtDzb7
         rVAaCdwEGUgleJZIqH8DFSNj94gpntm98oSdz3ouKX2D88ko43EhVGW7xeoEh2iKI8ef
         37cK0WRJPlDpWCtZHiyIgFKyaUfIeBk6koDc0Jvg7BdcPmm28UCGi7oSL2JlShtfi/Ff
         CMwCwyx+Uyu9EzPLxrL/9PWE0Oh7MSA8vcMH6gmXLoNv2YxsI35ol0AbpdO5EM4FL2TO
         sA8XqxmpD97JHmehJ5zQAZ6Pmdg2DZMNIxPx1hdBy68OcNOpGGFxway9GAAN2LhweO1F
         EBaQ==
X-Gm-Message-State: AOAM533tk4ucqePZXU2q6ZI/pa0F5d3Du4Pe2/xsFxw8/Ex8U1FWbNC1
        FGc+Tircle7zgi/6Q5z+brUP/9oI2bQ+6g==
X-Google-Smtp-Source: ABdhPJyB4BzVu6jeixu1gk0n4B4VYDuwYKx1dB0266XakOvXJ0YNren71lhLRwBZGZOhpl9m1LLSLw==
X-Received: by 2002:a17:902:8497:b0:154:9282:bc01 with SMTP id c23-20020a170902849700b001549282bc01mr3418482plo.33.1648089547345;
        Wed, 23 Mar 2022 19:39:07 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id oo16-20020a17090b1c9000b001b89e05e2b2sm1001104pjb.34.2022.03.23.19.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 19:39:05 -0700 (PDT)
Date:   Thu, 24 Mar 2022 08:09:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220324023904.h2qfxzxlznggbsyr@vireshk-i7>
References: <20220323175920.93155-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323175920.93155-1-singh.kuldeep87k@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-22, 23:29, Kuldeep Singh wrote:
> Reorder dmas and dma-names property for spi controller node to make it
> compliant with bindings.
> 
> Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> v2:
> - Add fixes tag
> - Remove 1/2 patch from series as it's not required
> - v1 discussion link:
>   https://lore.kernel.org/linux-devicetree/20220312180615.68929-2-singh.kuldeep87k@gmail.com/
> 
>  arch/arm/boot/dts/spear13xx.dtsi | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
> index c87b881b2c8b..45f0b2a33e02 100644
> --- a/arch/arm/boot/dts/spear13xx.dtsi
> +++ b/arch/arm/boot/dts/spear13xx.dtsi
> @@ -284,9 +284,8 @@ spi0: spi@e0100000 {
>  				#size-cells = <0>;
>  				interrupts = <0 31 0x4>;
>  				status = "disabled";
> -				dmas = <&dwdma0 4 0 0>,
> -					<&dwdma0 5 0 0>;
> -				dma-names = "tx", "rx";
> +				dmas = <&dwdma0 5 0 0>, <&dwdma0 4 0 0>;
> +				dma-names = "rx", "tx";
>  			};
>  
>  			rtc@e0580000 {

Rob,

I tried to ask this at V1 as well [1]. Why do we need a patch like
this ? Isn't this a DT tooling issue, where it is asking for a fixed
order of values ?

-- 
viresh

[1] https://lore.kernel.org/all/20220312180615.68929-2-singh.kuldeep87k@gmail.com/
