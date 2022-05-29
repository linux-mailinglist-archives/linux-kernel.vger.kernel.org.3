Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9EE5370D0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiE2Lib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiE2Li3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:38:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359553701
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:38:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v25so2257336eda.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eJTObeltLTBke/yOsO+fw5Eu7yLqlG9N158kbA/XPFA=;
        b=KI/Xu+UnDUGqeIW4t0YA4dSjfimVBTmDX80fvWX7X7adLUUmejqIjqTUZw8AqCTTCv
         1IJpODOkOLy0yeQLRnC7EV3nUL4oVei+prlE3NjY5KYdz3rh2nCB4x7n8Rs6VHGebt/V
         vbcvt8s4P678Tc0BAb/LTbi8C2+46hyK1UE6KZCwSrV2uFdICDtnZ26CAO+Y10Yi2AZH
         ceWAYcM6CbtTi+ZLvI3ZCM1ALkty1i4vhPVgtScii8w4YEo0xuZ/ps/6X9Igi0WvctsE
         HERnRxXz2/gJ3s2EUGTuyXuaMXhTFNbK2E6zkAKcMdZ0KS5qwxFum2FHpLrythUGotWh
         qv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eJTObeltLTBke/yOsO+fw5Eu7yLqlG9N158kbA/XPFA=;
        b=EgQz6gvfgKpJIM1pR9M3NW70HxP5RIPluACwBlitKW5RtVQ62oHx9MrTbxL41pXdIK
         Rmehm0lYAJ/8/UVq4FIS4IxNGf8IbVx7DwYQai0gFZ20X/8LWZqR7yKsYQK/UGu4XDu9
         9AVtON4KR4pNHMWxF3WSCiL+Upm/ASzJuk3+kEdNAKAOxz3bX4WF2hlS7qEsffaqtiDw
         rl7bdKqcqS0SFmbAyJlEn+bzBaVnGkVtDwuC4dftSyZ6AhNCzv7koA+CQDiQFAYg7An1
         8K7BEBnX4foCpUZVuBapxfOCdCGK/39Pexnb48oOA5wabLESn6hv7RYGmqXMB57fV2A+
         0SGQ==
X-Gm-Message-State: AOAM532/I9v3hwNmBixlnTgGjmZOM7GMFaDLWX/rc39aP3LizmzFqIDm
        NuUH/ShYVfRVJCNaE2gCYEFjGw==
X-Google-Smtp-Source: ABdhPJyfA/N9yfHVdBjobc7O3sdD7DxjsnQ+Q3rOVxI1CdL5M4flYPNCOvqcxHcqjp6diWXcgR7JKQ==
X-Received: by 2002:a05:6402:378b:b0:42a:ad8c:628f with SMTP id et11-20020a056402378b00b0042aad8c628fmr52702053edb.90.1653824306455;
        Sun, 29 May 2022 04:38:26 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906368900b006febca5a604sm3054184ejc.58.2022.05.29.04.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 04:38:26 -0700 (PDT)
Message-ID: <9bb791f8-a9d6-bc5d-d2e3-6776566ed5a7@linaro.org>
Date:   Sun, 29 May 2022 13:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/3] misc: uwb: Maintainers list for Nxp Uwb SR1XX SOCs
 family drivers
Content-Language: en-US
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com
References: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com>
 <20220527184351.3829543-3-manjunatha.venkatesh@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220527184351.3829543-3-manjunatha.venkatesh@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 20:43, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).
> 
> Message-ID: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>

Same comment.

> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41c9c8f2b96d..3d64aa8bac0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14306,6 +14306,12 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
>  F:	drivers/nfc/nxp-nci
>  
> +NXP-SR1XX UWB DRIVER
> +M:	Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> +F:	drivers/misc/nxp-sr1xx.c
> +

Squash it with driver change. No need for separate commit.


Best regards,
Krzysztof
