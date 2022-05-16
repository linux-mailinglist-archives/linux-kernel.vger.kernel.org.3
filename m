Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A615288CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbiEPP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiEPP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:27:02 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DDE12754;
        Mon, 16 May 2022 08:26:55 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-edf9ddb312so20530436fac.8;
        Mon, 16 May 2022 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KHyeVKxqxatLeY3gDq4jdVF9Tt519Zk/h+VHXOLojzc=;
        b=KewvRBMJACjGiAlIKD93nIY5CDbfu7LGLi5U9OT3JumiPFbrpxe/9hLyeFkc/lrj9W
         nyGDOJdITBAxQzLjMsAtN3oVx6acR1EWDeCWuS5Bd76MnSfwqtGsu1op6ye4kfO5CSEg
         kyAvSbwiXB2Wctjrp7/yIbHPfXU8bo/c/Na8FsNDrd2IewsEeOUHsrgrbCChJFtxq4Xg
         IbIjbK0xHOfAtds8bB6vnnsS1hu/Zv0xIdI/oEbKwWOt7kdKS6i1efSkkS1/Yh+RkHIv
         AcFdJQl6YijSS3Vzpn7tqldQsxM+mtnHyKfaPlcsPcTq3aYi7vFD5B1VH2e5WXC3ddxO
         Mftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KHyeVKxqxatLeY3gDq4jdVF9Tt519Zk/h+VHXOLojzc=;
        b=tJChQStwvwqF2VBreDpMlHcHk2fInDb+4XutpKFhIzIaNBQn1y+dcfwiy2TnWSvmTF
         Aza7Md5bST8lepRWHm83VAZA89tXGbxDXPlmoYTKcdbGr6Jni1jJcojh9cwGigr8rtmS
         al6Zjp42rYcMG59gYG+tBe6d6HTOVJqdUYkCHXq6xe5efpw47XgnKHPpHea6x3RO9jQn
         3V+GtACDVx9FNm6u7Je0JOSLtod3ezEnbYEyX/lKFBM0OzbSkPC63Yco0bOGVt81eRCY
         mTtdRYOXq7gXWVmZ1mIyesTPzEzNbT7qbkihg4+wCptTRFCgrSBgtVV6d/GRANz9A0jM
         3Stw==
X-Gm-Message-State: AOAM532FG9XcG058P247KiVrPeyRuP07jYZynK+cyGOYyun4IBcN706t
        2iRwPnkw4CxiPBC1zfQMtj4=
X-Google-Smtp-Source: ABdhPJzIjGJ8YJEvupAXFxrzzx+fCG8rregIbh6jLEAET5ITg4EypP6IKnXddR5n4Rh0gU+G8PeHrw==
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id cv18-20020a056870c69200b000e9536810dfmr9767194oab.182.1652714814852;
        Mon, 16 May 2022 08:26:54 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id z30-20020a056870461e00b000e686d1389fsm5475774oao.57.2022.05.16.08.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:26:54 -0700 (PDT)
Date:   Mon, 16 May 2022 10:26:51 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/6] arm64: dts: rockchip: enable sfc controller on
 Quartz64 Model A
Message-ID: <20220516152651.GA18461@wintermute.localdomain>
References: <20220511150117.113070-1-pgwipeout@gmail.com>
 <20220511150117.113070-7-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511150117.113070-7-pgwipeout@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 11:01:17AM -0400, Peter Geis wrote:
> Add the sfc controller binding for the Quartz64 Model A. This is not
> populated by default, so leave it disabled.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index 71df64655de5..6ec349e7e521 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -603,6 +603,22 @@ &sdmmc1 {
>  	status = "okay";
>  };
>  
> +&sfc {
> +	pinctrl-0 = <&fspi_pins>;
> +	pinctrl-names = "default";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "disabled";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <24000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <1>;

This isn't really a concern, just a comment. Did you test this with the
spi-tx-bus-width of 4 by chance? While I did have to use 1 for my
implementation (the Odroid Go Advance) the Rockchip engineer I worked
with couldn't replicate the issue on his end and we ended up chalking
my issues up to an implementation specific problem. I'm only commenting
here because I don't want you to think that for this device the tx
always has to be 1, of course if your implementation does have issues
with a tx of 2 or 4 that's different...

Thank you.

> +	};
> +};
> +
>  /* spdif is exposed on con40 pin 18 */
>  &spdif {
>  	status = "okay";
> -- 
> 2.25.1
> 
