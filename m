Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C598C49DFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbiA0KqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiA0KqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:46:22 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FE9C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:46:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s18so3932626wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jMJUQQRNGQfSVpTNxYkQjgWKQuRwp+63flTuqAq51FQ=;
        b=u3w9o4lfjlVkkkP5URbtPSU9Oll4DJlepTa3I2gW+BSrLpjzv6SpUTIEZcOIlpc3mR
         qsWEh9Q+4LE4txajrQgxHMdp6LJzBNn/X3SvwuNw6Ob/lHoslGVAavqUldTSltQHAFgu
         zwiPfza1RwmSSMSFqNICd4jjWGmXJd9xkp2v9otjYWZNqRrHtFwzjLqZs7OkQ4vAB9aj
         zRD4w/5dIyR1sPPw/AHH3izsEc5t92cj540nCrBfPuZ41pHlDUicM0cF67F/vOCvyUcA
         pOVWWrcwWT8GOXDvsPJ57BWjxBBowsqpnyzXbm7d0JPuj1waxw0NUIQxaPXFI8odqq4/
         jw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jMJUQQRNGQfSVpTNxYkQjgWKQuRwp+63flTuqAq51FQ=;
        b=Wxgw3Tnwc1obvyshXir29jftfvoW7Qdz19Xgf56aoLE2AtxbYdiRFR6ahQNVdItKTF
         boZTASYmUJekkNJmAnZxV4ME8+f5WURbK3LSnpt6dax3EZvunYwIdsrwkGOBYd42v0Wa
         earm/7+z9yK3vF3Ct2B2SSaETIKCln85VLmIfgaxl5CTypIqA/l5a2Kuct8DlB+mEYAN
         wa3CKjlOvFLpBYUdvebnO8OkJmVpMJRqg9byhEgJkvqCWe+QSMytudtkgpEip7XwFNs3
         AhOyI0oYqQraHm2HiS/KrXjBa2rYyx60Gt3Rn+0orPuwbfxHHiFIXt9dpeE7mFLJKnFV
         NkFA==
X-Gm-Message-State: AOAM532euvvul7en9+HM5s3hD6OO9N3QlTUueQ/UVqhDOEEXPak+omQg
        A4qbBOrU4JYC5UIZt+Ydj57olvD2d1Egbw==
X-Google-Smtp-Source: ABdhPJzAXLovLm3w1LwAV/9nZMMIWduZnrezt5OZmEwVVa7+NgBjFiaSXlAQ6BzecVuIb5qQWnhN4A==
X-Received: by 2002:a5d:6d03:: with SMTP id e3mr2537467wrq.536.1643280380592;
        Thu, 27 Jan 2022 02:46:20 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id l13sm5830775wmq.22.2022.01.27.02.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:46:20 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64: dts: meson-g12: add ATF BL32 reserved-memory
 region
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220126044954.19069-1-christianshewitt@gmail.com>
 <20220126044954.19069-3-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <af845f03-6bd4-cc78-2b7c-a32257f8773f@baylibre.com>
Date:   Thu, 27 Jan 2022 11:46:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220126044954.19069-3-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 05:49, Christian Hewitt wrote:
> Add an additional reserved memory region for the BL32 trusted firmware
> present in many devices that boot from Amlogic vendor u-boot.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 6d99c23261fb..45947c1031c4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -107,6 +107,12 @@
>  			no-map;
>  		};
>  
> +		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
> +		secmon_reserved_bl32: secmon@5300000 {
> +			reg = <0x0 0x05300000 0x0 0x2000000>;
> +			no-map;
> +		};
> +
>  		linux,cma {
>  			compatible = "shared-dma-pool";
>  			reusable;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
