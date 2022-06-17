Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900F054F5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381930AbiFQKle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381609AbiFQKlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:41:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B56B006;
        Fri, 17 Jun 2022 03:41:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn20so5649999edb.6;
        Fri, 17 Jun 2022 03:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=hkp4uK11/4OrCEaz4XjJ83xXpjDH+S9v2Ae5rIMepB0=;
        b=IbJe/gK1k4fHKqOVKnPxE8nZTqSlRC79Yfe71BoqEPgwqA4lei8xO41woON7CzD3jo
         2U2gcLr3zjHGaPsCwuJeZUUs671h5K3x6RoqOi7jjpfEVh5zlcEy+Fr2WSN6NMXmRH2t
         GkV3OUxyd7JyF2fB/GawNHu3nhLnsOqzGJunDcCm26ikQZUo5XhCqdhCchzplyH1JTqB
         q0Jcmikt/70zFb14mBWo9xodn0RawKh3/TdzJIRzlqmHJumGwPLvJnBvMJsrjXQW7jGL
         bgwriH9nisl8rcT5K0ycBDvIyBOTEyKncSFsT3P4qkfk35OnFERacVtv3w+P0HnLZTa+
         z4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hkp4uK11/4OrCEaz4XjJ83xXpjDH+S9v2Ae5rIMepB0=;
        b=WanFQuKs/7UkwRzGz3V/+0+XI/AgVSKDVGQ+9TsLRmt0A6IGu+np9mAeY06cc9Tt/Z
         MauGEzvWkD0R3yRv1RQ8n1qF5y7BJhm52iykKcPaw4tcZKBZPK/tmUamwNjr3byozANU
         Wu4qLC4rikSV9oRmsusJ6EWIbOLZM2f5b6tW+7nE0WYKd0SWX5Cc8vr/6y1W/53/vtXb
         37y1opXmGIt1LIggmakRjewUCTGQWG6M3eOemrQlzOCNEapND/0dh7gstjIaWvAFaSZP
         mqXPgrKii8wI8z4BJcxBQfz/G4VJDlQ4KmUhUwe73pRyX3gqa6Bo7LedhTspGm1Q2Tfp
         P9Ig==
X-Gm-Message-State: AJIora+2HGDNMKk/v6nv+UbA2CgAA+VeOHqN/dZwHgZy0u6tdBcRA37j
        LZfHHlc5gsd1Inj9VqH+FIg=
X-Google-Smtp-Source: AGRyM1upqkFvOJmB/mMBOlwf8qUMZi3Mn3x6lcJ0th8pgh5jhc5LwNGxznaYkOW3GVsCG4Z5WAv9Fg==
X-Received: by 2002:a05:6402:2682:b0:42e:1c85:7ddc with SMTP id w2-20020a056402268200b0042e1c857ddcmr11367546edd.143.1655462489240;
        Fri, 17 Jun 2022 03:41:29 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id b14-20020a056402084e00b0043565c79879sm467500edz.43.2022.06.17.03.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:41:28 -0700 (PDT)
Message-ID: <fcc5f00b-0776-9511-845a-5eac5d4c7876@gmail.com>
Date:   Fri, 17 Jun 2022 12:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 17/40] arm64: dts: mediatek: mt7622-rfb1: correct
 gpio-keys properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-17-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616005333.18491-17-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2022 02:53, Krzysztof Kozlowski wrote:
> gpio-keys children do not use unit addresses.
> 

Is it me or doesn't the commit message match the actual commit? Change looks 
good, but message puzzles me.

Regards,
Matthias

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> index c28da9323a9c..1a86857c9027 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> @@ -40,7 +40,6 @@ cpu@1 {
>   
>   	gpio-keys {
>   		compatible = "gpio-keys";
> -		poll-interval = <100>;
>   
>   		key-factory {
>   			label = "factory";
