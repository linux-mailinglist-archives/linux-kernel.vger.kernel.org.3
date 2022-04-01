Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0374EEE67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbiDANqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiDANq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:46:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07619C5A1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:44:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i16so5891508ejk.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dXg0BEPoxux+zW0v1jfz5+2BtoCnLEGuBTvWBm9Wyb8=;
        b=gMQkHynZ9sEfJqF3clbblelIVMJmE4P2GB9CnUpmZVa+05XLiBeyYyG4m4Ke+7TEKj
         T6tbD0DkZ9M6vNnSoFXGkwTLf66XUlGNjhfT7HTVktWhQ/rxt+oimLhRbxCgIXNaPjZZ
         w9wA9pr6XnNDAYzD7eROPoL2znvhkzesaYphAkAztT9dg8/TZONcwFloW/RYEQ0Nifs9
         A7Q9hogCHgGoMeXJuCM3gDHSKibzYq6Ii+eoKQmYrRoMIN0lVFIXJYHVMhUc9p7YMblT
         XZwpryUSoQ+WHTB4cubOHbDqb29eC3RfWMP//dHhCtPKpp4JUO/pvRQqpNwQBrRE2Io5
         dMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dXg0BEPoxux+zW0v1jfz5+2BtoCnLEGuBTvWBm9Wyb8=;
        b=ms50NsTGj61UhvlRmFGxHarAYkKElrXChvZWaj+ThCN1TFYg3NbrxaAJm5dOEQ3gV3
         JBNuDRXYsl0pfBCFi7Yq0/nEdgf+YRUeXB7YHBRGhou5YKcVO6dyUHZNQ8q1Mj7X74mi
         HlcWiQ+fMHgqi+0mvaNjE6SazidA482KhPgmiFoKms9YAr8y0qpKL17+kZFLgaP/FBYl
         QXEiKvsQkCA6NH6KkLZc7DNIg2PCcw3Z70VM+RuocQDO4GH25oFnlXOEgteORRQdCmQP
         vXuu6ub3D/EzqVxol0qIJ3DBUTKFjhc///QsWLsRbsFnI4Q8b2YNBnh9tFsVZu1zC5rB
         rsLg==
X-Gm-Message-State: AOAM533T1PDpn3MkOwWS1S+gmn7TOi17Zxrl92gQ1OBkfBNXE2jSHo9d
        1JdogGpUaBQHReab/qfuWWe/7Q==
X-Google-Smtp-Source: ABdhPJwihxSeskTAiciGW/SRE57is3wc8uCqoR1NFACh7coD/3vgO5wXAcx2Wk0MvUyPduOGFoVYFA==
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id t1-20020a1709061be100b006ceb0a8017dmr9336353ejg.413.1648820677476;
        Fri, 01 Apr 2022 06:44:37 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x4-20020a170906b08400b006e493cb583esm1054581ejy.47.2022.04.01.06.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 06:44:37 -0700 (PDT)
Message-ID: <39d74fa6-275b-b2bf-c5ed-7bc3a91e7fba@linaro.org>
Date:   Fri, 1 Apr 2022 15:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/4] dt-bindings: display: ssd1307fb: Add entry for SINO
 WEALTH SH1106
Content-Language: en-US
To:     Chen-Yu Tsai <wens@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220330190846.13997-1-wens@kernel.org>
 <20220330190846.13997-3-wens@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330190846.13997-3-wens@kernel.org>
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

On 30/03/2022 21:08, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The SINO WEALTH SH1106 is an OLED display driver that is somewhat
> compatible with the SSD1306. It supports a slightly wider display,
> at 132 instead of 128 pixels. The basic commands are the same, but
> the SH1106 doesn't support the horizontal or vertical address modes.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> index 9baafd0c42dd..1ac016a2d847 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -13,6 +13,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - sinowealth,sh1106-i2c
>        - solomon,ssd1305fb-i2c
>        - solomon,ssd1306fb-i2c
>        - solomon,ssd1307fb-i2c

Please update the allOf:if: blocks.

Best regards,
Krzysztof
