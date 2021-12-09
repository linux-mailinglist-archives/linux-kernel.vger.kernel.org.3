Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF646EC7C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbhLIQHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240565AbhLIQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:07:29 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65018C061746;
        Thu,  9 Dec 2021 08:03:55 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id k23so9753310lje.1;
        Thu, 09 Dec 2021 08:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=cb7DP4xQRrR7eaEbn0nK2nl/RVqJ7P0xuMj6assZJek=;
        b=WvfEK1oUK7PCmcUwb7qqB5b7t/tqkKwJy25w5G2ZpXi9fXnA0lP0F0Zd13IgPsYYzv
         DUg3NLq35vVC3ZDxjMlvNaZHaOB6NDNSSf5a57QJWhGMdeApCnf+6Rj2h80bD+exo2S8
         SJrKkZqx0gEFhuWgsTYdhUovek/wQQtM7FtXIr6y4qN8x4o//npz3+R1UEaq6LIh0BCG
         hE+UiJvUe14c1LY39MaWNn0b0EKiaxXhsoA5GerX4dnXXKXMN4eKP1DoXEJcPwfTrVi8
         RFQ7LhCc1viLLw+Azet7F7wpbMKj9g4f9RtCQu6mt80N86GW7YKpizYxVeGhXeIjOUFu
         NBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cb7DP4xQRrR7eaEbn0nK2nl/RVqJ7P0xuMj6assZJek=;
        b=ZddFJUPny/aVwaEfNkAmITqDVgsGv6ByTbjIwzF/NWBT0zS1HKcQBzcXrLOz9enQD7
         e4MU2iAKn1pcfEcCT3fSizSMlihNWYOOV9w+jgzsJEbX9WTc3ou1YoidZxNwoVnaOW/Y
         MKb5UtUt7cG2iDO8AMNpGO1mt/8ukNCaGTLnVRYHzC1ssuL0RD1DEpO9NfHATyDcsaLM
         oqRJGEGq0RFVnA2oBi3lJewSaqgQ67mZoZQE5v6/EgO467dDLiO2q776VJOOrluKDiwI
         Rt5vfaUxaOsMwtgdfImZBhScRIt6AjUQX6O4YdimA+hoiHtYE63vmaB/73dBV/aYWNux
         gApw==
X-Gm-Message-State: AOAM5338Q4C+kZMRcD7xq9N8QoXFO3KTdGNkrNy0AkZqdVIb8/OPp6QH
        J7H5qWHrCnHIVg14blJqI8PcbRy8I5o=
X-Google-Smtp-Source: ABdhPJyu5x+iWP19CiNhQXm3GIHUzijm71lS2NrxLaKYKseR9zAb0054+UU1XlOdD9NYHK6SloByPw==
X-Received: by 2002:a2e:7114:: with SMTP id m20mr7092240ljc.229.1639065833168;
        Thu, 09 Dec 2021 08:03:53 -0800 (PST)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl. [194.29.137.1])
        by smtp.gmail.com with ESMTPSA id x18sm16645ljd.110.2021.12.09.08.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 08:03:52 -0800 (PST)
Message-ID: <2697db33-753c-ead8-019f-5e2ef1773693@gmail.com>
Date:   Thu, 9 Dec 2021 17:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/1] arm64: dts: add minimal DTS for Microsoft Surface
 Duo 2
To:     Katherine Perez <kaperez@linux.microsoft.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
References: <20211208235137.2751003-1-kaperez@linux.microsoft.com>
 <20211208235137.2751003-2-kaperez@linux.microsoft.com>
From:   Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20211208235137.2751003-2-kaperez@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 09/12/2021 00:51, Katherine Perez wrote:
> This is a minimal devicetree for Microsoft Surface Duo 2 with SM8350
> Chipset
>
> Signed-off-by: Katherine Perez <kaperez@linux.microsoft.com>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
>
> Changes since v1:
> - Change remoteprocs firmware-naming scheme to qcom/sm8350/microsft/*
> - Add chassis-type
>
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../qcom/sm8350-microsoft-surface-duo2.dts    | 369 ++++++++++++++++++
>   2 files changed, 370 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
>
> --
> 2.31.1

[...]


> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (C) 2021, Microsoft Corporation
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>

This is now included in sm8350.dtsi


[...]

> +&usb_1 {
> +	dr_mode = "peripheral";
> +};
> +

Looks like you forgot to enable usb_1, but other than these two nits:


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

