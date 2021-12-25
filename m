Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A447F41F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhLYRkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:40:07 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961AC061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 09:40:07 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id v7-20020a4a2447000000b002daf9b0cb1eso2091787oov.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WfzhWj1jtwCdxEak/D97aNhkHTpQCqGgLyMJk8IXEwI=;
        b=eaAoE4ztF41KiZpnzSfaK9/FXh47Z15i/58PZS//afGbMpjYyS2woT9xWMHQvEJeZ4
         bK8MppOg/i4qnbJie6j7sWtJ7DGauG30E0V7rDy8BmdJfBeXDMbumgI1fm5bCHxI5XYO
         tfIwqEzLG9RVVBP1WWMq9TPuMm/Jt/K8xlFZWn+NsPSk1g/FSE1p1+6V1IqOEvPLuKOI
         wA+qcKwIBZm3rCsf3L/ZPj7+DYd5gRbXWH5uWOaJxZjOipCEBBLqJZCfP7Q50xm9mBTN
         2RAfJHyd4eH4p5j189+F/LnRv4qAFKuBdN/Wk9PN/nUF0W6qBU4wZW0u/m5Fy5qDyOX7
         F5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WfzhWj1jtwCdxEak/D97aNhkHTpQCqGgLyMJk8IXEwI=;
        b=Ss5vJseKrsTcr4efy0FwtF/Ee6EGhdHPZGrSQCsvi6fCRdgwV8K4WMc1X3s8oLVG7d
         DTkbqNPxN8nSEsqf9dr7BenxNF7KXb3fA/SDyVii7KHegeyLFM/qUFTvQR6fWmH5zj2T
         0N2NklIwLEtnPn1iYR5QWoZwRzyWJjTZBMEjOtcoup/Tc2nsbT99a8FRDxZqIo76epU1
         oV9cVkpm67pZzn4+FwyEOKUhDcRp2ez0WAr9tI3hQ378Nwg1nv1updOwUd1NK3TsHxjq
         ZBq+Wq+bHLdm8UPYWPV+HMAt4oPH3hhnx0vby7Rsc4ujPi+HPdbkR3wtslVg+0R4a2dc
         XEmw==
X-Gm-Message-State: AOAM532NPYE1JyPnJ3VnSt5LQrTFfJnc46z2FskP8WVEQCtrFn0psXdW
        /tRdK2PjlojvnMzrJBCzeEISMg==
X-Google-Smtp-Source: ABdhPJwTd64h6NmnuJkKrnhyJ8AydZv/uOcsiocQB/wkmdKbXj9YXiW8i6BntXb/sn4Bbg1VBBPEpA==
X-Received: by 2002:a4a:9612:: with SMTP id q18mr7025002ooi.36.1640454006594;
        Sat, 25 Dec 2021 09:40:06 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id v20sm2018193otj.27.2021.12.25.09.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Dec 2021 09:40:06 -0800 (PST)
Message-ID: <85cc3f89-6e87-6fc7-311e-d410833d75da@kali.org>
Date:   Sat, 25 Dec 2021 11:40:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/24/21 10:13 AM, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi,
>
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 7040293c2ee8..0f29a08b4c09 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1526,13 +1526,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>   	if (IS_ERR(ctrl->base))
>   		return PTR_ERR(ctrl->base);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "no slimbus IRQ resource\n");
> -		return -ENODEV;
> -	}
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
>   
> -	ret = devm_request_irq(dev, res->start, qcom_slim_ngd_interrupt,
> +	ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
>   			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
>   	if (ret) {
>   		dev_err(&pdev->dev, "request IRQ failed\n");

Tested on Lenovo Yoga C630

Tested-By: Steev Klimaszewski <steev@kali.org>

