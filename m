Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB4506708
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350081AbiDSIh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiDSIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:37:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF3EB7F6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:35:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so31352244ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3HxOdB4UCU69kWJbd9Px2wpk4tEVpj0zQBmF6/zE6v8=;
        b=qG628Os+yu7718NWewcI9Ahj6X16ZZowlghnUuG6tAkbap53O2gQg82ae/gGmvlC6U
         6Nr06BJhawXcDUh2rSfaF12pl1+x1AAaS7IRp+oSz/ohnpvpeJ4ZvtG/BWl8ZUSnVXH3
         rmAJOCqcTQu6BHlM+po5YkzdIvTug2mF1V7PSt6XlmZrXRyL19k+T891bAUikRamcPiV
         m0HRaXYI7HStgUR1AxU29IzCoSGGzrxX4oXJGoqwNyrUGJKuqn9Fvf1j0+Z9Nj29eROS
         FYugZH3hL8blmSGW4O4gcVIm1d1+A2tmK+BFXgxkKAFdWCxX2x2zg4LuXisxVb9appf2
         cM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3HxOdB4UCU69kWJbd9Px2wpk4tEVpj0zQBmF6/zE6v8=;
        b=MZyxcgfyEfsse+OVy8rsyz+M2PtEpka86FWI/vaq3cxq47JoRQnq/cKbtXtsccfwQI
         3Y7gOPU5HcDwYoDTnFJPVVCRzGf9KtPqf0R0yU1xVg1aXUojpJhqgeH6+PDbsnDYT+Ya
         t75WrZh1Z7Ny9cLBYS284iyH6ze+6z+b0REY5jrEE8wcjq/TtJWHAOxv7W3vvao+L/Vc
         b6Weml+DMnoluK6l6+wMfTFmU/EyzgkOMPwE/jZ3ecgvWl1ArkQf9AMzJ9/+MYl8n2g0
         Q+EApQ63epa7//lCiKDlodwQy3xdctRBdeXVfHuEyghx4qGqYov4fyCUOxf1ny1AwCQ8
         j9sw==
X-Gm-Message-State: AOAM533upfMpilTKKmrmDqi7fqjRPkMaIxz1CTzGuxovyn+j8AZ7ZOWG
        BhHCoQNrTqm7IxTsmPDYqee8DA==
X-Google-Smtp-Source: ABdhPJx3L49HVWZQ2DrT0icY5W4wYZZEXRaGyO0qeyomcColhxiKhhhJsoFRFYW7gUP4tHJcZQeEhg==
X-Received: by 2002:a17:906:65d5:b0:6ba:3133:dfb9 with SMTP id z21-20020a17090665d500b006ba3133dfb9mr12644194ejn.56.1650357310734;
        Tue, 19 Apr 2022 01:35:10 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906938f00b006e8afb5a7d9sm5368733ejx.33.2022.04.19.01.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 01:35:10 -0700 (PDT)
Message-ID: <0e569119-32e9-6549-d805-85f44fc5660e@linaro.org>
Date:   Tue, 19 Apr 2022 10:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] extcon: ptn5150: Add usb role class support
Content-Language: en-US
To:     Li Jun <jun.li@nxp.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
References: <1650354202-10445-1-git-send-email-jun.li@nxp.com>
 <1650354202-10445-2-git-send-email-jun.li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1650354202-10445-2-git-send-email-jun.li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 09:43, Li Jun wrote:
> Some usb controller drivers may not support extcon but use
> usb role class as it's the preferred approach, so to support
> usb dual role switch with usb role class, add usb role class
> consumer support.
> 
> Signed-off-by: Li Jun <jun.li@nxp.com>
> ---
> change for v2:
> - Add one patch to sync queue work before driver remove.
> - improve git commit log
> - use a variable of usb_role to set target role in
>   ptn5150_check_state() to simplify code.
> - use dev_err_probe for usb_role_switch_get() return value.
> 
>  drivers/extcon/Kconfig          |  1 +
>  drivers/extcon/extcon-ptn5150.c | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index c69d40ae5619..f3352a81ee7c 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -130,6 +130,7 @@ config EXTCON_PTN5150
>  	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
>  	depends on I2C && (GPIOLIB || COMPILE_TEST)
>  	select REGMAP_I2C
> +	select USB_ROLE_SWITCH

This is still being discussed. Rest looks good.

Best regards,
Krzysztof
