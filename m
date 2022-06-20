Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2895D5518F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbiFTMcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbiFTMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:32:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07165E08F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:32:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so20766105ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7YmAtGuUNzr3gUuWPc4KOL752YfmuI3qBOWH+yd3+h4=;
        b=EdLy5fr5XGxx/vVcT9Ub07TMY29cEaIzuTeee7orZoxugcQhL+oVPwN4wMMA7rBVgn
         /7yynxstyPpM1V9Ys56bcDhJbPddSxRIXBdC3/CX/qMhk3qmJmvhW975A7ifL6IBbZf0
         6xfhkFZpSdlWxJeKHyTT8XATMgrqA5f4n1Bnx7z6DLSmKyQugO0XM8s3YH5k3uCe+bH5
         pumdCpJNJt8ciAycv0oz/ZnfHDGTZLgYuV4kFvUex89gCqEmDaAYUbT2f5xhi9oLTUaV
         8+U/j1Xc5SNq+TUxkwO5VxJ7bEOg11qiGFUGK4xpeGNOP+9WrfnXUOCavwGW8VXDfCZU
         wkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7YmAtGuUNzr3gUuWPc4KOL752YfmuI3qBOWH+yd3+h4=;
        b=J5ZKwAfD4Y5Me+TS/lso0FUfktG85sFlxcuE/4IcispTNnEWP4EXt9vVBQ1AaTjzBc
         s/WVdY9QaczbL6uvbnnPPbtnf65MjQPAzgIPuvkBUxUGix8PZ+N/XTdFFTUDum26agYE
         hYBI8H8ySCSllmKipZLzc6DT1/gmB4N2/nLEveTzxd9lwVoqlNIcIllTRmAm+QBmOhUu
         MkrnWwXo79w3o8SdN0b/nVrMWwKKgmafBTgo2HMslv+8g4ljP7c8Oc458ERZjm8hTiEa
         DMbIcxIOIhHg9IyVcI7Hxdy8lnQ5LIASluIviojhqzs6HKDxv1wrirLpxqfIGNEyfONq
         0Z4w==
X-Gm-Message-State: AJIora92RuCBcSOom6wayoYVgfMF57V52vxmBpvOaJ4arUanNHEHNork
        LnghI5kzfYp4RmsIdAlSHIR18w==
X-Google-Smtp-Source: AGRyM1tYfe/5BEzRAUIPHntlRJzpoZstl5iSVvRMrTdqa/N6fL2lTjOUrfsUX3SJbLvtR9lARKYlrw==
X-Received: by 2002:a17:907:6295:b0:703:92b8:e113 with SMTP id nd21-20020a170907629500b0070392b8e113mr21027834ejc.594.1655728334584;
        Mon, 20 Jun 2022 05:32:14 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061b1a00b0070c4abe4706sm5811842ejg.158.2022.06.20.05.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 05:32:13 -0700 (PDT)
Message-ID: <2c753258-b68e-b2ad-c4cc-f0a437769bc2@linaro.org>
Date:   Mon, 20 Jun 2022 14:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: net: broadcom-bluetooth: Add CYW55572 DT
 binding
Content-Language: en-US
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <cover.1655723462.git.hakan.jansson@infineon.com>
 <acd9e85b1ba82875e83ca68ae2aa62d828bfdfa3.1655723462.git.hakan.jansson@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <acd9e85b1ba82875e83ca68ae2aa62d828bfdfa3.1655723462.git.hakan.jansson@infineon.com>
Content-Type: text/plain; charset=UTF-8
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

On 20/06/2022 14:01, Hakan Jansson wrote:
> CYW55572 is a Wi-Fi + Bluetooth combo device from Infineon.
> Extend the binding with its DT compatible.
> 
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> index df59575840fe..71fe9b17f8f1 100644
> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> @@ -24,6 +24,7 @@ properties:
>        - brcm,bcm43540-bt
>        - brcm,bcm4335a0
>        - brcm,bcm4349-bt
> +      - infineon,cyw55572-bt

Patch is okay, but just to be sure - is it entirely different device
from Infineon or some variant of Broadcom block? Are all existing
properties applicable to it as well?


Best regards,
Krzysztof
