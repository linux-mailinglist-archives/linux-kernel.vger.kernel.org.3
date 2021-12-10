Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C85470B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbhLJUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhLJUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:08:39 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4724C061353;
        Fri, 10 Dec 2021 12:05:02 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id k37so20067651lfv.3;
        Fri, 10 Dec 2021 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PPdSF2QMOft+QFWfpwCc8hMuziiHZKkOL3Ccc/u1Yq4=;
        b=TnD/M0jrYjBYZR/cUFHXxbwxlU+/PIMtroJCua+lrY9OrIdYIqjV5BPFP3SLM3zzcZ
         1DnXbV2SOMjQMEUrqp9R4D0Y9MoYEnLKnwbOozhctcenmG7ewdwB6YLcML6qx/S0Ou/P
         G3YbFiGq7W5VZhabWPZain3h95BJAy3wRN106xW84M2afQN8Hiz/zEkqJ3QLHSp50Sfv
         wZPpNQg2298oV9pNscstGZW+ekVp0FiyE3qQ7FOUfRlfpe08mmV4gsEnsurzYuX7OgPj
         pKFrP4LmhO2jAOWbgacS7m066YahvmFxmyPS76Y9ZU+0/rsLloEs73Yzzg2/uLej9Nsm
         rzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PPdSF2QMOft+QFWfpwCc8hMuziiHZKkOL3Ccc/u1Yq4=;
        b=K56Hy3FQO1Ug3j8ngrd2rmyzYsVadT6g87C0azs8HwXetGRR6DCbQk/ogKJ32Cc5XH
         EzPnbmAHOSXaxBhFL4tFPbVHFaja+y8XxsmD/7ldbjea8RQVsCVlutj7RTXAq+JXIfyZ
         hKbkrDuQlid/JFV8EdBo4Oe8/xUbqnXs7+1JRSFrmqYyGlrhXm43WUz4V3AKc+X9Ceo2
         pAYk0vbF3a6WChpU+60rv3u/cZN4mb9Ej9ABD/lw1k1O2k4j4VBM1XozlfEW4qadgxDH
         SY/8yI8nnZBdC8B+2MBVvkbKI2arMBm9bE0B/W5OMrnsVi7vSyDPHWGMgDRGo3ybnf5M
         otrw==
X-Gm-Message-State: AOAM533eie/8IMKgY3+3/ETpRED6Phdl7PQd/8oE/aG3OSuYD9H6CkE+
        bwKK4TWiyoYCOgz+AfEDFCPhQmxp+DA=
X-Google-Smtp-Source: ABdhPJxJtTkGd/Qrxy1Dx6MrJAsO56GYapsKLbyzU9fgFkoPuJLMfqgULwOmp/axXE3DYiamqFzSKw==
X-Received: by 2002:a05:6512:1304:: with SMTP id x4mr14727278lfu.484.1639166700738;
        Fri, 10 Dec 2021 12:05:00 -0800 (PST)
Received: from ?IPV6:2001:14ba:16ee:fa00::4? ([2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id w6sm401405lfn.169.2021.12.10.12.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 12:05:00 -0800 (PST)
Message-ID: <29c8eeeb-2dee-6182-a2d3-90821cda975a@gmail.com>
Date:   Fri, 10 Dec 2021 22:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
Content-Language: en-US
To:     reinhold.mueller@emtrion.com, robh+dt@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, inux-arm-kernel@lists.infradead.org
References: <20211209120934.4815-1-reinhold.mueller@emtrion.com>
 <20211209120934.4815-3-reinhold.mueller@emtrion.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20211209120934.4815-3-reinhold.mueller@emtrion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho Reinhold,


On 12/9/21 14:09, reinhold.mueller@emtrion.com wrote:
> From: Reinhold Mueller <reinhold.mueller@emtrion.com>
> 
> This patch adds support for the emtrion GmbH emCON-MX8M Mini modules.
> They are available with NXP i.MX 8M Mini equipped with 2 or 4 GB Memory.
> 
> The devicetree imx8mm-emcon.dtsi is the common part providing all
> module components and the basic support for the SoC. The support for the
> avari baseboard in the developer-kit configuration is provided by the
> emcon-avari dts files.
> 
> Signed-off-by: Reinhold Mueller <reinhold.mueller@emtrion.com>
> ---
>   arch/arm64/boot/dts/freescale/Makefile        |   3 +-
>   .../boot/dts/freescale/imx8mm-emcon-avari.dts |  23 +
>   .../dts/freescale/imx8mm-emcon-avari.dtsi     | 141 ++++
>   .../boot/dts/freescale/imx8mm-emcon.dtsi      | 645 ++++++++++++++++++
>   4 files changed, 811 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
> 

> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	bd71847:pmic@4b {
> +		compatible = "rohm,bd71847";
> +		reg = <0x4b>;
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <2 GPIO_ACTIVE_LOW>;

I assume this should be IRQ_TYPE_LEVEL_LOW

Best Regards
	-- Matti Vaittinen
