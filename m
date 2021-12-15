Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC0476293
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhLOUDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhLOUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:03:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E28C06173E;
        Wed, 15 Dec 2021 12:02:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e5so6719353wrc.5;
        Wed, 15 Dec 2021 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=15UlF7+uGjlTkwwX8mzVxbyazaBqLGc99zLGZEkto+M=;
        b=FP5GAk7B3qaNAoTR7zqIg100qjBKtzlqO3dniSqTNKaZfITZd+7c8DpWl/nGUEstuT
         SwJNkaBZydGstSCMXWyt+dAr8msoDsN7Fn7PFlQBZl6SfAR6NOOwiamNQVI9ndeMpHQs
         gP3T4MRQ4dHCodOVia4WNHbbLhn0WY13zBVY0agt51Ln4WCZmDuwnw1qTXPgHJ0nevPj
         Wzc4Aoxj2z01arRxqLpbFjrnz4TOxpzcBDPiAggSpQoDTINT4CYwpTJdeK7sEvoUQgYV
         153+zJ8p9XO2xUpgZai+6Ta5rZUlXYVwevN7yKfzbbx6xxmlclmc0aLfqM7NHA7Yivcn
         tapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=15UlF7+uGjlTkwwX8mzVxbyazaBqLGc99zLGZEkto+M=;
        b=0FfJ9ipJUNssE5zwJHTR4vVhs0fMPnuOSJT+Ja3jVSct2dP7lzkoYA1oEGngHOwyvc
         8VASKIpB/buHBHRivCfvH6ZGlpG2gaU27hZeJu5DLtj3eBN8Rs/PLkT5wjUasMAnNw4B
         BUJsbmXZEpLPXFEuKBQUX4w9NlEMUanBUtvLR7xytR2vjB7NmJVh33l+2t47EcGpf7ds
         +ks0g++/oMZBsqgtO6rLTUacg2lJxghSqv5jjfhGmUZTnr0qlFSIc7MfNDTsTutiDwV+
         uErW6GMvsszMfS0Gugcqz4yUllJ/gid7044Ba5SdrQ+xoExhACrSsj5Xld/eu3sXvemy
         omxA==
X-Gm-Message-State: AOAM533vQTmPdMrU8Cme0aWlmf4JrS6i3l/6yLphMp+9OvsKM8N/7Cwe
        oJ/jH8s7timi0DvNOJgd3f8=
X-Google-Smtp-Source: ABdhPJz0rKBo+MEebuAgAGMFyRMLsT9h33P48BbZMO47N1W8KxnvFvS5O7uqrk3ujwiK88+V8BDUjg==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr5912265wrw.486.1639598578493;
        Wed, 15 Dec 2021 12:02:58 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id b10sm3362890wri.78.2021.12.15.12.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 12:02:58 -0800 (PST)
Message-ID: <c62f562f-c446-4986-2915-00c01a2aff1a@gmail.com>
Date:   Wed, 15 Dec 2021 21:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] arm64: dts: mt8183: kukui: Add Type C node
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     Alexandru M Stan <amstan@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20211209195112.366176-1-pmalani@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211209195112.366176-1-pmalani@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2021 20:51, Prashant Malani wrote:
> Add a node describing the USB Type C connector, in order to utilize the
> Chromium OS USB Type-C driver that enumerates Type-C ports and connected
> cables/peripherals and makes them visible to userspace.
> 
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Applied to v5.16-next/dts64

Thanks

> ---
> 
> Changes in v2:
> - Alexandru mentioned that HW specs suggest preferred power role for
>    devices like kukui to be sink, so changed try-power-role to "sink".
> 
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 94c13c459194..0f9480f91261 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -886,6 +886,20 @@ usbc_extcon: extcon0 {
>   		cbas {
>   			compatible = "google,cros-cbas";
>   		};
> +
> +		typec {
> +			compatible = "google,cros-ec-typec";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			usb_c0: connector@0 {
> +				compatible = "usb-c-connector";
> +				reg = <0>;
> +				power-role = "dual";
> +				data-role = "host";
> +				try-power-role = "sink";
> +			};
> +		};
>   	};
>   };
>   
> 
