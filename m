Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3585F51B6C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbiEEDyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiEEDyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:54:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A14A93C;
        Wed,  4 May 2022 20:50:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d22so3241113plr.9;
        Wed, 04 May 2022 20:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+4u8FWl27VfHdqfIlbyjTh8gyGwlT371BcWanDHWfzg=;
        b=eVMlCGQpFdio62IA8ASAXoxSgo40hVH5mlz4vVCs9sZ1TFzgtyDx/ne3Eiy31U9vCQ
         700l4zXt+1sLgpUkGS3ig3Ro0EgmL0eJln/PShhFnr2Dw/sn11PT44kaVlDkDYh9u4hd
         N4pH8HFgTMz2ILNJcIGGaxrkjSxweIatbnHFQW1D3iFR0LkneC59jX0xlwbtTeMdcMqp
         auF8ySIam+wLLADOg+K5XONtfKhSByfFEEA2SO4VL3avrUy43CSHFvMs7sSGVkQ7V2OX
         f1ve84G6AZvQDFvVWH/yVkg35vI7pab0vAGdNomgR74zMT8wCuAD6Rfam+eD8JGM3jwm
         5o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+4u8FWl27VfHdqfIlbyjTh8gyGwlT371BcWanDHWfzg=;
        b=zHaFBGs8W23YPDzvumBfAWBDIrUUHgdR5LWmRt0Z5H2oqH54UiVhLeebjdEfd4LRjG
         /31J0U57ZbDKT970PDFvYoQqYYEaDeBm5SCIiyTAMC4V1Erf0sppnZMLm+u7X9xVKrC8
         bldipLdioNRc065jSackoqjXXaNEVr1wkqq+TqkAw60zkKeaoDeAQbKfPIpfBRIJ78SO
         m9OO5sqKEvCo4KoJqRkEiLGxjqbJfsrm2m9zaPGwD8iRM2MvM9Z2Y3Xk28VP8RGrNVX3
         Ra6EZFQyy1OWou/CMQnErmBoIY6qwOtSEONZHIJ7sJYE+Oilw1W93Qozg3nJ1rvpkXNP
         zi6Q==
X-Gm-Message-State: AOAM532pBKVnp9Txve1xkrvwevPDRv7qOqkm9ZaSA2HV59ZLRInoSFIJ
        keypBHd0qi2vqtUKweTyaEhQH7JoNW8=
X-Google-Smtp-Source: ABdhPJzDXGaIuN/D7gwGrbawKh7VbbPwGKt+VUjIoVCxdVj59/S+osHBuhAsg36BfNr3wzprEFqRaA==
X-Received: by 2002:a17:902:7109:b0:15c:e11e:efd with SMTP id a9-20020a170902710900b0015ce11e0efdmr25133723pll.110.1651722636638;
        Wed, 04 May 2022 20:50:36 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id 74-20020a62184d000000b0050dc76281f0sm169902pfy.202.2022.05.04.20.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 20:50:36 -0700 (PDT)
Message-ID: <0a7fd3d9-86bd-e030-7d00-c4f99644bb8b@gmail.com>
Date:   Wed, 4 May 2022 20:50:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] dt-bindings: gpio: pca95xx: add entry for pca6408
Content-Language: en-US
To:     Justin Chen <justinpopo6@gmail.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1651703357-25154-1-git-send-email-justinpopo6@gmail.com>
 <1651703357-25154-3-git-send-email-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1651703357-25154-3-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2022 3:29 PM, Justin Chen wrote:
> The NXP PCA5608 is the 8-bit version of PCA5616.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
