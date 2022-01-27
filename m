Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821F149DFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiA0KqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiA0KqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:46:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0022CC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:46:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c192so1573311wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NkxIb+P+5+H76bh6f83+7pLlqmMSsgvAiVmWl5dkrqY=;
        b=SpMp+sRuCSmEpu3Ipx2TZyuKCfwRyDnM/JK0kN2/kolIcyDpWYisP4jcbMe3oTJ34x
         OMXSgxwl59uvQ3b7OZEuEyRoCLuzXgSocMh90+5l0n5qYXWoVyHmCEoGJ8f0PO+/lxiQ
         io7Bh4UdHajE07PIICHF6qzncOBVQkLtU3F/8ktxIQMcS6fFRNJKiOjjcllp4i/6a8RX
         WNK6m5kFgD54MFHenOjsN8D9NdNA+sumDh5KPA0nbZuH966z2PXseDdu+5d3Bx8rPD2w
         irZA1W9TSnO7N2z0TXS7jQV9RgLTK6HG/qfAFqOwzL+78w4ZLbP3twGCgJqgqqaIL4h5
         x3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NkxIb+P+5+H76bh6f83+7pLlqmMSsgvAiVmWl5dkrqY=;
        b=DNOwljSwJaBozwBvbxo13glT7OekikCAWDnfzjdKWaQvmy9ljKuVl0kJC2oKdohYk9
         RZJY0bJdSSgTozD75KXL8TAmLgZkzJiEQ4AM9p56vXn9KxnHXJdDXvfItRwghIta2Pbp
         IsjFN9+k76VLuQTv4xKk4UqepvUOgkTLbacMvfBPS3CgcTBd1p3TB4o6KKUiPuojjBvf
         Qm9h1/oJBv8812P6h7ShxE9HVgf3js8zpk2ooyJq24gguODEKJUaqy1bt0nmSl2X6q/i
         dhycSW3knST7OVaYxCXOV6cBaLz+KiQdnFicHuC03Cswh7hHYZ3i9jolXWxVzwQR3zh2
         eDmw==
X-Gm-Message-State: AOAM5322eH/LqsKTgG9t75D281DgZ4qb8qN10G2yO6SU+XaYvMa+0MxC
        IcFtzTgJkittRcYqXISO8V+mtY7hda6zbg==
X-Google-Smtp-Source: ABdhPJzo3DHV622CAx9cYAdqcbvj9NzeXAZjWl1L9efjh/UkXJP6ZQ+49u/zGuYitMDsi0zubeKw4Q==
X-Received: by 2002:a05:600c:4e0d:: with SMTP id b13mr11204582wmq.99.1643280370135;
        Thu, 27 Jan 2022 02:46:10 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id o27sm5651453wms.4.2022.01.27.02.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:46:09 -0800 (PST)
Subject: Re: [PATCH 1/3] arm64: dts: meson-gx: add ATF BL32 reserved-memory
 region
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220126044954.19069-1-christianshewitt@gmail.com>
 <20220126044954.19069-2-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <517ef196-e622-7ed5-c3be-55ac3f054b74@baylibre.com>
Date:   Thu, 27 Jan 2022 11:46:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220126044954.19069-2-christianshewitt@gmail.com>
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
> Suggested-by: Mateusz Krzak <kszaquitto@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 6b457b2c30a4..aa14ea017a61 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -49,6 +49,12 @@
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
