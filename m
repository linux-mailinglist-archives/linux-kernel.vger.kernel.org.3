Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229534F1076
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377886AbiDDIFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbiDDIFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:05:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483B186D1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:03:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k23so595603wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8SQNSCl1uQRFQcDuyQdlt7wBlezOf9jiirA2VzBwlTs=;
        b=r7qbe0tbTjLNBedoiJzvlcd0MyQzMz89evtKZ45Moj8D2/wG66KyV1n8k8DOp8d6fj
         Y0/NgMDCFdJPZjLhXBd4X6t3IqVMTtFYcYv2xlc7qmKvB0o2rTaFxJew1fRY5ydikaoS
         6pYJ5mxtpL2IQCKXQFbETsgSOkfwesqVrUGv58cr8VVT9WkvP0TMrVlzJStclZNlCTbz
         xrcCnJX2m6T/5mVZExDIjRN68VcearoFIBnQTINBtWZmuVBnJayyYD5i6SYCZocu/pkl
         MeRSYCNnaT2X2SFZ8LpiktDFhRqmWYVftCc11bmOWdbR2kCUeiJSMftZcE2+RoRqb/XS
         OcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8SQNSCl1uQRFQcDuyQdlt7wBlezOf9jiirA2VzBwlTs=;
        b=4ojzYqPaosVJr8cHMMzXLulm6X7UiRiMt5e7ZJEBWgQZc+zL+gLUkhjKPyJW7mKKvG
         KwXKamiZUlkhG3O7jqIEoZFTj0rAjXbOwjh6MRTCeQ3dHBfVNEfEwXHWma+tb0ulP4Pd
         E1qHnRSfT83iF4NQshixvfiSFNCrWZoUjN/BkG9Hokj4GIIf7uFI/MWm5muLgaiebx7/
         u4eJsDDlnGmE8VAUm+7M1m1u5PW63UFYH386ItVGXeWbOh5HxytNi8hE1KaCojdwfQ6d
         uLDRnUsQtvoNLOQRZutd1I1hOBigZaPMfICKZp/qJD4FZHAjhfIhMXTzS9i3t9vpDNzd
         UzYA==
X-Gm-Message-State: AOAM530NDBvsAmjAJoNZ2s+tPITWCSrTLTXvum7jwn5irIvbjcxNk+P1
        AcBXAckJG1iMbG1mc/EZA6YnpQ==
X-Google-Smtp-Source: ABdhPJwnzzQCrd/ul/KUoS0o1nlGzDCH/uXy9DdlPxkD6ROj6GeaZpPH1NaKlI/9Hbf7XDWlF5NnvQ==
X-Received: by 2002:a5d:6d8f:0:b0:204:101e:753f with SMTP id l15-20020a5d6d8f000000b00204101e753fmr16529793wrs.707.1649059423757;
        Mon, 04 Apr 2022 01:03:43 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:1add:1b28:2457:eb46? ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm8814162wmz.43.2022.04.04.01.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 01:03:43 -0700 (PDT)
Message-ID: <048b9b97-62b9-5add-9d37-0f91f708a3dd@baylibre.com>
Date:   Mon, 4 Apr 2022 10:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V0] arm64: dts: add support for S4 power domain controller
Content-Language: en-US
To:     Shunzhou Jiang <shunzhou.jiang@amlogic.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220401110306.3364551-1-shunzhou.jiang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220401110306.3364551-1-shunzhou.jiang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 13:03, Shunzhou Jiang wrote:
> Enable power domain controller for Meson s4 SoC
> 
> Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index bf9ae1e1016b..96ea95ea5eb9 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -60,6 +60,12 @@ xtal: xtal-clk {
>   		#clock-cells = <0>;
>   	};
>   
> +	pwrc: power-controller {
> +		compatible = "amlogic,meson-s4-pwrc";
> +		#power-domain-cells = <1>;
> +		status = "okay";
> +	};
> +
>   	soc {
>   		compatible = "simple-bus";
>   		#address-cells = <2>;
> 
> base-commit: 1930a6e739c4b4a654a69164dbe39e554d228915

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
