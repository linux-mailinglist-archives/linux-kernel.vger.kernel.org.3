Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74E8552BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbiFUHT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbiFUHT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:19:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760871EEC2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:19:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z11so11931082edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dW7LTV+JrwgsWr7RJjBQKGVv8yoFjLp2uTqKjDi+Z6E=;
        b=E5/lCXMgjnzbURIeet6+LFqfxqP7CQSMw8O3BPWQLVsTHr4vnWBrKkhZ66SyaNHc+2
         sDzwCWK1/jo9JxealZ0bLVtiUpE33FwowmS3XyUO0jJdBBssoo3qPsZS/x/OtQmxoQrz
         KsGiSbqoUOJLReeB1cztMwfW/PJ2n48z1BHgLLnrNtz7/w5/vyJfaFkxTyoN+MwZZF5l
         IERnsazimEwoTFu/h0SxViWpl8B0pAhUyOR4TA0/Zqkk3m1PXAChWh+lvUxQFvQVl5JS
         jaE4Cyb1GV4A2m26Qkp/KcacoCEg4dJPPfg+wOR2jgaVdTc2F2i19ZTzjIUuneHccOO0
         gY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dW7LTV+JrwgsWr7RJjBQKGVv8yoFjLp2uTqKjDi+Z6E=;
        b=oVWbS4DRPShJAq2kW4sJ9wH0gNK/iV5+IAOrQ/WDp3nA3bFgzURVIggLsOVzWpBHZ1
         kT6NnKHTGr+rKQT6i3+NLKXuWafdTnitiWQVq4GciuN712rgi7610jSE87jJInRkpCP3
         ObW2QwuNibL8R6Fl38pwvwVvZ/XOYsvuynzwEQqzZzsbl0f37mvUBZPVmtcYl9TrGnKZ
         IezJYTlxVH1wrRy2G85x1XkmbDydI61WpQ1p0Ui6uiDm9r+tkp5zMVP3TC4rX3ZRTmRn
         Ntik27RFDVZJa4dXqfXCRibv6Sr44MLy1E64FOwc/nmrNUOfV/9kBAcrFTMwBdEZOI5I
         +1lA==
X-Gm-Message-State: AJIora+NgIT0kJKp990GXvoBlEwbonNSRV7cU1Ad4lrAoC4XmfpRtZQj
        klUB8XYKqVQUQN/jQB60oslS7zZ7Pxre2g==
X-Google-Smtp-Source: AGRyM1u5HZfRPrxD6ieLvj09AlW5VTW96uHA1rkvTbZ/MXswFeS4rivnv5KhNl454I/Wx98aQgZcSQ==
X-Received: by 2002:a05:6402:520a:b0:435:965f:e266 with SMTP id s10-20020a056402520a00b00435965fe266mr1967106edd.409.1655795994107;
        Tue, 21 Jun 2022 00:19:54 -0700 (PDT)
Received: from [192.168.0.216] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p24-20020a170907911800b00709343c0017sm7115247ejq.98.2022.06.21.00.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:19:53 -0700 (PDT)
Message-ID: <3ac4c6f1-0655-b26d-5b89-c492f609a8bc@linaro.org>
Date:   Tue, 21 Jun 2022 09:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/3] dt-bindings: mfd: atmel,flexcom: Add new
 compatible string for lan966x
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        Claudiu.Beznea@microchip.com, krzysztof.kozlowski+dt@linaro.org
Cc:     UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220620144634.25464-1-kavyasree.kotagiri@microchip.com>
 <20220620144634.25464-3-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620144634.25464-3-kavyasree.kotagiri@microchip.com>
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

On 20/06/2022 16:46, Kavyasree Kotagiri wrote:
> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
> in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
> functions being configured.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
