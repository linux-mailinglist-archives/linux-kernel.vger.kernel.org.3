Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33AE4F6581
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiDFQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiDFQc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112C6220B0A;
        Tue,  5 Apr 2022 18:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C96D619B3;
        Wed,  6 Apr 2022 01:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9027AC385A1;
        Wed,  6 Apr 2022 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649208236;
        bh=y610PixkxE0FbqCL6lBrY29URlY0CZAXClPdmkzBRr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPT1GL31n6ypgG8+0qeuiomp4TGySTjAhFA1JoBIEH4K6CR2KfpyHO0IfL9ksSOyo
         v1o9u56Y/wVLQCrdJzucyk86wNkIe5XNeC/Vb+XHGU0ASvnAKTdfdt6klXsKbbTjdD
         AdCjGtPjCp9IpQVGCZzS8EhDuF6lBOfUwbM4hma6sppIYVWSMhp9zMP6D+I7SHobpV
         68YfptgKuHu/pfZ/xKk6/DSmloIy5b85XZ+zQE58B4lRS7Gy+P+TwxHRQ/EWLyriga
         PAxTJ0yjK+XOmAMZ0Eg077Rs85AQsgqjk9sgvGaSbxSCLUTQ5TPjy9gwenbIKvBX4h
         jb5R27IhVqK+A==
Date:   Wed, 6 Apr 2022 09:23:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 1/8] ARM: dts: imx6qdl-vicut1/vicutgo: Set default
 backlight brightness to maximum
Message-ID: <20220406012348.GE129381@dragon>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221095312.3692669-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:05AM +0100, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Recover default behavior of the device and set maximal brightness
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6dl-victgo.dts   | 2 +-
>  arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
> index 227c952543d4..e6134efbfabd 100644
> --- a/arch/arm/boot/dts/imx6dl-victgo.dts
> +++ b/arch/arm/boot/dts/imx6dl-victgo.dts
> @@ -28,7 +28,7 @@ backlight: backlight {
>  		pwms = <&pwm1 0 5000000 0>;
>  		brightness-levels = <0 16 64 255>;
>  		num-interpolated-steps = <16>;
> -		default-brightness-level = <1>;
> +		default-brightness-level = <48>;

Please take a look at the documentation of the property.

  default-brightness-level:
    description:
      The default brightness level (index into the array defined by the
      "brightness-levels" property).

Shawn

>  		power-supply = <&reg_3v3>;
>  		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
>  	};
> diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> index 1ac7e13249d2..c1d06bc28c67 100644
> --- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> @@ -23,7 +23,7 @@ backlight: backlight {
>  		pwms = <&pwm1 0 5000000 0>;
>  		brightness-levels = <0 16 64 255>;
>  		num-interpolated-steps = <16>;
> -		default-brightness-level = <1>;
> +		default-brightness-level = <48>;
>  		power-supply = <&reg_3v3>;
>  		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
>  	};
> -- 
> 2.30.2
> 
