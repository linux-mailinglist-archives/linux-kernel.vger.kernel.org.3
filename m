Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A10560141
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiF2N23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiF2N21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:28:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD11902D;
        Wed, 29 Jun 2022 06:28:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jb13so14109743plb.9;
        Wed, 29 Jun 2022 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j7eMblZ/umfNsu6amY7Gfrgh8aKRk8TXNeQEA2osXGM=;
        b=qB+LK4bUP2pVrDcZnUOgL3pm7iIsQWJH0BWoAjH2r5nHj7VZCSi9STgZg2acwbSQQZ
         KV99vdnkERyU02Vg/HEE2q5SZiMrSIVunb3aru/NmvExPwWernWgdgvu3pDtFPDd5KgY
         syyaZzc7ceMLGP4jv9+g2sZfRBV0Kef0Bdh6fVCSFKGjbutJ5jUJKPTwz1GaThitudGL
         SK3J7+JgRO/k4n6zRM1Cor9d9h2Babyn0oL9qdGRAX+g/SCzvNRPcBfFVfgib1qvBMqY
         u4GFSBOtHXIIHjRF37at7ehOWROgxMEWyfCiij3eUx6KoyPuhu7He2h6u2V9b9ovHERr
         lajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j7eMblZ/umfNsu6amY7Gfrgh8aKRk8TXNeQEA2osXGM=;
        b=ZzSIiYZuEzuVuCzE4vjjnanE2ARwMQFbuv68OrBAXArVB0Ptq9m5Rq06Q61TW82DFy
         H9SSl3gIEhfqf2KV0aqyZTSaScbSFENfvSrLs6OJf8znD0L6v4nVza4j4S9keOLduPog
         4PXa/7lFPuZOUb1k1Kj0SNhOFGjXSyrW9U4Xs5GRvm/kZ9wXpkZkMcYihg0PVzxkuQ/M
         yn6ErH5ybhtD7MCb4KEoqG2/tdoL7JcMN1gOVGEXDstbrNLG+ItKHwtwtLV3uFdu/EF5
         rcQt/oQMlP7Fmshe2lzfEwWvUtXcVPQpg7pozbAeJO8rgzsYaJnrdHiN6rN74Z6P+vB/
         N2LA==
X-Gm-Message-State: AJIora9eKL6AvvfmePpuu0Rxdx9ZXFOHGIEEoGSKZ3u9uNmaiJYd2SW7
        4Df6DPo6N6otjabm0bTzhnNs7EoN5TE=
X-Google-Smtp-Source: AGRyM1uRW3TiEavmuScTeedq6x/Emvmj08CLZePmHPOHDet4jJYb3gDk7lKGD8lz403QJaBip4nOEg==
X-Received: by 2002:a17:90b:4c4e:b0:1ec:bc42:47c2 with SMTP id np14-20020a17090b4c4e00b001ecbc4247c2mr5640272pjb.180.1656509305035;
        Wed, 29 Jun 2022 06:28:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bd7-20020a056a00278700b0052090076426sm11785914pfb.19.2022.06.29.06.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:28:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <072325f3-dab4-6b50-3959-bddc6330732f@roeck-us.net>
Date:   Wed, 29 Jun 2022 06:28:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: realtek,otto-wdt: add RTL9310
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <84d873d7dd375cd2392f89fa6bd9e0fe5dda4e1c.1656356377.git.sander@svanheule.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <84d873d7dd375cd2392f89fa6bd9e0fe5dda4e1c.1656356377.git.sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 12:00, Sander Vanheule wrote:
> Add the realtek,rtl9310-wdt compatible to the Realtek Otto watchdog
> binding.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> index 11b220a5e0f6..099245fe7b10 100644
> --- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> @@ -29,6 +29,7 @@ properties:
>         - realtek,rtl8380-wdt
>         - realtek,rtl8390-wdt
>         - realtek,rtl9300-wdt
> +      - realtek,rtl9310-wdt
>   
>     reg:
>       maxItems: 1

