Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E07E4EBC8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244222AbiC3ISx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiC3ISs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:18:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6C21256
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:17:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 5so34454367lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M32C2MHJpxfv0C/rKIvNbWiRzkrTOQet2nkeXJtQzo0=;
        b=t9OAHmAFXejxXd/ABsEtkYmuhHgDTwLbTCfevdiYo0MasX/W4Y46/gP0+rZeUkxmdC
         dS5ElpGzDz7LVOreWpTiEHK9fMNj2+oARBc8IRc/n8r1xslr+8TSuUawqnqc1DOPUm03
         CK5eaZoH4W3sQOh0oN1PWyYR/ZZtbOXDBeIPYSBW72I1QOb24D1JZy4ug/FeS9NwjPHu
         8ajhDwHgSH+fjKntg393D4uOBL3kLfbkYgjClBIqObYX+4gyEPW/uIQSgLhRJ39M+7m9
         tDdT1z/Rk7wDig/QVWl4ianWvWELewIYqOzzYLdfALAmTyJTX/cCnyhxsTGKDis3Z1t+
         iglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M32C2MHJpxfv0C/rKIvNbWiRzkrTOQet2nkeXJtQzo0=;
        b=OPXouci4WgwNT90sroV9iZKcJp/66gdkTw+iDl1axHMhosaNOzcOGLGpYBBa+gAr7m
         rGtY+fqQn9YyElMg5U5UqOeV0xtycIWsKYxY3x0dZV7IhpW53a3lGHXDiP4FnjIikFQ4
         iVG4Kq9p0lgo0R5Gp9nG46X2m1979n19QxckVLo/uw2WEWyiUtnl8ZZ67spukqpVFTJA
         +4mkEMrhDaSy+2JHO68S7ATdhXMOHvRdl6dB7yVNViBu0apeCDE4QAxTimlrE593RkK6
         pScbm3H8iHZzKQuuvIDtCN3FDCdMnt8lYItb7dmb9MdwuGbFSbK9sphkKbQewlGQscVC
         JUKg==
X-Gm-Message-State: AOAM531l+06TYVXqlOpYm9sjsPhiZkuDiIs5IdbeZldQhSR1gVJ50z+s
        6cvqwtKfRamSFy48XF97bCNxvsAs3TUOn0JL
X-Google-Smtp-Source: ABdhPJyTFIiM6MpxCMpjaTZ6/DzmmysJPS4k5E+NlHAafGVlbwGJmW82547Bn11svVa6TmJUro3aZw==
X-Received: by 2002:a17:906:a0ce:b0:6d1:cb30:3b3b with SMTP id bh14-20020a170906a0ce00b006d1cb303b3bmr38128430ejb.582.1648628207357;
        Wed, 30 Mar 2022 01:16:47 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m20-20020a056402431400b00419315cc3e2sm9619545edc.61.2022.03.30.01.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 01:16:46 -0700 (PDT)
Message-ID: <d75fa410-db8d-eeed-5ace-ac88dce81610@linaro.org>
Date:   Wed, 30 Mar 2022 10:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: uniphier: Add "resets"
 property as optional
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648617338-8600-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648617338-8600-3-git-send-email-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648617338-8600-3-git-send-email-hayashi.kunihiko@socionext.com>
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

On 30/03/2022 07:15, Kunihiko Hayashi wrote:
> UniPhier UART controller has a reset lines from system controller.
> Add "resets" property to fix the following warning.
> 
>   uniphier-ld11-global.dtb: serial@54006800: 'resets' does not match any of the regexes: 'pinctrl-[0-9]+'
>       From schema: Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/serial/socionext,uniphier-uart.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
