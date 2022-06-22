Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01A2554CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358138AbiFVOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358078AbiFVOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:18:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052622E08D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:18:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ej4so20177641edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QpQTfmUdTKRwCxGO0jA6r2xEp5W5muPwnPlhJzJ0An0=;
        b=dWh7HnH44d6vuZ9fE3bmvUBY+wqWvGgEldwna09o9kMdOqXGZR7QTIOXWzbrJHdF1v
         PWWrDEImTU83EjU1LWrVrGUNUOubeN6hWfl9Ek6ajCRD7JPySgbc6ZtuvjSmPhzn3D89
         Cx1jS3ylPu+HP4oANS+zl96/xRdCQYNvMOkGGdBULipg2i9Kw2XZO+UbAi/OyjcPAsdl
         exUaY7vlwEiWaOV9k39YAx2Kx5uov/wuAHFtshWPXcn8rKOskc9640JMYt8fO7+SJCUZ
         4xdjCciJQfh5YUCCCOZHXCZAEDrkv4khuhjMIT5HyU8tSQImE6wmTPthrBMqEHXT5wIk
         dyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QpQTfmUdTKRwCxGO0jA6r2xEp5W5muPwnPlhJzJ0An0=;
        b=ojEDu1+EQQ1+0axZL9Vmc3f1GhrmMAHupd+bSx6ezt0bVpRLi+3jVZ5v6xHYB0IqI2
         C+rha1us2Stl0HFAN/364ZJSA8Oh3acBsZSUrlGdXRShwDZBkfyR5BYW75LB4ClT3k5c
         wUrcgOmTpQgQOSyinR5ZrFwiRJRK2kt8wjZGUe0rAQrt1qZQq7eECAxPl4UNcAFrnaj2
         UV+qJAVCWncZ0aukrbUjqNZ857URqHpyeWSPBQ/trohHbj42pUalr3sIhOJzOBJ6sxEf
         D9CMUhVTioRks16tcN2Dpfej81rDDUgAhEBgU0ciHKY3Y/mz3zuDhV0vsb7ZykN+kOEZ
         48Cw==
X-Gm-Message-State: AJIora/b1L9Q9zFIA6+76AnqPrphsV3LB601bBNd9puXYA31ESMTaiLU
        njpMiQa9Res23E6pGUptig3jYQ==
X-Google-Smtp-Source: AGRyM1tST5OqWHL1DDARx8o3mZQ7lpDnQqQ2k2nLeZV0MIDXdudnJDntwx5CLU+YY2PCyKCdurKKAQ==
X-Received: by 2002:a05:6402:1f0a:b0:435:6e0a:7aba with SMTP id b10-20020a0564021f0a00b004356e0a7abamr4513357edb.318.1655907485535;
        Wed, 22 Jun 2022 07:18:05 -0700 (PDT)
Received: from [192.168.0.225] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id nb36-20020a1709071ca400b0070beb9401d9sm9615013ejc.171.2022.06.22.07.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:18:05 -0700 (PDT)
Message-ID: <2fd94a25-0d0e-98d2-a06e-b0439f4d31be@linaro.org>
Date:   Wed, 22 Jun 2022 16:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s
 devicetree
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YrMVqifgV4kZaP7F@hovoldconsulting.com>
 <20220622132617.24604-1-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622132617.24604-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 15:26, Johan Hovold wrote:
> Add an initial devicetree for the Lenovo Thinkpad X13s with support for
> USB, backlight, keyboard, touchpad, touchscreen (to be verified), PMICs
> and remoteprocs.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Changes since v2
>  - Amend commit message
>  - Drop unused include files (depends on updating sc8280xp-pmics.dtsi)
>  - Rename fixed-regulator nodes
>  - Shorten two comments
>  - Drop a couple of newline separators in the pinctrl nodes
> 
> Changs since v1:
>  - New patch
> 

For the v3:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
