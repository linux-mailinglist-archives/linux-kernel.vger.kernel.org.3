Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2F4B8B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiBPOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:21:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiBPOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:21:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698BB265BC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:20:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v12so3775292wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fJttqD83JtcJ4lbDggnFlbM6cstaH6DYAd/AKXx3eLo=;
        b=S657ZCmwQ0Q6bSYlkDVeZ6mhrjpjDuakfGtu2AwZSz1wQ1biP8aSnn3FfncID+4RgR
         lOQzP6MJgXdZeuZVDlWh8IrFOXGas68VPXmwNWjQz4WZ1IkRU2svHateZ/1MsEIDycOt
         AfxKO+Ik0JxTT51Jaludyg4qTB3uV6Oi7bwagq9XO+CL//b2korJMnkdEQZwI7RG7gGG
         DpS9a03ijmmikXKp/nyr2O5lP0IuJ2N8bXv3rX6gpFCFBkAJgCL4vCcd/k+ns2vtb6GF
         /JIwNZmJwY7X5UA4OCuM9iaXltZPMMuOBtXd4UfWUcKWC+qXxwepAaRLUfmR078Vn5fu
         PH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fJttqD83JtcJ4lbDggnFlbM6cstaH6DYAd/AKXx3eLo=;
        b=OEfn+JGBG/ccjSr7gIw2dJJhWWKedqy0oEWxFomRRKxCiUR5EfitZo7IIPt51HJDo/
         s3i73n68wSeauYG0RK1XQ6SNaIuiCtxlNOCHBVlA0rDVzPJ7iTTh+u/lbnrDN1Is5hcn
         R0L3ZvFDx7oUO4Co3F8+0ttSPp6rt6nGr3wix/VrdSM9vRd+KqQxnmFZMQWnDbxKpQ9a
         41Uw80aTpHvFBu3mfNAAXC71Q0PfXyb0xaASXb4ab5FY5jSbZNsjpoEijy8G2IqY5YJ1
         ECi9wmPadIEvvo5Ypmiln2eLnY/Rfi6GQvHzGYPkhqKt+ev5hH+lXGkr30o19oYwg7Wi
         8NgQ==
X-Gm-Message-State: AOAM53198Uhks2N1+a3J0CLs3V4A7EBRj/7NLSi2AKHU+OTUryUbhMjj
        DGMhj6k0Anl7evvAxYmiGHxuEw==
X-Google-Smtp-Source: ABdhPJxm23Yuzt/CVqGgMXoOxwEXECgdCw4FnfkCJOiYKoi9WKeYemIFFyT21qzVKpv1dm1S/D9Ykg==
X-Received: by 2002:adf:d1cb:0:b0:1e8:57d1:8f50 with SMTP id b11-20020adfd1cb000000b001e857d18f50mr1656042wrd.21.1645021249045;
        Wed, 16 Feb 2022 06:20:49 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id e8sm20591211wru.37.2022.02.16.06.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 06:20:48 -0800 (PST)
Message-ID: <ba8a3cef-6df4-e482-8042-b9249143e284@linaro.org>
Date:   Wed, 16 Feb 2022 14:20:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 5/7] pinctrl: qcom: Extract chip specific LPASS LPI
 code
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-6-git-send-email-quic_srivasam@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1644851994-22732-6-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/2022 15:19, Srinivasa Rao Mandadapu wrote:
> Extract the chip specific SM8250 data from the LPASS LPI pinctrl driver
> to allow reusing the common code in the addition of subsequent
> platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>   drivers/pinctrl/qcom/Kconfig                    |   8 +
>   drivers/pinctrl/qcom/Makefile                   |   1 +
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 233 +-----------------------
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        |  86 +++++++++
>   drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c | 166 +++++++++++++++++
>   5 files changed, 266 insertions(+), 228 deletions(-)
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index ca6f68a..8871451 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -357,4 +357,12 @@ config PINCTRL_LPASS_LPI
>   	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>   	  (Low Power Island) found on the Qualcomm Technologies Inc SoCs.
>   
> +config PINCTRL_SM8250_LPASS_LPI
> +	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
> +	depends on PINCTRL_LPASS_LPI

shouldn't this be select instead of depends.


> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
> +	  (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
> +
>   endif

