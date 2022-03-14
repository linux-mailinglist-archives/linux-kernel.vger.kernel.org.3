Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06D4D79CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiCNDwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiCNDwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:52:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3365AF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:51:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p17so12438898plo.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Oqm6rMIEYZj78iej3CXr853eUOdIFYFax/LH5tNlQ4=;
        b=HT6ocqKuPFuAvF58pUg2kKkQKHEcOIlRgjO3OjMnA41k7rJvTugBLPWdbwSuGBrbm4
         hG8bU5/+Tu1cFFH1f2FY5KW8so58G5ibDdkgeGvmbU7IrG7m+zEc2Qb9KQjEb/gJhEIT
         aBkwd+ucbuLxui1U/Nj4IcMGywN++FYQg3HKrjR7+uWIC6csasTQROt8/LDExYa+b+/k
         r94RNe9ubcmA9iaq8GOsaFbhMLrBuxEOrBy8xAv+7B5i8Z/2IvGczVCTvZQKG12k7lFG
         x99atVsOaWmLwxUbSAmbva3PEDZ8OcxCQU3/IjX1YDj723fTn7pHr3E+3fi8T6Ow3LOx
         BPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Oqm6rMIEYZj78iej3CXr853eUOdIFYFax/LH5tNlQ4=;
        b=2MqDWYceSUyMt+ZVljNRGMHwYzGenm9haD/1p4GF1Cs9UmuOa17LeeVtvduTx3YHT9
         ybz5luWifFzpn7OnY3L7F7JtHdD3WoVVF/7tK19zkhltGU0rL6I0/1z+2AI5G8zeOA06
         Wgxx8BSgHOGSwcvjisjwbSGaBJ0fUWdbQ7wNSBiHm5W1BWHR4G/IJzLb8l3/31+uvppC
         CQ8OsrMx+Tue30cAIfV32EM/NVz1FabSu2mN26Itl/qs+IfofTnewh0c6/WHZJwAX3HL
         5lzUF78z0LLq1gUtPnRwyHzI0fBpNcOhvAejvnXeOmSJFw3zT3iEXEsCZxRlmlyc1Sod
         32tg==
X-Gm-Message-State: AOAM532tPObtmOvTjwqYfNul+BEdoeSGbE52ZcA4IRZg/YPl9cGMDSF4
        orlAocdyTqH5W2zy29G8TqBAkw==
X-Google-Smtp-Source: ABdhPJzRDv5E6ORpbQOsmkNhWUYCtTFzJpR8SogiKKLlKw0MvmqA5q9cATA2IpIJX4OlGa3gdrfVgA==
X-Received: by 2002:a17:902:d284:b0:153:6463:253d with SMTP id t4-20020a170902d28400b001536463253dmr4632616plc.54.1647229880920;
        Sun, 13 Mar 2022 20:51:20 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id t7-20020a056a0021c700b004f7916d44bcsm9179206pfj.220.2022.03.13.20.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 20:51:20 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:21:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220314035118.gbjbrwbsywxljjti@vireshk-i7>
References: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
 <20220312180615.68929-2-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312180615.68929-2-singh.kuldeep87k@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-03-22, 23:36, Kuldeep Singh wrote:
> Reorder dmas and dma-names property for spi controller node to make it
> compliant with bindings.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

What about a fixes tag ?

> ---
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

Why does the order matter here since we have dma-names anyway, which
was correct earlier ?

>  			};
>  
>  			rtc@e0580000 {
> -- 
> 2.25.1

-- 
viresh
